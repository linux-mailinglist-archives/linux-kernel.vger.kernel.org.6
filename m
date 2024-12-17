Return-Path: <linux-kernel+bounces-449965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F8B9F58B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6889617101E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898CE1FC0FF;
	Tue, 17 Dec 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wFRC6+CU"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4751FC0E8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470492; cv=none; b=qLvG60jnH9mUpWDl+0nTk4RyMhwZylry8ojhtvDhOeGjgGcK03w94AO63mir03KM3TtSTuMi42Wvmh7NJ7Ek8QsU7dOZjYXZbVLjh4zy40wfNHyZ9vtt6F6pQbc91lY5cU3Gf/CWCCcYuUddFJn0/wDhP6vdBXq2/fZdiGoEpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470492; c=relaxed/simple;
	bh=y+ObmbNISJLb+uQ/1aO7C0d5l+RElAtrw1fQHEN6vfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tt+jdIcPFxD4o+gm9mqyQaIIEHhSpEx/wT52HnXvl7go9LW8n7ERvLxdV/2nt57lvgw9sU5kxeymZYkdckksBmdLpOMdUQ1gUOpYr/0+OwkYy6EuUSc78d7e+aJCZsMvEPLxiK3hNhJig061HCvAe/GvxzPonvvJPGxzhuRYsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wFRC6+CU; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734470488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTQ2Tzn1HxAPU/EVgkiyp2AhrhJBkik6I90AqfM4kFo=;
	b=wFRC6+CUAMdRwboZkqFztEUtrhANO3wvwnKa2x+r/zKBV+O2jkyh51t0hCh82UiFi/wjZ5
	c0KX6V49bHL19huUTON3rMl+szrUm3Psf81+4lO1iPBGS1KhE4ZipLoBMOBVc+u/EbqBPf
	6tfob6iPBsWLgRokJUrSihicu3tT+F0=
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
Subject: [PATCH 10/18] KVM: arm64: Use guard() to cleanup usage of arm_pmus_lock
Date: Tue, 17 Dec 2024 13:20:40 -0800
Message-Id: <20241217212048.3709204-11-oliver.upton@linux.dev>
In-Reply-To: <20241217212048.3709204-1-oliver.upton@linux.dev>
References: <20241217212048.3709204-1-oliver.upton@linux.dev>
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

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pmu-emul.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 33cd694c754f..2c98cf24bef3 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -821,26 +821,23 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
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
@@ -861,17 +858,13 @@ static struct arm_pmu *kvm_pmu_probe_armpmu(void)
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


