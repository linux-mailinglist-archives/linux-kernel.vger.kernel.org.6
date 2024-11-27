Return-Path: <linux-kernel+bounces-423274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141BF9DA546
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C877A2831FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8B194A70;
	Wed, 27 Nov 2024 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3C2Wjou"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A7194AF4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701719; cv=none; b=pRPfE693iRZuhGUHDa4aK2LmSWvzGOPls+edYh7bvvCMNYK0MrNCrIRCQaMAXsXQZStnvtzH1VIn1p8TvlHflgnu0WGJy0RHNg83gvWUxn8CEFqXvBNVmoVT0FmMxYFTtvofR1SZa9926nGsvc2VZ8w6CviK2EzEG+DLzK8fPP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701719; c=relaxed/simple;
	bh=kRnFN+RePIWgidZUDRSYcja9gXjOYHCEs2GcS/YQR9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJNaFePQWJ7JOeKghCzHkf6pU0AwhBUJETPYcEsZ+Q+P8gkR1GcA2+iN+oAynqVXzX4SIJTbLfZmgLiQ4uvSNKxLyFLcITewDco3VvkkFUr6Xf2YEH7erD4zqB+ddOE/1dVb3hPS+JX/D4/+v+/6ZkcX3aRJ6cvVfqtQ1QDHEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j3C2Wjou; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso679095766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732701716; x=1733306516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZj1b2xrxu+uYiK1d2tMFby1ybMmB5QilRXAS0IFlr8=;
        b=j3C2Wjou0NONfcVzXTU1mNEaYH0PDONMsPJ0YYxCoz5O5SH+g2b3Sd5p7ysqigJDi+
         9cmnRC0NR6WDmcZmw72vyg9H5vGMCEJabkXDuFUhl9botYuS4D27ucTZ7UuCd4EJOPmi
         N/YHeO1w0NzEnIbB0fktXsNatQHJ4zBRAQJK72maA+af1n/lqCI3gJDZGDt6DIYCqn0L
         GQvgFbAoaIsXzgIov5cOkMn/aHqjrpOPmxAeOqjqP0UGn4knfmz0AHmkAkKpZAyp1Kl1
         M0uijTsUjBjSBWxmSTiV1tIIHONVvQNTGGhm3OXrFhiBd43YNxELezsA3IEH7lw3OtXd
         zhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732701716; x=1733306516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZj1b2xrxu+uYiK1d2tMFby1ybMmB5QilRXAS0IFlr8=;
        b=BFvpgx9Vn5ZRjJf0bvoCf87aJ58jIwk3Z1uC9jc87elVlSC3Qw7KqMUx70JS57q/+H
         NoHUa4TbhmpmS4iUeEebD7o3QCjMj0jBWVwfaum/49+CAgArwokUzveVZ9AZIK8atac8
         FuqYafMktqI5/ySU3+sBiJD+uDCLCWs2SAnzQptr8amHABkBMA7KOGyWb3UPrhoWS61g
         YO+yPK0YhgEQTr0MbzV9kV7EOJ53UV0x90QXdUozK9JhQXDQNHJTWF4aobUdwmPVOcZj
         8ltzCKdAK9FYvxnbSoMYY9i7ehO1MJQTTWMoi7EfECZuB7QkL+xCnLzWP0NNqBXGkDFA
         LIvA==
X-Forwarded-Encrypted: i=1; AJvYcCX775BdP2kKGAgCwSzA/i7VpuFgHtZfoPVkbzvGNzMqidJJC8Y6FOh9iER3e7HpXg+UHcKLFmJXKzvUuNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5tZvZUvNxSxjO8h89etv3Qlb9jrbSnIqrja8TTavCfNgUMqw
	lAoBCUuvdRGS7Xx+VTnZp+YjInDmMbJu68r0maSpflCtLSHXWu1IiivoVJ/yjD/3CXwXowny06v
	D
X-Gm-Gg: ASbGncuCul22dRcJFdaZpBF5/E/AxdYVfpwZteWhzIpzyk0QDVBGgCyU7A+KkTNUIBw
	+X3eNoKkvE9i/cWXxe+ZeRYfMK2DjEgkgR4O39FsZMyBkcS/xxjfX3yONIXsuE7JfGg1Xdklazc
	jjIHUW4SC8XZY2KwPp4NAd9OxQuSd/Vg2iQFqnd6x2lCOTDuXRqru5qVBRms/s+wg5D3dt37ZNg
	WXd3aU5ECIUnutSWA1uD71VpWLzmhfOYT0szyNNMHy4gFx8JQ==
X-Google-Smtp-Source: AGHT+IG/yqZM7gQ80KFLlzLstWak78i78p9Kn8TAyp6ek6i+4dK+mgf7V+8bPvrzOvcaxxY6vZeWpQ==
X-Received: by 2002:a17:907:781a:b0:aa5:3b1c:77a7 with SMTP id a640c23a62f3a-aa580ecc354mr151894466b.6.1732701715739;
        Wed, 27 Nov 2024 02:01:55 -0800 (PST)
Received: from pop-os.. ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa547ffb152sm421887466b.62.2024.11.27.02.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:01:55 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: maz@kernel.org,
	kvmarm@lists.linux.dev,
	oliver.upton@linux.dev,
	suzuki.poulose@arm.com,
	coresight@lists.linaro.org
Cc: James Clark <james.clark@linaro.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	James Morse <james.morse@arm.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/8] KVM: arm64: Track presence of SPE/TRBE in kvm_host_data instead of vCPU
Date: Wed, 27 Nov 2024 10:01:19 +0000
Message-Id: <20241127100130.1162639-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127100130.1162639-1-james.clark@linaro.org>
References: <20241127100130.1162639-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Upton <oliver.upton@linux.dev>

Add flags to kvm_host_data to track if SPE/TRBE is present +
programmable on a per-CPU basis. Set the flags up at init rather than
vcpu_load() as the programmability of these buffers is unlikely to
change.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h  | 19 +++++++++-------
 arch/arm64/kvm/arm.c               |  3 ---
 arch/arm64/kvm/debug.c             | 36 ++++++++----------------------
 arch/arm64/kvm/hyp/nvhe/debug-sr.c |  8 +++----
 4 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ad514434f3fe..7e3478386351 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -610,6 +610,10 @@ struct cpu_sve_state {
  * field.
  */
 struct kvm_host_data {
+#define KVM_HOST_DATA_FLAG_HAS_SPE	0
+#define KVM_HOST_DATA_FLAG_HAS_TRBE	1
+	unsigned long flags;
+
 	struct kvm_cpu_context host_ctxt;
 
 	/*
@@ -911,10 +915,6 @@ struct kvm_vcpu_arch {
 #define EXCEPT_AA64_EL2_SERR	__vcpu_except_flags(7)
 /* Guest debug is live */
 #define DEBUG_DIRTY		__vcpu_single_flag(iflags, BIT(4))
-/* Save SPE context if active  */
-#define DEBUG_STATE_SAVE_SPE	__vcpu_single_flag(iflags, BIT(5))
-/* Save TRBE context if active  */
-#define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
 
 /* SVE enabled for host EL0 */
 #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
@@ -1310,6 +1310,13 @@ DECLARE_KVM_HYP_PER_CPU(struct kvm_host_data, kvm_host_data);
 	 &this_cpu_ptr_hyp_sym(kvm_host_data)->f)
 #endif
 
+#define host_data_test_flag(flag)					\
+	(test_bit(KVM_HOST_DATA_FLAG_##flag, host_data_ptr(flags)))
+#define host_data_set_flag(flag)					\
+	set_bit(KVM_HOST_DATA_FLAG_##flag, host_data_ptr(flags))
+#define host_data_clear_flag(flag)					\
+	clear_bit(KVM_HOST_DATA_FLAG_##flag, host_data_ptr(flags))
+
 /* Check whether the FP regs are owned by the guest */
 static inline bool guest_owns_fp_regs(void)
 {
@@ -1370,10 +1377,6 @@ static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
 	return (!has_vhe() && attr->exclude_host);
 }
 
-/* Flags for host debug state */
-void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu);
-void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
-
 #ifdef CONFIG_KVM
 void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
 void kvm_clr_pmu_events(u64 clr);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ab1bf9ccf385..3822774840e1 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -617,15 +617,12 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	vcpu_set_pauth_traps(vcpu);
 
-	kvm_arch_vcpu_load_debug_state_flags(vcpu);
-
 	if (!cpumask_test_cpu(cpu, vcpu->kvm->arch.supported_cpus))
 		vcpu_set_on_unsupported_cpu(vcpu);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	kvm_arch_vcpu_put_debug_state_flags(vcpu);
 	kvm_arch_vcpu_put_fp(vcpu);
 	if (has_vhe())
 		kvm_vcpu_put_vhe(vcpu);
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 0dbabb6e1108..dd9e139dfd13 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -299,40 +299,22 @@ void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
 	}
 }
 
-void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
+void kvm_init_host_debug_data(void)
 {
-	u64 dfr0;
+	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
+
+	if (cpuid_feature_extract_signed_field(dfr0, ID_AA64DFR0_EL1_PMUVer_SHIFT) > 0)
+		*host_data_ptr(nr_event_counters) = FIELD_GET(ARMV8_PMU_PMCR_N,
+							      read_sysreg(pmcr_el0));
 
-	/* For VHE, there is nothing to do */
 	if (has_vhe())
 		return;
 
-	dfr0 = read_sysreg(id_aa64dfr0_el1);
-	/*
-	 * If SPE is present on this CPU and is available at current EL,
-	 * we may need to check if the host state needs to be saved.
-	 */
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_PMSVer_SHIFT) &&
-	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
-		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
+	    !(read_sysreg_s(SYS_PMBIDR_EL1) & PMBIDR_EL1_P))
+		host_data_set_flag(HAS_SPE);
 
-	/* Check if we have TRBE implemented and available at the host */
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
 	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
-		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
-}
-
-void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
-{
-	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
-	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
-}
-
-void kvm_init_host_debug_data(void)
-{
-	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
-
-	if (cpuid_feature_extract_signed_field(dfr0, ID_AA64DFR0_EL1_PMUVer_SHIFT) > 0)
-		*host_data_ptr(nr_event_counters) = FIELD_GET(ARMV8_PMU_PMCR_N,
-							      read_sysreg(pmcr_el0));
+		host_data_set_flag(HAS_TRBE);
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 1e2a26d0196e..858bb38e273f 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -82,10 +82,10 @@ static void __debug_restore_trace(u64 trfcr_el1)
 void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
 	/* Disable and flush SPE data generation */
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
+	if (host_data_test_flag(HAS_SPE))
 		__debug_save_spe(host_data_ptr(host_debug_state.pmscr_el1));
 	/* Disable and flush Self-Hosted Trace generation */
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
+	if (host_data_test_flag(HAS_TRBE))
 		__debug_save_trace(host_data_ptr(host_debug_state.trfcr_el1));
 }
 
@@ -96,9 +96,9 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
 
 void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
+	if (host_data_test_flag(HAS_SPE))
 		__debug_restore_spe(*host_data_ptr(host_debug_state.pmscr_el1));
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
+	if (host_data_test_flag(HAS_TRBE))
 		__debug_restore_trace(*host_data_ptr(host_debug_state.trfcr_el1));
 }
 
-- 
2.34.1


