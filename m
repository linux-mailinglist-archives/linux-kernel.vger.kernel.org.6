Return-Path: <linux-kernel+bounces-365909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1202B99EDC8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6ACB215F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD281C07CC;
	Tue, 15 Oct 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lharttqv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E71514F8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999383; cv=none; b=Q1vWsmNmLAmyqi0eKsM0JBuvDoQNyIovpS3+KShF52tD8sjQ4WBO7nNvKVzh2IH7gd/eqcddBRfdP+OvfGyWN1csYRkxLs54cT9rSUC3CxZlJTPVw1om7ah9fzepzYsFGH7/fP3klTrrfxk3xK2/OxmiY0Hr9/vSgJ9kqmfZ2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999383; c=relaxed/simple;
	bh=mFXiqK3KfzjuuV7ca3Y11LL8SftOwK2eMizVPciOeTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0nTb9fJYJYN/Dc6cTSMI+0+mOcajVntQowki7JqdX9l8jWfNOk/ClVOFww6ro1lTFxcfGuiYpjmFCsTxsAb5SxbPGP2Gx97wBydC9ndyBq+Po07+jt7nukc3VrsT9GbGDexRFoRL3lxP15WS21ldT3OG2PwCdj95tfk1tmqIxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lharttqv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728999380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbffXuV/W2LJJxkF9vZjOFB2SKnvqHFB2UqKGcqsdjI=;
	b=LharttqvhM6G+EjB7tpGivH9wEEQsnHSKPj33/Le3k4T8LH9031vJAlugum0RTvDSk3yWc
	BgkyQHrrAlIbx/rjjeWGfk1zwdyy483XEzo9R0v1UeddcV4nVCcDCsGy6V5oIdQ/ogp44S
	IQoNcTQ7ZopqTv8l89a+vXtCgwaBJrI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-Bo8bhmqKPq-l0asBS4WYGw-1; Tue,
 15 Oct 2024 09:36:19 -0400
X-MC-Unique: Bo8bhmqKPq-l0asBS4WYGw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 807641954233;
	Tue, 15 Oct 2024 13:36:18 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B422719560A3;
	Tue, 15 Oct 2024 13:36:16 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v4 5/6] rtla/timerlat: Add --deepest-idle-state for hist
Date: Tue, 15 Oct 2024 15:35:51 +0200
Message-ID: <20241015133552.3043040-6-tglozar@redhat.com>
In-Reply-To: <20241015133552.3043040-1-tglozar@redhat.com>
References: <20241015133552.3043040-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


