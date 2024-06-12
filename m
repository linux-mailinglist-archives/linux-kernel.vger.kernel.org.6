Return-Path: <linux-kernel+bounces-211352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA94C90507F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D75282B29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317DA16EBF3;
	Wed, 12 Jun 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekg/bXyY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2237BB19
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188590; cv=none; b=oaqAiXKkiPhVRCQGAgtb0Yb8QOPyHWKFEWtrIsaPQJECR+rl9b4m9XK0GEPtw3hP4LvIQQm0wyU65/wLbYHz9hd0VfW8QuOhBjVDF0gBDkocUV3ZBLHfTb7Hkq9yMNwSoI7ms279KCmW4utx18M8QvwoL4YCubYb7NP+7t4O0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188590; c=relaxed/simple;
	bh=eX0hMDs+PRjjxkDL9dZLNeFINrDNoCX8o2tqm0A4dhM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R6Y78A73j30arpb5q7oiDCu/zxjF4WvHqhnq7gvFbBSerUnC6z7e2yKB/yxpCdgw6CdV24IDzysMoLHh/V7Rg9yDNp6kCwGHs/jsruOE9mN4vixA18SXvbME4k4Gs02FeBauJkPISLp/KfNwVT1D9hV1/Qp0U48PXPrLUfK7gpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekg/bXyY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718188587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=J9SukMWyQNIS5OWhxrsad2CeSFU7AFbK+BapPzKpiNg=;
	b=ekg/bXyYEZv2R6Vj2j084pAexO68zG2tPY2oHWM1DJJKrBXwtgRMF5QmzGIOEA7c5cHUoV
	nXbtC70MJvXlLFX1BJ6ceKY9BPLaEHQqkjHsw3Gh+leZUiPu4q4caVnKBK8o6F2+PdQs/w
	oBR5bfNf9/n+PSDRoGmmefWlPWGkYuc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-a9BIPxjXNV-Tve-9jF0Mnw-1; Wed,
 12 Jun 2024 06:36:26 -0400
X-MC-Unique: a9BIPxjXNV-Tve-9jF0Mnw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1002D195608F;
	Wed, 12 Jun 2024 10:36:25 +0000 (UTC)
Received: from localhost (unknown [10.22.8.85])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F11DE19560AA;
	Wed, 12 Jun 2024 10:36:23 +0000 (UTC)
Date: Wed, 12 Jun 2024 07:36:22 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtla/osnoise: Better report when histogram is empty
Message-ID: <Zml6JmH5cbS7-HfZ@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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


Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 7be17d09f7e85..214e2c93fde01 100644
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
 


