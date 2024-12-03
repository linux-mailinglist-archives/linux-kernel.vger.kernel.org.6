Return-Path: <linux-kernel+bounces-430054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A619E2C18
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C65165AED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E720899B;
	Tue,  3 Dec 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sluqRxvy"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BE205E3B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733254391; cv=none; b=IiXj8CZZmjsniH6qq0AyH2J/Hc2Ze+UcFRuqu3xGjOoNie+yNkoRWpDuNA7/5UH05yhxSniZoAxD4YW/L3ljDnpSSxmqQ3/A7+btcQVTF02YCp46++sY8sqie543EDyUKc8jBdqYei79OToEMKG2gzoOJvq9ampPYv8zRCtkl3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733254391; c=relaxed/simple;
	bh=qOckG+G2KKpbK159U8SpKRtlVhc21nLwTcxuJwF7ZQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDQ860VUw95Pcq83G8IYTLlEF1HOygqLeo7L71Dt+dISJT0aw0QNwcGhf8ZYw6lnoiyvIXqlJLdY/YvpmvlMM9cPvkKz0DpHWGbx7mSfQikBYNOIac5zJaYrlMDy6z3xwXjIyOZ8mzQaEe34JMow6vWZz900evnrotqu0DnbpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sluqRxvy; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733254386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijxdRyc4mcLKg9rm6BGoJB0JmRAT0XsjGWyvMWN6qBk=;
	b=sluqRxvyoiZ4T+cA7m4vf4UtDNvz8FiYrPEq+xwCByoIHPK3Mnb3KQkCTpdGmzLYoC8Lks
	aHDgFaQGVg4lKw27Sz9K+s46Zu32yq+VSmk2vYfpSCMirtKaNfzFShx7DAWCgPbTP1AZk/
	wNZeXdiHcR2RmQDKPqgjf8AcHT0sNL0=
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
Subject: [RFC PATCH 05/14] KVM: arm64: Always allow fixed cycle counter
Date: Tue,  3 Dec 2024 11:32:11 -0800
Message-Id: <20241203193220.1070811-6-oliver.upton@linux.dev>
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

The fixed CPU cycle counter is mandatory for PMUv3, so it doesn't make a
lot of sense allowing userspace to filter it. Only apply the PMU event
filter to *programmed* event counters.

While at it, use the generic CPU_CYCLES perf event to back the cycle
counter, potentially allowing non-PMUv3 drivers to map the event onto
the underlying implementation.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 809d65b912e8..3e7091e1a2e4 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -707,26 +707,27 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
 	evtreg = kvm_pmc_read_evtreg(pmc);
 
 	kvm_pmu_stop_counter(pmc);
-	if (pmc->idx == ARMV8_PMU_CYCLE_IDX)
+	if (pmc->idx == ARMV8_PMU_CYCLE_IDX) {
 		eventsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
-	else
+	} else {
 		eventsel = evtreg & kvm_pmu_event_mask(vcpu->kvm);
 
-	/*
-	 * Neither SW increment nor chained events need to be backed
-	 * by a perf event.
-	 */
-	if (eventsel == ARMV8_PMUV3_PERFCTR_SW_INCR ||
-	    eventsel == ARMV8_PMUV3_PERFCTR_CHAIN)
-		return;
+		/*
+		 * If we have a filter in place and that the event isn't
+		 * allowed, do not install a perf event either.
+		 */
+		if (vcpu->kvm->arch.pmu_filter &&
+		    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
+			return;
 
-	/*
-	 * If we have a filter in place and that the event isn't allowed, do
-	 * not install a perf event either.
-	 */
-	if (vcpu->kvm->arch.pmu_filter &&
-	    !test_bit(eventsel, vcpu->kvm->arch.pmu_filter))
-		return;
+		/*
+		 * Neither SW increment nor chained events need to be backed
+		 * by a perf event.
+		 */
+		if (eventsel == ARMV8_PMUV3_PERFCTR_SW_INCR ||
+		    eventsel == ARMV8_PMUV3_PERFCTR_CHAIN)
+			return;
+	}
 
 	memset(&attr, 0, sizeof(struct perf_event_attr));
 	attr.type = arm_pmu->pmu.type;
@@ -877,6 +878,8 @@ static u64 compute_pmceid0(struct arm_pmu *pmu)
 
 	/* always support CHAIN */
 	val |= BIT(ARMV8_PMUV3_PERFCTR_CHAIN);
+	/* always support CPU_CYCLES */
+	val |= BIT(ARMV8_PMUV3_PERFCTR_CPU_CYCLES);
 	return val;
 }
 
-- 
2.39.5


