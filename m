Return-Path: <linux-kernel+bounces-309569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D20966CE6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8ADBB2300E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2919259A;
	Fri, 30 Aug 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM1U2eyX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F018FDDA
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060553; cv=none; b=JmGFXcGiCrOwcxaJQiBve70+CWJe1EvpQ2+AciiNYDqm+K1xukAWNUy7Qyv/PRodd0OGTYo57Gfzqo0rWF+040OqAIHN42JvSItDxhMYjsPG8QfXKgdjqOUVs9db6JPcJZd37kzjeuk50vov/U+U8NGQKCRUuJWGt1pAMW+3iBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060553; c=relaxed/simple;
	bh=FhSuLhCZLujOsL7ZD0FWBtHpkqfk0F0sycpI8h9gs4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf5WnkgOfOgDYu/SPQoWap2ngwlK8FAAklglBAlFtt6qZIn0F52y3ZRt8+kZSVDdWKzPt1X6IrYVg4TZhwwKi1ZbF2l52sb4iwUja61+6ZBiCLLds6BkiPYbbMadZqiaBQMQa/1GVRz15/jzXXi5rKlro5462eWBPbnjL4aRiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM1U2eyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F3FC4CEC6;
	Fri, 30 Aug 2024 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725060553;
	bh=FhSuLhCZLujOsL7ZD0FWBtHpkqfk0F0sycpI8h9gs4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZM1U2eyXBDhtfsvZiIjrBCu/u6XVvteZUBf8gyCpR55Im+KzkVUTg+yFv7s6sbPkj
	 /M3VbAxS0iV2COvXY+ZJBSICmyzDdDk+xir1sZyxZexDgUTU9Lpp0oLOvYK6l5bVO7
	 F4+iJOo1OKnwt/mdO2doHAg+gBITxygSHN6edtGRYx781nOEKQkQYInRLh6jiOQLKp
	 iVQEJGeMEcgsz0r6v8zsgdQW0M2iQIYSeL8lN0KxZBeVYYYjZm8DQLAwMsALSycRCK
	 JW3x0w0nPiM4E549qldThfskOri4HcB6Le0InPFz6K4edX6vamPHK4SNsco2C64Zuu
	 GgSH5x3lMIuaQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [RFC/PATCH 4/4] perf/x86: Relax privilege filter restriction on AMD IBS
Date: Fri, 30 Aug 2024 16:29:10 -0700
Message-ID: <20240830232910.1839548-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240830232910.1839548-1-namhyung@kernel.org>
References: <20240830232910.1839548-1-namhyung@kernel.org>
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

This uses perf_exclude_event() which checks regs->cs.  But it should be
fine because set_linear_ip() also updates the CS according to the RIP
provided by IBS.

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/ibs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e91970b01d62..e40e2255239a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -290,6 +290,11 @@ static int perf_ibs_init(struct perf_event *event)
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
 
+	/* handle exclude_{user,kernel} in the IRQ handler */
+	if (event->attr.exclude_hv || event->attr.exclude_idle ||
+	    event->attr.exclude_host || event->attr.exclude_guest)
+		return -EINVAL;
+
 	ret = validate_group(event);
 	if (ret)
 		return ret;
@@ -667,7 +672,6 @@ static struct perf_ibs perf_ibs_fetch = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.config_mask		= IBS_FETCH_CONFIG_MASK,
@@ -691,7 +695,6 @@ static struct perf_ibs perf_ibs_op = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
-		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_CONFIG_MASK,
@@ -1111,6 +1114,12 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
+	if (perf_exclude_event(event, &regs)) {
+		throttle = perf_event_account_interrupt(event);
+		atomic64_inc(&event->dropped_samples);
+		goto out;
+	}
+
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw = (struct perf_raw_record){
 			.frag = {
-- 
2.46.0.469.g59c65b2a67-goog


