Return-Path: <linux-kernel+bounces-440842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA799EC515
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2443516716B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CA01D5CCD;
	Wed, 11 Dec 2024 06:54:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E61C3F28;
	Wed, 11 Dec 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900079; cv=none; b=dyl/RhzdpMRNNUwM5417SOGgI47j0SQ0zlwxcsczpqVDbFytzR9u0Z8dFv3H4ar8/kzaM2L9cgKxya5HYn1Mu8xqP6APr7H9zfNJXafPaw3GqdTRl61Z9vSh+mDA3EvH/HZ5J2HGsj7yRHGUj8IRJxwJ3f7u9dHoeal2p8YcxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900079; c=relaxed/simple;
	bh=Qau3hUcWctg67mhkemsiWXM6oOUzNlZKWKoZZMjFI4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4OnCnbx1M0zcOeXFiX466W8LrWNhKR4oG41Jcuszt7CTKR+/0CZo8KEdY6e5Uy2qAXanaiy40vK+lQLoOP1L9e+m0Qh7RKs4GKkCKNm/JoYtiR9c7wEHhxk5RWZmD7Cq98bLVMeUfFGXZ9qriEKsgjdswK8Gh1JYyy//DBgxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA43016F2;
	Tue, 10 Dec 2024 22:55:04 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D27B3F720;
	Tue, 10 Dec 2024 22:54:33 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] docs: arm64: Document EL3 requirements for cpu debug architecture
Date: Wed, 11 Dec 2024 12:24:24 +0530
Message-Id: <20241211065425.1106683-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211065425.1106683-1-anshuman.khandual@arm.com>
References: <20241211065425.1106683-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents EL3 requirements for debug architecture. The register field
MDCR_EL3.TDA needs to be cleared for accesses into debug registers without
any trap being generated into EL3. CPU debug registers like DBGBCR<n>_EL1,
DBGBVR<n>_EL1, DBGWCR<n>_EL1, DBGWVR<n>_EL1 and MDSCR_EL1 are already being
accessed for HW breakpoint, watchpoint and debug monitor implementations on
the platform.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/arch/arm64/booting.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index 3278fb4bf219..1b3ac1394e5f 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -449,6 +449,12 @@ Before jumping into the kernel, the following conditions must be met:
 
     - HFGWTR_EL2.nGCS_EL0 (bit 52) must be initialised to 0b1.
 
+ - For CPUs with debug architecture i.e FEAT_Debugv8pN (all versions):
+
+ - If EL3 is present:
+
+   - MDCR_EL3.TDA (bit 9) must be initialized to 0b0
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented
-- 
2.30.2


