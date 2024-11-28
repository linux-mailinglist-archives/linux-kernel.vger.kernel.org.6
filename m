Return-Path: <linux-kernel+bounces-424425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BD9DB433
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF6A1648BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E460F1917E7;
	Thu, 28 Nov 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ8IFgq1"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46F15852F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783762; cv=none; b=TuX8wqotEH7Hxsd3L5selffYjDUyjtJYb2jtHd01xEOumpSjQQ1/blWAeAb5tpyf1rF/rMSFT42UBN51XM3HJotyFZ2AorT0dmr6fd+QjcY2OljXzxo9uVg4WlHK0Kqdq9/hK2pnYU2JKlhZo3rafAjxoWZpYh05rgrazHKYzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783762; c=relaxed/simple;
	bh=F0lk0HLz5jf8q7dw3dV1FgtHodw9reKkMWFPmZhr+WA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R0CG2unyavc6Yfco2LsNaM4cTBQIDgs+2yb+hRyqTw9R4VCqAn/qTia6vC8scYBicFWIgJi9HSNIcYDsFxm8L2td0kYZkSFQ7xaUi49+llQd4srNNss6StSur4/WKAO68kzfatPdssVZvr9ucJ4Qex9IcdMp9TbStD6FLva27Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ8IFgq1; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fc88476a02so487442a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732783760; x=1733388560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biTnDZFKhjt6ANlWd3ga/0C+ZkbKD1Beoc2zE39yreI=;
        b=TQ8IFgq1gIzPfepfSS4bBeq/nI4ibcCXCRqHYRxnUa+jD1EY6XtHLvgF9G+V/NTcb3
         UQD6cRW/+jLn2g5Q9a9//q0Ov93uzl4A+OjVtuoxC4eqqF7hIlm3mkIWNZhMhIq1tiII
         b2A2+2e7xPCW2f7WV5+3k1o75dOWwOUk3RhXq898GrsYo+Xz11BBZMZcVcd1UM2QniFl
         2Fwwgv5VoqxkMC/PZ6CK5Lrhj8C52qZavVYTFNh+tlHeqyXa6KRMutgtqIjvKKVc6Mep
         QelVRAq0qkJiUJLgk8ehJ7IPrzh4/ZdhwLPEU8QszxN+FhvIMyKarVnR1dEgmvC2fT/y
         MHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783760; x=1733388560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biTnDZFKhjt6ANlWd3ga/0C+ZkbKD1Beoc2zE39yreI=;
        b=fKNd0OvQPORptqkSEfJH6LcYq9h3/zauaU6ZBOMb+061/bzB1WGzTGCS7rauEMaxhP
         Khwr4yCuYekPqVUB5EuuXEKA62wOUBbdGB48j2J4GKBWzLN7r6nLERHNOOS634LNPi12
         Yr9C1XHAv0XQJTDk/JAjQm6w13dSCn4rTUfuoix9TinNMJO8PbKljr0KEc6yoLpnhBW5
         t0tvT/JBdcyXXzZMFYCx78F2H10g0TXa851MBuH9KXoIEsx3bSVH5ZPRbEa7eMqi/J82
         pCXH0RG4RZ057i5uPd1qm8feBbTur/RfDx2DIgnfUxknRB0uwKP0EW+EkfOSefF0zh01
         L7LQ==
X-Gm-Message-State: AOJu0YyOuZyi5wD86NPS7ou8TM6IoM6FV9HBMt6FZUeq+SgDTnhhDVQg
	UAbEkH3D1l7/lvF68Z1gBZlKHGuE1ta7hp4r6WNDaRY/xEOJdc83
X-Gm-Gg: ASbGncuToK+rNhLNPzGiSfFZKe/srWcjTT97bqRGVMDBrUNMPdJFp2o3YWf2VgFBXqU
	n59fahfP/8v0Ab/dVjUtJ79lmbnm+kK6V9NeZ0YZqBiMkOvcyHKGFLvYzqZap8aq6/8hO0zpetr
	TvF7pqdSQO1DeMZF6w3BSY4u50KlQZCaPrYfVars7JhFWbIoC4opoB1w30G9k5yfb86ISy9+hTZ
	MNxHA+NRYvnN/cOM55tS0APd2DL5WY5ZEHRp0p1rLBOfkpH3JPWvPtw+ttC55GnMcDB2rkhC7X+
	cYi0HOTYa8zX7LN8tNtWyiov3x5s85aHs1P1
X-Google-Smtp-Source: AGHT+IG7COHEp8iJJx9TF/+pKyS6xplvZQPOmN2zKWOES03VIlBT+HIpItQNSPXQVNrFZvZLusvf8Q==
X-Received: by 2002:a05:6a20:a108:b0:1d9:2408:aa4c with SMTP id adf61e73a8af0-1e0e0af5cdcmr9562581637.23.1732783759859;
        Thu, 28 Nov 2024 00:49:19 -0800 (PST)
Received: from localhost.localdomain (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848277sm971924b3a.177.2024.11.28.00.49.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Nov 2024 00:49:19 -0800 (PST)
From: Hao Jia <jiahao.kernel@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	mingo@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH] sched/core: Do not migrate ineligible tasks in sched_balance_rq()
Date: Thu, 28 Nov 2024 16:48:58 +0800
Message-Id: <20241128084858.25220-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

When the PLACE_LAG scheduling feature is enabled, if a task
is ineligible (lag < 0) on the source cpu runqueue, it will
also be ineligible when it is migrated to the destination
cpu runqueue.

Because we will keep the original equivalent lag of
the task in place_entity(). So if the task was ineligible
before, it will still be ineligible after migration.

Therefore, we should skip the migration of ineligible tasks
to reduce ineffective task migrations, just like the task
throttled by cfs_bandwidth, until they become eligible.

Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89c677f..5564e16b6fdb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9358,13 +9358,14 @@ static inline int migrate_degrades_locality(struct task_struct *p,
 static
 int can_migrate_task(struct task_struct *p, struct lb_env *env)
 {
+	struct cfs_rq *cfs_rq = task_cfs_rq(p);
 	int tsk_cache_hot;
 
 	lockdep_assert_rq_held(env->src_rq);
 
 	/*
 	 * We do not migrate tasks that are:
-	 * 1) throttled_lb_pair, or
+	 * 1) throttled_lb_pair, or task ineligible, or
 	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
 	 * 3) running (obviously), or
 	 * 4) are cache-hot on their current CPU.
@@ -9372,6 +9373,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running &&
+			!entity_eligible(cfs_rq, &p->se))
+		return 0;
+
 	/* Disregard percpu kthreads; they are where they need to be. */
 	if (kthread_is_per_cpu(p))
 		return 0;
-- 
2.34.1


