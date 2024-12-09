Return-Path: <linux-kernel+bounces-437481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26509E93DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9551164153
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0242236FD;
	Mon,  9 Dec 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AZuE/FHY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65A2236E5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747186; cv=none; b=WgRkj+6v+QsullX12na5H5jeUzc5aPf1nHnp88chXJBA53OvNogbwjj1YUyAnhXLLCHLJ9Rks9xPYluYgcUyiI986RmKDMmnvL9uEBoENnSPUkwdS1vEcrQ6Cz1K2P+A+K8PX6P6rzNYfxbjnjflNnKI0+mwDVWMpPXWv6kDFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747186; c=relaxed/simple;
	bh=ALBimcnbqk697UM83yKCxcwHYxQDDpnxBvP5j3NscJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lo/7Pvsua/0+eZ3IBBKEU1JR7Jxj1H/93iGhWbthnHtTTWlsW/sO+74l+6qLflHqErzvxTaB9NmQIJptmk3SFyuvTybEN7R7UVrZkvZH4miIGrPj7bBhBboG8SA7+i5cXTHZCu3Qu/tjVuGxE0XZ9Nfaj2j1s6FybiXNfZmuBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AZuE/FHY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216585cbe1eso6366615ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733747184; x=1734351984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=adtW4yhwyBOkoWat2M6vNhXJayXsjhP2L4IIfgg3CNM=;
        b=AZuE/FHYNFJNxgu/MLoL6bnVTfqQcKT8mZtt5G/tcYiWK1a7jMWlt/Cx+yKf2U6s5L
         2VhK8I8ieNm2s/aR6O6bRl0w0xDyWhdqIvlUvKXlzu88gA8mohmJAeSMu71Vc7NEZNUP
         QR+3a4jeYnwX9dyyiGTs2+cJF2D63HgZ48U1BVsy3vYCRhQxom8DCoo/Bm1UiYM8AdNb
         Kh7xrbRVPZBFZYsZ7fakTA3xp4hqepkgkuawKoQ6vBSuZFEPTGoDGLUFzlPBvLJ+sXeE
         J1UhjOnvDhaBGHc6FpZxwQOMvngPRc3CUOddar8grTlLSKAzZT7gN4HYfxs9sfscJA6z
         qBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747184; x=1734351984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adtW4yhwyBOkoWat2M6vNhXJayXsjhP2L4IIfgg3CNM=;
        b=AND0qdU5iO/BHXN7akU++GB8C2hNe6AhzFNewKdSlbIuyxE8+ASZ7VjBFsUH4PxuX7
         ebR4r31GWTj5LBlAgOy2ea+qaV2F/qxbKtFVHBMPfcERvyi4LWgT3OkweHWcQCyTwrGY
         8hbc9wZAx5bTbeQANOQf+P9Pqje13iNHkHdbYO9R8If+fRm+EZyHIzLxkREyWDN0M2wP
         bObVuXYNYlPKkZjeAQkaskDSx2bGPq860QcPHPQ33lGBdJ3eJwN8IHJWocJQR9oiKGSE
         gOvT9EkGh1DvZj0QSmdDZtPZNDRWq2OQrz/BLsYluVchrtbPaCg2WRNyj49koS5GTnYt
         m55g==
X-Forwarded-Encrypted: i=1; AJvYcCVns3pdo5u3bUlzsNxSOQ43xpw7rNL8lJsoIZtM/fMo2Cna9SbnqpG4Rnj6kSSzWEp1ly9pfJNvD5EF+Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCEBIgRlpYJYe7rLQw+aaCEAyo/f6mYRXw5n31Iw4212oU94YE
	WUo6XfzxW9DCUDw8BEYAywktVNd5IPTPQneLcZY0va6IoK5RXVTZCj5WZVr171g=
X-Gm-Gg: ASbGncutSujDuuXf6ivkRDQSRnjdK7tXaU5HRPpk/F9wASv0AVm9PdpfTOcj2ATjWE0
	jDC+/3hMJrfwc6TFP/7FYQLbfTE5kY2nrXa5alo2B4Tl3HNgN9GBgBlKrJwMG6jZrpyEKM5cjBS
	egaOzWapfRaSyU/P3R0hLtglxzqlXIrgni3ZxYytpdEKHIIf4so/EjF/t7I395trOWoGVaX+lp1
	LTW3+YJYphpEBwaLAft5xkGqyFQNYtsNENvEzRgd9BbIui7UhXAPr7LUUEE3ijj5YFY1ZFqmON1
	8Bo317n6qKyphGv7bE7EHi3Pn96H7isW
X-Google-Smtp-Source: AGHT+IEkfqOSMeyV1p1/Cuhjrl7T8ZPCluyO93B+ezN3zdW8K/wnCYdgb3FXmHnAi6yiGokVDtfhww==
X-Received: by 2002:a17:902:ccc1:b0:216:4e8d:4803 with SMTP id d9443c01a7336-2166a03c862mr3381875ad.42.1733747183831;
        Mon, 09 Dec 2024 04:26:23 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21638d87ca1sm28386325ad.171.2024.12.09.04.26.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 04:26:23 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	bjorn@rivosinc.com
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v4] riscv: mm: Fix the out of bound issue of vmemmap address
Date: Mon,  9 Dec 2024 20:26:17 +0800
Message-Id: <20241209122617.53341-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sparse vmemmap model, the virtual address of vmemmap is calculated as:
((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)).
And the struct page's va can be calculated with an offset:
(vmemmap + (pfn)).

However, when initializing struct pages, kernel actually starts from the
first page from the same section that phys_ram_base belongs to. If the
first page's physical address is not (phys_ram_base >> PAGE_SHIFT), then
we get an va below VMEMMAP_START when calculating va for it's struct page.

For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, the
first page in the same section is actually pfn 0x80000. During
init_unavailable_range(), we will initialize struct page for pfn 0x80000
with virtual address ((struct page *)VMEMMAP_START - 0x2000), which is
below VMEMMAP_START as well as PCI_IO_END.

This commit fixes this bug by introducing a new variable
'vmemmap_start_pfn' which is aligned with memory section size and using
it to calculate vmemmap address instead of phys_ram_base.

Fixes: a11dd49dcb93 ("riscv: Sparse-Memory/vmemmap out-of-bounds fix")
Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/page.h    |  1 +
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/riscv/mm/init.c             | 17 ++++++++++++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 71aabc5c6713..125f5ecd9565 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -122,6 +122,7 @@ struct kernel_mapping {
 
 extern struct kernel_mapping kernel_map;
 extern phys_addr_t phys_ram_base;
+extern unsigned long vmemmap_start_pfn;
 
 #define is_kernel_mapping(x)	\
 	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d4e99eef90ac..050fdc49b5ad 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -87,7 +87,7 @@
  * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
  * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
  */
-#define vmemmap		((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
+#define vmemmap		((struct page *)VMEMMAP_START - vmemmap_start_pfn)
 
 #define PCI_IO_SIZE      SZ_16M
 #define PCI_IO_END       VMEMMAP_START
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0e8c20adcd98..d93271cb97b1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -33,6 +33,7 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 #include <asm/soc.h>
+#include <asm/sparsemem.h>
 #include <asm/tlbflush.h>
 
 #include "../kernel/head.h"
@@ -62,6 +63,13 @@ EXPORT_SYMBOL(pgtable_l5_enabled);
 phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define VMEMMAP_ADDR_ALIGN	(1ULL << SECTION_SIZE_BITS)
+
+unsigned long vmemmap_start_pfn __ro_after_init;
+EXPORT_SYMBOL(vmemmap_start_pfn);
+#endif
+
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 							__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
@@ -240,8 +248,12 @@ static void __init setup_bootmem(void)
 	 * Make sure we align the start of the memory on a PMD boundary so that
 	 * at worst, we map the linear mapping with PMD mappings.
 	 */
-	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
+	if (!IS_ENABLED(CONFIG_XIP_KERNEL)) {
 		phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+		vmemmap_start_pfn = round_down(phys_ram_base, VMEMMAP_ADDR_ALIGN) >> PAGE_SHIFT;
+#endif
+	}
 
 	/*
 	 * In 64-bit, any use of __va/__pa before this point is wrong as we
@@ -1101,6 +1113,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
 	phys_ram_base = CONFIG_PHYS_RAM_BASE;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	vmemmap_start_pfn = round_down(phys_ram_base, VMEMMAP_ADDR_ALIGN) >> PAGE_SHIFT;
+#endif
 	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
 	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 
-- 
2.20.1


