Return-Path: <linux-kernel+bounces-430056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207F9E2C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69B72842BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA75320011E;
	Tue,  3 Dec 2024 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XiQiFqWh"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138FB209F5E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733254396; cv=none; b=eebjHmaOtBaYTAEvFrBKcd5k6j/LYrlq+94wsHVR9pywLDeKQwQ+wAg/L4KbYbvUKkV7MAQ7gYIWAiGUXMNdBNf62Fjv0nZ5vddvj0lOAHGiT+zZY1obC7KvDbnQziHJ1NZ3ZBzVZxspNQpqc3VYTgQnbvY+obD/v2IxAG7QXBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733254396; c=relaxed/simple;
	bh=Ov04l4ujL2LkEcmwso6nHaSaDE3vJOS7zFbb1yyg6LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MdMQAO1WsnqKsPYoFYRzH263+3tltEPKZQY+lCsW6RPdynHaB3Zd784dD4Ebh5uW0DZ2MfPceiAcyaBlY1ohgWNFMoBHk0zv35biS4kTJibZ0jFX6G3XUF1L5tPKC6zCvucNusoVIpZg8bY2AY1MyrB1Y8zl0qO923C+spWykVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XiQiFqWh; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733254392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ljs+gv1hVr+XiRqVBXY0trSq+If0bzU9o/nEcT3XzDA=;
	b=XiQiFqWh063UMkAQqarnzcY7a3lTc4w6NAl6KqXOSpy+790Wst359gsWA+VqC0iHa9phUK
	FeGXRXyhrhLWzZg1gdxGIUCYLnSkzaiqFJdkE/hc3AQ7+WAcUf0jNA+DKisq21wbx77kiv
	OF/wLHsxqBkKA9Bvo2gbsSRWjn3pWjk=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	Colton Lewis <coltonlewis@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [RFC PATCH 07/14] KVM: arm64: Use a cpucap to determine if system supports FEAT_PMUv3
Date: Tue,  3 Dec 2024 11:32:13 -0800
Message-Id: <20241203193220.1070811-8-oliver.upton@linux.dev>
In-Reply-To: <20241203193220.1070811-1-oliver.upton@linux.dev>
References: <20241203193220.1070811-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

KVM is about to learn some new tricks to virtualize PMUv3 on IMPDEF
hardware. As part of that, we now need to differentiate host support
from guest support for PMUv3.

Add a cpucap to determine if an architectural PMUv3 is present to guard
host usage of PMUv3 controls.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/include/asm/cpufeature.h     |  5 +++++
 arch/arm64/kernel/cpufeature.c          | 19 +++++++++++++++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h |  4 ++--
 arch/arm64/kvm/pmu.c                    | 10 +++++-----
 arch/arm64/tools/cpucaps                |  1 +
 include/kvm/arm_pmu.h                   |  2 +-
 6 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b64e49bd9d10..3718840e9767 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -867,6 +867,11 @@ static __always_inline bool system_supports_mpam_hcr(void)
 	return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
 }
 
+static inline bool system_supports_pmuv3(void)
+{
+	return cpus_have_final_cap(ARM64_HAS_PMUV3);
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6ce71f444ed8..fa73fbdd8617 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1889,6 +1889,19 @@ static bool has_lpa2(const struct arm64_cpu_capabilities *entry, int scope)
 }
 #endif
 
+static bool has_pmuv3(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+	unsigned int pmuver;
+
+	pmuver = cpuid_feature_extract_unsigned_field(dfr0,
+						      ID_AA64DFR0_EL1_PMUVer_SHIFT);
+	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
+		return false;
+
+	return pmuver >= ID_AA64DFR0_EL1_PMUVer_IMP;
+}
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define KPTI_NG_TEMP_VA		(-(1UL << PMD_SHIFT))
 
@@ -2990,6 +3003,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, GCS, IMP)
 	},
 #endif
+	{
+		.desc = "PMUv3",
+		.capability = ARM64_HAS_PMUV3,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_pmuv3,
+	},
 	{},
 };
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 34f53707892d..995aca419b1e 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -244,7 +244,7 @@ static inline void __activate_traps_common(struct kvm_vcpu *vcpu)
 	 * counter, which could make a PMXEVCNTR_EL0 access UNDEF at
 	 * EL1 instead of being trapped to EL2.
 	 */
-	if (kvm_arm_support_pmu_v3()) {
+	if (system_supports_pmuv3()) {
 		struct kvm_cpu_context *hctxt;
 
 		write_sysreg(0, pmselr_el0);
@@ -281,7 +281,7 @@ static inline void __deactivate_traps_common(struct kvm_vcpu *vcpu)
 	write_sysreg(*host_data_ptr(host_debug_state.mdcr_el2), mdcr_el2);
 
 	write_sysreg(0, hstr_el2);
-	if (kvm_arm_support_pmu_v3()) {
+	if (system_supports_pmuv3()) {
 		struct kvm_cpu_context *hctxt;
 
 		hctxt = host_data_ptr(host_ctxt);
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 0b3adf3e17b4..6b48a3d16d0d 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -41,7 +41,7 @@ void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr)
 {
 	struct kvm_pmu_events *pmu = kvm_get_pmu_events();
 
-	if (!kvm_arm_support_pmu_v3() || !kvm_pmu_switch_needed(attr))
+	if (!system_supports_pmuv3() || !kvm_pmu_switch_needed(attr))
 		return;
 
 	if (!attr->exclude_host)
@@ -57,7 +57,7 @@ void kvm_clr_pmu_events(u64 clr)
 {
 	struct kvm_pmu_events *pmu = kvm_get_pmu_events();
 
-	if (!kvm_arm_support_pmu_v3())
+	if (!system_supports_pmuv3())
 		return;
 
 	pmu->events_host &= ~clr;
@@ -133,7 +133,7 @@ void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu)
 	struct kvm_pmu_events *pmu;
 	u64 events_guest, events_host;
 
-	if (!kvm_arm_support_pmu_v3() || !has_vhe())
+	if (!system_supports_pmuv3() || !has_vhe())
 		return;
 
 	preempt_disable();
@@ -154,7 +154,7 @@ void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu)
 	struct kvm_pmu_events *pmu;
 	u64 events_guest, events_host;
 
-	if (!kvm_arm_support_pmu_v3() || !has_vhe())
+	if (!system_supports_pmuv3() || !has_vhe())
 		return;
 
 	pmu = kvm_get_pmu_events();
@@ -180,7 +180,7 @@ bool kvm_set_pmuserenr(u64 val)
 	struct kvm_cpu_context *hctxt;
 	struct kvm_vcpu *vcpu;
 
-	if (!kvm_arm_support_pmu_v3() || !has_vhe())
+	if (!system_supports_pmuv3() || !has_vhe())
 		return false;
 
 	vcpu = kvm_get_running_vcpu();
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index eb17f59e543c..b291eb73f5e0 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -45,6 +45,7 @@ HAS_LSE_ATOMICS
 HAS_MOPS
 HAS_NESTED_VIRT
 HAS_PAN
+HAS_PMUV3
 HAS_S1PIE
 HAS_S1POE
 HAS_RAS_EXTN
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index e61dd7dd2286..7ef9eb3cede5 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -87,7 +87,7 @@ void kvm_vcpu_pmu_resync_el0(void);
  */
 #define kvm_pmu_update_vcpu_events(vcpu)				\
 	do {								\
-		if (!has_vhe() && kvm_arm_support_pmu_v3())		\
+		if (!has_vhe() && system_supports_pmuv3())		\
 			vcpu->arch.pmu.events = *kvm_get_pmu_events();	\
 	} while (0)
 
-- 
2.39.5


