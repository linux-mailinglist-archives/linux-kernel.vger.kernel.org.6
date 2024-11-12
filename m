Return-Path: <linux-kernel+bounces-405683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0149C553D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30101F228BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE665220C7C;
	Tue, 12 Nov 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xuICYdkS"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B022D3A3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407910; cv=none; b=LpxAiesC11eMv9mk+Coi5uXhPZE68hAW3UaN1+o3rRFof47wt2yGJrAM20v1vGpl+EI8zlZVbBU0jk/AQW9PvjcTA1N7GhoeL4UTdmqKAMBdLNuATgqryzX8Svaxld5CDRGTvEC8Faby0mDnH5F18JyfskIvXhQIZDHZ7DgCM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407910; c=relaxed/simple;
	bh=zk+4pcQCSjKK/iDPaC2u2wqNDKb9SOs+tEOzLzLMQH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2ZNqPckiF3CPklBjw09YMmK8sPvSJvK5jCcz7CltVth0aRNPWp3btHKDriDuSdSCzHIlBuUMi+yw24fjgUZjpYJNcVha+Xu9/bJpPEoCt8mDiVFYorJjHgiMXr0NRjG3SsBecEtaeM4DKxMbQYM+4owqvN1k+80gZskjX8C2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xuICYdkS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43159c9f617so43184605e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731407907; x=1732012707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV3nsyw5404Uo8G1nSnnmKQ1QdbiAR4HgkQNY6sysiA=;
        b=xuICYdkS48NZ4O4pemmuGGbjdyD7nwkq4p+ia8NZplQkOXhPQk2zeka0WFW8XsWnBR
         rf/vB6LGeVkFQyWQp/HuBxOax3o8oXlsnhaOIPvJWN2Cdpzj4BNdIJb74dPM3dkNCATW
         LBLRQzwK3k46p8A1j6wvzA5rR+53+/9+FM15JsEs6MGruC6opuLrD4MTDyMb0ABJgrdB
         PrvfRd9LCcyMQHJn/osJ+W7MQJUIoiJ4e8HdntAHd5P4A1gHcFX8D06aSJzvRZ4HzxRo
         54ppcsze7eYVPd0Ae4oLxRu+cZMCreTAGavGk2DE7dW8OhOHD6sQ9LByaZqgN2MjKYPF
         X/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407907; x=1732012707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LV3nsyw5404Uo8G1nSnnmKQ1QdbiAR4HgkQNY6sysiA=;
        b=qJXALlv960DyrQt/d41yeUPP0Dx3edmcYNc2dmW6mo38GmCExStf2Ij/pZWOI+n6PK
         7zaMAp473Kc8iNRoN0HlJu8jagoMTFAhMagwKro6/uyGSQuZOUehCttDsAW3zDN8Q67i
         fL8toQvl3gTqmVevQK6epYZTApu59KU076EM0F6kRbr3OYadS4xFBXeOehaBg9gR7hqM
         cNm9LFAluXoL9yLJU8gTGJXYbeDdf4+oz1ECdx09Wp6MC+0DETjVgYR04pA/ss6E50Vi
         Fd8ppqlOWDhdTm8SEMZPrblaKGDZSkxcxWtOJ6DsxkJW+mREGhJv8/k/fkVT3uMim2ac
         VrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVek0PqxfEx740/aroVY6ejAbZduJJ6pQliDXaoTual76dz5x16jMDUTrlfJj38BZiDPLFAWRCM+ineiHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTp4E2IQGN1WGrk3yCnB7cBlRunoGBuFXKHpHLDFeb2BnGYwn
	f7P9QAcOyyOt+cr4QRSLEneJIS/dudbUlu2BfWT7fmT4GfB0i3/NiRv4rjFadH8=
X-Google-Smtp-Source: AGHT+IE1wDzy/6MnLRWAcMttuy2R6a5vKVFmcLrn5P5890TBsIGhMnK8XJK5ODuYyXhsBnu+l89pAA==
X-Received: by 2002:a05:600c:5127:b0:431:5ba2:2450 with SMTP id 5b1f17b1804b1-432b751e264mr133161105e9.33.1731407906666;
        Tue, 12 Nov 2024 02:38:26 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbf436ffsm142270955e9.44.2024.11.12.02.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:38:26 -0800 (PST)
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
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Fuad Tabba <tabba@google.com>,
	James Morse <james.morse@arm.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	Mark Brown <broonie@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/12] KVM: arm64: arm_spe: Give SPE enabled state to KVM
Date: Tue, 12 Nov 2024 10:37:06 +0000
Message-Id: <20241112103717.589952-8-james.clark@linaro.org>
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

Currently in nVHE, KVM has to check if SPE is enabled on every guest
switch even if it was never used. Because it's a debug feature and is
more likely to not be used than used, give KVM the SPE buffer status to
allow a much simpler and faster do-nothing path in the hyp.

This is always called with preemption disabled except for probe/hotplug
which gets wrapped with preempt_disable().

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h |  6 ++++++
 arch/arm64/kvm/debug.c            | 29 +++++++++++++++++++++++++++++
 drivers/perf/arm_spe_pmu.c        | 13 +++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5dfc3f4f74b2..7f1e32d40f0c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -641,6 +641,8 @@ struct kvm_host_data {
 	struct {
 		/* Host CPU features, set at init */
 		u8 feats;
+		/* Host CPU state */
+		u8 state;
 	} flags;
 
 	/*
@@ -941,6 +943,8 @@ struct kvm_vcpu_arch {
 #define HOST_FEAT_HAS_TRBE	__kvm_single_flag(feats, BIT(1))
 /* CPU has Feat_TRF */
 #define HOST_FEAT_HAS_TRF	__kvm_single_flag(feats, BIT(2))
+/* PMBLIMITR_EL1_E is set (SPE profiling buffer enabled) */
+#define HOST_STATE_SPE_EN	__kvm_single_flag(state, BIT(0))
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
 #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
@@ -1382,6 +1386,7 @@ static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
 void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
 void kvm_clr_pmu_events(u64 clr);
 bool kvm_set_pmuserenr(u64 val);
+void kvm_set_pmblimitr(u64 pmblimitr);
 #else
 static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u64 clr) {}
@@ -1389,6 +1394,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
 {
 	return false;
 }
+static inline void kvm_set_pmblimitr(u64 pmblimitr) {}
 #endif
 
 void kvm_vcpu_load_vhe(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index fb41ef5d9db9..ed3b4d057c52 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -335,3 +335,32 @@ void kvm_arm_clear_debug(struct kvm_vcpu *vcpu)
 		}
 	}
 }
+
+static bool kvm_arm_skip_trace_state(void)
+{
+	/* pKVM hyp finds out the state for itself */
+	if (is_protected_kvm_enabled())
+		return true;
+
+	/* Make sure state gets there in one piece */
+	if (WARN_ON_ONCE(preemptible()))
+		return true;
+
+	return false;
+}
+
+void kvm_set_pmblimitr(u64 pmblimitr)
+{
+	/* Only read in nVHE */
+	if (has_vhe())
+		return;
+
+	if (kvm_arm_skip_trace_state())
+		return;
+
+	if (pmblimitr & PMBLIMITR_EL1_E)
+		host_data_set_flag(HOST_STATE_SPE_EN);
+	else
+		host_data_clear_flag(HOST_STATE_SPE_EN);
+}
+EXPORT_SYMBOL_GPL(kvm_set_pmblimitr);
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 3569050f9cf3..6a79df363aa6 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/kvm_host.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -496,6 +497,12 @@ static u64 arm_spe_pmu_next_off(struct perf_output_handle *handle)
 	return limit;
 }
 
+static void arm_spe_write_pmblimitr(u64 val)
+{
+	write_sysreg_s(val, SYS_PMBLIMITR_EL1);
+	kvm_set_pmblimitr(val);
+}
+
 static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 					  struct perf_event *event)
 {
@@ -524,7 +531,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	write_sysreg_s(base, SYS_PMBPTR_EL1);
 
 out_write_limit:
-	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
+	arm_spe_write_pmblimitr(limit);
 }
 
 static void arm_spe_perf_aux_output_end(struct perf_output_handle *handle)
@@ -552,7 +559,7 @@ static void arm_spe_pmu_disable_and_drain_local(void)
 	dsb(nsh);
 
 	/* Disable the profiling buffer */
-	write_sysreg_s(0, SYS_PMBLIMITR_EL1);
+	arm_spe_write_pmblimitr(0);
 	isb();
 }
 
@@ -1095,7 +1102,9 @@ static void __arm_spe_pmu_reset_local(void)
 	 * This is probably overkill, as we have no idea where we're
 	 * draining any buffered data to...
 	 */
+	preempt_disable();
 	arm_spe_pmu_disable_and_drain_local();
+	preempt_enable();
 
 	/* Reset the buffer base pointer */
 	write_sysreg_s(0, SYS_PMBPTR_EL1);
-- 
2.34.1


