Return-Path: <linux-kernel+bounces-389325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDD89B6B63
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947321F213B3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F761BC09A;
	Wed, 30 Oct 2024 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UecCXqic"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D21F4274
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310825; cv=none; b=UlAgETEYLHZAui6ldew5swKkEU1I4LbzQqfr9TUNsZ9LYvBGBm6s0wSOYSTOg/Xs9aAfHqH3nPgfLe6jAA9OH2ivM274HVaYqe3XgkUqg/0aI8eB2GLgCdfvKiXcHTg1KB8E6yzWb5hzUi83SAg77/QqGsOVAnKLq6spJXry8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310825; c=relaxed/simple;
	bh=Xf7iaz7RhfEXsC2qbZz3r9uE1NWCdLczszPlMrhe9QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVrJEmCyQA7cHNHS546R6tIB7IFcpiDIbeyLqtVqH6L0Y0dtYmUtGroqnXyzk5P6HnG9/cMbAJW8RPrOy/SrE7oZ51y0yeEpZZSqBWDyajnqsa8XQgEFUjh+iLzymLkgtFT0LeVaOD5j+vZBY3FwyEl3TkyAOIvoe5cuJG3phys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UecCXqic; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730310822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPIKa2iNa6N9eFv3gPUxRMLqWm3wApOys5nqSpibaPM=;
	b=UecCXqicQOR1/hYK4M4rGltnj9e8jpueGQNi+Hrh/zep9CFhQmdORkwkQKWyB/4jb7O6gq
	rJlfXfg45cyb/9u32Dz62til8o4wTi/MnGrl8XQEIbAelQWEafMLRzMhhXNRJuBcq3rq/1
	IsOxGoOezEzxEp2XpmJ70DV5ieGyu84=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-XJh5WA6eNQqYjVLILXeEWw-1; Wed,
 30 Oct 2024 13:53:39 -0400
X-MC-Unique: XJh5WA6eNQqYjVLILXeEWw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A53C919560BE;
	Wed, 30 Oct 2024 17:53:37 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.200])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C879A19560A7;
	Wed, 30 Oct 2024 17:53:34 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RESEND PATCH v4 2/4] sched/isolation: Make "isolcpus=nohz" equivalent to "nohz_full"
Date: Wed, 30 Oct 2024 13:52:51 -0400
Message-ID: <20241030175253.125248-3-longman@redhat.com>
In-Reply-To: <20241030175253.125248-1-longman@redhat.com>
References: <20240921190720.106195-1-longman@redhat.com>
 <20241030175253.125248-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The "isolcpus=nohz" boot parameter and flag were used to disable tick
when running a single task.  Nowsdays, this "nohz" flag is seldomly used
as it is included as part of the "nohz_full" parameter.  Extend this
flag to cover other kernel noises disabled by the "nohz_full" parameter
to make them equivalent. This also eliminates the need to use both the
"isolcpus" and the "nohz_full" parameters to fully isolated a given
set of CPUs.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 kernel/sched/isolation.c                        | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8337d0fed311..4e664587943f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2424,7 +2424,9 @@
 			specified in the flag list (default: domain):
 
 			nohz
-			  Disable the tick when a single task runs.
+			  Disable the tick when a single task runs as well as
+			  disabling other kernel noises like having RCU callbacks
+			  offloaded. This is equivalent to the nohz_full parameter.
 
 			  A residual 1Hz tick is offloaded to workqueues, which you
 			  need to affine to housekeeping through the global
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5345e11f3d44..6a686322ce3c 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -209,9 +209,13 @@ static int __init housekeeping_isolcpus_setup(char *str)
 	int len;
 
 	while (isalpha(*str)) {
+		/*
+		 * isolcpus=nohz is equivalent to nohz_full.
+		 */
 		if (!strncmp(str, "nohz,", 5)) {
 			str += 5;
-			flags |= HK_FLAG_TICK;
+			flags |= HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER |
+				 HK_FLAG_RCU | HK_FLAG_MISC | HK_FLAG_KTHREAD;
 			continue;
 		}
 
-- 
2.43.5


