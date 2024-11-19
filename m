Return-Path: <linux-kernel+bounces-413661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E79D1D08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0401F20621
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA973E49D;
	Tue, 19 Nov 2024 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFEyTCZL"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394704087C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978877; cv=none; b=uibz+o31wSDQc+DstQpX/+MOe8qKNN8qqUBLKU7HaR4CKpaHNDmTa8myJIMOyKgcyw5jRtYqwmCwMnVa36SSiGp2CWfQZgF+RubHZ/GP8XyHw+ub07QeXSJq5VefZPz5orxipnarDP5PcXJwn16rTybLZ1SUGdo4WmKtl/ruC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978877; c=relaxed/simple;
	bh=EOnlo6Wwu/5WE/UoDd60kQ4EuRTmxuNd952WDErRHoA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DsCrklgrUPZR0Joq/07A/hY3htHP+Zytol1J5r3E98ATQ5aTwoZGYJvy94/P9psBS5oame7CbMEl6WkbNhWF0kmq2RqEFyM4ENisC9HKSmi2NE/4EAysVmeqEr489c3bwLjV4AjipR+94gpwIPqFeS4ah9uKZ68vroFEYaMfF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFEyTCZL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea764112f8so379840a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731978875; x=1732583675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mYuQ3lvcApDZezDe5Px2PCbRs3zDshsrJVmrX1S/bk=;
        b=nFEyTCZLrpfMA0G/rOk5Wavry56QJKZjV/8pKf98UIzlLMAx8UJzwmOLlhawtJH5Ej
         RmmIt0Kur7B85vlg05o3MtVGBkVItQTlLXl0li8cn/7DkyAROEvgWBG9sEC1J4DQcT7w
         vCsVF7oixpqtnuy7fzssNHIFtXoQeOaYZpr8m2oEokqSUmg+LvB8p0atm0y0IUB67Tv4
         OSvqwwtHOOKXwm5JE8DA45WVlTBj+bKiAkoXZig6femjSeO9fWEZK5LCmvYBaS268tpD
         2l7j8irQIQqFCF9uV83kf8shTYO/vZaxP8LkquGYiWsaNGHd59SN4l/eO9kk4M2/xwaF
         q+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731978875; x=1732583675;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mYuQ3lvcApDZezDe5Px2PCbRs3zDshsrJVmrX1S/bk=;
        b=LabPqtIEOjMcH6SI2AvdIrTqEpQgOv7SKrGZwFm+Vjdior1A31m2kQqur2/xncUSDP
         qhRnrj6Ls2tsnUk//sgq6huiEz0oOtrdVuQIiMH4eME5Egn0vgkDIrxwG0YfXrxb9IYO
         QWwvHqwWh1aIVyCVf4tvSXYzDjr/BBfcTStF8c2JUN16i1mnGC4wBXm333tlhcyxPt/R
         mfTbXGhu4so3sUpHxXu7oS/hJ0vUzqHMzUJrhHbGv/rb3bIt4OUkxvd0meuwE8YlXOV0
         z7WkcjG1E963lV84Os+Uk9wVW0X6O+9u3esZFBmxbhthzUrVfZazOmI416Z6U/rOdcXH
         jrDA==
X-Forwarded-Encrypted: i=1; AJvYcCWlekjp6zMYfuO/sUn88QhCb6HA/Y41WqjQErfgiGE3yJYc4wQnCuF8gHJ1MZ85IBLfz4S5f021PFic8Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7WWJ81G2aJlbOHUWJZEXTl7vCemTPoFR07QSCg0WR17VSQUG
	B8lw2DmTT1O8CkUQLnr0/EGu/DO7+cl7bb1OQvazXCRrpcPSvcvGq8iBi+lLKw9HS5OqSfTzsuH
	tfw==
X-Google-Smtp-Source: AGHT+IEIWKEhlfWGek8jkFFpawqtDvH7zk8zObmTwcV2zoORglSis/CaT+H7aPJijJZGVAdU4/kRNr5Uuh0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3ccd:b0:2ea:5dd2:e58f with SMTP id
 98e67ed59e1d1-2ea5dd2e6d5mr30707a91.2.1731978875615; Mon, 18 Nov 2024
 17:14:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 18 Nov 2024 17:14:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241119011433.1797921-1-seanjc@google.com>
Subject: [PATCH] Revert "KVM: VMX: Move LOAD_IA32_PERF_GLOBAL_CTRL errata
 handling out of setup_vmcs_config()"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Revert back to clearing VM_{ENTRY,EXIT}_LOAD_IA32_PERF_GLOBAL_CTRL in KVM's
golden VMCS config, as applying the workaround during vCPU creation is
pointless and broken.  KVM *unconditionally* clears the controls in the
values returned by vmx_vmentry_ctrl() and vmx_vmexit_ctrl(), as KVM loads
PERF_GLOBAL_CTRL if and only if its necessary to do so.  E.g. if KVM wants
to run the guest with the same PERF_GLOBAL_CTRL as the host, then there's
no need to re-load the MSR on entry and exit.

Even worse, the buggy commit failed to apply the erratum where it's
actually needed, add_atomic_switch_msr().  As a result, KVM completely
ignores the erratum for all intents and purposes, i.e. uses the flawed
VMCS controls to load PERF_GLOBAL_CTRL.

To top things off, the patch was intended to be dropped, as the premise
of an L1 VMM being able to pivot on FMS is flawed, and KVM can (and now
does) fully emulate the controls in software.  Simply revert the commit,
as all upstream supported kernels that have the buggy commit should also
have commit f4c93d1a0e71 ("KVM: nVMX: Always emulate PERF_GLOBAL_CTRL
VM-Entry/VM-Exit controls"), i.e. the (likely theoretical) live migration
concern is a complete non-issue.

Opportunistically drop the manual "kvm: " scope from the warning about
the erratum, as KVM now uses pr_fmt() to provide the correct scope (v6.1
kernels and earlier don't, but the erratum only applies to CPUs that are
15+ years old; it's not worth a separate patch).

This reverts commit 9d78d6fb186bc4aff41b5d6c4726b76649d3cb53.

Link: https://lore.kernel.org/all/YtnZmCutdd5tpUmz@google.com
Fixes: 9d78d6fb186b ("KVM: VMX: Move LOAD_IA32_PERF_GLOBAL_CTRL errata handling out of setup_vmcs_config()")
Cc: stable@vger.kernel.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Found by inspection, verified by hacking cpu_has_perf_global_ctrl_bug() to
unconditionally return true, and warning if add_atomic_switch_msr_special()
was called with for PERF_GLOBAL_GTRL.

 arch/x86/kvm/vmx/vmx.c | 54 ++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d28618e9277e..92fee5e8a3c7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2551,28 +2551,6 @@ static bool cpu_has_sgx(void)
 	return cpuid_eax(0) >= 0x12 && (cpuid_eax(0x12) & BIT(0));
 }
 
-/*
- * Some cpus support VM_{ENTRY,EXIT}_IA32_PERF_GLOBAL_CTRL but they
- * can't be used due to errata where VM Exit may incorrectly clear
- * IA32_PERF_GLOBAL_CTRL[34:32]. Work around the errata by using the
- * MSR load mechanism to switch IA32_PERF_GLOBAL_CTRL.
- */
-static bool cpu_has_perf_global_ctrl_bug(void)
-{
-	switch (boot_cpu_data.x86_vfm) {
-	case INTEL_NEHALEM_EP:	/* AAK155 */
-	case INTEL_NEHALEM:	/* AAP115 */
-	case INTEL_WESTMERE:	/* AAT100 */
-	case INTEL_WESTMERE_EP:	/* BC86,AAY89,BD102 */
-	case INTEL_NEHALEM_EX:	/* BA97 */
-		return true;
-	default:
-		break;
-	}
-
-	return false;
-}
-
 static int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt, u32 msr, u32 *result)
 {
 	u32 vmx_msr_low, vmx_msr_high;
@@ -2732,6 +2710,27 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		_vmexit_control &= ~x_ctrl;
 	}
 
+	/*
+	 * Some cpus support VM_{ENTRY,EXIT}_IA32_PERF_GLOBAL_CTRL but they
+	 * can't be used due to an errata where VM Exit may incorrectly clear
+	 * IA32_PERF_GLOBAL_CTRL[34:32].  Workaround the errata by using the
+	 * MSR load mechanism to switch IA32_PERF_GLOBAL_CTRL.
+	 */
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_NEHALEM_EP:	/* AAK155 */
+	case INTEL_NEHALEM:	/* AAP115 */
+	case INTEL_WESTMERE:	/* AAT100 */
+	case INTEL_WESTMERE_EP:	/* BC86,AAY89,BD102 */
+	case INTEL_NEHALEM_EX:	/* BA97 */
+		_vmentry_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
+		_vmexit_control &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
+		pr_warn_once("VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
+			     "does not work properly. Using workaround\n");
+		break;
+	default:
+		break;
+	}
+
 	rdmsrl(MSR_IA32_VMX_BASIC, basic_msr);
 
 	/* IA-32 SDM Vol 3B: VMCS size is never greater than 4kB. */
@@ -4422,9 +4421,6 @@ static u32 vmx_vmentry_ctrl(void)
 			  VM_ENTRY_LOAD_IA32_EFER |
 			  VM_ENTRY_IA32E_MODE);
 
-	if (cpu_has_perf_global_ctrl_bug())
-		vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
-
 	return vmentry_ctrl;
 }
 
@@ -4442,10 +4438,6 @@ static u32 vmx_vmexit_ctrl(void)
 	if (vmx_pt_mode_is_system())
 		vmexit_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP |
 				 VM_EXIT_CLEAR_IA32_RTIT_CTL);
-
-	if (cpu_has_perf_global_ctrl_bug())
-		vmexit_ctrl &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
-
 	/* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
 	return vmexit_ctrl &
 		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
@@ -8400,10 +8392,6 @@ __init int vmx_hardware_setup(void)
 	if (setup_vmcs_config(&vmcs_config, &vmx_capability) < 0)
 		return -EIO;
 
-	if (cpu_has_perf_global_ctrl_bug())
-		pr_warn_once("VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
-			     "does not work properly. Using workaround\n");
-
 	if (boot_cpu_has(X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
 

base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.47.0.338.g60cca15819-goog


