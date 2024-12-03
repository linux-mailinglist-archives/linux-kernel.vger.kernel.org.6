Return-Path: <linux-kernel+bounces-430055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6909E2C1A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55239165B43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502FE209F49;
	Tue,  3 Dec 2024 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TQW/xvxD"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C3204081
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733254392; cv=none; b=iUrojfCLoH3Dc/CNYD3LC4VGomC8DRJ0u8urAi46dvey6vh9BguJMxQ5526K50tFhnyT7ArNT2Bq75YxIgkJAlt+MNKelmYnJYRmQEF3ExwhT4DQVwM5mml4uLwL1lUTbpbJD5ZGgl4IBetmdgcbcJg7yp1OUIJJiVn9Ft/kmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733254392; c=relaxed/simple;
	bh=eE87/VYjBAUQSf916uxRztpFojr+GZWKYE3ex13i+b8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJq3tipWl0C447I5IA3nAKaZfsL0PhtzcqWcrNA0+eJDMCUUlvFb8Ym2YLvILi8rxoLhdxauOfnXtarcQmJab+aKtnKlM9zhjNWSDjYHa5UMHBU1D0QhAYdIVYh4wWdgoYDN26sfgr5V1L3sYuZnaa+xIQ/OAUrJO6FGeZ/c7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TQW/xvxD; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733254389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2WPpz2Qk6slKm6K4L/hEF3t3hcDY4cKIF/iBTjqOWQ=;
	b=TQW/xvxDkAst3EoN0BB+tNWtuzOBv8CuD8/HpYmenhK7aBN9e/64QzSF4nLIc59Y99E79S
	kHZAAxb1BftagUhFLL8qJL+w1dhuyyYG9sk3fzZqEkoQvF0LhF09K5Rcfuw4rUAaG5ZJY1
	ttCVmu+rjebQpeeqDtJFoRU3kDMWQds=
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
Subject: [RFC PATCH 06/14] KVM: arm64: Use PERF_COUNT_HW_CPU_CYCLES for fixed cycle counter
Date: Tue,  3 Dec 2024 11:32:12 -0800
Message-Id: <20241203193220.1070811-7-oliver.upton@linux.dev>
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

KVM will soon be able to emulate PMUv3 on non-PMUv3 hardware. Use the
generic event for CPU cycles to allow a non-PMUv3 driver to map the
event correctly on underlying hardware.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 3e7091e1a2e4..0b2ad60717e8 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -700,16 +700,27 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
 {
 	struct kvm_vcpu *vcpu = kvm_pmc_to_vcpu(pmc);
 	struct arm_pmu *arm_pmu = vcpu->kvm->arch.arm_pmu;
+	struct perf_event_attr attr = {};
 	struct perf_event *event;
-	struct perf_event_attr attr;
 	u64 eventsel, evtreg;
 
 	evtreg = kvm_pmc_read_evtreg(pmc);
 
 	kvm_pmu_stop_counter(pmc);
 	if (pmc->idx == ARMV8_PMU_CYCLE_IDX) {
-		eventsel = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
+		/*
+		 * Use the common event space for the cycle counter, allowing
+		 * the underlying PMU driver to map it onto hardware in the
+		 * unlikely case the host doesn't actually have PMUv3.
+		 */
+		attr.type = PERF_TYPE_HARDWARE;
+		eventsel = PERF_COUNT_HW_CPU_CYCLES;
 	} else {
+		/*
+		 * Otherwise, treat the event as a raw event for the selected
+		 * PMU.
+		 */
+		attr.type = arm_pmu->pmu.type;
 		eventsel = evtreg & kvm_pmu_event_mask(vcpu->kvm);
 
 		/*
@@ -729,8 +740,6 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
 			return;
 	}
 
-	memset(&attr, 0, sizeof(struct perf_event_attr));
-	attr.type = arm_pmu->pmu.type;
 	attr.size = sizeof(attr);
 	attr.pinned = 1;
 	attr.disabled = !kvm_pmu_counter_is_enabled(pmc);
-- 
2.39.5


