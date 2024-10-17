Return-Path: <linux-kernel+bounces-369933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D89A2499
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEE928A8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455EA1DEFE2;
	Thu, 17 Oct 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtStNdtx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749E1DED72
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174197; cv=none; b=K/D/o61n0rx68ZogM6qUPPWnGgFt3XRIFVR8sKxuHS+jKx7CRC0aa5NZ0qA1M7L8HZ7jAJYK68drueGhOoczT+eGzp7ITNqcE6pzljCTOf1V15Uz4Fq68w+igaZPYT05LNOgHxQ5HVqIB8Sotd/OLuyqja3K+hxEkYYrjFvV6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174197; c=relaxed/simple;
	bh=mFXiqK3KfzjuuV7ca3Y11LL8SftOwK2eMizVPciOeTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObyNlEIyitTxpbAF/SkpIrYyk8F1jLO9AyvToWL4+Njgj7sa7ce//hJ92vJI1xVek2ltpwUG6Jd2vS7iO67DKI4E/8eGOa6100tyjBIRKn2/nE8raSuRLSBKL44e7eSCFUj5rfCn6kZwe9HF/pjSK333mTvPdhC+N56phCXMI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VtStNdtx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729174194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbffXuV/W2LJJxkF9vZjOFB2SKnvqHFB2UqKGcqsdjI=;
	b=VtStNdtx6MNCWkHjfdDbWtmo548g61QY7GgVDMSBNcuN7kyYXh/XyCr5GmlCb9vuRuDtAD
	QClqqqhsnGWQKERfvTH6pUvSvBuE9c5qTxhNR3ThPBul1LOMa4KNWDwDOloykHaefafGOJ
	I9UqDjZn0zR6PbpT/hWyko6r9Kweckk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-rhdpxWSMPTunjy9TEGa9Ng-1; Thu,
 17 Oct 2024 10:09:53 -0400
X-MC-Unique: rhdpxWSMPTunjy9TEGa9Ng-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 298A0195608A;
	Thu, 17 Oct 2024 14:09:52 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E46A19560AD;
	Thu, 17 Oct 2024 14:09:50 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v5 5/6] rtla/timerlat: Add --deepest-idle-state for hist
Date: Thu, 17 Oct 2024 16:09:13 +0200
Message-ID: <20241017140914.3200454-6-tglozar@redhat.com>
In-Reply-To: <20241017140914.3200454-1-tglozar@redhat.com>
References: <20241017140914.3200454-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Tomas Glozar <tglozar@redhat.com>

Support limiting deepest idle state also for timerlat-hist.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 42 +++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index d49c8f0855fe..01dd337da13a 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -55,6 +55,7 @@ struct timerlat_hist_params {
 	int			entries;
 	int			warmup;
 	int			buffer_size;
+	int			deepest_idle_state;
 };
 
 struct timerlat_hist_cpu {
@@ -655,7 +656,7 @@ static void timerlat_hist_usage(char *usage)
 		"         [-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
 		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C[=cgroup_name]] [--no-aa] [--dump-task] [-u|-k]",
-		"	  [--warm-up s]",
+		"	  [--warm-up s] [--deepest-idle-state n]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -695,6 +696,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
+		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		NULL,
 	};
 
@@ -732,6 +734,9 @@ static struct timerlat_hist_params
 	/* disabled by default */
 	params->dma_latency = -1;
 
+	/* disabled by default */
+	params->deepest_idle_state = -2;
+
 	/* display data in microseconds */
 	params->output_divisor = 1000;
 	params->bucket_size = 1;
@@ -772,6 +777,7 @@ static struct timerlat_hist_params
 			{"dump-task",		no_argument,		0, '\1'},
 			{"warm-up",		required_argument,	0, '\2'},
 			{"trace-buffer-size",	required_argument,	0, '\3'},
+			{"deepest-idle-state",	required_argument,	0, '\4'},
 			{0, 0, 0, 0}
 		};
 
@@ -960,6 +966,9 @@ static struct timerlat_hist_params
 		case '\3':
 			params->buffer_size = get_llong_from_str(optarg);
 			break;
+		case '\4':
+			params->deepest_idle_state = get_llong_from_str(optarg);
+			break;
 		default:
 			timerlat_hist_usage("Invalid option");
 		}
@@ -1152,6 +1161,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	int return_value = 1;
 	pthread_t timerlat_u;
 	int retval;
+	int nr_cpus, i;
 
 	params = timerlat_hist_parse_args(argc, argv);
 	if (!params)
@@ -1201,6 +1211,28 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
+	if (params->deepest_idle_state >= -1) {
+		if (!have_libcpupower_support()) {
+			err_msg("rtla built without libcpupower, --deepest-idle-state is not supported\n");
+			goto out_free;
+		}
+
+		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+		for (i = 0; i < nr_cpus; i++) {
+			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+				continue;
+			if (save_cpu_idle_disable_state(i) < 0) {
+				err_msg("Could not save cpu idle state.\n");
+				goto out_free;
+			}
+			if (set_deepest_cpu_idle_state(i, params->deepest_idle_state) < 0) {
+				err_msg("Could not set deepest cpu idle state.\n");
+				goto out_free;
+			}
+		}
+	}
+
 	if (params->trace_output) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
@@ -1332,6 +1364,13 @@ int timerlat_hist_main(int argc, char *argv[])
 	timerlat_aa_destroy();
 	if (dma_latency_fd >= 0)
 		close(dma_latency_fd);
+	if (params->deepest_idle_state >= -1) {
+		for (i = 0; i < nr_cpus; i++) {
+			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+				continue;
+			restore_cpu_idle_disable_state(i);
+		}
+	}
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
 out_free:
@@ -1340,6 +1379,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
 	free(params);
+	free_cpu_idle_disable_states();
 out_exit:
 	exit(return_value);
 }
-- 
2.47.0


