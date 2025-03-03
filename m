Return-Path: <linux-kernel+bounces-540975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452FFA4B71B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17303AC00F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5115853B;
	Mon,  3 Mar 2025 04:18:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F1913D539
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 04:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975527; cv=none; b=oHb7e3MkczS09QYKOuyls43VZAGEdxIW6sSmdACjLIEmcy9v/3raxlqjhXJSM03I0PfjM9NBZ+Brk7fmK4R1ruqFlMbT1BejU4hLjN8TK7ili+HrL5Xl8l3TKFBa4Qr2ErzKOFrnAcvKwEIeWDuRQ+fl+PwIFC1pxdR0ZKMTKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975527; c=relaxed/simple;
	bh=eEpiGNqCgbnj8djhxEw+e4krx6XJyFeiTFUvAjInrP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PqyMT48oV//AC9eEpytQyqz1KU3RiLvuedMg+DOfhrszvzUUDZoie79lwXc2kzqqxcY3vNKCiIzwDWJWvEJ7F6eo9tuiVrEJocE+1IXHfMX44tPfIrFina28BySy/WTwDm0p5BKgS90ZRG8/hjeqG7iWNHQ/WNUmyy+ZiEuydtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA83F113E;
	Sun,  2 Mar 2025 20:18:57 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9D953F66E;
	Sun,  2 Mar 2025 20:18:40 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Create level specific section mappings in map_range()
Date: Mon,  3 Mar 2025 09:48:34 +0530
Message-Id: <20250303041834.2796751-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently PMD section mapping mask i.e PMD_TYPE_SECT is used while creating
section mapping at all page table levels except the last level. This works
fine as the section mapping masks are exactly the same (0x1UL) for all page
table levels.

This will change in the future with D128 page tables that have unique skip
level values (SKL) required for creating section mapping at different page
table levels. Hence use page table level specific section mapping macros
instead of the common PMD_TYPE_SECT.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on 6.14-rc5

PGD_TYPE_SECT for level -1 section map handling has been added for 4K
base pages with 52 bit VA configuration that has 5 page table levels.
In such cases (CONFIG_PGTABLE_LEVELS = 5) early_map_kernel() can call
map_range() eventually with -1 (i.e 4 - CONFIG_PGTABLE_LEVELS) as the
root_level.

 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/kernel/pi/map_range.c       | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index a9136cc551cc..fd0a82e8878c 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -99,6 +99,7 @@
 #define PGD_TYPE_TABLE		(_AT(pgdval_t, 3) << 0)
 #define PGD_TABLE_BIT		(_AT(pgdval_t, 1) << 1)
 #define PGD_TYPE_MASK		(_AT(pgdval_t, 3) << 0)
+#define PGD_TYPE_SECT		(_AT(pgdval_t, 1) << 0)
 #define PGD_TABLE_AF		(_AT(pgdval_t, 1) << 10)	/* Ignored if no FEAT_HAFT */
 #define PGD_TABLE_PXN		(_AT(pgdval_t, 1) << 59)
 #define PGD_TABLE_UXN		(_AT(pgdval_t, 1) << 60)
diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index 2b69e3beeef8..9ea869f5745f 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -44,8 +44,27 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 	 * Set the right block/page bits for this level unless we are
 	 * clearing the mapping
 	 */
-	if (protval)
-		protval |= (level < 3) ? PMD_TYPE_SECT : PTE_TYPE_PAGE;
+	if (protval) {
+		switch (level) {
+		case 3:
+			protval |= PTE_TYPE_PAGE;
+			break;
+		case 2:
+			protval |= PMD_TYPE_SECT;
+			break;
+		case 1:
+			protval |= PUD_TYPE_SECT;
+			break;
+		case 0:
+			protval |= P4D_TYPE_SECT;
+			break;
+		case -1:
+			protval |= PGD_TYPE_SECT;
+			break;
+		default:
+			break;
+		}
+	}
 
 	while (start < end) {
 		u64 next = min((start | lmask) + 1, PAGE_ALIGN(end));
-- 
2.30.2


