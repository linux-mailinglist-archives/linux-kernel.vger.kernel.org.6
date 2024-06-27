Return-Path: <linux-kernel+bounces-233019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6C91B124
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC981C22255
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3391A08A1;
	Thu, 27 Jun 2024 21:02:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E719F488
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522124; cv=none; b=XJd/MO+9JzZDbkmeWUgTPvlluOLRP8Je5BC3Lvc0P5yshWILoEZNEbJ/OtBFkG96tewogRiOOARe1Rg4wJYw5qhab1H/bYRLqT36felhgTv4RFgudXvcFfm8EP8ofsgnW2VPIJU6Hy5zdcEuae5D/sGiJ/NN9JROPIBvLOWgHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522124; c=relaxed/simple;
	bh=fBHm2aJE5BQePO6xN6ulviz3Ck3xv58aqXPvq+k5j1o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nmDQoC9YYsrpEx9oi6S2m4xtaBw6p2dmHyAL7N/G9/gsVFFCdOW51zA2jrlYVI8DgVOYSKrHDnJ3WPhrYJjhl9RSPWfZLPg6k9+isGrLRMRMpOiSoe7dFrliBxgKGnpr2mAj/92TbQDIQcuZXXz1vKQ5ZzWTUGzzHBgM00If9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6602EC4AF07;
	Thu, 27 Jun 2024 21:02:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sMwGe-000000031kc-3jeJ;
	Thu, 27 Jun 2024 17:02:56 -0400
Message-ID: <20240627210256.757142831@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 27 Jun 2024 16:50:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 2/3] rtla/osnoise: Better report when histogram is empty
References: <20240627205022.857212058@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>

When osnoise hist does not observe any samples above the threshold,
no entries are recorded and the final report shows empty entries
for the usual statistics (count, min, max, avg):

    [~]# osnoise hist -d 5s -T 500
    # RTLA osnoise histogram
    # Time unit is microseconds (us)
    # Duration:   0 00:00:05
    Index
    over:
    count:
    min:
    avg:
    max:

That could lead users to confusing interpretations of the results.

A simple solution is to report 0 for count and the statistics, making it
clear that no noise (above the defined threshold) was observed:

    [~]# osnoise hist -d 5s -T 500
    # RTLA osnoise histogram
    # Time unit is microseconds (us)
    # Duration:   0 00:00:05
    Index
    over: 0
    count: 0
    min: 0
    avg: 0
    max: 0

Link: https://lkml.kernel.org/r/Zml6JmH5cbS7-HfZ@uudg.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Reviewed-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/osnoise_hist.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

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
 
-- 
2.43.0



