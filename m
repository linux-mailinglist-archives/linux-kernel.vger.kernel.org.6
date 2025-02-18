Return-Path: <linux-kernel+bounces-519290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017F3A39B19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115A63A29E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B3A23C8BC;
	Tue, 18 Feb 2025 11:36:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210451AED5C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878608; cv=none; b=ZLEdxnYq8ED5aayYC5k+kaE7TtKZrHFwQHkqSI1tslysU3LD2DWLbo9w+jEELSOq9KYxp0hBeO3mytBP3i87uNde4H///FYy3ZpFe+3NT8AkkPeU+Ozp1vEv7VbOS57l6o++GpyJgZCLf+gHeQb90HTM+oaLRDLX3wOyMj8L49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878608; c=relaxed/simple;
	bh=nYcoxaCipOJL2FBl2zRSOLBS5Pp3UmN6FcQbRmD2XaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t0qQsh2MnhT/WvPBcN2P0AploLxSn9v9fSPVkfNhISk/RY6Gk2/8WmDRJL5MHgcidn2R23hz7KzcjViNiwhP1m2Mb9VxWkBQ1oRYMx0CIXsDzfqLIdvK31oADgsFdcGA2CCXD3+m9e0exAyBKjRPBI3spPbUV+Gp2Ld5ZFS9Lmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58251152B;
	Tue, 18 Feb 2025 03:37:05 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.37.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C0A63F6A8;
	Tue, 18 Feb 2025 03:36:43 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ryan.roberts@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/hugetlb: Consistently use pud_sect_supported()
Date: Tue, 18 Feb 2025 17:06:39 +0530
Message-Id: <20250218113639.475947-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's be consistent in using pud_sect_supported() for PUD_SIZE sized pages.
Hence change hugetlb_mask_last_page() and arch_make_huge_pte() as required.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.14-rc3

Changes in V2:

- Added an warning when PUD_SIZE is requested but not supported per Ryan

Changes in V1:

https://lore.kernel.org/all/20250217065414.49489-1-anshuman.khandual@arm.com/

 arch/arm64/mm/hugetlbpage.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 98a2a0e64e25..1d89599a20d7 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -342,7 +342,9 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
 	switch (hp_size) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SIZE:
-		return PGDIR_SIZE - PUD_SIZE;
+		if (pud_sect_supported())
+			return PGDIR_SIZE - PUD_SIZE;
+		break;
 #endif
 	case CONT_PMD_SIZE:
 		return PUD_SIZE - CONT_PMD_SIZE;
@@ -364,7 +366,10 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	switch (pagesize) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SIZE:
-		entry = pud_pte(pud_mkhuge(pte_pud(entry)));
+		if (pud_sect_supported())
+			entry = pud_pte(pud_mkhuge(pte_pud(entry)));
+		else
+			pr_warn("%s: pud huge page not supported\n", __func__);
 		break;
 #endif
 	case CONT_PMD_SIZE:
-- 
2.30.2


