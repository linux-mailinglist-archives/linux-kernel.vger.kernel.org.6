Return-Path: <linux-kernel+bounces-275442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C369485C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B017A1C21388
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A081155307;
	Mon,  5 Aug 2024 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSBjRWs7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C77136330
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722899450; cv=none; b=ZfEh1eJo2fhNQUc4Ao8e8YFw3rsTvUANTZOViCjyjFn/+o7l7yfs3WpaGpCzPcFCvH7pciadcEj9SOX8pWvx7eD6ixeGVUluuwxhEeeQAWRpjwuJMKFPdWQvvSEhcyx537duy1m80hZEfNHq+hYGLc/5EdL9ZzmAyCyoK2WtaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722899450; c=relaxed/simple;
	bh=w+YoyK6tQEJx47LsRhAERsC5VpbsZTPFVTUYp6sl1s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3Ou7B7mEdb/3coWgvd1eT1VL9MrnELx+ROxNR0N90Ciha70yrfaYmZQbbAwsnet60QtEQeUPXHvMniN3KxLteGJzS3W0ZnnzGkP5rA76YgoSdRwCP4v+XBJKQJrOWWH/thUm9HpokGFLGQyM2iyCsG57vcNF3e0a7Z4UMwumQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSBjRWs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DDFC32782;
	Mon,  5 Aug 2024 23:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722899449;
	bh=w+YoyK6tQEJx47LsRhAERsC5VpbsZTPFVTUYp6sl1s8=;
	h=From:To:Cc:Subject:Date:From;
	b=mSBjRWs77QgzSwZtiVpVKborn7qgPX77d3bb79RlqO0ChMuIQyMFcVMAc2TCU93xA
	 2YzUR6vyfIuIp8tfjAVHE5PkBY6kc5tMJkEEBW2A1fwsNnR67ynXtJvVwZSiSAQ/yh
	 TYVePumC1aGvBYcs4zQk6UagScZX7FQCYs5WvmO6CNrVdlthRlCbYL2r9/WR0z7cEd
	 VQismq0A0PrSYJdGhWtYuTCTy0IO97n27ALFKHtLL8XQhcXM78PsFY0vUY7PXG2vKe
	 svzM0mjLhZJ7FduGhREVBbskwW08U74rb+p8YG1BSiUJIDsFugakQRnHW7UK84130R
	 mKKQgXvX0fgMA==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Song Liu <song@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] Revert "perf: Add a counter for number of user access events in context"
Date: Mon,  5 Aug 2024 16:10:31 -0700
Message-ID: <20240805231031.1760371-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 82ff0c022d19c2ad69a472692bb7ee01ac07a40b.

perf_event->nr_user is not used any more. Remove it.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/perf_event.h | 1 -
 kernel/events/core.c       | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..509ae4770bbe 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -931,7 +931,6 @@ struct perf_event_context {
 	struct list_head		event_list;
 
 	int				nr_events;
-	int				nr_user;
 	int				is_active;
 
 	int				nr_task_data;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..6f44755ae907 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1793,8 +1793,6 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 
 	list_add_rcu(&event->event_entry, &ctx->event_list);
 	ctx->nr_events++;
-	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
-		ctx->nr_user++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
 
@@ -2017,8 +2015,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	event->attach_state &= ~PERF_ATTACH_CONTEXT;
 
 	ctx->nr_events--;
-	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
-		ctx->nr_user--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
 
-- 
2.43.5


