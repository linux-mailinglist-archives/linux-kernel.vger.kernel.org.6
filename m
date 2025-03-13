Return-Path: <linux-kernel+bounces-558905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A48A5ECE5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D70217AED5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9C1FECBE;
	Thu, 13 Mar 2025 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ac/CWr6H"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35551FC0E9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850527; cv=none; b=TDLKm0tu7Xpuj80Qiqv/nYd/GAWKqiIiUHXZj1BCZ8Qx18xm91PG669Lp3OUG8SHlLgCrrDAdgNhFaC/RtNiO0w7ervxoi6EjpV/7JKcVfX3PyMFnXVb4uQ3aGnfnFTIa2OjZQvC2cK0I29WwWYMsdmsclUAyGGylmcm4sSsYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850527; c=relaxed/simple;
	bh=ABdjK49NUCTMY7T5xxi5URbrXzpCVmOiO3AOk1OmA3A=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnsGwLucfRdKMx32IMYAI9IfQR7gGhNjAMJFEFoaF47UNUiggyMy3o0HDZW66psM3IapFD0S3BzhYiPIS0z/Tj/Oa5MiH01WdcQlBnAYxkijrY4OcqYbTOQC2GZjuwchu3YKmvy5gJeaFdAaFBK7rSEdDexo4T+7q1+DkWkU7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ac/CWr6H; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso3118838a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741850524; x=1742455324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mpdHZooSnnkS+K92aYRbLN7CIlx+7CoXTHdbFnteGvg=;
        b=ac/CWr6HWNIzT/enpGrH0S9ZJwXv11081w7nJzu4u0CF+G8uBoB9FXCpsXNv4mol8V
         6KCR5WB8Zq/9ofQKFmFHeLzjdL1RDAKTkGDj4z/RVdPwUUBLgy3ubQij45vtrUWCjnY4
         OGaiyWfWRMAb4VwjWRV+RQJ9QLoQ9gfW/Y8u9XiDj18U4jQ5RU7I+2VU5xHY15BEEc8b
         p3ugvAlZWRs1bGHz8f74jeSaY0lCvZagxOpX/HlG+x+EIwKLpbweW5mS9D8drzydG1xH
         bgZCmxGz/feSH4Gcgcf50/lMnoauVlKdeU35BzdCKdKD8/UTodAWbedcoJ6/JiAxuhSN
         SXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850524; x=1742455324;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpdHZooSnnkS+K92aYRbLN7CIlx+7CoXTHdbFnteGvg=;
        b=CE1Y17iMm/aal3Aa8NOCTfPtBtrxFsB1TwHndvKotnAM/x98hVvvGz83wtJg60oY5v
         vYMgm27Xb1KEpZ0tFgU1GYidAqTigb0nWX53f4a7ZJd9VhNS3LSadEIZoABbwNJva266
         /lhWWz4ww0jnvyMvx8kdWuFkc3VMxoNRPGy96LfNUed1to9CyufpWxiqmihsIAkueeXW
         gABlNeYhb9I0CQ4WgDh2Ki9soSdbPUSMM6o7knA6GqUvNuhenuSOyfpUpzhzScwq+06K
         lDTQHCkwz2JawK2q2H7PyvCTTlXfTrsuzbVIVfTPxZC/vXM9oh+tcDGKpPZ+Bhsi5ag3
         6bgQ==
X-Gm-Message-State: AOJu0YwH7KILgAy2EpBEITpfZzehUHoKLUhnrBeCPIipYxDKlRlbp5MD
	U8CIuayrGR9Ohb03s4D+SJ6DMPGXaDEJRyc/vYFOXxNKM78ZtBK7akiDTbEzgrVMnwlESePbJLY
	2SskYEnipS+Lqj2kfF5CbQEPcNEVglLk0e8Wk
X-Gm-Gg: ASbGncslxrGL+g+ZF70VRhRA2DlFYUl0g6hnCo82VHgjY0IAondk+rH07tnrepD2ml8
	Z8G6l7HMA/mMqmoTu5p1IpzG6ZKloQfDAgQWPhsnnHVK8u9KIjymOtFpeFYaRRUUEtG3XDvyP0L
	NOyeWtH52atejUxO/MR9KvWu/3zq+zpOnojrMoPg==
X-Google-Smtp-Source: AGHT+IH+IMhoSkaWpJS5TRkmjFwrwbFe9U/nZkypYcakAA2YPfL6JqR499A40vDIj5a4m3lqPAs4L2zH2oBrrA5kvzs=
X-Received: by 2002:a05:6402:2805:b0:5db:e88c:914f with SMTP id
 4fb4d7f45d1cf-5e814d8e710mr1565687a12.4.1741850524075; Thu, 13 Mar 2025
 00:22:04 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Mar 2025 00:22:03 -0700
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Aaron Lu <ziqianlu@bytedance.com>
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
In-Reply-To: <20250313072030.1032893-1-ziqianlu@bytedance.com>
Date: Thu, 13 Mar 2025 00:22:03 -0700
X-Gm-Features: AQ5f1JqKcMI_Wdoy74ykvkqqoq0GJML9yKZWszLN8__AcBW_Ar7AZHPLoJbMPRM
Message-ID: <CANCG0GehTMm3sbtXMy9MMFtG=kPYpHiFwy63OO4+dmXh68bWfA@mail.gmail.com>
Subject: [RFC PATCH 6/7] sched/fair: fix tasks_rcu with task based throttle
To: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Taskes throttled on exit to user path are scheduled by cond_resched() in
task_work_run() but that is a preempt schedule and doesn't mark a task
rcu quiescent state.

Fix this by directly calling schedule() in throttle_cfs_rq_work().

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f26d53ac143fe..be96f7d32998c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5847,6 +5847,7 @@ static void throttle_cfs_rq_work(struct
callback_head *work)
 	struct cfs_rq *cfs_rq;
 	struct rq *rq;
 	struct rq_flags rf;
+	bool sched = false;

 	WARN_ON_ONCE(p != current);
 	p->sched_throttle_work.next = &p->sched_throttle_work;
@@ -5879,9 +5880,13 @@ static void throttle_cfs_rq_work(struct
callback_head *work)
 	dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
 	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
 	resched_curr(rq);
+	sched = true;

 out_unlock:
 	task_rq_unlock(rq, p, &rf);
+
+	if (sched)
+		schedule();
 }

 void init_cfs_throttle_work(struct task_struct *p)
-- 
2.39.5

