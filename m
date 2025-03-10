Return-Path: <linux-kernel+bounces-553721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32800A58E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614AE168D24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3FC22332E;
	Mon, 10 Mar 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PADrfpdf"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1414A09E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595146; cv=none; b=i7C3ltchWKCSEjSKEtcvTbaP0/6VkATFOGTOm+c6QcEZTbraP3tAVw5KVe89/Qv9XtmQUXHLlttclR+ppf1G2zgvX++8WY+SFoPeGTDfMnP1G4b/HtLV8Hxn75QPBadBbiJWHQoL5Qvt0wOAuPF8k22pe47WYoQ/ZzhGRrsyn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595146; c=relaxed/simple;
	bh=v1hpRVLobjbgsf7s5Ty4V8yJxI3tNXbE/G2dV13Vyms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qteIEzcdTq7y2320uAgIUvdbej/lmryUng4sshu3SZQMISSoQ0IJwLjaRu5z59x5kANAmGLZdGRl/as76XW29jLz84Mu26y9Dk2tsWjpYswN8oJj6M9u98bkfgKwH0JpU2lhD2lOcl4geiunsoUwugz8a1E1db5Ylriad9TUiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PADrfpdf; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2feae794508so5797124a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741595143; x=1742199943; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6j0W1uMl8zTIDhkn41V1enJUyEizXs/L3VdEzVuvlkA=;
        b=PADrfpdfJhYll39x9N27KtOIvdPz1S1h2VM9RYEbY8tD67wVerVZG48cu360MEnH/l
         ofPCPRT1cqJA0gArKjUUPtqX6vzV6hmFidpHNQWYBWqKvNCum+oE8QNWtnRnU1qrPbuR
         1+bDS2wTrwK6nnOcZTCgFwHp4qq35R/qGsxo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595143; x=1742199943;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6j0W1uMl8zTIDhkn41V1enJUyEizXs/L3VdEzVuvlkA=;
        b=Q380azd5gmNyfWQMYQw/8pJRM/aTCCYzKdpEJZVeDrZz1DW4veap2/44vzJsHXE3jA
         rOqZJ9rgkjtMR6WijYqtoGtZ8K8tzOJxJqukNBomBPEeek9jPitdIeIAJcFPp6d3RjAm
         RpqjdBmrJZCpMdyO8suxfHYEQPLWM+lgunhMdcKMmcPS7rmHfQPzG9egkOUTtHHEaQ+p
         Q1AturdL/l+29xDU2oiH6+WTLzJR/Xb5cM5NKS962gL01PMxOY4CO/Xq2uS0u0ca4LK7
         2Iu+y8mBk3veLtCtjefCLtAsh/zxzzOg5L7wh/rgABsZWl+oAIwMD3gomRH4AKXGhcM6
         ohNw==
X-Forwarded-Encrypted: i=1; AJvYcCUBAJr2iQhWgTZg3diXs1CHl145FIlkbHVh5qQmQGa/k+2TR/aLpbXRNCmtHxoMjslb3JouSpYRFLx0V/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDhjQdZPzhj3ZuM6XvUHyuzE6T+y4CQ0ti647B6COx5kr0ibx5
	AV5IHNT2i+v6+bvLUrSmGMG4mcjQtRmCXdcnJI2ImoPh8vAEGglhB97ySgcUFA==
X-Gm-Gg: ASbGncvb9u1Mq4MKp3BSXCjg/9p9f96k7r2+kfIbjPlxVjFAm9ClnNPsixkmKKMoALv
	y6qLruCIUHd4+3oFYa3tGKgpb7fdB/sJOy9k3QQR4YHONXhhYFnG3Na5jj88iae8X4guhbKui/5
	IeSLvhzhDkwPI4LU8c6vdwTTkje1pToXb4GSS9cb1WjwsqN7X1eHIc6S02nn8VA9VSujYii5VAY
	rZ+gLMETHFr+ZxEXDjR1Ll0/oZ470dPDWLd1VbbnGUwyLpMHLx5tVXSRwpPaiAMQZYsRiUzx6AP
	EDfUKjuZlZOTgfNrhzjSettajVMVqlaQ9e0UGx3At5M/f1KA
X-Google-Smtp-Source: AGHT+IGLXJZOx4+vaPmp/dsJjffOCdx3UGx33BCjeH4NCp60R56pUuO7D5wBDhqxbyGE2mIYHu6bxw==
X-Received: by 2002:a17:90b:2d83:b0:2ee:e518:c1d8 with SMTP id 98e67ed59e1d1-2ff7cf22df2mr18354191a91.30.1741595143595;
        Mon, 10 Mar 2025 01:25:43 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d6c1:647d:8e28:bcf5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e789392sm9167281a91.28.2025.03.10.01.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:25:42 -0700 (PDT)
Date: Mon, 10 Mar 2025 17:25:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: [RFC] sched: add sched_show_task() variant that accepts log level
Message-ID: <miliiyxmqko6hx66yhdv4nkkopbm73wbz6kxxlzpts53mscqzy@dpfa6y3wnspv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

A request for comments, not a formal patch.

Is there any reason why hung-task watchdog prints error header
with KERN_ERR log level while task's backtrace is printed with
KERN_INFO?  Will it make sense to unify log levels and introduce
sched_show_task() variant that accept log level param so that
everything that hung-task watchdog prints becomes KERN_ERR?

Something like this:

---
 include/linux/sched/debug.h |  1 +
 kernel/hung_task.c          |  4 ++--
 kernel/sched/core.c         | 19 +++++++++++++------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
index b5035afa2396..8e46854d16fc 100644
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -34,6 +34,7 @@ extern void show_stack(struct task_struct *task, unsigned long *sp,
 		       const char *loglvl);
 
 extern void sched_show_task(struct task_struct *p);
+extern void sched_show_task_log_lvl(struct task_struct *p, const char *lvl);
 
 #ifdef CONFIG_SCHED_DEBUG
 struct seq_file;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index ccd7217fcec1..23dec32a05f3 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -119,7 +119,7 @@ static void debug_show_blocker(struct task_struct *task)
 		if ((unsigned long)t == owner) {
 			pr_err("INFO: task %s:%d is blocked on a mutex likely owned by task %s:%d.\n",
 				task->comm, task->pid, t->comm, t->pid);
-			sched_show_task(t);
+			sched_show_task_log_lvl(t, KERN_ERR);
 			return;
 		}
 	}
@@ -186,7 +186,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 			pr_err("      Blocked by coredump.\n");
 		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
 			" disables this message.\n");
-		sched_show_task(t);
+		sched_show_task_log_lvl(t, KERN_ERR);
 		debug_show_blocker(t);
 		hung_task_show_lock = true;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 00ea6f31973c..b6a5a41fbbfc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7687,7 +7687,7 @@ void __sched io_schedule(void)
 }
 EXPORT_SYMBOL(io_schedule);
 
-void sched_show_task(struct task_struct *p)
+void sched_show_task_log_lvl(struct task_struct *p, const char *lvl)
 {
 	unsigned long free;
 	int ppid;
@@ -7695,7 +7695,8 @@ void sched_show_task(struct task_struct *p)
 	if (!try_get_task_stack(p))
 		return;
 
-	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
+	printk("%stask:%-15.15s state:%c", lvl,
+	       p->comm, task_state_to_char(p));
 
 	if (task_is_running(p))
 		pr_cont("  running task    ");
@@ -7709,12 +7710,18 @@ void sched_show_task(struct task_struct *p)
 		free, task_pid_nr(p), task_tgid_nr(p),
 		ppid, p->flags, read_task_thread_flags(p));
 
-	print_worker_info(KERN_INFO, p);
-	print_stop_info(KERN_INFO, p);
-	print_scx_info(KERN_INFO, p);
-	show_stack(p, NULL, KERN_INFO);
+	print_worker_info(lvl, p);
+	print_stop_info(lvl, p);
+	print_scx_info(lvl, p);
+	show_stack(p, NULL, lvl);
 	put_task_stack(p);
 }
+EXPORT_SYMBOL_GPL(sched_show_task_log_lvl);
+
+void sched_show_task(struct task_struct *p)
+{
+	sched_show_task_log_lvl(p, KERN_INFO);
+}
 EXPORT_SYMBOL_GPL(sched_show_task);
 
 static inline bool
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


