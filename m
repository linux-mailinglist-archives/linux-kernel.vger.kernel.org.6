Return-Path: <linux-kernel+bounces-437120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8458A9E8F54
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAB31887B85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74360216E0C;
	Mon,  9 Dec 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DCkfM/+E"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D892165E7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737883; cv=none; b=l/BO43RLU39eHKboSPM3oMath0KZJJ8UKp4opR0EergKdNcTURufHY8cA4JuSANbrR1Oly2Ztk/UxAQ8p+8xc/H2DW/2y2F+K7LYa9WFeKzMZD3Bwr82C6ck+YlNmzYcIMjzjQg74N1Nqru+y0nJ550yo80V2Y2B4afyL4fdPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737883; c=relaxed/simple;
	bh=HpdO0p0ikDlTjKHuS1rX9dIWYWqLczl/hgxV4pbyU9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MRp2P+xek9Bxn5Ct1VGfqrB+0P+Xwa2r5+l7zB3yw+1T28/e9zDW4p1iCRT80leoFiq9tA1Ol4UCfisLBwU/67JG3Ps/lVsx8HGwiNU2Z1XSC9cfsdiVdFv+tGrl6wEa2bGB9dQJzGGyenDGLd1Ig4HhFd+zf0apsvPJXCHStdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DCkfM/+E; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef748105deso1983484a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733737881; x=1734342681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lcckKnBkxwonex0rN05fDWZ2YY8G15nPOBI5Ow04occ=;
        b=DCkfM/+EUSQ+xuIVR0Lf2lVCH1cVh6gzJ0RAAThk8tPO3lgatSkQyuIkPyFGDdpkaD
         N4mmKwb4aVcQ/9OoYCRwhlhfJOZ2S6zx415tnLdvObmjqIDXBzVp+/FYvFRCsRuawy41
         yXIyIfMQZ1ZjhwqRzbYm2tbdJ0q632v9Obldx7Yb5VgTddqXJbtWrSGRAvn3WFbpwqws
         xt71S2Vt5qfPQ2ayEMY2DQFR+VQRey8b6Ovw0HllJOZBM2dhFVGOHe6aT8r0zSyjQgKS
         zwLqlCQ6H6MygrcbO7F4xrSf5QBczahzju0Orvq2YZGkCN+fVl/Juw36pVzcYAj+BKQz
         HGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737881; x=1734342681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcckKnBkxwonex0rN05fDWZ2YY8G15nPOBI5Ow04occ=;
        b=JsLzhNLTIuv6H2te0M1H5S/D5fK8LPxK2hn3ViKjcY3XWCN9y84BwcB146IbZEX8Eh
         hohtugQywSzpf0A+0aHY3cA3UtAJJ6WRBYl3M6M+XeZ6CHkQd5hW1h5XPSqAh88oOujX
         TWAgw8QpPc0yP74T0ks5TtkOghm/fVjf40yQKTRGbSCoA5fA2x9LabUU5MSJEFNiGOe5
         m2/owHsQajRZ4ySp+7YAWeMH8AO5bgIWw1KC3DiAz/14OlAoXsjPvUBEMaimkz5IemK4
         WXxH0LID60cOWo6qQMlCM+zfLj96AGknHZrvXjlW8ysRfhA8v+qBszkD36+iPQGx5ZdB
         E9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUP6kOORn3YmHNnnMOiJNdnKgF7dH2GbFDwJn0EESCHjZyiC2z9US7nyaq8CuzPR3NMuhJdnVRruRVdndM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygnp7ZXoa8kiqxWFKXNmAkv+ZphA1ud661luXBF2I+oGQXAIh+
	TpRvgAXaiyRGak3C2ErCCvba/l+Zjb4L8bxzERRFCwqso2VHInvhtNqW6iRVYz4=
X-Gm-Gg: ASbGnctKc6Z9p4JbPpwhAiahjUN+HITsGtz5S/A5VZES5WQ1i6M4Q97NolVFSRRQ22P
	uuRWEszf+BQjmnBbFMkcDRaZVozp2yONRcOs4TYPKxROrGguXSv2OGZf2aSiEbspMlFsa/iwS5F
	cHX+hU+Y4xwPnExBZJ/601qW+DxkTZhyTVM3Og8yQNGPQRQ8ivKpmOr/fz0IzrzbNcW0ZC39lex
	Xh59ZgRxLqq46NNjwZwUl8PeapFC0G3i2BziSApZaM20cON6uyvBTBTJZ+hSVSeee3ftWv8Uxjl
	Rlt/7zDB+zjqt7y9VW4dcYKgAL34kHVN
X-Google-Smtp-Source: AGHT+IHkfKdV7X6NFJu77/MTZMkJs3GSnr3friviyGuaSw/bQdYdXWzPFIgBffs3GwqK80qVdk+nPA==
X-Received: by 2002:a17:90a:c88f:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-2ef69f0b077mr20057976a91.12.1733737880950;
        Mon, 09 Dec 2024 01:51:20 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708cf3csm9459051a91.53.2024.12.09.01.51.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 01:51:20 -0800 (PST)
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
Subject: [PATCH v3] riscv: mm: Fix the out of bound issue of vmemmap address
Date: Mon,  9 Dec 2024 17:51:13 +0800
Message-Id: <20241209095113.41154-1-luxu.kernel@bytedance.com>
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
 arch/riscv/include/asm/page.h    |  4 ++++
 arch/riscv/include/asm/pgtable.h |  4 +++-
 arch/riscv/mm/init.c             | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 71aabc5c6713..a1be1adcfb85 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -123,6 +123,10 @@ struct kernel_mapping {
 extern struct kernel_mapping kernel_map;
 extern phys_addr_t phys_ram_base;
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+extern unsigned long vmemmap_start_pfn;
+#endif
+
 #define is_kernel_mapping(x)	\
 	((x) >= kernel_map.virt_addr && (x) < (kernel_map.virt_addr + kernel_map.size))
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d4e99eef90ac..e2dbd4b9a686 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -87,7 +87,9 @@
  * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
  * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
  */
-#define vmemmap		((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#define vmemmap		((struct page *)VMEMMAP_START - vmemmap_start_pfn)
+#endif
 
 #define PCI_IO_SIZE      SZ_16M
 #define PCI_IO_END       VMEMMAP_START
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0e8c20adcd98..e7c52d647f50 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -32,6 +32,9 @@
 #include <asm/numa.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#include <asm/sparsemem.h>
+#endif
 #include <asm/soc.h>
 #include <asm/tlbflush.h>
 
@@ -62,6 +65,13 @@ EXPORT_SYMBOL(pgtable_l5_enabled);
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
@@ -243,6 +253,11 @@ static void __init setup_bootmem(void)
 	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
 		phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
+		vmemmap_start_pfn = round_down(phys_ram_base, VMEMMAP_ADDR_ALIGN) >> PAGE_SHIFT;
+#endif
+
 	/*
 	 * In 64-bit, any use of __va/__pa before this point is wrong as we
 	 * did not know the start of DRAM before.
@@ -1101,6 +1116,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
 	phys_ram_base = CONFIG_PHYS_RAM_BASE;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	vmemmap_start_pfn = round_down(phys_ram_base, VMEMMAP_ADDR_ALIGN) >> PAGE_SHIFT;
+#endif
 	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
 	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 
-- 
2.20.1


