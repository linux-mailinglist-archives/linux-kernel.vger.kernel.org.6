Return-Path: <linux-kernel+bounces-189633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB7C8CF30C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4A0282698
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE062D530;
	Sun, 26 May 2024 09:23:30 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A01863E
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716715410; cv=none; b=EjmaYMHX9GZsY3ga0houNq3QX7QeibW5WnD/qa5Ab9MSJs3VQs3vrOBoNaAznkaIv5V+t/AinPj8xP/MftDmYhNbEPve45ZnzAaa80D9mtQOR46rddf6kXhAxXh+Zn4x82XJIFcJD/sw85NB9Z4GJwSPovx29eg6HOGuVw41gdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716715410; c=relaxed/simple;
	bh=uUFe3OogHVPo7wrS42BAn509SjAdI6hEiXUNXjCP0Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fnyn3b5RNrYitPF0PoUzklfqcJtven/Zjj2f9AerTViNoFyZaa35dGX5w9duYNMyKz24iqu5FtxTJFtjdncRIIlndgZ9YhYdVIvu4trWTpdben/frfdvrZUCHOOQr+o3ysd9HR1ihduTsNhqtq9K4cYB5+p5JI18vV3A1DNbit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VnCwv0kMWz9tHF;
	Sun, 26 May 2024 11:22:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9YGwzvM-m0fS; Sun, 26 May 2024 11:22:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VnCwp2xr0z9tBX;
	Sun, 26 May 2024 11:22:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 608D68B764;
	Sun, 26 May 2024 11:22:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id fjdv1aG4p4qU; Sun, 26 May 2024 11:22:34 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.45])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DB6D58B774;
	Sun, 26 May 2024 11:22:33 +0200 (CEST)
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
Subject: [RFC PATCH v3 12/16] powerpc/e500: Encode hugepage size in PTE bits
Date: Sun, 26 May 2024 11:22:32 +0200
Message-ID: <2e3e288c9da4fbd93ac969cbe52e4d21dde9447a.1716714720.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716714720.git.christophe.leroy@csgroup.eu>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716715344; l=1805; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=uUFe3OogHVPo7wrS42BAn509SjAdI6hEiXUNXjCP0Kk=; b=0VE6/MIIw3LtsvUaB3hlFPyS6z55V8+XLyM9sC0pCdjaXqpmIinylhvukexSuqzpM9hETAR3t 7h85EAdAFyABY7cWUxMvj9FTDKdXkh845ms4dvcWW6NM2YcRBGtfw7O
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Use U0-U3 bits to encode hugepage size, more exactly page shift.

As we start using hugepages at shift 21 (2Mbytes), substract 20
so that it fits into 4 bits. That may change in the future if
we want to use smaller hugepages.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/hugetlb-e500.h | 6 ++++++
 arch/powerpc/include/asm/nohash/pte-e500.h     | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/hugetlb-e500.h b/arch/powerpc/include/asm/nohash/hugetlb-e500.h
index 8f04ad20e040..d8e51a3f8557 100644
--- a/arch/powerpc/include/asm/nohash/hugetlb-e500.h
+++ b/arch/powerpc/include/asm/nohash/hugetlb-e500.h
@@ -42,4 +42,10 @@ static inline int check_and_get_huge_psize(int shift)
 	return shift_to_mmu_psize(shift);
 }
 
+static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
+{
+	return __pte(pte_val(entry) | (_PAGE_U3 * (shift - 20)));
+}
+#define arch_make_huge_pte arch_make_huge_pte
+
 #endif /* _ASM_POWERPC_NOHASH_HUGETLB_E500_H */
diff --git a/arch/powerpc/include/asm/nohash/pte-e500.h b/arch/powerpc/include/asm/nohash/pte-e500.h
index 975facc7e38e..091e4bff1fba 100644
--- a/arch/powerpc/include/asm/nohash/pte-e500.h
+++ b/arch/powerpc/include/asm/nohash/pte-e500.h
@@ -46,6 +46,9 @@
 #define _PAGE_NO_CACHE	0x400000 /* I: cache inhibit */
 #define _PAGE_WRITETHRU	0x800000 /* W: cache write-through */
 
+#define _PAGE_HSIZE_MSK (_PAGE_U0 | _PAGE_U1 | _PAGE_U2 | _PAGE_U3)
+#define _PAGE_HSIZE_SHIFT	14
+
 /* "Higher level" linux bit combinations */
 #define _PAGE_EXEC		(_PAGE_BAP_SX | _PAGE_BAP_UX) /* .. and was cache cleaned */
 #define _PAGE_READ		(_PAGE_BAP_SR | _PAGE_BAP_UR) /* User read permission */
-- 
2.44.0


