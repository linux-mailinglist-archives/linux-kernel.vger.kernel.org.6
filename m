Return-Path: <linux-kernel+bounces-303664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972496133A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D70F1F22CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D881C9EAF;
	Tue, 27 Aug 2024 15:48:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8521C7B71
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773736; cv=none; b=oDWkktkYFkQA21OPEA0q0tJygAOGbpBY6W3ou//ebeWhpRi+pjZjyGhHoLX9cDriaNgJs9sB1MxHSHaEqJcFVcuR3oLW4cdPL1Hon4j2kta+NxTM+3qTDzQNa7lViZr7iGNdNkLpHfLKINtuD3SWOWAkwwr8bADtuVUf9QJs3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773736; c=relaxed/simple;
	bh=W3GtIf/q/dclmT9LP7pIWn9sc+dPZw1d2AHJQ2Ll774=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bm/IOmG8PzWto2hmZT0qlwIUrcSaKz4drTNKhuPK3b22YL3B3/gyrjQ7Om4yN362wnCTZwxcmDLGuOP5+Fp+Vmu+oYsOghAnAjrQhYY/SJLccFTEORnYQOiL3d3IrAJHIFDIu0lM/0L+ndxL/2TyUHMvLxrYUkaN3DhwL2TDiBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26E13DA7;
	Tue, 27 Aug 2024 08:49:20 -0700 (PDT)
Received: from ionvoi01-desktop.cambridge.arm.com (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D65D3F762;
	Tue, 27 Aug 2024 08:48:52 -0700 (PDT)
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	catalin.marinas@arm.com,
	vincent.guittot@linaro.org,
	beata.michalska@arm.com
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	dietmar.eggemann@arm.com,
	pierre.gondois@arm.com
Subject: [PATCH] arch_topology: init capacity_freq_ref to 0
Date: Tue, 27 Aug 2024 16:48:18 +0100
Message-Id: <20240827154818.1195849-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's useful to have capacity_freq_ref initialized to 0 for users of
arch_scale_freq_ref() to detect when capacity_freq_ref was not
yet set.

The only scenario affected by this change in the init value is when a
cpufreq driver is never loaded. As a result, the only setter of a
cpu scale factor remains the call of topology_normalize_cpu_scale()
from parse_dt_topology(). There we cannot use the value 0 of
capacity_freq_ref so we have to compensate for its uninitialized state.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---

Hi,

This patch was previously part of the patch-set at [1], but we thought
it's best to separate the standalone patches in that set to make
further review easier on the remaining topics.

Based on v6.11-rc5 and tested on Juno with and without a cpufreq driver.

[1] https://lore.kernel.org/lkml/20240603082154.3830591-2-beata.michalska@arm.com/

Thanks,
Ionela.

 drivers/base/arch_topology.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 75fcb75d5515..c49ef1a712f4 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -28,7 +28,7 @@
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
-DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
+DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 0;
 EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
@@ -293,13 +293,15 @@ void topology_normalize_cpu_scale(void)
 
 	capacity_scale = 1;
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
+		capacity = raw_capacity[cpu] *
+			   (per_cpu(capacity_freq_ref, cpu) ?: 1);
 		capacity_scale = max(capacity, capacity_scale);
 	}
 
 	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
+		capacity = raw_capacity[cpu] *
+			   (per_cpu(capacity_freq_ref, cpu) ?: 1);
 		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
 			capacity_scale);
 		topology_set_cpu_scale(cpu, capacity);
-- 
2.25.1


