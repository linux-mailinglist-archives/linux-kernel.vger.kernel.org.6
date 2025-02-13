Return-Path: <linux-kernel+bounces-512266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5BA336A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2431690D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 04:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E78D205E0A;
	Thu, 13 Feb 2025 04:09:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090B42066FE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419794; cv=none; b=BAKKxF6F+GCFxZqKtKR5HfTErwISozCP7IzM9XziDYNadW+rbuuHpn6dtNoHacJWzPDPHpKe6Z/hrE039aBzdai2U7+weIJssv8oFRiIsAT9iZbE2br94KlE7bODrHcxXWdOHIaAwmfGS2aoP+o56kvWW53SIuL+uXqGSgC92aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419794; c=relaxed/simple;
	bh=ayiL1Ib+URTyOp0kWrZvu2lcZ87UiKhI1LT/OfgBMTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dlpc8/+gG4pDujjIXehWY9ZP8tU9Ae/y7I61gHqkdCtHWt70SGTuIbdvfxg/bqcW9SLo8O1YdYruhTlJ3MBVukCEN3a/Dx3jegYrXXXzkYmUCz5dq+VrGbTaTNP/Qwkh/yTMkzasXkZ3abOsyc3zw3/1C8fZvnR5QGhMt/bgbNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF8DA1762;
	Wed, 12 Feb 2025 20:10:11 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AA833F58B;
	Wed, 12 Feb 2025 20:09:48 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: steven.price@arm.com,
	christophe.leroy@csgroup.eu,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm: Make GENERIC_PTDUMP dependent on MMU
Date: Thu, 13 Feb 2025 09:39:33 +0530
Message-Id: <20250213040934.3245750-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213040934.3245750-1-anshuman.khandual@arm.com>
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no page table dump without a MMU. Make this dependency at generic
level and drop the same from riscv platform instead.

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/riscv/Kconfig | 2 +-
 mm/Kconfig.debug   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..c4cdba6460b8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -112,7 +112,7 @@ config RISCV
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
-	select GENERIC_PTDUMP if MMU
+	select GENERIC_PTDUMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index a51a1149909a..c08406760d29 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -214,6 +214,7 @@ config DEBUG_WX
 	  If in doubt, say "Y".
 
 config GENERIC_PTDUMP
+	depends on MMU
 	bool
 
 config PTDUMP_CORE
-- 
2.25.1


