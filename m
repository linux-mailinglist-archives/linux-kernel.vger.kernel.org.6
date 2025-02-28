Return-Path: <linux-kernel+bounces-539026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A3DA49FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF200177070
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5EF276047;
	Fri, 28 Feb 2025 17:08:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB1D276039
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762515; cv=none; b=XsFFPAImg138H6tzubokGvAc1FHqt3JTYgNYWnSNKptrbFoVZJi0j+jH1TDx20Lo6gIdW1F9dT/Lj8Q9evw1Sef9iC89ibzcZDbSoKCac9upxhCS6UJaH/S1MM5N1Z1Se5LKKTjmy1cel1CHLFa7c5RbBd4jOvcEBJVaVGprSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762515; c=relaxed/simple;
	bh=/PaPFpur610XMWMxsbWrTUWEJDEIaoCa73CoXYSCGWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Do15NJtx5uMb/ZfvofTT+1bUJj7FjJtBJ70+YZxs74Iue6DxQDe1fzdKujUkR6zjaug93HZUy+BTT0FH9Hr4ertWyPHz8d5mmNrx7wPsq1KD6Fj8twRVrxgcc/ezBCe8/yzsI1ID2ghdY1pEF8a6NWqF2ySW5wNI4Nv4xD7GCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37091C4CEE2;
	Fri, 28 Feb 2025 17:08:33 +0000 (UTC)
Date: Fri, 28 Feb 2025 12:09:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Heiko Carstens
 <hca@linux.ibm.com>, Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [GIT PULL] tracing: Fixes for v6.14-rc4
Message-ID: <20250228120918.5a050257@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Tracing fixes for v6.14:

- Fix crash from bad histogram entry

  An error path in the histogram creation could leave an entry
  in a link list that gets freed. Then when a new entry is added
  it can cause a u-a-f bug. This is fixed by restructuring the code
  so that the histogram is consistent on failure and everything is
  cleaned up appropriately.

- Fix fprobe self test

  The fprobe self test relies on no function being attached by ftrace.
  BPF programs can attach to functions via ftrace and systemd now
  does so. This causes those functions to appear in the enabled_functions
  list which holds all functions attached by ftrace. The selftest also
  uses that file to see if functions are being connected correctly.
  It counts the functions in the file, but if there's already functions
  in the file, it fails. Instead, add the number of functions in the file
  at the start of the test to all the calculations during the test.

- Fix potential division by zero of the function profiler stddev

  The calculated divisor that calculates the standard deviation of
  the function times can overflow. If the overflow happens to land
  on zero, that can cause a division by zero. Check for zero from
  the calculation before doing the division.

  TODO: Catch when it ever overflows and report it accordingly.
        For now, just prevent the system from crashing.


Please pull the latest trace-v6.14-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.14-rc4

Tag SHA1: 91a87e3b52a1683844156e377986aaf69306b31f
Head SHA1: a1a7eb89ca0b89dc1c326eeee2596f263291aca3


Heiko Carstens (1):
      selftests/ftrace: Let fprobe test consider already enabled functions

Nikolay Kuratov (1):
      ftrace: Avoid potential division by zero in function_stat_show()

Steven Rostedt (1):
      tracing: Fix bad hist from corrupting named_triggers list

----
 kernel/trace/ftrace.c                              | 27 +++++++++----------
 kernel/trace/trace_events_hist.c                   | 30 +++++++++++-----------
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    | 18 ++++++++-----
 3 files changed, 38 insertions(+), 37 deletions(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6b0c25761ccb..fc88e0688daf 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -540,6 +540,7 @@ static int function_stat_show(struct seq_file *m, void *v)
 	static struct trace_seq s;
 	unsigned long long avg;
 	unsigned long long stddev;
+	unsigned long long stddev_denom;
 #endif
 	guard(mutex)(&ftrace_profile_lock);
 
@@ -559,23 +560,19 @@ static int function_stat_show(struct seq_file *m, void *v)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	seq_puts(m, "    ");
 
-	/* Sample standard deviation (s^2) */
-	if (rec->counter <= 1)
-		stddev = 0;
-	else {
-		/*
-		 * Apply Welford's method:
-		 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
-		 */
+	/*
+	 * Variance formula:
+	 * s^2 = 1 / (n * (n-1)) * (n * \Sum (x_i)^2 - (\Sum x_i)^2)
+	 * Maybe Welford's method is better here?
+	 * Divide only by 1000 for ns^2 -> us^2 conversion.
+	 * trace_print_graph_duration will divide by 1000 again.
+	 */
+	stddev = 0;
+	stddev_denom = rec->counter * (rec->counter - 1) * 1000;
+	if (stddev_denom) {
 		stddev = rec->counter * rec->time_squared -
 			 rec->time * rec->time;
-
-		/*
-		 * Divide only 1000 for ns^2 -> us^2 conversion.
-		 * trace_print_graph_duration will divide 1000 again.
-		 */
-		stddev = div64_ul(stddev,
-				  rec->counter * (rec->counter - 1) * 1000);
+		stddev = div64_ul(stddev, stddev_denom);
 	}
 
 	trace_seq_init(&s);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 261163b00137..ad7419e24055 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6724,27 +6724,27 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (existing_hist_update_only(glob, trigger_data, file))
 		goto out_free;
 
-	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
-	if (ret < 0)
-		goto out_free;
+	if (!get_named_trigger_data(trigger_data)) {
 
-	if (get_named_trigger_data(trigger_data))
-		goto enable;
+		ret = create_actions(hist_data);
+		if (ret)
+			goto out_free;
 
-	ret = create_actions(hist_data);
-	if (ret)
-		goto out_unreg;
+		if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+			ret = save_hist_vars(hist_data);
+			if (ret)
+				goto out_free;
+		}
 
-	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		ret = save_hist_vars(hist_data);
+		ret = tracing_map_init(hist_data->map);
 		if (ret)
-			goto out_unreg;
+			goto out_free;
 	}
 
-	ret = tracing_map_init(hist_data->map);
-	if (ret)
-		goto out_unreg;
-enable:
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret < 0)
+		goto out_free;
+
 	ret = hist_trigger_enable(trigger_data, file);
 	if (ret)
 		goto out_unreg;
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 449f9d8be746..73f6c6fcecab 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -10,12 +10,16 @@ PLACE=$FUNCTION_FORK
 PLACE2="kmem_cache_free"
 PLACE3="schedule_timeout"
 
+# Some functions may have BPF programs attached, therefore
+# count already enabled_functions before tests start
+ocnt=`cat enabled_functions | wc -l`
+
 echo "f:myevent1 $PLACE" >> dynamic_events
 
 # Make sure the event is attached and is the only one
 grep -q $PLACE enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -23,7 +27,7 @@ echo "f:myevent2 $PLACE%return" >> dynamic_events
 
 # It should till be the only attached function
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -32,7 +36,7 @@ echo "f:myevent3 $PLACE2" >> dynamic_events
 
 grep -q $PLACE2 enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 2 ]; then
+if [ $cnt -ne $((ocnt + 2)) ]; then
 	exit_fail
 fi
 
@@ -49,7 +53,7 @@ grep -q myevent1 dynamic_events
 
 # should still have 2 left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 2 ]; then
+if [ $cnt -ne $((ocnt + 2)) ]; then
 	exit_fail
 fi
 
@@ -57,7 +61,7 @@ echo > dynamic_events
 
 # Should have none left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 0 ]; then
+if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 
@@ -65,7 +69,7 @@ echo "f:myevent4 $PLACE" >> dynamic_events
 
 # Should only have one enabled
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -73,7 +77,7 @@ echo > dynamic_events
 
 # Should have none left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 0 ]; then
+if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 

