Return-Path: <linux-kernel+bounces-405674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05569C5789
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DA2B3EBBC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDF61F77A7;
	Tue, 12 Nov 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCNKcnd+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E741FB725
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407893; cv=none; b=B+JMlfFo8rTlfTCshpYS4vmdgmdfoV3nXQfrimS/A3AN1AloCT/msr2tpr5Kop+252XGuLYEpuIXYIThtQ2i2qCT9PF0ev//o59OUoSMEsQDIVlsUW63q3CDO4xZdKQJkPPObj67igfknaP9cmTSrcejrlwvg0A7v7h/E8yg+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407893; c=relaxed/simple;
	bh=FIuQLmZ9U5Bjo+xbTCL+G+E/GsoImV728ioC04pcMO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VD0zbdSElk/WsYiu3gnLWmYiTeuRjjZCoJaguPr+ljnGV7gQHhBpbVfadUNESez3nWIwfo2FIPeGKJVvdJYp+ChX8zG4f8URP11qCKRPQJX8903SG07wEwEEhIWszZkf/Kfyqv5+08YZ5q1jO7Wu+jP3kCZfwsbdjzC/GG1idd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NCNKcnd+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so44559585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731407890; x=1732012690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=867c+Xk81TQQxI9AorJDkxlnQKkh21LK8NW2S3F1gcs=;
        b=NCNKcnd+Ckn+JSeQqmiXZdZ9t/CPL6D827vzwuDsyaZvWuCmT77gHosfCkoaTx99UP
         eObH25Zbg5I2heZp4n2lTdpQfRIRe+KDZmeSi77Xowatq8D6WFWDYpvelLEmqgFu+jLB
         rpty/IPSITNyV+6JjUkfW4XZiN84y1rbh0cRlok38gi9pWGpzXNERw15wrEJiPnhqJ5P
         XC1pvKHerupK/nq8zavwhR3AmWJUVIjO3CW/+2bRN+hp5Vmvf5ci3XhTsBjoMZMVtX4o
         TQawdqwl6odTSndJyPVeUcfCdsML7JQrGZ0OUK0G6VgtFz0WARKOfyZleYQXpInufvny
         dKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407890; x=1732012690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=867c+Xk81TQQxI9AorJDkxlnQKkh21LK8NW2S3F1gcs=;
        b=TEQLZGh6chHLapZvXNquXhtW04o9hFY1cr7ALc3iRt8fzd0830+X+XrljoSvfxu9/U
         3rP7K15wOKdiz0DXypPZFKP+85s4G71USiEW4+bhh6adbPh4RmUmuPYjvBgRryiuI8aE
         FiEC/uy6YkXBkkGmjW2oGW2by1jmK7Pov520kTo12hUctYnHC/ULgywsv2Tk+NpKFh6s
         6yY8pzQHD+NxPeDpPbogD0maUJ443eVlHYIcZZK/2We542ety14trSBVerf9EwyY9kNm
         y6JCsfmThhlAH/WhZ/q5i6M/+JwZZbXd6t2MCz4JfrOMp9GJHgub321moXfGQWKtmiDY
         niNg==
X-Forwarded-Encrypted: i=1; AJvYcCUyq237u5kinwU+8siW1aYAKCviNu3M8ge+0w2K2RW0+JSczKH5c4vlMbqwQmGRiQcuykBWuBhGS0RbGcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/OUtKj1KwXMRpE85qdKyeqKNnrmjk4AMNIJsusav7eR0y2oUa
	chOvVgNrCy4FafY7U1xv50UG+PIlPTWQd1DSv+CwMJ3Ose8sEqCvb9hKFa9rQwU=
X-Google-Smtp-Source: AGHT+IE0xLwD1/ZV0XtAmGGdV4VSBlbGR4egnGHLGmnWqBzEDrOWmm09rA7sjHH5TO65egKKJadivA==
X-Received: by 2002:a05:600c:1910:b0:431:680e:95ff with SMTP id 5b1f17b1804b1-432cce723d3mr17694385e9.9.1731407890092;
        Tue, 12 Nov 2024 02:38:10 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbf436ffsm142270955e9.44.2024.11.12.02.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:38:09 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: suzuki.poulose@arm.com,
	oliver.upton@linux.dev,
	coresight@lists.linaro.org,
	kvmarm@lists.linux.dev
Cc: James Clark <james.clark@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/12] KVM: arm64: Move SPE and TRBE flags to host data
Date: Tue, 12 Nov 2024 10:37:04 +0000
Message-Id: <20241112103717.589952-6-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112103717.589952-1-james.clark@linaro.org>
References: <20241112103717.589952-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They don't change, are per-CPU and don't need to be on the vcpu, so
initialize them one time only. Another benefit is this is done before
the host is deprivileged so can be trusted by pKVM.

Rename SAVE to HAS which is slightly more accurate because saving only
happens when it exists _and_ is enabled.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h  | 21 +++++++-----
 arch/arm64/kvm/arm.c               |  3 --
 arch/arm64/kvm/debug.c             | 52 +++++++++++-------------------
 arch/arm64/kvm/hyp/nvhe/debug-sr.c |  8 ++---
 4 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 34aa59f498c4..61ff34e1ffef 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -638,6 +638,11 @@ struct kvm_host_data {
 		FP_STATE_GUEST_OWNED,
 	} fp_owner;
 
+	struct {
+		/* Host CPU features, set at init */
+		u8 feats;
+	} flags;
+
 	/*
 	 * host_debug_state contains the host registers which are
 	 * saved and restored during world switches.
@@ -908,10 +913,6 @@ struct kvm_vcpu_arch {
 #define EXCEPT_AA64_EL2_SERR	__vcpu_except_flags(7)
 /* Guest debug is live */
 #define DEBUG_DIRTY		__kvm_single_flag(iflags, BIT(4))
-/* Save SPE context if active  */
-#define DEBUG_STATE_SAVE_SPE	__kvm_single_flag(iflags, BIT(5))
-/* Save TRBE context if active  */
-#define DEBUG_STATE_SAVE_TRBE	__kvm_single_flag(iflags, BIT(6))
 
 /* SVE enabled for host EL0 */
 #define HOST_SVE_ENABLED	__kvm_single_flag(sflags, BIT(0))
@@ -930,6 +931,14 @@ struct kvm_vcpu_arch {
 /* WFI instruction trapped */
 #define IN_WFI			__kvm_single_flag(sflags, BIT(7))
 
+#define host_data_get_flag(...)	__kvm_get_flag((*host_data_ptr(flags)), __VA_ARGS__)
+#define host_data_set_flag(...)	__kvm_set_flag((*host_data_ptr(flags)), __VA_ARGS__)
+#define host_data_clear_flag(...) __kvm_clear_flag((*host_data_ptr(flags)), __VA_ARGS__)
+
+/* Save SPE context if active  */
+#define HOST_FEAT_HAS_SPE	__kvm_single_flag(feats, BIT(0))
+/* Save TRBE context if active  */
+#define HOST_FEAT_HAS_TRBE	__kvm_single_flag(feats, BIT(1))
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
 #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
@@ -1367,10 +1376,6 @@ static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
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
index a102c3aebdbc..2a54baca3144 100644
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
index ce8886122ed3..cf5558806687 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -68,16 +68,31 @@ static void restore_guest_debug_regs(struct kvm_vcpu *vcpu)
 /**
  * kvm_arm_init_debug - grab what we need for debug
  *
- * Currently the sole task of this function is to retrieve the initial
- * value of mdcr_el2 so we can preserve MDCR_EL2.HPMN which has
- * presumably been set-up by some knowledgeable bootcode.
- *
  * It is called once per-cpu during CPU hyp initialisation.
  */
 
 void kvm_arm_init_debug(void)
 {
+	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
+
+	/*
+	 * Retrieve the initial value of mdcr_el2 so we can preserve MDCR_EL2.HPMN which
+	 * has presumably been set-up by some knowledgeable bootcode.
+	 */
 	__this_cpu_write(mdcr_el2, kvm_call_hyp_ret(__kvm_get_mdcr_el2));
+
+	/*
+	 * If SPE is present on this CPU and is available at current EL,
+	 * we may need to check if the host state needs to be saved.
+	 */
+	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_PMSVer_SHIFT) &&
+	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
+		host_data_set_flag(HOST_FEAT_HAS_SPE);
+
+	/* Check if we have TRBE implemented and available at the host */
+	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
+	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
+		host_data_set_flag(HOST_FEAT_HAS_TRBE);
 }
 
 /**
@@ -314,32 +329,3 @@ void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
 		}
 	}
 }
-
-void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
-{
-	u64 dfr0;
-
-	/* For VHE, there is nothing to do */
-	if (has_vhe())
-		return;
-
-	dfr0 = read_sysreg(id_aa64dfr0_el1);
-	/*
-	 * If SPE is present on this CPU and is available at current EL,
-	 * we may need to check if the host state needs to be saved.
-	 */
-	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_PMSVer_SHIFT) &&
-	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
-		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
-
-	/* Check if we have TRBE implemented and available at the host */
-	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
-	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
-		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
-}
-
-void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
-{
-	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
-	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
-}
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 53efda0235cf..89f44a51a172 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -82,10 +82,10 @@ static void __debug_restore_trace(u64 trfcr_el1)
 void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
 	/* Disable and flush SPE data generation */
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
+	if (host_data_get_flag(HOST_FEAT_HAS_SPE))
 		__debug_save_spe(host_data_ptr(host_debug_state.pmscr_el1));
 	/* Disable and flush Self-Hosted Trace generation */
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
+	if (host_data_get_flag(HOST_FEAT_HAS_TRBE))
 		__debug_save_trace(host_data_ptr(host_debug_state.trfcr_el1));
 }
 
@@ -96,9 +96,9 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
 
 void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
+	if (host_data_get_flag(HOST_FEAT_HAS_SPE))
 		__debug_restore_spe(*host_data_ptr(host_debug_state.pmscr_el1));
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
+	if (host_data_get_flag(HOST_FEAT_HAS_TRBE))
 		__debug_restore_trace(*host_data_ptr(host_debug_state.trfcr_el1));
 }
 
-- 
2.34.1


