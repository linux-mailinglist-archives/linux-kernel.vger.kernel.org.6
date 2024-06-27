Return-Path: <linux-kernel+bounces-233017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D791B122
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B723AB22ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C881A0714;
	Thu, 27 Jun 2024 21:02:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCCA19AA5D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522124; cv=none; b=tvFvppSLAmybkYxwm2MBvjCWz1uBNpTbW8oh0X5GiOX+VJ+pphxMPOxc9MdvVxV7UeSkEU7QshnFqgqWkyDs2bdQHvAebzyepDKWHXH6fEpWTip3CL3jIjFHNn/h9ECcu5rPsLnFuw+rZSyVtxSNyGAkzMBvPGBLKTyTligGLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522124; c=relaxed/simple;
	bh=1tkTuwgRdTqCRUm9PPbyXU/b2nxuXiB8D2jFPWEFqd0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WaQb1Z8Kq+TckFKIdOe1iBloenkk+DzCaBRkEmeUaUlcFOa2Bp7duwXsHQXp5cpO82WP39L9VW0V4B+1aVtylB4xwJ5v9RdOBqcqZsM90x7VJVFvii/vmLFh2JyAMWRB/FOwOVo0XMGF948hm5IQN4iDWMvRjgHGwphl6Pbk0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D67C32789;
	Thu, 27 Jun 2024 21:02:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sMwGe-000000031k7-34gi;
	Thu, 27 Jun 2024 17:02:56 -0400
Message-ID: <20240627210256.595062681@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 27 Jun 2024 16:50:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 1/3] rtla/osnoise: Use pretty formatting only on interactive tty
References: <20240627205022.857212058@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>

osnoise top performs background/font color formatting that could make
the text output confusing if not on a terminal. Use the changes from
commit f5c0cdad6684a ("rtla/timerlat: Use pretty formatting only on
interactive tty") as an inspiration to fix this problem.

Apply the formatting only if running on a tty, and not in quiet mode.

Link: https://lkml.kernel.org/r/Zmb-yP_3EDHliI8Z@uudg.org

Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Reviewed-by: John Kacur <jkacur@redhat.com>
Reviewed-by: Clark Williams <williams@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/osnoise_top.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

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
-- 
2.43.0



