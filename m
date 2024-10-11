Return-Path: <linux-kernel+bounces-361579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A09999AA06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA0D1F25C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E791CF2A7;
	Fri, 11 Oct 2024 17:30:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCE1C5782
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667818; cv=none; b=sjBw50T1RTI9VT70TbaLu/hMGAjfxW54jEPJlgindoZKJ7yxI26NEFdtek4Q7N3EwsnNJjYTPuSgqa6cmJQW9htine7x3Y8F2aGzDrZOoYpwQ8XnWN11xW8f7qqpeIGhwSQgNz9RG3haG6f56zZea7L073PLZe23N0orVEyqvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667818; c=relaxed/simple;
	bh=LeUqvpIi3xVVykZZ2tXrQflVdKy0iM9aX71D1yOFHZ0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qEmGWIhv2yt8KAfbEFmEylFKv9LOXU6qaQ2pJHb9Aw0GPNfYpSEAwFxWzLTCTdXeF6NQe0nMeeDku5tFF4L8bXhl1rWJnFqxMAukdAbkneNs5ZrNfT3sWfG6UIn7QZ9iJBrMpo13ZD5DR16omnKi+WE8uootifASlPoQIGj6NUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7361C4CEDF;
	Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1szJTB-00000001U2I-1KOo;
	Fri, 11 Oct 2024 13:30:29 -0400
Message-ID: <20241011173029.181826265@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 11 Oct 2024 13:30:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Attila Fazekas <afazekas@redhat.com>
Subject: [for-next][PATCH 9/9] rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long
References: <20241011173010.441043942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Do the same fix as in previous commit also for timerlat-hist.

Link: https://lore.kernel.org/20241011121015.2868751-2-tglozar@redhat.com
Reported-by: Attila Fazekas <afazekas@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 1f9137c592f4..d49c8f0855fe 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -62,9 +62,9 @@ struct timerlat_hist_cpu {
 	int			*thread;
 	int			*user;
 
-	int			irq_count;
-	int			thread_count;
-	int			user_count;
+	unsigned long long	irq_count;
+	unsigned long long	thread_count;
+	unsigned long long	user_count;
 
 	unsigned long long	min_irq;
 	unsigned long long	sum_irq;
@@ -304,15 +304,15 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 			continue;
 
 		if (!params->no_irq)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].irq_count);
 
 		if (!params->no_thread)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].thread_count);
 
 		if (params->user_hist)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					 data->hist[cpu].user_count);
 	}
 	trace_seq_printf(trace->seq, "\n");
@@ -488,15 +488,15 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
 		trace_seq_printf(trace->seq, "count:");
 
 	if (!params->no_irq)
-		trace_seq_printf(trace->seq, "%9d ",
+		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.irq_count);
 
 	if (!params->no_thread)
-		trace_seq_printf(trace->seq, "%9d ",
+		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.thread_count);
 
 	if (params->user_hist)
-		trace_seq_printf(trace->seq, "%9d ",
+		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.user_count);
 
 	trace_seq_printf(trace->seq, "\n");
-- 
2.45.2



