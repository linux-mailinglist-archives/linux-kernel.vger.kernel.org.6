Return-Path: <linux-kernel+bounces-553580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72348A58BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD04169900
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878C1CAA6E;
	Mon, 10 Mar 2025 06:28:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0297519DF52
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588109; cv=none; b=qFwm3WB9vbigQOPMbkXlfJlPq58Ma40tnSQPdH9gi+2VGxPt8nsfD/Qrmqv4KjPVt93V7QYneCkbOUacx4TRx654aPq6P37sdktJpeaC8HHMy3s3s34APDrzppgaWU/BG08FkTl2MI/b10YqL+uUD5OstYELjXLyzezwvT1GKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588109; c=relaxed/simple;
	bh=C1kJVWEKEwWNNYe0i+nZYOE1/1vy/u3O3laH7Uoc0rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TAe4WqB9GKe6sqL9b1zzZRZ2zeT4zD85+BnQxv875MnLLdwunYvneEB9ryBgtFvVoylWky+EsSHSJFQWZjxid/Q/nP+5FQ6uqA4mtKEOpwfqRbZOSedFjjLLY+O+1DzHFwPZ2MCzZ6u9SxeJAsqL8bL64VXeZVXfBDVln9qY7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8654415A1;
	Sun,  9 Mar 2025 23:28:37 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.42.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 46F523F673;
	Sun,  9 Mar 2025 23:28:22 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/mm: Create level specific section mappings in map_range()
Date: Mon, 10 Mar 2025 11:58:12 +0530
Message-Id: <20250310062812.216031-1-anshuman.khandual@arm.com>
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
instead of the common PMD_TYPE_SECT. While here also ensure that a section
mapping is only created on page table levels which could support that on a
given page size configuration otherwise fall back to create table entries.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.14-rc6

Changes in V2:

- Dropped PGD_TYPE_SECT macro and its instance from map_range()
- Create table entries on levels where section mapping is not possible

Changes in V1:

https://lore.kernel.org/all/20250303041834.2796751-1-anshuman.khandual@arm.com/

 arch/arm64/kernel/pi/map_range.c | 38 +++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index 2b69e3beeef8..25a70c675c4d 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -11,6 +11,22 @@
 
 #include "pi.h"
 
+static bool sect_supported(int level)
+{
+	switch (level) {
+	case -1:
+		return false;
+	case 0:
+		if (IS_ENABLED(CONFIG_ARM64_16K_PAGES) ||
+		    IS_ENABLED(CONFIG_ARM64_64K_PAGES))
+			return false;
+		else
+			return true;
+	default:
+		return true;
+	}
+}
+
 /**
  * map_range - Map a contiguous range of physical pages into virtual memory
  *
@@ -44,13 +60,29 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 	 * Set the right block/page bits for this level unless we are
 	 * clearing the mapping
 	 */
-	if (protval)
-		protval |= (level < 3) ? PMD_TYPE_SECT : PTE_TYPE_PAGE;
+	if (protval && sect_supported(level)) {
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
+		default:
+			break;
+		}
+	}
 
 	while (start < end) {
 		u64 next = min((start | lmask) + 1, PAGE_ALIGN(end));
 
-		if (level < 3 && (start | next | pa) & lmask) {
+		if ((level < 3 && (start | next | pa) & lmask) || !sect_supported(level)) {
 			/*
 			 * This chunk needs a finer grained mapping. Create a
 			 * table mapping if necessary and recurse.
-- 
2.25.1


