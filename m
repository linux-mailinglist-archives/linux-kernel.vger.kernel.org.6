Return-Path: <linux-kernel+bounces-332284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D59697B7CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1966B1F23BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5B1531E6;
	Wed, 18 Sep 2024 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="i2v4uYkE"
Received: from out187-23.us.a.mail.aliyun.com (out187-23.us.a.mail.aliyun.com [47.90.187.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B502572
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640265; cv=none; b=QP1DxEmgvqzLN2p/CDgqlDt+dmdNV4uyGdGleJyrW2iUaO/GTnZiY8obPqVgXpck50KgKs1mNMEmusWG/xEWAROr5QCDF6sMNyltEeI5VibZij2CPfCKGR8XwsPfbhCEYc7eaR4ADSTy6yhbZIg3aqzAAK4s1l/76mHwwytlzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640265; c=relaxed/simple;
	bh=yRVXFrOQPl2AO+xSeJUL1sX/M031o7p41IoX4P+Jt7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l2tVD6Kn3i/Q34jadIwI1tI7SyuTTwwCAwQ6EB+barU5/Nese1bVqb5eDMRRcafGAArS0KTsCsL/rLnhg/RJ4NWwxxjALPuRZcDF8VyM2hRtnFhY5Oqd8oGbivezBZzqPAn5cb2QFwQfZo0dt0J3GgUDnH7cEggrfYpARr6aoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=i2v4uYkE; arc=none smtp.client-ip=47.90.187.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726640244; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GSbNvMbvlIYCPZ3mxOvNKxWg383qnaZcxNrNsAwhkbo=;
	b=i2v4uYkEZ9Uymp4h3914hG5/qT+MIs4sFV23u/+5utOvKIMMf/61I7WptAaGT8GTuhPQ6ZxFsnKpGilNit4eAiXjcQtmhYY8zS25c0pIZFi4BLUtANMYxrvzxAzEVdnc9eorgwEjI90eC4FB5ltG9NcayzAh6ZPGpyeU9nUx80A=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZLyYvfD_1726640238)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 14:17:23 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Remove 3-level page table support on i386
Date: Wed, 18 Sep 2024 14:17:02 +0800
Message-Id: <20240918061702.614837-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The highmem support has been removed by commit a98a6d864d3b ("um:
Remove broken highmem support"). The 2-level page table is sufficient
on UML/i386 now. Remove the 3-level page table support on UML/i386
which is still marked as experimental.

Suggested-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/configs/i386_defconfig       |  1 -
 arch/um/include/asm/page.h           | 24 ------------------------
 arch/um/include/asm/pgtable-3level.h |  9 ---------
 arch/x86/um/Kconfig                  | 10 +---------
 4 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index e543cbac8792..0cc717d80be6 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -1,4 +1,3 @@
-CONFIG_3_LEVEL_PGTABLES=y
 # CONFIG_COMPACTION is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_HOSTFS=y
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 9ef9a8aedfa6..8d2ac5e86cf5 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -32,28 +32,6 @@ struct page;
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
-#if defined(CONFIG_3_LEVEL_PGTABLES) && !defined(CONFIG_64BIT)
-
-typedef struct { unsigned long pte; } pte_t;
-typedef struct { unsigned long pmd; } pmd_t;
-typedef struct { unsigned long pgd; } pgd_t;
-#define pte_val(p) ((p).pte)
-
-#define pte_get_bits(p, bits) ((p).pte & (bits))
-#define pte_set_bits(p, bits) ((p).pte |= (bits))
-#define pte_clear_bits(p, bits) ((p).pte &= ~(bits))
-#define pte_copy(to, from) ({ (to).pte = (from).pte; })
-#define pte_is_zero(p) (!((p).pte & ~_PAGE_NEWPAGE))
-#define pte_set_val(p, phys, prot) \
-	({ (p).pte = (phys) | pgprot_val(prot); })
-
-#define pmd_val(x)	((x).pmd)
-#define __pmd(x) ((pmd_t) { (x) } )
-
-typedef unsigned long long phys_t;
-
-#else
-
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 
@@ -75,8 +53,6 @@ typedef struct { unsigned long pmd; } pmd_t;
 
 typedef unsigned long phys_t;
 
-#endif
-
 typedef struct { unsigned long pgprot; } pgprot_t;
 
 typedef struct page *pgtable_t;
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 8a5032ec231f..3504a92dc485 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -11,11 +11,7 @@
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
 
-#ifdef CONFIG_64BIT
 #define PGDIR_SHIFT	30
-#else
-#define PGDIR_SHIFT	31
-#endif
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
@@ -32,13 +28,8 @@
  */
 
 #define PTRS_PER_PTE 512
-#ifdef CONFIG_64BIT
 #define PTRS_PER_PMD 512
 #define PTRS_PER_PGD 512
-#else
-#define PTRS_PER_PMD 1024
-#define PTRS_PER_PGD 1024
-#endif
 
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 186f13268401..7d16baba8f5f 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -29,15 +29,7 @@ config X86_64
 	select MODULES_USE_ELF_RELA
 
 config 3_LEVEL_PGTABLES
-	bool "Three-level pagetables" if !64BIT
-	default 64BIT
-	help
-	  Three-level pagetables will let UML have more than 4G of physical
-	  memory.  All the memory that can't be mapped directly will be treated
-	  as high memory.
-
-	  However, this it experimental on 32-bit architectures, so if unsure say
-	  N (on x86-64 it's automatically enabled, instead, as it's safe there).
+	def_bool 64BIT
 
 config ARCH_HAS_SC_SIGNALS
 	def_bool !64BIT
-- 
2.34.1


