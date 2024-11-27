Return-Path: <linux-kernel+bounces-423747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB0B9DAC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F33B24029
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30315200BB3;
	Wed, 27 Nov 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4ETGwJB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A717C96
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726532; cv=none; b=ResX1JkzS3HvfJOVKFaEetMQeOt5o0Iu9pdE7G52SiOr3x2fNPNeQPIm9d1dXCn4UkOY+06Yt89OVqQ6LpHtW3WLNVwoLWWGosAHViMCIrY6fdtye9kEz7wY7+Wjnqmj7U240xuuQp4l9k09zksov1l5Dt9wjcgWnpvj9HCi6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726532; c=relaxed/simple;
	bh=Sw/lC3wbc7lK5AOa4tshnDQwwuGg4F54NnCQVifJxTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLknsptoiA48GwKkPUh1mRun/jcuKlYjMhPZh0RUe41Ovx4uHx8mVJBFfpYo+/ReptOE9n0hPUtEsyA5xBXpur8PCeTM6JchGJ6H3w1CbZ004LqtGV8zNZyMb+KcMXelgdirA1NmI0cySeDIOT+ug6bhk+gwg8I3WOwulMyPhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B4ETGwJB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732726529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ElG/i+aYGl7GQLJ2l091Zzj1HQkN8C9gntVQhHWTBzI=;
	b=B4ETGwJBYXfAOp23YkvufciTbfLdP6di2cEaDO24kCsxA1+3/5KTy4R0sO1VEh0pPdn9Lw
	1R/BxRyge7LG+wBd714iVm4jzROHk7SirkqNHwJ4TrF5Z6F5g/mT6iFp9Z6CCtLiIVMP56
	bsaAHgaALBqoV4mndRbom2eQvOPN8U8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615--d_R0ZkaN_aN8EpGvgbVeg-1; Wed,
 27 Nov 2024 11:55:26 -0500
X-MC-Unique: -d_R0ZkaN_aN8EpGvgbVeg-1
X-Mimecast-MFC-AGG-ID: -d_R0ZkaN_aN8EpGvgbVeg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E97891955EA2;
	Wed, 27 Nov 2024 16:55:23 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.244])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12072300019E;
	Wed, 27 Nov 2024 16:55:17 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH] sched/fair: Remove CONFIG_CFS_BANDWIDTH=n definition of cfs_bandwidth_used()
Date: Wed, 27 Nov 2024 17:55:01 +0100
Message-ID: <20241127165501.160004-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Andy reported that clang gets upset with CONFIG_CFS_BANDWIDTH=n:

  kernel/sched/fair.c:6580:20: error: unused function 'cfs_bandwidth_used' [-Werror,-Wunused-function]
   6580 | static inline bool cfs_bandwidth_used(void)
	|                    ^~~~~~~~~~~~~~~~~~

Indeed, cfs_bandwidth_used() is only used within functions defined under
CONFIG_CFS_BANDWIDTH=y. Remove its CONFIG_CFS_BANDWIDTH=n declaration &
definition.

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Link: http://lore.kernel.org/r/20240905171210.267626-1-andriy.shevchenko@linux.intel.com
---
 kernel/sched/fair.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3356315d7e641..55e0a32d2027f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5373,8 +5373,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
-static inline bool cfs_bandwidth_used(void);
-
 static void
 requeue_delayed_entity(struct sched_entity *se);
 
@@ -6747,11 +6745,6 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 
 #else /* CONFIG_CFS_BANDWIDTH */
 
-static inline bool cfs_bandwidth_used(void)
-{
-	return false;
-}
-
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
-- 
2.43.0


