Return-Path: <linux-kernel+bounces-284694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD195042B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B34B26A39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F0199E9A;
	Tue, 13 Aug 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlsGFCaf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6C194A6B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549783; cv=none; b=VbDerBSbsbder5aG1aIWrxx26qVjvgUTalxPcEhx69Y2BjELoRzhX8Pawktcg92aePtbX5EiBOh18lhfFX07Ow6ShoUQIN2V+LoUi079MZZ9Vzlytby/Ug/nR8RbuQttGEGZkG8bc2AW1SwN2uAsO37VNfwr8isZyOGA/hGUx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549783; c=relaxed/simple;
	bh=xEeXlmjbCWkA83ODn5+P/1vT4N0c9dsr/kuusqM3pEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4HWvHvpHN4GkKF51Kn1JoG96pYB2t1drpL3ZHkF39gzWMxS9mEnBo56R+96awHzF7eBu5AF6ghrzF7veoInJYEk4D2PGWg4gGdHogGG1R27XP9+7fD7kpIX4eMs/TX2TtFeiRKQumdEg5Cr5PVqk4HI+YOoHYba6FWH5fTNHEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlsGFCaf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723549780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r6RlHVcf/jAXydMpE738i+dtXHMRB+KkyJcsMj8nRQ8=;
	b=JlsGFCafi65csmscyTvU3zZvEenv+iLpzgvgYRn8+9Ucs0fBWBNAe7IRNX3knxx+b87IP+
	JckD9cvZhHXhZklMEKf64bw10NnY8uYXt6fpdGf5Ss+qq3zCluQCsABMI0E/gzB1ONg2MG
	JXEWzDOpheaIqQGgAhH1suHhDV6qEVA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-PkCMKgX7Mwuyeja_rYqEIQ-1; Tue,
 13 Aug 2024 07:49:37 -0400
X-MC-Unique: PkCMKgX7Mwuyeja_rYqEIQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28B0418EB230;
	Tue, 13 Aug 2024 11:49:36 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.192.249])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 601081944A95;
	Tue, 13 Aug 2024 11:49:33 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	jlelli@redhat.com,
	lgoncalv@redhat.com,
	jkacur@redhat.com,
	williams@redhat.com,
	tglozar@redhat.com
Subject: [PATCH] rtla: Sync the help text between hist tools
Date: Tue, 13 Aug 2024 13:49:31 +0200
Message-ID: <20240813114931.360823-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In addition, fix a typo in the error message generated when the
specified duration is invalid.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 4 ++--
 tools/tracing/rtla/src/timerlat_hist.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 214e2c93fde0..9017be674810 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -454,7 +454,7 @@ static void osnoise_hist_usage(char *usage)
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
 		"	  [-T us] [-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
 		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros] [-C[=cgroup_name]] [--warm-up]",
+		"	  [--no-index] [--with-zeros] [-C[=cgroup_name]] [--warm-up s]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -603,7 +603,7 @@ static struct osnoise_hist_params
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				osnoise_hist_usage("Invalid -D duration\n");
+				osnoise_hist_usage("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a3907c390d67..2d657ea281a4 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -666,7 +666,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
-		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
+		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[file]: save the stopped trace to [file|timerlat_trace.txt]",
@@ -827,7 +827,7 @@ static struct timerlat_hist_params
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				timerlat_hist_usage("Invalid -D duration\n");
+				timerlat_hist_usage("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
-- 
2.46.0


