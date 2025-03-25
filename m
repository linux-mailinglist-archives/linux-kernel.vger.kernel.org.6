Return-Path: <linux-kernel+bounces-575538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DC3A703CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2439E16A2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179C25C704;
	Tue, 25 Mar 2025 14:34:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F425A352
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913258; cv=none; b=M/Zv1+NZSKOJjJZkhfVPK1VJzGnfKyCPHcn0oAaDOd1tDz2RBNdgJn/l7UdhiTKbmGKHAJ3Myuf74fxWa6xiefaZtoM4NiTnhlxWuQu9NlUpv6NCBx/ln+/TAyhc3JQWdZDfFCzf6pUD9zoI9IXaawLjYwlfTsTuXaM+WdMW49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913258; c=relaxed/simple;
	bh=op4bZHNgFkTMeMbsYcAkob/xeuuEeaMPRJ0DS4GK3Ac=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kObcY9ITxywpYBc5J5QNhytAWKlxO2JAz9DpoNwg34KWqxWDpLVVkxVqaZ+pKgfzJjfSOHpVzG/YH6YWLS0uJkGHOPl6aW6x39oVErSor9G9a1TRne2I/1pWuZvgW06I3kLprGwCXm0KwrLmnly4krbvcyt3otaemBwba+fsQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837CAC4AF09;
	Tue, 25 Mar 2025 14:34:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tx5Ms-00000002P1L-4066;
	Tue, 25 Mar 2025 10:35:02 -0400
Message-ID: <20250325143502.803979565@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 10:34:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 6/9] tools/rv: Add support for nested monitors
References: <20250325143436.168114339@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

RV now supports nested monitors, this functionality requires a container
monitor, which has virtually no functionality besides holding other
monitors, and nested monitors, that have a container as parent.

Nested monitors' sysfs folders are physically nested in the container's
folder, and they are listed in the available_monitors file with the
notation container:monitor.
These changes go against the assumption that each line in the
available_monitors file correspond to a folder in the rv directory,
breaking the functionality of the rv tool.

Add support for nested containers in the rv userspace tool, indenting
nested monitors while listed and allowing both the notation with and
without container name, which are equivalent:

  # rv list
  mon1
  mon2
  container:
   - nested1
   - nested2

  ## notation with container name
  # rv mon container:nested1

  ## notation without container name
  # rv mon nested1

Either way, enabling a nested monitor is the same as enabling any other
non-nested monitor.
Selecting the container with rv mon enables all the nested monitors, if
-t is passed, the trace also includes the monitor name next to the
event:

  # rv mon nested1 -t
  <idle>-0        [004] event   state1 x event    -> state2
  <idle>-0        [004] error   event not expected in state2

  # rv mon sched -t
  <idle>-0        [004] event_nested1   state1 x event    -> state2
  <idle>-0        [004] error_nested1   event not expected in state2

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/20250305140406.350227-7-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rv/include/rv.h    |   1 +
 tools/verification/rv/src/in_kernel.c | 226 ++++++++++++++++++++------
 2 files changed, 179 insertions(+), 48 deletions(-)

diff --git a/tools/verification/rv/include/rv.h b/tools/verification/rv/include/rv.h
index 0cab1037a98f..6f668eb266cb 100644
--- a/tools/verification/rv/include/rv.h
+++ b/tools/verification/rv/include/rv.h
@@ -7,6 +7,7 @@ struct monitor {
 	char name[MAX_DA_NAME_LEN];
 	char desc[MAX_DESCRIPTION];
 	int enabled;
+	int nested;
 };
 
 int should_stop(void);
diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index f2bbc75a76f4..032b85101929 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -6,15 +6,18 @@
  */
 #include <getopt.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include <string.h>
 #include <errno.h>
 #include <unistd.h>
+#include <dirent.h>
 
 #include <trace.h>
 #include <utils.h>
 #include <rv.h>
 
 static int config_has_id;
+static int config_is_container;
 static int config_my_pid;
 static int config_trace;
 
@@ -44,6 +47,51 @@ static int __ikm_read_enable(char *monitor_name)
 	return enabled;
 }
 
+/*
+ * __ikm_find_monitor - find the full name of a possibly nested module
+ *
+ * __does not log errors.
+ *
+ * Returns 1 if we found the monitor, -1 on error and 0 if it does not exist.
+ * The string out_name is populated with the full name, which can be
+ * equal to monitor_name or container/monitor_name if nested
+ */
+static int __ikm_find_monitor_name(char *monitor_name, char *out_name)
+{
+	char *available_monitors, container[MAX_DA_NAME_LEN+1], *cursor, *end;
+	int retval = 1;
+
+	available_monitors = tracefs_instance_file_read(NULL, "rv/available_monitors", NULL);
+	if (!available_monitors)
+		return -1;
+
+	cursor = strstr(available_monitors, monitor_name);
+	if (!cursor) {
+		retval = 0;
+		goto out_free;
+	}
+
+	for (; cursor > available_monitors; cursor--)
+		if (*(cursor-1) == '\n')
+			break;
+	end = strstr(cursor, "\n");
+	memcpy(out_name, cursor, end-cursor);
+	out_name[end-cursor] = '\0';
+
+	cursor = strstr(out_name, ":");
+	if (cursor)
+		*cursor = '/';
+	else {
+		sprintf(container, "%s:", monitor_name);
+		if (strstr(available_monitors, container))
+			config_is_container = 1;
+	}
+
+out_free:
+	free(available_monitors);
+	return retval;
+}
+
 /*
  * ikm_read_enable - reads monitor's enable status
  *
@@ -137,7 +185,17 @@ static char *ikm_read_desc(char *monitor_name)
 static int ikm_fill_monitor_definition(char *name, struct monitor *ikm)
 {
 	int enabled;
-	char *desc;
+	char *desc, *nested_name;
+
+	nested_name = strstr(name, ":");
+	if (nested_name) {
+		*nested_name = '/';
+		++nested_name;
+		ikm->nested = 1;
+	} else {
+		nested_name = name;
+		ikm->nested = 0;
+	}
 
 	enabled = ikm_read_enable(name);
 	if (enabled < 0) {
@@ -151,7 +209,7 @@ static int ikm_fill_monitor_definition(char *name, struct monitor *ikm)
 		return -1;
 	}
 
-	strncpy(ikm->name, name, MAX_DA_NAME_LEN);
+	strncpy(ikm->name, nested_name, MAX_DA_NAME_LEN);
 	ikm->enabled = enabled;
 	strncpy(ikm->desc, desc, MAX_DESCRIPTION);
 
@@ -273,7 +331,7 @@ static int ikm_has_id(char *monitor_name)
 int ikm_list_monitors(void)
 {
 	char *available_monitors;
-	struct monitor ikm;
+	struct monitor ikm = {0};
 	char *curr, *next;
 	int retval;
 
@@ -293,7 +351,9 @@ int ikm_list_monitors(void)
 		if (retval)
 			err_msg("ikm: error reading %d in kernel monitor, skipping\n", curr);
 
-		printf("%-24s %s %s\n", ikm.name, ikm.desc, ikm.enabled ? "[ON]" : "[OFF]");
+		printf("%s%-*s %s %s\n", ikm.nested ? " - " : "",
+		       ikm.nested ? MAX_DA_NAME_LEN - 3 : MAX_DA_NAME_LEN,
+		       ikm.name, ikm.desc, ikm.enabled ? "[ON]" : "[OFF]");
 		curr = ++next;
 
 	} while (strlen(curr));
@@ -343,11 +403,11 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
 	unsigned long long final_state;
 	unsigned long long pid;
 	unsigned long long id;
-	int cpu = record->cpu;
 	int val;
+	bool missing_id;
 
 	if (config_has_id)
-		tep_get_field_val(s, trace_event, "id", record, &id, 1);
+		missing_id = tep_get_field_val(s, trace_event, "id", record, &id, 1);
 
 	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
 
@@ -356,12 +416,21 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
 	else if (config_my_pid && (config_my_pid == pid))
 		return 0;
 
-	tep_print_event(trace_event->tep, s, record, "%16s-%-8d ", TEP_PRINT_COMM, TEP_PRINT_PID);
+	tep_print_event(trace_event->tep, s, record, "%16s-%-8d [%.3d] ",
+			TEP_PRINT_COMM, TEP_PRINT_PID, TEP_PRINT_CPU);
 
-	trace_seq_printf(s, "[%.3d] event ", cpu);
+	if (config_is_container)
+		tep_print_event(trace_event->tep, s, record, "%s ", TEP_PRINT_NAME);
+	else
+		trace_seq_printf(s, "event ");
 
-	if (config_has_id)
-		trace_seq_printf(s, "%8llu ", id);
+	if (config_has_id) {
+		if (missing_id)
+			/* placeholder if we are dealing with a mixed-type container*/
+			trace_seq_printf(s, "        ");
+		else
+			trace_seq_printf(s, "%8llu ", id);
+	}
 
 	state = tep_get_field_raw(s, trace_event, "state", record, &val, 0);
 	event = tep_get_field_raw(s, trace_event, "event", record, &val, 0);
@@ -394,9 +463,10 @@ ikm_error_handler(struct trace_seq *s, struct tep_record *record,
 	int cpu = record->cpu;
 	char *state, *event;
 	int val;
+	bool missing_id;
 
 	if (config_has_id)
-		tep_get_field_val(s, trace_event, "id", record, &id, 1);
+		missing_id = tep_get_field_val(s, trace_event, "id", record, &id, 1);
 
 	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
 
@@ -405,10 +475,20 @@ ikm_error_handler(struct trace_seq *s, struct tep_record *record,
 	else if (config_my_pid == pid)
 		return 0;
 
-	trace_seq_printf(s, "%8lld [%03d] error ", pid, cpu);
+	trace_seq_printf(s, "%8lld [%03d] ", pid, cpu);
 
-	if (config_has_id)
-		trace_seq_printf(s, "%8llu ", id);
+	if (config_is_container)
+		tep_print_event(trace_event->tep, s, record, "%s ", TEP_PRINT_NAME);
+	else
+		trace_seq_printf(s, "error ");
+
+	if (config_has_id) {
+		if (missing_id)
+			/* placeholder if we are dealing with a mixed-type container*/
+			trace_seq_printf(s, "        ");
+		else
+			trace_seq_printf(s, "%8llu ", id);
+	}
 
 	state = tep_get_field_raw(s, trace_event, "state", record, &val, 0);
 	event = tep_get_field_raw(s, trace_event, "event", record, &val, 0);
@@ -421,6 +501,64 @@ ikm_error_handler(struct trace_seq *s, struct tep_record *record,
 	return 0;
 }
 
+static int ikm_enable_trace_events(char *monitor_name, struct trace_instance *inst)
+{
+	char event[MAX_DA_NAME_LEN + 7]; /* max(error_,event_) + '0' = 7 */
+	int retval;
+
+	snprintf(event, sizeof(event), "event_%s", monitor_name);
+	retval = tracefs_event_enable(inst->inst, "rv",  event);
+	if (retval)
+		return -1;
+
+	tep_register_event_handler(inst->tep, -1, "rv", event,
+				   ikm_event_handler, NULL);
+
+	snprintf(event, sizeof(event), "error_%s", monitor_name);
+	retval = tracefs_event_enable(inst->inst, "rv", event);
+	if (retval)
+		return -1;
+
+	tep_register_event_handler(inst->tep, -1, "rv", event,
+				   ikm_error_handler, NULL);
+
+	/* set if at least 1 monitor has id in case of a container */
+	config_has_id = ikm_has_id(monitor_name);
+	if (config_has_id < 0)
+		return -1;
+
+
+	return 0;
+}
+
+static int ikm_enable_trace_container(char *monitor_name,
+				      struct trace_instance *inst)
+{
+	DIR *dp;
+	char *abs_path, rv_path[MAX_PATH];
+	struct dirent *ep;
+	int retval = 0;
+
+	snprintf(rv_path, MAX_PATH, "rv/monitors/%s", monitor_name);
+	abs_path = tracefs_instance_get_file(NULL, rv_path);
+	if (!abs_path)
+		return -1;
+	dp = opendir(abs_path);
+	if (!dp)
+		goto out_free;
+
+	while (!retval && (ep = readdir(dp))) {
+		if (ep->d_type != DT_DIR || ep->d_name[0] == '.')
+			continue;
+		retval = ikm_enable_trace_events(ep->d_name, inst);
+	}
+
+	closedir(dp);
+out_free:
+	free(abs_path);
+	return retval;
+}
+
 /*
  * ikm_setup_trace_instance - set up a tracing instance to collect data
  *
@@ -430,19 +568,12 @@ ikm_error_handler(struct trace_seq *s, struct tep_record *record,
  */
 static struct trace_instance *ikm_setup_trace_instance(char *monitor_name)
 {
-	char event[MAX_DA_NAME_LEN + 7]; /* max(error_,event_) + '0' = 7 */
 	struct trace_instance *inst;
 	int retval;
 
 	if (!config_trace)
 		return NULL;
 
-	config_has_id = ikm_has_id(monitor_name);
-	if (config_has_id < 0) {
-		err_msg("ikm: failed to read monitor %s event format\n", monitor_name);
-		goto out_err;
-	}
-
 	/* alloc data */
 	inst = calloc(1, sizeof(*inst));
 	if (!inst) {
@@ -454,23 +585,13 @@ static struct trace_instance *ikm_setup_trace_instance(char *monitor_name)
 	if (retval)
 		goto out_free;
 
-	/* enable events */
-	snprintf(event, sizeof(event), "event_%s", monitor_name);
-	retval = tracefs_event_enable(inst->inst, "rv",  event);
-	if (retval)
-		goto out_inst;
-
-	tep_register_event_handler(inst->tep, -1, "rv", event,
-				   ikm_event_handler, NULL);
-
-	snprintf(event, sizeof(event), "error_%s", monitor_name);
-	retval = tracefs_event_enable(inst->inst, "rv", event);
+	if (config_is_container)
+		retval = ikm_enable_trace_container(monitor_name, inst);
+	else
+		retval = ikm_enable_trace_events(monitor_name, inst);
 	if (retval)
 		goto out_inst;
 
-	tep_register_event_handler(inst->tep, -1, "rv", event,
-				   ikm_error_handler, NULL);
-
 	/* ready to enable */
 	tracefs_trace_on(inst->inst);
 
@@ -633,32 +754,41 @@ static int parse_arguments(char *monitor_name, int argc, char **argv)
 int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 {
 	struct trace_instance *inst = NULL;
+	char *nested_name, full_name[2*MAX_DA_NAME_LEN];
 	int retval;
 
-	/*
-	 * Check if monitor exists by seeing it is enabled.
-	 */
-	retval = __ikm_read_enable(monitor_name);
-	if (retval < 0)
+	nested_name = strstr(monitor_name, ":");
+	if (nested_name)
+		++nested_name;
+	else
+		nested_name = monitor_name;
+
+	retval = __ikm_find_monitor_name(monitor_name, full_name);
+	if (!retval)
 		return 0;
+	if (retval < 0) {
+		err_msg("ikm: error finding monitor %s\n", nested_name);
+		return -1;
+	}
 
+	retval = __ikm_read_enable(full_name);
 	if (retval) {
-		err_msg("ikm: monitor %s (in-kernel) is already enabled\n", monitor_name);
+		err_msg("ikm: monitor %s (in-kernel) is already enabled\n", nested_name);
 		return -1;
 	}
 
 	/* we should be good to go */
-	retval = parse_arguments(monitor_name, argc, argv);
+	retval = parse_arguments(full_name, argc, argv);
 	if (retval)
-		ikm_usage(1, monitor_name, "ikm: failed parsing arguments");
+		ikm_usage(1, nested_name, "ikm: failed parsing arguments");
 
 	if (config_trace) {
-		inst = ikm_setup_trace_instance(monitor_name);
+		inst = ikm_setup_trace_instance(nested_name);
 		if (!inst)
 			return -1;
 	}
 
-	retval = ikm_enable(monitor_name);
+	retval = ikm_enable(full_name);
 	if (retval < 0)
 		goto out_free_instance;
 
@@ -682,17 +812,17 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 		sleep(1);
 	}
 
-	ikm_disable(monitor_name);
+	ikm_disable(full_name);
 	ikm_destroy_trace_instance(inst);
 
 	if (config_reactor && config_initial_reactor)
-		ikm_write_reactor(monitor_name, config_initial_reactor);
+		ikm_write_reactor(full_name, config_initial_reactor);
 
 	return 1;
 
 out_free_instance:
 	ikm_destroy_trace_instance(inst);
 	if (config_reactor && config_initial_reactor)
-		ikm_write_reactor(monitor_name, config_initial_reactor);
+		ikm_write_reactor(full_name, config_initial_reactor);
 	return -1;
 }
-- 
2.47.2



