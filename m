Return-Path: <linux-kernel+bounces-577180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12660A719A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB3F1894411
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0644D1F3FD3;
	Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488C1F2C3B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000917; cv=none; b=Nox2HnZt93MNugtmTArDECIitduKsWmIuhMRoz8MDa40vP92Zw3P/pMRi7QHwGRfUT6rZTEtLJscIEMaMNnxEuxVUurQLLo4a6IDyT8pdQwWAeeM7lsTkibPz+HwJwNcrcWEzjc3Nys5uqVtDaSOI1H6bw3upigrczuq+w2IdPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000917; c=relaxed/simple;
	bh=AORDiZMilQMwkA+4E1LTKXvwzeeC1Tm13E5d4IPLRXk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GmudShyUVlRbzXYXxjjPnt+knd3LmQklGx2/1Bd3o+yf6SClUIO/6zijUKO5vDfO62q5pFW0Yl4lYz8OcPQW424a6K+d01jmOAPmxwqOaIsvBK2ANrrWq4yrELxFd4j6FaioGfFxOpdkMgGnnHqMk+jhhXJ8aq6b3xYMKPSt5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8F1C4CEE8;
	Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txSAm-00000002kD7-0Uxv;
	Wed, 26 Mar 2025 10:56:04 -0400
Message-ID: <20250326145603.969401580@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Mar 2025 10:55:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>
Subject: [for-next][PATCH 2/9] rtla: Fix segfault in save_trace_to_file call
References: <20250326145549.978154551@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Running rtla with exit on threshold, but without saving trace leads to a
segmenetation fault:

$ rtla timerlat hist -T 10
...
Max timerlat IRQ latency from idle: 4.29 us in cpu 0
Segmentation fault

This is caused by null pointer deference in the call of
save_trace_to_file, which attempts to dereference an uninitialized
osnoise_tool variable:

save_trace_to_file(record->trace.inst, params->trace_output);
                   ^ this is uninitialized if params->trace_output is
                     not set

Fix this by not attempting to dereference "record" if it is NULL and
passing NULL instead. As a safety measure, the first field is also
checked for NULL inside save_trace_to_file.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Link: https://lore.kernel.org/20250313141034.299117-1-tglozar@redhat.com
Fixes: dc4d4e7c72d1 ("rtla: Refactor save_trace_to_file")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 3 ++-
 tools/tracing/rtla/src/osnoise_top.c   | 3 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 3 ++-
 tools/tracing/rtla/src/timerlat_top.c  | 3 ++-
 tools/tracing/rtla/src/trace.c         | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 7c6ef67ef3e6..f4c9051c33c4 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -983,7 +983,8 @@ int osnoise_hist_main(int argc, char *argv[])
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("rtla osnoise hit stop tracing\n");
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		save_trace_to_file(record ? record->trace.inst : NULL,
+				   params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 0eeefbbbf317..dacec2f99017 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -813,7 +813,8 @@ int osnoise_top_main(int argc, char **argv)
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("osnoise hit stop tracing\n");
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		save_trace_to_file(record ? record->trace.inst : NULL,
+				   params->trace_output);
 	}
 
 out_top:
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 93d0c9e45020..822c068b4776 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1473,7 +1473,8 @@ int timerlat_hist_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		save_trace_to_file(record ? record->trace.inst : NULL,
+				   params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 3894ac37d81c..c3196a0bb585 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -1295,7 +1295,8 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		save_trace_to_file(record->trace.inst, params->trace_output);
+		save_trace_to_file(record ? record->trace.inst : NULL,
+				   params->trace_output);
 	} else if (params->aa_only) {
 		/*
 		 * If the trace did not stop with --aa-only, at least print the
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 74ed2f6208ba..69cbc48d53d3 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -75,7 +75,7 @@ int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
 	int out_fd, in_fd;
 	int retval = -1;
 
-	if (!filename)
+	if (!inst || !filename)
 		return 0;
 
 	in_fd = tracefs_instance_file_open(inst, file, O_RDONLY);
-- 
2.47.2



