Return-Path: <linux-kernel+bounces-383317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787BA9B1A00
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DD128307A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A961D88BF;
	Sat, 26 Oct 2024 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DvCJA+lL"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973DA1D6DB6
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962892; cv=none; b=AHV0R4w1m7jtysUs1J0PgxmG/YTCf/v6SsyWmeONkImLLutcSj/gLVtAZRIiNhAV5dHlWqpmpfXIeJo9mcwB7lzrcX3YE3WfkVXUOr0TI8WX6H0p/Zheb7KWlPG4FDZPngUCo7YkHeeXQxW26a1kz7guvwBQ6Sr1US4Ni+MqG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962892; c=relaxed/simple;
	bh=9n83+TFEs1sWuWurdveeddmsJrb/ReI1EWNzw3Tr+ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTkF5c6sBdAF9QJntXYpNfs3tFEOxX6svyIqtDGArikTug+n5WIS6HtdaYmnzvbn4SODExtLgDAou5Zg9JStyB/9KZtJokOeB2Cy4wIWaijwhkKghWhwEJI19GjaounEyIIKFuBCNbumDSmBsUXUIO5WUQYG2Wo9i99V7lZRVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DvCJA+lL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so2261585a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729962890; x=1730567690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32SXpWlDW0kkamANJs274cWuCXV1jWs6Ch/GFZy2syA=;
        b=DvCJA+lLBQgbyFoAY3ZIgEVI1knNSbxFx+ef+DcawVxrwB0TPpNSZB+p76yMztJQes
         Iq9CPaFTXLroN/qCG1319gspJkxo5K36Rbq0jPcRoZprf06iz22S1AeI6p6+S9qf7V3O
         br1VfB9kYB31x63Yy9fZ6hdIoal/F3a57EaiCcLMlr4ryjl8Wbtt93VEhaP1tzDBUr4c
         6aYqHBCb/hLvL7NJjtYtg3eqxgKneVgYnPnq5OpKVK1IyPIUgw7AQIJEKLU0RIf6Fvwg
         u4d9ome82fmLsGq56mPhKmI8NkTDDtpWXqFfbmN6l/lnS/YVmtv2iusnnlYSXUpndBQk
         AGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729962890; x=1730567690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32SXpWlDW0kkamANJs274cWuCXV1jWs6Ch/GFZy2syA=;
        b=Y1qL0nQNi6mle0UjgD7eEVYnyX91+v1XWRU13xATlNF44DSUlm9RH7TrwmrWjSUztB
         mzuuZbTzYifDxc/TodqotzS1zRXfN0H7HMODkWn0uSnuuJiA+87MC0SE0K2Sy3+5df4M
         /Aqu5Imgi/NlK/pmyGmPRY9O8LYUdqcGQy2Q2QxdwqJV/2595JJLIeCu/WFclxO2ASNy
         OSqt7Cn8ZG/HDfrwqFxUvQPEM2OBjEbfFd8Yvc9THNaQZeWfa6z9pxcWaSyWT3PuqmnO
         33oYKGg9PY5TIZI928Dpsa+KpqsenS2sCn8Eyay73s4zx2REYPscchRKOA7W31nhp9A8
         BRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlfzMkE+PcuMqGehY3OnyG5+uTCQvGlkzhbRoU/dKF2r4Rq4o9WwLldAkzXsUi6ODh5zqYfcNWrDJEdc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4SrNYtdnix279IpAA6eDzW0d8o+AdsTJXAaR/g9OH2EbqOf8
	jjhLV1NMpsDVVjXPelZdxH5tk5x7znFIombsv2XHWrJegd+3gS9ZSxcQ08zAL6w=
X-Google-Smtp-Source: AGHT+IHuE/xLTvkb+BU83DmMK1Bc6hhBs45MKVg/zLV/CvtM1d0wHjLI0sEZOu1+WLDNR8rdwiJXEw==
X-Received: by 2002:a17:90a:5e07:b0:2e2:eacc:3227 with SMTP id 98e67ed59e1d1-2e8f107c664mr4417836a91.23.1729962889947;
        Sat, 26 Oct 2024 10:14:49 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e558114sm5663762a91.36.2024.10.26.10.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 10:14:49 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 5/6] riscv: Support CONFIG_RELOCATABLE on riscv32
Date: Sat, 26 Oct 2024 10:13:57 -0700
Message-ID: <20241026171441.3047904-6-samuel.holland@sifive.com>
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

When adjusted to use the correctly-sized ELF types, relocate_kernel()
works on riscv32 as well. The caveat about crossing an intermediate page
table boundary does not apply to riscv32, since for Sv32 the early
kernel mapping uses only PGD entries. Since KASLR is not yet supported
on riscv32, this option is mostly useful for NOMMU.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Kconfig   |  2 +-
 arch/riscv/mm/init.c | 17 ++++++++---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4420419e7054..33aa79d84021 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -934,7 +934,7 @@ config PARAVIRT_TIME_ACCOUNTING
 
 config RELOCATABLE
 	bool "Build a relocatable kernel"
-	depends on 64BIT && !XIP_KERNEL
+	depends on !XIP_KERNEL
 	select MODULE_SECTIONS if MODULES
 	help
           This builds a kernel as a Position Independent Executable (PIE),
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a74e28367f9f..0aad925848a4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -20,15 +20,13 @@
 #include <linux/dma-map-ops.h>
 #include <linux/crash_dump.h>
 #include <linux/hugetlb.h>
-#ifdef CONFIG_RELOCATABLE
-#include <linux/elf.h>
-#endif
 #include <linux/kfence.h>
 #include <linux/execmem.h>
 
 #include <asm/fixmap.h>
 #include <asm/io.h>
 #include <asm/kasan.h>
+#include <asm/module.h>
 #include <asm/numa.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
@@ -312,7 +310,7 @@ extern unsigned long __rela_dyn_start, __rela_dyn_end;
 
 static void __init relocate_kernel(void)
 {
-	Elf64_Rela *rela = (Elf64_Rela *)&__rela_dyn_start;
+	Elf_Rela *rela = (Elf_Rela *)&__rela_dyn_start;
 	/*
 	 * This holds the offset between the linked virtual address and the
 	 * relocated virtual address.
@@ -324,9 +322,9 @@ static void __init relocate_kernel(void)
 	 */
 	uintptr_t va_kernel_link_pa_offset = KERNEL_LINK_ADDR - kernel_map.phys_addr;
 
-	for ( ; rela < (Elf64_Rela *)&__rela_dyn_end; rela++) {
-		Elf64_Addr addr = (rela->r_offset - va_kernel_link_pa_offset);
-		Elf64_Addr relocated_addr = rela->r_addend;
+	for ( ; rela < (Elf_Rela *)&__rela_dyn_end; rela++) {
+		Elf_Addr addr = (rela->r_offset - va_kernel_link_pa_offset);
+		Elf_Addr relocated_addr = rela->r_addend;
 
 		if (rela->r_info != R_RISCV_RELATIVE)
 			continue;
@@ -340,7 +338,7 @@ static void __init relocate_kernel(void)
 		if (relocated_addr >= KERNEL_LINK_ADDR)
 			relocated_addr += reloc_offset;
 
-		*(Elf64_Addr *)addr = relocated_addr;
+		*(Elf_Addr *)addr = relocated_addr;
 	}
 }
 #endif /* CONFIG_RELOCATABLE */
@@ -1155,7 +1153,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 * makes the kernel cross over a PUD_SIZE boundary, raise a bug
 	 * since a part of the kernel would not get mapped.
 	 */
-	BUG_ON(PUD_SIZE - (kernel_map.virt_addr & (PUD_SIZE - 1)) < kernel_map.size);
+	if (IS_ENABLED(CONFIG_64BIT))
+		BUG_ON(PUD_SIZE - (kernel_map.virt_addr & (PUD_SIZE - 1)) < kernel_map.size);
 	relocate_kernel();
 #endif
 
-- 
2.45.1


