Return-Path: <linux-kernel+bounces-190705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA08D018A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9905A1F25A89
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A0D15FA6C;
	Mon, 27 May 2024 13:30:40 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850915FA63
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816640; cv=none; b=qZ4A8+y0QmcdfQ+Fcrsdjq2U/fPEIYWCRK1Kgoux/Qkx61WjQDSxWT5KpJzwkMDpBrQ+BkNgo5qrk2DN4m1Gum6kN/sQrGbA/sb7Jwbv22BfvMThdJbJ9sZKDEWUP6gsdG8W9Ndl3zkmW0K0ZWDjqerKO+RBO4gGk0GsHXS1mFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816640; c=relaxed/simple;
	bh=ymAToQL34uMf8YFNIV4scdsUyseWbpqXywhQPbZn4dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAlBDcP51cg8nPalVKKwse/f/S4mQ+75NHfUEaGFF0fhe+qM455xFBKrhRanfqV0Q7CrYtDN8uAoTBF3IK0QPhU6uULS+NBfXmlau6f5kUiTHmlHZiWfVDwGIDXOr1PWE3wQeIVnh/+zV+nAQgUTVUZUmZW4cwQyA11LAMu32OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VnxNS2y9Tz9tCB;
	Mon, 27 May 2024 15:30:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dwzHL0j4Um4X; Mon, 27 May 2024 15:30:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VnxNS27XHz9sqS;
	Mon, 27 May 2024 15:30:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 445D48B773;
	Mon, 27 May 2024 15:30:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id z_9OGc64ZTyp; Mon, 27 May 2024 15:30:32 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.49])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B2E508B764;
	Mon, 27 May 2024 15:30:29 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v4 04/16] powerpc/mm: Remove _PAGE_PSIZE
Date: Mon, 27 May 2024 15:30:02 +0200
Message-ID: <bb2d6cc86dacaf3ee4b88c8f3eaf6431e2a2d290.1716815901.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716815901.git.christophe.leroy@csgroup.eu>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716816600; l=3781; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ymAToQL34uMf8YFNIV4scdsUyseWbpqXywhQPbZn4dQ=; b=mgroCXZl2/TZQwRAqnuJswewIKfMl4lJ+gcZuO2nU2xi2qIowPjsJ/9jFFjBsd+KifgCqhjoI +l+xohWFTyKAbv9S8ISGhJeETUR9pdCiIfLYaWAaL+8GS2KnB1LQFyw
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

_PAGE_PSIZE macro is never used outside the place it is defined
and is used only on 8xx and e500.

Remove indirection, remove it and use its content directly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 arch/powerpc/include/asm/nohash/32/pte-40x.h  | 3 ---
 arch/powerpc/include/asm/nohash/32/pte-44x.h  | 3 ---
 arch/powerpc/include/asm/nohash/32/pte-85xx.h | 3 ---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h  | 5 ++---
 arch/powerpc/include/asm/nohash/pte-e500.h    | 4 +---
 5 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index d759cfd74754..52ed58516fa4 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -49,9 +49,6 @@
 #define _PAGE_EXEC	0x200	/* hardware: EX permission */
 #define _PAGE_ACCESSED	0x400	/* software: R: page referenced */
 
-/* No page size encoding in the linux PTE */
-#define _PAGE_PSIZE		0
-
 /* cache related flags non existing on 40x */
 #define _PAGE_COHERENT	0
 
diff --git a/arch/powerpc/include/asm/nohash/32/pte-44x.h b/arch/powerpc/include/asm/nohash/32/pte-44x.h
index 851813725237..da0469928273 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-44x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-44x.h
@@ -75,9 +75,6 @@
 #define _PAGE_NO_CACHE	0x00000400		/* H: I bit */
 #define _PAGE_WRITETHRU	0x00000800		/* H: W bit */
 
-/* No page size encoding in the linux PTE */
-#define _PAGE_PSIZE		0
-
 /* TODO: Add large page lowmem mapping support */
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
diff --git a/arch/powerpc/include/asm/nohash/32/pte-85xx.h b/arch/powerpc/include/asm/nohash/32/pte-85xx.h
index 653a342d3b25..14d64b4f3f14 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-85xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-85xx.h
@@ -31,9 +31,6 @@
 #define _PAGE_WRITETHRU	0x00400	/* H: W bit */
 #define _PAGE_SPECIAL	0x00800 /* S: Special page */
 
-/* No page size encoding in the linux PTE */
-#define _PAGE_PSIZE		0
-
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 137dc3c84e45..625c31d6ce5c 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -74,12 +74,11 @@
 #define _PTE_NONE_MASK	0
 
 #ifdef CONFIG_PPC_16K_PAGES
-#define _PAGE_PSIZE	_PAGE_SPS
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_SPS)
 #else
-#define _PAGE_PSIZE		0
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
 #endif
 
-#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
 #define _PAGE_BASE	(_PAGE_BASE_NC)
 
 #include <asm/pgtable-masks.h>
diff --git a/arch/powerpc/include/asm/nohash/pte-e500.h b/arch/powerpc/include/asm/nohash/pte-e500.h
index f516f0b5b7a8..975facc7e38e 100644
--- a/arch/powerpc/include/asm/nohash/pte-e500.h
+++ b/arch/powerpc/include/asm/nohash/pte-e500.h
@@ -65,8 +65,6 @@
 
 #define _PAGE_SPECIAL	_PAGE_SW0
 
-/* Base page size */
-#define _PAGE_PSIZE	_PAGE_PSIZE_4K
 #define	PTE_RPN_SHIFT	(24)
 
 #define PTE_WIMGE_SHIFT (19)
@@ -89,7 +87,7 @@
  * pages. We always set _PAGE_COHERENT when SMP is enabled or
  * the processor might need it for DMA coherency.
  */
-#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE_4K)
 #if defined(CONFIG_SMP)
 #define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
 #else
-- 
2.44.0


