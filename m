Return-Path: <linux-kernel+bounces-562496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9109AA629AD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F121896673
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0FC1F7076;
	Sat, 15 Mar 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="fSIz2ZfJ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A141F63D5
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029978; cv=none; b=IPkqTYKWDhLZZKinCZmjOjcNKhuAVLzJAUTao3uudphTPR/Hr/mKXgkeh26xGlVKDF5UsfrhSwxvcYjS9ULnu2fU1uCN6zloNURx8ZtKlcSrlK2ypW99ZhCsEjY1GwUab/fYGFSJ5z+la+V4DM3jXRt1pz70nlw+3BY0THrmYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029978; c=relaxed/simple;
	bh=55NhlBArV0bxMhOMhIHB8X/BAl2ygANfTR+Wz8xFj8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jAoG2Taf3nzIjr8HdbY295WLR6EPSsvWNLRANkNwJF130APr6m6qtF4lYyUMe27lEEca0SnRYIQXopfM0tBpDp6F9B0MaBTKwSsh+2lWCwJ8PmSA8Wl5y0b7ZYJHMz3ELeKP6VDxLWjVWw9Ho08qSVOkqjpFXNGWJFuAVciklzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=fSIz2ZfJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22398e09e39so61425225ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742029976; x=1742634776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z45wX6sTn0j+WP194BbrDZyhFp7C/BntrOrXCNO4tBM=;
        b=fSIz2ZfJIpSydL/GmnIwvx/Et0Ty8syFi8rx6sQqDJ4pGDy55RRDVFTENPapmOMijT
         efcH9dYewzpueVMcTBcdrYilAxdD5rAv4v/5axm6K3ga/19fn5WoZZdl0b2Dab5Plfk/
         AKAg6y/kZr0cPdRM7BPp/L7oNtoqKqc+RIYMxogLVbeK2nziVfDFU62lT97L5V/lL38E
         NUPoyZb3IqXaF2nMNOdgH7zyNuaSFdMq+MCxNWpYTHHC79wMDPdJnOZZvFaWUWjoaQHJ
         YASsgxcwWiAox2Fp8jANFe+IunOxuoDV9VjyJs/zba4nIzNT5h/pV2IatF5MBJgHtMB7
         uX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742029976; x=1742634776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z45wX6sTn0j+WP194BbrDZyhFp7C/BntrOrXCNO4tBM=;
        b=vFBWAANg5HOmitkivTN3Su4a0AmYY32f/+Nbc6sl2+5lu+/54B4CQxDu4ZScon5cJ3
         3c5xVysj+7TfiOfWohon4MGx6H2YcS+5VTacV60GfeUy8odZzUo1/dG6r/qcaz2BOdvh
         EOofH/RtJm/ZnjVUjW52tnWM/gPwRInAApM1aDVGeQOy9pKQMwe0Cj0Xz9x6xIBLz6Ru
         53tdsqG//HOt2mw4Jr+AQAhOKZ7h0Y9tdwru1vgyXjhXp3n5dNMFtFzjTUJ2wkBbepoG
         WacXk0qnpjR8H+UokzucilYDclmm+vOzuRPFsYrGZvfPQNOaPyVPRUEv8AZEIIxJDuTZ
         C2/A==
X-Forwarded-Encrypted: i=1; AJvYcCXZTAJOqQnmrXtm/VEf0pJ5EKRPA8YPUTvce4XhC+7cYPX5NQYESuMvuZbKUIt7847NJG8+X8E09tP5Nr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlO7MqwBZtp+rYHO7HOVD8GU8r3hRunPA7XGEIHKITQfZsnEY7
	K1vkFvNhXmNXCkdp46rFEtLnp73fWe/ceaUEdcZqClLQ43+HhkwFf3z9jGNJJjk=
X-Gm-Gg: ASbGncuPnwewy3ylXeuwkI0YdliWIeEzs4TPuPE2XTDbk2vyrTg00IPeJbGOTv2rk0O
	7Cek7Vhnxocrp8QiGLIt1bVNI8IgEGCIezJ6XOdjxhiy41gNsgkFrcpZTCde0953miWL7A2F9Kc
	2eEe2PV1lGUrEF4dta8eXzGA8/CSAiVxv4UJxAmH4WB4F9qmpCypD3JxZ43CQmDWE7OxtVZ4Qlg
	6Ig2kpgB5LK1elkQFa8+n39j6DZYm77045ZzyunRcOj2cUsiyH04yane0WmQIHkK4eDe7/lCt3z
	YqKyTkJr7WEvKKFjQ9kGmy5LWI6evqz4CEt06eyCtAanDyGM
X-Google-Smtp-Source: AGHT+IFM01ujgQGmxWWrZqVb8b6dOpUickjIAuSWkmx+lJTnPzesouNeLYIaUrB/yeU1KLg5VJSBcQ==
X-Received: by 2002:a05:6a20:2d08:b0:1f3:1d13:96b3 with SMTP id adf61e73a8af0-1f5c1132fcfmr7792054637.5.1742029976132;
        Sat, 15 Mar 2025 02:12:56 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af56ea7c7ffsm3280291a12.55.2025.03.15.02.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 02:12:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 15 Mar 2025 18:12:12 +0900
Subject: [PATCH v5 3/5] KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-pmc-v5-3-ecee87dab216@daynix.com>
References: <20250315-pmc-v5-0-ecee87dab216@daynix.com>
In-Reply-To: <20250315-pmc-v5-0-ecee87dab216@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <andrew.jones@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Reload the perf event when setting the vPMU counter (vPMC) registers
(PMCCNTR_EL0 and PMEVCNTR<n>_EL0). This is a change corresponding to
commit 9228b26194d1 ("KVM: arm64: PMU: Fix GET_ONE_REG
for vPMC regs to return the current value") but for SET_ONE_REG.

Values of vPMC registers are saved in sysreg files on certain occasions.
These saved values don't represent the current values of the vPMC
registers if the perf events for the vPMCs count events after the save.
The current values of those registers are the sum of the sysreg file
value and the current perf event counter value.  But, when userspace
writes those registers (using KVM_SET_ONE_REG), KVM only updates the
sysreg file value and leaves the current perf event counter value as is.

It is also important to keep the correct state even if userspace writes
them after first run, specifically when debugging Windows on QEMU with
GDB; QEMU tries to write back all visible registers when resuming the VM
execution with GDB, corrupting the PMU state. Windows always uses the
PMU so this can cause adverse effects on that particular OS.

Fix this by releasing the current perf event and trigger recreating one
with KVM_REQ_RELOAD_PMU.

Fixes: 051ff581ce70 ("arm64: KVM: Add access handler for event counter register")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/pmu-emul.c | 13 +++++++++++++
 arch/arm64/kvm/sys_regs.c | 20 +++++++++++++++++++-
 include/kvm/arm_pmu.h     |  2 ++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 98fdc65f5b24..593216bc14f0 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -191,6 +191,19 @@ void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
 	kvm_pmu_set_pmc_value(kvm_vcpu_idx_to_pmc(vcpu, select_idx), val, false);
 }
 
+/**
+ * kvm_pmu_set_counter_value_user - set PMU counter value from user
+ * @vcpu: The vcpu pointer
+ * @select_idx: The counter index
+ * @val: The counter value
+ */
+void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
+{
+	kvm_pmu_release_perf_event(kvm_vcpu_idx_to_pmc(vcpu, select_idx));
+	__vcpu_sys_reg(vcpu, counter_index_to_reg(select_idx)) = val;
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+}
+
 /**
  * kvm_pmu_release_perf_event - remove the perf event
  * @pmc: The PMU counter pointer
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e8e9c781a929..4d1ef47d0049 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -960,6 +960,22 @@ static int get_pmu_evcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	return 0;
 }
 
+static int set_pmu_evcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
+			  u64 val)
+{
+	u64 idx;
+
+	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 0)
+		/* PMCCNTR_EL0 */
+		idx = ARMV8_PMU_CYCLE_IDX;
+	else
+		/* PMEVCNTRn_EL0 */
+		idx = ((r->CRm & 3) << 3) | (r->Op2 & 7);
+
+	kvm_pmu_set_counter_value_user(vcpu, idx, val);
+	return 0;
+}
+
 static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
 			      struct sys_reg_params *p,
 			      const struct sys_reg_desc *r)
@@ -1238,6 +1254,7 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 #define PMU_PMEVCNTR_EL0(n)						\
 	{ PMU_SYS_REG(PMEVCNTRn_EL0(n)),				\
 	  .reset = reset_pmevcntr, .get_user = get_pmu_evcntr,		\
+	  .set_user = set_pmu_evcntr,					\
 	  .access = access_pmu_evcntr, .reg = (PMEVCNTR0_EL0 + n), }
 
 /* Macro to expand the PMEVTYPERn_EL0 register */
@@ -2835,7 +2852,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	  .access = access_pmceid, .reset = NULL },
 	{ PMU_SYS_REG(PMCCNTR_EL0),
 	  .access = access_pmu_evcntr, .reset = reset_unknown,
-	  .reg = PMCCNTR_EL0, .get_user = get_pmu_evcntr},
+	  .reg = PMCCNTR_EL0, .get_user = get_pmu_evcntr,
+	  .set_user = set_pmu_evcntr },
 	{ PMU_SYS_REG(PMXEVTYPER_EL0),
 	  .access = access_pmu_evtyper, .reset = NULL },
 	{ PMU_SYS_REG(PMXEVCNTR_EL0),
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 147bd3ee4f7b..b6d0a682505d 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -47,8 +47,10 @@ static __always_inline bool kvm_arm_support_pmu_v3(void)
 #define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
+void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
 u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu);
+u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1);
 void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);

-- 
2.48.1


