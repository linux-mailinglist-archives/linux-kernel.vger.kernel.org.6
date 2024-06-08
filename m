Return-Path: <linux-kernel+bounces-206846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE69900EB4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15140284F9D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D2C20322;
	Sat,  8 Jun 2024 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWddpbZ4"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA01CD00
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717805217; cv=none; b=nVTGCJKYbZ9MIRNKEOD09jEX+Vpuj7d2ZbWR9iNJzoE+s2B5r7RLV5PQLsxV/8QZJ4y0Xrfj5Lo2EmT5ZPMleCQ9TFbA+7oEAdrogd7H+Ko7bd9KK0lucv3CEfKJq/bFE4DguVlrTJwos97YEAnwxAQc1LpRRQsmGKGodVR7ubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717805217; c=relaxed/simple;
	bh=6kqkQOeGxQkn53M2KEHk2/M5zGfJ/Ga7YB5xxnYelGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fGTKBDDLYun9TPm8Hc0Svl94Fi48rFeNLfXUF7A9VHzJn6Mt+mAgl9iOOFd5pded+U3zNWkCpv3WnHhHFj0lXr0Ftz5bKo0gISCdCSpNU1lnD0fieHfGu4Roq1gXUBg7TngH7dKFF8gsGfSHfSqogLn/dmF6piJV9FSek/deVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWddpbZ4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c283f190c1so1584459a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 17:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717805215; x=1718410015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8TLSuBEX+P1/sjGRLpoZ3jVRlThdpta5sXvxaIB45Jk=;
        b=wWddpbZ4NNK+xZm6K4oME+hEJvZJ+WfSyIovRMr2M51RD9gtmbadFOonWIjsRgcrO4
         NYkF4+WolMVXh9r++3y76uX9bb9+s3ddeCO/ysOAo+LW7qrNxshyC7dqPBpH7T68DkGn
         ig7nJGpzMhK2Tew8SVrvwOR76DipTvaR4dPPa8M43WvI6A6lpJul/ERXZvcJAYTBYf8O
         Kr3lExfseSj8FU/jnEDBav1kgL8n42lbPpqPjLdhG2huQ9wCPXF7NHG6p53cVTk3dd1O
         qvMRZfLw6r1kCPxjElGOEdxkZ9xjgNgi1VmVyj6DhorCoxszTN9x9zuMdlak0uh3lCS8
         c+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717805215; x=1718410015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TLSuBEX+P1/sjGRLpoZ3jVRlThdpta5sXvxaIB45Jk=;
        b=cclcULdZv8uH2TSXG2Okgn1i2SgZCgkhXvf5QRJrkfsoE9/7I44Lvx6CAtjLDwzG5c
         BSkCbm5g9TvGx0qbYMoHA8uv6trvqjl90QSXYWgQvNPcYosb8NTOjIIVnthkW5FePehi
         I5s4xzaCOZzJsrnT4V8tGogjKXQjOCjEQqqnLowzpWiCDGvH0v2E6Vsc5a8TlqKOBii9
         zbtyteLIueh09yEiS59wHgodLUQMMeT/Fo+ute+vRVhQrd8vRnIANA99rhmFle8/VgZM
         J0RdBfhuRcUxyqA5M+GDMXt7LW0f2yvoryc6K9DWiqfuHIgNShpW70kRHn7IJpgIsooN
         PTtg==
X-Forwarded-Encrypted: i=1; AJvYcCUn5Up7RrC/9j182QPtXG72Xgu4T0gPM5zGVmJ6Y62pkc6LCJksvtbLYi/iuwPhXkEm6R4tvAPgZpqY5qsG9rJLWKRsCwvBOtRbHUE0
X-Gm-Message-State: AOJu0YyJyjeAuNmmZpbk3N/07mOjnt1us6Lv0SVpXaixrDR2UgewHnps
	qwM9hm7ykCSw17Jilkxb0xDEq84jzPaJKbgWyBeB0b0xpeYsLEHbAu0tbQThRQvhqvs3/xtI2Sj
	C7w==
X-Google-Smtp-Source: AGHT+IH6oAmMG/Wy9I2jAo5gtN27DcalJ0mI7IJVMh6HVM6DDOqHPpelfrT7QwFjts8KL4lgLd9pZv42vrw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5d16:b0:2c2:d6e5:535f with SMTP id
 98e67ed59e1d1-2c2d6e55433mr2867a91.8.1717805215021; Fri, 07 Jun 2024 17:06:55
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  7 Jun 2024 17:06:38 -0700
In-Reply-To: <20240608000639.3295768-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240608000639.3295768-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240608000639.3295768-8-seanjc@google.com>
Subject: [PATCH v3 7/8] KVM: x86: Register "emergency disable" callbacks when
 virt is enabled
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
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
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
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
index 5c0415899a07..a4444b43f575 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -36,6 +36,7 @@
 #include <asm/kvm_page_track.h>
 #include <asm/kvm_vcpu_regs.h>
 #include <asm/hyperv-tlfs.h>
+#include <asm/reboot.h>
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
@@ -1626,6 +1627,8 @@ struct kvm_x86_ops {
 
 	int (*hardware_enable)(void);
 	void (*hardware_disable)(void);
+	cpu_emergency_virt_cb *emergency_disable;
+
 	void (*hardware_unsetup)(void);
 	bool (*has_emulated_msr)(struct kvm *kvm, u32 index);
 	void (*vcpu_after_set_cpuid)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d33193d522e3..aa0aeb185d17 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4981,6 +4981,7 @@ static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
 static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.name = KBUILD_MODNAME,
 
+	.emergency_disable = svm_emergency_disable,
 	.check_processor_compatibility = svm_check_processor_compat,
 
 	.hardware_unsetup = svm_hardware_unsetup,
@@ -5416,8 +5417,6 @@ static struct kvm_x86_init_ops svm_init_ops __initdata = {
 static void __svm_exit(void)
 {
 	kvm_x86_vendor_exit();
-
-	cpu_emergency_unregister_virt_callback(svm_emergency_disable);
 }
 
 static int __init svm_init(void)
@@ -5433,8 +5432,6 @@ static int __init svm_init(void)
 	if (r)
 		return r;
 
-	cpu_emergency_register_virt_callback(svm_emergency_disable);
-
 	/*
 	 * Common KVM initialization _must_ come last, after this, /dev/kvm is
 	 * exposed to userspace!
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d0e1a5b5c915..45d6b5ad2da3 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -25,6 +25,8 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.hardware_enable = vmx_hardware_enable,
 	.hardware_disable = vmx_hardware_disable,
+	.emergency_disable = vmx_emergency_disable,
+
 	.has_emulated_msr = vmx_has_emulated_msr,
 
 	.vm_size = sizeof(struct kvm_vmx),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0e3aaf520db2..7edbd4e5758e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -754,7 +754,7 @@ static int kvm_cpu_vmxoff(void)
 	return -EIO;
 }
 
-static void vmx_emergency_disable(void)
+void vmx_emergency_disable(void)
 {
 	int cpu = raw_smp_processor_id();
 	struct loaded_vmcs *v;
@@ -8603,8 +8603,6 @@ static void __vmx_exit(void)
 {
 	allow_smaller_maxphyaddr = false;
 
-	cpu_emergency_unregister_virt_callback(vmx_emergency_disable);
-
 	vmx_cleanup_l1d_flush();
 }
 
@@ -8651,8 +8649,6 @@ static int __init vmx_init(void)
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
index 4157602c964e..e4bdb42a9b00 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12478,6 +12478,16 @@ void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
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
2.45.2.505.gda0bf45e8d-goog


