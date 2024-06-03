Return-Path: <linux-kernel+bounces-198775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA7F8D7D35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28967283031
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3407E765;
	Mon,  3 Jun 2024 08:22:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C79F7829C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402939; cv=none; b=J0l1c6aIfaQ8VozRVQxh1lRNO1t4rFLdDg6rcRRmnGjwf/MY2Zd+j3DhHXQQCasJtwHhYLDT8JCFypMyTS7dIy5hY7I7QcpoR7OVo75SKLMdR8GgaBiTLnMPpMk0CWzO2f5eSU5nQKVXLdMBwL3J33+um0IKI4XIsq8E0Y46c2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402939; c=relaxed/simple;
	bh=FrYBEuC2EWkcA/x4vedBv4/lo/U8SlIy+bWz2wH/mds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGJ4WerKUW+aqqg2Z2vQx+cT1712z6bhrE5ub4i8Iw18PGnU9PjVQI4463vDbAz5IbF+4ecwKzN2HBK7/Ukee1mnnwDmQutRXi/Q8CRFx5tRxH7XE58XKoCH7uF9C6xZXkyABpCqRnHIvmpeJVCeKkYJzMCvzJW8thv+EwMCD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0514E1042;
	Mon,  3 Jun 2024 01:22:42 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 07C043F792;
	Mon,  3 Jun 2024 01:22:15 -0700 (PDT)
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
Subject: [PATCH v6 4/4] arm64: Update AMU-based freq scale factor on  entering idle
Date: Mon,  3 Jun 2024 09:21:54 +0100
Message-Id: <20240603082154.3830591-5-beata.michalska@arm.com>
In-Reply-To: <20240603082154.3830591-1-beata.michalska@arm.com>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the frequency scale factor has been activated for retrieving
current frequency on a given CPU, trigger its update upon entering
idle. This will, to an extent, allow querying last known frequency
in a non-invasive way. It will also improve the frequency scale factor
accuracy when a CPU entering idle did not receive a tick for a while.
As a consequence, for idle cores, the reported frequency will be the
last one observed before entering the idle state.

Suggested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/kernel/topology.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 2c002d2c3e0b..56c5b2e632b4 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -213,6 +213,19 @@ static __always_inline bool amu_fie_cpu_supported(unsigned int cpu)
 		cpumask_test_cpu(cpu, amu_fie_cpus);
 }
 
+void arch_cpu_idle_enter(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (!amu_fie_cpu_supported(cpu))
+		return;
+
+	/* Kick in AMU update but only if one has not happened already */
+	if (housekeeping_cpu(cpu, HK_TYPE_TICK) &&
+	    time_is_before_jiffies(per_cpu(cpu_amu_samples.last_update, cpu)))
+		amu_scale_freq_tick();
+}
+
 #define AMU_SAMPLE_EXP_MS	20
 
 unsigned int arch_freq_get_on_cpu(int cpu)
@@ -239,8 +252,8 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	 * this boils down to identifying an active cpu within the same freq
 	 * domain, if any.
 	 */
-	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
-	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
+	if (!housekeeping_cpu(cpu, HK_TYPE_TICK) || (!idle_cpu(cpu) &&
+	    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS)))) {
 		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 		int ref_cpu = cpu;
 
-- 
2.25.1


