Return-Path: <linux-kernel+bounces-382404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037559B0D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277F01C22381
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA021620F;
	Fri, 25 Oct 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AHPoUC9f"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6512161EB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880680; cv=none; b=CZwo0vKc3zo9eEo5zvHDNH2JPxglb7fjvm3cDgHjXA/LqZuP2rHaoruHudSCgbj0bW8siP9FJi3uxeD9+FuQ9IvG2A/iUxg5U8r7dHNVFCNlF1OhN3yEL3u0ikWHR+EwoJwb1oat3NaH67z41iOCUm/CCq2YhxTE0V+hARcEPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880680; c=relaxed/simple;
	bh=9vzq53PCmu/Y7zjKtU/lX/A81aiQzCSYL3Z1OonDC60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqCrq8d3iqYvtu7D7xFUPrtWRY9dRX+9h9ymz6/InT8B1LiqoVNn6yuQE7jVAgSK9Le7Cq8hp43hpJLn8BJz7/XolwdMqSqs//23MRGYQq/9NLrx0aL6iySpEVwB21as8vgVHql87tlljx3bv1VUth9I9aMIF8YC/qixu9JbDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AHPoUC9f; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729880675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQbPfXcKqguf2CSntuN0/NMKRu/M0rQKlM/2rK1MGZk=;
	b=AHPoUC9fdpWn9L1Z6PNl/PyiY2zsU/YeEPLLX12r1jXZ1Pon2gkoHeUmaHyYYpLeys3q1/
	uVFUNZWFZo0ZyV/3krAe8WdZqr23+kLc8HHxsPY6WNJDKGSbW7d2RsK/oJ6Mj+XSqAqoiE
	XaxW+2OMkQOMkhtqf7gxZIIVXqWMmLU=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v4 13/18] KVM: arm64: nv: Adjust range of accessible PMCs according to HPMN
Date: Fri, 25 Oct 2024 18:23:48 +0000
Message-ID: <20241025182354.3364124-14-oliver.upton@linux.dev>
In-Reply-To: <20241025182354.3364124-1-oliver.upton@linux.dev>
References: <20241025182354.3364124-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The value of MDCR_EL2.HPMN controls the number of event counters made
visible to EL0 and EL1. This means it is possible for the guest
hypervisor to allow direct access to event counters to the L2.

Rework KVM's PMU register emulation to take the effects of HPMN into
account when handling a trap. For bitmask-style registers, writes only
affect accessible registers.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 14 +++++++++++++-
 arch/arm64/kvm/sys_regs.c | 12 ++++++------
 include/kvm/arm_pmu.h     |  5 +++++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index fd08c4b53be3..0d669fb84485 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -283,6 +283,18 @@ bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int idx)
 	return idx >= hpmn;
 }
 
+u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
+{
+	u64 mask = kvm_pmu_implemented_counter_mask(vcpu);
+	u64 hpmn;
+
+	if (!vcpu_has_nv(vcpu) || vcpu_is_el2(vcpu))
+		return mask;
+
+	hpmn = SYS_FIELD_GET(MDCR_EL2, HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
+	return mask & ~GENMASK(vcpu->kvm->arch.pmcr_n - 1, hpmn);
+}
+
 u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu)
 {
 	u64 val = FIELD_GET(ARMV8_PMU_PMCR_N, kvm_vcpu_read_pmcr(vcpu));
@@ -592,7 +604,7 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 		kvm_pmu_set_counter_value(vcpu, ARMV8_PMU_CYCLE_IDX, 0);
 
 	if (val & ARMV8_PMU_PMCR_P) {
-		unsigned long mask = kvm_pmu_implemented_counter_mask(vcpu);
+		unsigned long mask = kvm_pmu_accessible_counter_mask(vcpu);
 		mask &= ~BIT(ARMV8_PMU_CYCLE_IDX);
 		for_each_set_bit(i, &mask, 32)
 			kvm_pmu_set_pmc_value(kvm_vcpu_idx_to_pmc(vcpu, i), 0, true);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index bd0c116f041b..8c226ec8bc25 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1131,7 +1131,7 @@ static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 va
 {
 	bool set;
 
-	val &= kvm_pmu_implemented_counter_mask(vcpu);
+	val &= kvm_pmu_accessible_counter_mask(vcpu);
 
 	switch (r->reg) {
 	case PMOVSSET_EL0:
@@ -1154,7 +1154,7 @@ static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 va
 
 static int get_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 *val)
 {
-	u64 mask = kvm_pmu_implemented_counter_mask(vcpu);
+	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
 
 	*val = __vcpu_sys_reg(vcpu, r->reg) & mask;
 	return 0;
@@ -1168,7 +1168,7 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
 
-	mask = kvm_pmu_implemented_counter_mask(vcpu);
+	mask = kvm_pmu_accessible_counter_mask(vcpu);
 	if (p->is_write) {
 		val = p->regval & mask;
 		if (r->Op2 & 0x1) {
@@ -1191,7 +1191,7 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			   const struct sys_reg_desc *r)
 {
-	u64 mask = kvm_pmu_implemented_counter_mask(vcpu);
+	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
 
 	if (check_pmu_access_disabled(vcpu, 0))
 		return false;
@@ -1215,7 +1215,7 @@ static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static bool access_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			 const struct sys_reg_desc *r)
 {
-	u64 mask = kvm_pmu_implemented_counter_mask(vcpu);
+	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
 
 	if (pmu_access_el0_disabled(vcpu))
 		return false;
@@ -1245,7 +1245,7 @@ static bool access_pmswinc(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	if (pmu_write_swinc_el0_disabled(vcpu))
 		return false;
 
-	mask = kvm_pmu_implemented_counter_mask(vcpu);
+	mask = kvm_pmu_accessible_counter_mask(vcpu);
 	kvm_pmu_software_increment(vcpu, p->regval & mask);
 	return true;
 }
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index b175b10491f0..b738ffb39bb0 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -48,6 +48,7 @@ static __always_inline bool kvm_arm_support_pmu_v3(void)
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
 u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu);
+u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu);
 u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1);
 void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
@@ -118,6 +119,10 @@ static inline u64 kvm_pmu_implemented_counter_mask(struct kvm_vcpu *vcpu)
 {
 	return 0;
 }
+static inline u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
 static inline void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
-- 
2.47.0.163.g1226f6d8fa-goog


