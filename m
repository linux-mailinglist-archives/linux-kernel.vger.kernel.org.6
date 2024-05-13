Return-Path: <linux-kernel+bounces-178001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19528C474D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D4B236E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017C65F87D;
	Mon, 13 May 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vkjxjnvi"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558355F84F
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626749; cv=none; b=CAI2xcuouBUqEx4pO1hB9nf2NN4g5M2AFE0DEns3fI4YwQbopBO+DJVnRvxmmhPleHhj7D5y5nNR2QqwUnhGWf/aY+9iicGzPJqicc9p/iHSgzEiZh8SVXH9dfI0VFNyOu/ydLzeD/IZSi6osHqv2A3sOi3WYvjpllOIdg7ue9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626749; c=relaxed/simple;
	bh=PhGdhNFvZZbZxGhIhqAB/A26vdTYa6Ksch5m1ZGKeLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs2Ijlqux5EwYjKfFZjQ2udOgmqnJBNzlTXfUV0EEuTxsxyyqFCvli4vf3Xm5MMFahI+r/XJF+7PKgVqx3Nn4+BcG9q88T0TsDZKJXzpOBzXw3jmMK5KsfdUkob88Tn09LqxE5shrlX5AZFVN0WSpOlgTqKfkiehEo/ndNkiwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vkjxjnvi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so26963345ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715626747; x=1716231547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DkQ7gN7nCNGAvo6j4bf0eNtvdYMb49Sp4UB0TNBH5zI=;
        b=vkjxjnviFk3c+RGiNXreAaozLZA1Id7nCLoC5Uurw4VSqkBwspkUFHNrI6ETd0BcXx
         lRgv68SFSxztApfmX+zQPNIYz75QK+YzxGzayQF5TuAu5zG6+Hq8EqFkz0TmGtbPmOP9
         6luCdDh2rGuHAp7wpxft23+uHXxipuhzGd/4EGBCGDjPjtS9V7qf7wduZizx8/R21kjC
         MqnWDyb2Sz2SWQKocWmsjm/NODA7NG9gBBFe1X8D6Sg+SIF/UUEQVrio360ZHBTwQmqm
         cZdFsTHW4So0tS4YofUArT+Ju8iA2kUTGZKjyPObuJ4Jz+Nn5UY6HKQEB3/kQdWDJUAQ
         5HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626747; x=1716231547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkQ7gN7nCNGAvo6j4bf0eNtvdYMb49Sp4UB0TNBH5zI=;
        b=vFouYcA903nUbJAIG7fGjrr3hHjjMGvt36zoSujYMG02/we9AHgs9+0ETJ4OzlM53O
         940JV7GTKLHFbhC1FsDAPfX0KCRpIL5+w3KU/ekTBLXrfpnqelqqyPkanAmebXp9Ki3r
         UO98RtKHklBNz3AcWyt7K/C2S0FPkf0zGwdSjUNBBam4JJR+eAcUkhJQt7/oRZgtF5ZM
         +iv7YQCGRMafg7KE6q1kzD4ICR5ereNuiQcvqEYa4B4Oo8TYJmHfF7AfZQ30Qjn+Av+k
         CNbqG+CPqTFI7Uy+1xQ4xsDvv2xenpz6WQH6LV0NP9LA42k7cHNBDWCJOLlC6kLF6WM/
         XDPg==
X-Forwarded-Encrypted: i=1; AJvYcCXOW4V6gfekVAqXJjnvxyyGwcYk0m2vayWYDCkiPSASth8xyyISOX0UjbmsX2sxmeKt0fRYDGxxjnrpus2rgDAb96UUC9R5v4oCTV6q
X-Gm-Message-State: AOJu0YxCwAAqLaeYOB7Cztr5UYDQ589lpkFB/G5eLE2CuuDpvpGcQ1oO
	ek/hDdoovLzim71+8rED67RYuk5ZllTHZQ7PV+fqGWvJI2Rfj0NdTKOkDwaMabA=
X-Google-Smtp-Source: AGHT+IG20sYXzHGsKV8cr1mnWemCePdNZlDhW5Dt/UqsXAayGzUvlBnnQvW06jxjqdu/cIJjaKjgrg==
X-Received: by 2002:a17:903:234c:b0:1e8:682b:7f67 with SMTP id d9443c01a7336-1ef432a0c85mr152017945ad.29.1715626746563;
        Mon, 13 May 2024 11:59:06 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f083c35680sm648365ad.119.2024.05.13.11.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:59:06 -0700 (PDT)
Date: Mon, 13 May 2024 11:59:02 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, andy.chiu@sifive.com,
	hankuan.chen@sifive.com, guoren@kernel.org, greentime.hu@sifive.com,
	samitolvanen@google.com, cleger@rivosinc.com,
	apatel@ventanamicro.com, ajones@ventanamicro.com,
	conor.dooley@microchip.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, waylingii@gmail.com, sameo@rivosinc.com,
	alexghiti@rivosinc.com, akpm@linux-foundation.org,
	shikemeng@huaweicloud.com, rppt@kernel.org, charlie@rivosinc.com,
	xiao.w.wang@intel.com, willy@infradead.org, jszhang@kernel.org,
	leobras@redhat.com, songshuaishuai@tinylab.org, haxel@fzi.de,
	samuel.holland@sifive.com, namcaov@gmail.com, bjorn@rivosinc.com,
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com,
	falcon@tinylab.org, viro@zeniv.linux.org.uk, bhe@redhat.com,
	chenjiahao16@huawei.com, hca@linux.ibm.com, arnd@arndb.de,
	kent.overstreet@linux.dev, boqun.feng@gmail.com, oleg@redhat.com,
	paulmck@kernel.org, broonie@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 07/12] riscv/mm: prepare shadow stack for init task
 for kernel cfi
Message-ID: <ZkJi9rYMkwbp5h7I@debug.ba.rivosinc.com>
References: <20240409061043.3269676-1-debug@rivosinc.com>
 <20240409061043.3269676-8-debug@rivosinc.com>
 <e46b2d43-fe4d-4e9b-95ad-1900779b8bed@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e46b2d43-fe4d-4e9b-95ad-1900779b8bed@ghiti.fr>

Thanks Alex.


On Sun, May 12, 2024 at 10:12:33PM +0200, Alexandre Ghiti wrote:
>
>On 09/04/2024 08:10, Deepak Gupta wrote:
>>Under CONFIG_SHADOW_CALL_STACK, shadow call stack goes into data section.
>>Although with CONFIG_DYNAMIC_SCS on riscv, hardware assisted shadow stack
>>are used. Hardware assisted shadow stack on riscv uses PTE.R=0, PTE.W=1 &
>>PTE.X=0 encodings. Without CONFIG_DYNAMIC_SCS, shadow stack for init is
>>placed in data section and thus regular read/write encodings are applied
>>to it. Although with with CONFIG_DYNAMIC_SCS, they need to go into
>>different section. This change places it into `.shadowstack` section.
>>As part of this change early boot code (`setup_vm`), applies appropriate
>>PTE encodings to shadow call stack for init placed in `.shadowstack`
>>section.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/include/asm/pgtable.h     |  4 ++++
>>  arch/riscv/include/asm/sections.h    | 22 +++++++++++++++++++++
>>  arch/riscv/include/asm/thread_info.h | 10 ++++++++--
>>  arch/riscv/kernel/vmlinux.lds.S      | 12 ++++++++++++
>>  arch/riscv/mm/init.c                 | 29 +++++++++++++++++++++-------
>>  5 files changed, 68 insertions(+), 9 deletions(-)
>>
>>diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>index 9f8ea0e33eb1..3409b250390d 100644
>>--- a/arch/riscv/include/asm/pgtable.h
>>+++ b/arch/riscv/include/asm/pgtable.h
>>@@ -197,6 +197,10 @@ extern struct pt_alloc_ops pt_ops __initdata;
>>  #define PAGE_KERNEL_READ_EXEC	__pgprot((_PAGE_KERNEL & ~_PAGE_WRITE) \
>>  					 | _PAGE_EXEC)
>>+#ifdef CONFIG_DYNAMIC_SCS
>>+#define PAGE_KERNEL_SHADOWSTACK __pgprot(_PAGE_KERNEL & ~(_PAGE_READ | _PAGE_EXEC))
>>+#endif
>>+
>
>
>Not sure the ifdefs are necessary here, but I'll let others jump in. 
>We have a lot of them, so we should try not to add.

I have no hard leanings either way. I was trying to make sure compile fails if shadow stack
is not enabled. But there are other places where config selection makes sure of this.
So may be not needed here.

>
>
>>  #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
>>  #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
>>diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
>>index a393d5035c54..4c4154d0021e 100644
>>--- a/arch/riscv/include/asm/sections.h
>>+++ b/arch/riscv/include/asm/sections.h
>>@@ -14,6 +14,10 @@ extern char __init_data_begin[], __init_data_end[];
>>  extern char __init_text_begin[], __init_text_end[];
>>  extern char __alt_start[], __alt_end[];
>>  extern char __exittext_begin[], __exittext_end[];
>>+#ifdef CONFIG_DYNAMIC_SCS
>>+extern char __init_shstk_start[], __init_shstk_end[];
>>+#endif
>>+extern char __end_srodata[];
>>  static inline bool is_va_kernel_text(uintptr_t va)
>>  {
>>@@ -31,4 +35,22 @@ static inline bool is_va_kernel_lm_alias_text(uintptr_t va)
>>  	return va >= start && va < end;
>>  }
>>+#ifdef CONFIG_DYNAMIC_SCS
>>+static inline bool is_va_init_shadow_stack_early(uintptr_t va)
>>+{
>>+	uintptr_t start = (uintptr_t)(kernel_mapping_pa_to_va(__init_shstk_start));
>>+	uintptr_t end = (uintptr_t)(kernel_mapping_pa_to_va(__init_shstk_end));
>>+
>>+	return va >= start && va < end;
>>+}
>>+
>>+static inline bool is_va_init_shadow_stack(uintptr_t va)
>>+{
>>+	uintptr_t start = (uintptr_t)(__init_shstk_start);
>>+	uintptr_t end = (uintptr_t)(__init_shstk_end);
>>+
>>+	return va >= start && va < end;
>>+}
>>+#endif
>
>
>You could have used an early flag and have only one function but 
>that's up to you.

Make sense, yeah I'll do that.

>
>
>>+
>>  #endif /* __ASM_SECTIONS_H */
>>diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>>index 5d473343634b..7ae28d627f84 100644
>>--- a/arch/riscv/include/asm/thread_info.h
>>+++ b/arch/riscv/include/asm/thread_info.h
>>@@ -63,12 +63,18 @@ struct thread_info {
>>  };
>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>+#ifdef CONFIG_DYNAMIC_SCS
>>  #define INIT_SCS							\
>>-	.scs_base	= init_shadow_call_stack,			\
>>+	.scs_base	= init_shadow_call_stack,	\
>>+	.scs_sp		= &init_shadow_call_stack[SCS_SIZE / sizeof(long)],
>>+#else
>>+#define INIT_SCS							\
>>+	.scs_base	= init_shadow_call_stack,	\
>>  	.scs_sp		= init_shadow_call_stack,
>>+#endif /* CONFIG_DYNAMIC_SCS */
>>  #else
>>  #define INIT_SCS
>>-#endif
>>+#endif /* CONFIG_SHADOW_CALL_STACK */
>>  /*
>>   * macros/functions for gaining access to the thread information structure
>>diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
>>index 002ca58dd998..cccc51f845ab 100644
>>--- a/arch/riscv/kernel/vmlinux.lds.S
>>+++ b/arch/riscv/kernel/vmlinux.lds.S
>>@@ -126,6 +126,18 @@ SECTIONS
>>  		*(.srodata*)
>>  	}
>>+	. = ALIGN(SECTION_ALIGN);
>>+	__end_srodata = .;
>>+
>>+#ifdef CONFIG_DYNAMIC_SCS
>>+	.shadowstack : AT(ADDR(.shadowstack) - LOAD_OFFSET){
>>+		__init_shstk_start = .;
>>+		KEEP(*(.shadowstack..init))
>>+		. = __init_shstk_start + PAGE_SIZE;
>>+		__init_shstk_end = .;
>>+	}
>>+#endif
>>+
>>  	. = ALIGN(SECTION_ALIGN);
>>  	_data = .;
>>diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>index fe8e159394d8..5b6f0cfa5719 100644
>>--- a/arch/riscv/mm/init.c
>>+++ b/arch/riscv/mm/init.c
>>@@ -713,14 +713,22 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
>>  	if (IS_ENABLED(CONFIG_64BIT) && is_va_kernel_lm_alias_text(va))
>>  		return PAGE_KERNEL_READ;
>>+#ifdef CONFIG_DYNAMIC_SCS
>>+	/* If init task's shadow stack va, return write only page protections */
>>+	if (IS_ENABLED(CONFIG_64BIT) && is_va_init_shadow_stack(va)) {
>>+		pr_info("Shadow stack protections are being applied to for init\n");
>>+		return PAGE_KERNEL_SHADOWSTACK;
>>+	}
>>+#endif
>
>
>To avoid the ifdef here, I would hide it inis_va_init_shadow_stack().

Make sense too.

>
>
>>+
>>  	return PAGE_KERNEL;
>>  }
>>  void mark_rodata_ro(void)
>>  {
>>-	set_kernel_memory(__start_rodata, _data, set_memory_ro);
>>+	set_kernel_memory(__start_rodata, __end_srodata, set_memory_ro);
>>  	if (IS_ENABLED(CONFIG_64BIT))
>>-		set_kernel_memory(lm_alias(__start_rodata), lm_alias(_data),
>>+		set_kernel_memory(lm_alias(__start_rodata), lm_alias(__end_srodata),
>>  				  set_memory_ro);
>>  }
>>  #else
>>@@ -913,14 +921,21 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
>>  static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
>>  {
>>  	uintptr_t va, end_va;
>>+	pgprot_t prot;
>>  	end_va = kernel_map.virt_addr + kernel_map.size;
>>-	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE)
>>+	for (va = kernel_map.virt_addr; va < end_va; va += PMD_SIZE) {
>>+		prot = PAGE_KERNEL_EXEC;
>>+#ifdef CONFIG_DYNAMIC_SCS
>>+		if (early && is_va_init_shadow_stack_early(va))
>>+			prot = PAGE_KERNEL_SHADOWSTACK;
>>+#endif
>
>
>Ditto here to avoid the ifdef, hide it intois_va_init_shadow_stack_early().

Yes, will do.

>
>
>>  		create_pgd_mapping(pgdir, va,
>>-				   kernel_map.phys_addr + (va - kernel_map.virt_addr),
>>-				   PMD_SIZE,
>>-				   early ?
>>-					PAGE_KERNEL_EXEC : pgprot_from_va(va));
>>+					kernel_map.phys_addr + (va - kernel_map.virt_addr),
>>+					PMD_SIZE,
>>+					early ?
>
>
>The 3 lines above are not modified, so no need to indent them.

noted.

>
>
>>+					prot : pgprot_from_va(va));
>>+	}
>>  }
>>  #endif
>
>
>Apart from the nits above, you can add:
>
>Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
>Thanks,
>
>Alex
>

