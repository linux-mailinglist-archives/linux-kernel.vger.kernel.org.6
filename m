Return-Path: <linux-kernel+bounces-524732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0121AA3E671
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796A3701194
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F3264FAD;
	Thu, 20 Feb 2025 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0pKbMoJ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675D264F88
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086198; cv=none; b=SMN/Ja7o7LNCOuiQHQJZcD+NYMoi4BFstrZmMyVNSqtf7xzegJrbzwjItQ6gPWTvdRLVS+zLiADyGS7xKCEkpuoLPBsTeDZLNKzP6XX7FqN3mLNaYxQhEtj4eR7CuabN3jHmojiVhT5utlZk0KaVOWUqo1xB0SIlaoeEwPMaZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086198; c=relaxed/simple;
	bh=jR3mLIaiTeoa+eMLo/cxTYfU6MgHYfLBM6TtUFuwv2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KKVH3b+j1nFVRwP6QLp2LneD01wJSBWIJEtJKO2reBZGuBEdSL0CwiuyrN6b3QQ7OKiaftsQ9t+zCFIy3taFxDr5RgMaaK2Y2Il1eztjg8DXgSqysoMBSB4sf2VAeYfh9Dnueu3diYiq6EOonfXXjm15HpMbCJBH/QpxF47bWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0pKbMoJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so3094085a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740086196; x=1740690996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qwgJNMEdiT1vhkG5lo7+qzuUnmeEBfj5pFKSBW8oyKM=;
        b=A0pKbMoJcAVxOzyy7J0he2qXatydDIEXS3i/uqCtCr6QoM6AUY0Sq77Xj2MxHgE7lh
         C4C7hHGr/ozv/bJcJMPiKIzJPCORI3nFSH+9P06OvOaZQb1+ajhrGCJ4FCygaAxwb/wo
         2K8jJsCv4ZIwHE+pDr0TETgTXNo305ov8/X5tNRhh9p5GXe+aTh0oRkXs94GuIW17G7F
         VwJs9f2y2/uXzBssB5EuYJF57DEq0xagde+tdmrJBhHjXIht09HI36qkgppmCT0wr8Zi
         w900oz+kEw8L+Bi+jsihOG+x/YreR7jws9AIF8Aln24cLbXmRyWeLGCgwby8mMQB+qLf
         OCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086196; x=1740690996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwgJNMEdiT1vhkG5lo7+qzuUnmeEBfj5pFKSBW8oyKM=;
        b=Cbah3VZiJ/SfxHAml0E2m/uXeB08PGHE+h8k1HtKTx9YAXyUMjjxDJtaukvPRKkXmI
         B8hWtBPPMgxtMKD+v1OxY7LRdctrdWqF2VY2cpJdK0QhI2/fHS0355Hb6fugez1wrmAj
         S3areaVoKQmiS4e/WXnlMNv7JsDXA1ZBym78YVd/ssVGf7Ok2cKEZOWGIjBOfT7LMkR2
         k1ULPn5hBswVicg91JO/OT6rdWgfzm4xXiOWqiPA7fIj0qICMB17KDbMats/Y8e09f1J
         dbT+s9FdGEk+CSi3tvRxGdGATEY8MEK+CPUEyEwyk+W0Sm2khJ1VDISIDb8C5QOCzAYT
         wfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9TyXZ6eiH9R2qsONj4pDA2JpnoSAwyeCX9feHRf/gUKZQrhiWtg84q3yWSseHVDx0qDHZIWCCy89FVxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jmusceLfQuJQqpDvu7gXOhoil+kPrLKFPRJY1rQW6UhOshVZ
	d7/BOvBbNVwF6dQTQiRR82zne+1v4/BPPUEBEv2GbwUWCMdPt0GSyUCoRK6wp9TiSZPZ15adxF4
	jEoicRhhNmGato9/WEw==
X-Google-Smtp-Source: AGHT+IEUy6fUyPlY/43Esb54TIEMhhhxJkccpoUI9fpWZbCJIo3NCSM5KuRkfyBLlkcAsmHOkWWxQmMvctwYKaNK
X-Received: from pjbsx14.prod.google.com ([2002:a17:90b:2cce:b0:2f2:ea3f:34c3])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3806:b0:2f7:4cce:ae37 with SMTP id 98e67ed59e1d1-2fce78cb5afmr1247829a91.18.1740086196337;
 Thu, 20 Feb 2025 13:16:36 -0800 (PST)
Date: Thu, 20 Feb 2025 21:16:26 +0000
In-Reply-To: <20250220211628.1832258-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220211628.1832258-3-vannapurve@google.com>
Subject: [PATCH V5 2/4] x86/tdx: Route safe halt execution via tdx_safe_halt()
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jgross@suse.com, 
	ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	Vishal Annapurve <vannapurve@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events. So "sti;hlt" sequence needs to
be replaced for TDX VMs with "TDCALL; *_irq_enable()" to keep interrupts
disabled during TDCALL execution.

Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
prevented the idle routines from using "sti;hlt". But it missed the
paravirt routine which can be reached like this as an example:
        acpi_safe_halt() =>
        raw_safe_halt()  =>
        arch_safe_halt() =>
        irq.safe_halt()  =>
        pv_native_safe_halt()

Modify tdx_safe_halt() to implement the sequence "TDCALL;
raw_local_irq_enable()" and invoke tdx_halt() from idle routine which just
executes TDCALL without toggling interrupt state. Introduce dependency
on CONFIG_PARAVIRT and override paravirt halt()/safe_halt() routines for
TDX VMs.

Cc: stable@vger.kernel.org
Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/Kconfig           |  1 +
 arch/x86/coco/tdx/tdx.c    | 22 +++++++++++++++++++++-
 arch/x86/include/asm/tdx.h |  2 +-
 arch/x86/kernel/process.c  |  2 +-
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d957e2f..afcdbc9693dc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -902,6 +902,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	depends on EFI_STUB
+	depends on PARAVIRT
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 32809a06dab4..7ab427e85bd3 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -14,6 +14,7 @@
 #include <asm/ia32.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/traps.h>
@@ -398,7 +399,7 @@ static int handle_halt(struct ve_info *ve)
 	return ve_instr_len(ve);
 }
 
-void __cpuidle tdx_safe_halt(void)
+void __cpuidle tdx_halt(void)
 {
 	const bool irq_disabled = false;
 
@@ -409,6 +410,16 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static void __cpuidle tdx_safe_halt(void)
+{
+	tdx_halt();
+	/*
+	 * "__cpuidle" section doesn't support instrumentation, so stick
+	 * with raw_* variant that avoids tracing hooks.
+	 */
+	raw_local_irq_enable();
+}
+
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_module_args args = {
@@ -1109,6 +1120,15 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
 	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
 
+	/*
+	 * "sti;hlt" execution in TDX guests will induce a #VE in the STI-shadow
+	 * which will enable interrupts before HLT TDCALL inocation possibly
+	 * resulting in missed wakeup events. Modify all possible HLT
+	 * execution paths to use TDCALL for performance/reliability reasons.
+	 */
+	pv_ops.irq.safe_halt = tdx_safe_halt;
+	pv_ops.irq.halt = tdx_halt;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b4b16dafd55e..393ee2dfaab1 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -58,7 +58,7 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
-void tdx_safe_halt(void);
+void tdx_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 6da6769d7254..d11956a178df 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -934,7 +934,7 @@ void __init select_idle_routine(void)
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		static_call_update(x86_idle, tdx_safe_halt);
+		static_call_update(x86_idle, tdx_halt);
 	} else {
 		static_call_update(x86_idle, default_idle);
 	}
-- 
2.48.1.601.g30ceb7b040-goog


