Return-Path: <linux-kernel+bounces-298060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1295C14B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 01:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E59285A41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB11D1F75;
	Thu, 22 Aug 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox6GbPUi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70F1CFEB3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724368098; cv=none; b=upt6XgL/OarqgcHhWFxRNbtbtI3Kjp0PHL0JYPjtvNtIu4itU+ITWyDVJk8lJILpg6Q4ZKoCrJEm+putDv50gw+o1kgX2lOEQW+Dj01LiHWLHrQylnQpIaIxIm6Cdb1HqJvkt96KpLEwTywKGs9KIl8YFFgawZx2oc0hpctkBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724368098; c=relaxed/simple;
	bh=YWAhTioaJFqNJ1RDnh98a3P0t0DemEj3xHyuR0IkfgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NP3bGip7JR5c+iU6COtjgrpvI7pw/zNyxO3oROwPpF2gegCmSVqO7CmVZAp3t/jVqtRPgYYL83ltx6V4eLOqo8zBl1r3xfFmaSuhN561hZ08b9l4f7THjn6crvcNz8eVvJnDBR4z5gHbhDuaGRLSXJUO/kfdK9W+O/fvUb6oNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox6GbPUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE13C32782;
	Thu, 22 Aug 2024 23:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724368097;
	bh=YWAhTioaJFqNJ1RDnh98a3P0t0DemEj3xHyuR0IkfgA=;
	h=From:To:Cc:Subject:Date:From;
	b=ox6GbPUiFSAStedBi/bBVwIzG5GmCDPLv8nbPqhfaZHaE6ZZRA7OfvE7/eSUJkEUu
	 6u0tGJiZ2rAdZX+BkUZHbLHlWrJugxgrW6Fizsygz6yqUPhJGV9DE7aCVoZinoZWzm
	 bf3VrOy/L4T79U2jKtvP6bbIGXgh7DSyo8b/T3GXrCOjU+V5n5kQkjAHNupCQ6QK01
	 qpyKlVEGfmaIUXNEOz0h8dFgmhOoRYJxI3zZWwBE3h7zxncGelpcrkL3YxluVHTOgY
	 dBlp+XbdmGmchTwoTfsTo5LyjEhT9gEXOEl+HIjZtSrNHuUrY4ES4YPptVdKtHA9n+
	 vIit+NrYBU2bg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>
Subject: [RFC/PATCH] perf/x86: Relax privilege filter restriction on AMD IBS
Date: Thu, 22 Aug 2024 16:08:16 -0700
Message-ID: <20240822230816.564262-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
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

This should be done in the hardware, but until we get the fix we may
allow exclude_{kernel,user} in the attribute and silently drop the
samples in the PMU IRQ handler.  It won't guarantee the sampling
frequency or even it'd miss some with fixed period too.  Not ideal,
but that'd still be helpful to regular users.

I also think that it should be able to inform the number of dropped
samples to userspace so I've increased the lost_samples count.  This
can be read with the PERF_FORMAT_LOST (perf tools set it by default)
so I didn't emit the PERF_RECORD_LOST_SAMPLES for this.

I'm not sure if it's acceptable since it might be confusing to figure
out whether it's because of a lack of the ring buffer or it's dropped
due to privileges.  Or we can add a new record format for this.  Let me
know if you have a better idea.

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/ibs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e91970b01d62..6f514072c440 100644
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
@@ -1062,6 +1065,13 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	if (!perf_ibs_set_period(perf_ibs, hwc, &period))
 		goto out;	/* no sw counter overflow */
 
+	if ((event->attr.exclude_kernel && !user_mode(iregs)) ||
+	    (event->attr.exclude_user && user_mode(iregs))) {
+		throttle = perf_event_account_interrupt(event);
+		atomic64_inc(&event->lost_samples);
+		goto out;
+	}
+
 	ibs_data.caps = ibs_caps;
 	size = 1;
 	offset = 1;
-- 
2.46.0.295.g3b9ea8a38a-goog


