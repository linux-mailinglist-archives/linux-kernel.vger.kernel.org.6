Return-Path: <linux-kernel+bounces-547706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7187A50C82
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AA516E6DA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5825A653;
	Wed,  5 Mar 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j67styIc"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746D2571D2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206438; cv=none; b=T74NSBBVjystukGs19SjtGGgdjrj30sT6tLOguKkxzhgMbgmTbonffP5xtANbseWWNdPfwHdueIb3DPaZFH7P91uLdJCSEz41G9yMJnRCl8pDD+lLCmLQEriCwJhOUuzDP1DtZ39Xjjg8kzPn3ei/EV0cvhoT/fyVEHQTcFQB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206438; c=relaxed/simple;
	bh=8Lu11TjGp4gyr+MQq1xWXc+p1xthTU7mr1vBgnCMruU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYAPBbOJ4JXl6V6HP0Y+hDeboDU3ZbCJ6ULdo50nHjkG6INklx3zMgqDstaDDp7suI+ddhdKrRVufdZzBFvQ62WlWummMCFHKH8G1ETtp9IhEwSWB53XjUgtij5rJTfCOudiCdzHXr/4o89gM9vj7GYwmpSTg6ZeTr6wa8CnQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j67styIc; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741206435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THyb2hAFANk49lbyBjrbji8OLhzmvtcpQkFb5J3BMvM=;
	b=j67styIcO3xSLksWDsU+hmN0s0DezY8cdy3cwllJjFno7nugclMlFNH3q9WtZfSF4yFy1E
	CETonA9EcFBl3b7bQ15NG2gp4yHf14tCL8EUAFpMKSdiVpaUnNl0dy9Wrf4YWO4zCSfaQ5
	5Ei9YUOyBeyESBY3OY8pgzOFF+R0u+Y=
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
	Janne Grunau <j@jannau.net>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v3 07/14] KVM: arm64: Use guard() to cleanup usage of arm_pmus_lock
Date: Wed,  5 Mar 2025 12:26:34 -0800
Message-Id: <20250305202641.428114-8-oliver.upton@linux.dev>
In-Reply-To: <20250305202641.428114-1-oliver.upton@linux.dev>
References: <20250305202641.428114-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Get rid of some goto label patterns by using guard() to drop the
arm_pmus_lock when returning from a function.

Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 120f48136a0f..fee3d0003d54 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -790,26 +790,23 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
 	if (!pmuv3_implemented(kvm_arm_pmu_get_pmuver_limit()))
 		return;
 
-	mutex_lock(&arm_pmus_lock);
+	guard(mutex)(&arm_pmus_lock);
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
-		goto out_unlock;
+		return;
 
 	entry->arm_pmu = pmu;
 	list_add_tail(&entry->entry, &arm_pmus);
-
-out_unlock:
-	mutex_unlock(&arm_pmus_lock);
 }
 
 static struct arm_pmu *kvm_pmu_probe_armpmu(void)
 {
-	struct arm_pmu *tmp, *pmu = NULL;
 	struct arm_pmu_entry *entry;
+	struct arm_pmu *pmu;
 	int cpu;
 
-	mutex_lock(&arm_pmus_lock);
+	guard(mutex)(&arm_pmus_lock);
 
 	/*
 	 * It is safe to use a stale cpu to iterate the list of PMUs so long as
@@ -830,17 +827,13 @@ static struct arm_pmu *kvm_pmu_probe_armpmu(void)
 	 */
 	cpu = raw_smp_processor_id();
 	list_for_each_entry(entry, &arm_pmus, entry) {
-		tmp = entry->arm_pmu;
+		pmu = entry->arm_pmu;
 
-		if (cpumask_test_cpu(cpu, &tmp->supported_cpus)) {
-			pmu = tmp;
-			break;
-		}
+		if (cpumask_test_cpu(cpu, &pmu->supported_cpus))
+			return pmu;
 	}
 
-	mutex_unlock(&arm_pmus_lock);
-
-	return pmu;
+	return NULL;
 }
 
 static u64 __compute_pmceid(struct arm_pmu *pmu, bool pmceid1)
-- 
2.39.5


