Return-Path: <linux-kernel+bounces-432988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B4C9E5299
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463A82845FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718F206F34;
	Thu,  5 Dec 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zto/FeYT"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69B206F29
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395142; cv=none; b=XvPj5C5lSdpnQDfY0VStXRA8/B4yM0qNRNb19M3r/x5FJUapVLo7yvDJDN8phuvC9dQw4Hxn6o4yTJeybvTTERA2Nvl3ytfqz59/2ClfRALPXojiuEXR2LjwbafuEqXGLYfNWpLJDJSbEcS3JxZqbR0qzqVeWy0wrA/4tp9A6Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395142; c=relaxed/simple;
	bh=DpO08fjIGRmuLFgPlCH9M2mTu8N/UKIsbU3j6nxBJ+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJ0NjYBDJbspws1FcCkFaBCiVxePAo5AnGvWCt7iq+ecOgJHsv7RER71Scq5dB9+QzndzX7Yufli9jeJjqTuwZddMgMkDkSzhd1R8OFk7cLtrMMxJycn7BUjZsAO2D9gEeFTLWSOKwibx+gMJjkVTdGTulOItscNJ9EF7C6pUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zto/FeYT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fc22a88bcbso610032a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395140; x=1733999940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HKGaUSlXgW0yAKeFS5JtDgO8P73Aga3Eke367yRUOM=;
        b=Zto/FeYTvrJ8EPutWjt/0l5LCn+K1XmeorPmPpQoI76MNks1abFQptonsxRVhnq53r
         XNvZtuQkHOsbO0cH9yzJVxIG429Zicw69pxCi5n+xMsXtQudCwJSrHtU/LEm57IxdzN1
         qw2xLf5MhLRy+51pxHPysw417Q3R5+nT0Tl1aWkNowUx6sYIY+ghqtUFWEtlEH5F/gTv
         FUmTRht/fyFYp1yCPPIsDJLSRyPbduZMkJ75o27mYUzpHguNDI6OC7QCLFg72w+/ngnD
         LA2cD2QlBJ5hfMzoY520VbTCp53wderlRTAofICMdOkg6c1kGsmQrhJG+bBV9wxaV65T
         q+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395140; x=1733999940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HKGaUSlXgW0yAKeFS5JtDgO8P73Aga3Eke367yRUOM=;
        b=mqpWwgGOVaW09WoKEt/9mMR/YfpsqkX+uXtPqOHSDXRB3olOh2nZ/hxRxdPsHl46N0
         EdzSap6tAt2L9fWnmwuQ0oh9Sz9h2yFCioC2U7ggV384qIo14yOcIM3uBvzzhFOHaWaO
         HgU1LscEdhWPsSm3EtZF6TSYbmVr+yTbicRyUgEYKCTdv+4QjaIPdu6lu1mcwcGl1EX7
         2eDnPd0LrJ2TYxpLu/wyjHz3gq7euLkBOt9TWLV7zlXP1vygO11kJf7YGStqARGfmlNw
         Ala4cif1FjznG4ccosiihhSERS02JCX2xMP8HIVWh8F3LOTxGCcVDrU0B0hy0G1V8sac
         FwJg==
X-Forwarded-Encrypted: i=1; AJvYcCXNrLeRz+M1W2wN+4K+O6696zNDtx+SjpYWmaP0Tw5iCT9G04VxTaZ8TPPVrh0+tlkbByRkeDG0ntxuSRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLSkfZFAKvDeOlsdtHD3+ixCRlAjO63qurD+IAVhxdKqZQF+IW
	CbG9idLMwaQVoKHS7EAKqrQo0MCzerQTw0pTj6I/MPibA95fkBPHqH47E5CNcgk=
X-Gm-Gg: ASbGncsyq7uIVWk08eXXKgSezE7uePTBnzTgEcNSex3mbJnAnQR35AiD0jXfhXiSp+x
	UaNfUrHsbJojviG4lrkS7IRPAsIKpVC4UWOUsb0FJrhS98BpTzY9XJWvs4AMxv4lZbykBYanXIE
	EWxuzcQSrTuYYMiPe/aWemX3+M6lSJ7R2MCzuWGZJVv1VVzCKbNJwNzIJaENaCxX6HPQ4GPX44E
	Y9j6yksaPkWKnkry+DoY8YOEPq07tQmWYuQjGzWKpVT4ffVFXJmITn1XRaLXl3msQeLIQ+m+/Ej
	J7pGCfqLx53f+R/hbTP0NKGLQYxarMgI
X-Google-Smtp-Source: AGHT+IENYN2wIy2LzaSrsQXEce8aC4H6FioafWLUrw0utp3p27SZ8r2YKo2I/DuxTOOKoa8IMLVh9Q==
X-Received: by 2002:a05:6a21:78a6:b0:1e0:d60c:3f49 with SMTP id adf61e73a8af0-1e165413484mr13667504637.43.1733395140137;
        Thu, 05 Dec 2024 02:39:00 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:59 -0800 (PST)
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
Subject: [RFC PATCH v2 20/21] riscv: mm: Adjust address space layout and init page table for 64K Page
Date: Thu,  5 Dec 2024 18:37:28 +0800
Message-Id: <20241205103729.14798-21-luxu.kernel@bytedance.com>
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

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/page.h    |  6 +++++-
 arch/riscv/include/asm/pgtable.h | 12 +++++++++++
 arch/riscv/mm/init.c             | 36 +++++++++++++++++++++++---------
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 9bc908d94c7a..236b0106a1c9 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -40,8 +40,12 @@
  * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address space so
  * define the PAGE_OFFSET value for SV48 and SV39.
  */
+#ifdef CONFIG_RISCV_64K_PAGES
+#define PAGE_OFFSET_L4		_AC(0xffffa80000000000, UL)
+#else
 #define PAGE_OFFSET_L4		_AC(0xffffaf8000000000, UL)
-#define PAGE_OFFSET_L3		_AC(0xffffffd600000000, UL)
+#endif /* CONFIG_RISCV_64K_PAGES */
+#define PAGE_OFFSET_L3		_AC(0xffffffd800000000, UL)
 #else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 #endif /* CONFIG_64BIT */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9f347e5eefeb..fbc397c4e1c8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -147,6 +147,18 @@ static inline unsigned long __page_val_to_pfn(unsigned long val);
 #include <asm/pgtable-32.h>
 #endif /* CONFIG_64BIT */
 
+#define __PMD_SHIFT	(PMD_SHIFT - (PAGE_SHIFT - HW_PAGE_SHIFT))
+#define __PMD_SIZE	(_AC(1, UL) << __PMD_SHIFT)
+
+#define __PUD_SHIFT	(PUD_SHIFT - (PAGE_SHIFT - HW_PAGE_SHIFT))
+#define __PUD_SIZE	(_AC(1, UL) << __PUD_SHIFT)
+
+#define __P4D_SHIFT	(P4D_SHIFT - (PAGE_SHIFT - HW_PAGE_SHIFT))
+#define __P4D_SIZE	(_AC(1, UL) << __P4D_SHIFT)
+
+#define __PGD_SHIFT	(PGD_SHIFT - (PAGE_SHIFT - HW_PAGE_SHIFT))
+#define __PGD_SIZE	(_AC(1, UL) << __PGD_SHIFT)
+
 #include <linux/page_table_check.h>
 
 #ifdef CONFIG_XIP_KERNEL
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 678b892b4ed8..2c6b7ea33009 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -695,15 +695,15 @@ static uintptr_t __meminit best_map_size(phys_addr_t pa, uintptr_t va, phys_addr
 		return PAGE_SIZE;
 
 	if (pgtable_l5_enabled &&
-	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
+	    !(pa & (__P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
 		return P4D_SIZE;
 
 	if (pgtable_l4_enabled &&
-	    !(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
+	    !(pa & (__PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
 		return PUD_SIZE;
 
 	if (IS_ENABLED(CONFIG_64BIT) &&
-	    !(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= PMD_SIZE)
+	    !(pa & (__PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= PMD_SIZE)
 		return PMD_SIZE;
 
 	return PAGE_SIZE;
@@ -937,17 +937,33 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
 				   PMD_SIZE, PAGE_KERNEL);
 }
 #else
+
+#ifdef CONFIG_RISCV_64K_PAGES
+/* TODO: better implementation */
+#define KERNEL_MAP_STEP			PAGE_SIZE
+#else
+#define KERNEL_MAP_STEP			PMD_SIZE
+#endif
+
 static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
 {
 	uintptr_t va, end_va;
 
 	end_va = kernel_map.virt_addr + kernel_map.size;
-	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE)
-		create_pgd_mapping(pgdir, va,
-				   kernel_map.phys_addr + (va - kernel_map.virt_addr),
-				   PMD_SIZE,
-				   early ?
-					PAGE_KERNEL_EXEC : pgprot_from_va(va));
+	if (early)
+		for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE)
+			create_pgd_mapping(pgdir, va,
+					   kernel_map.phys_addr + (va - kernel_map.virt_addr),
+					   PMD_SIZE,
+					   early ?
+						PAGE_KERNEL_EXEC : pgprot_from_va(va));
+	else
+		for (va = kernel_map.virt_addr; va < end_va; va += KERNEL_MAP_STEP)
+			create_pgd_mapping(pgdir, va,
+					   kernel_map.phys_addr + (va - kernel_map.virt_addr),
+					   KERNEL_MAP_STEP,
+					   early ?
+						PAGE_KERNEL_EXEC : pgprot_from_va(va));
 }
 #endif
 
@@ -1138,7 +1154,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	/* Sanity check alignment and size */
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
-	BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
+	BUG_ON((kernel_map.phys_addr % __PMD_SIZE) != 0);
 
 #ifdef CONFIG_64BIT
 	/*
-- 
2.20.1


