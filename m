Return-Path: <linux-kernel+bounces-284817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8E950572
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95A61C20B49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8943E19D076;
	Tue, 13 Aug 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpLphfoX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PvAirMVm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8E19AD8E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553123; cv=none; b=kCJtS6aouOgiWHlSQUQ8xh3Z7UvfouYUPyvTioKYKTSvhtGep/Q2knoyLqoDRpWcB/3Jk/diAE9STuYmMCbM/zwnfrZ92uNT1ZHP6UFjZH+Y4YFyQi381uO8gSRsLvyeN4lzTiJ8kFeZ/qhAPN6B2NSrH6ZcDZmnk9jNyzOhtEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553123; c=relaxed/simple;
	bh=nKuihict5bCtVs5sR8hBaLPudxNaLHNcvhXqiQBm3qM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bkt0c9XoU/V/xoOn3R7/o2m8WqdmsLHor1y3hLnoMmynWIuloLH1gWUhPbfCM6wtY5WyuXWT7oq5nz37cIr8luVE+k1BIt4kwa9pfBhSa5iuS5X0Ak/qNn99MWcyZhKanOKCQ3ZZmfStxoVwZs3YViGKQ2f14m0XNXNfQ5AgmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpLphfoX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PvAirMVm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723553119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkUvBI/VTu0tRVlkFmQ2yshVJhdDkZNQnzo/Zh15d54=;
	b=ZpLphfoXXuy47Lvaiw8VAnVn/LUVIGAi9mfgqI7LP4eoqBKFAlV2N1yvDH/J/84+acWUOC
	g98d9rnYq+LXuo2zw8cJ5zlFYS1BWGJqez1bc7SSblIBX6aO1khlOBhgdlh23h9x6CGjD/
	0ELkRJYX/lvvIHsSzQ1L+4rlSmBcLPi7DcToRoJ/QvqnMecEF6vJ4PxVoDSXVUV84muoBi
	uI20xQn4//wlQwOr/CAJ/vNggrKOLzIeHLXu96HTGKyUfsyv0/gSDASB0RyjqexHyqEG1D
	0WYpk3UygRBmJqedLyyHtfgvWF6T9eJ8pjETr+bWrqTXz/GlQAO0qe13cv4Fuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723553119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkUvBI/VTu0tRVlkFmQ2yshVJhdDkZNQnzo/Zh15d54=;
	b=PvAirMVmjFSF6mgfHDh0MRPfPGbCJZqF71bm4LeiO7lRgrdkmBjFOicLp8w1dbowNqYleP
	wkW2rav8makLAdCg==
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
 andrew.cooper3@citrix.com, nik.borisov@suse.com,
 houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v2 3/3] x86/fred: Enable FRED right after
 init_mem_mapping()
In-Reply-To: <20240709154048.3543361-4-xin@zytor.com>
References: <20240709154048.3543361-1-xin@zytor.com>
 <20240709154048.3543361-4-xin@zytor.com>
Date: Tue, 13 Aug 2024 14:45:19 +0200
Message-ID: <874j7or3q8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 09 2024 at 08:40, Xin Li wrote:

I'm really unhappy about sprinkling all these FRED conditionals all over
the place:

>  	init_mem_mapping();
>  
> -	idt_setup_early_pf();
> +	/*
> +	 * init_mem_mapping() uses early IDT to setup memory mappings, thus FRED
> +	 * can't be enabled earlier than that, unless FRED adds support to setup
> +	 * memory mappings.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		cpu_init_fred_exceptions();
> +	else
> +		idt_setup_early_pf();
  
> @@ -248,6 +249,11 @@ static void notrace start_secondary(void *unused)
>  
>  	cpu_init_exception_handling();
>  
> +	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> +		cpu_init_fred_exceptions();
> +		cpu_init_fred_rsps();
> +	}

>  	/* Init cpu_entry_area before IST entries are set up */
>  	setup_cpu_entry_areas();
>  
> +	/* FRED RSPs pointing to memory from CPU entry areas */
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		cpu_init_fred_rsps();
> +
>  	/* Init GHCB memory pages when running as an SEV-ES guest */
>  	sev_es_init_vc_handling();

This really can be encapsulated and kept in places which need to know
about FRED already. See below. Can you please validate?

Thanks,

        tglx
---
From: "Xin Li (Intel)" <xin@zytor.com>
Subject: x86/fred: Enable FRED right after init_mem_mapping()
Date: Tue, 09 Jul 2024 08:40:48 -0700

From: "Xin Li (Intel)" <xin@zytor.com>

On 64-bit init_mem_mapping() relies on the minimal page fault handler
provided by the early IDT mechanism. The real page fault handler is
installed right afterwards into the IDT.

This is problematic on CPUs which have X86_FEATURE_FRED set because the
real page fault handler retrieves the faulting address from the FRED
exception stack frame and not from CR2, but that does obviously not work
when FRED is not yet enabled in the CPU.

To prevent this enable FRED right after init_mem_mapping() without
interrupt stacks. Those are enabled later in trap_init() after the CPU
entry area is set up.

[ tglx: Encapsulate the FRED details ]

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240709154048.3543361-4-xin@zytor.com
---
 arch/x86/include/asm/processor.h |    3 ++-
 arch/x86/kernel/cpu/common.c     |   15 +++++++++++++--
 arch/x86/kernel/setup.c          |    7 ++++++-
 arch/x86/kernel/smpboot.c        |    2 +-
 arch/x86/kernel/traps.c          |    2 +-
 5 files changed, 23 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -582,7 +582,8 @@ extern void switch_gdt_and_percpu_base(i
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void cpu_init(void);
-extern void cpu_init_exception_handling(void);
+extern void cpu_init_exception_handling(bool boot_cpu);
+extern void cpu_init_replace_early_idt(void);
 extern void cr4_init(void);
 
 extern void set_task_blockstep(struct task_struct *task, bool on);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2176,7 +2176,7 @@ static inline void tss_setup_io_bitmap(s
  * Setup everything needed to handle exceptions from the IDT, including the IST
  * exceptions which use paranoid_entry().
  */
-void cpu_init_exception_handling(void)
+void cpu_init_exception_handling(bool boot_cpu)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 	int cpu = raw_smp_processor_id();
@@ -2196,13 +2196,24 @@ void cpu_init_exception_handling(void)
 	setup_ghcb();
 
 	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
-		cpu_init_fred_exceptions();
+		/* The boot CPU has enabled FRED during early boot */
+		if (!boot_cpu)
+			cpu_init_fred_exceptions();
+
 		cpu_init_fred_rsps();
 	} else {
 		load_current_idt();
 	}
 }
 
+void __init cpu_init_replace_early_idt(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		cpu_init_fred_exceptions();
+	else
+		idt_setup_early_pf();
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT.  We
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1039,7 +1039,12 @@ void __init setup_arch(char **cmdline_p)
 
 	init_mem_mapping();
 
-	idt_setup_early_pf();
+	/*
+	 * init_mem_mapping() relies on the early IDT page fault handling.
+	 * Now either enable FRED or install the real page fault handler
+	 * for 64-bit in the IDT.
+	 */
+	cpu_init_replace_early_idt();
 
 	/*
 	 * Update mmu_cr4_features (and, indirectly, trampoline_cr4_features)
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -246,7 +246,7 @@ static void notrace start_secondary(void
 		__flush_tlb_all();
 	}
 
-	cpu_init_exception_handling();
+	cpu_init_exception_handling(false);
 
 	/*
 	 * Load the microcode before reaching the AP alive synchronization
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1411,7 +1411,7 @@ void __init trap_init(void)
 	sev_es_init_vc_handling();
 
 	/* Initialize TSS before setting up traps so ISTs work */
-	cpu_init_exception_handling();
+	cpu_init_exception_handling(true);
 
 	/* Setup traps as cpu_init() might #GP */
 	if (!cpu_feature_enabled(X86_FEATURE_FRED))

