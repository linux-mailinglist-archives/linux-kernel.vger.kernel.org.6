Return-Path: <linux-kernel+bounces-269086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C34942D65
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FB5B240A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BD71AD9E0;
	Wed, 31 Jul 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg17DCcH"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB41A8BEF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425966; cv=none; b=UKd7+5pXDliN79jdorV+j67letzgYybM3erd7NKl3uaZYDSUdtzSY/lXAZRm+sc9eHGlQSLvPOVKKv7u5jACsjXLvT5q5UdsCnYAMFwmo0NFWFFJ5q3dZf4uHfBPcfG9okb6K9M/9RTR0UiSC9Nv460H4q416R2i17wfPbglc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425966; c=relaxed/simple;
	bh=VbX8lSJGqSUaTBoWiEIuWZU1AG6jJ+f+6PDE3s72Xm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgBY4SUFduhgNnhSdBCooMN1tC45GePoSfVY/OEiMnSsE5utb/FZXL/xMtVgsDsb/wxC4/U7OD5wWhqnO8naNRPQm7myuxtjG91R0uMD1f9dzBG4IE00r2FyB23T61ZtlUFIJK2B6k1FnH52FQKMx6K6ZiqXqLIXLUlZnGqjDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg17DCcH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1c655141so4118698b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722425964; x=1723030764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLclCjvWmzDVskwplMLBw1uSn78KDC7EwkI18+XKFCg=;
        b=dg17DCcH79kw3pLouCU/se7r/OAHB2/9LQnUao9DqwuFDl5Ubl6PQ1JNvakr7vXXAU
         MC1TMpFebLMkwrIUkLfUnxGGva8H1lKDwnUe+w8+R2JAgODtTGQ53LojLREOTZr9XwZV
         MQaS40ni2klLhuB+s3lxOTH1hmurNA3JsQiATPDl2h7QmxnGlIzL+s6G2EofpkeIdtX6
         eZrSEwfHhS2HKyJWbNnKQsCZ11mMSjFF9fodZi2AiqC5cGozlhnfULQSD6+g3tQuQiFn
         +cnCXw99nkXSrMsYOnHqAT7G1zhXSnAshlEw9FORB9SoLYtIwzLZrRw5iJkzm5Q4nVz/
         csgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722425964; x=1723030764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLclCjvWmzDVskwplMLBw1uSn78KDC7EwkI18+XKFCg=;
        b=lXOy3i+n9OgwEB1IOazYweoMDCFazQsKkcb2vj7lREEQnvUBG/emT5iDLXOUKBWWaq
         GeB4NguTQmRLDUXUKHZTiIIhnu8bhmzAPQCDBn38quz3+GxJ4IEGBrZgnkNbXR87K//s
         NbX1CR7nbqBG2USRzegAWXpn4ftzB3lzPGjrKM8OxudOnglFl4qmOrYqgaTEmkqrHiVD
         04EQFJprVtkTbTlaYFVrcdpsx1zyXESK/1M5W1wuWC9a3AYok8qqe+ffzeBTguG0acpf
         LL3MXSqSR8iJMoEZvBiQmrEUCOaDOpxvGnQjDy1OtPJhhAY88st0dMNjdwGX8cb87Qbb
         hHYw==
X-Forwarded-Encrypted: i=1; AJvYcCUXnK23uNcD2OvbPA9JQ8OqzZvdweod1PRvfymq3GwyuoGyIic6np8cmWyPkijNhZhd/Y4CdpwmmapUqSr+V4UyUigwsRfzV/Z6TZCh
X-Gm-Message-State: AOJu0Yx9/0mt2HddmrEWfRkUeEi+ZfG9QRaWo5dSd283rBiW/5JHkfYj
	ih0x8xRVU/tVmOwCmvdJuWF7eFunKVTesgY5/kcGajw6YeVW7p7P
X-Google-Smtp-Source: AGHT+IEC2QxBU4qtJWH66S0e//PI9jURHmJfotISS0SZIVdP3MgLEpncrKN9daK8Bt/bNO4NKaaq9Q==
X-Received: by 2002:a05:6a20:7354:b0:1bd:1d6e:d444 with SMTP id adf61e73a8af0-1c4a118279emr13946423637.2.1722425963927;
        Wed, 31 Jul 2024 04:39:23 -0700 (PDT)
Received: from alif.. ([14.195.28.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e15d7sm9748343b3a.22.2024.07.31.04.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 04:39:23 -0700 (PDT)
From: Harith George <mail2hgg@gmail.com>
To: linus.walleij@linaro.org,
	linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: harith.g@alifsemi.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	rmk+kernel@armlinux.org.uk,
	m.szyprowski@samsung.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	willy@infradead.org,
	nico@fluxnic.net,
	ardb@kernel.org
Subject: [PATCH 1/2] arm: mm: Fix kernel memory mapping for xip kernels
Date: Wed, 31 Jul 2024 17:09:04 +0530
Message-Id: <20240731113905.3326586-1-mail2hgg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harith George <harith.g@alifsemi.com>

The patchset introducing kernel_sec_start/end variables to separate the
kernel/lowmem memory mappings, broke the mapping of the kernel memory
for xipkernels.

kernel_sec_start/end variables are in RO area before the MMU is switched
on for xipkernels.
So these cannot be set early in boot in head.S. Fix this by setting these
after MMU is switched on.
xipkernels need two different mappings for kernel text (starting at
CONFIG_XIP_PHYS_ADDR) and data (starting at CONFIG_PHYS_OFFSET).
Also, move the kernel code mapping from devicemaps_init() to map_kernel().

Fixes: a91da5457085 ("ARM: 9089/1: Define kernel physical section start and end")
Signed-off-by: Harith George <harith.g@alifsemi.com>
---
 arch/arm/kernel/head.S |  8 ++++++--
 arch/arm/mm/mmu.c      | 34 +++++++++++++++++++++-------------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 1ec35f065617..28873cda464f 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -252,11 +252,15 @@ __create_page_tables:
 	 */
 	add	r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	ldr	r6, =(_end - 1)
+
+	/* For XIP, kernel_sec_start/kernel_sec_end are currently in RO memory */
+#ifndef CONFIG_XIP_KERNEL
 	adr_l	r5, kernel_sec_start		@ _pa(kernel_sec_start)
 #if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDIAN_BE32
 	str	r8, [r5, #4]			@ Save physical start of kernel (BE)
 #else
 	str	r8, [r5]			@ Save physical start of kernel (LE)
+#endif
 #endif
 	orr	r3, r8, r7			@ Add the MMU flags
 	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ENTRY_ORDER)
@@ -264,6 +268,7 @@ __create_page_tables:
 	add	r3, r3, #1 << SECTION_SHIFT
 	cmp	r0, r6
 	bls	1b
+#ifndef CONFIG_XIP_KERNEL
 	eor	r3, r3, r7			@ Remove the MMU flags
 	adr_l	r5, kernel_sec_end		@ _pa(kernel_sec_end)
 #if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDIAN_BE32
@@ -271,8 +276,7 @@ __create_page_tables:
 #else
 	str	r3, [r5]			@ Save physical end of kernel (LE)
 #endif
-
-#ifdef CONFIG_XIP_KERNEL
+#else
 	/*
 	 * Map the kernel image separately as it is not located in RAM.
 	 */
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f11bf84aa3a2..537f94cd6012 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1402,18 +1402,6 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 		create_mapping(&map);
 	}
 
-	/*
-	 * Map the kernel if it is XIP.
-	 * It is always first in the modulearea.
-	 */
-#ifdef CONFIG_XIP_KERNEL
-	map.pfn = __phys_to_pfn(CONFIG_XIP_PHYS_ADDR & SECTION_MASK);
-	map.virtual = MODULES_VADDR;
-	map.length = ((unsigned long)_exiprom - map.virtual + ~SECTION_MASK) & SECTION_MASK;
-	map.type = MT_ROM;
-	create_mapping(&map);
-#endif
-
 	/*
 	 * Map the cache flushing regions.
 	 */
@@ -1603,12 +1591,27 @@ static void __init map_kernel(void)
 	 * This will only persist until we turn on proper memory management later on
 	 * and we remap the whole kernel with page granularity.
 	 */
+#ifdef CONFIG_XIP_KERNEL
+	phys_addr_t kernel_nx_start = kernel_sec_start;
+#else
 	phys_addr_t kernel_x_start = kernel_sec_start;
 	phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
 	phys_addr_t kernel_nx_start = kernel_x_end;
+#endif
 	phys_addr_t kernel_nx_end = kernel_sec_end;
 	struct map_desc map;
 
+	/*
+	 * Map the kernel if it is XIP.
+	 * It is always first in the modulearea.
+	 */
+#ifdef CONFIG_XIP_KERNEL
+	map.pfn = __phys_to_pfn(CONFIG_XIP_PHYS_ADDR & SECTION_MASK);
+	map.virtual = MODULES_VADDR;
+	map.length = ((unsigned long)_exiprom - map.virtual + ~SECTION_MASK) & SECTION_MASK;
+	map.type = MT_ROM;
+	create_mapping(&map);
+#else
 	map.pfn = __phys_to_pfn(kernel_x_start);
 	map.virtual = __phys_to_virt(kernel_x_start);
 	map.length = kernel_x_end - kernel_x_start;
@@ -1618,7 +1621,7 @@ static void __init map_kernel(void)
 	/* If the nx part is small it may end up covered by the tail of the RWX section */
 	if (kernel_x_end == kernel_nx_end)
 		return;
-
+#endif
 	map.pfn = __phys_to_pfn(kernel_nx_start);
 	map.virtual = __phys_to_virt(kernel_nx_start);
 	map.length = kernel_nx_end - kernel_nx_start;
@@ -1762,6 +1765,11 @@ void __init paging_init(const struct machine_desc *mdesc)
 {
 	void *zero_page;
 
+#ifdef CONFIG_XIP_KERNEL
+	/* Store the kernel RW RAM region start/end in these variables */
+	kernel_sec_start = CONFIG_PHYS_OFFSET & SECTION_MASK;
+	kernel_sec_end = round_up(__pa(_end), SECTION_SIZE);
+#endif
 	pr_debug("physical kernel sections: 0x%08llx-0x%08llx\n",
 		 kernel_sec_start, kernel_sec_end);
 
-- 
2.34.1


