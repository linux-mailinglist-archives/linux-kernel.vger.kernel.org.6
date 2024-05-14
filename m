Return-Path: <linux-kernel+bounces-178940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF548C5996
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0331C21257
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9713817F37E;
	Tue, 14 May 2024 16:17:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56D17F36C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703427; cv=none; b=DsMNAk3jnQPbDaXmNSJsMdOqYrH0ylAytbiyDEAuNjm3WzXB2ixTXJLBgsWFbq6mz2P8K5nuHV5tAsOKwJOKGB7uUpv1xAQph7d8bcwdV/FzDhuSdzKljoYHeDyiTDGzsV8xgg0dMBSmKEVTiTtBpVseulM+OowlyobiPrRg7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703427; c=relaxed/simple;
	bh=iJERzLjJkxTqAUWnDXq2duAyH62ba6gQeg5N6A7qs8g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CjhX0Ypgn1GCZzIAvAd4DOPqgdRt6twNiLge6WeVZRMlUT12/6JbNAAIXNiU1C3sfekfGa7gjZyrdQh9xiXAVuhk3MLMyi12cZ/FH9eFT7F3zDuJ6VQ/o9Xz5f932Fg0hT085bciBdXOv2LZyY9fmb5h0rdwzFgOAE/FFv7puI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1148AC4AF08;
	Tue, 14 May 2024 16:17:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6uqJ-00000003tJe-3FPU;
	Tue, 14 May 2024 12:17:31 -0400
Message-ID: <20240514161731.642735808@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:17:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 1/2] tracing/user_events: Fix non-spaced field matching
References: <20240514161710.977621701@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Beau Belgrave <beaub@linux.microsoft.com>

When the ABI was updated to prevent same name w/different args, it
missed an important corner case when fields don't end with a space.
Typically, space is used for fields to help separate them, like
"u8 field1; u8 field2". If no spaces are used, like
"u8 field1;u8 field2", then the parsing works for the first time.
However, the match check fails on a subsequent register, leading to
confusion.

This is because the match check uses argv_split() and assumes that all
fields will be split upon the space. When spaces are used, we get back
{ "u8", "field1;" }, without spaces we get back { "u8", "field1;u8" }.
This causes a mismatch, and the user program gets back -EADDRINUSE.

Add a method to detect this case before calling argv_split(). If found
force a space after the field separator character ';'. This ensures all
cases work properly for matching.

With this fix, the following are all treated as matching:
u8 field1;u8 field2
u8 field1; u8 field2
u8 field1;\tu8 field2
u8 field1;\nu8 field2

Link: https://lore.kernel.org/linux-trace-kernel/20240423162338.292-2-beaub@linux.microsoft.com

Fixes: ba470eebc2f6 ("tracing/user_events: Prevent same name but different args event")
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 76 +++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 70d428c394b6..82b191f33a28 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1989,6 +1989,80 @@ static int user_event_set_tp_name(struct user_event *user)
 	return 0;
 }
 
+/*
+ * Counts how many ';' without a trailing space are in the args.
+ */
+static int count_semis_no_space(char *args)
+{
+	int count = 0;
+
+	while ((args = strchr(args, ';'))) {
+		args++;
+
+		if (!isspace(*args))
+			count++;
+	}
+
+	return count;
+}
+
+/*
+ * Copies the arguments while ensuring all ';' have a trailing space.
+ */
+static char *insert_space_after_semis(char *args, int count)
+{
+	char *fixed, *pos;
+	int len;
+
+	len = strlen(args) + count;
+	fixed = kmalloc(len + 1, GFP_KERNEL);
+
+	if (!fixed)
+		return NULL;
+
+	pos = fixed;
+
+	/* Insert a space after ';' if there is no trailing space. */
+	while (*args) {
+		*pos = *args++;
+
+		if (*pos++ == ';' && !isspace(*args))
+			*pos++ = ' ';
+	}
+
+	*pos = '\0';
+
+	return fixed;
+}
+
+static char **user_event_argv_split(char *args, int *argc)
+{
+	char **split;
+	char *fixed;
+	int count;
+
+	/* Count how many ';' without a trailing space */
+	count = count_semis_no_space(args);
+
+	/* No fixup is required */
+	if (!count)
+		return argv_split(GFP_KERNEL, args, argc);
+
+	/* We must fixup 'field;field' to 'field; field' */
+	fixed = insert_space_after_semis(args, count);
+
+	if (!fixed)
+		return NULL;
+
+	/* We do a normal split afterwards */
+	split = argv_split(GFP_KERNEL, fixed, argc);
+
+	/* We can free since argv_split makes a copy */
+	kfree(fixed);
+
+	return split;
+}
+
 /*
  * Parses the event name, arguments and flags then registers if successful.
  * The name buffer lifetime is owned by this method for success cases only.
@@ -2012,7 +2086,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 		return -EPERM;
 
 	if (args) {
-		argv = argv_split(GFP_KERNEL, args, &argc);
+		argv = user_event_argv_split(args, &argc);
 
 		if (!argv)
 			return -ENOMEM;
-- 
2.43.0



