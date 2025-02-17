Return-Path: <linux-kernel+bounces-517684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969BA38472
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC4A3B7019
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98112221D87;
	Mon, 17 Feb 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXSxppMK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9122069A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797997; cv=none; b=YkxzyScdp/Y0xELWcO6Vge0v/WiUXWedlaYx1ref2OAb8O4DiJBhvUleHpbVf75oGki/05sMu18/1eDzqzsWOBVRdDg68E/FuNG8VpzwrZD6SYwrx9pqruR0T7pPeKZJZ3uXa49aP9HADrZvoRNV81xc8D/qXHJitPLGqA5ROas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797997; c=relaxed/simple;
	bh=MFyJzG3kxv6rgiXk0F67ley3QB9Ga1PK84Oojs3YhRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCXS8sNKq+RXPhoW0EanmK5YxHKOV07vXaOWc3YJ4oTAtOHD/HUpKLI1wpDdRYXoMMlU6EMvke0Kl98RHwCYkdHulfM6al24suNzS8taZe/Db07/JQYJqOcczsFi9fcp7pFKTykKgbG0tetNWjehZiLOl1viHNrcyJxbDdAjBy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXSxppMK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739797995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnR6oqxI0UEcO9ewCzZls4ELgDlHtvYrPUmSJgsWcEQ=;
	b=WXSxppMKMyAVCGogenUPnmmhnfYqFVXOjzBVRvKRRrF5c3YOpHNeGbT55jT/dZ99toU/Ie
	IbL/sV8mbIi3SkDKSDZr2wQ5Fyuod0osXbxPrB/1p2VK83jXV5glRHZLw24a0j1b55blMI
	YQRDr+OuM96fXt1rDOThLagWbCKU9eM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-GKB3N3pYOjSaiNrql5xdJQ-1; Mon,
 17 Feb 2025 08:13:12 -0500
X-MC-Unique: GKB3N3pYOjSaiNrql5xdJQ-1
X-Mimecast-MFC-AGG-ID: GKB3N3pYOjSaiNrql5xdJQ_1739797991
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47B89180087F;
	Mon, 17 Feb 2025 13:13:11 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1C3B180035E;
	Mon, 17 Feb 2025 13:13:08 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 11/11] tools/rv: Allow rv list to filter for container
Date: Mon, 17 Feb 2025 14:12:02 +0100
Message-ID: <20250217131206.388485-12-gmonaco@redhat.com>
In-Reply-To: <20250217131206.388485-1-gmonaco@redhat.com>
References: <20250217131206.388485-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/include/in_kernel.h |  2 +-
 tools/verification/rv/src/in_kernel.c     | 36 +++++++++++++++------
 tools/verification/rv/src/rv.c            | 38 +++++++++++++++--------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/tools/verification/rv/include/in_kernel.h b/tools/verification/rv/include/in_kernel.h
index 3090638c8d710..f3bfd3b9895fe 100644
--- a/tools/verification/rv/include/in_kernel.h
+++ b/tools/verification/rv/include/in_kernel.h
@@ -1,3 +1,3 @@
 // SPDX-License-Identifier: GPL-2.0
-int ikm_list_monitors(void);
+int ikm_list_monitors(char *container);
 int ikm_run_monitor(char *monitor, int argc, char **argv);
diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 032b851019290..c0dcee795c0de 100644
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
index 1ddb855328165..239de054d1e06 100644
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
2.48.1


