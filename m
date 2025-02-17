Return-Path: <linux-kernel+bounces-517072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE3CA37BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1650169414
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B0318FDAE;
	Mon, 17 Feb 2025 06:54:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DBA18A95A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775264; cv=none; b=BvuVcYtq578HdSZhbsqmsE0nFN5HQNGyXj9RvBRHLJjwKZbd/Fv/1EBsOxTw6syEUiBQKcjwI5iYz9b8cE3zNTRP6Kr0Zp6gEufKJkp2Xrm1Estj+Bn6+Ue1AYH7atwRox9zY81EtSScOhD7SN2iN0pG2KQrNAp8GBdHV7JnoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775264; c=relaxed/simple;
	bh=P6cHBE0hSq19QpI50fjzrhRsVBUf1Zsec0ntMl17JZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mngE9XhUIVW3/XrITIvbkqX8ZWaf7CuUhGRJEoh51ZspGvXWIFFKn98+bhZGeExCH1fjXT7tLAZwC40+h1teFka0eyax0ntz2Bu9wYZ0sT2dBVcZ3UTzKzgzZuD9dvd018fc6UPvuCiJKyEbNyeiMH6p2EnwLGhlskOFPZ4z4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AF0E1063;
	Sun, 16 Feb 2025 22:54:40 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.16.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10C463F6A8;
	Sun, 16 Feb 2025 22:54:18 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ryan.roberts@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/hugetlb: Consistently use pud_sect_supported()
Date: Mon, 17 Feb 2025 12:24:14 +0530
Message-Id: <20250217065414.49489-1-anshuman.khandual@arm.com>
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

 arch/arm64/mm/hugetlbpage.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 98a2a0e64e25..5b7cfdba9c93 100644
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
@@ -364,7 +366,8 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	switch (pagesize) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SIZE:
-		entry = pud_pte(pud_mkhuge(pte_pud(entry)));
+		if (pud_sect_supported())
+			entry = pud_pte(pud_mkhuge(pte_pud(entry)));
 		break;
 #endif
 	case CONT_PMD_SIZE:
-- 
2.30.2


