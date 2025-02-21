Return-Path: <linux-kernel+bounces-525652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04198A3F2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655413B9F98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60692080FC;
	Fri, 21 Feb 2025 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ILS3XgnE"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ADB2080F0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136379; cv=none; b=WEwyyGAifpkP4E7jJSZXV5LgMHV/pu/P46K6ZLCbPP42FOfaedwvPtuuEwNrViayO6TSIKkAmxQw3s8N1dcYQTM7ElGqoey7LHhvXl6cBfhrmxyp/vUkD0RhszG07aBn9z6J/uIAXKo7q7K9+RzKxL+7IAMRhIge84Aqn95hcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136379; c=relaxed/simple;
	bh=a9DZaEqgd5aLQB/kDaA4Z1oSSumYhosLf1PP57esesE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qMsQx6c2stzRccd11AZBfwRL/5OHDo8Im8OpK87bOpchzopfkYgzfxzrYbOC8xOqV3vxD/NpD7PEpGOGNxr/GMp5e3L7s9/qG0hvca9M6br4OK7gG0yrlOWimg/SFGjq04yyHR7v+k1FguGA5qWOQgg1uI2MVCVgQrrqVrZqGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ILS3XgnE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2210f7cb393so3831565ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740136377; x=1740741177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csjxLa7ENffY/I+nqFB0CkTIWdAA49thd+4pFitEmRo=;
        b=ILS3XgnEMO0reto/CZkbApgsuna9u1Y2qa9oaBn7bZZgsd1RAgTAlTJOpraVlly6/G
         puFwYTs7Pq+HbZIusoNNJjVhWKJ06eCeXYjqHDZAPbMWpn3vVZhJBcQm9RnmgtD4FlPG
         2GgBWR4I6qyXuLDzTwgnCv/GO+/eFseJXCbfsCH7TeT4EXFttOpfXUwUfR7dRf3ka2ui
         muiu9STCnIdqhpHHmyYFSzrXNBuFGbjKtxX22RBy7A91XuL7S3sBzMDBg3lh9ZGuofJp
         CKTlekp/HTq7plgCdYdN1ZHUXX4CVMLCj/S2yP/Rw2QPWlB7RL9RKstgX5BlQZoUXKbt
         0RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136377; x=1740741177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csjxLa7ENffY/I+nqFB0CkTIWdAA49thd+4pFitEmRo=;
        b=hk09d95lUod16g44jmN39kFq4cGqVbhYLdKG/grQqZo5NiKIr0Vm2p8m9PH2lP11og
         YKWJXq+X7wiJQipfTprSOxOGZLWbkgpCfAqTxPCLtcT30+gjNf4SnMd3rRCZ7ZFQfMlQ
         Vl61Z+YVJCX8AvIdNcbmmscnpLH8OR9DSGd6eX68Px4tJbIhw1lFPeJD5YIriRF53voN
         HSHtPGCmIu0UqaYB9QorA6X/gL1r6UE/kwLRq5HRZfTQ1BnAa31J2ndXW+5JUicTB2op
         VHdgXzrjPO8LikE2rZenEhwB3KY5dXCjwZEVpf+p0MAP0TWZjqajiJrvr0PovUHJzruG
         aG4w==
X-Forwarded-Encrypted: i=1; AJvYcCUN64wjDHt0RQqYSs/OIRa/+YNgOEeZZO0dY0aAVHlzDPIrzcc7Zw4mG2Tt+Ym0rnxZ/eNiLgs0MbWGHRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW45EFHMj1z1AHw9+MbVwjX+x6uw0ju1VvLRPBPjygvjeE5Y+0
	3ms+AGVrz2TlUd2e3Zt8FIC80ydBS8Z4A5V/Lw+kb7eudKdnZ0LwFpbBdosus7A=
X-Gm-Gg: ASbGnctI1ihigm+Ib7hQaYUb/Mu9QRLvE9cFY96mCxY1dSk06XDYpNIR0JbKt0rd+xj
	En4lmg//EZNM4qS/s23Jc5zhElobJvn4wJWfYjN5dCUSSO+gOl2L4jBpiRiJizWCzkmlBmQlhic
	c25xipcpemglu/39EIeHxwz9wpHIL1JomUlvPE7cOp0QhCxH862bNFxWPlxjI+CDHVilC0ACIBN
	eY8hMSUly5q6BWbpUU6H/ce/eLSOCBBr20sW6pSNqDF5SA/MKHRnJ/YoQqjXyxcRn+lYhIlrLtA
	3UKA4NQYXDM3rsj/5/vUPEVylMVlBEgJiG1PM6vt6B02BghhwbdFiZ1gu7hd3XH1
X-Google-Smtp-Source: AGHT+IFEzaHfQLUx8UObmxUbeAXmKwjv5L9GPSDn7cUukSOar+cH/JT8h9tr5jzKsMPfKDI6spOpWw==
X-Received: by 2002:a05:6a21:7a47:b0:1ee:d7b1:38b8 with SMTP id adf61e73a8af0-1eef3da0984mr2002087637.7.1740136376884;
        Fri, 21 Feb 2025 03:12:56 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327237a5efsm10205145b3a.127.2025.02.21.03.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 03:12:56 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Ingo Molnar <mingo@redhat.com>,
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
Subject: [PATCH 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
Date: Fri, 21 Feb 2025 19:12:24 +0800
Message-Id: <20250221111226.64455-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250221111226.64455-1-wuyun.abel@bytedance.com>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Idle tasks are by definition preempted by non-idle tasks whether feat
WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since
commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
which gives priority to WAKEUP_PREEMPTION, so when !FAIR_GROUP_SCHED,
SCHED_IDLE tasks do not preempt by non-idle tasks.

Fixes: faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4340178f29b7..de9a2689de9c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8768,9 +8768,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (test_tsk_need_resched(rq->curr))
 		return;
 
-	if (!sched_feat(WAKEUP_PREEMPTION))
-		return;
-
 	find_matching_se(&se, &pse);
 	WARN_ON_ONCE(!pse);
 
@@ -8783,6 +8780,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (cse_is_idle && !pse_is_idle)
 		goto preempt;
 
+	if (!sched_feat(WAKEUP_PREEMPTION))
+		return;
+
 	/*
 	 * IDLE entities do not preempt others.
 	 */
-- 
2.37.3


