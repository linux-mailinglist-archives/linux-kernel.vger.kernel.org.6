Return-Path: <linux-kernel+bounces-261965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C22E93BEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C4B1F21C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A42A19750B;
	Thu, 25 Jul 2024 09:11:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7966185E5D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898662; cv=none; b=I+6qvwWNf8Hr3xs4oUr2VmNrpXXUw35qmAvjnc9I2/oLUL0v2ISOSdx0CFqDgol//VDJ3kZgs1+brwJ9jNM8iSOT7mqkXmC5Oh3+Fi1AUx78kxwCnYXxsIYnSSytcPlZ0hBuULz/NvNzRT9rZA3Me1xGONfOa/h1nOFB+TqXb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898662; c=relaxed/simple;
	bh=oJT8EbXNAOu9BTfU5rIcxECDldIh4IVQ12mqGsQToG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nxe0M7gl8DhubRTrwFK0r1T/xc/YQGBECwXKSrsaSSMtp8YZ2+NDgMiaFXXP9qmU4yK/MQ/04Mdnzwjegh7jg1g3/gAnCSc4OgS3zXLpHRbTtoIpU0CJpztOKOGOoWcxZbNqREif/1f+87UtxG6kfw58g7d224x0h7U1Gnybbvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 775781007;
	Thu, 25 Jul 2024 02:11:25 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9C233F5A1;
	Thu, 25 Jul 2024 02:10:57 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Avoid direct referencing page table enties in map_range()
Date: Thu, 25 Jul 2024 14:40:52 +0530
Message-Id: <20240725091052.314750-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like else where in arm64 platform, use WRITE_ONCE() in map_range() while
creating page table entries. This avoids referencing page table entries
directly.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kernel/pi/map_range.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index 5410b2cac590..b93b70cdfb62 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -56,8 +56,8 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 			 * table mapping if necessary and recurse.
 			 */
 			if (pte_none(*tbl)) {
-				*tbl = __pte(__phys_to_pte_val(*pte) |
-					     PMD_TYPE_TABLE | PMD_TABLE_UXN);
+				WRITE_ONCE(*tbl, __pte(__phys_to_pte_val(*pte) |
+					   PMD_TYPE_TABLE | PMD_TABLE_UXN));
 				*pte += PTRS_PER_PTE * sizeof(pte_t);
 			}
 			map_range(pte, start, next, pa, prot, level + 1,
@@ -79,7 +79,7 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 				protval &= ~PTE_CONT;
 
 			/* Put down a block or page mapping */
-			*tbl = __pte(__phys_to_pte_val(pa) | protval);
+			WRITE_ONCE(*tbl, __pte(__phys_to_pte_val(pa) | protval));
 		}
 		pa += next - start;
 		start = next;
-- 
2.30.2


