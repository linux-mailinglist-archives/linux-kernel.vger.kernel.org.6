Return-Path: <linux-kernel+bounces-198773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D69C8D7D33
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEEB1C216F6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1D6EB4A;
	Mon,  3 Jun 2024 08:22:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C15BAC3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402936; cv=none; b=ZQcWmutcUCNYD5MDv17GR+e+ndU1bgIhOWOKpMqiacfT6n1rAAwzggKxD5EjmfJiqGdE/AlIUKxeHiA97TVm3aUVxSx1yZ/njHpZSc1m6jRcLNIET3Pl3uzrpD6vgAiWzlxLFDeMwlgAeXGLeAgtSLTX8kv7VDz6+PdwniORCw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402936; c=relaxed/simple;
	bh=mcByuKxJJ46kPM0AYKATs2LizIwbORX/DJJd+bwMDLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYtCXWASA+dxWVXuUNj7Gea8fZwn8VYtYY6GlnE4B+La5K4m1iYy8kYYPlQiH2Mr4/yHJyPpGKSIScyfEg/rVXI0Q13PLIoUXcQSm8yyOdDmfRHSbVGi2ziKo6XjX3MLCItkYt8pIRYRcwHLYxU2exzpjcTtg0jYr8aBwmzymP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3541A106F;
	Mon,  3 Jun 2024 01:22:38 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37BE93F792;
	Mon,  3 Jun 2024 01:22:12 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com,
	sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	vincent.guittot@linaro.org,
	vanshikonda@os.amperecomputing.com
Cc: sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	lihuisong@huawei.com,
	viresh.kumar@linaro.org,
	rafael@kernel.org
Subject: [PATCH v6 2/4] arm64: amu: Delay allocating cpumask for AMU FIE support
Date: Mon,  3 Jun 2024 09:21:52 +0100
Message-Id: <20240603082154.3830591-3-beata.michalska@arm.com>
In-Reply-To: <20240603082154.3830591-1-beata.michalska@arm.com>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the time being, the amu_fie_cpus cpumask is being exclusively used
by the AMU-related internals of FIE support and is guaranteed to be
valid on every access currently made. Still the mask is not being
invalidated on one of the error handling code paths, which leaves
a soft spot with theoretical risk of uaf for CPUMASK_OFFSTACK cases.
To make things sound, delay allocating said cpumask
(for CPUMASK_OFFSTACK) avoiding otherwise nasty sanitising case failing
to register the cpufreq policy notifications.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/kernel/topology.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1a2c72f3e7f8..e475ec2705e1 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -194,11 +194,16 @@ static void amu_fie_setup(const struct cpumask *cpus)
 	int cpu;
 
 	/* We are already set since the last insmod of cpufreq driver */
-	if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
-		return;
+	if (cpumask_available(amu_fie_cpus) &&
+	    unlikely(cpumask_subset(cpus, amu_fie_cpus)))
+	    return;
 
 	for_each_cpu(cpu, cpus) {
-		if (!freq_counters_valid(cpu))
+	    if (!cpumask_available(amu_fie_cpus) &&
+	        !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
+	        return;
+
+	    if (!freq_counters_valid(cpu))
 			return;
 	}
 
@@ -237,17 +242,8 @@ static struct notifier_block init_amu_fie_notifier = {
 
 static int __init init_amu_fie(void)
 {
-	int ret;
-
-	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
-		return -ENOMEM;
-
-	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
+	return cpufreq_register_notifier(&init_amu_fie_notifier,
 					CPUFREQ_POLICY_NOTIFIER);
-	if (ret)
-		free_cpumask_var(amu_fie_cpus);
-
-	return ret;
 }
 core_initcall(init_amu_fie);
 
-- 
2.25.1


