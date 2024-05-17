Return-Path: <linux-kernel+bounces-182471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C100F8C8B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769D8285E12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D413FD68;
	Fri, 17 May 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+ELswp3"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158C13FD61
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967657; cv=none; b=Cw5zcYDgLdkcriogh8Ohdd+WtjUMHAZ9YUvZyDjkjImcgM8ubNw/bHSEDqi8HtT8eyWYjDURUoxafdi+am155jGDW/YsRVpcqJ3c1Ep/unkNAGsN2cvcifRJIXI8IxQo/to/0uFw/FtQHag7wm6i7tST4Ba1UlRdoxCHz3/4w/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967657; c=relaxed/simple;
	bh=oLP6vBtnIMKcCmR9bxwe4hrP2Xb7UVn0Z2vROvuqDqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NpeQNIGF/DC9fQ45XnibzwWEpPBQfaW9Va/CNynFLiP237q0uslAebxGD6VCrpV1+W4ZNcOs0aKWIJkTyMt9woKxNQh7lY1H+KhLc64vj3ogZTF9Aplk2t/rTxe69fS/M0Zkjz2+ZS59DQDNGan00mGpWrlaZ18D/HGaHaimnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+ELswp3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f44e0a2756so7725004b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967655; x=1716572455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uRieiorDmTB4brnwf2TicwaCq2nIyXRKv7Z4oOjftbg=;
        b=k+ELswp3RsL4k7/WKR9cDVcmVhfkGs4atR6BG6V74QtwGLplxscsnva8ot90v/k7hS
         ibKQw4RrA/0uduSwP+6sY/Lm4IZ7Jyiv40zOpW9G38gNe8RJeFnROFw4FzMwTPJf90vr
         hn5DvBKDB0HZhCr6oH1pwcOjxPP5Gg/K0t/TIzDKe55FBFJHkhsp7to3FK0OXXMSE2AE
         CkS38ZD5pQvQNjkE6aIqpHmJ3yJCNbic9AxR75yHJxve49Um0LNl6q1r63de1v3qxWho
         KBKKQM3ioR2AOetv3GIuv4qyNRP1ktmAOd25YGgiAwIb1K9chE+U3v5c8tExwv6jNM+x
         LA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967655; x=1716572455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRieiorDmTB4brnwf2TicwaCq2nIyXRKv7Z4oOjftbg=;
        b=DNnToTBfwUud3LyqcpGNYE6qdksk37vryeZ55LQjJMrrfMF2J7y/LfZesX2BgJd5pH
         xegyMckoK6nE2DPfIfViAibrDuaMJ0fnZ2yX41grOGyZnJiWf33yoCaadtKQkk/xITsx
         +9ND7TRH0Xee4yhUpX+fIe+Dt9XpjmH4Cs2dFDIn20X9Xg+2+qJ7+WZaHRz8t6Mei/tq
         iruueyz5VQAvVtsj21ylk17BHeekZ7BBDrvQGNz5dTMjLV4fzs/lXtq3bGDpQOLhZVRB
         l/xeixSgGi82DzowiNlrFG1F2lNW034y4pXzJYCtYBWCJVdEoqQ21zBAFG5rBOCz1chY
         Ewlw==
X-Forwarded-Encrypted: i=1; AJvYcCWQjWPGDRmgCOcDs+dymkUVrMKdwuygeAWZYEzP0j8mpArcKyiLsv2rJIajmgD+ztCMVJyQNwKpSeU+8F0fRSNunJI2Otx+WSmW6rdM
X-Gm-Message-State: AOJu0YzntnHIwDjsGwMPCr3mkrqCDDaPc1r5MpU+JjojI+cyB14HHxNM
	hBQIGzVxCGtt1WonOuotJoBsXFMtGeuUpXOdWifgJVKoTbalzlaYzQiVjlW2+39J9XxTdFloyhD
	KgQ==
X-Google-Smtp-Source: AGHT+IHjSMKPVawNw4dXwgcSiXKdKSYh3w600Z14yaES8icm49snxaowgCc3DnGBB9emq10yB4jmeYnLOBg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:7107:b0:6ed:36e2:9d0c with SMTP id
 d2e1a72fcca58-6f4c890652dmr86249b3a.0.1715967655103; Fri, 17 May 2024
 10:40:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:15 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-39-seanjc@google.com>
Subject: [PATCH v2 38/49] KVM: x86: Initialize guest cpu_caps based on guest CPUID
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Initialize a vCPU's capabilities based on the guest CPUID provided by
userspace instead of simply zeroing the entire array.  This is the first
step toward using cpu_caps to query *all* CPUID-based guest capabilities,
i.e. will allow converting all usage of guest_cpuid_has() to
guest_cpu_cap_has().

Zeroing the array was the logical choice when using cpu_caps was opt-in,
e.g. "unsupported" was generally a safer default, and the whole point of
governed features is that KVM would need to check host and guest support,
i.e. making everything unsupported by default didn't require more code.

But requiring KVM to manually "enable" every CPUID-based feature in
cpu_caps would require an absurd amount of boilerplate code.

Follow existing CPUID/kvm_cpu_caps nomenclature where possible, e.g. for
the change() and clear() APIs.  Replace check_and_set() with constrain()
to try and capture that KVM is constraining userspace's desired guest
feature set based on KVM's capabilities.

This is intended to be gigantic nop, i.e. should not have any impact on
guest or KVM functionality.

This is also an intermediate step; a future commit will also incorporate
KVM support into the vCPU's cpu_caps before converting guest_cpuid_has()
to guest_cpu_cap_has().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c   | 46 ++++++++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/cpuid.h   | 25 ++++++++++++++++++++---
 arch/x86/kvm/svm/svm.c | 28 +++++++++++++------------
 arch/x86/kvm/vmx/vmx.c |  8 +++++---
 4 files changed, 86 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 89c506cf649b..fd725cbbcce5 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -381,13 +381,56 @@ static bool kvm_cpuid_has_hyperv(struct kvm_vcpu *vcpu)
 #endif
 }
 
+/*
+ * This isn't truly "unsafe", but except for the cpu_caps initialization code,
+ * all register lookups should use __cpuid_entry_get_reg(), which provides
+ * compile-time validation of the input.
+ */
+static u32 cpuid_get_reg_unsafe(struct kvm_cpuid_entry2 *entry, u32 reg)
+{
+	switch (reg) {
+	case CPUID_EAX:
+		return entry->eax;
+	case CPUID_EBX:
+		return entry->ebx;
+	case CPUID_ECX:
+		return entry->ecx;
+	case CPUID_EDX:
+		return entry->edx;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
 void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	struct kvm_cpuid_entry2 *best;
+	struct kvm_cpuid_entry2 *entry;
 	bool allow_gbpages;
+	int i;
 
 	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
+	BUILD_BUG_ON(ARRAY_SIZE(reverse_cpuid) != NR_KVM_CPU_CAPS);
+
+	/*
+	 * Reset guest capabilities to userspace's guest CPUID definition, i.e.
+	 * honor userspace's definition for features that don't require KVM or
+	 * hardware management/support (or that KVM simply doesn't care about).
+	 */
+	for (i = 0; i < NR_KVM_CPU_CAPS; i++) {
+		const struct cpuid_reg cpuid = reverse_cpuid[i];
+
+		if (!cpuid.function)
+			continue;
+
+		entry = kvm_find_cpuid_entry_index(vcpu, cpuid.function, cpuid.index);
+		if (!entry)
+			continue;
+
+		vcpu->arch.cpu_caps[i] = cpuid_get_reg_unsafe(entry, cpuid.reg);
+	}
 
 	kvm_update_cpuid_runtime(vcpu);
 
@@ -404,8 +447,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	allow_gbpages = tdp_enabled ? boot_cpu_has(X86_FEATURE_GBPAGES) :
 				      guest_cpuid_has(vcpu, X86_FEATURE_GBPAGES);
-	if (allow_gbpages)
-		guest_cpu_cap_set(vcpu, X86_FEATURE_GBPAGES);
+	guest_cpu_cap_change(vcpu, X86_FEATURE_GBPAGES, allow_gbpages);
 
 	best = kvm_find_cpuid_entry(vcpu, 1);
 	if (best && apic) {
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index ad0168d3aec5..c2c2b8aa347b 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -265,11 +265,30 @@ static __always_inline void guest_cpu_cap_set(struct kvm_vcpu *vcpu,
 	vcpu->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
 }
 
-static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcpu *vcpu,
-							unsigned int x86_feature)
+static __always_inline void guest_cpu_cap_clear(struct kvm_vcpu *vcpu,
+						unsigned int x86_feature)
 {
-	if (kvm_cpu_cap_has(x86_feature) && guest_cpuid_has(vcpu, x86_feature))
+	unsigned int x86_leaf = __feature_leaf(x86_feature);
+
+	reverse_cpuid_check(x86_leaf);
+	vcpu->arch.cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
+}
+
+static __always_inline void guest_cpu_cap_change(struct kvm_vcpu *vcpu,
+						 unsigned int x86_feature,
+						 bool guest_has_cap)
+{
+	if (guest_has_cap)
 		guest_cpu_cap_set(vcpu, x86_feature);
+	else
+		guest_cpu_cap_clear(vcpu, x86_feature);
+}
+
+static __always_inline void guest_cpu_cap_constrain(struct kvm_vcpu *vcpu,
+						    unsigned int x86_feature)
+{
+	if (!kvm_cpu_cap_has(x86_feature))
+		guest_cpu_cap_clear(vcpu, x86_feature);
 }
 
 static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2acd2e3bb1b0..1bc431a7e862 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4339,27 +4339,29 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * XSS on VM-Enter/VM-Exit.  Failure to do so would effectively give
 	 * the guest read/write access to the host's XSS.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
-	    boot_cpu_has(X86_FEATURE_XSAVES) &&
-	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
-		guest_cpu_cap_set(vcpu, X86_FEATURE_XSAVES);
+	guest_cpu_cap_change(vcpu, X86_FEATURE_XSAVES,
+			     boot_cpu_has(X86_FEATURE_XSAVE) &&
+			     boot_cpu_has(X86_FEATURE_XSAVES) &&
+			     guest_cpuid_has(vcpu, X86_FEATURE_XSAVE));
 
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_NRIPS);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_TSCRATEMSR);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_LBRV);
+	guest_cpu_cap_constrain(vcpu, X86_FEATURE_NRIPS);
+	guest_cpu_cap_constrain(vcpu, X86_FEATURE_TSCRATEMSR);
+	guest_cpu_cap_constrain(vcpu, X86_FEATURE_LBRV);
 
 	/*
 	 * Intercept VMLOAD if the vCPU mode is Intel in order to emulate that
 	 * VMLOAD drops bits 63:32 of SYSENTER (ignoring the fact that exposing
 	 * SVM on Intel is bonkers and extremely unlikely to work).
 	 */
-	if (!guest_cpuid_is_intel(vcpu))
-		guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
+	if (guest_cpuid_is_intel(vcpu))
+		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
+	else
+		guest_cpu_cap_constrain(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_PAUSEFILTER);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_PFTHRESHOLD);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_VGIF);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_VNMI);
+	guest_cpu_cap_constrain(vcpu, X86_FEATURE_PAUSEFILTER);
+	guest_cpu_cap_constrain(vcpu, X86_FEATURE_PFTHRESHOLD);
+	guest_cpu_cap_constrain(vcpu, X86_FEATURE_VGIF);
+	guest_cpu_cap_constrain(vcpu, X86_FEATURE_VNMI);
 
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1bc56596d653..d873386e1473 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7838,10 +7838,12 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
 	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
-		guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_XSAVES);
+		guest_cpu_cap_constrain(vcpu, X86_FEATURE_XSAVES);
+	else
+		guest_cpu_cap_clear(vcpu, X86_FEATURE_XSAVES);
 
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_VMX);
-	guest_cpu_cap_check_and_set(vcpu, X86_FEATURE_LAM);
+	guest_cpu_cap_constrain(vcpu, X86_FEATURE_VMX);
+	guest_cpu_cap_constrain(vcpu, X86_FEATURE_LAM);
 
 	vmx_setup_uret_msrs(vmx);
 
-- 
2.45.0.215.g3402c0e53f-goog


