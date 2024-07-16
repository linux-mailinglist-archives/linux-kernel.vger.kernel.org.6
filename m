Return-Path: <linux-kernel+bounces-254419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA029332FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9B61C226A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2319FA8F;
	Tue, 16 Jul 2024 20:35:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC34335A7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162146; cv=none; b=Z2siIwtRTzdGV1hvo53qfgLfxJ1I6VvQbnBBqYBEWMv40AAWse90Nkopdw3dlyo53oUH2hdzJTlxSVbw0+ljC06JX6P2WK7g7TUy7qF68dx6CoMt0u3Wf6PjBhexjLWzA7m+QqW18aRehCfewGu8eH6AsTo0BQ7DZr1pfPp40qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162146; c=relaxed/simple;
	bh=f6klj0ZlyFqH8i6nKE3ulFuf/7lkXIbkgAbDQGQJbmM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n7mv8UC9xsJ5tbN0K7ERvCs458/5VkYylWBZqVuc2BpWTT2oVHUFFbnjeYHnYQvPWtD/VZ3OnhvjFsqV9Ru9TZER3hOJfadyssltj8mnWEKp+nBbKuJDmCZHGvVO4bq8h/Hw6x0Jy5YEjGmXj+OTnI+g9VR//x2JHKrY+8folDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D625C116B1;
	Tue, 16 Jul 2024 20:35:44 +0000 (UTC)
Date: Tue, 16 Jul 2024 16:35:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Wagner <dwagner@suse.de>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [GIT PULL] tracing/tools: Minor updates for 6.11
Message-ID: <20240716163543.038d461b@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

tracing/tools: Trivial updates for 6.11

- Use pretty formatting only on interactive tty in rtla/osnoise

- Better reporting when histogram is empty in rtla/osnoise

- Use the correct library name for "libtracefs" in feature detection

This has the last updates from Daniel Bristot's repository.

Please pull the latest trace-tools-v6.11 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-tools-v6.11

Tag SHA1: 1fea7fbe8848853afc0694bde17612f78265157e
Head SHA1: 28beb730ee167e505c86d1a8ae239e97d0136b13


Daniel Wagner (1):
      tools: build: use correct lib name for libtracefs feature detection

Luis Claudio R. Goncalves (2):
      rtla/osnoise: Use pretty formatting only on interactive tty
      rtla/osnoise: Better report when histogram is empty

----
 tools/build/feature/Makefile          |  2 +-
 tools/build/feature/test-libtracefs.c |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c | 15 +++++++++++++++
 tools/tracing/rtla/src/osnoise_top.c  | 19 +++++++++++++++----
 4 files changed, 32 insertions(+), 6 deletions(-)
---------------------------
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index ed54cef450f5..489cbed7e82a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -213,7 +213,7 @@ $(OUTPUT)test-libtraceevent.bin:
 	$(BUILD) -ltraceevent
 
 $(OUTPUT)test-libtracefs.bin:
-	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtraceevent 2>/dev/null) -ltracefs
+	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
 
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
diff --git a/tools/build/feature/test-libtracefs.c b/tools/build/feature/test-libtracefs.c
index 8eff16c0c10b..29a757a7d848 100644
--- a/tools/build/feature/test-libtracefs.c
+++ b/tools/build/feature/test-libtracefs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <tracefs/tracefs.h>
+#include <tracefs.h>
 
 int main(void)
 {
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 7be17d09f7e8..214e2c93fde0 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -374,6 +374,7 @@ osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *too
 {
 	struct osnoise_hist_data *data = tool->data;
 	struct trace_instance *trace = &tool->trace;
+	int has_samples = 0;
 	int bucket, cpu;
 	int total;
 
@@ -402,11 +403,25 @@ osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *too
 			continue;
 		}
 
+		/* There are samples above the threshold */
+		has_samples = 1;
 		trace_seq_printf(trace->seq, "\n");
 		trace_seq_do_printf(trace->seq);
 		trace_seq_reset(trace->seq);
 	}
 
+	/*
+	 * If no samples were recorded, skip calculations, print zeroed statistics
+	 * and return.
+	 */
+	if (!has_samples) {
+		trace_seq_reset(trace->seq);
+		trace_seq_printf(trace->seq, "over: 0\ncount: 0\nmin: 0\navg: 0\nmax: 0\n");
+		trace_seq_do_printf(trace->seq);
+		trace_seq_reset(trace->seq);
+		return;
+	}
+
 	if (!params->no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 07ba55d4ec06..f594a44df840 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -42,6 +42,7 @@ struct osnoise_top_params {
 	int			hk_cpus;
 	int			warmup;
 	int			buffer_size;
+	int			pretty_output;
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
@@ -163,7 +164,9 @@ static void osnoise_top_header(struct osnoise_tool *top)
 
 	get_duration(top->start_time, duration, sizeof(duration));
 
-	trace_seq_printf(s, "\033[2;37;40m");
+	if (params->pretty_output)
+		trace_seq_printf(s, "\033[2;37;40m");
+
 	trace_seq_printf(s, "                                          ");
 
 	if (params->mode == MODE_OSNOISE) {
@@ -174,12 +177,16 @@ static void osnoise_top_header(struct osnoise_tool *top)
 	}
 
 	trace_seq_printf(s, "                                   ");
-	trace_seq_printf(s, "\033[0;0;0m");
+
+	if (params->pretty_output)
+		trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 
 	trace_seq_printf(s, "duration: %9s | time is in us\n", duration);
 
-	trace_seq_printf(s, "\033[2;30;47m");
+	if (params->pretty_output)
+		trace_seq_printf(s, "\033[2;30;47m");
+
 	trace_seq_printf(s, "CPU Period       Runtime ");
 	trace_seq_printf(s, "       Noise ");
 	trace_seq_printf(s, " %% CPU Aval ");
@@ -192,7 +199,8 @@ static void osnoise_top_header(struct osnoise_tool *top)
 	trace_seq_printf(s, "          IRQ      Softirq       Thread");
 
 eol:
-	trace_seq_printf(s, "\033[0;0;0m");
+	if (params->pretty_output)
+		trace_seq_printf(s, "\033[0;0;0m");
 	trace_seq_printf(s, "\n");
 }
 
@@ -619,6 +627,9 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
+	if (isatty(1) && !params->quiet)
+		params->pretty_output = 1;
+
 	return 0;
 
 out_err:

