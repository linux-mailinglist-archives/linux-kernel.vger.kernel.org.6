Return-Path: <linux-kernel+bounces-392078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFE19B8F67
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA631F21695
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020021AB6C1;
	Fri,  1 Nov 2024 10:36:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD221AA781
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457370; cv=none; b=h1NhzxCjZrzoy9QGF+w5r6qhkMy+cFeOwQfthQahUozu/P1fuPun8b12JJGFUEYVeseSOjpKk4xxTvwA17wRcaQL3IGfuYDNL44JXyMr7rdMj0Pi7Lsr0UR+CVfVheJUwP4NdWrPehTQsQHqxdZ+hR2sstqoAR0mABYyP8SR5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457370; c=relaxed/simple;
	bh=vAHb8kUiQkoZ4OsNQ/q+0l4qiZnMCMPsG95aghsEG60=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FDv8AJRc/ZpAbU3J95LDiksUEo5TXoOGQx1tknVzjCqXJ00A2/geMQcoRy/CA/9eOrHSnuVrhkfl6G2N1wXqW3f0Wj8jGNVK3l0U5largrcN4iDNiKzXsvCviNAKaZlrycGG3e/KBX6faYb+vDrTRsekQt39kPghtBUePgQZJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F53BC4CED1;
	Fri,  1 Nov 2024 10:36:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1g-00000005S9X-3063;
	Fri, 01 Nov 2024 06:37:08 -0400
Message-ID: <20241101103708.577077710@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [for-next][PATCH 11/11] tracing: Replace strncpy() with strscpy() when copying comm
References: <20241101103647.011707614@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Jinjie Ruan <ruanjinjie@huawei.com>

Replace the depreciated[1] strncpy() calls with strscpy()
when copying comm.

Link: https://github.com/KSPP/linux/issues/90 [1]

Cc: <mhiramat@kernel.org>
Cc: <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241031120139.1343025-1-ruanjinjie@huawei.com
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c              | 2 +-
 kernel/trace/trace_events_hist.c  | 4 ++--
 kernel/trace/trace_sched_switch.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f1d613d924e9..a587fd7d7447 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1921,7 +1921,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	max_data->critical_start = data->critical_start;
 	max_data->critical_end = data->critical_end;
 
-	strncpy(max_data->comm, tsk->comm, TASK_COMM_LEN);
+	strscpy(max_data->comm, tsk->comm);
 	max_data->pid = tsk->pid;
 	/*
 	 * If tsk == current, then use current_uid(), as that does not use
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index cc2924ad32a3..c288b92fc4df 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1599,7 +1599,7 @@ static inline void save_comm(char *comm, struct task_struct *task)
 		return;
 	}
 
-	strncpy(comm, task->comm, TASK_COMM_LEN);
+	strscpy(comm, task->comm, TASK_COMM_LEN);
 }
 
 static void hist_elt_data_free(struct hist_elt_data *elt_data)
@@ -3405,7 +3405,7 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 	elt_data = context->elt->private_data;
 	track_elt_data = track_data->elt.private_data;
 	if (elt_data->comm)
-		strncpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
+		strscpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
 
 	track_data->updated = true;
 
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 8a407adb0e1c..573b5d8e8a28 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -187,7 +187,7 @@ static inline char *get_saved_cmdlines(int idx)
 
 static inline void set_cmdline(int idx, const char *cmdline)
 {
-	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
+	strscpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
 }
 
 static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
-- 
2.45.2



