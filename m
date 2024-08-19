Return-Path: <linux-kernel+bounces-291387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD51956173
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD651C208C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679F2E40E;
	Mon, 19 Aug 2024 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UkvTz71H"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A28213D509
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724038243; cv=none; b=b4un29z+Q6padvAigpVbDcHdiPBvnRd1HDQyYTfAory/W4k+h1Om7CkzfKdC1ftlU2wlJcuIw/FEEYhdc0drAE7f8Vw6f9+fjHZpFP04sk9caesNWrlAyG9S4/CvtkDaJN1VOZmajHgtEQL1J0D1zhCbtFDsVoBKBS5vehAOZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724038243; c=relaxed/simple;
	bh=zljR9VRSxb0sGTWoDHNNQkcanUn9KXSFylAo5Lbi41Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhcwEFr0RtbfGKlqwvhJkqelqiaaRkJHa0U+evYoptkPD4QKEEPxsW0cwqYne/yJSXVxiD+fXaWaayx1ozPdWdZzjNL6B3c8g6U4uwpr3jlCiAD0+B98EMQkKyAD3BfNBgltwCFSZetIkcCdxDbQJib/KcdsSqZ/dyz7mMwnDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UkvTz71H; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d316f0060so3249868b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724038241; x=1724643041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmCEXCOk+hO1c6Sh2eb2KmmDxqjIbBhXdcGGXb64czY=;
        b=UkvTz71H1NLt2sG38dU+YJLlxW8xCjblWGBGqiTx94LgyHC49xZGRD9LKwRW6nZTLq
         mRDz/7PGVwBssWl1AQ4DhuDZ3/gKd2i13VYCzJ0QLFbRhHIrD+5qq603qjtrniSubrQ5
         rFgq4Omp+M05FtH4QoCncE+NIJkk3LnmBhmpUXL9rF/p4zjlO8xKQVCMNvKopPa5EbFc
         IB165Os9Xw8pDsVoCswy/xgE66EYQC/soisLuJYzdSdJl/FDgpiLx7mqWbWDQmnpvOBa
         BiryJ0wNl+CeQkFGAcWq9htSM7qnk8ZHcUOHWsUmdrkVBPhZ8IaD+Z3V7lTMtLq5UFiZ
         Po8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724038241; x=1724643041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmCEXCOk+hO1c6Sh2eb2KmmDxqjIbBhXdcGGXb64czY=;
        b=F4KX0BE4Yo70yJP6pA34XZGJIQuqKKVpvogHYnKF5LVLHfoxc0KHh1G2IIUFlDrcmt
         ROb9SvS50CX5+8y/0TNaWcj64BUx8oo/tpq4Y8VDSK/01pkWplxe6bsQxgV+bEBCp3tS
         viR6okM8pnHZ/x1/5Pz+Cwn63hvBzZ9Vf4Vdd5gDILrJVF5w16urWwEFaE3GafRqAq3p
         /WoCRjyrAk0ErBpUcWx6c2RDm1QQTfoMaymrW0zaK7f/4U7mhCpfRj46DULwxtx2w7cC
         JKCU9OZoEyrhllGUESZkVhDO7c28k0zXAktxsXM4aklX3K8pEHX96Mm6SVQGd3qCupoG
         93Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVDWkZJDFdcbWmeBH1GFzt0uUP2rIfQf6nqsZ5APhWffwRbbnffiZ141It043/rlppnoSY+UtJulc1ZAA2Qm1BqDeNj78UZs4mnM11N
X-Gm-Message-State: AOJu0YyPrH1VyCwNgi4gNBzjDfx1/o9wdWILOnMIRpGiX9mTrZvbGA0z
	fbPytA83eF5crlIZToUwjKPdX2MDBOx1+7miU/ppJnHKc2HRAUWLb73nF1MucPU=
X-Google-Smtp-Source: AGHT+IFoWqt6pcEK892u6sgpFJh/ajwxn6trQxKIOYO6AqVn7guFnB3X6L1zJ4I1WzFbqyzPL8s0kw==
X-Received: by 2002:aa7:8e10:0:b0:706:1bb3:fb1d with SMTP id d2e1a72fcca58-71276f5f0e6mr19512940b3a.7.1724038240947;
        Sun, 18 Aug 2024 20:30:40 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add83bdsm5816397b3a.3.2024.08.18.20.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 20:30:40 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 1/2] perf sched timehist: Add --show-prio option
Date: Mon, 19 Aug 2024 11:30:15 +0800
Message-Id: <20240819033016.2427235-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819033016.2427235-1-yangjihong@bytedance.com>
References: <20240819033016.2427235-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --show-prio option is used to display the priority of task.
It is disabled by default, which is consistent with original behavior.

The display format is xxx (priority does not change during task running)
or xxx->yyy (priority changes during task running)

Testcase:

  # perf sched record nice -n 9 true
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 0.497 MB perf.data ]

  # perf sched timehist -h

   Usage: perf sched timehist [<options>]

      -C, --cpu <cpu>       list of cpus to profile
      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -g, --call-graph      Display call chains if present (default on)
      -I, --idle-hist       Show idle events only
      -i, --input <file>    input file name
      -k, --vmlinux <file>  vmlinux pathname
      -M, --migrations      Show migration events
      -n, --next            Show next task
      -p, --pid <pid[,pid...]>
                            analyze events only for given process id(s)
      -s, --summary         Show only syscall summary with statistics
      -S, --with-summary    Show all syscalls and summary with statistics
      -t, --tid <tid[,tid...]>
                            analyze events only for given thread id(s)
      -V, --cpu-visual      Add CPU visual
      -v, --verbose         be more verbose (show symbol address, etc)
      -w, --wakeups         Show wakeup events
          --kallsyms <file>
                            kallsyms pathname
          --max-stack <n>   Maximum number of functions to display backtrace.
          --show-prio       Show task priority
          --state           Show task state when sched-out
          --symfs <directory>
                            Look for files with symbols relative to this directory
          --time <str>      Time span for analysis (start,stop)

  # perf sched timehist
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
     23952.006537 [0000]  perf[534]                           0.000      0.000      0.000
     23952.006593 [0000]  migration/0[19]                     0.000      0.014      0.056
     23952.006899 [0001]  perf[534]                           0.000      0.000      0.000
     23952.006947 [0001]  migration/1[22]                     0.000      0.015      0.047
     23952.007138 [0002]  perf[534]                           0.000      0.000      0.000
  <SNIP>

  # perf sched timehist --show-prio
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       prio      wait time  sch delay   run time
                          [tid/pid]                                    (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  --------  ---------  ---------  ---------
     23952.006537 [0000]  perf[534]                       120           0.000      0.000      0.000
     23952.006593 [0000]  migration/0[19]                 0             0.000      0.014      0.056
     23952.006899 [0001]  perf[534]                       120           0.000      0.000      0.000
  <SNIP>
     23952.034843 [0003]  nice[535]                       120->129      0.189      0.024     23.314
  <SNIP>
     23952.053838 [0005]  rcu_preempt[16]                 120           3.993      0.000      0.023
     23952.053990 [0005]  <idle>                          120           0.023      0.023      0.152
     23952.054137 [0006]  <idle>                          120           1.427      1.427     17.855
     23952.054278 [0007]  <idle>                          120           0.506      0.506      1.650

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/Documentation/perf-sched.txt |  3 +
 tools/perf/builtin-sched.c              | 91 +++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 84d49f9241b1..3efa5c58418d 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -212,6 +212,9 @@ OPTIONS for 'perf sched timehist'
 --state::
 	Show task state when it switched out.
 
+--show-prio::
+	Show task priority.
+
 OPTIONS for 'perf sched replay'
 ------------------------------
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 9c1276dc8ef6..cb61cbb72bfa 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -228,6 +228,7 @@ struct perf_sched {
 	bool		show_next;
 	bool		show_migrations;
 	bool		show_state;
+	bool		show_prio;
 	u64		skipped_samples;
 	const char	*time_str;
 	struct perf_time_interval ptime;
@@ -258,6 +259,8 @@ struct thread_runtime {
 	bool comm_changed;
 
 	u64 migrations;
+
+	int prio;
 };
 
 /* per event run time data */
@@ -920,6 +923,11 @@ struct sort_dimension {
 	struct list_head	list;
 };
 
+static inline void init_prio(struct thread_runtime *r)
+{
+	r->prio = -1;
+}
+
 /*
  * handle runtime stats saved per thread
  */
@@ -932,6 +940,7 @@ static struct thread_runtime *thread__init_runtime(struct thread *thread)
 		return NULL;
 
 	init_stats(&r->run_stats);
+	init_prio(r);
 	thread__set_priv(thread, r);
 
 	return r;
@@ -2036,6 +2045,24 @@ static char *timehist_get_commstr(struct thread *thread)
 	return str;
 }
 
+/* prio field format: xxx or xxx->yyy */
+#define MAX_PRIO_STR_LEN 8
+static char *timehist_get_priostr(struct evsel *evsel,
+				  struct thread *thread,
+				  struct perf_sample *sample)
+{
+	static char prio_str[16];
+	int prev_prio = (int)evsel__intval(evsel, sample, "prev_prio");
+	struct thread_runtime *tr = thread__priv(thread);
+
+	if (tr->prio != prev_prio && tr->prio != -1)
+		scnprintf(prio_str, sizeof(prio_str), "%d->%d", tr->prio, prev_prio);
+	else
+		scnprintf(prio_str, sizeof(prio_str), "%d", prev_prio);
+
+	return prio_str;
+}
+
 static void timehist_header(struct perf_sched *sched)
 {
 	u32 ncpus = sched->max_cpu.cpu + 1;
@@ -2053,8 +2080,14 @@ static void timehist_header(struct perf_sched *sched)
 		printf(" ");
 	}
 
-	printf(" %-*s  %9s  %9s  %9s", comm_width,
-		"task name", "wait time", "sch delay", "run time");
+	if (sched->show_prio) {
+		printf(" %-*s  %-*s  %9s  %9s  %9s",
+		       comm_width, "task name", MAX_PRIO_STR_LEN, "prio",
+		       "wait time", "sch delay", "run time");
+	} else {
+		printf(" %-*s  %9s  %9s  %9s", comm_width,
+		       "task name", "wait time", "sch delay", "run time");
+	}
 
 	if (sched->show_state)
 		printf("  %s", "state");
@@ -2069,8 +2102,14 @@ static void timehist_header(struct perf_sched *sched)
 	if (sched->show_cpu_visual)
 		printf(" %*s ", ncpus, "");
 
-	printf(" %-*s  %9s  %9s  %9s", comm_width,
-	       "[tid/pid]", "(msec)", "(msec)", "(msec)");
+	if (sched->show_prio) {
+		printf(" %-*s  %-*s  %9s  %9s  %9s",
+		       comm_width, "[tid/pid]", MAX_PRIO_STR_LEN, "",
+		       "(msec)", "(msec)", "(msec)");
+	} else {
+		printf(" %-*s  %9s  %9s  %9s", comm_width,
+		       "[tid/pid]", "(msec)", "(msec)", "(msec)");
+	}
 
 	if (sched->show_state)
 		printf("  %5s", "");
@@ -2085,9 +2124,15 @@ static void timehist_header(struct perf_sched *sched)
 	if (sched->show_cpu_visual)
 		printf(" %.*s ", ncpus, graph_dotted_line);
 
-	printf(" %.*s  %.9s  %.9s  %.9s", comm_width,
-		graph_dotted_line, graph_dotted_line, graph_dotted_line,
-		graph_dotted_line);
+	if (sched->show_prio) {
+		printf(" %.*s  %.*s  %.9s  %.9s  %.9s",
+		       comm_width, graph_dotted_line, MAX_PRIO_STR_LEN, graph_dotted_line,
+		       graph_dotted_line, graph_dotted_line, graph_dotted_line);
+	} else {
+		printf(" %.*s  %.9s  %.9s  %.9s", comm_width,
+		       graph_dotted_line, graph_dotted_line, graph_dotted_line,
+		       graph_dotted_line);
+	}
 
 	if (sched->show_state)
 		printf("  %.5s", graph_dotted_line);
@@ -2134,6 +2179,9 @@ static void timehist_print_sample(struct perf_sched *sched,
 
 	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
 
+	if (sched->show_prio)
+		printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_priostr(evsel, thread, sample));
+
 	wait_time = tr->dt_sleep + tr->dt_iowait + tr->dt_preempt;
 	print_sched_time(wait_time, 6);
 
@@ -2301,6 +2349,7 @@ static int init_idle_thread(struct thread *thread)
 	if (itr == NULL)
 		return -ENOMEM;
 
+	init_prio(&itr->tr);
 	init_stats(&itr->tr.run_stats);
 	callchain_init(&itr->callchain);
 	callchain_cursor_reset(&itr->cursor);
@@ -2627,6 +2676,30 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
 	return 0;
 }
 
+static void timehist_update_task_prio(struct evsel *evsel,
+				      struct perf_sample *sample,
+				      struct machine *machine)
+{
+	struct thread *thread;
+	struct thread_runtime *tr = NULL;
+	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
+	const u32 next_prio = evsel__intval(evsel, sample, "next_prio");
+
+	if (next_pid == 0)
+		thread = get_idle_thread(sample->cpu);
+	else
+		thread = machine__findnew_thread(machine, -1, next_pid);
+
+	if (thread == NULL)
+		return;
+
+	tr = thread__get_runtime(thread);
+	if (tr == NULL)
+		return;
+
+	tr->prio = next_prio;
+}
+
 static int timehist_sched_change_event(const struct perf_tool *tool,
 				       union perf_event *event,
 				       struct evsel *evsel,
@@ -2650,6 +2723,9 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 		goto out;
 	}
 
+	if (sched->show_prio)
+		timehist_update_task_prio(evsel, sample, machine);
+
 	thread = timehist_get_thread(sched, sample, machine, evsel);
 	if (thread == NULL) {
 		rc = -1;
@@ -3683,6 +3759,7 @@ int cmd_sched(int argc, const char **argv)
 	OPT_STRING('t', "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "analyze events only for given thread id(s)"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_BOOLEAN(0, "show-prio", &sched.show_prio, "Show task priority"),
 	OPT_PARENT(sched_options)
 	};
 
-- 
2.25.1


