Return-Path: <linux-kernel+bounces-550921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE46A565E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CFF1695F7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A70212B38;
	Fri,  7 Mar 2025 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="S7445gr4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF892116FF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344940; cv=none; b=X4CHXX6j2eCGxpB3BLeaDqg0tkmhCzFD+rQQLvT1wfmf8pIUqq1nxDgpbbddv2hR3SxEnhC0PWYJnoPnfhafcpTVG0oCLCZJyxsHT3dYNuVLjlJMIa++AUqfsbvz7W0B5H7AEw/2cyDQyRXPYM5/HM/EDVrCJ5ghU11ee2umL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344940; c=relaxed/simple;
	bh=CtDw6xTemlzhoe3Mf/ikMlb2drvcCXVf6yE4VYRuHlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+uiAQ4QdK2zqd8tL/Z09Cre+OcZAVQfWzF1lNcPtwzRwdXZFQaLAWzI/sa79RySvbis/9ymOfckDCTjxfv7cefGMf2+0r4AJZzhGwIGumGSMmyjqqbRbQiHAJBHUz+CDaR8ZZSc+c4WYc9Nt/m3Fva9meb7iEPdBNZHeC9R/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=S7445gr4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22409077c06so37942485ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741344938; x=1741949738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1Rms3TAKvJ0DWAIQahRYenmqeYz1Pw9/up2OrK8qe4=;
        b=S7445gr4goKMyq1QhVZBJirS1uInNMQ9yl6vDKCzsZXWw6aUUeeM3sEzoHweKZ/Gi5
         kH7gbI3rVaAcRpOyEhFRMVej1qIzHqDftIJypSebpVgepgeLbU2Ah2uB5G32w1zL5iw6
         WHC22CSxOAmF8erqRFKSZIttxdfLYVb4yufKWog9z7Ek1QBsWzqvY3RcBdVuisFudxx9
         aLDpoEptAZcewACZdGcNfDTgUc7cycEemS44m9F5wW1sXevM1MsYJgIlSsYfxVeYogDj
         WyYPFSvtB6KqCTGF2i76GbDgxTXKtvYy8GRT8iDtBCECiTsOdD1zpUxAJO3e9u36VTaF
         YNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741344938; x=1741949738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1Rms3TAKvJ0DWAIQahRYenmqeYz1Pw9/up2OrK8qe4=;
        b=ISP/ILXjsZlJyfRw25Bb2r2isBp0+RQWDvDXfv99vQdFGG2xLs++MjmAD+1ZDJLvBl
         kGStfLZlN9AyPpPvQsyQn4zOdwBrxiIe0BxHYd5curfxghyOrckZ0c1MNKE6CnVrxfjp
         1FEbT1Xo1r14nJj29rxhei9JCmFedLM/jVEy7odode0JnUBrQXLbvamscjkyIFjPMPNS
         AaII5EEHMAiqjaXrRIaB5U+OS8vz/vdIhJOAoiS8GpSNhZ3IP2C0YRFnqr4T/ZJNsNKA
         aALTVWTfBAkRV3O6fdPmLKMGSw9tqhslX+k377Xt3p16VQOyXxUb+WefPv9+NnXeb1bw
         gZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCV4kfB0g9ATBcvBCb0PD5wmYwgpo5iA6xGDiaGNxi4IS73k8pFtOXScoBgBS2v9loDpB36eban/D0g5Its=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM26GV2iZNR3z17RXh3TTo1ClolQCTAhHW0TrbkFuYUPovc2eq
	xj3I4oh6ZpXr7Z3xDH88W0gaWTtjRqWB8vYgdi4gI2kLKBAtu8GHcoM8Uv0mxsc=
X-Gm-Gg: ASbGnctPUzF6R/MFuaoWwos6qBfTT6xNrI1KfkbLwe25pqdp72FM3mSNR2nwQnxs3W7
	hAyv5D6BWuOqGRncjkfNnZAaqRgUsj29KcMl+4xIPHlsCTo9w2wqBhnk7/lpRbCCzpjN1fVdpf3
	0leu3aHsZoD2uLFViz78Xr/oxbO9E51JlSyRODZWwRAch8VVrsOkimUVzgpWBWxETjOco6OxO78
	5WDAMfx6ozktdYxuMORMA1oRwd5x36nOK8cPKdORUNwyYRa/vTGLBR9rUQcgLBSeqKmP6phpyEQ
	A/ArqNSFmN2EgSFxDErKBHW8iWq+gpySf5kPdf9/M0cmx28e
X-Google-Smtp-Source: AGHT+IHp21Tz3W1NVSkiBkXo05zCKdRXsyhKUTTj6kvZ1eTKmFZGZ/WkqB5Jrack/mZQWt+UsvaCdA==
X-Received: by 2002:a17:902:e80a:b0:224:13a4:d61e with SMTP id d9443c01a7336-22428c0a43bmr38314595ad.51.1741344938150;
        Fri, 07 Mar 2025 02:55:38 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a908a0sm27232235ad.162.2025.03.07.02.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 02:55:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Mar 2025 19:55:28 +0900
Subject: [PATCH v2 1/3] KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-pmc-v2-1-6c3375a5f1e4@daynix.com>
References: <20250307-pmc-v2-0-6c3375a5f1e4@daynix.com>
In-Reply-To: <20250307-pmc-v2-0-6c3375a5f1e4@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

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

Fix this by releasing the current perf event and trigger recreating one
with KVM_REQ_RELOAD_PMU.

Fixes: 051ff581ce70 ("arm64: KVM: Add access handler for event counter register")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/pmu-emul.c | 16 ++++++++++++++++
 arch/arm64/kvm/sys_regs.c | 20 +++++++++++++++++++-
 include/kvm/arm_pmu.h     |  1 +
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index e3e82b66e2268d37d5e2630e47ddf085a6846e1c..1402cce5625bffa706aabe5e6121d1f3817a0aaf 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -191,6 +191,22 @@ void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val)
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
+	if (!kvm_vcpu_has_pmu(vcpu))
+		return;
+
+	kvm_pmu_release_perf_event(kvm_vcpu_idx_to_pmc(vcpu, select_idx));
+	__vcpu_sys_reg(vcpu, counter_index_to_reg(select_idx)) = val;
+	kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+}
+
 /**
  * kvm_pmu_release_perf_event - remove the perf event
  * @pmc: The PMU counter pointer
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 42791971f75887796afab905cc12f49fead39e10..27418dac791df9a89124f867879e899db175e506 100644
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
@@ -1328,6 +1344,7 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 #define PMU_PMEVCNTR_EL0(n)						\
 	{ PMU_SYS_REG(PMEVCNTRn_EL0(n)),				\
 	  .reset = reset_pmevcntr, .get_user = get_pmu_evcntr,		\
+	  .set_user = set_pmu_evcntr,					\
 	  .access = access_pmu_evcntr, .reg = (PMEVCNTR0_EL0 + n), }
 
 /* Macro to expand the PMEVTYPERn_EL0 register */
@@ -2682,7 +2699,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
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
index 28b380ad8dfa942c4275e0c7ed3535d309b81b2f..9c062756ebfad5ea555362154459ffe9f8311c6d 100644
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


