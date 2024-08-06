Return-Path: <linux-kernel+bounces-275553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C394871E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D91B2298E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CCBAD5E;
	Tue,  6 Aug 2024 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JRHmSb3p"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AE41E495
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909444; cv=none; b=TlwzKTYIt9NlKbSJCy1S3UC8v4YdqxEPzpf/OOaoGO6pJ3htHB9MbQUHsfMg+6Pg29I2xCruhQw71z9DU2rm0zzT4bcGbqxDtopJhUDzcGuub9p1FST66XODv7li8jYafRLPq/70Lv6CBJWlucUB5Yow9Vmx+Aptw2VwW/wyCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909444; c=relaxed/simple;
	bh=T5lTh1H+KpenjsCnPwoeArAkVYsP23cMh/VNluhjGWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+a0xK9NXgrkhDUjkKCdY3laylwTqjTH1hHAf3ZIdEjP6cqV9Gu8RMKzk9R7ssVAYdUI+KMsY6YXi0w3N6nMgZT+6WD5aJisAHjXKSJ1L3LAaRxlJw67vOyM/TbgHxIKN8NMinjvpf6RG4nlgcaF9r/g6v7CA5ly911uzghnocc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JRHmSb3p; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fed72d23a7so721225ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722909442; x=1723514242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPUpKaXytJIYx+EO0mIECPeSM07Nvv2jd3odmg2iV0U=;
        b=JRHmSb3pOxSRvKD1uGln7naF7y1LLHD1qpHmWeCeJXhr8P6TQhMC1o3MsmlO15h9h4
         MtMMOtXqcVptDxQ6nYrqZBjeJUttUc/CIxnZsSeWptURQgJaTuc9N1Weg1Q9N6RF1/Hz
         4MCVx5H2jMkuojBCIlYIWcY9lXowhTyl3vx0Hp+aOY6ct1v9AaIcI8pFtp1oh7wgZASH
         kEJ0VMMltXkM+UqqWET1ZKg2B3mo/kPJKT2e0df40v0Pmo3lFAzAJHV2kIEB2wYpzDSV
         Pgeu5avys2wE020q3+rfoVwknGOBf84g/rhigX3ZGJIAJu3UY+4wFRrhft6rFWxuf/UI
         v3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722909442; x=1723514242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPUpKaXytJIYx+EO0mIECPeSM07Nvv2jd3odmg2iV0U=;
        b=V9fKW6cJmMS4pg1N9RslNjtmmj8Eptm3AZgQCvw+Cy6EANdAsjFjje/c8tqkHd01/3
         djwjtX6DRaE2965jgwshDiI9ufy6oThembyta6oJ4mR7AeIb/mwa4qWGwggoitkh9l3U
         ctv9GxzW305wLP+zMkqF+BdlcETU9idIQLleP/aU1xfmfRK5At+ybUmEYRE3Q/LEKW7l
         zmktSaDvD0gEPUIxcptA/UgJmikl5E9e1IWhAYYkdAEyB8UCu1Wn25Epp/RFVY5bXH0P
         fe4/GyN4xDjkF2WOJ5ATze78HhFKvBByGYvw3+L9Y+WwX8hfZJ4ERRhWgcq8hwlF5EAi
         tOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM0ryvalIFURVG8UfRamjFCZP+sayUZXAtda6ozazdwohfvpdWPJZCSE0zG1EeAzfSHcwDBywMUIMbhN+Z8+rrZmoMiuyWtLivL0zn
X-Gm-Message-State: AOJu0Yw0E8i6lf1sM8cj9cKw7r8sCnRjWzN0KOef3BXIjFIK4gb4cY+5
	GACkva+Yi0TrBHQT9EyhzvmFjpvZSE2DRDMWjyHmP3lHh1POv5WQTbRBPFkSzKw=
X-Google-Smtp-Source: AGHT+IG1t7I0ttnnv1LNsH0qPkCMmyU0yOUwkOZouNuryfp8pW2BWsjbPOHZkV8yW6FHJEFfTDbGrg==
X-Received: by 2002:a17:902:e885:b0:1fc:57b7:995c with SMTP id d9443c01a7336-1ff572584f3mr146229415ad.7.1722909442408;
        Mon, 05 Aug 2024 18:57:22 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5917496fsm75509455ad.182.2024.08.05.18.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 18:57:21 -0700 (PDT)
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH 2/2] perf sched timehist: Add --prio option
Date: Tue,  6 Aug 2024 09:57:01 +0800
Message-Id: <20240806015701.1309833-3-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806015701.1309833-1-yangjihong@bytedance.com>
References: <20240806015701.1309833-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --prio option is used to only show events for the given task priority(ies).
The default is to show events for all priority tasks, which is consistent with
the previous behavior.

Testcase:
  # perf sched record nice -n 9 perf bench sched messaging -l 10000
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 3.435 [sec]
  [ perf record: Woken up 270 times to write data ]
  [ perf record: Captured and wrote 618.688 MB perf.data (5729036 samples) ]

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
          --prio <prio>     analyze events only for given task priority(ies)
          --show-prio       Show task priority
          --state           Show task state when sched-out
          --symfs <directory>
                            Look for files with symbols relative to this directory
          --time <str>      Time span for analysis (start,stop)

  # perf sched timehist --prio 140
  Samples of sched_switch event do not have callchains.
  Invalid prio string

  # perf sched timehist --show-prio --prio 129
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       prio      wait time  sch delay   run time
                          [tid/pid]                                    (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  --------  ---------  ---------  ---------
   2090450.765421 [0002]  sched-messaging[1229618]        129           0.000      0.000      0.029
   2090450.765445 [0007]  sched-messaging[1229616]        129           0.000      0.062      0.043
   2090450.765448 [0014]  sched-messaging[1229619]        129           0.000      0.000      0.032
   2090450.765478 [0013]  sched-messaging[1229617]        129           0.000      0.065      0.048
   2090450.765503 [0014]  sched-messaging[1229622]        129           0.000      0.000      0.017
   2090450.765550 [0002]  sched-messaging[1229624]        129           0.000      0.000      0.021
   2090450.765562 [0007]  sched-messaging[1229621]        129           0.000      0.071      0.028
   2090450.765570 [0005]  sched-messaging[1229620]        129           0.000      0.064      0.066
   2090450.765583 [0001]  sched-messaging[1229625]        129           0.000      0.001      0.031
   2090450.765595 [0013]  sched-messaging[1229623]        129           0.000      0.060      0.028
   2090450.765637 [0014]  sched-messaging[1229628]        129           0.000      0.000      0.019
   2090450.765665 [0007]  sched-messaging[1229627]        129           0.000      0.038      0.030
  <SNIP>

  # perf sched timehist --show-prio --prio 0,120-129
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       prio      wait time  sch delay   run time
                          [tid/pid]                                    (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  --------  ---------  ---------  ---------
   2090450.763231 [0000]  perf[1229608]                   120           0.000      0.000      0.000
   2090450.763235 [0000]  migration/0[15]                 0             0.000      0.001      0.003
   2090450.763263 [0001]  perf[1229608]                   120           0.000      0.000      0.000
   2090450.763268 [0001]  migration/1[21]                 0             0.000      0.001      0.004
   2090450.763302 [0002]  perf[1229608]                   120           0.000      0.000      0.000
   2090450.763309 [0002]  migration/2[27]                 0             0.000      0.001      0.007
   2090450.763338 [0003]  perf[1229608]                   120           0.000      0.000      0.000
   2090450.763343 [0003]  migration/3[33]                 0             0.000      0.001      0.004
   2090450.763459 [0004]  perf[1229608]                   120           0.000      0.000      0.000
   2090450.763469 [0004]  migration/4[39]                 0             0.000      0.002      0.010
   2090450.763496 [0005]  perf[1229608]                   120           0.000      0.000      0.000
   2090450.763501 [0005]  migration/5[45]                 0             0.000      0.001      0.004
   2090450.763613 [0006]  perf[1229608]                   120           0.000      0.000      0.000
   2090450.763622 [0006]  migration/6[51]                 0             0.000      0.001      0.008
   2090450.763652 [0007]  perf[1229608]                   120           0.000      0.000      0.000
   2090450.763660 [0007]  migration/7[57]                 0             0.000      0.001      0.008
  <SNIP>
   2090450.765665 [0001]  <idle>                          120           0.031      0.031      0.081
   2090450.765665 [0007]  sched-messaging[1229627]        129           0.000      0.038      0.030
   2090450.765667 [0000]  s1-perf[8235/7168]              120           0.008      0.000      0.004
   2090450.765684 [0013]  <idle>                          120           0.028      0.028      0.088
   2090450.765685 [0001]  sched-messaging[1229630]        129           0.000      0.001      0.020
   2090450.765688 [0000]  <idle>                          120           0.004      0.004      0.020
   2090450.765689 [0002]  <idle>                          120           0.021      0.021      0.138
   2090450.765691 [0005]  sched-messaging[1229626]        129           0.000      0.085      0.029

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/Documentation/perf-sched.txt |  3 +
 tools/perf/builtin-sched.c              | 74 ++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 3efa5c58418d..70a9016d5a06 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -215,6 +215,9 @@ OPTIONS for 'perf sched timehist'
 --show-prio::
 	Show task priority.
 
+--prio::
+	Only show events for given task priority(ies).
+
 OPTIONS for 'perf sched replay'
 ------------------------------
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2af9dbdf4ba2..3981994d9921 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -51,6 +51,7 @@
 #define COMM_LEN		20
 #define SYM_LEN			129
 #define MAX_PID			1024000
+#define MAX_PRIO		140
 
 static const char *cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -234,6 +235,8 @@ struct perf_sched {
 	struct perf_time_interval ptime;
 	struct perf_time_interval hist_time;
 	volatile bool   thread_funcs_exit;
+	const char	*prio_str;
+	DECLARE_BITMAP(prio_bitmap, MAX_PRIO);
 };
 
 /* per thread run time data */
@@ -2504,12 +2507,33 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 				 struct perf_sample *sample)
 {
 	bool rc = false;
+	int prio = -1;
+	struct thread_runtime *tr = NULL;
 
 	if (thread__is_filtered(thread)) {
 		rc = true;
 		sched->skipped_samples++;
 	}
 
+	if (sched->prio_str) {
+		/*
+		 * Because priority may be changed during task execution,
+		 * first read priority from prev sched_in event for current task.
+		 * If prev sched_in event is not saved, then read priority from
+		 * current task sched_out event.
+		 */
+		tr = thread__get_runtime(thread);
+		if (tr && tr->prio != -1)
+			prio = tr->prio;
+		else if (evsel__name_is(evsel, "sched:sched_switch"))
+			prio = evsel__intval(evsel, sample, "prev_prio");
+
+		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
+			rc = true;
+			sched->skipped_samples++;
+		}
+	}
+
 	if (sched->idle_hist) {
 		if (!evsel__name_is(evsel, "sched:sched_switch"))
 			rc = true;
@@ -2723,7 +2747,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 		goto out;
 	}
 
-	if (sched->show_prio)
+	if (sched->show_prio || sched->prio_str)
 		timehist_update_task_prio(evsel, sample, machine);
 
 	thread = timehist_get_thread(sched, sample, machine, evsel);
@@ -3142,6 +3166,47 @@ static int timehist_check_attr(struct perf_sched *sched,
 	return 0;
 }
 
+static int timehist_parse_prio_str(struct perf_sched *sched)
+{
+	char *p;
+	unsigned long start_prio, end_prio;
+	const char *str = sched->prio_str;
+
+	if (!str)
+		return 0;
+
+	while (isdigit(*str)) {
+		p = NULL;
+		start_prio = strtoul(str, &p, 0);
+		if (start_prio >= MAX_PRIO || (*p != '\0' && *p != ',' && *p != '-'))
+			return -1;
+
+		if (*p == '-') {
+			str = ++p;
+			p = NULL;
+			end_prio = strtoul(str, &p, 0);
+
+			if (end_prio >= MAX_PRIO || (*p != '\0' && *p != ','))
+				return -1;
+
+			if (end_prio < start_prio)
+				return -1;
+		} else {
+			end_prio = start_prio;
+		}
+
+		for (; start_prio <= end_prio; start_prio++)
+			__set_bit(start_prio, sched->prio_bitmap);
+
+		if (*p)
+			++p;
+
+		str = p;
+	}
+
+	return 0;
+}
+
 static int perf_sched__timehist(struct perf_sched *sched)
 {
 	struct evsel_str_handler handlers[] = {
@@ -3203,6 +3268,11 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	if (timehist_check_attr(sched, evlist) != 0)
 		goto out;
 
+	if (timehist_parse_prio_str(sched) != 0) {
+		pr_err("Invalid prio string\n");
+		goto out;
+	}
+
 	setup_pager();
 
 	/* prefer sched_waking if it is captured */
@@ -3768,6 +3838,8 @@ int cmd_sched(int argc, const char **argv)
 		   "analyze events only for given thread id(s)"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
 	OPT_BOOLEAN(0, "show-prio", &sched.show_prio, "Show task priority"),
+	OPT_STRING(0, "prio", &sched.prio_str, "prio",
+		   "analyze events only for given task priority(ies)"),
 	OPT_PARENT(sched_options)
 	};
 
-- 
2.25.1


