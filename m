Return-Path: <linux-kernel+bounces-182545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CFF8C8C79
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D4B1C232BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC49142630;
	Fri, 17 May 2024 19:01:34 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED7B13FD94
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972493; cv=none; b=doQCnhn/HfUcDVbg00mYvgcB/vRU5sHInw7ybVDnVfGtg93Q2usbypKq9zDITgo24yT3z6D0J1ZCVgnNpHG75/ZunKxSvRNPpdIdaLDFHg+dZ7r5Hm47NbcPuhnt8aMv+Xb+1us9WJPZLa7t5SIySH+alb2Hc7bVuy66QEeOG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972493; c=relaxed/simple;
	bh=uUFe3OogHVPo7wrS42BAn509SjAdI6hEiXUNXjCP0Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM27Z80cD3G3m764HihoU5Pk2BE89MObcEUm1GwinCF5zfaBlZIIxjw9auHppYGog6gaUB9grbVky0K34Jq/j+C5/vZIxFrO4NdMJcyqGVUDj2mW79KIpd5xSUpmtPxgM1ymZpktUDqzPLUCUVSuqhb/9X4tnyqFIGi51rfPGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Vgx9c50q8z9t2k;
	Fri, 17 May 2024 21:00:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6G-lIAk78RJz; Fri, 17 May 2024 21:00:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Vgx9S16kFz9t5L;
	Fri, 17 May 2024 21:00:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 21D618B766;
	Fri, 17 May 2024 21:00:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hhOBvouUQuaH; Fri, 17 May 2024 21:00:12 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.121])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9891D8B783;
	Fri, 17 May 2024 21:00:11 +0200 (CEST)
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
Subject: [RFC PATCH v2 16/20] powerpc/e500: Encode hugepage size in PTE bits
Date: Fri, 17 May 2024 21:00:10 +0200
Message-ID: <f4f76cf605b84ff60cd8cb347775a8ff2338ce18.1715971869.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715971869.git.christophe.leroy@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715972397; l=1805; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=uUFe3OogHVPo7wrS42BAn509SjAdI6hEiXUNXjCP0Kk=; b=ZgscMOKggwgeUW8ncdg8rGYCt7h02SBiakLBEZEpYpkN9wL1AvbyEIRM/zdAcHOxiTUxbvNRQ 6qrfpdtSNAjBTfOxtzk4DxhQ+HTfvJ4908nLHcsf5pB37r7rthBwVvE
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


