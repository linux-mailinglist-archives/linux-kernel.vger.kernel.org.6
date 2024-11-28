Return-Path: <linux-kernel+bounces-424157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F59DB11E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B937C280DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1781CBEA0;
	Thu, 28 Nov 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zzjPRRjp"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA831C9EC2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757751; cv=none; b=tQbCnNlQtowRaI2+OIZTya5OjTBYtrdHzhkpDsr8y3uczjA8uBLpKSmVoxQX8E98WN4FI0iR45m4id6yyCg+J1YdLo6AfrmREDrDMuZKzjgjL1dVwIE5q8Obd8/aO+s8/+EkSUHktBj4RayTvfMF4NY6cO+It4BNIu5hczdRT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757751; c=relaxed/simple;
	bh=AhzkXtmCCM2uzNkbc1wKogSBqvYhkXQzLU3RFLMop8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AX628dZOV6uBX0hKZzMdchK1Z6RhDnw4ti82VAOYqkQmSGHAFy0gbw3SfFqs5kPDoXXY7Ld0RHohW+6nrsPJjnWhvOrwNC+l+SmOVI88UNubbapYGg8s0mOBQDiAC1Re2+jyjWM67uVczJWWLyR9Raq/bQwIqeQuNGMtI8yNj2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zzjPRRjp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee0c9962daso354441a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757749; x=1733362549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oX4zoA92uX/TiwHEJXa6fKLIdOdEnfDXoZc1BynGc94=;
        b=zzjPRRjpb61nqCznY61COVXXsVjcVN59XMGGDgbHDtP3OeTLyw0KbV9DLWUZNvIAtc
         PxYWagO3mSXqeWxs/8ODv3eUkpI35pzX3EyXg/9nV53WNSdMNXFMzm3POy4VmnGcMN6U
         TU0FtsmRV9Tn6aUxOoaPomdRblcTaDsKbSRENMdKNSPnPuppw1cyR3zBU0Ff7kS41jl8
         4wLGwcGVH1iWFYxW4Kmitj6/yYDVDyBpb3BabwQ9IYknaUbGRt89dfCvCUQAW6RZG09T
         rNVY8fiq/7ZJvGertMVxHM9d6A/BfsvblnOh5W2VpyBT9h+veUgQ4G6pAIrA0v7DwcW9
         qxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757749; x=1733362549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oX4zoA92uX/TiwHEJXa6fKLIdOdEnfDXoZc1BynGc94=;
        b=j4DMH0dU19yT3LwDlbR5jRT6e2x/4u0y0tl+KqpVcehDAM6GZwHCiqOeI0J1viTHQu
         iPvQlERXv3ooOHCGV/TgFXkyOiQtkB4BAqV0aJs4LIWZU5XtA6z4XJSzJsJ0GJQFuGNq
         sMgIdbEf2ZgWIzqfIrQQFdTx+35P7SW9JkP8mp1encibhdvzeycbz/6zf5n2Y0Au38zY
         mf1Qo+BQJXKUtongIFhL6teMjrNTFbBAu9oMEOdi7t3VRuqQQL+6ca2/S+dYLpmjD3M0
         2JDNDd33TZGhdARoLkJgIwoCn0T7VAlULFsE9exsQsYtRBAq+PeZ80l2kGvVA8CEPbbI
         F1mw==
X-Forwarded-Encrypted: i=1; AJvYcCUn8aPI61iN+AjAJFdjkWziW4lr5tiTpTQruUokc/qFsSDu4usUXTMYE2yW/3l8gUT/g9W0LuC+6YKJYMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwS4UbP7Q9OEJFbW0jOZS0yoXjpDfSZ1VUVU4eyKdUf7AcLDG
	huA2JmHMXIZ0OXRFXyZfsjn9V8w/Pf0qtqVGF8lITsS084n/Gp2nFWgEkhQEex2cwYHLrGR8cmW
	h/g==
X-Google-Smtp-Source: AGHT+IHqiBW7ylFioQH9r/0FDeS4VWt48HcfPZ5KbrnqgDIhirizajDMmTT+yUaR52RQ2Ssu5wGSCgPDzk0=
X-Received: from pjbqn15.prod.google.com ([2002:a17:90b:3d4f:b0:2e0:aba3:662a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c04:b0:2ea:3a13:4916
 with SMTP id 98e67ed59e1d1-2ee08e9980emr6733033a91.6.1732757748712; Wed, 27
 Nov 2024 17:35:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:34:11 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-45-seanjc@google.com>
Subject: [PATCH v3 44/57] KVM: x86: Initialize guest cpu_caps based on KVM support
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: kvm@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Constrain all guest cpu_caps based on KVM support instead of constraining
only the few features that KVM _currently_ needs to verify are actually
supported by KVM.  The intent of cpu_caps is to track what the guest is
actually capable of using, not the raw, unfiltered CPUID values that the
guest sees.

I.e. KVM should always consult it's only support when making decisions
based on guest CPUID, and the only reason KVM has historically made the
checks opt-in was due to lack of centralized tracking.

Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c   | 15 ++++++++++++++-
 arch/x86/kvm/cpuid.h   |  7 -------
 arch/x86/kvm/svm/svm.c | 11 -----------
 arch/x86/kvm/vmx/vmx.c |  9 ++-------
 4 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0c63492f119d..8015d6b52a69 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -355,6 +355,9 @@ static u32 cpuid_get_reg_unsafe(struct kvm_cpuid_entry2 *entry, u32 reg)
 	}
 }
 
+static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
+			       bool include_partially_emulated);
+
 void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
@@ -373,6 +376,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	for (i = 0; i < NR_KVM_CPU_CAPS; i++) {
 		const struct cpuid_reg cpuid = reverse_cpuid[i];
+		struct kvm_cpuid_entry2 emulated;
 
 		if (!cpuid.function)
 			continue;
@@ -381,7 +385,16 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		if (!entry)
 			continue;
 
-		vcpu->arch.cpu_caps[i] = cpuid_get_reg_unsafe(entry, cpuid.reg);
+		cpuid_func_emulated(&emulated, cpuid.function, true);
+
+		/*
+		 * A vCPU has a feature if it's supported by KVM and is enabled
+		 * in guest CPUID.  Note, this includes features that are
+		 * supported by KVM but aren't advertised to userspace!
+		 */
+		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i] |
+					 cpuid_get_reg_unsafe(&emulated, cpuid.reg);
+		vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
 	}
 
 	kvm_update_cpuid_runtime(vcpu);
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 8c9d6be8cb58..27da0964355c 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -263,13 +263,6 @@ static __always_inline void guest_cpu_cap_change(struct kvm_vcpu *vcpu,
 		guest_cpu_cap_clear(vcpu, x86_feature);
 }
 
-static __always_inline void guest_cpu_cap_constrain(struct kvm_vcpu *vcpu,
-						    unsigned int x86_feature)
-{
-	if (!kvm_cpu_cap_has(x86_feature))
-		guest_cpu_cap_clear(vcpu, x86_feature);
-}
-
 static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
 					      unsigned int x86_feature)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3b94cb6c2b7a..0045fe474023 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4406,10 +4406,6 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 			     boot_cpu_has(X86_FEATURE_XSAVES) &&
 			     guest_cpuid_has(vcpu, X86_FEATURE_XSAVE));
 
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_NRIPS);
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_TSCRATEMSR);
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_LBRV);
-
 	/*
 	 * Intercept VMLOAD if the vCPU model is Intel in order to emulate that
 	 * VMLOAD drops bits 63:32 of SYSENTER (ignoring the fact that exposing
@@ -4417,13 +4413,6 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	if (guest_cpuid_is_intel_compatible(vcpu))
 		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
-	else
-		guest_cpu_cap_constrain(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
-
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_PAUSEFILTER);
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_PFTHRESHOLD);
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_VGIF);
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_VNMI);
 
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8b95ba323a17..a7c2c36f2a4f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7828,15 +7828,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
 	 * set if and only if XSAVE is supported.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
-	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
-		guest_cpu_cap_constrain(vcpu, X86_FEATURE_XSAVES);
-	else
+	if (!boot_cpu_has(X86_FEATURE_XSAVE) ||
+	    !guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
 		guest_cpu_cap_clear(vcpu, X86_FEATURE_XSAVES);
 
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_VMX);
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_LAM);
-
 	vmx_setup_uret_msrs(vmx);
 
 	if (cpu_has_secondary_exec_ctrls())
-- 
2.47.0.338.g60cca15819-goog


