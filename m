Return-Path: <linux-kernel+bounces-510241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC647A31A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D82188AC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F80111A8;
	Wed, 12 Feb 2025 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0W4+BWTt"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7FE79FD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318900; cv=none; b=AhU3KC1rWOgSs+RSTh3C1+yg/Zv2ulsTC3hir2N4ji045Rr/d4owWg1wctiUH6LdA7sbWw/Z5VxOwfOOIVwTjZ9CYavHt+ogFQiaH9gVZ9wmrF5rijO/eHfjZymx/NlfjcIEtWWpsU1AN7Mch83+iTqJ/9eU3Hsd+3GYy0v4QXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318900; c=relaxed/simple;
	bh=qPyAwicKpZpLg3GmtysNq22b8SvhJ9Kkp+IXaoaTFnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DOfVp3xaE9/h+3RS6DeqTqPHaws3iuzUjCWfhJLAWWFswH7ZbfZDZkjyh+cg/h/jogCITMyx9t4fVlqnvFEgKXmJ1GUPqnl5l70TmICl5yWn/qnER/WrokSO/EmOj3ntYytqq4SQm7Xudlc4mS3DYK+u3MTmjH2a3WEi6mocI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0W4+BWTt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f5538a2356so13035251a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739318898; x=1739923698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhFKIyqyWccfVyhYNzTyKMpa/Pu1oM/LLWYuIAGv7wA=;
        b=0W4+BWTt/oWdsQ6efyp1JIT778fbfnHUNFjprU9IjG8JvSPV9OK6gEIOK8o7SjXMBj
         cxpf1agmm1vmLJdY8G18PHbuFP6Zo4HiAw4qFM1Jf14O8gtUDlPFmqYJ5ocMokEmotXI
         qR3v9IXFAjD/z2kIgcer3mZ3HN/WMXiryPNHrFYkORgmS4DLFY++YkjwF2wJPPQuSkbm
         pnfMlJ1xeiw3S1eTVVfinzKSwjMh0TgZmPC4o4OdOvST4F/hhswmmW3732/4sYJqrSUR
         dl4DVtycLHe78SaGT5ZmfDxyyEulSN0pDtd/vtzCiTLjT5QzyCy0uOkOSKE1J5EDfCUW
         ueGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318898; x=1739923698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhFKIyqyWccfVyhYNzTyKMpa/Pu1oM/LLWYuIAGv7wA=;
        b=M749EkXMjYMgn1rzFBMys34n0rrtw5G9Xv04fy6U1ukYklZWFe2gMwxdiZho9yd1VY
         Eq+bDZft8qcpV1TecmRSbNb5lpadY7YO5IOVjk9bXj3qPlvX3PPkvgpwJx3WjUNySuE/
         qalUyU4TMvXjMNnW3Wb2kR0prlkxK6NzmCeGP450+tANVOSBB6yn3eVdyvDyIQsiHnFC
         LXoej37t57qLHN0scOs1FDa3/tDvLMuuyXM9ao9a2tLnoeA4byNgiv4xcKNBfjwqsnoT
         aDY1ZNLjPROIQQSQ+mOxlylfc2cnqrJHH65BSYeIEFP6ebVWK9hNNgYqQz7vbSFuBTTa
         fF/A==
X-Forwarded-Encrypted: i=1; AJvYcCX1p5NsQvFXAB2odFemYVW6vzy27wuMEMsY2HHhrP92lmvn5qAufyCnwGCEl+wKOGqrFndQkYiKoKLpAUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7nNqzyAOpAU5DLPA+2c7go5x1ByMpolZHjQuyyQIGmoGs/79
	NSfh1FPhogguPpD2LbT/Zc+wbG3GGAqC20Nsa9c6CA4g3LYcvoX3yc8vyQ8Pn8flc0iUmF/3+bN
	rUzkkmKjusS+JiDrWHg==
X-Google-Smtp-Source: AGHT+IGIIh1a6f5LCEQr8t1bLmoqA5VXctBMBQSaTYWM2+xjlnEVTI47jUBbtXW0wJOYn/WoZYxJQiGIyuC2R8tL
X-Received: from pfoa23.prod.google.com ([2002:aa7:8657:0:b0:730:759d:5049])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:cd2:b0:730:7499:4036 with SMTP id d2e1a72fcca58-7322c443c7bmr1611687b3a.22.1739318898459;
 Tue, 11 Feb 2025 16:08:18 -0800 (PST)
Date: Wed, 12 Feb 2025 00:07:45 +0000
In-Reply-To: <20250212000747.3403836-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212000747.3403836-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212000747.3403836-3-vannapurve@google.com>
Subject: [PATCH V4 2/4] x86/tdx: Route safe halt execution via tdx_safe_halt()
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	Vishal Annapurve <vannapurve@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events. So "sti;hlt" sequence needs to
be replaced with "TDCALL; raw_local_irq_enable()" for TDX VMs.

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
executes TDCALL without changing state of interrupts. Introduce dependency
on CONFIG_PARAVIRT and override paravirt halt()/safe_halt() routines for
TDX VMs.

Cc: stable@vger.kernel.org
Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/Kconfig           |  1 +
 arch/x86/coco/tdx/tdx.c    | 18 +++++++++++++++++-
 arch/x86/include/asm/tdx.h |  2 +-
 arch/x86/kernel/process.c  |  2 +-
 4 files changed, 20 insertions(+), 3 deletions(-)

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
index 32809a06dab4..ee67c1870e70 100644
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
 
@@ -409,6 +410,12 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static void __cpuidle tdx_safe_halt(void)
+{
+	tdx_halt();
+	raw_local_irq_enable();
+}
+
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_module_args args = {
@@ -1109,6 +1116,15 @@ void __init tdx_early_init(void)
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
2.48.1.502.g6dc24dfdaf-goog


