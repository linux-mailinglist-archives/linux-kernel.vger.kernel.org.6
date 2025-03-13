Return-Path: <linux-kernel+bounces-558840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A00A5EBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A67E3B5171
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161B51FBE89;
	Thu, 13 Mar 2025 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="109+J2OL"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58251FC0FF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849092; cv=none; b=hy8+3xArpG5lcB/LwwtKwnYcFivvSusSCeQh2uHcnAMNf9yvguyRyiwc/6xAlaDQoM3YEsOyewDegmXkaF0SdnVzdoJKKShtKL+x2MlxJ/YNfEMwUqtO8d8GaYBCSojzrp2GZKn7waU5fG9W9/wDzJ50RWRdwuXJ3T27egrat5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849092; c=relaxed/simple;
	bh=IJXHD7sx8FOQ/TCbz0hTrjmBv+Lvr54IEhabSGoOnKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPY9HsobV+yXC2GeyTcCIIbQwyw4e1OKAQJkmweUlAUA2/77jqn6tDzpwU3V7+JkvYXjVE/r5jyH9Lz/gx4ba3knp1GSOoLk0Z2G/RsHNuFN2pREopGVBdWh7T1DSJvgA1WmKCdgZ6mY/C+8KoGQm+egzQKhkLKwp04c2Dns8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=109+J2OL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223f4c06e9fso11001785ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849090; x=1742453890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6iz2Tb4ku//H3AxfAexQ9B2Bw11aMopngIm2weGw1M=;
        b=109+J2OLKk5wJOik8w1QZw76hoQCU1oJNMTDXnjW2OhC9D+4n+WjQ3NkllY18b13ld
         QSu3MIhcu08mkp6OWOG7lMxTPaIWrqXqDB/YufawzSKDwFLrgIBJwZtmAQhevgE7jiBk
         /mktNhp3x8D3C+/W4DHJ+me3T2wRXttm2G9CsBI2iqwqWidqFX6Groa6avRhN6zRJi5J
         FNsX/CvLTtcXOsf7oFuloa9ZBYSXa6zpYGKAhozxxB+zVBGRw2hsr05yNOiyBYZVqdzR
         boaVsaY8n9bM6l/tGZS7MZWCnvFjU2VKhVW9mE3Pd6hkKxrAQ94bBvEiVTjXuSXWZqsb
         yZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849090; x=1742453890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6iz2Tb4ku//H3AxfAexQ9B2Bw11aMopngIm2weGw1M=;
        b=VH5WTD09f0qgy3nPOW5RPAiFTBJXXELekzkHE3ZE1sPczX5RuiUJglwr4wcBViRYc8
         FXjIpiRK7rvLh0D0GAEIMrHQQV/2e+Nri3cWlJSFBFGpXTH/RrPOydo4LV/GoF4A4zbH
         thsROG0QnY3/U52Cuy2AP3ksr9ZfEEk/Ng1+N8hsw+xJKTpmDbWloaBiQXKcx4QGvdqD
         oGN1BOuaG1JP6kDEv5BtL4wewBp9koNTmzKl1KGi1xI8q0WUWB5+IaeZvGy1hGmNYCso
         qQlj0ZnDwJX5xQLm6YDRCFqjWS+5u3GGy1gn7Ra5rozJ93KODejHurkoxHZw1VaAInNc
         huhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGIkS/81yJnUCzPSbX+vDUyioea0MaWuM2SmXAY6EZVdsDezfrK99BUdlUiPrHlaJEdSEbJHTuOzpidxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ9q7ugWLiDuLPJdKqcYCxg2515f5MoMkZsVXMvcZlitMm6wvz
	QSyiu7SnQH8HalymXsTe9eyEKZzuzu1KJkilRVu+A03QXaEfuEy+tZR/SUkr+7g=
X-Gm-Gg: ASbGncvqFhAxj6l66uOX7PEOEE5p2H27RO9kt6NAPzXgNyYNMjyFKpHLCLdT6aLAeFC
	rWCJeYVbJMcn+Y60o71IhdBhUVRljPiBCpvRnG/vp2xIPCFufPVXrI5+AFgnzc6i8J0rtGFqLpT
	yb6jiUX017f/xieIK+gOHa3ZxXLNfSoze1WgztJtYO9/fVvIt/3iAtSGcJxkVcSTPBHypVFHzAC
	oDEv2VNJ029/FH2hH9GdDuuWWoqdQhECxy+8N36hVNCLZbDyh0LW/dn35joFvOT0CG//Aq6JtqF
	vlSxATVIYvhLhgRfRYW0ng/gt68njiFHUmWyneb64FzwKHHO
X-Google-Smtp-Source: AGHT+IE5NpWqZ+PooCqPvK48p4HWbGtSfd6lTwIKoKKHaXf2OMgXMo53qPDLD1AgcAjnRYmc4YTHGw==
X-Received: by 2002:a17:902:d2c6:b0:215:742e:5cff with SMTP id d9443c01a7336-225c6672ca0mr23251545ad.16.1741849090214;
        Wed, 12 Mar 2025 23:58:10 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbe960sm6398075ad.200.2025.03.12.23.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 23:58:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:57:44 +0900
Subject: [PATCH v4 3/7] KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pmc-v4-3-2c976827118c@daynix.com>
References: <20250313-pmc-v4-0-2c976827118c@daynix.com>
In-Reply-To: <20250313-pmc-v4-0-2c976827118c@daynix.com>
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
 include/kvm/arm_pmu.h     |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 3dd0b479c6fd..1b91e5188d52 100644
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


