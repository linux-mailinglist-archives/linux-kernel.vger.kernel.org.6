Return-Path: <linux-kernel+bounces-218612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25CD90C28E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7442850B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EE420B28;
	Tue, 18 Jun 2024 03:47:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367828FD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682436; cv=none; b=DbVqd0/n5R44Qhd9mWF0EhAo0L9FMyzMt9JbDB04McKUTYf3QDaIavGvvm3URF0sJT8m7TgIhqLAfKpJD/Wm0/XjpKCtRzz4b1X/wtOUdsHpvVlffwD+gDatq9SDS52Fcw3wQm459aFPUUH+0riG1x4FWJaFAySxc5/wFk2WDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682436; c=relaxed/simple;
	bh=mhxqX9HiAtpa0nU5f5SzZN+KrgL7HZ4BRQwVjT8w5HU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WYf9k9F/HiqHzCPcixQhri1/DW+NinKIcfj8nCWm23xd+mHDD2NAIFx6sC9gMGsVZe0UqcS+7ADew8TfF4L6Q4moBYUbG693OYoG/aKUQga6UXPmq1SVkjdViHGeElZ0zgbmd18pfFx8ZAWuY3Ql6Tg6Sl3PXyC6psKx7lc/El0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 367C5DA7;
	Mon, 17 Jun 2024 20:47:37 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.45.206])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A85A53F73B;
	Mon, 17 Jun 2024 20:47:09 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com,
	ryan.roberts@arm.com,
	maz@kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/mm: Stop using ESR_ELx_FSC_TYPE during fault
Date: Tue, 18 Jun 2024 09:17:03 +0530
Message-Id: <20240618034703.3622510-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fault status codes at page table level 0, 1, 2 and 3 for access, permission
and translation faults are architecturally organized in a way, that masking
out ESR_ELx_FSC_TYPE, fetches Level 0 status code for the respective fault.

Helpers like esr_fsc_is_[translation|permission|access_flag]_fault() mask
out ESR_ELx_FSC_TYPE before comparing against corresponding Level 0 status
code as the kernel does not yet care about the page table level, where in
the fault really occurred previously.

This scheme is starting to crumble after FEAT_LPA2 when level -1 got added.
Fault status code for translation fault at level -1 is 0x2B which does not
follow ESR_ELx_FSC_TYPE, requiring esr_fsc_is_translation_fault() changes.

This changes above helpers to compare against individual fault status code
values for each page table level and stop using ESR_ELx_FSC_TYPE, which is
losing its value as a common mask.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.10-rc4 and still leaves behind ESR_ELx_FSC_TYPE for now.

Changes in V2:

- Defined ESR_ELx_FSC_[ACCESS|FAULT_PERM]_L() macros
- Changed fault helpers using the above macros instead
- Dropped each page table level fault status discrete values
- Dropped set_thread_esr() changes in arch/arm64/mm/fault.c
- Updated the commit message

Changes in V1:

https://lore.kernel.org/linux-arm-kernel/20240613094538.3263536-1-anshuman.khandual@arm.com/

 arch/arm64/include/asm/esr.h | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 7abf09df7033..3f482500f71f 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -121,6 +121,14 @@
 #define ESR_ELx_FSC_SECC	(0x18)
 #define ESR_ELx_FSC_SECC_TTW(n)	(0x1c + (n))
 
+/* Status codes for individual page table levels */
+#define ESR_ELx_FSC_ACCESS_L(n)	(ESR_ELx_FSC_ACCESS + n)
+#define ESR_ELx_FSC_PERM_L(n)	(ESR_ELx_FSC_PERM + n)
+
+#define ESR_ELx_FSC_FAULT_nL	(0x2C)
+#define ESR_ELx_FSC_FAULT_L(n)	(((n) < 0 ? ESR_ELx_FSC_FAULT_nL : \
+					    ESR_ELx_FSC_FAULT) + (n))
+
 /* ISS field definitions for Data Aborts */
 #define ESR_ELx_ISV_SHIFT	(24)
 #define ESR_ELx_ISV		(UL(1) << ESR_ELx_ISV_SHIFT)
@@ -388,20 +396,33 @@ static inline bool esr_is_data_abort(unsigned long esr)
 
 static inline bool esr_fsc_is_translation_fault(unsigned long esr)
 {
-	/* Translation fault, level -1 */
-	if ((esr & ESR_ELx_FSC) == 0b101011)
-		return true;
-	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
+	esr = esr & ESR_ELx_FSC;
+
+	return (esr == ESR_ELx_FSC_FAULT_L(3)) ||
+	       (esr == ESR_ELx_FSC_FAULT_L(2)) ||
+	       (esr == ESR_ELx_FSC_FAULT_L(1)) ||
+	       (esr == ESR_ELx_FSC_FAULT_L(0)) ||
+	       (esr == ESR_ELx_FSC_FAULT_L(-1));
 }
 
 static inline bool esr_fsc_is_permission_fault(unsigned long esr)
 {
-	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_PERM;
+	esr = esr & ESR_ELx_FSC;
+
+	return (esr == ESR_ELx_FSC_PERM_L(3)) ||
+	       (esr == ESR_ELx_FSC_PERM_L(2)) ||
+	       (esr == ESR_ELx_FSC_PERM_L(1)) ||
+	       (esr == ESR_ELx_FSC_PERM_L(0));
 }
 
 static inline bool esr_fsc_is_access_flag_fault(unsigned long esr)
 {
-	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_ACCESS;
+	esr = esr & ESR_ELx_FSC;
+
+	return (esr == ESR_ELx_FSC_ACCESS_L(3)) ||
+	       (esr == ESR_ELx_FSC_ACCESS_L(2)) ||
+	       (esr == ESR_ELx_FSC_ACCESS_L(1)) ||
+	       (esr == ESR_ELx_FSC_ACCESS_L(0));
 }
 
 /* Indicate whether ESR.EC==0x1A is for an ERETAx instruction */
-- 
2.30.2


