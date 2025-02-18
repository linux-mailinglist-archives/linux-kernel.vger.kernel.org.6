Return-Path: <linux-kernel+bounces-519688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF37A3A0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D171723D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5889926D5C8;
	Tue, 18 Feb 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eghRKEYZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB426AA96
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890775; cv=none; b=pA9T/rsPGoCc+lVJv76ihXZF/d7lCrYb2yrVVjeOSJvAFdAJRvlaIjKlC/xOMQrxArXKWo8JLwScmg63k+U1kLVGOX0wC0bmLNmB1YJXXWdvDdzqCa1mDDnKIMiq3j80KJ/IGsmO/4mLDnT1w9qBcbKpPSeklvJrfS4WwBhMWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890775; c=relaxed/simple;
	bh=7uNRLTQ3uWkRnThODNQ0fc1z3GnmXe9tVNeGNklUfmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrTZmz6Kj5ckyUGdebpXKQjKdz55o4BNKL0KIJUgiCrIh3sJhI+VA2/HpycL5b1VvupPs3e/4/5HOdZU+ydqC4uha78KjfahSfF4Uqin/VR9flLC1IVV0dtWpaT/9Y35o7A3pPfWo3QcXjTW4v8vQsBqSPTMwOTm/LzLaUoKrlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eghRKEYZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/J80FVqXNQwlCdEIWRRbi6goB9rCCrTSPaR3g2A4nBM=;
	b=eghRKEYZmy3FltZ4HUlG18CQwc1B26mQbN+BYEqSquf96SOnnRe7Unfu0y3251fzQh/41T
	uOaanjZKWZp+75i+CaA+YViEI8E7i9ls8Tjo07R5ZG4g9WRM2wpJa8Apgn98G/yhLSgfJO
	4YJ9DadsZqQyqs2GMzyxqB5+snD13Pw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-szaUpkO-OV-lW4cdmk3lIg-1; Tue,
 18 Feb 2025 09:59:31 -0500
X-MC-Unique: szaUpkO-OV-lW4cdmk3lIg-1
X-Mimecast-MFC-AGG-ID: szaUpkO-OV-lW4cdmk3lIg_1739890770
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AB171800872;
	Tue, 18 Feb 2025 14:59:30 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25CD11800357;
	Tue, 18 Feb 2025 14:59:27 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6/8] rtla/timerlat_top: Move divisor to update
Date: Tue, 18 Feb 2025 15:58:57 +0100
Message-ID: <20250218145859.27762-7-tglozar@redhat.com>
In-Reply-To: <20250218145859.27762-1-tglozar@redhat.com>
References: <20250218145859.27762-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Unlike timerlat-hist, timerlat-top applies the output divisor used to
set ns/us mode when printing results instead of applying it when
collecting the samples.

Move the application of the divisor from timerlat_top_print into
timerlat_top_update to make it consistent with timerlat-hist.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
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
2.48.1


