Return-Path: <linux-kernel+bounces-571084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E052A6B8E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB045178DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC3219312;
	Fri, 21 Mar 2025 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRcuI1eN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0FE1F4C9B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553590; cv=none; b=Lo+viiqeLS/SUiK9KVkVE2Tud9npS3x4/LSNmJb+dbpn4fx4bASllLUrSbpZShh7EDiqibkbHn9E0UCBa0hfTEAxu59zgV2Hr635xYW0a4TZTOAMJ1h+ZTSCjimBKytCc46a25H3gEAjLT6lHAAPbY2XGTSGyhiDus/scB4j4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553590; c=relaxed/simple;
	bh=rJKPzBCxHUvrDxIvnIJVKdVnHq7cIfbeWhNKnlRSV64=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GdPsMXY9SHsgbydx95gHArCKj2BA9L8Wr6V1DbNuwIb5pyT+N98bDS9eg+0RzfbZb5Dp4nHPgLRWK6BP8NUBzWopCsWsIS6+6sTnm04N+jcU9nW4g8RL0BIwsT1PnMI79I2gbEKllTtXu1hX0rwhABdfCaIp14g7Irc+BZOSJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRcuI1eN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DA8C4CEE3;
	Fri, 21 Mar 2025 10:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742553589;
	bh=rJKPzBCxHUvrDxIvnIJVKdVnHq7cIfbeWhNKnlRSV64=;
	h=Date:From:To:Cc:Subject:From;
	b=DRcuI1eNNtkKC5BHCXFI2GiZ8QU7bXFgD638XnMTafelwJ0AJ/BTmFEfydzTXitOG
	 u1i8F0BrmF5EAjU/RlBuPagMTYaVMOE4+HwI8m7GszjV8l8g0zdlRqa0c/hvvc7DuN
	 amrScJqNgCacfh5mPEFdiXiQxkTXfguAq2v0iAN1X7HSYV6SqferJ736DbcHjxwisT
	 1Cdkj9AhwwKrAhsUeJwFuK0inSTtCpPH99LVLCuWvA2TL4P3W9Je8hIqSTNdpI2Yyq
	 ixVPU9dpJdmi699yNhnGdRh4esNSHFlcKlSkSfDLVsw6ObUWAaIky1MzQBRWiE/CMg
	 2Xq29z+GDCy4A==
Date: Fri, 21 Mar 2025 11:39:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [GIT PULL] perf events fixes
Message-ID: <Z91B8ILV-cXRUULf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-03-21

   # HEAD: 7e512f5ad24458e2c930b5be5d96ddf9e176e05d perf/x86/rapl: Fix error handling in init_rapl_pmus()

Two fixes: an RAPL PMU driver error handling fix, and an AMD IBS software
filter fix.

Thanks,

	Ingo

------------------>
Dhananjay Ugwekar (1):
      perf/x86/rapl: Fix error handling in init_rapl_pmus()

Namhyung Kim (1):
      perf/x86: Check data address for IBS software filter


 arch/x86/events/amd/ibs.c | 10 ++++++----
 arch/x86/events/rapl.c    |  7 ++++++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e7a8b8758e08..c46500592002 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1128,8 +1128,13 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
+	if (perf_ibs == &perf_ibs_op)
+		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
+
 	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    perf_exclude_event(event, &regs)) {
+	    (perf_exclude_event(event, &regs) ||
+	     ((data.sample_flags & PERF_SAMPLE_ADDR) &&
+	      event->attr.exclude_kernel && kernel_ip(data.addr)))) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
@@ -1144,9 +1149,6 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
-	if (perf_ibs == &perf_ibs_op)
-		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
-
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 6941f4811bec..043f0a0b1e00 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -730,6 +730,7 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
 {
 	int nr_rapl_pmu = topology_max_packages();
 	struct rapl_pmus *rapl_pmus;
+	int ret;
 
 	/*
 	 * rapl_pmu_scope must be either PKG, DIE or CORE
@@ -761,7 +762,11 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
-	return init_rapl_pmu(rapl_pmus);
+	ret = init_rapl_pmu(rapl_pmus);
+	if (ret)
+		kfree(rapl_pmus);
+
+	return ret;
 }
 
 static struct rapl_model model_snb = {

