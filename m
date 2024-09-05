Return-Path: <linux-kernel+bounces-316251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE22696CD12
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D287D1C224E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB76154423;
	Thu,  5 Sep 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1037pHC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B714C59A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505832; cv=none; b=gR3aBdK634QYVdetPHDXBqw8WPPubvmxXH22TpXJwSINSjQdtseSlZj7B+uaXjdlh9c2kLp904pkX37xF9avayszpQL+3xB5x+UmwJnIqHJwdsWr6NxCmUjupbaGfD9sKUCI83feqF9PkRRZ9PMCst9Usf4ojkBZq/GKjCCld4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505832; c=relaxed/simple;
	bh=SUt1t/dGXLRQIHmGDjBK/uiCU8X/cP41NUQ4Kg/f/FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuA359NRiHV1oaS2isgkodQqEO0CJ4u4heF6hAtVbnKaFDkypbS5wc24bsHUdaC6uKOxXrsU+h1k8ypLJUHy3zZr1gUeTzgL+XzPgr1OygpK6yaIw11oMftJ03oFSyBIYf9IsedR9DOmL7hmkbjjf7k2HcOuZhvAFo888RCCLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1037pHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16178C4AF0B;
	Thu,  5 Sep 2024 03:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725505831;
	bh=SUt1t/dGXLRQIHmGDjBK/uiCU8X/cP41NUQ4Kg/f/FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1037pHCXv+7d2VV/q7DmZGP2cxg/racl9AHhZ1OxiAQhAq81vFMBd+jheXvLFs8A
	 1eZMJHCfY6cPfTagFKEMhwoh3k+GmmMKhU+cDKMKhFaHnVTWgM0o6YqFGr+1LYJir3
	 mKx0CUz5CAdnShQESV6sxybqLWJZhQTQAMthNMqgL+pvYwND+2m/3AMG1XnkBo2t+n
	 fbMKARWmo4zczXpphDBksOiPOGgBnNbaqKsW558oR8+B9qzQUEb3cMBvNWujIVpFbZ
	 3qeSZf5aOsLg8cDbkuXGBeJOhO6jZCv1vthc5G6vEM66L6jaGvVI+eUkF+KVtLUS7U
	 KHAPRGbgKSPmA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 5/5] perf/x86: Relax privilege filter restriction on AMD IBS
Date: Wed,  4 Sep 2024 20:10:27 -0700
Message-ID: <20240905031027.2567913-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905031027.2567913-1-namhyung@kernel.org>
References: <20240905031027.2567913-1-namhyung@kernel.org>
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
allow exclude_{kernel,user} in the attribute and silently drop the
samples in the PMU IRQ handler.  It won't guarantee the sampling
frequency or even it'd miss some with fixed period too.  Not ideal,
but that'd still be helpful to regular users.

To minimize the confusion, let's add 'swfilt' bit to attr.config2 which
is exposed in the sysfs format directory so that users can figure out
if the kernel support the privilege filters by software.

  $ perf record -e ibs_op/swfilt=1/uh true

This uses perf_exclude_event() which checks regs->cs.  But it should be
fine because set_linear_ip() also updates the CS according to the RIP
provided by IBS.

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ananth Narayan <ananth.narayan@amd.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/ibs.c | 50 ++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e91970b01d6243e4..7fea9527971a7aae 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -31,6 +31,8 @@ static u32 ibs_caps;
 #define IBS_FETCH_CONFIG_MASK	(IBS_FETCH_RAND_EN | IBS_FETCH_MAX_CNT)
 #define IBS_OP_CONFIG_MASK	IBS_OP_MAX_CNT
 
+/* attr.config2 */
+#define IBS_SW_FILTER_MASK	1
 
 /*
  * IBS states:
@@ -290,6 +292,15 @@ static int perf_ibs_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	/* handle exclude_{user,kernel} in the IRQ handler */
+	if (event->attr.exclude_hv || event->attr.exclude_idle ||
+	    event->attr.exclude_host || event->attr.exclude_guest)
+		return -EINVAL;
+
+	if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
+	    (event->attr.exclude_kernel || event->attr.exclude_user))
+		return -EINVAL;
+
 	ret = validate_group(event);
 	if (ret)
 		return ret;
@@ -550,24 +561,14 @@ static struct attribute *attrs_empty[] = {
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
@@ -583,6 +584,11 @@ static struct attribute *rand_en_attrs[] = {
 	NULL,
 };
 
+static struct attribute *swfilt_attrs[] = {
+	&format_attr_swfilt.attr,
+	NULL,
+};
+
 static struct attribute *fetch_l3missonly_attrs[] = {
 	&fetch_l3missonly.attr.attr,
 	NULL,
@@ -598,6 +604,11 @@ static struct attribute_group group_rand_en = {
 	.attrs = rand_en_attrs,
 };
 
+static struct attribute_group group_swfilt = {
+	.name = "format",
+	.attrs = swfilt_attrs,
+};
+
 static struct attribute_group group_fetch_l3missonly = {
 	.name = "format",
 	.attrs = fetch_l3missonly_attrs,
@@ -612,6 +623,7 @@ static struct attribute_group group_zen4_ibs_extensions = {
 
 static const struct attribute_group *fetch_attr_groups[] = {
 	&group_rand_en,
+	&group_swfilt,
 	&empty_caps_group,
 	NULL,
 };
@@ -650,6 +662,12 @@ static struct attribute_group group_op_l3missonly = {
 	.is_visible = zen4_ibs_extensions_is_visible,
 };
 
+static const struct attribute_group *op_attr_groups[] = {
+	&group_swfilt,
+	&empty_caps_group,
+	NULL,
+};
+
 static const struct attribute_group *op_attr_update[] = {
 	&group_cnt_ctl,
 	&group_op_l3missonly,
@@ -667,7 +685,6 @@ static struct perf_ibs perf_ibs_fetch = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.config_mask		= IBS_FETCH_CONFIG_MASK,
@@ -691,7 +708,6 @@ static struct perf_ibs perf_ibs_op = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_CONFIG_MASK,
@@ -1111,6 +1127,12 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
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
@@ -1228,7 +1250,7 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
 
-	perf_ibs_op.pmu.attr_groups = empty_attr_groups;
+	perf_ibs_op.pmu.attr_groups = op_attr_groups;
 	perf_ibs_op.pmu.attr_update = op_attr_update;
 
 	return perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
-- 
2.46.0.469.g59c65b2a67-goog


