Return-Path: <linux-kernel+bounces-336044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21497EE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5D01C20D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3352199229;
	Mon, 23 Sep 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="am5M1dqD"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895C13D893
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106373; cv=none; b=Lzx+62W8L1XRih1bZtOQZ7+3e2gRRy3NAhJ9azgaWKEvB0KHiH0b4ZPd5hv4uqJEHVAeAZNfxBwpSjOwZIK5c01nwN2LcWORMZZKg5EgYLdrNOBkLAkOkTxbHnYpGB5pxAQb9wGizgG0Y56n30C3qpfpFfIGXQike1PftUhC8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106373; c=relaxed/simple;
	bh=C2xYYnW+/eBvgc3v+eP03xaZFfxQt6yM2oxQFwb5t2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ3Ul2VuQQcLDkKWpdcLYuCmvy9w1aouu03Z2yjFmbQNnl3tubhk4u3bi7gnJmEGl0U3xs2zcf8rOwf2jEqXDagJFLuML9pq+d7n/VTfh2+n1NpteIqYYwk1bKJ15acxB22hT0HWqM+maLIpf2ojEjIBWOuo0tiY4sOpnPQ4ThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=am5M1dqD; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c54a5fbceeso35429556d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727106368; x=1727711168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESYwXswqqcUH5BLw9hFh9aaHVtjhIWmKyClvFuaPqsg=;
        b=am5M1dqDlz8m446ULw5Oh8fwTWl3a/YfeiklT52UDem5fGr3Fz3jO9wIvdXO/fvLjM
         va5MlsUynImKHf4KEEU6odhpK+2wQNGYWqK6MWulVoHlymRVcdpZlG+6Mos4FLO7P9Ph
         toHASznLgKMsKmAHSySUkDUlbhoJf6zzbIlwVj/BR0fKq4DAqZFWeIBO1CX0+OCLK5/n
         TBTZF0ZeQeFkSAeTt0fLofN5zOVcAZOQy0Du4305JNZmZhvdeQvjI89lPsL23IHDwpxt
         kC3N7Q4OknfI4SwYqO23lzM9e8vBVRNh6jexQRVUfjrW89RZY7hUsQIkghOQZuuut8NO
         je7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106368; x=1727711168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESYwXswqqcUH5BLw9hFh9aaHVtjhIWmKyClvFuaPqsg=;
        b=d105gIrollHGmN2eXzgFjNCikN80VJkcByCld8n1UCwhuEgN3VBKWCr0bS8xCv6KUI
         ch20zpLEk1BwrzAXAD+fvZVc4PEeenFhrqV2ICIgMNSxex9XmJXkeCFYMDK2gNgImOOQ
         GyRwSUs/zq6Ye530b7Nf8QnBJx9fo2dj5gzFUAOWNghWY2Vth0O1P5nlK2pm47AcCkyn
         E9qAd2JNnoX4O7NfH5mqImFwCURJdzwD2cjKUzit5wCU8cTg3wj7QQTjVcz/54oUbFjA
         3sxtEfmqI3K08w1McMzy2a8ggSoR8tpJ6W1K2XCj0uPjYn5AYh/ZiZeyEQ3PKTLN+xcX
         4RtA==
X-Forwarded-Encrypted: i=1; AJvYcCUPVmo6x/x7W1tVZZsLKd8rVWxHqKyy/Z4v4nqrjHlcXsGX+q/Z9DWZQgOJydc2ijVHpaeodI4KEhvNUVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMh8QOgTsrCisx1JH8K6iMSZCX6iWOf4VORciV9zppWL8fW8HZ
	Du8HH3PLOD3zxLzuRccvE37+3v7xDBwMOGPDOrgJFR8Wvu4jvndvwZVtR/QaCU8=
X-Google-Smtp-Source: AGHT+IHPUR6EuXJsHNnKKFnokK0Em7hNPMb8rIhk8WEyODJzzOukPb0nF82ySC7C0nba/DeW5dzZjg==
X-Received: by 2002:a0c:f20a:0:b0:6c5:2a13:b8e1 with SMTP id 6a1803df08f44-6c7bc83bf00mr207859086d6.43.1727106368349;
        Mon, 23 Sep 2024 08:46:08 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e44bfc4sm48392486d6.2.2024.09.23.08.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:46:06 -0700 (PDT)
Date: Mon, 23 Sep 2024 11:46:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Parag W <parag.lkml@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	pmenzel@molgen.mpg.de, regressions@lists.linux.dev,
	surenb@google.com, tglx@linutronix.de
Subject: Re: Error: psi: inconsistent task state! task=1:swapper/0 cpu=0
 psi_flags=4 clear=0 set=4
Message-ID: <20240923154601.GC437832@cmpxchg.org>
References: <20240922102047.GA437832@cmpxchg.org>
 <20240923120339.11809-1-parag.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923120339.11809-1-parag.lkml@gmail.com>

On Mon, Sep 23, 2024 at 08:03:39AM -0400, Parag W wrote:
> FWIW, moving psi_enqueue to be after ->enqueue_task() in
> sched/core.c made no difference - I still get the inconsistent task
> state error. psi_dequeue() is already before ->dequeue_task() in
> line with uclamp.

Yes, that isn't enough.

AFAICS, in psi want to know when a task gets dequeued from a core POV,
even if the class holds on to it until picked again. If it's later
picked and dequeued by the class, I don't think there is a possible
call into psi. Lastly, if a sched_delayed task is woken and enqueued
from core, psi wants to know - we should call psi_enqueue() after
->enqueue_task has cleared sched_delayed.

I don't think we want the ttwu_runnable() callback: since the task
hasn't been dequeued yet from a core & PSI perspective, we shouldn't
update psi states either. The sched_delayed check in psi_enqueue()
should accomplish that. Oh, but wait: ->enqueue_task() will clear
sched_delayed beforehand. We should probably filter ENQUEUE_DELAYED?

This leaves me with the below diff. But I'm still getting the double
enqueue with it applied:

[root@ham ~]# dmesg | grep -i psi
[    0.350533] psi: inconsistent task state! task=1:swapper/0 cpu=0 psi_flags=4 clear=0 set=4

Peter, what am I missing here?

---

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b6cc1cf499d6..4f036c66cf07 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2012,11 +2012,6 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	if (!(flags & ENQUEUE_RESTORE)) {
-		sched_info_enqueue(rq, p);
-		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
-	}
-
 	p->sched_class->enqueue_task(rq, p, flags);
 	/*
 	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
@@ -2024,6 +2019,11 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	uclamp_rq_inc(rq, p);
 
+	if (!(flags & (ENQUEUE_RESTORE|ENQUEUE_DELAYED))) {
+		sched_info_enqueue(rq, p);
+		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
+	}
+
 	if (sched_core_enabled(rq))
 		sched_core_enqueue(rq, p);
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 237780aa3c53..138c52c2f2c9 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -129,6 +129,9 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	if (p->se.sched_delayed)
+		return;
+
 	if (p->in_memstall)
 		set |= TSK_MEMSTALL_RUNNING;
 
@@ -148,6 +151,9 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	if (p->se.sched_delayed)
+		return;
+
 	/*
 	 * A voluntary sleep is a dequeue followed by a task switch. To
 	 * avoid walking all ancestors twice, psi_task_switch() handles


