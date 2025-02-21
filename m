Return-Path: <linux-kernel+bounces-525172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB86DA3EBF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75867A58FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472CC1FBEA5;
	Fri, 21 Feb 2025 04:43:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A41FBE89
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112987; cv=none; b=FIv8LTl1gD0fkcSpXIiX67b7DD8dMaZ2Uza6OTCug0YV6GQEy+TTZSUcSYXR72B5V1ap4Ij9nm2+r+C0iCQYwGHaFFrlOnP2tUes/YeybwBeuzamRY36cG6EhszOigxpfx91uVR1ViBqiTfBtktPtmnECYWe1S0h4vlC6IQS4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112987; c=relaxed/simple;
	bh=0PX5MVDBSGVG2PGxKPjhBBIhYbfxharACAP4e3x6TKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gsbub33lxr1XVXjYJU35DNTvQPr8c83aXwtajdCeIxXFbgMLoC7faAz0sXSKcQHkYfwqHME26jTs4ksFJA4YQtBca+KddZW0iR8Vu2z6CIWLa2wS6VIeVHwaSEqYWT0RfihVZA7+y8o6Ku8nLAusinj214D+QccpPBjYNv1++EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF2B01C01;
	Thu, 20 Feb 2025 20:43:23 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B72703F6A8;
	Thu, 20 Feb 2025 20:43:01 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/8] arm64/mm: Check PXD_TYPE_TABLE in [p4d|pgd]_bad()
Date: Fri, 21 Feb 2025 10:12:24 +0530
Message-Id: <20250221044227.1145393-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221044227.1145393-1-anshuman.khandual@arm.com>
References: <20250221044227.1145393-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check page table entries against PXD_TYPE_TABLE on PXD_TYPE_MASK mask bits
in [p4d|pgd]_bad() while determining a table entry instead of just checking
only for PXD_TABLE_BIT.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4485ecdffd8a..0c1691979c14 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -918,7 +918,9 @@ static inline bool mm_pud_folded(const struct mm_struct *mm)
 	pr_err("%s:%d: bad pud %016llx.\n", __FILE__, __LINE__, pud_val(e))
 
 #define p4d_none(p4d)		(pgtable_l4_enabled() && !p4d_val(p4d))
-#define p4d_bad(p4d)		(pgtable_l4_enabled() && !(p4d_val(p4d) & P4D_TABLE_BIT))
+#define p4d_bad(p4d)		(pgtable_l4_enabled() && \
+				((p4d_val(p4d) & P4D_TYPE_MASK) != \
+				 P4D_TYPE_TABLE))
 #define p4d_present(p4d)	(!p4d_none(p4d))
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
@@ -1045,7 +1047,9 @@ static inline bool mm_p4d_folded(const struct mm_struct *mm)
 	pr_err("%s:%d: bad p4d %016llx.\n", __FILE__, __LINE__, p4d_val(e))
 
 #define pgd_none(pgd)		(pgtable_l5_enabled() && !pgd_val(pgd))
-#define pgd_bad(pgd)		(pgtable_l5_enabled() && !(pgd_val(pgd) & PGD_TABLE_BIT))
+#define pgd_bad(pgd)		(pgtable_l5_enabled() && \
+				((pgd_val(pgd) & PGD_TYPE_MASK) != \
+				 PGD_TYPE_TABLE))
 #define pgd_present(pgd)	(!pgd_none(pgd))
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
-- 
2.25.1


