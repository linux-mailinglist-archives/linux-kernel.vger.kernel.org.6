Return-Path: <linux-kernel+bounces-199133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD578D82CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3C11C21599
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C016E12BF3D;
	Mon,  3 Jun 2024 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N1g197vK"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48987839EA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419041; cv=none; b=UXpbQZQNiYo90mRjmap9tJ3Bguftk6cg8Ubi/96ChbCMeYeRZrWf/FYFkQKdqGdtvyw/ec3qkqeCMeWxqKWYNPCWdw6b6oARhLC0ylWu3kgWUd6YYFX9If5SpFMaQBIanO9re108xI8FAv4z+RD5TdR5u09jLPAvmd9dM0uYpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419041; c=relaxed/simple;
	bh=Xx8hZI8ETFFARLK8cGsQFhmUvgpM/d78SWxzC56NTOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJvgJ5RvLfHlS5Er9hkQm4XwxCLmue8v8LbYLKH7HSUD+z/T/l7nxM7tBxFQeRf/axhd8oWy7XfSeOLWkaZnB2hYEZwZnQgthr8f9xGHZecyvepSsKY4APzHZRQlMjayADOA2xj71iCcbH+1rG3Z/jcKgKZwv9r/eZpwE7hrEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N1g197vK; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mingo@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717419037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgeKLP+6Ei7WwWWp/yRMV4AawW29LI/t4aEV6fabFvU=;
	b=N1g197vK3VTZ2J7/8XHk2GOHHCzRQQoMMbmV7UqK4R/ECCSq9+K3dwmpmaymCVDYfaSKyG
	extP3RgXsUWSsHD3FZZ6pjfFK8shp1fOV/iyLW0g0mX2qF6cUfPLJ1MEnxKue6vnBT3RoO
	6HsBBNuggdKUgkK24jIKOKn/n68TAXA=
X-Envelope-To: peterz@infradead.org
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: bsegall@google.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: bristot@redhat.com
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yajun.deng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 1/2] sched/rt: Use 'back' only if CONFIG_RT_GROUP_SCHED is enabled
Date: Mon,  3 Jun 2024 20:50:01 +0800
Message-Id: <20240603125002.3086-2-yajun.deng@linux.dev>
In-Reply-To: <20240603125002.3086-1-yajun.deng@linux.dev>
References: <20240603125002.3086-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The 'back' member in struct sched_rt_entity only related to
CONFIG_RT_GROUP_SCHED, so there is no need to init it in dequeue_rt_stack.

Init the 'back' member in init_tg_rt_entry and use it only if
CONFIG_RT_GROUP_SCHED is enabled.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/rt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 63e49c8ffc4d..44bb9087cfe5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -232,8 +232,10 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 
 	if (!parent)
 		rt_se->rt_rq = &rq->rt;
-	else
+	else {
 		rt_se->rt_rq = parent->my_q;
+		parent->back = rt_se;
+	}
 
 	rt_se->my_q = rt_rq;
 	rt_se->parent = parent;
@@ -1428,16 +1430,19 @@ static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
 	struct sched_rt_entity *back = NULL;
 	unsigned int rt_nr_running;
 
-	for_each_sched_rt_entity(rt_se) {
-		rt_se->back = back;
+	for_each_sched_rt_entity(rt_se)
 		back = rt_se;
-	}
 
 	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
 
-	for (rt_se = back; rt_se; rt_se = rt_se->back) {
+	for (rt_se = back; rt_se; ) {
 		if (on_rt_rq(rt_se))
 			__dequeue_rt_entity(rt_se, flags);
+#ifdef CONFIG_RT_GROUP_SCHED
+		rt_se = rt_se->back;
+#else
+		rt_se = NULL;
+#endif
 	}
 
 	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
-- 
2.25.1


