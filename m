Return-Path: <linux-kernel+bounces-432982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0139E5293
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FFC280E41
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4710F1F541D;
	Thu,  5 Dec 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Qn2kqWig"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA611FC7E7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395118; cv=none; b=uoDTVIlU6xlfmN+Jd2R4CU2EDBR2HCaDDY9DPuERkTygECrwjQtJr9RnPYpqeL8xgCiiAlc6pCmqroHZeovITRXwJ9B4XS7rH/dP4OFnxbFqMFIuyMAFonER5cvzUYvlPOYjM+umWypqaE3Y/cCTVQADFTSUryWA7kayUf6TxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395118; c=relaxed/simple;
	bh=4wlJhID0o3jWa77hDSW35GLVeQRNwf5/sMX6Ua0okEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfSUZ7VZfi8QaZL6cBhp8F3indYmxg/j3tQy9NIW9yxLmyZS839FFwoQpDKkbN5mgm587mcdwkUeQHAI32aR2vcQhAQvxX/3aoq0Y4uMw/sdG9QCe/e6U/FfYBRN3NoI5j8fRK58gZywmBqmYOm1KCXl2oECk7DaQ11Yy9dkk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Qn2kqWig; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f1ed6ee4d6so399931eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395116; x=1733999916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxSp7kmSqkSnu4KEBfrma7Z74EMZDahAlv9AUZJtR6k=;
        b=Qn2kqWig/vHxSglw3enhYJ2yjOq/zqMtLd+oxdVe4uYKpwzzJCrMctsxm95STyUBtO
         k3qxhhTBcf/32F2KBKJy5YT9m64dfx2o5SrLnIi3J1l7L4nGsIlSFSmVQvQfqnNB3FS2
         zzxpa4+zSDDY32v+Lch4rFLgIoW5qsT2TaV73BLXHkzkCAGwibuGT1/F6TrcD/eDwCEr
         MWrc2o7IayOTNCe1PML7PCuFu63DucwciX707KzwFxz7wN0GpHoV4dfpvK5xYP4XG9Je
         V7z2h+CkegE/PqVLfCUm9PPD7yBfVwVKv1L21p3TMNz7RrcyUwfTrAkwn6KvpoO91qEW
         zMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395116; x=1733999916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxSp7kmSqkSnu4KEBfrma7Z74EMZDahAlv9AUZJtR6k=;
        b=G9JwWjiG/PqZxhc3Vfh6B/XY697Hh2ZBUHfutpyNq4Na8W4tkekumjIa7HnOpNeieU
         uzs8B47K15ikoTIRdGeiaKHJwUTJBzF8i/Dtulaoe+2Y6etj7yRPQ1xHPBpfjOnlQKeC
         epRhOLc7w7pSdDr6+n1OAYiEQlT4tWje8gROP2vc8p2z2PcKmHdWzDrFttGHw9f0ew6i
         XMEQWsmHVIhslcQf+TgfE72uCuoJ9RjtHez79RMPFTK6VAWJ4qlIvGTCIw+zkIHNFx0x
         I7WxWqlLBdxRlba2p8QOyb96Xv1S7tq6frNVKXxZdfaWvljaXbBnb2Ckv6AliBKYbAsI
         06XA==
X-Forwarded-Encrypted: i=1; AJvYcCVrH+GeO9+Mk2M6UOfs5ZgPqkqZBg7Zwp/ZvQv9ba03FT54WPgFR8V6j8ZB/Zh9nKc3CYsQFw1GHwrbkIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvcNbwBS150G8yidMKFJcIbg+BEO2pF4dU46B0PGY0ofkiNddg
	lSXNKFcyh22VEZFl9cGQsIFVnEQi5VQ84mdP1g58hiCP3Px3kF9dzBxVKy3Efz4=
X-Gm-Gg: ASbGncsv3QTY1LomROOBpvvHlUq6og43FrR66Nw+7G1QPljpVa+suAP4TL+m7OYGhQt
	Pa2T6trGiBdi2q6zJ8cZsTNAp6iRAEKIC2gMZHJjCoIdErqEDfkVNObgVCIpoG3Di63mkoOI6t2
	1Cd+xBdJxGG9gSAob7Bt8AGME2WAJQCF+5gjyOhhj5WAhQKHDWTvNqz8s6TRWrKh0EOnqG9oWPP
	iwqfMPIeaSyW/bCyAuUhHbdkqOG1GpjSLCI8WrwD2cQ3zRffcoirfTFLl/D3t5S1g/cgQAZBW1M
	Y6tA6mwZaEnu2NmyeihpZdk9Ovrho8OQ
X-Google-Smtp-Source: AGHT+IGAja+xIu0LL2xTFT4mUl3KDqN8KlPjYMDJCXFuXRD/rOHFiqKg6itfbSNH2M80yhGpilt+dg==
X-Received: by 2002:a05:6830:4882:b0:71d:6272:862f with SMTP id 46e09a7af769-71dad6d401bmr10590081a34.22.1733395115810;
        Thu, 05 Dec 2024 02:38:35 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:35 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 14/21] riscv: mm: Only apply svnapot region bigger than software page
Date: Thu,  5 Dec 2024 18:37:22 +0800
Message-Id: <20241205103729.14798-15-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usually, when it comes to napot pte order, we refer to the order of
software page number. Thus, this commit updates the napot order
calculation method. Also, we only apply svnapot pte as huge pte when its
napot size is bigger than software page.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable-64.h | 21 +++++++++---
 arch/riscv/include/asm/pgtable.h    | 50 +++++++++++++++++++++++------
 arch/riscv/mm/hugetlbpage.c         |  7 ++--
 3 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 26c13484e721..fbdaad9a98dd 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -124,12 +124,23 @@ enum napot_cont_order {
 	NAPOT_ORDER_MAX,
 };
 
+#define NAPOT_PAGE_ORDER_BASE							\
+	((NAPOT_CONT_ORDER_BASE >= (PAGE_SHIFT - HW_PAGE_SHIFT)) ?		\
+	 (NAPOT_CONT_ORDER_BASE - (PAGE_SHIFT - HW_PAGE_SHIFT)) : 1)
+#define NAPOT_PAGE_ORDER_MAX							\
+	((NAPOT_ORDER_MAX > (PAGE_SHIFT - HW_PAGE_SHIFT)) ?			\
+	 (NAPOT_ORDER_MAX - (PAGE_SHIFT - HW_PAGE_SHIFT)) :			\
+	 NAPOT_PAGE_ORDER_BASE)
+
 #define for_each_napot_order(order)						\
-	for (order = NAPOT_CONT_ORDER_BASE; order < NAPOT_ORDER_MAX; order++)
+	for (order = NAPOT_PAGE_ORDER_BASE;					\
+		order < NAPOT_PAGE_ORDER_MAX; order++)
 #define for_each_napot_order_rev(order)						\
-	for (order = NAPOT_ORDER_MAX - 1;					\
-	     order >= NAPOT_CONT_ORDER_BASE; order--)
-#define napot_cont_order(val)	(__builtin_ctzl((pte_val(val) >> _PAGE_PFN_SHIFT) << 1))
+	for (order = NAPOT_PAGE_ORDER_MAX - 1;					\
+		order >= NAPOT_PAGE_ORDER_BASE; order--)
+#define napot_cont_order(val)							\
+	(__builtin_ctzl((pte_val(val) >> _PAGE_HWPFN_SHIFT) << 1) -		\
+		(PAGE_SHIFT - HW_PAGE_SHIFT))
 
 #define napot_cont_shift(order)	((order) + PAGE_SHIFT)
 #define napot_cont_size(order)	BIT(napot_cont_shift(order))
@@ -137,7 +148,7 @@ enum napot_cont_order {
 #define napot_pte_num(order)	BIT(order)
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-#define HUGE_MAX_HSTATE		(2 + (NAPOT_ORDER_MAX - NAPOT_CONT_ORDER_BASE))
+#define HUGE_MAX_HSTATE		(2 + (NAPOT_ORDER_MAX - NAPOT_PAGE_ORDER_BASE))
 #else
 #define HUGE_MAX_HSTATE		2
 #endif
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0fd9bd4e0d13..07d557bc8b39 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -130,7 +130,7 @@
 #include <asm/compat.h>
 
 #define __page_val_to_hwpfn(_val)  (((_val) & _PAGE_HW_PFN_MASK) >> _PAGE_HWPFN_SHIFT)
-#define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
+static inline unsigned long __page_val_to_pfn(unsigned long val);
 
 #ifdef CONFIG_64BIT
 #include <asm/pgtable-64.h>
@@ -470,15 +470,42 @@ static inline unsigned long pte_napot(pte_t pte)
 	return __pte_napot(pte_val(pte));
 }
 
-static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
+static inline unsigned long __pte_mknapot(unsigned long pteval,
+					  unsigned int order)
 {
 	int pos = order - 1 + _PAGE_PFN_SHIFT;
 	unsigned long napot_bit = BIT(pos);
-	unsigned long napot_mask = ~GENMASK(pos, _PAGE_PFN_SHIFT);
+	unsigned long napot_mask = ~GENMASK(pos, _PAGE_HWPFN_SHIFT);
+
+	BUG_ON(__pte_napot(pteval));
+	pteval = (pteval & napot_mask) | napot_bit | _PAGE_NAPOT;
 
-	return __pte((pte_val(pte) & napot_mask) | napot_bit | _PAGE_NAPOT);
+	return pteval;
 }
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
+{
+	unsigned long pteval = pte_val(pte);
+	unsigned int i;
+
+	pteval = __pte_mknapot(pteval, order);
+	for (i = 0; i < HW_PAGES_PER_PAGE; i++)
+		pte.ptes[i] = pteval;
+
+	return pte;
+}
+#else
+static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
+{
+	unsigned long pteval = pte_val(pte);
+
+	pte_val(pte) = __pte_mknapot(pteval, order);
+
+	return pte;
+}
+#endif /* CONFIG_RISCV_USE_SW_PAGE */
+
 #else
 
 static __always_inline bool has_svnapot(void) { return false; }
@@ -495,15 +522,20 @@ static inline unsigned long pte_napot(pte_t pte)
 
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
-/* Yields the page frame number (PFN) of a page table entry */
-static inline unsigned long pte_pfn(pte_t pte)
+static inline unsigned long __page_val_to_pfn(unsigned long pteval)
 {
-	unsigned long res  = __page_val_to_pfn(pte_val(pte));
+	unsigned long res = __page_val_to_hwpfn(pteval);
 
-	if (has_svnapot() && pte_napot(pte))
+	if (has_svnapot() && __pte_napot(pteval))
 		res = res & (res - 1UL);
 
-	return res;
+	return hwpfn_to_pfn(res);
+}
+
+/* Yields the page frame number (PFN) of a page table entry */
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return __page_val_to_pfn(pte_val(pte));
 }
 
 #define pte_page(x)     pfn_to_page(pte_pfn(x))
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 8896c28ec881..4286c7dea68d 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -212,7 +212,7 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 			break;
 		}
 	}
-	if (order == NAPOT_ORDER_MAX)
+	if (order == NAPOT_PAGE_ORDER_MAX)
 		entry = pte_mkhuge(entry);
 
 	return entry;
@@ -405,7 +405,8 @@ static __init int napot_hugetlbpages_init(void)
 		unsigned long order;
 
 		for_each_napot_order(order)
-			hugetlb_add_hstate(order);
+			if (napot_cont_shift(order) > PAGE_SHIFT)
+				hugetlb_add_hstate(order);
 	}
 	return 0;
 }
@@ -426,7 +427,7 @@ static bool __hugetlb_valid_size(unsigned long size)
 		return true;
 	else if (IS_ENABLED(CONFIG_64BIT) && size == PUD_SIZE)
 		return true;
-	else if (is_napot_size(size))
+	else if (is_napot_size(size) && size > PAGE_SIZE)
 		return true;
 	else
 		return false;
-- 
2.20.1


