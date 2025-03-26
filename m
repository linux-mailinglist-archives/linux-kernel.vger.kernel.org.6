Return-Path: <linux-kernel+bounces-577184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C2EA7199F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D982E3BFCBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFFF1F5433;
	Wed, 26 Mar 2025 14:55:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047081F3D59
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000918; cv=none; b=J+/lGognGYQ8I58UJ2slPSOIqyG3iV/pbkCnt+aN+JBmX7dLLCJL6kKFw56upuVAy/aJKBMecBd2UxXYJO4L13SgNu3vo6t4MG5NTnWXZqm4qkdCFAjNzgSAusUm1J5XNWGnu1fyGMcyM5bHL8qmT50A2fyi4YDUlwS1NsmDyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000918; c=relaxed/simple;
	bh=RbxTpL00A5cqTlR0YQKwZWmt521LefRA9dXYwCczeU0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iGJQcKNWDtjDiSgMPZIP8Va9gHTphpMJ8+R5cSxNUMkw9VV6PBKj0f/jaUQW0h3kn+GbE8B5nhQdJJBKzxnX2ceWox6L8K4jF1W1faooAj22P+e6ghDWyMQXeJshC8x+E29wtYZfeDaFKB2Vff4CtC4Euu8Pb3USHMrSxRGxlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4566C4CEEB;
	Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txSAm-00000002kF3-3NUe;
	Wed, 26 Mar 2025 10:56:04 -0400
Message-ID: <20250326145604.654551325@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Mar 2025 10:55:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>
Subject: [for-next][PATCH 6/9] rtla: Always set all tracer options
References: <20250326145549.978154551@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

rtla currently only sets tracer options that are explicitly set by the
user, with the exception of OSNOISE_WORKLOAD.

This leads to improper behavior in case rtla is run with those options
not set to the default value. rtla does reset them to the original
value upon exiting, but that does not protect it from starting with
non-default values set either by an improperly exited rtla or by another
user of the tracers.

For example, after running this command:

$ echo 1 > /sys/kernel/tracing/osnoise/stop_tracing_us

all runs of rtla will stop at the 1us threshold, even if not requested
by the user:

$ rtla osnoise hist
Index   CPU-000   CPU-001
1             8         5
2             5         9
3             1         2
4             6         1
5             2         1
6             0         1
8             1         1
12            0         1
14            1         0
15            1         0
over:         0         0
count:       25        21
min:          1         1
avg:       3.68      3.05
max:         15        12
rtla osnoise hit stop tracing

Fix the problem by setting the default value for all tracer options if
the user has not provided their own value.

For most of the options, it's enough to just drop the if clause checking
for the value being set. For cpus, "all" is used as the default value,
and for osnoise default period and runtime, default values of
the osnoise_data variable in trace_osnoise.c are used.

Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250320092500.101385-5-tglozar@redhat.com
Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise.c  | 56 ++++++++++++++---------------
 tools/tracing/rtla/src/timerlat.c | 59 +++++++++++++++----------------
 2 files changed, 56 insertions(+), 59 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index a71618d876e9..2dc3e4539e99 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -17,6 +17,9 @@
 
 #include "osnoise.h"
 
+#define DEFAULT_SAMPLE_PERIOD	1000000			/* 1s */
+#define DEFAULT_SAMPLE_RUNTIME	1000000			/* 1s */
+
 /*
  * osnoise_get_cpus - return the original "osnoise/cpus" content
  *
@@ -1127,46 +1130,43 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 	if (!params->sleep_time)
 		params->sleep_time = 1;
 
-	if (params->cpus) {
-		retval = osnoise_set_cpus(tool->context, params->cpus);
-		if (retval) {
-			err_msg("Failed to apply CPUs config\n");
-			goto out_err;
-		}
+	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
+	if (retval) {
+		err_msg("Failed to apply CPUs config\n");
+		goto out_err;
 	}
 
 	if (params->runtime || params->period) {
 		retval = osnoise_set_runtime_period(tool->context,
 						    params->runtime,
 						    params->period);
-		if (retval) {
-			err_msg("Failed to set runtime and/or period\n");
-			goto out_err;
-		}
+	} else {
+		retval = osnoise_set_runtime_period(tool->context,
+						    DEFAULT_SAMPLE_PERIOD,
+						    DEFAULT_SAMPLE_RUNTIME);
 	}
 
-	if (params->stop_us) {
-		retval = osnoise_set_stop_us(tool->context, params->stop_us);
-		if (retval) {
-			err_msg("Failed to set stop us\n");
-			goto out_err;
-		}
+	if (retval) {
+		err_msg("Failed to set runtime and/or period\n");
+		goto out_err;
 	}
 
-	if (params->stop_total_us) {
-		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
-		if (retval) {
-			err_msg("Failed to set stop total us\n");
-			goto out_err;
-		}
+	retval = osnoise_set_stop_us(tool->context, params->stop_us);
+	if (retval) {
+		err_msg("Failed to set stop us\n");
+		goto out_err;
 	}
 
-	if (params->threshold) {
-		retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
-		if (retval) {
-			err_msg("Failed to set tracing_thresh\n");
-			goto out_err;
-		}
+	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+	if (retval) {
+		err_msg("Failed to set stop total us\n");
+		goto out_err;
+	}
+
+	retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
+	if (retval) {
+		err_msg("Failed to set tracing_thresh\n");
+		goto out_err;
 	}
 
 	if (params->hk_cpus) {
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 448fb1f7d3a6..c29e2ba2d7d8 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -16,6 +16,8 @@
 
 #include "timerlat.h"
 
+#define DEFAULT_TIMERLAT_PERIOD	1000			/* 1ms */
+
 /*
  * timerlat_apply_config - apply common configs to the initialized tool
  */
@@ -27,49 +29,44 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 	if (!params->sleep_time)
 		params->sleep_time = 1;
 
-	if (params->cpus) {
-		retval = osnoise_set_cpus(tool->context, params->cpus);
-		if (retval) {
-			err_msg("Failed to apply CPUs config\n");
-			goto out_err;
-		}
-	} else {
+	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
+	if (retval) {
+		err_msg("Failed to apply CPUs config\n");
+		goto out_err;
+	}
+
+	if (!params->cpus) {
 		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
 			CPU_SET(i, &params->monitored_cpus);
 	}
 
-	if (params->stop_us) {
-		retval = osnoise_set_stop_us(tool->context, params->stop_us);
-		if (retval) {
-			err_msg("Failed to set stop us\n");
-			goto out_err;
-		}
+	retval = osnoise_set_stop_us(tool->context, params->stop_us);
+	if (retval) {
+		err_msg("Failed to set stop us\n");
+		goto out_err;
 	}
 
-	if (params->stop_total_us) {
-		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
-		if (retval) {
-			err_msg("Failed to set stop total us\n");
-			goto out_err;
-		}
+	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+	if (retval) {
+		err_msg("Failed to set stop total us\n");
+		goto out_err;
 	}
 
 
-	if (params->timerlat_period_us) {
-		retval = osnoise_set_timerlat_period_us(tool->context, params->timerlat_period_us);
-		if (retval) {
-			err_msg("Failed to set timerlat period\n");
-			goto out_err;
-		}
+	retval = osnoise_set_timerlat_period_us(tool->context,
+						params->timerlat_period_us ?
+						params->timerlat_period_us :
+						DEFAULT_TIMERLAT_PERIOD);
+	if (retval) {
+		err_msg("Failed to set timerlat period\n");
+		goto out_err;
 	}
 
 
-	if (params->print_stack) {
-		retval = osnoise_set_print_stack(tool->context, params->print_stack);
-		if (retval) {
-			err_msg("Failed to set print stack\n");
-			goto out_err;
-		}
+	retval = osnoise_set_print_stack(tool->context, params->print_stack);
+	if (retval) {
+		err_msg("Failed to set print stack\n");
+		goto out_err;
 	}
 
 	if (params->hk_cpus) {
-- 
2.47.2



