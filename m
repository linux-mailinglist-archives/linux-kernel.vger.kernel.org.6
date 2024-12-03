Return-Path: <linux-kernel+bounces-430049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B04D9E2C10
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102AD28436E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF019204087;
	Tue,  3 Dec 2024 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QElGUt9o"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A83B1FECC3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733254382; cv=none; b=YnurX+O6UwmQIEfQUHwp9SVH3uLyN1YaPTHrkTtq5ZGBYSrGUch1cKczinGYz0y4dhAylEuq0vIm7BUgyHK71MZ3DLGx6YxdYQCqzQTfb7cGcG04HY4aIhWARYx0mI31nlUp0qTwkpjnno9WMrfF0jrNTrJG28q42gxiJt+VlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733254382; c=relaxed/simple;
	bh=buy8FBwMtT0wxxmP/EHcZGI1fziOVUj+xaCyjH1kHAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEsnoO8Oqv7GINgSmweXeVkqMc77FQIyoJMUBsmqv0iCoaHMZ1N8g+s/1h0axFDwRkMKxP00M2n20W5I1v3BLXhvkK40fvr90IyyMjgp3xqKxQeg/X5kpgd70KmBsGPomBHtAazcHtTr85NkfdTR5Cv8LTcVoOAEIAMPv45QB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QElGUt9o; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733254378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+p5reWVqLjy4I/TWVxsMBx1YnEZvRo6ajPef4GWCnXg=;
	b=QElGUt9oWvjr2JFV8BMnxyp9iwlv3abSzu4xFpAnZQdtjXFNPPCb0cyKsp7QmEhCfTqv9q
	gShA/lU1ZvGgOYeqHVn2dB+iuD1UMScdKkcG2pBCLkPvhq3AK5cWTiUioBYv8uTabJJ5/S
	WFC3GVt6qyXEadoxlHRJ54olb0cpii8=
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
Subject: [RFC PATCH 02/14] drivers/perf: apple_m1: Support host/guest event filtering
Date: Tue,  3 Dec 2024 11:32:08 -0800
Message-Id: <20241203193220.1070811-3-oliver.upton@linux.dev>
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

The PMU appears to have a separate register for filtering 'guest'
exception levels (i.e. EL1 and !ELIsInHost(EL0)) which has the same
layout as PMCR1_EL1. Conveniently, there exists a VHE register alias
(PMCR1_EL12) that can be used to configure it.

Support guest events by programming the EL12 register with the intended
guest kernel/userspace filters. Limit support for guest events to VHE
(i.e. kernel running at EL2), as it avoids involving KVM to context
switch PMU registers. VHE is the only supported mode on M* parts anyway,
so this isn't an actual feature limitation.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 drivers/perf/apple_m1_cpu_pmu.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index ecc71f6808dd..2a34523500f8 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -120,6 +120,8 @@ enum m1_pmu_events {
 	 */
 	M1_PMU_CFG_COUNT_USER					= BIT(8),
 	M1_PMU_CFG_COUNT_KERNEL					= BIT(9),
+	M1_PMU_CFG_COUNT_HOST					= BIT(10),
+	M1_PMU_CFG_COUNT_GUEST					= BIT(11),
 };
 
 /*
@@ -326,7 +328,7 @@ static void m1_pmu_disable_counter_interrupt(unsigned int index)
 }
 
 static void __m1_pmu_configure_event_filter(unsigned int index, bool user,
-					    bool kernel)
+					    bool kernel, bool host)
 {
 	u64 clear, set, user_bit, kernel_bit;
 
@@ -354,7 +356,10 @@ static void __m1_pmu_configure_event_filter(unsigned int index, bool user,
 	else
 		clear |= kernel_bit;
 
-	sysreg_clear_set_s(SYS_IMP_APL_PMCR1_EL1, clear, set);
+	if (host)
+		sysreg_clear_set_s(SYS_IMP_APL_PMCR1_EL1, clear, set);
+	else if (is_kernel_in_hyp_mode())
+		sysreg_clear_set_s(SYS_IMP_APL_PMCR1_EL12, clear, set);
 }
 
 static void __m1_pmu_configure_eventsel(unsigned int index, u8 event)
@@ -389,10 +394,13 @@ static void __m1_pmu_configure_eventsel(unsigned int index, u8 event)
 static void m1_pmu_configure_counter(unsigned int index, unsigned long config_base)
 {
 	bool kernel = config_base & M1_PMU_CFG_COUNT_KERNEL;
+	bool guest = config_base & M1_PMU_CFG_COUNT_GUEST;
+	bool host = config_base & M1_PMU_CFG_COUNT_HOST;
 	bool user = config_base & M1_PMU_CFG_COUNT_USER;
 	u8 evt = config_base & M1_PMU_CFG_EVENT;
 
-	__m1_pmu_configure_event_filter(index, user, kernel);
+	__m1_pmu_configure_event_filter(index, user && host, kernel && host, true);
+	__m1_pmu_configure_event_filter(index, user && guest, kernel && guest, false);
 	__m1_pmu_configure_eventsel(index, evt);
 }
 
@@ -568,7 +576,7 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 {
 	unsigned long config_base = 0;
 
-	if (!attr->exclude_guest) {
+	if (!attr->exclude_guest && !is_kernel_in_hyp_mode()) {
 		pr_debug("ARM performance counters do not support mode exclusion\n");
 		return -EOPNOTSUPP;
 	}
@@ -576,6 +584,10 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 		config_base |= M1_PMU_CFG_COUNT_KERNEL;
 	if (!attr->exclude_user)
 		config_base |= M1_PMU_CFG_COUNT_USER;
+	if (!attr->exclude_host)
+		config_base |= M1_PMU_CFG_COUNT_HOST;
+	if (!attr->exclude_guest)
+		config_base |= M1_PMU_CFG_COUNT_GUEST;
 
 	event->config_base = config_base;
 
-- 
2.39.5


