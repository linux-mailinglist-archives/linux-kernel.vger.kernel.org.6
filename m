Return-Path: <linux-kernel+bounces-423762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF989DAC68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11D5281E61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF7E200BBA;
	Wed, 27 Nov 2024 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpVwA8uA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E36201017
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728453; cv=none; b=e9xdo35k9mYHCGuqzmVYDhuta6p8WOSOZHrjGR1l0DXw8tuKKaJBu/ZTrMCfr+yxnuBxgERLBoKtFoIX9b3OT8JwvYLfWxDjt4EL5HZ1xCr7sv9K16nz0sKw0U/dKLtVhU7kyebZGKQ9vlA+5Ea8ma5fUS7L6bT8TuJdtgaSnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728453; c=relaxed/simple;
	bh=84k0kHnTdC3L+4g7efXnw/e520GNE2hshbg8krGIP5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfgT4wHXzj7a0LLy+iNzBIlDnjc5zZjXsMZfMGBLcb3ZP1PcZTOvkJSLOEIDaX00Tt1eSknTxkontLs0yPWOI6OPva+ddKuMAaJFkJjtjCLmfL5BOSVhPMUjR0SsHYApVSS9UZo4xncrwOk8lx0bJSy66VG9Id7PIqJhZcHy00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpVwA8uA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732728450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=beOnUcZGQU2mrcIYvueq6R+cVXgzH9B5DJtHxbHnrQM=;
	b=YpVwA8uAhGpAgB5M35KtDYBImfiFXGeOml28AgJnaglrS46xRoZY+TpZcyM4DcgJl8Hc51
	60Zs8DO2xcmhtSk9Nn1JucG3+Uxn1sweCrlcpKzBxuZOH45DKiBNNiBrplJ/i3PxwhtuHh
	pM5gTxpWzCVNfGnBvXgD3oOrRw5nRe4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-z_JTpAvDMEq08wmF_vb-6Q-1; Wed, 27 Nov 2024 12:27:28 -0500
X-MC-Unique: z_JTpAvDMEq08wmF_vb-6Q-1
X-Mimecast-MFC-AGG-ID: z_JTpAvDMEq08wmF_vb-6Q
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-466acb9f16dso26631211cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728448; x=1733333248;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beOnUcZGQU2mrcIYvueq6R+cVXgzH9B5DJtHxbHnrQM=;
        b=DuCxxICrNTTQKCQT/IwpjJyN0SReJmWfsS50KznL6650Ia1zQQoL8lKNAoA7FMl8n6
         K7xoIIT1DmtIw0Aywys0D9f5Gsb8ZHO5vnv/7ut9zUhBBjx4kCmU6a6mX07dKQDoWcEj
         DYqMrRFt3luSCaI60V/0WYK2XZiN4w0xVUItTX0Vx/WG/nnxVkTEWva2Kg67ZTeDjDvI
         vFb5qn1R1RjD8sdcwQzBjnkygB44apdP0HNP5QElQf3uKRF0QiEPQrAqDpKlwlheAd1b
         0ENoPvgmAD+g6ZEm2YxTXJjeRTIEI+H/7htjwWRZrnyXsN1qwvOT+DaniaI/TkekVagR
         2URg==
X-Forwarded-Encrypted: i=1; AJvYcCXLZm7cUshh6G87kd6yUJdlCrUSaYYjorDIxnI1U6w0bjCshgCPrTem16VMDcQ1LIJxyn5sSWc+/Tg4av0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHu7jImKYdkj2URaMUd/w7BfTCp9CP8QkcneHzXWaN8naKu80v
	lVGJGbzL+WbVM09g4F60mSeSXV94Ue3mW/Fh4Occ5egs1b7PIwMLpfCuwYliDDaaZOXLoStEotB
	nt+n96RkHOp0EC4z8/FlMJXaSvL4oayI42lB6TVDuDSnx1mMA424GtshoZwtu2c/E4ixc0kIRee
	ERWcDNi/xCy8ycVPWVgJhVcK8iI/uStGc2abBW2S8T9I4Qpw==
X-Gm-Gg: ASbGncuGeyrinzdM+tClhAJrsnxwEWy8kYUPSdVJc3YTu5DxpOpfjSKUZ+ObhLYWVBJ
	Jjtt1em9IGahAnNUsA6ypZHBmD1EPXZG6JuiFsKaGP7NN1rHsWIZGjBEoEloSXGzLn/0bBdRPFC
	NfOF7vlcgZWxSgLfTUL/zxHvvo7biBgNpRbqV9HsgF5RkSpMUAt6NtWKOlcizzZwYVHZODoKM2i
	WxleZKHjlkAfIrZ6ftN5zrKrNwwaxuTT+D2csbx/n8ARy4N9Htp7YKPZVA8COe4iM1Mn/Pz1xMz
	Uh1FIWjVURduHe3Svrm6FlZn1wHGiEyXNyc=
X-Received: by 2002:a05:622a:1341:b0:463:1677:c09 with SMTP id d75a77b69052e-466b35ea5femr68921751cf.23.1732728447853;
        Wed, 27 Nov 2024 09:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+fAMgcLzUudgIW52TJuWeKGmuj/kR1YAzG3qMwrZjsvPqzOjlYx5DSJYQMYJ3GaA+mF1VrQ==
X-Received: by 2002:a05:622a:1341:b0:463:1677:c09 with SMTP id d75a77b69052e-466b35ea5femr68921251cf.23.1732728447440;
        Wed, 27 Nov 2024 09:27:27 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46682eee51bsm48523711cf.82.2024.11.27.09.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 09:27:26 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Chenbo Lu
 <chenbo.lu@jobyaviation.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, mingo@redhat.com,
 juri.lelli@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Performance Degradation After Upgrading to Kernel 6.8
In-Reply-To: <20241120090354.GE19989@noisy.programming.kicks-ass.net>
References: <CACodVevaOp4f=Gg467_m-FAdQFceGQYr7_Ahtt6CfpDVQhAsjA@mail.gmail.com>
 <20241120090354.GE19989@noisy.programming.kicks-ass.net>
Date: Wed, 27 Nov 2024 18:27:23 +0100
Message-ID: <xhsmhzflkmvt0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damn, I wrote a reply on the 20th but seems like I never sent it. At least
I found it saved somewhere, so I don't have to rewrite it...

On 20/11/24 10:03, Peter Zijlstra wrote:
> On Tue, Nov 19, 2024 at 04:30:02PM -0800, Chenbo Lu wrote:
>> Hello,
>> 
>> I am experiencing a significant performance degradation after
>> upgrading my kernel from version 6.6 to 6.8 and would appreciate any
>> insights or suggestions.
>> 
>> I am running a high-load simulation system that spawns more than 1000
>> threads and the overall CPU usage is 30%+ . Most of the threads are
>> using real-time
>> scheduling (SCHED_RR), and the threads of a model are using
>> SCHED_DEADLINE. After upgrading the kernel, I noticed that the
>> execution time of my model has increased from 4.5ms to 6ms.
>> 
>> What I Have Done So Far:
>> 1. I found this [bug
>> report](https://bugzilla.kernel.org/show_bug.cgi?id=219366#c7) and
>> reverted the commit efa7df3e3bb5da8e6abbe37727417f32a37fba47 mentioned
>> in the post. Unfortunately, this did not resolve the issue.
>> 2. I performed a git bisect and found that after these two commits
>> related to scheduling (RT and deadline) were merged, the problem
>> happened. They are 612f769edd06a6e42f7cd72425488e68ddaeef0a,
>> 5fe7765997b139e2d922b58359dea181efe618f9
>
> And yet you failed to Cc Valentin, the author of said commits :/
>
>> After reverting these two commits, the model execution time improved
>> to around 5 ms.
>> 3. I revert two more commits, and the execution time is back to 4.7ms:
>> 63ba8422f876e32ee564ea95da9a7313b13ff0a1,
>> efa7df3e3bb5da8e6abbe37727417f32a37fba47
>> 
>> My questions are:
>> 1.Has anyone else experienced similar performance degradation after
>> upgrading to kernel 6.8?
>
> This is 4 kernel releases back, I my memory isn't that long.
>
>> 2.Can anyone explain why these two commits are causing the problem? I
>> am not very familiar with the kernel code and would appreciate any
>> insights.
>
> There might be a race window between setting the tro and sending the
> IPI, such that previously the extra IPIs would sooner find the newly
> pushable task.
>
> Valentin, would it make sense to set tro before enqueueing the pushable,
> instead of after it?

Urgh, those cachelines are beyond cold...

/me goes reading

Ok yeah I guess we could have this race vs

rto_push_irq_work_func()
`\
  rto_next_cpu()

Not sure if that applies to DL too since it doesn't have the PUSH_IPI
thing, but anyway - Chenbo, could you please try the below?
---
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a702f1a61..270a25335c4bc 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -602,16 +602,16 @@ static void enqueue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 
 	WARN_ON_ONCE(!RB_EMPTY_NODE(&p->pushable_dl_tasks));
 
+	if (!rq->dl.overloaded) {
+		dl_set_overload(rq);
+		rq->dl.overloaded = 1;
+	}
+
 	leftmost = rb_add_cached(&p->pushable_dl_tasks,
 				 &rq->dl.pushable_dl_tasks_root,
 				 __pushable_less);
 	if (leftmost)
 		rq->dl.earliest_dl.next = p->dl.deadline;
-
-	if (!rq->dl.overloaded) {
-		dl_set_overload(rq);
-		rq->dl.overloaded = 1;
-	}
 }
 
 static void dequeue_pushable_dl_task(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index bd66a46b06aca..1ea45a45ed657 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -385,6 +385,15 @@ static inline void rt_queue_pull_task(struct rq *rq)
 
 static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
 {
+	/*
+	 * Set RTO first so rto_push_irq_work_func() can see @rq as a push
+	 * candidate as early as possible.
+	 */
+	if (!rq->rt.overloaded) {
+		rt_set_overload(rq);
+		rq->rt.overloaded = 1;
+	}
+
 	plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
 	plist_node_init(&p->pushable_tasks, p->prio);
 	plist_add(&p->pushable_tasks, &rq->rt.pushable_tasks);
@@ -392,15 +401,15 @@ static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
 	/* Update the highest prio pushable task */
 	if (p->prio < rq->rt.highest_prio.next)
 		rq->rt.highest_prio.next = p->prio;
-
-	if (!rq->rt.overloaded) {
-		rt_set_overload(rq);
-		rq->rt.overloaded = 1;
-	}
 }
 
 static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
 {
+	/*
+	 * To match enqueue we should check/unset RTO first, but for that we
+	 * need to pop @p first. This makes this asymmetric wrt enqueue, but
+	 * the worst we can get out of this is an extra useless IPI.
+	 */
 	plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
 
 	/* Update the new highest prio pushable task */


