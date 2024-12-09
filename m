Return-Path: <linux-kernel+bounces-437040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71639E8E58
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598D31882DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3651A1BC4E;
	Mon,  9 Dec 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SxEbTIul"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BC21519B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734944; cv=none; b=CZpROTbrYcMnEcT+1tooUfDthAfNLHsX7ok1N1xfmZJp8dye1mPgef85lgoD9pRrBpMgyWFEi6pvZeiwp9zO19lO6I0sSeh9UPkd/WqAWoLZRMEC4r1K7qqqm/D3wwSlvyQiI3kZEAGksFBztDiGhdrymEG2VFns3db9RmlJ9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734944; c=relaxed/simple;
	bh=cf9dyL6/PNkWyw15AxxEcxcYPYFRL47e/VHupH4ZnsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iy10Zelv4E3yh7WifxN9KmWkLisiMm1I+99CRTGGYPyz45JcW6BInq19cjwSnx8u4+jLWgtf0ysxPqOhYkVnwrUigi1dY39/9Orh+dKZJk4z1J2Bb/aSARVk8kO2QbUDcOjO1gP2keklAPptXvB621Tbgr1mgLbApI2/fzNF5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SxEbTIul; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-725dbdf380aso944680b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733734940; x=1734339740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvtR8cnQupCYqwoKVo/nm49rLeqd+grV918TGv1GjgM=;
        b=SxEbTIulH60KbyzHDvwwLkIt0Z3bS+vuhbJ7G//4vf6baPZ95E4zEHy7xOJJmYWY2d
         d3LY+Siw88YhxzBji9HngfBR+negPbvVMNCco/ydH9LR4OgZz7CLJOhcPLbD6BeSRoFj
         NOBOWS6q9mG1u885WfhBOiy0bcpc3gxh5mXpsMeFSH0W5noHqy75ZRx5oOwkbpJMZy5X
         w6RRPo0/sGmYCqISh+GJzu9zsAZSlEeE9oMQjoI13lyQ5kCS8ZaX26t0HvbV+WIC10YT
         nOfAo4ZJwK2ubd0u+0t/EBG9ARDYMo4q1rFmtEZyDdWylwOZFdw7j2+Tq2gnX7TCyECs
         fz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734940; x=1734339740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvtR8cnQupCYqwoKVo/nm49rLeqd+grV918TGv1GjgM=;
        b=hjZSgaA++tDfmAUNrnkXoCe4Mgg671DRVto3G+8EXJYf8o8C6AqgKzgkhEBfSdsfyE
         0Ki+aLkheXlCtrLQ1nPvguVx1rxxXHSTeYxrBYz4Cq5Uvzqly3iZCeTImM03qIXCXGHZ
         OxeGb7olEyi7FIG8NZ3+hRYRHgVG7UCOhnpt1rk7QGU7En0S7rkLSUaElBAljwSBmGGy
         9m3SCbJvPUkwZsHYacpcQUASvD6wQSuOGVkWs5l4jpJMyHe7m7P6wynlWn1hWQm4sLIz
         hY6Dhzl9/ggb7zpF0QvoHCH+8/IXCQs3894seCb/khyktXzuU6ZydlkmGsgTqUccqluJ
         ZKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyKBUku1LCVQLXqnP440PknNRPgACw2vkpyqSydbB5PudCvV20r7GnCkcE5+1vn/zZKVEs3JrS5lm20Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Y7RqfVGK4Qq2fdlbk8xmlC2gyoAZDCB/0f8kv3rXkQoeZZWg
	lDag/BWxMHX6lWXtp84THhhfty/PwXFJDfkn5erHP1pnYV0v3q2UGdH0qqE603k=
X-Gm-Gg: ASbGncsJMI9cEK4mZWANcp/p7KZ/f5x6vjnPUuVaU2D8OfCYLZTeTsQcMYIgMcHDh0/
	OeKtqIcP0vCfwnmM/1qK48+LjQmddYkE9f/03RZwyU/qI1Vku48BGDjwESsFmuK5cxHozqRaGzC
	1lOSZIbTN7j4bvoiPYcS0PkM+gk7Nckzdy6rHIzFKIsD7MOU71KTwB/FzsRgSIVxrdFZqhStzJQ
	EIKXih2GZXb4KAFNyRR0X7Bfg2LMmzp7qKiaIN6AQ==
X-Google-Smtp-Source: AGHT+IFmpSpcVOn2Hcdd0lYtgr6LtTEm+EytvTlHcDuayCCnQJo3iR47k6Zx7CM/mZBJOkKcJ2SLJQ==
X-Received: by 2002:a05:6a00:816:b0:725:eb12:a73b with SMTP id d2e1a72fcca58-725eb12aa1dmr5546999b3a.20.1733734940457;
        Mon, 09 Dec 2024 01:02:20 -0800 (PST)
Received: from 4CE152BDRN.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29e9003sm7036290b3a.44.2024.12.09.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:02:20 -0800 (PST)
From: Vincent Zhou <vincentzhou@bytedance.com>
X-Google-Original-From: Vincent Zhou <Vincent Zhou@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: vincentzhou@bytedance.com
Subject: [PATCH] sched/rt: fix the error in rt task wait time calculation
Date: Mon,  9 Dec 2024 17:02:05 +0800
Message-Id: <20241209090205.2181878-1-vincentzhou@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: vincentzhou <vincentzhou@bytedance.com>

update_stats_wait_end_rt needs to be called in dequeue_task_rt
to update the wait_start variable, otherwise calling
update_stats_wait_start_rt again will casue a wrong small value
of wait_start because the following codes logic:
if (p && likely(wait_start > prev_wait_start))
	wait_start -= prev_wait_start;
After that, update_stats_wait_end_rt is called again, it will
calculate wait time by using current rq_clock subtracting
wait_start which will cause a very big wait time.

Signed-off-by: vincentzhou <vincentzhou@bytedance.com>
---
 kernel/sched/rt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index bd66a46b06ac..544dd55447df 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1488,6 +1488,10 @@ static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_rt_entity *rt_se = &p->rt;
 
 	update_curr_rt(rq);
+
+	if (!task_current(rq, p))
+		update_stats_wait_end_rt(rt_rq_of_se(rt_se), rt_se);
+
 	dequeue_rt_entity(rt_se, flags);
 
 	dequeue_pushable_task(rq, p);
-- 
2.25.1


