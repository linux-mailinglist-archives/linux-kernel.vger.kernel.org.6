Return-Path: <linux-kernel+bounces-247180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642092CC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9751B1C21E91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B2084A21;
	Wed, 10 Jul 2024 07:51:43 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC035CB8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597903; cv=none; b=j16nyMVACraC/BZsNAWHv3k85DriQykO53a4xCVDeB7Zo9WwykMD5PavEm+XPD6mLqn4zKfWobrmNZPCCrm+mB4l6U/VzQwbGv73/SJ5hrUToC7vat638dMCPUmm+55gvudrFyQbTZBNvy9hOvlwoTnD9fLbFMgX3/Q7WO6bF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597903; c=relaxed/simple;
	bh=Ndc+9Qc/wSd8cgS0VuGQFkVzbnR7y1hmuot87Sn0J4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZDRDZOHNoJwMOaLd+8H5ITCZC2xMqOAmON/YACeek14LOembVEPB/60i649fH+wv4gCJ8q7H7dytAM140lwyY3C1WZfQfQU9IZy5Y2Hu9X4m43LwEjqJxOXg9PFgDcQaKYbZ41njawFf+miNpFDEohs4mfLW04hC4DhS9osopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WJqn62Pw2z9sSv;
	Wed, 10 Jul 2024 09:51:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EpgCmhGS0H2a; Wed, 10 Jul 2024 09:51:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WJqmw2510z9sT8;
	Wed, 10 Jul 2024 09:51:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 35A9E8B779;
	Wed, 10 Jul 2024 09:51:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Su09KU2IeCB5; Wed, 10 Jul 2024 09:51:28 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.26])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E1D468B766;
	Wed, 10 Jul 2024 09:51:27 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 1/3] arch/x86: Drop own definition of pgd,p4d_leaf
Date: Wed, 10 Jul 2024 09:51:20 +0200
Message-ID: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720597882; l=1393; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=y1Fku5Ig+SrLh/mlbGZSDg5khbyWLz2sNH+Fhxvf8CY=; b=ZZZbGXGTOnTKjAp08fuPZS4cmRBbyfRVezQt4Oz9YhJ7W4Res5iQwjOEEXfNvOQwA/ghhFQas Nvz5aEWhOUEA4kFg32/yccO89q7Vl3J1d9wEvAyscMk8Xay/WbsDPQO
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

From: Oscar Salvador <osalvador@suse.de>

We provide generic definitions of pXd_leaf in pgtable.h when the arch
do not define their own, where the generic pXd_leaf always return false.

Although x86 defines {pgd,p4d}_leaf, they end up being a no-op, so drop them
and make them fallback to the generic one.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/x86/include/asm/pgtable.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 65b8e5bb902c..772f778bac06 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -252,13 +252,6 @@ static inline unsigned long pgd_pfn(pgd_t pgd)
 	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
 
-#define p4d_leaf p4d_leaf
-static inline bool p4d_leaf(p4d_t p4d)
-{
-	/* No 512 GiB pages yet */
-	return 0;
-}
-
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
 #define pmd_leaf pmd_leaf
@@ -1396,9 +1389,6 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
 }
 
-#define pgd_leaf	pgd_leaf
-static inline bool pgd_leaf(pgd_t pgd) { return false; }
-
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
  * All top-level MITIGATION_PAGE_TABLE_ISOLATION page tables are order-1 pages
-- 
2.44.0


