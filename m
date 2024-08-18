Return-Path: <linux-kernel+bounces-291275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7A95602B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 007F7B21853
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D70157492;
	Sun, 18 Aug 2024 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsW4/DrK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA4156F3F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724024749; cv=none; b=FC2CqLas9zNLIqUCcSNtuEZdPJX92nfwclLMX26N1YPdhSGiv5zQ0M0SEJnPncGu3VW5f1y+jc/asF2tztiuKkx/CuQ0LGHV5DwVeKt7QkOSGbYWoJu0vZdrAPwHf8d1QJwW8UhY+46c8Dvpx+siNuNft05h2/EOxjhrhM9Uy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724024749; c=relaxed/simple;
	bh=K8N4sqRBO1QmisApM5o1j014BZ0JiNvo9k0GVZKy9Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwAoTIpRGkUdqNCf48IvXsbeqLWXL1zkVsMPBkmik+n4jfrvFPKFmg4anY9gT7mu8wmuMxRHbJ47axatdvkn44p9QJF1x2LB7zYQMajDyNFrGYKT7krFz9Tnz9+cL5N5nb/HyFR3PaQp8SNNtusqyr7H5xvuF5QY/q+pOxOkhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsW4/DrK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724024746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xTT9PXPTqZi64l2mdUMl7RWoFN2PRqSXvjmstfCL2M=;
	b=JsW4/DrKGty5EfK1au/BFl2Tc9DX6wovGow0CJD9KOeA7MX8Stl1ZagD7RXEPGDmTSl6Xp
	NbVgVmQyXgmvQxHGCkoW6Uq3cjE8hXWvw+x0GnxVHlX72pjs+WrWW+9SlppK5+hiWT5WnG
	OQAb90ueXyVM8G5yJaX8VAWdXQ673G4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-YRjt1jxCOEqJEzPC9NJdnw-1; Sun,
 18 Aug 2024 19:45:42 -0400
X-MC-Unique: YRjt1jxCOEqJEzPC9NJdnw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E69219560AD;
	Sun, 18 Aug 2024 23:45:40 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E398130001A1;
	Sun, 18 Aug 2024 23:45:37 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/3] sched/fair: Use HK_TYPE_SCHED housekeeping CPUs
Date: Sun, 18 Aug 2024 19:45:19 -0400
Message-ID: <20240818234520.90186-3-longman@redhat.com>
In-Reply-To: <20240818234520.90186-1-longman@redhat.com>
References: <20240818234520.90186-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

As the previous commit has enabled the setting of HK_TYPE_SCHED
housekeeping CPUs in nohz_full setup, we can now use the more aptly
named HK_TYPE_SCHED housekeeping CPUs instead of HK_TYPE_MISC.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/fair.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6be618110885..0350667f5ce8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12128,16 +12128,13 @@ static inline int on_null_domain(struct rq *rq)
  * - When one of the busy CPUs notices that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
- *
- * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is not set
- *   anywhere yet.
  */
 static inline int find_new_ilb(void)
 {
 	const struct cpumask *hk_mask;
 	int ilb_cpu;
 
-	hk_mask = housekeeping_cpumask(HK_TYPE_MISC);
+	hk_mask = housekeeping_cpumask(HK_TYPE_SCHED);
 
 	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
 
@@ -12155,7 +12152,7 @@ static inline int find_new_ilb(void)
  * Kick a CPU to do the NOHZ balancing, if it is time for it, via a cross-CPU
  * SMP function call (IPI).
  *
- * We pick the first idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
+ * We pick the first idle CPU in the HK_TYPE_SCHED housekeeping set (if there is one).
  */
 static void kick_ilb(unsigned int flags)
 {
-- 
2.43.5


