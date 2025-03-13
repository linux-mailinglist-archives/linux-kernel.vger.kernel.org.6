Return-Path: <linux-kernel+bounces-558904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5318AA5ECE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BC23BB281
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551921FE462;
	Thu, 13 Mar 2025 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NoMIY2vZ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9F1FCCEA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850517; cv=none; b=Z5lV2IMuTo5KLXHE6lyycrXmDF8jjuQ79MPHI2Nx03VyV/OrfNeZT32mTEuu4oNIT4lQZDPkwbjmHPBwX5iSRtqYPkb7viAw7PQkGwrPsr4adUh9a8b3535FObNCAP99A0j4xl+Nd43QlFJ2/J/pv/QdFD8tbnX+J2qYtcq5DLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850517; c=relaxed/simple;
	bh=F2iSSOdR/hDLzHj6tvB8TPDBA4YNdpFnG46Hrlaho/Y=;
	h=From:Mime-Version:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc4RlVp/KElLG7bXQIw3lWcTg7Swgp5ZLecFKB9fw5hzZmJlHpqON0zyL5aYi+o0wgusQWehLOjFMCYA7zqT8Tyev8bxnNzkQjKOn4XgeOA7Imp15B5I+AeIkg0hAuuON7SwTqo8dU1xQJE4MrqnMohxQrG8qLuTflk9auZ1BQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NoMIY2vZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so1063656a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741850514; x=1742455314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:mime-version
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jQAPUFnO9nEMuZGJ5x9hWTx/DhspMU7TljFp3+HbdFk=;
        b=NoMIY2vZP0t/tX8yBbh7F1TL6xfLB3UbCqHxkPiPpFlc4u0j9lcXwtO1YNr72jcWK0
         XXfM1XuzC0054OFHErCYjOPqB5I2lfF6vg+jhIug4Wprqz8lpNyXvTLeJ5xvPYbCaC1s
         JVc3MoR3Igfi7P1Y/ZZLvYs5+Ys1Tu3SfxLeic/k/jCCzcQw+wxsPnr3CVoKUllcWsWd
         GHHiyEV+wuDBxyX/LzzkVHq14jAn9RYTjoTUhAjuyTvuyuhrsZp6n3tAR1V7O6RlIpuu
         ZN29yiAgYfcpl/9ZdqGJCJOFOJBZ8JwPABJarArK3ZbdDfnDjZkn/ddq8Hfm/OHHdnSD
         w+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850514; x=1742455314;
        h=cc:to:subject:message-id:date:in-reply-to:references:mime-version
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQAPUFnO9nEMuZGJ5x9hWTx/DhspMU7TljFp3+HbdFk=;
        b=qt6wXx+FxhOyWWgRQZV78XOcRmbWBbdQYk3+P73WbIw/5h7FhDP1DdH/6FkKo2jzDg
         jvlFGgx2VcA6TmAgrpdNMFHj2dbVCQVk30uSiUMlPoMBKUvVPCrhdjv6SJIOJCksBfrK
         vp9QAmJmceIHETpslvHf5g+X4xDC8OC/wXF1weXsnCYLo5+/1UkZLt71eYyHElC3Tg5F
         zAKuIshA9WZCtjUP6/DjS29cQbf7/LiX0vJuXoPSt22oN0k6UZho+0izBdHEO7ktXSM/
         I6RTPVLSwHyRDazWLyXkai5a0Kfa/dc3WBt+Jtsz75cHbh3KMoOtYa0h94nI7ax9QmvQ
         RAGg==
X-Gm-Message-State: AOJu0YzbVhmoHBHwnFeBiwhqn31U4fRsrGX2wU95BwvJLpSXsTAY8u7F
	PoKljK4NI4q4Ce8yeukHHQYzl6p7+66kKE+FMnmdO9YtuhZDJxCPXEbQTxavom7gg1ayDxMUkjx
	mXRkW+ssQ9bVJ8JjdUaazVT7TFhdzk93OcQoc
X-Gm-Gg: ASbGnctzhzrxii9Bg2wEbn2vrXMbdHc3ALGC7Eftqw8H+b1uLXa+o5O24Iw/i6wYvCn
	FzqMnXjMpDvT/oN2IpDwJpw6gCFcZxUxjHwznk70g0iL+t6ZiWElpYuQcl677UdESA/DGY33CfD
	rCZPmAoIEkkgQoAiupP2B7tEQlWp4=
X-Google-Smtp-Source: AGHT+IFfeWDlYHQTGMGMpO3/ozaP1dGAKoleEHFUOzP5BCuASPpC5R/F94l3F6TLYPhgGf2jH/VO5O2ShcA1DRsgK60=
X-Received: by 2002:a05:6402:2747:b0:5e0:2e70:c2af with SMTP id
 4fb4d7f45d1cf-5e5e24909a2mr28745235a12.26.1741850514277; Thu, 13 Mar 2025
 00:21:54 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Mar 2025 02:21:53 -0500
X-Mailer: git-send-email 2.39.5
From: Aaron Lu <ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
In-Reply-To: <20250313072030.1032893-1-ziqianlu@bytedance.com>
Date: Thu, 13 Mar 2025 02:21:53 -0500
X-Gm-Features: AQ5f1JokQNZnRoxq3hXBX0TkqhOuxJ2KX7RFvRrM-srb1Xpe3594xFdcKDUmfTQ
Message-ID: <CANCG0Gcm92LNtei5yLym-5dK96gb5GF2-tDoLJ+YS0fMx8jADg@mail.gmail.com>
Subject: [RFC PATCH 5/7] sched/fair: Take care of group/affinity/sched_class
 change for throttled task
To: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On task group change, for a queued task, core will dequeue it and then
requeued it. The throttled task is still considered as queued by core
because p->on_rq is still set so core will dequeue it too, but since
the task is already dequeued on throttle, handle this case properly in
fair class code.

Affinity and sched class change is similar.

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9e036f18d73e6..f26d53ac143fe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5876,8 +5876,8 @@ static void throttle_cfs_rq_work(struct
callback_head *work)

 	update_rq_clock(rq);
 	WARN_ON_ONCE(!list_empty(&p->throttle_node));
-	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
 	dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
+	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
 	resched_curr(rq);

 out_unlock:
@@ -5920,10 +5920,6 @@ static int tg_unthrottle_up(struct task_group
*tg, void *data)
 	/* Re-enqueue the tasks that have been throttled at this level. */
 	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list,
throttle_node) {
 		list_del_init(&p->throttle_node);
-		/*
-		 * FIXME: p may not be allowed to run on this rq anymore
-		 * due to affinity change while p is throttled.
-		 */
 		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
 	}

@@ -7194,6 +7190,16 @@ static int dequeue_entities(struct rq *rq,
struct sched_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (task_is_throttled(p)) {
+		/* sched/core wants to dequeue this throttled task. */
+		SCHED_WARN_ON(p->se.on_rq);
+		SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
+
+		list_del_init(&p->throttle_node);
+
+		return true;
+	}
+
 	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &
DEQUEUE_SAVE))))
 		util_est_dequeue(&rq->cfs, p);

-- 
2.39.5

