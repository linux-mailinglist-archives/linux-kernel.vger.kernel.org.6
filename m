Return-Path: <linux-kernel+bounces-429983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28859E2A44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B20A163C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CBB1FDE19;
	Tue,  3 Dec 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf4eo4NW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15C1FCCE0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249084; cv=none; b=d3fTpRUyJihnlRSwjqgHVvXxqEbXpuZW9UvcNuzok7atnMsRKyLG6PNka91zKGFBFG7Oq6kGzq7RWSVxMEcOZcx1n7N4pnTzdvjjPL9zWXFvj8zAeafOBAIOQWbuZ9AfcDq4njU78Yrry8mgrETNVUJ2R158QS+fF+Q6S0nQlQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249084; c=relaxed/simple;
	bh=MJL6Rpf8HXh905YWUKftcAg0oe2cq+CM22XVsVFxVOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYrkcsf4I3iPxEzI4yIyg5keADjO0HrsSFCOFEU250Aft8sJRL/G5O3Zd1baPec8pDOAzAdia5nXI2pz9bz95TWt+zwEVYy5N9Llo1npoub3qqdsk3bY4nVMK/PM8DEpgm+5VBmtQpVFvcZy+H2bLTe7OMcx5ViyACr7l7ru8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf4eo4NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7625AC4CED9;
	Tue,  3 Dec 2024 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249083;
	bh=MJL6Rpf8HXh905YWUKftcAg0oe2cq+CM22XVsVFxVOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cf4eo4NWh4rOlMTL6cjD6gVW+GU5jFYT+pkmMKrc8HfKnTAWZKN0/L6KlOC7NaN95
	 UbV+UCS6FxZBpmfKRuzWsK3TxFZOXtmahcGlwdetcvElwdEXteP3GpkiF2l/Ix5pHB
	 gDdIEY+GkfoxyJY1Ffj/724Dnpso0iHdeTAKeUO65z5GIMbPXUaBBlNQfzLcd6YNC9
	 NQFjHjq7E2ufS6ScGAChO/vmBh7JZrkWXXzT4W/z2V4D0OPzyO+jOhjFjQs58k3Oe3
	 VNKQLf6wBOIr9MgxpBDsozx3Uy3UyGbsrbTfyQpfWKDgV4NMRPvSA+MWrXj8g7c0f6
	 AHjkmmFezSCLA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/2] perf/x86: Relax privilege filter restriction on AMD IBS
Date: Tue,  3 Dec 2024 10:04:41 -0800
Message-ID: <20241203180441.1634709-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241203180441.1634709-1-namhyung@kernel.org>
References: <20241203180441.1634709-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While IBS is available for per-thread profiling, still regular users
cannot open an event due to the default paranoid setting (2) which
doesn't allow unprivileged users to get kernel samples.  That means
it needs to set exclude_kernel bit in the attribute but IBS driver
would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
we want and I've been getting requests to fix this issue.

This should be done in the hardware, but until we get the HW fix we may
allow exclude_{kernel,user,hv} in the attribute and silently drop the
samples in the PMU IRQ handler.  It won't guarantee the sampling
frequency or even it'd miss some with fixed period too.  Not ideal,
but that'd still be helpful to regular users.

To minimize the confusion, let's add 'swfilt' bit to attr.config2 which
is exposed in the sysfs format directory so that users can figure out
if the kernel support the privilege filters by software.

  $ perf record -e ibs_op/swfilt=1/u true

This uses perf_exclude_event() which checks regs->cs.  But it should be
fine because set_linear_ip() also updates the CS according to the RIP
provided by IBS.

Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ananth Narayan <ananth.narayan@amd.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/ibs.c | 59 +++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index f02939655b2ac819..e7a8b8758e088f61 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -31,6 +31,8 @@ static u32 ibs_caps;
 #define IBS_FETCH_CONFIG_MASK	(IBS_FETCH_RAND_EN | IBS_FETCH_MAX_CNT)
 #define IBS_OP_CONFIG_MASK	IBS_OP_MAX_CNT
 
+/* attr.config2 */
+#define IBS_SW_FILTER_MASK	1
 
 /*
  * IBS states:
@@ -290,6 +292,16 @@ static int perf_ibs_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	/* handle exclude_{user,kernel} in the IRQ handler */
+	if (event->attr.exclude_host || event->attr.exclude_guest ||
+	    event->attr.exclude_idle)
+		return -EINVAL;
+
+	if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
+	    (event->attr.exclude_kernel || event->attr.exclude_user ||
+	     event->attr.exclude_hv))
+		return -EINVAL;
+
 	ret = validate_group(event);
 	if (ret)
 		return ret;
@@ -550,24 +562,14 @@ static struct attribute *attrs_empty[] = {
 	NULL,
 };
 
-static struct attribute_group empty_format_group = {
-	.name = "format",
-	.attrs = attrs_empty,
-};
-
 static struct attribute_group empty_caps_group = {
 	.name = "caps",
 	.attrs = attrs_empty,
 };
 
-static const struct attribute_group *empty_attr_groups[] = {
-	&empty_format_group,
-	&empty_caps_group,
-	NULL,
-};
-
 PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
+PMU_FORMAT_ATTR(swfilt,		"config2:0");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
 PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
@@ -578,8 +580,9 @@ zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr, int
 	return ibs_caps & IBS_CAPS_ZEN4 ? attr->mode : 0;
 }
 
-static struct attribute *rand_en_attrs[] = {
+static struct attribute *fetch_attrs[] = {
 	&format_attr_rand_en.attr,
+	&format_attr_swfilt.attr,
 	NULL,
 };
 
@@ -593,9 +596,9 @@ static struct attribute *zen4_ibs_extensions_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group group_rand_en = {
+static struct attribute_group group_fetch_formats = {
 	.name = "format",
-	.attrs = rand_en_attrs,
+	.attrs = fetch_attrs,
 };
 
 static struct attribute_group group_fetch_l3missonly = {
@@ -611,7 +614,7 @@ static struct attribute_group group_zen4_ibs_extensions = {
 };
 
 static const struct attribute_group *fetch_attr_groups[] = {
-	&group_rand_en,
+	&group_fetch_formats,
 	&empty_caps_group,
 	NULL,
 };
@@ -628,6 +631,11 @@ cnt_ctl_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return ibs_caps & IBS_CAPS_OPCNT ? attr->mode : 0;
 }
 
+static struct attribute *op_attrs[] = {
+	&format_attr_swfilt.attr,
+	NULL,
+};
+
 static struct attribute *cnt_ctl_attrs[] = {
 	&format_attr_cnt_ctl.attr,
 	NULL,
@@ -638,6 +646,11 @@ static struct attribute *op_l3missonly_attrs[] = {
 	NULL,
 };
 
+static struct attribute_group group_op_formats = {
+	.name = "format",
+	.attrs = op_attrs,
+};
+
 static struct attribute_group group_cnt_ctl = {
 	.name = "format",
 	.attrs = cnt_ctl_attrs,
@@ -650,6 +663,12 @@ static struct attribute_group group_op_l3missonly = {
 	.is_visible = zen4_ibs_extensions_is_visible,
 };
 
+static const struct attribute_group *op_attr_groups[] = {
+	&group_op_formats,
+	&empty_caps_group,
+	NULL,
+};
+
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
 	&group_op_l3missonly,
@@ -667,7 +686,6 @@ static struct perf_ibs perf_ibs_fetch = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.config_mask		= IBS_FETCH_CONFIG_MASK,
@@ -691,7 +709,6 @@ static struct perf_ibs perf_ibs_op = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_CONFIG_MASK,
@@ -1111,6 +1128,12 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
+	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
+	    perf_exclude_event(event, &regs)) {
+		throttle = perf_event_account_interrupt(event);
+		goto out;
+	}
+
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw = (struct perf_raw_record){
 			.frag = {
@@ -1227,7 +1250,7 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
 
-	perf_ibs_op.pmu.attr_groups = empty_attr_groups;
+	perf_ibs_op.pmu.attr_groups = op_attr_groups;
 	perf_ibs_op.pmu.attr_update = op_attr_update;
 
 	return perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
-- 
2.47.0.338.g60cca15819-goog


