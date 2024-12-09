Return-Path: <linux-kernel+bounces-436690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A897C9E8971
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC0C1885BC5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6E42AA4;
	Mon,  9 Dec 2024 03:13:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DC94A02
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733713988; cv=none; b=tUc85dJPgZ6uL9Q7TeR0LZfUhJ9imImNrRnp6QABdq6Ba3EnqSjGnGeOqimcFU8D5Ee2f7N/7ERQhZ//BHitBRXlsosTS2ZWYqP8Zi/avHCv77PTVjX1jhWm8HwxSwqJgZ/05VrXWxM/OowrXiXjaZjZKPudc3lllLPuuhV5btA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733713988; c=relaxed/simple;
	bh=XBa8dBNPBeGiDtffe4gl1gj7H1aIeC7MmnQiRE4yBjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rJMM1H9qa2rqh3w2RgQhSfXOl/WpZPVTKxLHogcy7ytMZCVLw/GoW14hxac8PKj+9aNLXSy3W4H0WeDYAMQtMopAT0jsl3t0svtHlcVjc2K1nVfoiq26gOH23CxIcXmUiEmavbwZKcnz46V+c6ymamFlks5wx36K3ilspVJIX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30181143D;
	Sun,  8 Dec 2024 19:13:27 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98D073F58B;
	Sun,  8 Dec 2024 19:12:56 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/execmem: Make ARCH_WANTS_EXECMEM_LATE depend on EXECMEM
Date: Mon,  9 Dec 2024 08:42:51 +0530
Message-Id: <20241209031251.515903-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Late initialisation of EXECMEM inherently requires EXEMEM itself, and hence
this dependency should not be left with the subscribing platforms.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.13-rc1

 arch/Kconfig       | 1 +
 arch/arm64/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6682b2a53e34..17716f32dc44 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1058,6 +1058,7 @@ config ARCH_WANTS_MODULES_DATA_IN_VMALLOC
 
 config ARCH_WANTS_EXECMEM_LATE
 	bool
+	depends on EXECMEM
 	help
 	  For architectures that do not allocate executable memory early on
 	  boot, but rather require its initialization late when there is
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5479c8b454c..b146372bc365 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -113,7 +113,7 @@ config ARM64
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_LD_ORPHAN_WARN
-	select ARCH_WANTS_EXECMEM_LATE if EXECMEM
+	select ARCH_WANTS_EXECMEM_LATE
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
 	select ARCH_HAS_UBSAN
-- 
2.30.2


