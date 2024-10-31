Return-Path: <linux-kernel+bounces-390400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077A59B7961
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FA01C21B21
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EDF199FD7;
	Thu, 31 Oct 2024 11:10:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C245025
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373046; cv=none; b=cBxSlWLmkg7H1Rb6uO9XtvjBS2KpXwpJ5RShN1f3VCDT2MOR6MXPGFmtNfTxUXI8Y5v7+tdnzCcUUIky8Tr++Yd2OMg9UQqtCi6zS4Rx770xRxUdPEUgXvw7L8+ZYK0/fNouhJUNFXdo4dUcEk7EOICOwdwe0/AQI9Y/xLnrQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373046; c=relaxed/simple;
	bh=XZzGtkf3McRL58mysGvwnqs0kCojwsn8JcfOx/U9qmc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VNBpf2QIkH4Tv7A1vKIN3H2YPX3IX60pgHUXcxGqXDJdA7+pm6SR78KbR5hAgVFMyKw9HRSIqhzY5tNEGnmkvXHUIHhTq6k1R42dE51qQJfboT4HBodJgtfjKlvk+sbTu7WqJ+5BMJB5aMAizgLrOYGsIMc3/TDiYwNJ/rFx2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2D6C4AF1D;
	Thu, 31 Oct 2024 11:10:44 +0000 (UTC)
Date: Thu, 31 Oct 2024 07:10:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH] ftrace: Show timings of how long nop patching
 took
Message-ID: <20241031071039.0921d692@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace/for-next

Head SHA1: 36a367b8912a3aac023d9e35c815f7b1e609f4a3


Steven Rostedt (1):
      ftrace: Show timings of how long nop patching took

----
 kernel/trace/ftrace.c | 11 ++++++++---
 kernel/trace/trace.c  | 15 +++++++++++----
 kernel/trace/trace.h  |  2 ++
 3 files changed, 21 insertions(+), 7 deletions(-)
---------------------------
commit 36a367b8912a3aac023d9e35c815f7b1e609f4a3
Author: Steven Rostedt <rostedt@goodmis.org>
Date:   Thu Oct 17 11:31:05 2024 -0400

    ftrace: Show timings of how long nop patching took
    
    Since the beginning of ftrace, the code that did the patching had its
    timings saved on how long it took to complete. But this information was
    never exposed. It was used for debugging and exposing it was always
    something that was on the TODO list. Now it's time to expose it. There's
    even a file that is where it should go!
    
    Also include how long patching modules took as a separate value.
    
     # cat /sys/kernel/tracing/dyn_ftrace_total_info
     57680 pages:231 groups: 9
     ftrace boot update time = 14024666 (ns)
     ftrace module total update time = 126070 (ns)
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: Mike Rapoport <rppt@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: https://lore.kernel.org/20241017113105.1edfa943@gandalf.local.home
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b4ef469f4fd2..71e53eaba8bc 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3686,7 +3686,8 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
 }
 
 
-static u64		ftrace_update_time;
+u64			ftrace_update_time;
+u64			ftrace_total_mod_time;
 unsigned long		ftrace_update_tot_cnt;
 unsigned long		ftrace_number_of_pages;
 unsigned long		ftrace_number_of_groups;
@@ -3706,7 +3707,7 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 	bool init_nop = ftrace_need_init_nop();
 	struct ftrace_page *pg;
 	struct dyn_ftrace *p;
-	u64 start, stop;
+	u64 start, stop, update_time;
 	unsigned long update_cnt = 0;
 	unsigned long rec_flags = 0;
 	int i;
@@ -3750,7 +3751,11 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 	}
 
 	stop = ftrace_now(raw_smp_processor_id());
-	ftrace_update_time = stop - start;
+	update_time = stop - start;
+	if (mod)
+		ftrace_total_mod_time += update_time;
+	else
+		ftrace_update_time = update_time;
 	ftrace_update_tot_cnt += update_cnt;
 
 	return 0;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c01375adc471..405dcf498159 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8548,15 +8548,22 @@ tracing_read_dyn_info(struct file *filp, char __user *ubuf,
 	char *buf;
 	int r;
 
-	/* 256 should be plenty to hold the amount needed */
-	buf = kmalloc(256, GFP_KERNEL);
+	/* 512 should be plenty to hold the amount needed */
+#define DYN_INFO_BUF_SIZE	512
+
+	buf = kmalloc(DYN_INFO_BUF_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	r = scnprintf(buf, 256, "%ld pages:%ld groups: %ld\n",
+	r = scnprintf(buf, DYN_INFO_BUF_SIZE,
+		      "%ld pages:%ld groups: %ld\n"
+		      "ftrace boot update time = %llu (ns)\n"
+		      "ftrace module total update time = %llu (ns)\n",
 		      ftrace_update_tot_cnt,
 		      ftrace_number_of_pages,
-		      ftrace_number_of_groups);
+		      ftrace_number_of_groups,
+		      ftrace_update_time,
+		      ftrace_total_mod_time);
 
 	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 	kfree(buf);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6adf48ef4312..3307dad4d917 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -775,6 +775,8 @@ extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
 extern unsigned long ftrace_update_tot_cnt;
 extern unsigned long ftrace_number_of_pages;
 extern unsigned long ftrace_number_of_groups;
+extern u64 ftrace_update_time;
+extern u64 ftrace_total_mod_time;
 void ftrace_init_trace_array(struct trace_array *tr);
 #else
 static inline void ftrace_init_trace_array(struct trace_array *tr) { }

