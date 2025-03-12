Return-Path: <linux-kernel+bounces-557656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D22A5DC12
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FBC3B3602
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFEF243370;
	Wed, 12 Mar 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="cbeP0VEi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1324061F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780586; cv=none; b=mJTtiKB2FON491eBC131+2fwXOrY0eQkdS1zZbW2zoauOgWCGaOFqqFOVUbOkJ13ubqOBkr0WbwhpU2r+xpwXLnVPcRJ19jst9Kpip9gR8GUL7WHDq8JAfkaCVnM/ftz4taq2F57/qBSbS1gscH2vR111e4hKiHnqk7b+LGsCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780586; c=relaxed/simple;
	bh=T5ZrCuiwP99CKRJiyuMFvbhV9YXqT9moZhal0ysaEVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R8WwGonIyXO6cFVoMHpdg6pxCgtejbyX7g63il2baAvf5O45jZVOFVJ7Wx4fxLEGvQvs18EKNGyDlKBHzTkd9zSw0bUgOIhKAx0ojKA1NtsRykVFF6+5StpP5VHwpFjRRqPPIPp4bB11CrcoY/JKYsMTL49aI9YUBZsji8DIWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=cbeP0VEi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225b5448519so4565615ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741780584; x=1742385384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSsGsr3kAuFxcrtpSfRGA99t0k+DUOp8ehJUjKxyPeQ=;
        b=cbeP0VEiezbAB3Y9Q8tV0xu/6MbjYoL/lvGCt3dcx88xeuneEEQ/B8Tcc8VRC08NbI
         8X4dREl5viuiEwQcrQA16Awx95ahmqL1RzXlenGrOgsi/x8gpcWybz29fGKvzAy6RVX/
         TM7LMhuM1vAXMXcyNU6ykHjSyjiQnoHmdc+WO5Y2gTWrdpEISFvcU/wLqbLf51CSoxpb
         ux2KQbmbGf4/vx0zPPEuj4tEpNdyCv3yW+4+e/GDduqKT4OUTqCYdXXYuPifUFf5Bbrr
         nuKnSdLONyk+OnOc6aqMXJ2AC4xNwiXLhlTobYp19NW+e9civkQp92s7uu3tYg5Bv6oD
         xg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780584; x=1742385384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSsGsr3kAuFxcrtpSfRGA99t0k+DUOp8ehJUjKxyPeQ=;
        b=MYguunEV94be/nW3RyjAJOUP0MLtSKBdI4Jl4M0z+LSK50sT5okjbTaVfDF+u6yzpI
         ma0UNvZp0eW5GyqFIXyf+SLN9JaoRSCXyO6uu2DW7AvSkQ/D5hCFzhPF5yIefqVOqO3q
         PuIW37PLewqAqmbO04MiQuX3Up4VCPgy8MEKXvqDTl+tJlbQZT1EZo/1hcrK3ZXpl6WW
         bHRy40GJGpSwdDoD87ttEHZ1bhbRyjJa+pB+TNiEG3qz0Tc1r/KK3c1lkH5BqNfd3r7x
         CUc60tlaEuyhtFDJ9ZoSxVqhfbTBKScIdDf4DOktIGgUdwG8gbYPe8C57rc04w+jfJ++
         kA3A==
X-Forwarded-Encrypted: i=1; AJvYcCWxtGgy5lWrYmtmnGnrVdDgyiUwBP7JOqaQZk5kMTtEMzSmrItz8TUsQOh4BQVADyaKjuHCtdQc14tVoRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx68Iq2OJlPH96nAxZBN366mnTkIGK7oKt2OossTvkr2PVQDKc3
	zoDGOzfpoqcbfsDnYmow+FUa4AHawRmbAvqHjMSRgpCe2x1lPK+YQJc5sjt3Q5I=
X-Gm-Gg: ASbGncsnMSpwyWXwKouPXBPlGU7Fv2OaBoPdUgSvTIU9yXsdS7/7n37yC0iJFoyfmKy
	XbS24151msJAWq6+g+46mdTRe4ArALHboeGXLS8LDBhERsK7l+SoqY5oIeAlBjKNOCipJVg1gmu
	2lr+C1E1rWEqlTebBmkprHfQ1lfDjapFNrYVPm0Vh7AxpZPUzaw4ufTRVzmMsY5Q/GOJcuf6Ku/
	N/ILNIceftYtkLT/iFyMTSnzDhlv/AyNgJ2syCqWppu75ZqnAdg0TiW2mA0/C6mQlVrFnjEpxH4
	jMP89fvdR1NGg+zE1ga9yKSd5hA+Me2h3PtokBfn4dfJZrW66TsAAjeNOJE=
X-Google-Smtp-Source: AGHT+IEySYB2KOvAVkEbdUGCk7PaLmynA5DtA3ifevnpQFe/NSoQ7IgcTUmRgz4PK00aGrJKKcPhDQ==
X-Received: by 2002:a05:6a00:8e09:b0:736:ff65:3fcc with SMTP id d2e1a72fcca58-736ff65443emr3402126b3a.16.1741780584028;
        Wed, 12 Mar 2025 04:56:24 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736b7bb0bf2sm9336341b3a.42.2025.03.12.04.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 04:56:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 12 Mar 2025 20:55:57 +0900
Subject: [PATCH v3 3/6] KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pmc-v3-3-0411cab5dc3d@daynix.com>
References: <20250312-pmc-v3-0-0411cab5dc3d@daynix.com>
In-Reply-To: <20250312-pmc-v3-0-0411cab5dc3d@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>
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
 include/kvm/arm_pmu.h     |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 3e5bf414447f..1cfe53b6353e 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -185,6 +185,19 @@ void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
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
index 6e75557bea1d..26182cae4ac7 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1035,6 +1035,22 @@ static int get_pmu_evcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
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
@@ -1309,6 +1325,7 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 #define PMU_PMEVCNTR_EL0(n)						\
 	{ PMU_SYS_REG(PMEVCNTRn_EL0(n)),				\
 	  .reset = reset_pmevcntr, .get_user = get_pmu_evcntr,		\
+	  .set_user = set_pmu_evcntr,					\
 	  .access = access_pmu_evcntr, .reg = (PMEVCNTR0_EL0 + n), }
 
 /* Macro to expand the PMEVTYPERn_EL0 register */
@@ -2665,7 +2682,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
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
index 28b380ad8dfa..9c062756ebfa 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -41,6 +41,7 @@ bool kvm_supports_guest_pmuv3(void);
 #define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
+void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
 u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1);
 void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu);

-- 
2.48.1


