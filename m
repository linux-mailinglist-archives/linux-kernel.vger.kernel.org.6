Return-Path: <linux-kernel+bounces-227407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA79150CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22521C23809
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382719D093;
	Mon, 24 Jun 2024 14:47:13 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494319D063
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240433; cv=none; b=KiKg3F3GcmCddjHj6Wu2Jbx8lZ3ZL2Fn36Xqsa3hyrIA7Jl0cd9s/9Ib9XKW9eoUbb10uo1F0gQbXAwlChCbkmL8BKtf4+q38t66rm9YDCs+fj4VKVEpkODm8d1mgCVu54CePPVbp6rKK1WYmtxzG/c2iEWO99MS2bQaR/JUbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240433; c=relaxed/simple;
	bh=cm0Ph/xp1X0SRFsHS2XbjMZ7j+bK1MCB+6twQ18qnAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2+KWYl7ttwuxa1uhTLujKm4Mjh6E0gChecL62nzKTtaFhHDRoDxoxyjos9QxVCjIbfvKA0aAKX8AwHLNT0FVoFIstAtl3ZgU3wsBMlgXyg8XlylyCi6Mu2y0PYUOe/ydYT4JlHR8wWZrLVDXmeL1BJqeXgDbSxZD6MDgbxUo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4W79km1X5wz9vG9;
	Mon, 24 Jun 2024 16:46:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kHHWTxjw4GQ; Mon, 24 Jun 2024 16:46:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4W79kg4WNWz9vDw;
	Mon, 24 Jun 2024 16:46:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 971518B768;
	Mon, 24 Jun 2024 16:46:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OnuayCbZs0AO; Mon, 24 Jun 2024 16:46:03 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.33])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1653C8B763;
	Mon, 24 Jun 2024 16:46:03 +0200 (CEST)
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
Subject: [PATCH v6 09/23] powerpc/mm: Remove _PAGE_PSIZE
Date: Mon, 24 Jun 2024 16:45:35 +0200
Message-ID: <2b456ef73a9a834eef2f4a7f59ad45200b6a3bbc.1719240269.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719240269.git.christophe.leroy@csgroup.eu>
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719240333; l=3260; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=cm0Ph/xp1X0SRFsHS2XbjMZ7j+bK1MCB+6twQ18qnAY=; b=m8ISkrH1qKmjgUr7UOzOzgi5x5bb+d5Zk1ECFvbqmJnYe4XPNOXR6JhyRvil/K9n088qnVhM4 1E+kKUTb/s8ABuzBrA90iPy7iLAnd+GZvfd/TJv96NPXnfRQ3hm81Vo
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

_PAGE_PSIZE macro is never used outside the place it is defined
and is used only on 8xx and e500.

Remove indirection, remove it and use its content directly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
v6: Removed the change to pte-40x.h to avoid conflict with the removal of 40x
---
 arch/powerpc/include/asm/nohash/32/pte-44x.h  | 3 ---
 arch/powerpc/include/asm/nohash/32/pte-85xx.h | 3 ---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h  | 5 ++---
 arch/powerpc/include/asm/nohash/pte-e500.h    | 4 +---
 4 files changed, 3 insertions(+), 12 deletions(-)

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


