Return-Path: <linux-kernel+bounces-549628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F3A554B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066277A7142
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C412D272939;
	Thu,  6 Mar 2025 18:18:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9BB26AA99
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285105; cv=none; b=SgjnX6yZ4HsnaC4ALIwzdcbM/5e99rpEnpZ3UqOdVPkf6Buv7N9kJHIUTkXcjlhWnPvvYDZnqS8cXWdvIndCpE8L+qPmqWAb0DIoU+CFyt+G6/Vyu7FcpnqHDnvkyCg3hCMV0Api2RqN9wNE6nM6e1RMTyRG/jj1uLIC7JAvFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285105; c=relaxed/simple;
	bh=Rw6Z1zX/mW/v2FDBY1/DP0sxiF95fJOj3jZf3szi18Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=R6m558ujgzLV5KvUP7qjDgecR2bnHsT91C1Si9dwJaEtgxA4UuYQjmWOIuuuI9wEvUbLp/eA4D21TBzteMRdPWeWUvfzRUUOX7jgH4yIGy/uzadI6c6609FRis0uQhXb1CyI+PdsSLU/l7k9uKIBJvFB2RkOqkBeEm1VV1DrRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7853C4CEE0;
	Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqFne-00000000PI7-1w8f;
	Thu, 06 Mar 2025 13:18:26 -0500
Message-ID: <20250306181826.317093224@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 13:18:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Clark Williams <williams@redhat.com>
Subject: [for-next][PATCH 06/10] rtla/timerlat_top: Move divisor to update
References: <20250306181801.485766945@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Unlike timerlat-hist, timerlat-top applies the output divisor used to
set ns/us mode when printing results instead of applying it when
collecting the samples.

Move the application of the divisor from timerlat_top_print into
timerlat_top_update to make it consistent with timerlat-hist.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Link: https://lore.kernel.org/20250218145859.27762-7-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 54 +++++++++++++--------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 97eead91decc..a3d9e8f67a4f 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -127,9 +127,13 @@ timerlat_top_update(struct osnoise_tool *tool, int cpu,
 		    unsigned long long thread,
 		    unsigned long long latency)
 {
+	struct timerlat_params *params = tool->params;
 	struct timerlat_top_data *data = tool->data;
 	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
 
+	if (params->output_divisor)
+		latency = latency / params->output_divisor;
+
 	if (!thread) {
 		cpu_data->irq_count++;
 		cpu_data->cur_irq = latency;
@@ -231,12 +235,8 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 	struct timerlat_params *params = top->params;
 	struct timerlat_top_data *data = top->data;
 	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
-	int divisor = params->output_divisor;
 	struct trace_seq *s = top->trace.seq;
 
-	if (divisor == 0)
-		return;
-
 	/*
 	 * Skip if no data is available: is this cpu offline?
 	 */
@@ -251,20 +251,20 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 	if (!cpu_data->irq_count) {
 		trace_seq_printf(s, "%s %s %s %s |", no_value, no_value, no_value, no_value);
 	} else {
-		trace_seq_printf(s, "%9llu ", cpu_data->cur_irq / params->output_divisor);
-		trace_seq_printf(s, "%9llu ", cpu_data->min_irq / params->output_divisor);
-		trace_seq_printf(s, "%9llu ", (cpu_data->sum_irq / cpu_data->irq_count) / divisor);
-		trace_seq_printf(s, "%9llu |", cpu_data->max_irq / divisor);
+		trace_seq_printf(s, "%9llu ", cpu_data->cur_irq);
+		trace_seq_printf(s, "%9llu ", cpu_data->min_irq);
+		trace_seq_printf(s, "%9llu ", cpu_data->sum_irq / cpu_data->irq_count);
+		trace_seq_printf(s, "%9llu |", cpu_data->max_irq);
 	}
 
 	if (!cpu_data->thread_count) {
 		trace_seq_printf(s, "%s %s %s %s", no_value, no_value, no_value, no_value);
 	} else {
-		trace_seq_printf(s, "%9llu ", cpu_data->cur_thread / divisor);
-		trace_seq_printf(s, "%9llu ", cpu_data->min_thread / divisor);
+		trace_seq_printf(s, "%9llu ", cpu_data->cur_thread);
+		trace_seq_printf(s, "%9llu ", cpu_data->min_thread);
 		trace_seq_printf(s, "%9llu ",
-				(cpu_data->sum_thread / cpu_data->thread_count) / divisor);
-		trace_seq_printf(s, "%9llu", cpu_data->max_thread / divisor);
+				cpu_data->sum_thread / cpu_data->thread_count);
+		trace_seq_printf(s, "%9llu", cpu_data->max_thread);
 	}
 
 	if (!params->user_top) {
@@ -277,11 +277,11 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 	if (!cpu_data->user_count) {
 		trace_seq_printf(s, "%s %s %s %s\n", no_value, no_value, no_value, no_value);
 	} else {
-		trace_seq_printf(s, "%9llu ", cpu_data->cur_user / divisor);
-		trace_seq_printf(s, "%9llu ", cpu_data->min_user / divisor);
+		trace_seq_printf(s, "%9llu ", cpu_data->cur_user);
+		trace_seq_printf(s, "%9llu ", cpu_data->min_user);
 		trace_seq_printf(s, "%9llu ",
-				(cpu_data->sum_user / cpu_data->user_count) / divisor);
-		trace_seq_printf(s, "%9llu\n", cpu_data->max_user / divisor);
+				cpu_data->sum_user / cpu_data->user_count);
+		trace_seq_printf(s, "%9llu\n", cpu_data->max_user);
 	}
 }
 
@@ -294,13 +294,9 @@ timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summar
 	const char *split = "----------------------------------------";
 	struct timerlat_params *params = top->params;
 	unsigned long long count = summary->irq_count;
-	int divisor = params->output_divisor;
 	struct trace_seq *s = top->trace.seq;
 	int e = 0;
 
-	if (divisor == 0)
-		return;
-
 	/*
 	 * Skip if no data is available: is this cpu offline?
 	 */
@@ -323,19 +319,19 @@ timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summar
 		trace_seq_printf(s, "          %s %s %s |", no_value, no_value, no_value);
 	} else {
 		trace_seq_printf(s, "          ");
-		trace_seq_printf(s, "%9llu ", summary->min_irq / params->output_divisor);
-		trace_seq_printf(s, "%9llu ", (summary->sum_irq / summary->irq_count) / divisor);
-		trace_seq_printf(s, "%9llu |", summary->max_irq / divisor);
+		trace_seq_printf(s, "%9llu ", summary->min_irq);
+		trace_seq_printf(s, "%9llu ", summary->sum_irq / summary->irq_count);
+		trace_seq_printf(s, "%9llu |", summary->max_irq);
 	}
 
 	if (!summary->thread_count) {
 		trace_seq_printf(s, "%s %s %s %s", no_value, no_value, no_value, no_value);
 	} else {
 		trace_seq_printf(s, "          ");
-		trace_seq_printf(s, "%9llu ", summary->min_thread / divisor);
+		trace_seq_printf(s, "%9llu ", summary->min_thread);
 		trace_seq_printf(s, "%9llu ",
-				(summary->sum_thread / summary->thread_count) / divisor);
-		trace_seq_printf(s, "%9llu", summary->max_thread / divisor);
+				summary->sum_thread / summary->thread_count);
+		trace_seq_printf(s, "%9llu", summary->max_thread);
 	}
 
 	if (!params->user_top) {
@@ -349,10 +345,10 @@ timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summar
 		trace_seq_printf(s, "          %s %s %s |", no_value, no_value, no_value);
 	} else {
 		trace_seq_printf(s, "          ");
-		trace_seq_printf(s, "%9llu ", summary->min_user / divisor);
+		trace_seq_printf(s, "%9llu ", summary->min_user);
 		trace_seq_printf(s, "%9llu ",
-				(summary->sum_user / summary->user_count) / divisor);
-		trace_seq_printf(s, "%9llu\n", summary->max_user / divisor);
+				summary->sum_user / summary->user_count);
+		trace_seq_printf(s, "%9llu\n", summary->max_user);
 	}
 }
 
-- 
2.47.2



