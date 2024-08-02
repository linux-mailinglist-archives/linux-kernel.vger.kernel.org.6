Return-Path: <linux-kernel+bounces-272701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFDA94600E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6D21F2393C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98643DABF5;
	Fri,  2 Aug 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCqVVoaP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D021C171
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611763; cv=none; b=B/BZpn9/B+wBWWf3OM5w35YhYjvgYUOccTNtxmwKz4LV09kEF82XRPvxIsYwzJ3J5Voi0C4VhPwdkvTc8pZ9iufmjB1ZK0w3nXIxtQ4PioWh5fjyOnbdJDIWhvLoioGMpJsjxDx9tqFvvnh1Y3zoOGp5ArIborMlrPXbeo611nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611763; c=relaxed/simple;
	bh=X/DZHGNEnpppzw6W66fG/5qG6ja3qRNvChuXNJE/48w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XRlU053M41M4lauqzf9VP4iNtTDqPW6ItIcDgaXGAz4/X93S4J1vm8gjGf60bBj2TuCsxQ1CmW6pGgZ9LEnxg2ZdW9XEXKU7eeJFRsnSxv3L2oMD/C234jsWR+mwquoAWPh1mZMZNqumR2IYogl388vjqfk3EBXXoZXaKZe9hec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCqVVoaP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722611763; x=1754147763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X/DZHGNEnpppzw6W66fG/5qG6ja3qRNvChuXNJE/48w=;
  b=OCqVVoaP7LPt8Nj90EH9pSKpsRCANA+JXhyFbhbCJo3XqZWg0US5lODt
   /TUv4LcijZMeDyX9dvxIqJm786d4rQ2Gu9CBcuNXfSHEvsDoLPcRHR451
   ONt3QiRZCb3Lfg4KHD5WZyN/Jj7IBoJWq/9t1CRJnesmCZqjz0j31s6Ls
   3oYH3SJLTaUpiVNGy9lqjTRk7PHiIr27afZ/3zeVYwAnyhRzW33TGzOAq
   8WWXEXQvl3RLJiu1sRvOa59b+IKCdk26bVVcX9aZqQ+tefkG+fdi8UbCt
   /fYr1LUVH6dW2x/HECwNsFpl/6AVodkPk44icel3C3dQc7Ai52eaWYyEA
   w==;
X-CSE-ConnectionGUID: RYRk/fM+Qt+cLVeAaed5iA==
X-CSE-MsgGUID: zdUrDHe8Rm6T06izzIEfdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20473772"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20473772"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:16:00 -0700
X-CSE-ConnectionGUID: m3YEcdw7RruD1VS/A3Y19g==
X-CSE-MsgGUID: f2Ic8290SdynwlOlesaHDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55516934"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 02 Aug 2024 08:15:59 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH 4/7] iommu/vt-d: Clean up cpumask and hotplug for perfmon
Date: Fri,  2 Aug 2024 08:16:40 -0700
Message-Id: <20240802151643.1691631-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240802151643.1691631-1-kan.liang@linux.intel.com>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The iommu PMU is system-wide scope, which is supported by the generic
perf_event subsystem now.

Set the scope for the iommu PMU and remove all the cpumask and hotplug
codes.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev
---
 drivers/iommu/intel/iommu.h   |   2 -
 drivers/iommu/intel/perfmon.c | 111 +---------------------------------
 2 files changed, 2 insertions(+), 111 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14da1240..bd2c5a4ca11a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -687,8 +687,6 @@ struct iommu_pmu {
 	DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
 	struct perf_event	*event_list[IOMMU_PMU_IDX_MAX];
 	unsigned char		irq_name[16];
-	struct hlist_node	cpuhp_node;
-	int			cpu;
 };
 
 #define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index 44083d01852d..75f493bcb353 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -34,28 +34,9 @@ static struct attribute_group iommu_pmu_events_attr_group = {
 	.attrs = attrs_empty,
 };
 
-static cpumask_t iommu_pmu_cpu_mask;
-
-static ssize_t
-cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return cpumap_print_to_pagebuf(true, buf, &iommu_pmu_cpu_mask);
-}
-static DEVICE_ATTR_RO(cpumask);
-
-static struct attribute *iommu_pmu_cpumask_attrs[] = {
-	&dev_attr_cpumask.attr,
-	NULL
-};
-
-static struct attribute_group iommu_pmu_cpumask_attr_group = {
-	.attrs = iommu_pmu_cpumask_attrs,
-};
-
 static const struct attribute_group *iommu_pmu_attr_groups[] = {
 	&iommu_pmu_format_attr_group,
 	&iommu_pmu_events_attr_group,
-	&iommu_pmu_cpumask_attr_group,
 	NULL
 };
 
@@ -565,6 +546,7 @@ static int __iommu_pmu_register(struct intel_iommu *iommu)
 	iommu_pmu->pmu.attr_groups	= iommu_pmu_attr_groups;
 	iommu_pmu->pmu.attr_update	= iommu_pmu_attr_update;
 	iommu_pmu->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+	iommu_pmu->pmu.scope		= PERF_PMU_SCOPE_SYS_WIDE;
 	iommu_pmu->pmu.module		= THIS_MODULE;
 
 	return perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
@@ -773,89 +755,6 @@ static void iommu_pmu_unset_interrupt(struct intel_iommu *iommu)
 	iommu->perf_irq = 0;
 }
 
-static int iommu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
-{
-	struct iommu_pmu *iommu_pmu = hlist_entry_safe(node, typeof(*iommu_pmu), cpuhp_node);
-
-	if (cpumask_empty(&iommu_pmu_cpu_mask))
-		cpumask_set_cpu(cpu, &iommu_pmu_cpu_mask);
-
-	if (cpumask_test_cpu(cpu, &iommu_pmu_cpu_mask))
-		iommu_pmu->cpu = cpu;
-
-	return 0;
-}
-
-static int iommu_pmu_cpu_offline(unsigned int cpu, struct hlist_node *node)
-{
-	struct iommu_pmu *iommu_pmu = hlist_entry_safe(node, typeof(*iommu_pmu), cpuhp_node);
-	int target = cpumask_first(&iommu_pmu_cpu_mask);
-
-	/*
-	 * The iommu_pmu_cpu_mask has been updated when offline the CPU
-	 * for the first iommu_pmu. Migrate the other iommu_pmu to the
-	 * new target.
-	 */
-	if (target < nr_cpu_ids && target != iommu_pmu->cpu) {
-		perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target);
-		iommu_pmu->cpu = target;
-		return 0;
-	}
-
-	if (!cpumask_test_and_clear_cpu(cpu, &iommu_pmu_cpu_mask))
-		return 0;
-
-	target = cpumask_any_but(cpu_online_mask, cpu);
-
-	if (target < nr_cpu_ids)
-		cpumask_set_cpu(target, &iommu_pmu_cpu_mask);
-	else
-		return 0;
-
-	perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target);
-	iommu_pmu->cpu = target;
-
-	return 0;
-}
-
-static int nr_iommu_pmu;
-static enum cpuhp_state iommu_cpuhp_slot;
-
-static int iommu_pmu_cpuhp_setup(struct iommu_pmu *iommu_pmu)
-{
-	int ret;
-
-	if (!nr_iommu_pmu) {
-		ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
-					      "driver/iommu/intel/perfmon:online",
-					      iommu_pmu_cpu_online,
-					      iommu_pmu_cpu_offline);
-		if (ret < 0)
-			return ret;
-		iommu_cpuhp_slot = ret;
-	}
-
-	ret = cpuhp_state_add_instance(iommu_cpuhp_slot, &iommu_pmu->cpuhp_node);
-	if (ret) {
-		if (!nr_iommu_pmu)
-			cpuhp_remove_multi_state(iommu_cpuhp_slot);
-		return ret;
-	}
-	nr_iommu_pmu++;
-
-	return 0;
-}
-
-static void iommu_pmu_cpuhp_free(struct iommu_pmu *iommu_pmu)
-{
-	cpuhp_state_remove_instance(iommu_cpuhp_slot, &iommu_pmu->cpuhp_node);
-
-	if (--nr_iommu_pmu)
-		return;
-
-	cpuhp_remove_multi_state(iommu_cpuhp_slot);
-}
-
 void iommu_pmu_register(struct intel_iommu *iommu)
 {
 	struct iommu_pmu *iommu_pmu = iommu->pmu;
@@ -866,17 +765,12 @@ void iommu_pmu_register(struct intel_iommu *iommu)
 	if (__iommu_pmu_register(iommu))
 		goto err;
 
-	if (iommu_pmu_cpuhp_setup(iommu_pmu))
-		goto unregister;
-
 	/* Set interrupt for overflow */
 	if (iommu_pmu_set_interrupt(iommu))
-		goto cpuhp_free;
+		goto unregister;
 
 	return;
 
-cpuhp_free:
-	iommu_pmu_cpuhp_free(iommu_pmu);
 unregister:
 	perf_pmu_unregister(&iommu_pmu->pmu);
 err:
@@ -892,6 +786,5 @@ void iommu_pmu_unregister(struct intel_iommu *iommu)
 		return;
 
 	iommu_pmu_unset_interrupt(iommu);
-	iommu_pmu_cpuhp_free(iommu_pmu);
 	perf_pmu_unregister(&iommu_pmu->pmu);
 }
-- 
2.38.1


