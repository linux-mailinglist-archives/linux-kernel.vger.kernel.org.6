Return-Path: <linux-kernel+bounces-208230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1289022A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5458D1C20866
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE96B74048;
	Mon, 10 Jun 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjQSpkEG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909C7E0E8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025939; cv=none; b=pYC6hy2XLgnwOlrIER/jvGzJpEhRWWkCl08g9Kn8tT9ensQQa3ptQ9yCZZN+GI8VQIh0bA4dqs2UXSJBrEey4lrxrWL8+wQOJvsRGXt5u/d4V6A98awptnIjBX9fUaiAgICjPpAbd6QUffluxTLkheWkh+kfRarplzjrkMG9FMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025939; c=relaxed/simple;
	bh=Ah9a8Efx4wEnL7RAaVShaay27q/GZtk7dGv4xhEN3ao=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nUTbAkwnraDNr1/BO2uggFlc2ZMjSHtZDjTXsYLbUE6und/u67aHMyTecZVcSC9vUWJS8GXl8ZwtEdVD2UbwcsTehif9nrVge2w+G4xo+G4dCDeQcDF7EOXxC8VsdDYCdinlqbUWkAwnlHhDVBkD38dbWXF6SWwR3Y8NSTJB48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjQSpkEG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718025936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=t92VNX+/8V2N5xX4LSaFwU8u1lEMvFbI4ck5ZnHCQ50=;
	b=CjQSpkEGfe1fiGb0TpZKiCs+z3PyGAfR2VIvhPGgD68wCIGy0CUACoZe7H3hK47M0+dP2l
	V0EfQEM9tkA6vWRcHNImKQpwbo/qfkc3FBZTxcs8/pbzdX76mPRJ0jRVxuJBbWtw7MH9mh
	XtizXZNl4MjheSUn0PpWtdnNnSN9PQk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-hA4nFa50PpKfrt3JzmN-_Q-1; Mon,
 10 Jun 2024 09:25:31 -0400
X-MC-Unique: hA4nFa50PpKfrt3JzmN-_Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B4B619560BB;
	Mon, 10 Jun 2024 13:25:30 +0000 (UTC)
Received: from localhost (unknown [10.22.8.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B733719560AB;
	Mon, 10 Jun 2024 13:25:29 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:25:28 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] rtla/osnoise: Use pretty formatting only on interactive
 tty
Message-ID: <Zmb-yP_3EDHliI8Z@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

osnoise top performs background/font color formatting that could make
the text output confusing if not on a terminal. Use the changes from
commit f5c0cdad6684a ("rtla/timerlat: Use pretty formatting only on
interactive tty") as an inspiration to fix this problem.

Apply the formatting only if running on a tty, and not in quiet mode.

Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Reviewed-by: John Kacur <jkacur@redhat.com>
Reviewed-by: Clark Williams <williams@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 tools/tracing/rtla/src/osnoise_top.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 07ba55d4ec06f..d539fade99d48 100644
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
-- 
2.45.2


