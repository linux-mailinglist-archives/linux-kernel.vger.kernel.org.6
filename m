Return-Path: <linux-kernel+bounces-414393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718129D2752
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D52284D33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7781CDA36;
	Tue, 19 Nov 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhFW1m2g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826D1CCEE4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024298; cv=none; b=MI4OeVXqXG3eUo0+hB9A38N9SLf7Ha8q1+6XTzcjSkWzQdJXOZgMFbKISHbiQY02/0lK/epetVmPVxfoYf+xrhNs2cANNqy/Qb80Ko+p3OVLDZMo6K2Rj4WHDmZPq3yvhrn87C9ZMxVGNPBhcOjIHWMGT/w+IajvcGA7mTKxzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024298; c=relaxed/simple;
	bh=kI3fmJ8Hl/BgNHyHwVH9e+O98vAnZ5hm/7Gsg2FGx1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vz5Y/7yKlcx5UhKo8lv567Tp1FvdxerQ9aZemLaMXbE8yRMaDJbOB3k0eMOdcJPhDS0Ea8dM1aGYsP/qrXyi98J4FlunhscUSS8P7dJonD5qMkD2JRl8YMvRnZZ2989oCi1HNrRugnMRR5NCYgU6vorGbaDVgsKZZUbQk6GcOEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhFW1m2g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732024295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HX5YQ+0XGJLuTnrRsfXwyh3Yrgy/pyIOX3CQFLrgtQ0=;
	b=RhFW1m2gkhQmeFKHJbrZhmaU2ZTUD2b9PQEQT7O8SnV2UWzp4+3dnRDc3YjakGTVq0FWfm
	Y6M5bLX0Z+UMznci5+mS4p5WgXpBoMBtICVWMaxpMW4BXrStnYCgTQDshjk7Xh+fDsb/Ep
	eUzYQT72h7vXHVjAFc8ZtBftxI3yH3o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-UBIYx5OiOWesG-BAbothDg-1; Tue,
 19 Nov 2024 08:51:32 -0500
X-MC-Unique: UBIYx5OiOWesG-BAbothDg-1
X-Mimecast-MFC-AGG-ID: UBIYx5OiOWesG-BAbothDg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBF881956080;
	Tue, 19 Nov 2024 13:51:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.129])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E67801956054;
	Tue, 19 Nov 2024 13:51:28 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rtla/timerlat: Fix histogram ALL for zero samples
Date: Tue, 19 Nov 2024 14:48:57 +0100
Message-ID: <20241119134858.1862632-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Tomas Glozar <tglozar@redhat.com>

rtla timerlat hist currently computers the minimum, maximum and average
latency even in cases when there are zero samples. This leads to
nonsensical values being calculated for maximum and minimum, and to
divide by zero for average.

A similar bug is fixed by 01b05fc0e5f3 ("rtla/timerlat: Fix histogram
report when a cpu count is 0") but the bug still remains for printing
the sum over all CPUs in timerlat_print_stats_all.

The issue can be reproduced with this command:

$ rtla timerlat hist -U -k -d 1s
Index
over:
count:
min:
avg:
max:
Floating point exception (core dumped)

(There are always no samples with -U unless the user workload is
created; the -k is to work around a bug with -U.)

Fix the bug by omitting max/min/avg when sample count is zero,
displaying a dash instead, just like we already do for the individual
CPUs.

Cc: stable@vger.kernel.org
Fixes: 1462501c7a8 ("rtla/timerlat: Add a summary for hist mode")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 93 ++++++++++++++++++--------
 1 file changed, 66 insertions(+), 27 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a3907c390d67..5cbbe3e98c1d 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -504,51 +504,90 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
 	if (!params->no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	if (!params->no_irq)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.min_irq);
+	if (!params->no_irq) {
+		if (sum.irq_count != 0)
+			trace_seq_printf(trace->seq, "%9llu ",
+					 sum.min_irq);
+		else
+			trace_seq_printf(trace->seq, "%9c ", '-');
+	}
 
-	if (!params->no_thread)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.min_thread);
+	if (!params->no_thread) {
+		if (sum.thread_count != 0)
+			trace_seq_printf(trace->seq, "%9llu ",
+					 sum.min_thread);
+		else
+			trace_seq_printf(trace->seq, "%9c ", '-');
+	}
 
-	if (params->user_hist)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.min_user);
+	if (params->user_hist) {
+		if (sum.user_count != 0) {
+			trace_seq_printf(trace->seq, "%9llu ",
+					 sum.min_user);
+		} else {
+			trace_seq_printf(trace->seq, "%9c ", '-');
+		}
+	}
 
 	trace_seq_printf(trace->seq, "\n");
 
 	if (!params->no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	if (!params->no_irq)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.sum_irq / sum.irq_count);
+	if (!params->no_irq) {
+		if (sum.irq_count != 0)
+			trace_seq_printf(trace->seq, "%9llu ",
+					 sum.sum_irq / sum.irq_count);
+		else
+			trace_seq_printf(trace->seq, "%9c ", '-');
+	}
 
-	if (!params->no_thread)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.sum_thread / sum.thread_count);
+	if (!params->no_thread) {
+		if (sum.thread_count != 0)
+			trace_seq_printf(trace->seq, "%9llu ",
+					 sum.sum_thread / sum.thread_count);
+		else
+			trace_seq_printf(trace->seq, "%9c ", '-');
+	}
 
-	if (params->user_hist)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.sum_user / sum.user_count);
+	if (params->user_hist) {
+		if (sum.user_count != 0) {
+			trace_seq_printf(trace->seq, "%9llu ",
+					 sum.sum_user / sum.user_count);
+		} else {
+			trace_seq_printf(trace->seq, "%9c ", '-');
+		}
+	}
 
 	trace_seq_printf(trace->seq, "\n");
 
 	if (!params->no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	if (!params->no_irq)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.max_irq);
+	if (!params->no_irq) {
+		if (sum.irq_count != 0)
+			trace_seq_printf(trace->seq, "%9llu ",
+					 sum.max_irq);
+		else
+			trace_seq_printf(trace->seq, "%9c ", '-');
+	}
 
-	if (!params->no_thread)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.max_thread);
+	if (!params->no_thread) {
+		if (sum.thread_count != 0)
+			trace_seq_printf(trace->seq, "%9llu ",
+					 sum.max_thread);
+		else
+			trace_seq_printf(trace->seq, "%9c ", '-');
+	}
 
-	if (params->user_hist)
-		trace_seq_printf(trace->seq, "%9llu ",
-				 sum.max_user);
+	if (params->user_hist) {
+		if (sum.user_count != 0) {
+			trace_seq_printf(trace->seq, "%9llu ",
+					 sum.max_user);
+		} else {
+			trace_seq_printf(trace->seq, "%9c ", '-');
+		}
+	}
 
 	trace_seq_printf(trace->seq, "\n");
 	trace_seq_do_printf(trace->seq);
-- 
2.47.0


