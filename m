Return-Path: <linux-kernel+bounces-182538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486EE8C8C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72E22824D8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6986313E8A4;
	Fri, 17 May 2024 19:01:04 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A013E89B
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972464; cv=none; b=OV8AZl6OzTrZGc/SRwnInPLI5b5SZcENKlijK6PylpRbflpCY3dEFqzHaFWWhyOKzG43SKZ422SwS1UFoEW1dEZnqiouUMbV2k1fPgxd/i4/pQHRBj9ZuPQRjdhZoLFLOgMMGiIcOdpZw6Hh2gCUAuJrEdN/mUihzdgyGdZQDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972464; c=relaxed/simple;
	bh=kfm3D3YMK6HKXlI4Q/jWMJpnE5NIQCirG/kIeww8M2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxw+zR3TGLBShZGKR9nvG6t+fUmDbvWNRTBVC9RMwUkYTGwTrj/TunxI156emHVtKni91R4RE30IflTwa61eBfhSVb5RECMpP1Eeo4XFRpsSLCOk80MMasnkY9ZIBjRaHT2aW7sbsI1kdZqObrQqvgzfEM/KoL2cY+w61e02reU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Vgx9T0h5Zz9t7B;
	Fri, 17 May 2024 21:00:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SEVCeolmhLT6; Fri, 17 May 2024 21:00:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Vgx9N2xCQz9t0H;
	Fri, 17 May 2024 21:00:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 607318B783;
	Fri, 17 May 2024 21:00:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LflFse82JXm8; Fri, 17 May 2024 21:00:08 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.121])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF3D08B775;
	Fri, 17 May 2024 21:00:07 +0200 (CEST)
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
Subject: [RFC PATCH v2 09/20] powerpc/mm: Remove _PAGE_PSIZE
Date: Fri, 17 May 2024 21:00:03 +0200
Message-ID: <c1d3ab0dc3cb890663a72597d516cce56b47f6e2.1715971869.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715971869.git.christophe.leroy@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715972396; l=3732; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=kfm3D3YMK6HKXlI4Q/jWMJpnE5NIQCirG/kIeww8M2Y=; b=fcRvCMkxiRGg6+9f01EgFQraTFZEGrniZm4822lN26ocsCQ2sTaXecZu9dkQoDitlHSu5mOP3 XIw8j9ai8HfCE5hsjwNLkvjIvI2kLRAfbm0q3SdtBGHFbLcq1huxxod
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

_PAGE_PSIZE macro is never used outside the place it is defined
and is used only on 8xx and e500.

Remove indirection, remove it and use its content directly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
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
index b05cc4f87713..e5bf0d29c7db 100644
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


