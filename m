Return-Path: <linux-kernel+bounces-289846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282DB954C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543171C22DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C521BC9F4;
	Fri, 16 Aug 2024 14:22:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925E85270
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818169; cv=none; b=EJKM9nxMwupf2CS38uZOTXR1MNauY+cI+W9DBaEcp4U97InbEvBedDu/aAu4bOJt67Qz2Tpsq60agvBZB/2DM4YIqeTi4ibw8zR77BRvjJzaoDf4LL1m7pl1Uy3B2J95Dt0ZtEB+tVRfSi3b3aftlNfS0EqmpqUsZHZ5d5UkYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818169; c=relaxed/simple;
	bh=Vj54shtRufRW3DLPISndHouxt9LezGxwGgq28GofPds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OzLM6U6wzIbukI8oY4G50grKLP5nXm0yYUaNrjDlK2BOH6zmFi2VPusGomAwcHISFyBXci2pGc1hvQsaCmq+9mcw5cyIEh6CacJecjC6ndpmbGA6e0EG6RVBzbXpJE3OWt+uQDXieHrzIE9Nz2pLcpdMV0ECQkQkB3brluMpjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E85FC32782;
	Fri, 16 Aug 2024 14:22:47 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:23:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 John Kacur <jkacur@redhat.com>, Juri Lelli <juri.lelli@gmail.com>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: [GIT PULL] tracing: Fixes in RTLA tool and reading the ring buffer
Message-ID: <20240816102305.08d91865@gandalf.local.home>
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

A couple of fixes for tracing:

- Prevent a NULL pointer dereference in the error path of RTLA tool

- Fix an infinite loop bug when reading from the ring buffer when closed.
  If there's a thread trying to read the ring buffer and it gets closed
  by another thread, the one reading will go into an infinite loop
  when the buffer is empty instead of exiting back to user space.


Please pull the latest trace-v6.11-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.11-rc3

Tag SHA1: 436b8a891cd73d07847c86cd55ff7f8f17f47dfe
Head SHA1: 90574d2a675947858b47008df8d07f75ea50d0d0


Dan Carpenter (1):
      rtla/osnoise: Prevent NULL dereference in error handling

Steven Rostedt (1):
      tracing: Return from tracing_buffers_read() if the file has been closed

----
 kernel/trace/trace.c                 |  2 +-
 tools/tracing/rtla/src/osnoise_top.c | 11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)
---------------------------
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 10cd38bce2f1..ebe7ce2f5f4a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7956,7 +7956,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	trace_access_unlock(iter->cpu_file);
 
 	if (ret < 0) {
-		if (trace_empty(iter)) {
+		if (trace_empty(iter) && !iter->closed) {
 			if ((filp->f_flags & O_NONBLOCK))
 				return -EAGAIN;
 
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index f594a44df840..2f756628613d 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -651,8 +651,10 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
 		return NULL;
 
 	tool->data = osnoise_alloc_top(nr_cpus);
-	if (!tool->data)
-		goto out_err;
+	if (!tool->data) {
+		osnoise_destroy_tool(tool);
+		return NULL;
+	}
 
 	tool->params = params;
 
@@ -660,11 +662,6 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
 				   osnoise_top_handler, NULL);
 
 	return tool;
-
-out_err:
-	osnoise_free_top(tool->data);
-	osnoise_destroy_tool(tool);
-	return NULL;
 }
 
 static int stop_tracing;

