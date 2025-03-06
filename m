Return-Path: <linux-kernel+bounces-549632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12ABA554CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E03D3ADCE2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE81627426C;
	Thu,  6 Mar 2025 18:18:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF12702B3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285106; cv=none; b=ZBk1X2Pe2TXVTzQPR/x6PF3ZRUNttEg5F47GZObKXcdQ7iXS2aCwrnT7IM9dfuNsRPPgLLHvlaX4Fvlaf4sT4YkELA+IbjA/NrhyB76Qio/Sng1Ft7jA3Ab0g4UvaCh35bCw+JBUE4dmRIVBeIix/wTd6jGJy8s+x0S0+8eYkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285106; c=relaxed/simple;
	bh=RmA8FvfFeBujo6qDHWDoz5f640kOFON4eLlg4WgAEhQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OhpTa1HOQ6nQa+uB9+yG6eTUGHXwpAGRi4xPcBop4xO3aHmdbER4GraUCKmskV2g/M90TWVyC2gYrchbVzgShwSlU5NWpjPd7WHd2uTH0PAX2e4gW36NcnUkVjiGER4iyZtVjwA+CWM+uOPfzE1KbLlZuRJNs2JGbfBWTbwPwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531D4C4CEED;
	Thu,  6 Mar 2025 18:18:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqFnf-00000000PK7-0B8q;
	Thu, 06 Mar 2025 13:18:27 -0500
Message-ID: <20250306181826.923371010@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 13:18:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Eder Zulian <ezulian@redhat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>
Subject: [for-next][PATCH 10/10] rtla: Refactor save_trace_to_file
References: <20250306181801.485766945@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Costa Shulyupin <costa.shul@redhat.com>

The functions osnoise_hist_main(), osnoise_top_main(),
timerlat_hist_main(), and timerlat_top_main() are lengthy and contain
duplicated code.

Refactor by consolidating the duplicate lines into the
save_trace_to_file() function.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Eder Zulian <ezulian@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250219115138.406075-1-costa.shul@redhat.com
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Tested-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 5 +----
 tools/tracing/rtla/src/osnoise_top.c   | 5 +----
 tools/tracing/rtla/src/timerlat_hist.c | 5 +----
 tools/tracing/rtla/src/timerlat_top.c  | 5 +----
 tools/tracing/rtla/src/trace.c         | 4 ++++
 5 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index b4930b835b0a..7c6ef67ef3e6 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -983,10 +983,7 @@ int osnoise_hist_main(int argc, char *argv[])
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("rtla osnoise hit stop tracing\n");
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 4772677ac762..0eeefbbbf317 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -813,10 +813,7 @@ int osnoise_top_main(int argc, char **argv)
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("osnoise hit stop tracing\n");
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_top:
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 202d99a598ba..93d0c9e45020 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1473,10 +1473,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1b6455b9e093..3894ac37d81c 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -1295,10 +1295,7 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		if (params->trace_output) {
-			printf("  Saving trace to %s\n", params->trace_output);
-			save_trace_to_file(record->trace.inst, params->trace_output);
-		}
+		save_trace_to_file(record->trace.inst, params->trace_output);
 	} else if (params->aa_only) {
 		/*
 		 * If the trace did not stop with --aa-only, at least print the
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 728f5029d533..74ed2f6208ba 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -75,12 +75,16 @@ int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
 	int out_fd, in_fd;
 	int retval = -1;
 
+	if (!filename)
+		return 0;
+
 	in_fd = tracefs_instance_file_open(inst, file, O_RDONLY);
 	if (in_fd < 0) {
 		err_msg("Failed to open trace file\n");
 		return -1;
 	}
 
+	printf("  Saving trace to %s\n", filename);
 	out_fd = creat(filename, mode);
 	if (out_fd < 0) {
 		err_msg("Failed to create output file %s\n", filename);
-- 
2.47.2



