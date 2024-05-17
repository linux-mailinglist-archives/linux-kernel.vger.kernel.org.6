Return-Path: <linux-kernel+bounces-182473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3748C8B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24AD1C21810
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5A1586CB;
	Fri, 17 May 2024 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkMQY6Rn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC0157A45
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967661; cv=none; b=BU/Fqznfzq3GOy5NuXMb9pw3pE9xXjMEsmHVckh4I9dyQuF1suN3c7NCv/7UyZXiUPHM+Aw35V+kAoXj6OXttd+/VBmFHaDEeCah53EiOinxCDLk7nMG+zNeFJNCss6PQD0r3u/XlIiwJq2jG7PutTTiL+U/hgO3SNGm0h0yWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967661; c=relaxed/simple;
	bh=kI1V8iWtDCi3gaGLgIqfWqUEd9o1y7KFkaDu4zsWU9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yqjh6Gzl4fX0nLBNaqvC7dzK5hokZvYtLz3PiR2Pns4YnvUw7Uvkmru9vryO/U1RLqfJgc4FJp7Wosd1Tnrau/uvetBpKlrJyOWaztsPb2YOswpHF0yfkv24O+tWhbjmjyKXJia+Z1SpuNXIZALt01T8f/Mr1av2bsssoI8Zas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkMQY6Rn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ec5efb0a33so102261555ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967659; x=1716572459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4+vEQpXYFAV6v26K1r1y7x6SNSckikiSt0V6msMx5VQ=;
        b=HkMQY6Rn2Rz/rGsG1MKB2OwzrKjDAddvm83Oy7Gcpk0EQrXDyim0v+ZQjsB/SMtpWA
         4wpAoZyu3e5dqfgVyx2hq7vuD4HfD4xXCd7JkM0Mj58A340XHicA1WtXx5sNu7+rCzi8
         Ny1Coc+M0/F4o5UkF9WFruVSX6LKpwWRTN8kq5gH9BsMELuEX4nPRhWX2bfQaOF3NH3v
         KgsNgN0eu6qUgBEPpxgM/ORyNdVAhEOOCkUbCBJzWfe5OobGDOCy0pRG3VYFQLzbut1P
         4CatV66ZaSGI79Arh6x0nZBoTKIzpDivg/vq0Rz+xwHjvo0TaH46kDtiNTWhx9tFsIPR
         Li2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967659; x=1716572459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+vEQpXYFAV6v26K1r1y7x6SNSckikiSt0V6msMx5VQ=;
        b=Fc4q+rRPFwGbY+y4S33aFC5JWK7XPqQSfs82STxjfhtQVGiqu9/+p8LYtz/U3ZKiIl
         RKVKfM4uGAZB4+q3kSvJ31SGyf7OajaORWvPUfwVpmFVjxytbUO7jSFUY5wacVQ62C8f
         mpSjCJxcM2QkCN/4sg6uZcKH7scaxs8BVzZLkTZWPafeYZNRtz6wm2lYqesuej/SrZZv
         KwETYpfcP/ybwATcFLYuOj4aGjq3yuDcZQBZT39RDzFyCNczAI7VrPWYW52CmVZjAGYz
         WEPusZjK4SzRNYj01B58FWh3+Z21A0ULwK5QBxj3R32v28eW+4WHgzgsXIFo4a4bZzvo
         +Dsw==
X-Forwarded-Encrypted: i=1; AJvYcCW44D4CFA4IZ2H0edamxkdI1cyRtB/5s1iSzIFo98VV/SWtprZP8HBuC78ggcI1vNgdWLZWqrO4O62KEBPFShkycu6cfPwv4sTGhViM
X-Gm-Message-State: AOJu0Yz+alC9vc47YU26ROImEZtXynLjKro3sHLdO/XPjBjHOXtwpUpf
	3zz994XAfViqNDc/UeEUjE7Px7zZhMVG4R2kQCKlzzY8IfbTJrxTDFU2QBiTLByE11qm9oSnkvQ
	uzQ==
X-Google-Smtp-Source: AGHT+IGVmngpFAiyErMvUjSPcvd+ZZOiDuP1pjBcsRxsnrKfM6mt8IfEJP2qYQGnfGBKkfzs+fzMKw3EQmI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e88d:b0:1e8:a7fb:c1fc with SMTP id
 d9443c01a7336-1ef43d170c0mr16960645ad.5.1715967659453; Fri, 17 May 2024
 10:40:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:17 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-41-seanjc@google.com>
Subject: [PATCH v2 40/49] KVM: x86: Initialize guest cpu_caps based on KVM support
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
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
 arch/x86/kvm/cpuid.c   | 14 +++++++++++++-
 arch/x86/kvm/cpuid.h   |  7 -------
 arch/x86/kvm/svm/svm.c | 11 -----------
 arch/x86/kvm/vmx/vmx.c |  9 ++-------
 4 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index d1849fe874ab..8ada1cac8fcb 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -403,6 +403,8 @@ static u32 cpuid_get_reg_unsafe(struct kvm_cpuid_entry2 *entry, u32 reg)
 	}
 }
 
+static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func);
+
 void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
@@ -421,6 +423,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	for (i = 0; i < NR_KVM_CPU_CAPS; i++) {
 		const struct cpuid_reg cpuid = reverse_cpuid[i];
+		struct kvm_cpuid_entry2 emulated;
 
 		if (!cpuid.function)
 			continue;
@@ -429,7 +432,16 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		if (!entry)
 			continue;
 
-		vcpu->arch.cpu_caps[i] = cpuid_get_reg_unsafe(entry, cpuid.reg);
+		cpuid_func_emulated(&emulated, cpuid.function);
+
+		/*
+		 * A vCPU has a feature if it's supported by KVM and is enabled
+		 * in guest CPUID.  Note, this includes features that are
+		 * supported by KVM but aren't advertised to userspace!
+		 */
+		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i] | kvm_vmm_cpu_caps[i] |
+					 cpuid_get_reg_unsafe(&emulated, cpuid.reg);
+		vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
 	}
 
 	kvm_update_cpuid_runtime(vcpu);
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index c2c2b8aa347b..60da304db4e4 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -284,13 +284,6 @@ static __always_inline void guest_cpu_cap_change(struct kvm_vcpu *vcpu,
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
index 1bc431a7e862..946a75771946 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4344,10 +4344,6 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 			     boot_cpu_has(X86_FEATURE_XSAVES) &&
 			     guest_cpuid_has(vcpu, X86_FEATURE_XSAVE));
 
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_NRIPS);
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_TSCRATEMSR);
-	guest_cpu_cap_constrain(vcpu, X86_FEATURE_LBRV);
-
 	/*
 	 * Intercept VMLOAD if the vCPU mode is Intel in order to emulate that
 	 * VMLOAD drops bits 63:32 of SYSENTER (ignoring the fact that exposing
@@ -4355,13 +4351,6 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	if (guest_cpuid_is_intel(vcpu))
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
index d873386e1473..653c4b68ec7f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7836,15 +7836,10 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
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
2.45.0.215.g3402c0e53f-goog


