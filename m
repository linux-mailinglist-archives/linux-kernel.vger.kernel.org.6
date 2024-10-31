Return-Path: <linux-kernel+bounces-390932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088519B802F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EA4286072
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D431BBBE4;
	Thu, 31 Oct 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlHOdaUV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D81953A2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392398; cv=none; b=XQzdiB1zUL92XqI5JQnmxBoO7pOjvRwx1K0h9NLeRUxfDwiHnyfKMRj+cfqWW9KcqetN3qFDhbBZ/owzobAa90qA6USYo3Cw/q+PaVIknASoZMoMwDlXHgnPCfHuA7Z0kjqSuKBlLvH0o32GQtwyio7aZIzevY57hVdmJtgPv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392398; c=relaxed/simple;
	bh=LVr5dSOBgqflK0gltwTmDPnzj7zrOFThABbwkBbV0mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jx9+OUERBq+i5zKEdvCV9++dgaRGlZmSIqI74qYSTD/CorlrHDIQ8PfR0xlAyYzuy69OZ1H8aA6JIBdy3OMMPypVqwCp5NTwXQlR9OAWOH9+nAAdJw7Th6gFrArUr7rjiWuauovuLjxHIXJGj15qlZ+g+AV3ydW8q0qs0ZeFIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlHOdaUV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730392395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YdMTFS4fEyRhEFc+mN3pHqMCVM2Pz1mvTqynMm1lcKc=;
	b=HlHOdaUVr4iXNqb3rVrw8zj21BoaSPxG0/9fRhf9KisRcshyWeOlicoOiuCn4sh3QHQh+t
	/FtN0mhQn8GUINQjjnqw1pWR8gGCgvv2k4Cb5dZkTbUeRSs+XuAMLmDL2WX3Fce6diSy/4
	SCpq+VgnT0F6P2LF030uAPgnmHQshvQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-F-dJBbzhMMa4WqTHdQzgcg-1; Thu,
 31 Oct 2024 12:33:11 -0400
X-MC-Unique: F-dJBbzhMMa4WqTHdQzgcg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49FED1955F45;
	Thu, 31 Oct 2024 16:33:04 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.35])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EF301956052;
	Thu, 31 Oct 2024 16:33:01 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] sched/core: Enable full cpumask to clear user cpumask in sched_setaffinity()
Date: Thu, 31 Oct 2024 12:32:42 -0400
Message-ID: <20241031163242.24195-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
cpumask"), user provided CPU affinity via sched_setaffinity(2) is
perserved even if the task is being moved to a different cpuset.
However, that affinity is also being inherited by any subsequently
created child processes which may not want or be aware of that affinity.

One way to solve this problem is to provide a way to back off from
that user provided CPU affinity.  This patch implements such a scheme
by using a full cpumask (a cpumask with all bits set) to signal the
clearing of the user cpumask to follow the default as allowed by
the current cpuset.  In fact, with a full cpumask in user_cpus_ptr,
the task behavior should be the same as with a NULL user_cpus_ptr.
This patch just formalizes it without causing any incompatibility and
discard an otherwise useless cpumask.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/syscalls.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 0470bcc3d204..232704f4a315 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1276,14 +1276,22 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 		return retval;
 
 	/*
-	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
-	 * alloc_user_cpus_ptr() returns NULL.
+	 * If a full cpumask is passed in, clear user_cpus_ptr and reset the
+	 * current cpu affinity to the default for the current cpuset.
 	 */
-	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
-	if (user_mask) {
-		cpumask_copy(user_mask, in_mask);
-	} else if (IS_ENABLED(CONFIG_SMP)) {
-		return -ENOMEM;
+	if (cpumask_full(in_mask)) {
+		user_mask = NULL;
+	} else {
+		/*
+		 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
+		 * alloc_user_cpus_ptr() returns NULL.
+		 */
+		user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
+		if (user_mask) {
+			cpumask_copy(user_mask, in_mask);
+		} else if (IS_ENABLED(CONFIG_SMP)) {
+			return -ENOMEM;
+		}
 	}
 
 	ac = (struct affinity_context){
-- 
2.47.0


