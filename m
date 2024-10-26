Return-Path: <linux-kernel+bounces-383318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E1E9B1A01
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E071C21484
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CD51D90A9;
	Sat, 26 Oct 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rzmbx2Hs"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A721D79B8
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962894; cv=none; b=bacqxQEpLz4fArbQmlISrrxA0UTVNWP4Lw/C2KB58NoTwxpUSTNnpW45DviOFK4CIG4BTNCVxB4g8YLHXz3E/g84thBfZdl5W1RWQEBqeEgV1cgrSROQEmplChiHwIu7/AmRnhOnwWfBpBAC6T0D9SJ9sRkGs6b5edEpmV9s+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962894; c=relaxed/simple;
	bh=6v/2B5pS1NQbKcx4Aq5/VZ8a+qebWC56UpnkfHq3Es8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuwHJf+HhGM1ZDLljhZ3AoPyqTZqWb4zIDRY5R5/RADlvhu/qfRp1f3IUAOzAVa9k/OXtE7JB2jzPB72WDIt668HRTMhFVJQXi1FfINWppRCcaFjQtwMXRV3kVMdsB6mnW4zbiAqHolR87vsxTVQFRv+z0rEETUJS5XPEGFjc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Rzmbx2Hs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso2429962a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729962891; x=1730567691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iilPE9PRtO5dgnEVdYwMDgO0cR2NihKQ5GAqyVmi0I=;
        b=Rzmbx2Hs+kYbN/koVQwfBMju+R1WhWRIswEM/1mAWdcNPP8bBcTwAAtCtR8lR1XZD9
         oL21rAiDAGK3Bm0PC9Rr35EWIg9ckg7hTo2KzSJPY/w6iRGorYKXC+8UiO20ULTAnFrs
         tSVqCvZ9ogvcD8IndvxuqxtrhwkT9BT4KFrcyzRxwH0+3HSNVS36L2AOdRHznLUJqxRF
         i4lgmxToW8xCHEx/0bP+cvOSSvXdPeCeGERDC0HVWlWaELDwKnoqQ17pZzigFXMy/1lg
         eW9XUH5A2MxaBQv7Va4dZwaBjz5ZtsjXJCdr84BtKF1wcsKRjJ13e5GS6CpQO6cpPB9r
         h+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729962891; x=1730567691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iilPE9PRtO5dgnEVdYwMDgO0cR2NihKQ5GAqyVmi0I=;
        b=Rjy6YPYh5aef6rIdS7C51shDnCGK8tAQJi+Pez+XEm1JBHC+CE6vDNdYKB/XHU87LQ
         zEm2MCsF0apmW+n1LVyF6/Wkf/McP87YmRq7hvGVpdp9iu9WzmOoo97TbK9WAzHQnM3T
         DRdctvZ61NSS3bc4pGYFbEu1aeVKjXaZIfheYt0V5Aap83RJi2BQwu8+Z/vYdRbM9IBO
         EoAk2vZpuutOJ8BFmJcX8P14rbbQ2bl5GhphKwJ4tsUjj3r+A3gUwX7EWID3Wvu/NeXX
         dtbu/KiqDjHQe6cS3K9KU6f0mZxJaNRYd4bAuOZ+2d0EjOlVIB1+TN+zI2zXs5OlT5yC
         /26A==
X-Forwarded-Encrypted: i=1; AJvYcCVPOIM2Od2wQd7PBVzgh6BwDKtAcUoajfzeOrLuHWoo5wMSBCnPmN+RN42m7lnLRT4WBI9lRHQU8kcYJ7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDHU8n56lERvOU47SBQ9JRaWxmtnn8bYCT8uKmfQlzvSAnc8G
	Qr4+z7y75PXmyg1jQOy4SVJxe+7a52BjFhkqxAqITTKJ/XMfzdAdWycnJ3hejdE=
X-Google-Smtp-Source: AGHT+IHKHWEssFZ3dU4bK/XFfhtDHlaKTxMDsGGVAwitWxfjevjp7X7a3fieuNlFSdnYzB2SDFDTOA==
X-Received: by 2002:a17:90a:3d0a:b0:2e2:c252:f861 with SMTP id 98e67ed59e1d1-2e8f10a7298mr4016154a91.28.1729962891258;
        Sat, 26 Oct 2024 10:14:51 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e558114sm5663762a91.36.2024.10.26.10.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 10:14:50 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 6/6] riscv: Remove CONFIG_PAGE_OFFSET
Date: Sat, 26 Oct 2024 10:13:58 -0700
Message-ID: <20241026171441.3047904-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241026171441.3047904-1-samuel.holland@sifive.com>
References: <20241026171441.3047904-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current definition of CONFIG_PAGE_OFFSET is problematic for a couple
of reasons:
 1) The value is misleading for normal 64-bit kernels, where it is
    overridden at runtime if Sv48 or Sv39 is chosen. This is especially
    the case for XIP kernels, which always use Sv39.
 2) The option is not user-visible, but for NOMMU kernels it must be a
    valid RAM address, and for !RELOCATABLE it must additionally be the
    exact address where the kernel is loaded.

Fix both of these by removing the option.
 1) For MMU kernels, drop the indirection through Kconfig. Additionally,
    for XIP, drop the indirection through kernel_map.
 2) For NOMMU kernels, use the user-visible physical RAM base if
    provided. Otherwise, force the kernel to be relocatable.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Kconfig               |  8 +-------
 arch/riscv/include/asm/page.h    | 15 ++++++++-------
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/riscv/mm/init.c             |  8 ++------
 4 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 33aa79d84021..297ccbf4b5ce 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -195,6 +195,7 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if (ACPI && PCI)
 	select PCI_MSI if PCI
+	select RELOCATABLE if !MMU && !PHYS_RAM_BASE_FIXED
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
 	select RISCV_APLIC
 	select RISCV_IMSIC
@@ -282,13 +283,6 @@ config MMU
 	  Select if you want MMU-based virtualised addressing space
 	  support by paged memory management. If unsure, say 'Y'.
 
-config PAGE_OFFSET
-	hex
-	default 0x80000000 if !MMU && RISCV_M_MODE
-	default 0x80200000 if !MMU
-	default 0xc0000000 if 32BIT
-	default 0xff60000000000000 if 64BIT
-
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN_GENERIC
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 24d1ac052609..d1acd1efe0dc 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -28,15 +28,16 @@
  */
 #ifdef CONFIG_MMU
 #ifdef CONFIG_64BIT
-#define PAGE_OFFSET		kernel_map.page_offset
-/*
- * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address space so
- * define the PAGE_OFFSET value for SV48 and SV39.
- */
+#define PAGE_OFFSET_L5		_AC(0xff60000000000000, UL)
 #define PAGE_OFFSET_L4		_AC(0xffffaf8000000000, UL)
 #define PAGE_OFFSET_L3		_AC(0xffffffd600000000, UL)
+#ifdef CONFIG_XIP_KERNEL
+#define PAGE_OFFSET		PAGE_OFFSET_L3
 #else
-#define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
+#define PAGE_OFFSET		kernel_map.page_offset
+#endif /* CONFIG_XIP_KERNEL */
+#else
+#define PAGE_OFFSET		_AC(0xc0000000, UL)
 #endif /* CONFIG_64BIT */
 #else
 #define PAGE_OFFSET		((unsigned long)phys_ram_base)
@@ -100,7 +101,6 @@ typedef struct page *pgtable_t;
 #define ARCH_PFN_OFFSET		(PFN_DOWN((unsigned long)phys_ram_base))
 
 struct kernel_mapping {
-	unsigned long page_offset;
 	unsigned long virt_addr;
 	unsigned long virt_offset;
 	uintptr_t phys_addr;
@@ -114,6 +114,7 @@ struct kernel_mapping {
 	uintptr_t xiprom;
 	uintptr_t xiprom_sz;
 #else
+	unsigned long page_offset;
 	unsigned long va_kernel_pa_offset;
 #endif
 };
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d0190ee9b2e4..b8125c3aa85d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -15,7 +15,7 @@
 #ifdef CONFIG_RELOCATABLE
 #define KERNEL_LINK_ADDR	UL(0)
 #else
-#define KERNEL_LINK_ADDR	_AC(CONFIG_PAGE_OFFSET, UL)
+#define KERNEL_LINK_ADDR	_AC(CONFIG_PHYS_RAM_BASE, UL)
 #endif
 #define KERN_VIRT_SIZE		(UL(-1))
 #else
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0aad925848a4..a1a185e6faf0 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -843,6 +843,8 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
 	uintptr_t set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
 	u64 satp_mode_cmdline = __pi_set_satp_mode_from_cmdline(dtb_pa);
 
+	kernel_map.page_offset = PAGE_OFFSET_L5;
+
 	if (satp_mode_cmdline == SATP_MODE_57) {
 		disable_pgtable_l5();
 	} else if (satp_mode_cmdline == SATP_MODE_48) {
@@ -1090,11 +1092,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.virt_addr = KERNEL_LINK_ADDR + kernel_map.virt_offset;
 
 #ifdef CONFIG_XIP_KERNEL
-#ifdef CONFIG_64BIT
-	kernel_map.page_offset = PAGE_OFFSET_L3;
-#else
-	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
-#endif
 	kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
 	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
@@ -1106,7 +1103,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.va_kernel_xip_data_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr
 						+ (uintptr_t)&_sdata - (uintptr_t)&_start;
 #else
-	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 	kernel_map.phys_addr = (uintptr_t)(&_start);
 	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
-- 
2.45.1


