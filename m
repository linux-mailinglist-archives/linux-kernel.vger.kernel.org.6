Return-Path: <linux-kernel+bounces-563402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ECCA64110
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28FF07A2AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED621506D;
	Mon, 17 Mar 2025 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WurO6fta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BB1E1DE9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192266; cv=none; b=j5Jnad0ZP/5p/f3lJwX37qZ37EbNVDQntShc/Uk++OmTAQYdF1k01ugqDjhDqZPbwre7K1yu7gRvMsKrX98mwnsX2TI4PFl7+7m+KScoUemBnspd5jZATX1msgVPk/Crie7UbjO3ziN/M8lS0wMB1zPB7cbI57CdTX6KgXFdCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192266; c=relaxed/simple;
	bh=oqZd/1SCKhzq7njLemTg/dgWTpsIxROK6yuWtABDV+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfIPtdhPzgccrknigy+pC8beFr3CMhWXfcf1UvZ957qCXzPLd/m928J7YaK4nh7yJYihXnbrXwpy3ajuG0fb4k/w0K44/gmnQVuxSrpXIm7WpZOZrbmadHliR3aJs3ZyixUfrYMA3Ovw+YJr+mOXH5P7H38EJykp9YrH7GNdAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WurO6fta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CC5C4CEE3;
	Mon, 17 Mar 2025 06:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742192266;
	bh=oqZd/1SCKhzq7njLemTg/dgWTpsIxROK6yuWtABDV+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=WurO6ftahzDi64z+rpgtefHhWN/w1yXVqEPdbjpsBlmvD3NGpFOixKD6k4AxztgXV
	 rACqjAEgzA66miin9UDrIFuVQrJGpvj5VhgmTMnlnUdLMprWCHUDLl0Qx39qm+bVsv
	 8SVd4VaBp/EqgYXpEVMEFfaAvv/rdHwMJBYk2dBHmeBkLuCIKQ2+kRyrWmZpFeuS2m
	 6nMHVVn9vKu4M0x7oqEu5xqFrKpA+g3ac1WVQfRakSH0IVjcS/erFcYGbZ7HfV2UKA
	 6in8kSLUVsqa/yPHnc0imNMRmbrZkarvWXk5gUTFvWpPGog1lqE+KalQ7D7+Cdjy38
	 Gn0LHwblf2dkA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC/PATCH] perf/core: Use POLLHUP for a pinned event in error
Date: Sun, 16 Mar 2025 23:17:45 -0700
Message-ID: <20250317061745.1777584-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pinned events can go to an error state when they are failed to be
scheduled in the context.  And they won't generate samples anymore
and silently ignored until it's recovered by PERF_EVENT_IOC_ENABLE or
something (and of course the condition also should be changed so that
they can be scheduled in).  But then users should know about the state
change.

Currently there's no mechanism to notify users when they go to an error
state.

One way to do this is to issue POLLHUP event to poll(2) to handle this.
Reading events in an error state would return 0 (EOF) and it matches to
the behavior of POLLHUP according to the man page.

Users should remove the fd of the event from pollfd after getting
POLLHUP, otherwise it'll be returned repeatedly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2533fc32d890eacd..cef1f5c60f642d21 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3984,6 +3984,11 @@ static int merge_sched_in(struct perf_event *event, void *data)
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+
+			if (*perf_event_fasync(event))
+				event->pending_kill = POLL_HUP;
+
+			perf_event_wakeup(event);
 		} else {
 			struct perf_cpu_pmu_context *cpc = this_cpc(event->pmu_ctx->pmu);
 
@@ -5925,6 +5930,10 @@ static __poll_t perf_poll(struct file *file, poll_table *wait)
 	if (is_event_hup(event))
 		return events;
 
+	if (unlikely(READ_ONCE(event->state) == PERF_EVENT_STATE_ERROR &&
+		     event->attr.pinned))
+		return events;
+
 	/*
 	 * Pin the event->rb by taking event->mmap_mutex; otherwise
 	 * perf_event_set_output() can swizzle our rb and make us miss wakeups.
-- 
2.49.0.rc1.451.g8f38331e32-goog


