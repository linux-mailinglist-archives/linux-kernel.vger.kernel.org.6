Return-Path: <linux-kernel+bounces-550352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DC5A55E42
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263B73B48A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E40118DF6B;
	Fri,  7 Mar 2025 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LVqt3a0m"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB39189B91
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317727; cv=none; b=C4HSxAqsCG84wu9u84iG2lcdjKjRxFwbwKi8FSfpnrzN1Ee4uoudmH7vuyCDqp37KiQAGHtGhNiXQIRKN9S3PuV533p14SPoWmoERcoUu5vcARb9qt0/0OeDNn6/HbWm2Bx1EroAXJcmXqwmv+JAUn+23Jc+LWOfxAOAKlIlHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317727; c=relaxed/simple;
	bh=TULGkmqI05IIqDjwmHOqlL/pO8Vr5xhbS11kFZM3UVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3yvhBVg9vGgjY6jqy/EEmJfoPA/DY/zWNTFMEyfHalO6FvJjjIh6l1DtWs4KWx7kUE4r8fnB1GhQmRDeays4qxmfucpN19eS01VQ39685kEjFC/OA2faWZRjd+IpWRIuZ8/EtGHgdiIIT6NLxSbUHc8I4KbjSnz74nQ8u49VBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LVqt3a0m; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240ff0bd6eso3586455ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 19:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741317724; x=1741922524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfYVgV6MPqgoo7cn85aMhXvWtnrwYHtcacliZIPZ8K8=;
        b=LVqt3a0mBNQPmUavUgqah2d7iqrsvM5tcVbFdWog8Bw0npsRGrQq6+ZD2ZZ4xUMBNU
         HysVcbUtSu4zewCNrXl4rT26qu7RpAqQDOnGqtIVweIPKX3VAsLkFOLbrAsUrqmrm07p
         q0bD+bTiz+ijsmolFkGzr4dwxvLErvCd9fXb6CdPpugBYGc1/nk+5e5opCmQj55qJQOf
         imJacdDshlfXSk6ESpnC5DjjOyNzikHPX2twDSqDnl4Gs8onEh++2nXEnM+z05jTKBST
         g3AYxOuI3UhiFW83uZLqpk+bLM62bECDKmnjw6qJEBZ7L1JvBt94bgi9RvBHQDCswwoh
         KMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741317724; x=1741922524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfYVgV6MPqgoo7cn85aMhXvWtnrwYHtcacliZIPZ8K8=;
        b=wiaoTjPOnRDK2bmKte1O95Hnzu+5Guz1CuHuY2mK+Rjmx9aLGSDc88VE1HAwb93XZO
         9bLm+MtJ168GoJP2etibf9ODpQgS6BBw7BB8qEsep/X50eLzhIdg71o22Z9VB+U3Q2lp
         FLnvUq0Cf9HIy6StOy+8Ziq/rkzQrubdJHMs6DPSneqE5KXnzGcNAu+2Z4kHkh6Ve7fF
         YDypzpnzfhPBc3kIgyhGcBH7W/k1QiWm4aWJH6WFOhpBTZx0njVT+tKfyznmVimaxCFm
         2u2LngAkpo7sC5xgwLblz7lwyUCSws13Agedw4BtktKLSKgdTAuY4YorqPmGE/SR+ard
         A+0g==
X-Forwarded-Encrypted: i=1; AJvYcCUeHTuPrMIsXWoywwEX5EwHUoL6t3otrRfWl/MpiwOaSgbcReef0Z7bUAjT0is1q4IMSJ5FYPhR1QPjtrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5zB7KbJrIpD4xYhWCoYe6yAaSAN4zRYWC3hbYWuI/GGM9DMU
	EiuHWnX1Fbj9bJHFfclVz8sHzW3ygxyQz8rhivRVnCuFVmTb30lOX4C7ccpbFxI=
X-Gm-Gg: ASbGncvrBhVAz4cbbmQ5IfPXNVVXr3H698RQ6edarq9JsjoMCh8PRBgu4wV57Fr8L2l
	jSFEgx+VFeYe86gmvP3zVY+LjpWS5qMfyTNkJx8mj5mQKGJiwbQnv9DHlQNTClrDJV+yj7bIMol
	0wMwCJAaZuertIraF/hAe4ry+zEFDEtV80Ey02cCGlBPWEaPAbnAkOY8LPrkXeK4vcGAYEFMuhg
	8dlsu47wkRUzLOJ2EaidLOu41LZFrd3JMrhKWzlIFgEY2j7vVWeKHvmqPYnjqrSs3k8230Y97ng
	JIbp4AsOKXcpMTc2GlSCymKhawwtxVHLQZDOiKxobN8m8gdAlc+NrAMxK29GLViOXLUPmQ1MStQ
	HEJLosiw=
X-Google-Smtp-Source: AGHT+IGonKs3uk6txbTNv8Opl1SZz4mSoEX/Aqa3IgUbiJh7FyjWtslUZVfknvYursYWSRHo26UZ2g==
X-Received: by 2002:a17:902:c943:b0:224:216e:38bd with SMTP id d9443c01a7336-2242b167d52mr4033695ad.5.1741317724375;
        Thu, 06 Mar 2025 19:22:04 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8a86sm19847605ad.240.2025.03.06.19.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:22:03 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
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
Subject: [PATCH v3 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
Date: Fri,  7 Mar 2025 11:21:16 +0800
Message-Id: <20250307032118.30364-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250307032118.30364-1-wuyun.abel@bytedance.com>
References: <20250307032118.30364-1-wuyun.abel@bytedance.com>
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
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19ae870cbeda..a5b58da629ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8787,9 +8787,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (test_tsk_need_resched(rq->curr))
 		return;
 
-	if (!sched_feat(WAKEUP_PREEMPTION))
-		return;
-
 	find_matching_se(&se, &pse);
 	WARN_ON_ONCE(!pse);
 
@@ -8808,6 +8805,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
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


