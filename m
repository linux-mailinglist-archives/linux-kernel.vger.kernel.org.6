Return-Path: <linux-kernel+bounces-272975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8CA9462FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220511F23708
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98771E2127;
	Fri,  2 Aug 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dE5EUyAs"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AC1A83B4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622795; cv=none; b=LA9o3h2nFcolnRvlFBo4A2dbyN2xWPzbgMsqCk8Hm7mvh1DezmYIUugwJSXxscE8VxktQojyc/1uIJdTzz7ZZOnr/0NMT4/TsBT+iBGYbBNyw5kwzCOOabSqqcwPdN7dBR7dWdkLkncuBWGev8PvGPsaRC4Xakefl4Ddemp8cTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622795; c=relaxed/simple;
	bh=Me8Eo+MvIzPMLzI320ZRHVctlxzYT40aoDeS1tIVUcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rmn8gFJiu6B9FzWEwYGWj1lDMIIdwYdYwKACVcc4HqTIPSvm13OLgGDxsL24KUYLbPQF5+AHg4tHYtuKOFKzjbYZMHuiMPjZkPlCZ+5VqugnP19Zin2JOOURD78gphZ112e2NO7LLbag9aGVusLhuGGBE0u6aeoPu1WCkcxL3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dE5EUyAs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc51ea72abso81535475ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722622793; x=1723227593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LkWS5JYANXD4WC3fP+ZndYoHRMqSIM9FlXyYtLSkfM8=;
        b=dE5EUyAs99EQ7TB8h5Ta50ke/lKEHlNLBF3NXiol2u4261Y8aRjVq41VI8pw2jVm75
         y3h3Ah3PRjFdlE339Gs9JnwiqH3FlGuzvfC+9u8kTRmyQsWMLZW1YyiYvP4qKnkCKBoy
         voMYR6fM8AMsmzRSC/cOk2PmycVKjPdmRi0Zwf5Tc7Y6+4CiCcSj5rIZG1Q4Pnf/bWDF
         l+ZqtktZTjOXC5PYc57LIqBsW+iQgBj/0b8auQk7KtMVICQg3gxLoG9yjWz5uzTUmXVF
         MXuKvIFJAuhztU/QCAXvm1rwRCEJkLgcr7YTiEXR18UL1BvRXSsUWbhV2QOBF8Aaz7Ap
         8EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722622793; x=1723227593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkWS5JYANXD4WC3fP+ZndYoHRMqSIM9FlXyYtLSkfM8=;
        b=e98ZU1BBEvz4S4LCC4LFyKSCOdxPqhUpZStjsVDuHowZ/8qKur6WCw/0bxR6meFjjM
         03X8W31WDovXyIXMIbcyqjI84R6Oj9W4OPKD1x9cNmVbtbHK3mozHYg/BY6bONiKEN2O
         Fx7DDFSNk4rKHy+nJRwm7dLyth8Snjw1ff27qHGvfNW+THM1RS7+GqmmMvRbdOLoxBDD
         om+YrJdQTwIZgz5XAqZGxwX0y72FH2lxz7sKArZFT1rDMNyr0ArZVuNWrILpAEUGyEyc
         ruQw19QkGbdeoH+7ZMLEJJqGSujs6L3qA/uQZ9MvF5kpj7scAOgmOxVE+qqn5Ts0j9dc
         QjkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+sV/t6B823BputO/hL73+qE1myrZ4DrnHWSnoyQ/D/i8TN/dzMag8Kqt/Adbw9EP6MuOsYW4W0poKn0GMzVS4Pt5u5jOQ9v4WVYw1
X-Gm-Message-State: AOJu0YzxgQwaeV0G2Uz+ZWDPGe7eseW+POmbUtOJVAOqWjxqsMOnsarw
	z8f+Tlvepok7iizCeZBh8015Xqk2VIq1Yu4Agflc6lsuRyr0NWPMMmvU4XeUZf5VKaHo1Uzl6AQ
	R7Q==
X-Google-Smtp-Source: AGHT+IEvAsK4EUpCMeEdJPk5PiekcGKdsfmP8xBhi3WPsHryQw1Txod98VcPIvaBrEy2nbAm7QkW3nrWvFQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d502:b0:1f9:b35f:a2b6 with SMTP id
 d9443c01a7336-1ff5725095fmr2433365ad.1.1722622792947; Fri, 02 Aug 2024
 11:19:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:19:33 -0700
In-Reply-To: <20240802181935.292540-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802181935.292540-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802181935.292540-9-seanjc@google.com>
Subject: [PATCH v2 08/10] KVM: x86: Hoist x86.c's global msr_* variables up
 above kvm_do_msr_access()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the definitions of the various MSR arrays above kvm_do_msr_access()
so that kvm_do_msr_access() can query the arrays when handling failures,
e.g. to squash errors if userspace tries to read an MSR that isn't fully
supported, but that KVM advertised as being an MSR-to-save.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 368 ++++++++++++++++++++++-----------------------
 1 file changed, 184 insertions(+), 184 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4de1d7f17109..d0ea6340fba1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -304,6 +304,190 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 
 static struct kmem_cache *x86_emulator_cache;
 
+/*
+ * The three MSR lists(msrs_to_save, emulated_msrs, msr_based_features) track
+ * the set of MSRs that KVM exposes to userspace through KVM_GET_MSRS,
+ * KVM_SET_MSRS, and KVM_GET_MSR_INDEX_LIST.  msrs_to_save holds MSRs that
+ * require host support, i.e. should be probed via RDMSR.  emulated_msrs holds
+ * MSRs that KVM emulates without strictly requiring host support.
+ * msr_based_features holds MSRs that enumerate features, i.e. are effectively
+ * CPUID leafs.  Note, msr_based_features isn't mutually exclusive with
+ * msrs_to_save and emulated_msrs.
+ */
+
+static const u32 msrs_to_save_base[] = {
+	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
+	MSR_STAR,
+#ifdef CONFIG_X86_64
+	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
+#endif
+	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
+	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
+	MSR_IA32_SPEC_CTRL, MSR_IA32_TSX_CTRL,
+	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
+	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
+	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
+	MSR_IA32_RTIT_ADDR1_A, MSR_IA32_RTIT_ADDR1_B,
+	MSR_IA32_RTIT_ADDR2_A, MSR_IA32_RTIT_ADDR2_B,
+	MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
+	MSR_IA32_UMWAIT_CONTROL,
+
+	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
+};
+
+static const u32 msrs_to_save_pmu[] = {
+	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
+	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
+	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
+	MSR_CORE_PERF_GLOBAL_CTRL,
+	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
+
+	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
+	MSR_ARCH_PERFMON_PERFCTR0, MSR_ARCH_PERFMON_PERFCTR1,
+	MSR_ARCH_PERFMON_PERFCTR0 + 2, MSR_ARCH_PERFMON_PERFCTR0 + 3,
+	MSR_ARCH_PERFMON_PERFCTR0 + 4, MSR_ARCH_PERFMON_PERFCTR0 + 5,
+	MSR_ARCH_PERFMON_PERFCTR0 + 6, MSR_ARCH_PERFMON_PERFCTR0 + 7,
+	MSR_ARCH_PERFMON_EVENTSEL0, MSR_ARCH_PERFMON_EVENTSEL1,
+	MSR_ARCH_PERFMON_EVENTSEL0 + 2, MSR_ARCH_PERFMON_EVENTSEL0 + 3,
+	MSR_ARCH_PERFMON_EVENTSEL0 + 4, MSR_ARCH_PERFMON_EVENTSEL0 + 5,
+	MSR_ARCH_PERFMON_EVENTSEL0 + 6, MSR_ARCH_PERFMON_EVENTSEL0 + 7,
+
+	MSR_K7_EVNTSEL0, MSR_K7_EVNTSEL1, MSR_K7_EVNTSEL2, MSR_K7_EVNTSEL3,
+	MSR_K7_PERFCTR0, MSR_K7_PERFCTR1, MSR_K7_PERFCTR2, MSR_K7_PERFCTR3,
+
+	/* This part of MSRs should match KVM_MAX_NR_AMD_GP_COUNTERS. */
+	MSR_F15H_PERF_CTL0, MSR_F15H_PERF_CTL1, MSR_F15H_PERF_CTL2,
+	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
+	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
+	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
+
+	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+};
+
+static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
+			ARRAY_SIZE(msrs_to_save_pmu)];
+static unsigned num_msrs_to_save;
+
+static const u32 emulated_msrs_all[] = {
+	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
+	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
+
+#ifdef CONFIG_KVM_HYPERV
+	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
+	HV_X64_MSR_TIME_REF_COUNT, HV_X64_MSR_REFERENCE_TSC,
+	HV_X64_MSR_TSC_FREQUENCY, HV_X64_MSR_APIC_FREQUENCY,
+	HV_X64_MSR_CRASH_P0, HV_X64_MSR_CRASH_P1, HV_X64_MSR_CRASH_P2,
+	HV_X64_MSR_CRASH_P3, HV_X64_MSR_CRASH_P4, HV_X64_MSR_CRASH_CTL,
+	HV_X64_MSR_RESET,
+	HV_X64_MSR_VP_INDEX,
+	HV_X64_MSR_VP_RUNTIME,
+	HV_X64_MSR_SCONTROL,
+	HV_X64_MSR_STIMER0_CONFIG,
+	HV_X64_MSR_VP_ASSIST_PAGE,
+	HV_X64_MSR_REENLIGHTENMENT_CONTROL, HV_X64_MSR_TSC_EMULATION_CONTROL,
+	HV_X64_MSR_TSC_EMULATION_STATUS, HV_X64_MSR_TSC_INVARIANT_CONTROL,
+	HV_X64_MSR_SYNDBG_OPTIONS,
+	HV_X64_MSR_SYNDBG_CONTROL, HV_X64_MSR_SYNDBG_STATUS,
+	HV_X64_MSR_SYNDBG_SEND_BUFFER, HV_X64_MSR_SYNDBG_RECV_BUFFER,
+	HV_X64_MSR_SYNDBG_PENDING_BUFFER,
+#endif
+
+	MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
+	MSR_KVM_PV_EOI_EN, MSR_KVM_ASYNC_PF_INT, MSR_KVM_ASYNC_PF_ACK,
+
+	MSR_IA32_TSC_ADJUST,
+	MSR_IA32_TSC_DEADLINE,
+	MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_PERF_CAPABILITIES,
+	MSR_IA32_MISC_ENABLE,
+	MSR_IA32_MCG_STATUS,
+	MSR_IA32_MCG_CTL,
+	MSR_IA32_MCG_EXT_CTL,
+	MSR_IA32_SMBASE,
+	MSR_SMI_COUNT,
+	MSR_PLATFORM_INFO,
+	MSR_MISC_FEATURES_ENABLES,
+	MSR_AMD64_VIRT_SPEC_CTRL,
+	MSR_AMD64_TSC_RATIO,
+	MSR_IA32_POWER_CTL,
+	MSR_IA32_UCODE_REV,
+
+	/*
+	 * KVM always supports the "true" VMX control MSRs, even if the host
+	 * does not.  The VMX MSRs as a whole are considered "emulated" as KVM
+	 * doesn't strictly require them to exist in the host (ignoring that
+	 * KVM would refuse to load in the first place if the core set of MSRs
+	 * aren't supported).
+	 */
+	MSR_IA32_VMX_BASIC,
+	MSR_IA32_VMX_TRUE_PINBASED_CTLS,
+	MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
+	MSR_IA32_VMX_TRUE_EXIT_CTLS,
+	MSR_IA32_VMX_TRUE_ENTRY_CTLS,
+	MSR_IA32_VMX_MISC,
+	MSR_IA32_VMX_CR0_FIXED0,
+	MSR_IA32_VMX_CR4_FIXED0,
+	MSR_IA32_VMX_VMCS_ENUM,
+	MSR_IA32_VMX_PROCBASED_CTLS2,
+	MSR_IA32_VMX_EPT_VPID_CAP,
+	MSR_IA32_VMX_VMFUNC,
+
+	MSR_K7_HWCR,
+	MSR_KVM_POLL_CONTROL,
+};
+
+static u32 emulated_msrs[ARRAY_SIZE(emulated_msrs_all)];
+static unsigned num_emulated_msrs;
+
+/*
+ * List of MSRs that control the existence of MSR-based features, i.e. MSRs
+ * that are effectively CPUID leafs.  VMX MSRs are also included in the set of
+ * feature MSRs, but are handled separately to allow expedited lookups.
+ */
+static const u32 msr_based_features_all_except_vmx[] = {
+	MSR_AMD64_DE_CFG,
+	MSR_IA32_UCODE_REV,
+	MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_PERF_CAPABILITIES,
+};
+
+static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
+			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
+static unsigned int num_msr_based_features;
+
+/*
+ * All feature MSRs except uCode revID, which tracks the currently loaded uCode
+ * patch, are immutable once the vCPU model is defined.
+ */
+static bool kvm_is_immutable_feature_msr(u32 msr)
+{
+	int i;
+
+	if (msr >= KVM_FIRST_EMULATED_VMX_MSR && msr <= KVM_LAST_EMULATED_VMX_MSR)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(msr_based_features_all_except_vmx); i++) {
+		if (msr == msr_based_features_all_except_vmx[i])
+			return msr != MSR_IA32_UCODE_REV;
+	}
+
+	return false;
+}
+
+static bool kvm_is_msr_to_save(u32 msr_index)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_msrs_to_save; i++) {
+		if (msrs_to_save[i] == msr_index)
+			return true;
+	}
+
+	return false;
+}
+
 typedef int (*msr_access_t)(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 			    bool host_initiated);
 
@@ -1428,178 +1612,6 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_rdpmc);
 
-/*
- * The three MSR lists(msrs_to_save, emulated_msrs, msr_based_features) track
- * the set of MSRs that KVM exposes to userspace through KVM_GET_MSRS,
- * KVM_SET_MSRS, and KVM_GET_MSR_INDEX_LIST.  msrs_to_save holds MSRs that
- * require host support, i.e. should be probed via RDMSR.  emulated_msrs holds
- * MSRs that KVM emulates without strictly requiring host support.
- * msr_based_features holds MSRs that enumerate features, i.e. are effectively
- * CPUID leafs.  Note, msr_based_features isn't mutually exclusive with
- * msrs_to_save and emulated_msrs.
- */
-
-static const u32 msrs_to_save_base[] = {
-	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
-	MSR_STAR,
-#ifdef CONFIG_X86_64
-	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
-#endif
-	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
-	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_SPEC_CTRL, MSR_IA32_TSX_CTRL,
-	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
-	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
-	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
-	MSR_IA32_RTIT_ADDR1_A, MSR_IA32_RTIT_ADDR1_B,
-	MSR_IA32_RTIT_ADDR2_A, MSR_IA32_RTIT_ADDR2_B,
-	MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
-	MSR_IA32_UMWAIT_CONTROL,
-
-	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
-};
-
-static const u32 msrs_to_save_pmu[] = {
-	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
-	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
-	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
-	MSR_CORE_PERF_GLOBAL_CTRL,
-	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
-
-	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
-	MSR_ARCH_PERFMON_PERFCTR0, MSR_ARCH_PERFMON_PERFCTR1,
-	MSR_ARCH_PERFMON_PERFCTR0 + 2, MSR_ARCH_PERFMON_PERFCTR0 + 3,
-	MSR_ARCH_PERFMON_PERFCTR0 + 4, MSR_ARCH_PERFMON_PERFCTR0 + 5,
-	MSR_ARCH_PERFMON_PERFCTR0 + 6, MSR_ARCH_PERFMON_PERFCTR0 + 7,
-	MSR_ARCH_PERFMON_EVENTSEL0, MSR_ARCH_PERFMON_EVENTSEL1,
-	MSR_ARCH_PERFMON_EVENTSEL0 + 2, MSR_ARCH_PERFMON_EVENTSEL0 + 3,
-	MSR_ARCH_PERFMON_EVENTSEL0 + 4, MSR_ARCH_PERFMON_EVENTSEL0 + 5,
-	MSR_ARCH_PERFMON_EVENTSEL0 + 6, MSR_ARCH_PERFMON_EVENTSEL0 + 7,
-
-	MSR_K7_EVNTSEL0, MSR_K7_EVNTSEL1, MSR_K7_EVNTSEL2, MSR_K7_EVNTSEL3,
-	MSR_K7_PERFCTR0, MSR_K7_PERFCTR1, MSR_K7_PERFCTR2, MSR_K7_PERFCTR3,
-
-	/* This part of MSRs should match KVM_MAX_NR_AMD_GP_COUNTERS. */
-	MSR_F15H_PERF_CTL0, MSR_F15H_PERF_CTL1, MSR_F15H_PERF_CTL2,
-	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
-	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
-	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
-
-	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
-	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
-	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
-};
-
-static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
-			ARRAY_SIZE(msrs_to_save_pmu)];
-static unsigned num_msrs_to_save;
-
-static const u32 emulated_msrs_all[] = {
-	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
-	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
-
-#ifdef CONFIG_KVM_HYPERV
-	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
-	HV_X64_MSR_TIME_REF_COUNT, HV_X64_MSR_REFERENCE_TSC,
-	HV_X64_MSR_TSC_FREQUENCY, HV_X64_MSR_APIC_FREQUENCY,
-	HV_X64_MSR_CRASH_P0, HV_X64_MSR_CRASH_P1, HV_X64_MSR_CRASH_P2,
-	HV_X64_MSR_CRASH_P3, HV_X64_MSR_CRASH_P4, HV_X64_MSR_CRASH_CTL,
-	HV_X64_MSR_RESET,
-	HV_X64_MSR_VP_INDEX,
-	HV_X64_MSR_VP_RUNTIME,
-	HV_X64_MSR_SCONTROL,
-	HV_X64_MSR_STIMER0_CONFIG,
-	HV_X64_MSR_VP_ASSIST_PAGE,
-	HV_X64_MSR_REENLIGHTENMENT_CONTROL, HV_X64_MSR_TSC_EMULATION_CONTROL,
-	HV_X64_MSR_TSC_EMULATION_STATUS, HV_X64_MSR_TSC_INVARIANT_CONTROL,
-	HV_X64_MSR_SYNDBG_OPTIONS,
-	HV_X64_MSR_SYNDBG_CONTROL, HV_X64_MSR_SYNDBG_STATUS,
-	HV_X64_MSR_SYNDBG_SEND_BUFFER, HV_X64_MSR_SYNDBG_RECV_BUFFER,
-	HV_X64_MSR_SYNDBG_PENDING_BUFFER,
-#endif
-
-	MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
-	MSR_KVM_PV_EOI_EN, MSR_KVM_ASYNC_PF_INT, MSR_KVM_ASYNC_PF_ACK,
-
-	MSR_IA32_TSC_ADJUST,
-	MSR_IA32_TSC_DEADLINE,
-	MSR_IA32_ARCH_CAPABILITIES,
-	MSR_IA32_PERF_CAPABILITIES,
-	MSR_IA32_MISC_ENABLE,
-	MSR_IA32_MCG_STATUS,
-	MSR_IA32_MCG_CTL,
-	MSR_IA32_MCG_EXT_CTL,
-	MSR_IA32_SMBASE,
-	MSR_SMI_COUNT,
-	MSR_PLATFORM_INFO,
-	MSR_MISC_FEATURES_ENABLES,
-	MSR_AMD64_VIRT_SPEC_CTRL,
-	MSR_AMD64_TSC_RATIO,
-	MSR_IA32_POWER_CTL,
-	MSR_IA32_UCODE_REV,
-
-	/*
-	 * KVM always supports the "true" VMX control MSRs, even if the host
-	 * does not.  The VMX MSRs as a whole are considered "emulated" as KVM
-	 * doesn't strictly require them to exist in the host (ignoring that
-	 * KVM would refuse to load in the first place if the core set of MSRs
-	 * aren't supported).
-	 */
-	MSR_IA32_VMX_BASIC,
-	MSR_IA32_VMX_TRUE_PINBASED_CTLS,
-	MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
-	MSR_IA32_VMX_TRUE_EXIT_CTLS,
-	MSR_IA32_VMX_TRUE_ENTRY_CTLS,
-	MSR_IA32_VMX_MISC,
-	MSR_IA32_VMX_CR0_FIXED0,
-	MSR_IA32_VMX_CR4_FIXED0,
-	MSR_IA32_VMX_VMCS_ENUM,
-	MSR_IA32_VMX_PROCBASED_CTLS2,
-	MSR_IA32_VMX_EPT_VPID_CAP,
-	MSR_IA32_VMX_VMFUNC,
-
-	MSR_K7_HWCR,
-	MSR_KVM_POLL_CONTROL,
-};
-
-static u32 emulated_msrs[ARRAY_SIZE(emulated_msrs_all)];
-static unsigned num_emulated_msrs;
-
-/*
- * List of MSRs that control the existence of MSR-based features, i.e. MSRs
- * that are effectively CPUID leafs.  VMX MSRs are also included in the set of
- * feature MSRs, but are handled separately to allow expedited lookups.
- */
-static const u32 msr_based_features_all_except_vmx[] = {
-	MSR_AMD64_DE_CFG,
-	MSR_IA32_UCODE_REV,
-	MSR_IA32_ARCH_CAPABILITIES,
-	MSR_IA32_PERF_CAPABILITIES,
-};
-
-static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all_except_vmx) +
-			      (KVM_LAST_EMULATED_VMX_MSR - KVM_FIRST_EMULATED_VMX_MSR + 1)];
-static unsigned int num_msr_based_features;
-
-/*
- * All feature MSRs except uCode revID, which tracks the currently loaded uCode
- * patch, are immutable once the vCPU model is defined.
- */
-static bool kvm_is_immutable_feature_msr(u32 msr)
-{
-	int i;
-
-	if (msr >= KVM_FIRST_EMULATED_VMX_MSR && msr <= KVM_LAST_EMULATED_VMX_MSR)
-		return true;
-
-	for (i = 0; i < ARRAY_SIZE(msr_based_features_all_except_vmx); i++) {
-		if (msr == msr_based_features_all_except_vmx[i])
-			return msr != MSR_IA32_UCODE_REV;
-	}
-
-	return false;
-}
-
 /*
  * Some IA32_ARCH_CAPABILITIES bits have dependencies on MSRs that KVM
  * does not yet virtualize. These include:
@@ -3747,18 +3759,6 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
 }
 
-static bool kvm_is_msr_to_save(u32 msr_index)
-{
-	unsigned int i;
-
-	for (i = 0; i < num_msrs_to_save; i++) {
-		if (msrs_to_save[i] == msr_index)
-			return true;
-	}
-
-	return false;
-}
-
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	u32 msr = msr_info->index;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


