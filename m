Return-Path: <linux-kernel+bounces-432981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9976F9E5290
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51315284483
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DA41F7090;
	Thu,  5 Dec 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JjMf19Ur"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1E1F541D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395114; cv=none; b=Q0a70FEd1XHHDonCJs9/fLIJewRzcudamtqtf9aPefNRRtJGnBCCK0mJoFP+XpZTUOz9t9S5iLQWynBGIXVCcO6kTvXPinExPzhWmPo/xJ/AsGGLK24Im77NqZdyeolVz80AnmnQ5tmE9agn270I/E1fPsVfWBOYu89CfM8EuQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395114; c=relaxed/simple;
	bh=2xt5O246IYbEQQM1Fa2q3Rs7HZrYgfCnOBLIf+feb+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohGTU4atPXSwd9kVLjln/KJv9rr+2oLLP9SqegNQe6887klrPbhcg01sKpBdnorOCYvLTIzh/bB+pGWZKu564Mern7qjUGyZpJfCkn48i7CrXX1PbbVclszPs7rWZklRrt3cZlwgkRs4o6+crwQasvwnl/kRSf7+clNRC5KCna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JjMf19Ur; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724f74d6457so839676b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395112; x=1733999912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q07gCTIJJE8Xz9bnD//uUjqUF3bkJlTAdnYkbDObJk8=;
        b=JjMf19UrJpojzu/ra2B0GYngWlOpfaTnMM67JpAGGfyYtqAvD6eT8pRC/FRDFoHuw2
         4UAuyc00soi1QgqJAGh62l7RckIBcxvUuwMpX2euwxwp+ma20raT/HtE7U9K6f915fbG
         dwQ/t2T5hxQyeyycJcDeESNEtpOvF8FUzEi3R8pFJ0bGjhAF0p81WiWmzZVlitJ+sj9I
         N7mLpvj/D4V3fcZ8EJbBLAlmBINP0iKtv+7JHryiP89PcPPWdD5DftDnEJfI9gPIOLlg
         zbh5vmBURW5tu7iWcjDBk2PCTU/ZLoezG1vWP7vhjU70dSRn6G0XtSmbwKUkGjP83l/F
         mBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395112; x=1733999912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q07gCTIJJE8Xz9bnD//uUjqUF3bkJlTAdnYkbDObJk8=;
        b=PQ+Gh5Srqpjq1YXVdP6FNTEZQXMcGnrddBb6lbLBW/YrKr8sp9ry6NOI/LHKfad+q+
         wbx/EGC2J9MyS4IfA7DzaugtaQxQmyoR9L/rD2vmxM6o/EeYxuFY4se+VdBaIMY8DN7+
         RlKrEYYJqMLHDE+HkDItGTKlM/6E/jsOYVUW7Go+CkUWUldLP/EO2C+ExqZ/kTyCg+8Z
         B0KAOodixQPMEuRTMNZqOh1xM4b9jMbu9R9xwBNwak2sOwmCxxFhNjexBhUXWwgZVzPz
         BRtAFPkj5jIt4uZFR1nRPLc028B1FYe8ua5cXcvNSnpJ9dngOFhSEl7CcSv+IS8SJ4ya
         AiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK0AbrxUPihkbZb+Kxi9ZYixMOHsgfF6Ue+w91CCP8LwP06VVyWTwu4bB947r1AjrklHKvt42k3ODHEuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgeVy0Gi50qQUnEHsnJqCEJFE04cDuboAoeCQLrV0X3JOCS8WM
	kj8WpA0WkpLCjolxllKP5VVdQA6J3k2i2EJopNDae+pbrJ6wxGmKW9x1WBNhG9s=
X-Gm-Gg: ASbGncvt/mp2iG0F9ENWuCRaMhtoqlT9d6sZeSFchJ5a0xETlO0Zpo8EgNVdjfTNpxU
	tsHRyqty9kTcElYVZ7y+hPKbP59StQmiVkXBSHAs/1nGrX5rABUTU/vYDDP5hqCcIQGr4hHdizN
	zTlTVzlzae7wHQKzLhBo2LTSlrwzreVQ10CHBept9vPBLD7Fdcyn8lMleLtGkpoNgFkLq7hlXbH
	xqb8pfLgXLl2KaUsXlty1wWovn9xxuKAW/7eQS70nwQt5dyS/PNpifha7CR/qq+fMfpGUKJUb8u
	dNr1leOLXzyH3Jcf0WlYxGclKuK8LsmO
X-Google-Smtp-Source: AGHT+IG3G9tPg6qUeSO1QGI/Mdcn1uGTNUPe0Tsf/e+WSW8vxQ4wgkKlRQB0qkddigD/hXKfbzL+jQ==
X-Received: by 2002:a05:6a00:138d:b0:71e:cb5:2219 with SMTP id d2e1a72fcca58-7257fa5e7d6mr10595111b3a.9.1733395111754;
        Thu, 05 Dec 2024 02:38:31 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:31 -0800 (PST)
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
Subject: [RFC PATCH v2 13/21] riscv: mm: Adjust PGDIR/P4D/PUD/PMD_SHIFT
Date: Thu,  5 Dec 2024 18:37:21 +0800
Message-Id: <20241205103729.14798-14-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit adjusts the SHIFT of pte index bits at each page table
level.

For example, in SV39, the traditional va behaves as:

----------------------------------------------
| pgd index | pmd index | pte index | offset |
----------------------------------------------
| 38     30 | 29     21 | 20     12 | 11   0 |
----------------------------------------------

When we choose 64K as basic software page, va now behaves as:

----------------------------------------------
| pgd index | pmd index | pte index | offset |
----------------------------------------------
| 38     34 | 33     25 | 24     16 | 15   0 |
----------------------------------------------

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable-32.h |  2 +-
 arch/riscv/include/asm/pgtable-64.h | 16 ++++++++--------
 arch/riscv/include/asm/pgtable.h    | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 2959ab72f926..e0c5c62f88d9 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -11,7 +11,7 @@
 #include <linux/const.h>
 
 /* Size of region mapped by a page global directory */
-#define PGDIR_SHIFT     22
+#define PGDIR_SHIFT     (10 + PAGE_SHIFT)
 #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 2649cc90b14e..26c13484e721 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -13,9 +13,9 @@
 extern bool pgtable_l4_enabled;
 extern bool pgtable_l5_enabled;
 
-#define PGDIR_SHIFT_L3  30
-#define PGDIR_SHIFT_L4  39
-#define PGDIR_SHIFT_L5  48
+#define PGDIR_SHIFT_L3  (9 + 9 + PAGE_SHIFT)
+#define PGDIR_SHIFT_L4  (9 + PGDIR_SHIFT_L3)
+#define PGDIR_SHIFT_L5  (9 + PGDIR_SHIFT_L4)
 #define PGDIR_SHIFT     (pgtable_l5_enabled ? PGDIR_SHIFT_L5 : \
 		(pgtable_l4_enabled ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
 /* Size of region mapped by a page global directory */
@@ -23,20 +23,20 @@ extern bool pgtable_l5_enabled;
 #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
 
 /* p4d is folded into pgd in case of 4-level page table */
-#define P4D_SHIFT_L3   30
-#define P4D_SHIFT_L4   39
-#define P4D_SHIFT_L5   39
+#define P4D_SHIFT_L3   (9 + 9 + PAGE_SHIFT)
+#define P4D_SHIFT_L4   (9 + P4D_SHIFT_L3)
+#define P4D_SHIFT_L5   (9 + P4D_SHIFT_L3)
 #define P4D_SHIFT      (pgtable_l5_enabled ? P4D_SHIFT_L5 : \
 		(pgtable_l4_enabled ? P4D_SHIFT_L4 : P4D_SHIFT_L3))
 #define P4D_SIZE       (_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK       (~(P4D_SIZE - 1))
 
 /* pud is folded into pgd in case of 3-level page table */
-#define PUD_SHIFT      30
+#define PUD_SHIFT      (9 + 9 + PAGE_SHIFT)
 #define PUD_SIZE       (_AC(1, UL) << PUD_SHIFT)
 #define PUD_MASK       (~(PUD_SIZE - 1))
 
-#define PMD_SHIFT       21
+#define PMD_SHIFT       (9 + PAGE_SHIFT)
 /* Size of region mapped by a page middle directory */
 #define PMD_SIZE        (_AC(1, UL) << PMD_SHIFT)
 #define PMD_MASK        (~(PMD_SIZE - 1))
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9fa16c0c20aa..0fd9bd4e0d13 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -30,12 +30,27 @@
 /* Number of entries in the page table */
 #define PTRS_PER_PTE    (PAGE_SIZE / sizeof(pte_t))
 
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+
+/*
+ * PGDIR_SHIFT grows as PAGE_SIZE grows. To avoid va exceeds limitation, pgd
+ * index bits should be cut. Thus we use HW_PAGE_SIZE instead.
+ */
+#define __PTRS_PER_PGD	(HW_PAGE_SIZE / sizeof(pgd_t))
+#define pgd_index(a)	(((a) >> PGDIR_SHIFT) & (__PTRS_PER_PGD - 1))
+
+#define KERN_VIRT_SIZE          ((__PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
+
+#else
+
 /*
  * Half of the kernel address space (1/4 of the entries of the page global
  * directory) is for the direct mapping.
  */
 #define KERN_VIRT_SIZE          ((PTRS_PER_PGD / 2 * PGDIR_SIZE) / 2)
 
+#endif /* CONFIG_RISCV_USE_SW_PAGE */
+
 #define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
 #define VMALLOC_END      PAGE_OFFSET
 #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
@@ -1304,7 +1319,11 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * Similarly for SV57, bits 63–57 must be equal to bit 56.
  */
 #ifdef CONFIG_64BIT
+#ifdef CONFIG_RISCV_USE_SW_PAGE
+#define TASK_SIZE_64	(PGDIR_SIZE * __PTRS_PER_PGD / 2)
+#else
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
+#endif
 #define TASK_SIZE_MAX	LONG_MAX
 
 #ifdef CONFIG_COMPAT
-- 
2.20.1


