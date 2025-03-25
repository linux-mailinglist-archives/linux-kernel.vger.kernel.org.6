Return-Path: <linux-kernel+bounces-575541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 363D1A703D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373C418900BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579CA25D525;
	Tue, 25 Mar 2025 14:34:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133525B668
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913259; cv=none; b=Q+s9pPxrPCFYoifWm+weopWxgmMGq4iEvPptWDJttoL0NAmHfWxQ1D4dmXDILvpwanQCrKc7D3XvWLpXlUXiQtMAU6MKzPmtpSsiQh09ipgyGWD8Qh3aTZEwUoTjft7FTkIUfl33WSKCk1vV8dQ9xtW5NOXsrEqSqAqqhVoJUDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913259; c=relaxed/simple;
	bh=CryzNEnxPBRHXq02oYSPUJ0eUX222lqvKXI2gty0v4w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=K/0IiPLEjSORvB7xJuVat94YLsSl6dAQXFo7ES3rExUJZJyliPg1kRp4Fk8nZ3mrrXs4IDIBvEhx6SQAJQv+o4oyFlwvBpNXe/JcOW9xzckM+nm27Gv7knOpKO/zK/3Y/+RuQydT/szDCEU/M6K6H1XY6rd8sKPHqbdVvqNilug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD11C4CEF1;
	Tue, 25 Mar 2025 14:34:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tx5Mt-00000002P2p-1xW6;
	Tue, 25 Mar 2025 10:35:03 -0400
Message-ID: <20250325143503.318376722@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 10:34:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 9/9] tools/rv: Allow rv list to filter for container
References: <20250325143436.168114339@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

Add possibility to supply the container name to rv list:

  # rv list sched
  mon1
  mon2
  mon3

This lists only monitors in sched, without indentation.
Supplying -h, any option (string starting with -) or more than 1
argument will still print the usage.
Passing a non-existent container prints nothing and passing no container
continues to print all monitors, showing indentation for nested
monitors, reported after their container.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/20250305140406.350227-10-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rv/include/in_kernel.h |  2 +-
 tools/verification/rv/src/in_kernel.c     | 36 +++++++++++++++------
 tools/verification/rv/src/rv.c            | 38 +++++++++++++++--------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/tools/verification/rv/include/in_kernel.h b/tools/verification/rv/include/in_kernel.h
index 3090638c8d71..f3bfd3b9895f 100644
--- a/tools/verification/rv/include/in_kernel.h
+++ b/tools/verification/rv/include/in_kernel.h
@@ -1,3 +1,3 @@
 // SPDX-License-Identifier: GPL-2.0
-int ikm_list_monitors(void);
+int ikm_list_monitors(char *container);
 int ikm_run_monitor(char *monitor, int argc, char **argv);
diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 032b85101929..c0dcee795c0d 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -180,19 +180,25 @@ static char *ikm_read_desc(char *monitor_name)
 /*
  * ikm_fill_monitor_definition - fill monitor's definition
  *
- * Returns -1 on error, 0 otherwise.
+ * Returns -1 on error, 1 if the monitor does not belong in the container, 0 otherwise.
+ * container can be NULL
  */
-static int ikm_fill_monitor_definition(char *name, struct monitor *ikm)
+static int ikm_fill_monitor_definition(char *name, struct monitor *ikm, char *container)
 {
 	int enabled;
 	char *desc, *nested_name;
 
 	nested_name = strstr(name, ":");
 	if (nested_name) {
+		/* it belongs in container if it starts with "container:" */
+		if (container && strstr(name, container) != name)
+			return 1;
 		*nested_name = '/';
 		++nested_name;
 		ikm->nested = 1;
 	} else {
+		if (container)
+			return 1;
 		nested_name = name;
 		ikm->nested = 0;
 	}
@@ -328,12 +334,12 @@ static int ikm_has_id(char *monitor_name)
  *
  * Returns 0 on success, -1 otherwise.
  */
-int ikm_list_monitors(void)
+int ikm_list_monitors(char *container)
 {
 	char *available_monitors;
 	struct monitor ikm = {0};
 	char *curr, *next;
-	int retval;
+	int retval, list_monitor = 0;
 
 	available_monitors = tracefs_instance_file_read(NULL, "rv/available_monitors", NULL);
 
@@ -347,17 +353,29 @@ int ikm_list_monitors(void)
 		next = strstr(curr, "\n");
 		*next = '\0';
 
-		retval = ikm_fill_monitor_definition(curr, &ikm);
-		if (retval)
+		retval = ikm_fill_monitor_definition(curr, &ikm, container);
+		if (retval < 0)
 			err_msg("ikm: error reading %d in kernel monitor, skipping\n", curr);
 
-		printf("%s%-*s %s %s\n", ikm.nested ? " - " : "",
-		       ikm.nested ? MAX_DA_NAME_LEN - 3 : MAX_DA_NAME_LEN,
-		       ikm.name, ikm.desc, ikm.enabled ? "[ON]" : "[OFF]");
+		if (!retval) {
+			int indent = ikm.nested && !container;
+
+			list_monitor = 1;
+			printf("%s%-*s %s %s\n", indent ? " - " : "",
+			       indent ? MAX_DA_NAME_LEN - 3 : MAX_DA_NAME_LEN,
+			       ikm.name, ikm.desc, ikm.enabled ? "[ON]" : "[OFF]");
+		}
 		curr = ++next;
 
 	} while (strlen(curr));
 
+	if (!list_monitor) {
+		if (container)
+			printf("-- No monitor found in container %s --\n", container);
+		else
+			printf("-- No monitor found --\n");
+	}
+
 	free(available_monitors);
 
 	return 0;
diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index 1ddb85532816..239de054d1e0 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -41,30 +41,42 @@ static void rv_list(int argc, char **argv)
 {
 	static const char *const usage[] = {
 		"",
-		"  usage: rv list [-h]",
+		"  usage: rv list [-h] [container]",
 		"",
 		"	list all available monitors",
 		"",
 		"	-h/--help: print this menu",
+		"",
+		"	[container]: list only monitors in this container",
 		NULL,
 	};
-	int i;
-
-	if (argc > 1) {
+	int i, print_help = 0, retval = 0;
+	char *container = NULL;
+
+	if (argc == 2) {
+		if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help")) {
+			print_help = 1;
+			retval = 0;
+		} else if (argv[1][0] == '-') {
+			/* assume invalid option */
+			print_help = 1;
+			retval = 1;
+		} else
+			container = argv[1];
+	} else if (argc > 2) {
+		/* more than 2 is always usage */
+		print_help = 1;
+		retval = 1;
+	}
+	if (print_help) {
 		fprintf(stderr, "rv version %s\n", VERSION);
-
-		/* more than 1 is always usage */
 		for (i = 0; usage[i]; i++)
 			fprintf(stderr, "%s\n", usage[i]);
-
-		/* but only -h is valid */
-		if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
-			exit(0);
-		else
-			exit(1);
+		exit(retval);
 	}
 
-	ikm_list_monitors();
+	ikm_list_monitors(container);
+
 	exit(0);
 }
 
-- 
2.47.2



