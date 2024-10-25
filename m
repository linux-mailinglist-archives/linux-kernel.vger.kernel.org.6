Return-Path: <linux-kernel+bounces-382405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD159B0D30
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF08B25F85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CC418F2F6;
	Fri, 25 Oct 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ejB6tZgt"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F2216200
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880681; cv=none; b=GO1bSYwJiWNq8mzP8VOfYiZsOOkXV3M9yEgnPw9Z9uFb1QzsutYeokFF2yR74qTfM1hWo6KFaRPMLEBdL0xHdkPgTxpGmv5mu3qFaw+hP+QVqOPqj07fqI4RziBNYxDV0lgW6J/fnbDR7LmbNQLT/uOZ+3hBJbOZ/kXR1vamlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880681; c=relaxed/simple;
	bh=NycnbOmqbmRqcBTORz7kn7nxCumdEciTRup8fIwDwBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJsFXJ5/ghigLjX+qCYM2w70TiSsrPT89fNy9jDs7iLjVG3zL8uGyrOWXXaKCCj+RWVluqV8hfUeqt32UgmB6UhrLhsquSZj3ka4ZfMqyVxWYOGqvgnaAXRTs8y+ZAIu+jprinA41tV5GUYnQbwUSPXCMqgnp/ADw7SSwgMzlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ejB6tZgt; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729880678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWJEQN56N/CeKfveDMMoJU65zML9g/eXZiwy9Gw5WvI=;
	b=ejB6tZgterLk/gbHmBLxWNnprsUUwqRnXUpyPbf/SYm1C0qPn8Ks1SwIKU9WW/VEyoim94
	aWHL5eKiXMOYI7r2KQkQMiicqSsdEFqd6VX9jp6RVhi5O44qT3bKU3KS7jbpcEAB4TrLkw
	SLgGU+sYMsYhnSYtXBegEs5nN8IENs0=
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
Subject: [PATCH v4 14/18] KVM: arm64: Add helpers to determine if PMC counts at a given EL
Date: Fri, 25 Oct 2024 18:23:49 +0000
Message-ID: <20241025182354.3364124-15-oliver.upton@linux.dev>
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

Checking the exception level filters for a PMC is a minor annoyance to
open code. Add helpers to check if an event counts at EL0 and EL1, which
will prove useful in a subsequent change.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 40 +++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 0d669fb84485..03cd1ad7a55a 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -111,6 +111,11 @@ static u32 counter_index_to_evtreg(u64 idx)
 	return (idx == ARMV8_PMU_CYCLE_IDX) ? PMCCFILTR_EL0 : PMEVTYPER0_EL0 + idx;
 }
 
+static u64 kvm_pmc_read_evtreg(const struct kvm_pmc *pmc)
+{
+	return __vcpu_sys_reg(kvm_pmc_to_vcpu(pmc), counter_index_to_evtreg(pmc->idx));
+}
+
 static u64 kvm_pmu_get_pmc_value(struct kvm_pmc *pmc)
 {
 	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
@@ -619,6 +624,24 @@ static bool kvm_pmu_counter_is_enabled(struct kvm_pmc *pmc)
 	       (__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & BIT(pmc->idx));
 }
 
+static bool kvm_pmc_counts_at_el0(struct kvm_pmc *pmc)
+{
+	u64 evtreg = kvm_pmc_read_evtreg(pmc);
+	bool nsu = evtreg & ARMV8_PMU_EXCLUDE_NS_EL0;
+	bool u = evtreg & ARMV8_PMU_EXCLUDE_EL0;
+
+	return u == nsu;
+}
+
+static bool kvm_pmc_counts_at_el1(struct kvm_pmc *pmc)
+{
+	u64 evtreg = kvm_pmc_read_evtreg(pmc);
+	bool nsk = evtreg & ARMV8_PMU_EXCLUDE_NS_EL1;
+	bool p = evtreg & ARMV8_PMU_EXCLUDE_EL1;
+
+	return p == nsk;
+}
+
 /**
  * kvm_pmu_create_perf_event - create a perf event for a counter
  * @pmc: Counter context
@@ -629,17 +652,15 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
 	struct arm_pmu *arm_pmu = vcpu->kvm->arch.arm_pmu;
 	struct perf_event *event;
 	struct perf_event_attr attr;
-	u64 eventsel, reg, data;
-	bool p, u, nsk, nsu;
+	u64 eventsel, evtreg;
 
-	reg = counter_index_to_evtreg(pmc->idx);
-	data = __vcpu_sys_reg(vcpu, reg);
+	evtreg = kvm_pmc_read_evtreg(pmc);
 
 	kvm_pmu_stop_counter(pmc);
 	if (pmc->idx == ARMV8_PMU_CYCLE_IDX)
 		eventsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
 	else
-		eventsel = data & kvm_pmu_event_mask(vcpu->kvm);
+		eventsel = evtreg & kvm_pmu_event_mask(vcpu->kvm);
 
 	/*
 	 * Neither SW increment nor chained events need to be backed
@@ -657,18 +678,13 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
 	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
 		return;
 
-	p = data & ARMV8_PMU_EXCLUDE_EL1;
-	u = data & ARMV8_PMU_EXCLUDE_EL0;
-	nsk = data & ARMV8_PMU_EXCLUDE_NS_EL1;
-	nsu = data & ARMV8_PMU_EXCLUDE_NS_EL0;
-
 	memset(&attr, 0, sizeof(struct perf_event_attr));
 	attr.type = arm_pmu->pmu.type;
 	attr.size = sizeof(attr);
 	attr.pinned = 1;
 	attr.disabled = !kvm_pmu_counter_is_enabled(pmc);
-	attr.exclude_user = (u != nsu);
-	attr.exclude_kernel = (p != nsk);
+	attr.exclude_user = !kvm_pmc_counts_at_el0(pmc);
+	attr.exclude_kernel = !kvm_pmc_counts_at_el1(pmc);
 	attr.exclude_hv = 1; /* Don't count EL2 events */
 	attr.exclude_host = 1; /* Don't count host events */
 	attr.config = eventsel;
-- 
2.47.0.163.g1226f6d8fa-goog


