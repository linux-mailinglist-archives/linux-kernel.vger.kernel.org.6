Return-Path: <linux-kernel+bounces-288309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5C99538A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0161C23D15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F891BB6B0;
	Thu, 15 Aug 2024 16:57:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BED1BB680
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741076; cv=none; b=kut7+cwYS9TyCk0tuM2Sl6/hZVONnzUzg9h3RsDfMbwOVtF37u6BQtLacmz71s2gzmP45fWYgOVcyZUXJDgNgtjHjMvvd3sa5I8uQfxCt6v/eut2AQZeLdH78T5B5BhQLT9DE1pLgyGobecddOyzH9bKEubbHh4m5ZV3e04us6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741076; c=relaxed/simple;
	bh=hjjExUGKchfhZrxg4MOWggq8zOIerXFFEgT6Ij+pA60=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ql9EQc/bSr+Dn/MHcYj+nLgwyGq6yxE4yyc3Iou/5/6xLM3u0OgQ93DrhaH4XKkIXn1zSZJDNzaZCl90RtQODtSS+Cdfd67Adrhi1HyNuKeEkBlmEvJIbVz9erPbsT2R/xSsuyKAFAa1V5Icuyv8b+dfnibrZIYJCGf8XTWIabU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E958C4AF09;
	Thu, 15 Aug 2024 16:57:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sedng-00000001uL0-0UHU;
	Thu, 15 Aug 2024 12:58:12 -0400
Message-ID: <20240815165811.972621103@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 15 Aug 2024 12:57:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@kernel.org>
Subject: [for-next][PATCH 1/3] tracing: Fix ifdef of snapshots to not prevent last_boot_info file
References: <20240815165744.699054530@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The mapping of the ring buffer to memory allocated at boot up will also
expose a "last_boot_info" to help tooling to read the raw data from the
last boot. As instances that have their ring buffer mapped to fixed
memory cannot perform snapshots, they can either have the "snapshot" file
or the "last_boot_info" file, but not both.

The code that added the "last_boot_info" file failed to notice that the
"snapshot" creation was inside a "#ifdef CONFIG_TRACER_SNAPSHOT" and
incorrectly placed the creation of the "last_boot_info" file within the
ifdef block. Not only does it cause a warning when CONFIG_TRACER_SNAPSHOT
is not enabled, it also incorrectly prevents the file from appearing.

Link: https://lore.kernel.org/all/20240719102640.718554-1-arnd@kernel.org/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Arnd Bergmann <arnd@kernel.org>
Link: https://lore.kernel.org/20240719101312.3d4ac707@rorschach.local.home
Fixes: 7a1d1e4b9639 ("tracing/ring-buffer: Add last_boot_info file to boot instance")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d0af984a5337..8e5a4ca9fd70 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9828,15 +9828,15 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
 
-#ifdef CONFIG_TRACER_SNAPSHOT
 	if (tr->range_addr_start) {
 		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
 				  tr, &last_boot_fops);
+#ifdef CONFIG_TRACER_SNAPSHOT
 	} else {
 		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
 				  tr, &snapshot_fops);
-	}
 #endif
+	}
 
 	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_err_log_fops);
-- 
2.43.0



