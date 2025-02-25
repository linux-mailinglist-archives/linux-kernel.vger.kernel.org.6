Return-Path: <linux-kernel+bounces-530323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0015CA43212
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B89E3A8399
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474642571B4;
	Tue, 25 Feb 2025 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ue3Zy9F4"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5915E96
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444443; cv=none; b=plgWeRaEs2a2QqUjWQo5PtiWzqlMzrfEntjHFf0rumzVLX51+I9kevW6OBmFtSgoIA4XFBzN0wODyClQ7ObJeCIGG7anruK36j3oHqqJLF8u7mSIVlmUgbJ+Lh75qFPaL1xBO/JQ/TLNo18kTIybR/Aa/sdarWBvdgyV38Sbqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444443; c=relaxed/simple;
	bh=9VyoE5rqBPdWDwAYMqaw+sWflGZ3yC3uju/Z14kM9NY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bx1mD9qvGUsdMrfSs+liniPHtbV/y9MBPxZZPRAIorpZl9pTVLMWOJnxXvNbUIGpQ9+U/Dj7bxjxgyB6hH1bjjynNrHqMRq2M+Jc5VojZg+5R+Umm97HzqTw0i/xjl404gMXH1/k7FAtwN5UiwqMjUCnu9uVggZJ1nUxTY2BmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ue3Zy9F4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fce2954a10so13886315a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740444441; x=1741049241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LLn0ouDWavOo+k23cGEFyx3GWlevLRlbuFWAFagmycY=;
        b=ue3Zy9F4/lVYxCTqL1P2UsOLfyLvZMzv2LJENCSTrfWocqFa5PNhSNEwvB5xsOavbr
         mo4TOHMJa3zA9pcVVsRUe7Ve06Fepwqv16m2IaMRMcbjxoAl9OdsF9KoWNQmBH6Xe9iq
         8IGUd0xDz8PFqqwsq+mYo2Wi3G3TUSiaMqO9A7dTCu0jn2gM3SUO1gVj4veXuKMAv1M3
         rcmbXibEDBbVUNgyHnvDgUj4FZUKNZ4XnfRP1iot+7pyQnWANIbd4p0UvvJJxdMhQUqv
         AjBxXVH37wiBRGGHs59fnSNv7MKAW9wlWug7ogJVbWwuqJO5lafwa3VPpec0MfwC3mQd
         X62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740444441; x=1741049241;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLn0ouDWavOo+k23cGEFyx3GWlevLRlbuFWAFagmycY=;
        b=wGikZJG4bcEz+UUxREe+f03zx6C/H9WL8qJ+DSUsNsU4MPS6ocEUoqdnBenK6v3xyU
         ZMtJNQ+D809+q50xTtGuXp2oZY+bJgD0sOCFs7W1S6ZkHY9MYAI8uiERwFTwtVaBj3s6
         +g6m3fpV3olBAI/fRICmrGF5ETA/p052L5XMkMrFHoqLsaXKaAb6ycDFUDvy/CQYSs3O
         Sz7YwIdfge6xbMDOsUpfLxpwOL4tmc2FHY7jMGaFCYIh0kMPpkSIVw3icK2C2CtvLfQO
         cFiT02eMUPgIymPMnngO41NafNDawyRHWgpx/O/HNvY3k5DuakwFZ1rLfDFVZ1Xhdnfw
         95XQ==
X-Gm-Message-State: AOJu0YxUBsAUoA4wMxqr5luhQaJh6BqCXX9Kp4Dyq8lI2d31LvmZKGG2
	5+LkB4kPctm62pqh2h8A9UUmx0+4LO5GHrBWXGORazrbQ2OiQfJHYLkNE2pHGNFLB/ClWEhHX/V
	ge2YDfEcFbMVjQCsvB4S64GAzv6aROFl8XpzCqQiCb1+ktPaRAwRojxr3y54w95mdJWIVGXy7d0
	5d6umCBHgoXv9XMx9AW6OlKfdHHpzexhlt7mIGJ8S85HIQpPNklfo=
X-Google-Smtp-Source: AGHT+IGjTB7OqTkNMNzcfyv0LdWUXTWhbdIyRa+cJKyKRwTrcEIT6xduBck8PQaOscdeB6AJZA6OXuOCQQ8MTQ==
X-Received: from pjbqx15.prod.google.com ([2002:a17:90b:3e4f:b0:2fc:3022:36b8])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b83:b0:2f6:d266:f45c with SMTP id 98e67ed59e1d1-2fce868c637mr26094804a91.2.1740444440607;
 Mon, 24 Feb 2025 16:47:20 -0800 (PST)
Date: Mon, 24 Feb 2025 16:45:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225004708.1001320-1-jmattson@google.com>
Subject: [PATCH] KVM: x86: Provide a capability to disable APERF/MPERF read intercepts
From: Jim Mattson <jmattson@google.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow a guest to read the physical IA32_APERF and IA32_MPERF MSRs
without interception.

The IA32_APERF and IA32_MPERF MSRs are not virtualized. Writes are not
handled at all. The MSR values are not zeroed on vCPU creation, saved
on suspend, or restored on resume. No accommodation is made for
processor migration or for sharing a logical processor with other
tasks. No adjustments are made for non-unit TSC multipliers. The MSRs
do not account for time the same way as the comparable PMU events,
whether the PMU is virtualized by the traditional emulation method or
the new mediated pass-through approach.

Nonetheless, in a properly constrained environment, this capability
can be combined with a guest CPUID table that advertises support for
CPUID.6:ECX.APERFMPERF[bit 0] to induce a Linux guest to report the
effective physical CPU frequency in /proc/cpuinfo. Moreover, there is
no performance cost for this capability.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 Documentation/virt/kvm/api.rst  | 1 +
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/svm/svm.c          | 7 +++++++
 arch/x86/kvm/svm/svm.h          | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 4 ++++
 arch/x86/kvm/x86.c              | 7 +++++--
 arch/x86/kvm/x86.h              | 5 +++++
 include/uapi/linux/kvm.h        | 1 +
 tools/include/uapi/linux/kvm.h  | 4 +++-
 9 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 2b52eb77e29c..6431cd33f06a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7684,6 +7684,7 @@ Valid bits in args[0] are::
   #define KVM_X86_DISABLE_EXITS_HLT              (1 << 1)
   #define KVM_X86_DISABLE_EXITS_PAUSE            (1 << 2)
   #define KVM_X86_DISABLE_EXITS_CSTATE           (1 << 3)
+  #define KVM_X86_DISABLE_EXITS_APERFMPERF       (1 << 4)
 
 Enabling this capability on a VM provides userspace with a way to no
 longer intercept some instructions for improved latency in some
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0b7af5902ff7..53de91fccc20 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1380,6 +1380,7 @@ struct kvm_arch {
 	bool hlt_in_guest;
 	bool pause_in_guest;
 	bool cstate_in_guest;
+	bool aperfmperf_in_guest;
 
 	unsigned long irq_sources_bitmap;
 	s64 kvmclock_offset;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a713c803a3a3..5ebcbff341bc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -111,6 +111,8 @@ static const struct svm_direct_access_msrs {
 	{ .index = MSR_IA32_CR_PAT,			.always = false },
 	{ .index = MSR_AMD64_SEV_ES_GHCB,		.always = true  },
 	{ .index = MSR_TSC_AUX,				.always = false },
+	{ .index = MSR_IA32_APERF,			.always = false },
+	{ .index = MSR_IA32_MPERF,			.always = false },
 	{ .index = X2APIC_MSR(APIC_ID),			.always = false },
 	{ .index = X2APIC_MSR(APIC_LVR),		.always = false },
 	{ .index = X2APIC_MSR(APIC_TASKPRI),		.always = false },
@@ -1359,6 +1361,11 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	if (boot_cpu_has(X86_FEATURE_V_SPEC_CTRL))
 		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SPEC_CTRL, 1, 1);
 
+	if (kvm_aperfmperf_in_guest(vcpu->kvm)) {
+		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_APERF, 1, 0);
+		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_MPERF, 1, 0);
+	}
+
 	if (kvm_vcpu_apicv_active(vcpu))
 		avic_init_vmcb(svm, vmcb);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 9d7cdb8fbf87..3ee2b7e07395 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -44,7 +44,7 @@ static inline struct page *__sme_pa_to_page(unsigned long pa)
 #define	IOPM_SIZE PAGE_SIZE * 3
 #define	MSRPM_SIZE PAGE_SIZE * 2
 
-#define MAX_DIRECT_ACCESS_MSRS	48
+#define MAX_DIRECT_ACCESS_MSRS	50
 #define MSRPM_OFFSETS	32
 extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
 extern bool npt_enabled;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6c56d5235f0f..88a555328932 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7597,6 +7597,10 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 		vmx_disable_intercept_for_msr(vcpu, MSR_CORE_C6_RESIDENCY, MSR_TYPE_R);
 		vmx_disable_intercept_for_msr(vcpu, MSR_CORE_C7_RESIDENCY, MSR_TYPE_R);
 	}
+	if (kvm_aperfmperf_in_guest(vcpu->kvm)) {
+		vmx_disable_intercept_for_msr(vcpu, MSR_IA32_APERF, MSR_TYPE_R);
+		vmx_disable_intercept_for_msr(vcpu, MSR_IA32_MPERF, MSR_TYPE_R);
+	}
 
 	vmx->loaded_vmcs = &vmx->vmcs01;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02159c967d29..98f3df24ac9a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4533,7 +4533,7 @@ static inline bool kvm_can_mwait_in_guest(void)
 
 static u64 kvm_get_allowed_disable_exits(void)
 {
-	u64 r = KVM_X86_DISABLE_EXITS_PAUSE;
+	u64 r = KVM_X86_DISABLE_EXITS_PAUSE | KVM_X86_DISABLE_EXITS_APERFMPERF;
 
 	if (!mitigate_smt_rsb) {
 		r |= KVM_X86_DISABLE_EXITS_HLT |
@@ -6543,7 +6543,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 
 		if (!mitigate_smt_rsb && boot_cpu_has_bug(X86_BUG_SMT_RSB) &&
 		    cpu_smt_possible() &&
-		    (cap->args[0] & ~KVM_X86_DISABLE_EXITS_PAUSE))
+		    (cap->args[0] & ~(KVM_X86_DISABLE_EXITS_PAUSE |
+				      KVM_X86_DISABLE_EXITS_APERFMPERF)))
 			pr_warn_once(SMT_RSB_MSG);
 
 		if (cap->args[0] & KVM_X86_DISABLE_EXITS_PAUSE)
@@ -6554,6 +6555,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			kvm->arch.hlt_in_guest = true;
 		if (cap->args[0] & KVM_X86_DISABLE_EXITS_CSTATE)
 			kvm->arch.cstate_in_guest = true;
+		if (cap->args[0] & KVM_X86_DISABLE_EXITS_APERFMPERF)
+			kvm->arch.aperfmperf_in_guest = true;
 		r = 0;
 disable_exits_unlock:
 		mutex_unlock(&kvm->lock);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 91e50a513100..0c3ac99454e5 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -488,6 +488,11 @@ static inline bool kvm_cstate_in_guest(struct kvm *kvm)
 	return kvm->arch.cstate_in_guest;
 }
 
+static inline bool kvm_aperfmperf_in_guest(struct kvm *kvm)
+{
+	return kvm->arch.aperfmperf_in_guest;
+}
+
 static inline bool kvm_notify_vmexit_enabled(struct kvm *kvm)
 {
 	return kvm->arch.notify_vmexit_flags & KVM_X86_NOTIFY_VMEXIT_ENABLED;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 45e6d8fca9b9..b4a4eb52f6df 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -617,6 +617,7 @@ struct kvm_ioeventfd {
 #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
 #define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
+#define KVM_X86_DISABLE_EXITS_APERFMPERF     (1 << 4)
 
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 502ea63b5d2e..9b60f0509cdc 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -617,10 +617,12 @@ struct kvm_ioeventfd {
 #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
 #define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
+#define KVM_X86_DISABLE_EXITS_APERFMPERF     (1 << 4)
 #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
                                               KVM_X86_DISABLE_EXITS_HLT | \
                                               KVM_X86_DISABLE_EXITS_PAUSE | \
-                                              KVM_X86_DISABLE_EXITS_CSTATE)
+					      KVM_X86_DISABLE_EXITS_CSTATE | \
+					      KVM_X86_DISABLE_EXITS_APERFMPERF)
 
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
-- 
2.48.1.658.g4767266eb4-goog


