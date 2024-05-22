Return-Path: <linux-kernel+bounces-185694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352AA8CB8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E711F2676F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10327D095;
	Wed, 22 May 2024 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJHIrMm9"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B77B3C1
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716344922; cv=none; b=s/d9Te+kNwF1CZQmE+v8lwZ4UiyFFoQS+Mi4GF1zeOjQpjoqLhA0+lE7Xc8PCo6YSacoApqpFXE5scYh1AjGbRE3qHVCXvY4HL8NntNBs/YtoUG1kXgGvEh9u42aGeWeLz1Z3ofKXI5N7cf1E7VwVB5HJLp8iDVd9Egt5CiPOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716344922; c=relaxed/simple;
	bh=bL1+vHMHhm9cMRQczr5G+NHO3Zy1qclzvEFtBGp3ICc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZJLJksBmRHam9q7i132Le7qeyH/mDSKJrV4LtJhUd/ey39kxc4KodhdI0p64okneylswwdkuTo5cU02FcjngJw6orxPqgPUW9fKFYomXLPrtIAYEnt5lSYBqTbPjV1tLI0VqFxx8Kw/KkiOv3p88xIk0KIMWIf4eyOJcG2H7fZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJHIrMm9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6efef492e79so12887639b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716344921; x=1716949721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3UQR7L7IeR8qz/nRM58REudhth61YMdGJiKJChX9kbI=;
        b=iJHIrMm9GwBnSI1yjJajM0NyU9BObafjttFfKfHFnTmBoA5icmjewg2HT4xKppxpxO
         WIvyzBh/lgwYUFm6UrCgyVEEgb/s0D2bELZ27vrsUXhAlWngfo65dIjQAvP5YZ/xJ59t
         DZMSBxcXtlKxui/9eXrhdzbven9eS1BXwtvGXiMCEL0WwaY0AOItb6a3yE+L3gdjyMXt
         /Jv7nT7iNSZfBeY3n/to0YO6EXSRTco5C9XXLtPxwPXB1JU1wjVbW1GXuo3hoXugVoun
         EFKEMiqmco60vrv/s7PCxLxpoBhaCQVmF43loq7bAqVw23dfco4sSt44621hKRkQ8TO9
         uk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716344921; x=1716949721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UQR7L7IeR8qz/nRM58REudhth61YMdGJiKJChX9kbI=;
        b=VDUXegUzH0glSc34l3jAcPbZQ2LFUEPPk8xbx1xiw5vcObOghBcfQljnaIQsVsjbbP
         MZSlittQVSbjLF1QaVHHNglvHpN2rTxY961oH2MZnW5iGYXxhrdPtrRqqFPQfjn3UUJg
         nkpcQBJGnh2EakZ14kTQb+uvZOi61P5fzFy+DMrZHbPAs8M8+k83Id2z46ZyxRJVwTPB
         rfkkVqax+e8PS4+lftihHWIf2mhxKaLBOmpl+6UP0pJdWK5Fw1WQ9pv/QCwzsKXh8+in
         a8C4TZ7l44mbdTkk03+mFuxmSBjEPq6Ad6e99HOeg6sk7awWUSR4ji9qdDYjNXHy2IDn
         NS3A==
X-Forwarded-Encrypted: i=1; AJvYcCWEDjOI8/m2qo//8xxYookKqoHlTHcXY96V7QV3nzfgT5luoM5NT/f6t6wD62XoEyn7twUEQo5G+/+BYyuGCO7+uWkoil1OV4f/azZp
X-Gm-Message-State: AOJu0YxTy0u8JVByxQZ3/qlHehzOLOB/KOAU26DPqfFwPE9rwFNUXhSL
	6qxOy8dmp0Sos+YvIv5Fb/7pSXraYzqhWmshDHayxABiPmwH9R+6AXZXWZzqYtCPSgiFWc72TOu
	i4A==
X-Google-Smtp-Source: AGHT+IFOo0EomRnvSty2EF4AepPhMj/lMUO8x2DSRQ64LdBqHmI5HFTl/IGL+l18xs+e4laGXFK2xAMdhpc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d04:b0:6f3:ead3:c280 with SMTP id
 d2e1a72fcca58-6f6d60c1e1cmr35160b3a.2.1716344920604; Tue, 21 May 2024
 19:28:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 21 May 2024 19:28:27 -0700
In-Reply-To: <20240522022827.1690416-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522022827.1690416-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240522022827.1690416-7-seanjc@google.com>
Subject: [PATCH v2 6/6] KVM: x86: Register "emergency disable" callbacks when
 virt is enabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Register the "disable virtualization in an emergency" callback just
before KVM enables virtualization in hardware, as there is no functional
need to keep the callbacks registered while KVM happens to be loaded, but
is inactive, i.e. if KVM hasn't enabled virtualization.

Note, unregistering the callback every time the last VM is destroyed could
have measurable latency due to the synchronize_rcu() needed to ensure all
references to the callback are dropped before KVM is unloaded.  But the
latency should be a small fraction of the total latency of disabling
virtualization across all CPUs, and userspace can set enable_virt_at_load
to completely eliminate the runtime overhead.

Add a pointer in kvm_x86_ops to allow vendor code to provide its callback.
There is no reason to force vendor code to do the registration, and either
way KVM would need a new kvm_x86_ops hook.

Suggested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/svm/svm.c          |  5 +----
 arch/x86/kvm/vmx/main.c         |  2 ++
 arch/x86/kvm/vmx/vmx.c          |  6 +-----
 arch/x86/kvm/vmx/x86_ops.h      |  1 +
 arch/x86/kvm/x86.c              | 10 ++++++++++
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index aabf1648a56a..66698f5bcc85 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -36,6 +36,7 @@
 #include <asm/kvm_page_track.h>
 #include <asm/kvm_vcpu_regs.h>
 #include <asm/hyperv-tlfs.h>
+#include <asm/reboot.h>
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
@@ -1613,6 +1614,8 @@ struct kvm_x86_ops {
 
 	int (*hardware_enable)(void);
 	void (*hardware_disable)(void);
+	cpu_emergency_virt_cb *emergency_disable;
+
 	void (*hardware_unsetup)(void);
 	bool (*has_emulated_msr)(struct kvm *kvm, u32 index);
 	void (*vcpu_after_set_cpuid)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3d0549ca246f..9c55d0c9cb59 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4952,6 +4952,7 @@ static void svm_vcpu_unblocking(struct kvm_vcpu *vcpu)
 static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.name = KBUILD_MODNAME,
 
+	.emergency_disable = svm_emergency_disable,
 	.check_processor_compatibility = svm_check_processor_compat,
 
 	.hardware_unsetup = svm_hardware_unsetup,
@@ -5389,8 +5390,6 @@ static struct kvm_x86_init_ops svm_init_ops __initdata = {
 static void __svm_exit(void)
 {
 	kvm_x86_vendor_exit();
-
-	cpu_emergency_unregister_virt_callback(svm_emergency_disable);
 }
 
 static int __init svm_init(void)
@@ -5406,8 +5405,6 @@ static int __init svm_init(void)
 	if (r)
 		return r;
 
-	cpu_emergency_register_virt_callback(svm_emergency_disable);
-
 	/*
 	 * Common KVM initialization _must_ come last, after this, /dev/kvm is
 	 * exposed to userspace!
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 7c546ad3e4c9..3f423afc263b 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -24,6 +24,8 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.hardware_enable = vmx_hardware_enable,
 	.hardware_disable = vmx_hardware_disable,
+	.emergency_disable = vmx_emergency_disable,
+
 	.has_emulated_msr = vmx_has_emulated_msr,
 
 	.vm_size = sizeof(struct kvm_vmx),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 51b2cd13250a..eac505299a7b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -753,7 +753,7 @@ static int kvm_cpu_vmxoff(void)
 	return -EIO;
 }
 
-static void vmx_emergency_disable(void)
+void vmx_emergency_disable(void)
 {
 	int cpu = raw_smp_processor_id();
 	struct loaded_vmcs *v;
@@ -8613,8 +8613,6 @@ static void __vmx_exit(void)
 {
 	allow_smaller_maxphyaddr = false;
 
-	cpu_emergency_unregister_virt_callback(vmx_emergency_disable);
-
 	vmx_cleanup_l1d_flush();
 }
 
@@ -8661,8 +8659,6 @@ static int __init vmx_init(void)
 		pi_init_cpu(cpu);
 	}
 
-	cpu_emergency_register_virt_callback(vmx_emergency_disable);
-
 	vmx_check_vmcs12_offsets();
 
 	/*
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 502704596c83..afddfe3747dd 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -15,6 +15,7 @@ void vmx_hardware_unsetup(void);
 int vmx_check_processor_compat(void);
 int vmx_hardware_enable(void);
 void vmx_hardware_disable(void);
+void vmx_emergency_disable(void);
 int vmx_vm_init(struct kvm *kvm);
 void vmx_vm_destroy(struct kvm *kvm);
 int vmx_vcpu_precreate(struct kvm *kvm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d750546ec934..84b34696a76c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12464,6 +12464,16 @@ void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_deliver_sipi_vector);
 
+void kvm_arch_enable_virtualization(void)
+{
+	cpu_emergency_register_virt_callback(kvm_x86_ops.emergency_disable);
+}
+
+void kvm_arch_disable_virtualization(void)
+{
+	cpu_emergency_unregister_virt_callback(kvm_x86_ops.emergency_disable);
+}
+
 int kvm_arch_hardware_enable(void)
 {
 	struct kvm *kvm;
-- 
2.45.0.215.g3402c0e53f-goog


