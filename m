Return-Path: <linux-kernel+bounces-237901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68227923F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C631F2644C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA571BC07E;
	Tue,  2 Jul 2024 13:52:51 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CC1BA869
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928370; cv=none; b=qMh73JA3JCEi6Xy612Db3MlSK98DtZCytZyEJku+kwGmHF8xbKKcS2T6Q/1jxC3ez5Av5WwhkXjagaUHHvvN7SsQ++2chtPm5QES6LBgIE8hkX6Hejl94ht8nJ5EpwvYd7EFQ+btlFkLKsk+fMeNj/9VYG5+m2fnuAwXosvXpWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928370; c=relaxed/simple;
	bh=ynQfm9JBiFGAxo+DROotbCi4y0+yhN5d6b0AA4yoL0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPzEIArev3Rc6VVwJFXzSGD/REESIVJBTVef/0On43uWNRHSH9jxvHacNePshj0QOCkq10DqqJRoZUjBZe8idsEcIPsz+BpAYPYR5rbOSlj6RD7zBpKrE0kMUvmPeUiMUuV/JIyJgBzjpD39rMOuYwDA24YjD+08jdbGxl9m/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4WD48K12dVz9v2F;
	Tue,  2 Jul 2024 15:51:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CxQ474nA3jKF; Tue,  2 Jul 2024 15:51:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4WD4862d6Bz9v7L;
	Tue,  2 Jul 2024 15:51:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 55D388B774;
	Tue,  2 Jul 2024 15:51:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id A5pzDnRs-Jou; Tue,  2 Jul 2024 15:51:34 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.12])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C91538B775;
	Tue,  2 Jul 2024 15:51:33 +0200 (CEST)
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
Subject: [PATCH v7 17/23] powerpc/e500: Encode hugepage size in PTE bits
Date: Tue,  2 Jul 2024 15:51:29 +0200
Message-ID: <6f7ce82fa8c381d55f65342d77060fc55802e612.1719928057.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719928057.git.christophe.leroy@csgroup.eu>
References: <cover.1719928057.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719928275; l=4066; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ynQfm9JBiFGAxo+DROotbCi4y0+yhN5d6b0AA4yoL0Q=; b=QlbwuOh8CkIKRxk1Au5CyczWq573GEKpqCwwgW7AMQgt2eEOL8L6hmPsA5PNJoTqDOTWjwumi 7MRu1yorX68DIIBViNV11hHb6SZmkTrroIUiiqrvbJl9pPA9MJhHdpu
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Use PTE page size bits to encode hugepage size with the following
format corresponding to the values expected in bits 52-55 in MAS1
register. Those bits are called TSIZE:
	0001 	4 Kbyte
	0010 	16 Kbyte
	0011 	64 Kbyte
	0100 	256 Kbyte
	0101 	1 Mbyte
	0110 	4 Mbyte
	0111 	16 Mbyte
	1000 	64 Mbyte
	1001 	256 Mbyte
	1010 	1 Gbyte
	1011 	4 Gbyte
	1100 	16 Gbyte
	1101	64 Gbyte
	1110	256 Gbyte
	1111	1 Tbyte

It corresponds to shift value minus 10 with lowest bit removed.

It is not the value expected in the PTE in that field, but only
e6500 performs HW based TLB loading and the e6500 reference manual
explicitely says that this field is ignored.

Also add pte_huge_size() which will be used later.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5: Use PAGE SIZE field instead of U0-U3 because on some HW U2-U3 are used for something else.
---
 .../powerpc/include/asm/nohash/hugetlb-e500.h |  9 ++++++
 arch/powerpc/include/asm/nohash/pte-e500.h    | 28 +++++++++----------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/hugetlb-e500.h b/arch/powerpc/include/asm/nohash/hugetlb-e500.h
index 8f04ad20e040..c6a0938e86fd 100644
--- a/arch/powerpc/include/asm/nohash/hugetlb-e500.h
+++ b/arch/powerpc/include/asm/nohash/hugetlb-e500.h
@@ -42,4 +42,13 @@ static inline int check_and_get_huge_psize(int shift)
 	return shift_to_mmu_psize(shift);
 }
 
+static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
+{
+	unsigned int tsize = shift - _PAGE_PSIZE_SHIFT_OFFSET;
+	pte_basic_t val = (tsize << _PAGE_PSIZE_SHIFT) & _PAGE_PSIZE_MSK;
+
+	return __pte((pte_val(entry) & ~(pte_basic_t)_PAGE_PSIZE_MSK) | val);
+}
+#define arch_make_huge_pte arch_make_huge_pte
+
 #endif /* _ASM_POWERPC_NOHASH_HUGETLB_E500_H */
diff --git a/arch/powerpc/include/asm/nohash/pte-e500.h b/arch/powerpc/include/asm/nohash/pte-e500.h
index 975facc7e38e..6dac1c0a6937 100644
--- a/arch/powerpc/include/asm/nohash/pte-e500.h
+++ b/arch/powerpc/include/asm/nohash/pte-e500.h
@@ -19,20 +19,7 @@
 #define _PAGE_BAP_SX	0x000040
 #define _PAGE_BAP_UX	0x000080
 #define _PAGE_PSIZE_MSK	0x000f00
-#define _PAGE_PSIZE_4K	0x000200
-#define _PAGE_PSIZE_8K	0x000300
-#define _PAGE_PSIZE_16K	0x000400
-#define _PAGE_PSIZE_32K	0x000500
-#define _PAGE_PSIZE_64K	0x000600
-#define _PAGE_PSIZE_128K	0x000700
-#define _PAGE_PSIZE_256K	0x000800
-#define _PAGE_PSIZE_512K	0x000900
-#define _PAGE_PSIZE_1M	0x000a00
-#define _PAGE_PSIZE_2M	0x000b00
-#define _PAGE_PSIZE_4M	0x000c00
-#define _PAGE_PSIZE_8M	0x000d00
-#define _PAGE_PSIZE_16M	0x000e00
-#define _PAGE_PSIZE_32M	0x000f00
+#define _PAGE_TSIZE_4K	0x000100
 #define _PAGE_DIRTY	0x001000 /* C: page changed */
 #define _PAGE_SW0	0x002000
 #define _PAGE_U3	0x004000
@@ -46,6 +33,9 @@
 #define _PAGE_NO_CACHE	0x400000 /* I: cache inhibit */
 #define _PAGE_WRITETHRU	0x800000 /* W: cache write-through */
 
+#define _PAGE_PSIZE_SHIFT		7
+#define _PAGE_PSIZE_SHIFT_OFFSET	10
+
 /* "Higher level" linux bit combinations */
 #define _PAGE_EXEC		(_PAGE_BAP_SX | _PAGE_BAP_UX) /* .. and was cache cleaned */
 #define _PAGE_READ		(_PAGE_BAP_SR | _PAGE_BAP_UR) /* User read permission */
@@ -87,7 +77,7 @@
  * pages. We always set _PAGE_COHERENT when SMP is enabled or
  * the processor might need it for DMA coherency.
  */
-#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE_4K)
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_TSIZE_4K)
 #if defined(CONFIG_SMP)
 #define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
 #else
@@ -103,6 +93,14 @@ static inline pte_t pte_mkexec(pte_t pte)
 }
 #define pte_mkexec pte_mkexec
 
+static inline unsigned long pte_huge_size(pte_t pte)
+{
+	pte_basic_t val = pte_val(pte);
+
+	return 1UL << (((val & _PAGE_PSIZE_MSK) >> _PAGE_PSIZE_SHIFT) + _PAGE_PSIZE_SHIFT_OFFSET);
+}
+#define pte_huge_size pte_huge_size
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
-- 
2.44.0


