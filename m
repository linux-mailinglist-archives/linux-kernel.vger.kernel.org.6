Return-Path: <linux-kernel+bounces-202716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F218FCFF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A142802A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD79619B587;
	Wed,  5 Jun 2024 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UfXa0Mgm"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3119AD7A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594591; cv=none; b=K2sTj0w0k5CSh646wggchODVkZ+uoih6wglGh473dP3uM373kdhNTcKtwJu64rpi6IRwHb6uJVmrnUpPtxO+3ohSlwZWCy/wtsEumLufeaO7f3liFfxpGIvYEkT63s/LnAhcnmZT5drXIZeb17WqhPBWPii5sXmD8ef1o6CTlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594591; c=relaxed/simple;
	bh=Q+yKb3UoyyFzRRfAW+NzEGFhCqBmF4Gfe38PmpDlfNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSE12aZUQ84MUe5C31jU0nBSzq4hMC9vo/QVef5fy+BOO89wrY6h2MLAPdQ2ioLpwqtoD9B7oKEuw5XBhJUePrkknUhbXQdw1Fv9qsAYIrYaO2Ku2TrVnjOwfCR+Fwu2cUJfxOtARsxH9wo9tCUFl2zEldurMgD/nZcAcn5/UwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UfXa0Mgm; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mingo@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717594586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yb3nN64g5IVJqtCKRjk27NnlVJOOQo5LzCqk+WIDbk=;
	b=UfXa0MgmXPfC5cQp4mFTQ5w4AnRjbsA95G4WA0FZbE5DR+O6chpusfCAqAbL+FuZb47rOc
	zpLXONsIfCQG0Klze82g5vLHVwrSOew/FU/9O5wgq2N8rZop34kYzbd36xHwEyAN7NpoBx
	H0w0IY0ARwcIbyTWWaIo4gSGEOgO0x0=
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
Subject: [PATCH v2 1/2] sched/rt: Use 'back' only if CONFIG_RT_GROUP_SCHED is enabled
Date: Wed,  5 Jun 2024 21:35:56 +0800
Message-Id: <20240605133557.2984-2-yajun.deng@linux.dev>
In-Reply-To: <20240605133557.2984-1-yajun.deng@linux.dev>
References: <20240605133557.2984-1-yajun.deng@linux.dev>
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
 kernel/sched/rt.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 63e49c8ffc4d..842a2cfd6dcc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -230,10 +230,12 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 	if (!rt_se)
 		return;
 
-	if (!parent)
+	if (!parent) {
 		rt_se->rt_rq = &rq->rt;
-	else
+	} else {
 		rt_se->rt_rq = parent->my_q;
+		parent->back = rt_se;
+	}
 
 	rt_se->my_q = rt_rq;
 	rt_se->parent = parent;
@@ -604,6 +606,11 @@ static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
 	return &rt_rq->tg->rt_bandwidth;
 }
 
+static struct sched_rt_entity *rt_se_back(struct sched_rt_entity *se)
+{
+	return se->back;
+}
+
 #else /* !CONFIG_RT_GROUP_SCHED */
 
 static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
@@ -666,6 +673,11 @@ static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
 	return &def_rt_bandwidth;
 }
 
+static inline struct sched_rt_entity *rt_se_back(struct sched_rt_entity *se)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_RT_GROUP_SCHED */
 
 bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
@@ -1428,14 +1440,12 @@ static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
 	struct sched_rt_entity *back = NULL;
 	unsigned int rt_nr_running;
 
-	for_each_sched_rt_entity(rt_se) {
-		rt_se->back = back;
+	for_each_sched_rt_entity(rt_se)
 		back = rt_se;
-	}
 
 	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
 
-	for (rt_se = back; rt_se; rt_se = rt_se->back) {
+	for (rt_se = back; rt_se; rt_se = rt_se_back(rt_se)) {
 		if (on_rt_rq(rt_se))
 			__dequeue_rt_entity(rt_se, flags);
 	}
-- 
2.25.1


