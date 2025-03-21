Return-Path: <linux-kernel+bounces-572037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA6A6C5B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8A1481B61
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240D823371C;
	Fri, 21 Mar 2025 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtvaWyw3"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8231F03D3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595304; cv=none; b=FdrInE/EJXe+yMtZPkTJE16GzEH2TcXi3Jv/hMEvUxTLCAViPt+MKXN5yOhD8ZV0UQxPoZwXPu1AwEv18wGJAhK1x8VU/31EO4MeAPRbhWnbGB+eivzl4w4jV3jYD/YfcCN5b2WIKekMoqw/y17+piFZgV/CbR7gkfmoP+NGbi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595304; c=relaxed/simple;
	bh=q8hRpNf0nsUGYFzkwActTecf/+d4T+3EXVa33lTtUnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C9EawlOG2Dg+qzh2u5AXOfQPSyYyizIuvyx97SBK0e1VGX+OIPM5wS0XDXUwR/EjCntDPv//4uUl7XA/qWj8awTSJIA+Ypp8rKPzrgLlNuiRlZ6tV2qeKeIfjtv6nlMUWoICudsptKbaanS2y0PXUKj3RLEgVNI17LPuVe8ehzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HtvaWyw3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff82dd6de0so3238364a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595302; x=1743200102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVrbpENm6RLNsnlZDyG/Vo3Dfi5Oueq+F28RCQJGF8s=;
        b=HtvaWyw3lQ44OMl5yJUQeij/G62Lqbei1ZmR4a4wAjHSHhUsW1qu4ZqVGnG95mn4FI
         bMxFDxDseRp3FB16pDHv3Xo20IhWJn7rgepUbv/IxxWJNSagz7kzf8Hg10fQqQf+X9uh
         cGICNNg31REJrgBq11+7wavjwMucId6IQPN+jpH+N1Ju89k+lD9w8dwTQcHUKBGtKYyN
         TRDr6EziTsm4HcClbUoZ10P9fMHtRhe1nHMPUocGRA0MJoxe1enQTVK8jWSZrkXzqGAj
         8Uc3lkRh5lUWPQBQ2fW/tpLajNN0+E/yQSx0eo+tjZuck9ZYC2Xdx5g/wePFDWf21TVj
         FKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595302; x=1743200102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVrbpENm6RLNsnlZDyG/Vo3Dfi5Oueq+F28RCQJGF8s=;
        b=gu2ogjNvgLHht0m/yoeKW79OW6LOaaIg600EHUVo2+HrCzm84l+4rUX3exVBxItCV1
         vNf2KjgVgseaCoKQu6U5Squ/sjvMCUCOb/XxfeHqorBZNpJ/J71c9ZcT+31398XiGt45
         hiUZm2p7MC/+axfg2g7f88DHDGBjUF13FkQZmMrqHvo8N3YVl9GoZu5U5R40Vn/nYCVw
         N+cjDeq8T6TW2r2cXowb18avJ2aRVl8uujzfOzCOpv7qdV1+lP5jL5a5Go6+UgYWffr4
         jre9riqkSrbQnA+9KtFvRVwPaFR70odd6NXEVdYbj5piROSv8SvZrBHS6YDVeSX71tkv
         ySIQ==
X-Gm-Message-State: AOJu0Yxj3yU+NEw7bKnAwtOT6BHW7S0UKVuZevionpj9ydXxIHPiRQq+
	X0C/ZFZZjitu2U+Bwd36AcKwDeawSzCQD8cjeCK0Z145JTp1ShvVC9V6y2l0SncCSR6y7hQ/+CW
	LJImhz2ca/xkgerpi6aTQZaWIT36D3G5sN5aJHJO/A3uvhNfbspftCiP0oIbWIKOR4oXEt+ic76
	YMIwIDWMfN/l85tkld4KksjySt8OIepDneEbBg8gzlkIA59NYKwKk=
X-Google-Smtp-Source: AGHT+IE14pwRofNoOE1BtudhQ3bnwnN1AfIzk5V080Ekna4riMjsKOuYuDrgquBU4t0eqJilxnisWtG9dxw44A==
X-Received: from pjj6.prod.google.com ([2002:a17:90b:5546:b0:2ef:7af4:5e8e])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2647:b0:301:c5cb:7b13 with SMTP id 98e67ed59e1d1-3030fe552f1mr6854185a91.3.1742595301945;
 Fri, 21 Mar 2025 15:15:01 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:14:30 -0700
In-Reply-To: <20250321221444.2449974-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321221444.2449974-1-jmattson@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321221444.2449974-2-jmattson@google.com>
Subject: [PATCH v3 1/2] KVM: x86: Provide a capability to disable APERF/MPERF
 read intercepts
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
 arch/x86/kvm/vmx/vmx.c          | 6 ++++++
 arch/x86/kvm/vmx/vmx.h          | 2 +-
 arch/x86/kvm/x86.c              | 8 +++++++-
 arch/x86/kvm/x86.h              | 5 +++++
 include/uapi/linux/kvm.h        | 1 +
 tools/include/uapi/linux/kvm.h  | 4 +++-
 10 files changed, 33 insertions(+), 4 deletions(-)

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
index 32ae3aa50c7e..1287f365eff7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1381,6 +1381,7 @@ struct kvm_arch {
 	bool hlt_in_guest;
 	bool pause_in_guest;
 	bool cstate_in_guest;
+	bool aperfmperf_in_guest;
 
 	unsigned long irq_sources_bitmap;
 	s64 kvmclock_offset;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e67de787fc71..439e5f41f29e 100644
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
index ea44c1da5a7c..5b38d5c00788 100644
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
index 3b92f893b239..6d07313e4472 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -186,6 +186,8 @@ static u32 vmx_possible_passthrough_msrs[MAX_POSSIBLE_PASSTHROUGH_MSRS] = {
 	MSR_CORE_C3_RESIDENCY,
 	MSR_CORE_C6_RESIDENCY,
 	MSR_CORE_C7_RESIDENCY,
+	MSR_IA32_APERF,
+	MSR_IA32_MPERF,
 };
 
 /*
@@ -7593,6 +7595,10 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 		vmx_disable_intercept_for_msr(vcpu, MSR_CORE_C6_RESIDENCY, MSR_TYPE_R);
 		vmx_disable_intercept_for_msr(vcpu, MSR_CORE_C7_RESIDENCY, MSR_TYPE_R);
 	}
+	if (kvm_aperfmperf_in_guest(vcpu->kvm)) {
+		vmx_disable_intercept_for_msr(vcpu, MSR_IA32_APERF, MSR_TYPE_R);
+		vmx_disable_intercept_for_msr(vcpu, MSR_IA32_MPERF, MSR_TYPE_R);
+	}
 
 	vmx->loaded_vmcs = &vmx->vmcs01;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 951e44dc9d0e..0d3c5bdd556e 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -356,7 +356,7 @@ struct vcpu_vmx {
 	struct lbr_desc lbr_desc;
 
 	/* Save desired MSR intercept (read: pass-through) state */
-#define MAX_POSSIBLE_PASSTHROUGH_MSRS	16
+#define MAX_POSSIBLE_PASSTHROUGH_MSRS	18
 	struct {
 		DECLARE_BITMAP(read, MAX_POSSIBLE_PASSTHROUGH_MSRS);
 		DECLARE_BITMAP(write, MAX_POSSIBLE_PASSTHROUGH_MSRS);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b64ab350bcd..1b3cdca806b4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4535,6 +4535,9 @@ static u64 kvm_get_allowed_disable_exits(void)
 {
 	u64 r = KVM_X86_DISABLE_EXITS_PAUSE;
 
+	if (boot_cpu_has(X86_FEATURE_APERFMPERF))
+		r |= KVM_X86_DISABLE_EXITS_APERFMPERF;
+
 	if (!mitigate_smt_rsb) {
 		r |= KVM_X86_DISABLE_EXITS_HLT |
 			KVM_X86_DISABLE_EXITS_CSTATE;
@@ -6543,7 +6546,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 
 		if (!mitigate_smt_rsb && boot_cpu_has_bug(X86_BUG_SMT_RSB) &&
 		    cpu_smt_possible() &&
-		    (cap->args[0] & ~KVM_X86_DISABLE_EXITS_PAUSE))
+		    (cap->args[0] & ~(KVM_X86_DISABLE_EXITS_PAUSE |
+				      KVM_X86_DISABLE_EXITS_APERFMPERF)))
 			pr_warn_once(SMT_RSB_MSG);
 
 		if (cap->args[0] & KVM_X86_DISABLE_EXITS_PAUSE)
@@ -6554,6 +6558,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
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
2.49.0.395.g12beb8f557-goog


