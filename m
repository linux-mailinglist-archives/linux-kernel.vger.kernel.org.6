Return-Path: <linux-kernel+bounces-535881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27C8A47873
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF67A4B22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C0C22759C;
	Thu, 27 Feb 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eCe9eUMy"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB5225403
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646737; cv=none; b=qocrYBer5r3OFBdIwwGN+rwuQtlxdUz5/zds3Zo3nIvIEBkrwF35f8oRkXR3ULYT2ngmXMJP9W7URUfbAczwo32tKzV8WUhQch9n6oDAich2CZBNgTz0f0QfPs46892Ps+vRNj1ZXiAVUde9fe3hcvNmbnM3qr+kKJ9hR1myatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646737; c=relaxed/simple;
	bh=7o5Cvqqhjmk+oLZQceup0DA2T5jY1vIBIK+cMeNyBSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9kbyBRcVNdAEWS98+JbE7/iAfMk1MKvtVwEqyHq0aJdrF/pl87HH7qwmyQ/ZUE1QITKSnYNIPfwBiOTJWSG+J5Kg1+iUtHV0yhRZJQjEPd8YuANG05kX5fB85EtEieyO6ehx1pYd/d9FbnT3mNKqwY4wFLoFKXwiO3tAe2QkIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eCe9eUMy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fe5d75ff8cso177133a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740646735; x=1741251535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4StnT4jNIOgnd6tCzVc5gf8fgMnAw9nw7Dhm88E1Z8=;
        b=eCe9eUMyZAls/ddAYZ3s4ZChySkCpwzrZA7/YP/LswUhWoehBN7xVxrHGL/OjW/hUi
         OV8/yVgd7M9GeFeNdGjKG6tBiZXmUjRoptUizhqDV1OKtTXelYkwJ7HXHaMMhrVkHQ+p
         FI2s+Gg9xuQOKY3hloOG7De7jdKeliJBmwuvQHABDCYc8cCCFazB53wKRvT43HY4+BkS
         qpT1kmov0JgKzLulWZ7DbSexySZb7BVZo5PxeSNIj7KkNuTYsC1iG0NinAQySe0N6McG
         +GpZkd8VjjTkzy+JNMG8XLm7ef/kmedzP6u15znpNUtBcJZVDlVATImmpBY3gJCj6EYY
         96Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646735; x=1741251535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4StnT4jNIOgnd6tCzVc5gf8fgMnAw9nw7Dhm88E1Z8=;
        b=S0t6DJaDmeR6tyAMHk0Y60vvqPBbqrcQwpXASIPJND98R2/Lit3yT+hed0Zn8IQTD1
         r+R5ZJ3g2lZPHlK7L4wHfYg5vhkt+H3k4nk1HATOlPYkOhURU6Q26phwi62SirgcH/jQ
         6ZRnQch4iM0UiyfzIj0fkNTqpsvudEAIa8gfb/xFURe4/edDJRzUbOZBbtuMwCkUQXRI
         5t53mFqodJ8HE2qXUdpm4LOO1kyxLcjDt8h80fysxssViBo/VH7cMOaOBDpUwHg10tYd
         RGQcQgev+5DmLTMQBXt6WM9BdYKxaeHOP/UAPMxd4O6N9BIFwLb4GlNwkOCj8DLABufO
         OXOA==
X-Forwarded-Encrypted: i=1; AJvYcCW//wxAMfGxRohK7JDChsYu0jjZeyhLUt/htkL0brWOLB7mGcYdk1XrEhd5lP8KC+VcHjV7iTHDltpH4lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHz2G6MgBIhb4O1HJ6vBUzXpw5UIYwhatvhojQRgTtJzkufyV
	XE5BqzYgjeuQ/TOmceEFVN4V3IT1fDkgBC6y2bQZovex57nG79IAQiLEFsD0GPc=
X-Gm-Gg: ASbGncvov+Pkmib86p9Hd3kYVYKlgd+vZbJI91ppF7nO9xNBRcJT8vZ5BKLNWFGF/VJ
	8wbEKxuhmDgxXJAvOd4TA22R005k5mDMxfwpnhLdew3fbyMwWedPYwva7z+Z40ZZM/VIn6q5Vw5
	sqy8kcxEeOuIn76dHxwMs6HNOiwfHn6v5Yqfpmsxujbvf1XVeOEOZeA5AdRd4vamp7ecGVv22aR
	EPEK2siLPqcinH9mAeCfGU7WRNrUzU91V9RRAR2TeCyoc4jOytMr7LRKaLrABq7tMUcZo7s461Z
	TnPqjmDFvxAiFk8ps3nLzNXE+1fXmspZR5stCFPSDAgJ3GLckMkWIfzVhXMlAjxF
X-Google-Smtp-Source: AGHT+IFMsg90Nckj5hLpUrhCyxsin8lWZGoOvUFa/yPsAAd/h6ZXVdNyOkwE9HP5KwwzGinOMNZLnQ==
X-Received: by 2002:a17:90a:db49:b0:2fe:8fa0:e7a1 with SMTP id 98e67ed59e1d1-2fe8fa0e7e0mr2490117a91.2.1740646734818;
        Thu, 27 Feb 2025 00:58:54 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825ba9b4sm3112759a91.12.2025.02.27.00.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:58:54 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [PATCH v2 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
Date: Thu, 27 Feb 2025 16:58:13 +0800
Message-Id: <20250227085815.18131-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250227085815.18131-1-wuyun.abel@bytedance.com>
References: <20250227085815.18131-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
defines the behavior of SCHED_IDLE as following:

 - no SCHED_IDLE buddies
 - never let SCHED_IDLE preempt on wakeup
 - always preempt SCHED_IDLE on wakeup
 - limit SLEEPER fairness for SCHED_IDLE

and the 3rd rule is broken if !WAKEUP_PREEMPTION due to recently merged
commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")

Although WAKEUP_PREEMPTION is mainly there for debug purpose to provide
a way to check whether a performance degrade of certain workload is due
to overscheduling or not, it is still kind of weird that we treat sched-
idle cpus as idle but don't let the non-idle tasks preempt the sched-idle
cpus in debug mode (!WAKEUP_PREEMPTION).

Fix it by strictly following the aforementioned rules.

Fixes: faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aaa9822e9562..a7eeb72d57aa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8785,9 +8785,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (test_tsk_need_resched(rq->curr))
 		return;
 
-	if (!sched_feat(WAKEUP_PREEMPTION))
-		return;
-
 	find_matching_se(&se, &pse);
 	WARN_ON_ONCE(!pse);
 
@@ -8806,6 +8803,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 		goto preempt;
 	}
 
+	if (!sched_feat(WAKEUP_PREEMPTION))
+		return;
+
 	/*
 	 * IDLE entities do not preempt others.
 	 */
-- 
2.37.3


