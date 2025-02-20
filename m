Return-Path: <linux-kernel+bounces-523146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3EFA3D2B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819FE189B4F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFC41E411C;
	Thu, 20 Feb 2025 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZX06T6D7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D21A8F8E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038434; cv=none; b=TU7me6kjYfiabDStQS/CHAPAebCCWf5+S9PnMHZexG25+JsZUg5M5TcQwyVA153WcA1YMIrRhnOCZ6EfW/iS+fel0jMZhv+AbvLsD3Cw5Vc1YLSPRSp+Rp7L54TY07FC3WD5PXYkvXDW9sizLd3mbUfdun4KsrtTZJZg1FxGZ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038434; c=relaxed/simple;
	bh=ni5cBujq2HhDSr/l3QFaiba/7JfaRlXTdJoUovWgfTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hm/Eug83oSPEg5kt6cxFZY/mCNQp7WgGZZ+FNyaSL9k0VuFpLFz55h02BxqDknTOaDeYUwmNUQu31K8iFe+gEUHLykah2/2hDj+2Hm2Nr2foqxYoooDW/hgtyIAZBXyovXyEH1a7Sj9DsU6rm+oTwoh3ihwTnJ3u3eb2VjN77Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZX06T6D7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740038431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ni5cBujq2HhDSr/l3QFaiba/7JfaRlXTdJoUovWgfTo=;
	b=ZX06T6D78iu6cpSPCpTrmNcNfpwzfT4DYAaabZ8VQ+riIhNroZfG2qoIg+tlPvq3DYvy9K
	74IrsNEUHf0KQ+yhVV5ytV6tYSptGVtwp9qPce+dHVHqUIeAVisO/iLBa215TrNygH1yF1
	w8anvFE3I4ghNv2OsTzXrXpD8K9n210=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-penKVrnMPhWub2iOTmGtWA-1; Thu, 20 Feb 2025 03:00:29 -0500
X-MC-Unique: penKVrnMPhWub2iOTmGtWA-1
X-Mimecast-MFC-AGG-ID: penKVrnMPhWub2iOTmGtWA_1740038429
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399c5ba9e4so2788735e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740038428; x=1740643228;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ni5cBujq2HhDSr/l3QFaiba/7JfaRlXTdJoUovWgfTo=;
        b=WypAI+6rFN3Tgl22MupWIvisUdWwUH01USzhLreWhYDQmH1bGq22yeEHop6CmO5GOX
         HYy+jC+L3Xyk/seHPnlDb9oLazeWWsFtewx2iwXRFhFzqzKEhEQBKWEnDC+PPRPzuWKh
         09A1f+qbSt5Uj1zA5HHFUJNnbbuULU3nO7tKrBkn0cHWc16UdmriGdaPHJ3RJ+1qsoMI
         elgHH+7UzFut3qHy5rENL5dm8bTDRzNswurQHau8z0oJ2XRKbGVYFa3+CUw+4cUg0n6E
         x7zktPrjvdGhJMC4gZiaEB/ksw+pWgmLI8Z175WkcAwrx5BVtmezBzwrkIYRCxhMZppX
         RwXg==
X-Forwarded-Encrypted: i=1; AJvYcCXQS4zBMCs3QFgMOoyUh1C4Wf/6xkymyyCdqI3dgMTvFgqwtXDD0JFRS2Arr1cW+fMyRVZKwSCacIO3TwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzyarfpRe7E1XSXmw5u8+ngEIMozbHQVOuNgqP1Boc4T/qdAJV
	4SOb/9wG5PpDN/qxIxc1ZLrOywIVuqnnaG8W6vx6DH2oIg1RYK+R0WeLlvJ5TGk1PBlTCDzscdy
	Eu/N5SfdjFrvD4c/PQ+TwX1xcAjZ3ceyEw4FwV2Z6f3/vsk4vB4pqjTaJNpUNMw==
X-Gm-Gg: ASbGncumJ1pLFYGLocL5R2rxl2PBo9yDkNWs2A69Lx51Tx+DqWuxdaWO5E6sypJSKjH
	4tvzIZHJHwaiO3hH2vfVMbkTUiwz4rNxZ6eiyQj+RDljqLnKKx8Bb8q/AVAYFSca7LINIQUkMSc
	Bj/hxUYpJM3Exogs7dzV73fWWhEcHlX8urJkr0M2gyyivQJl/JB6DNNIC2o9pi+oKo9OxnkHh86
	eyBAUBgFz+pN2BATpyc2uo+ORXxmqGSVvnaZMAUbkVdUFZEBw2hp0LSmwwLaqr8LkswzSsoS6jY
	Zg28nl6WJ6/Ps9QiE8bWwz16PYAF3n0=
X-Received: by 2002:a05:600c:1d23:b0:439:9ac3:a8b3 with SMTP id 5b1f17b1804b1-4399ac3aa6cmr53537455e9.18.1740038428572;
        Thu, 20 Feb 2025 00:00:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVH07uirG3vhruI9DjqJFGGMUDyZrbRLPYo5k79VxfBffJ5WS/NvWyfz/b12nwm87jumBLtw==
X-Received: by 2002:a05:600c:1d23:b0:439:9ac3:a8b3 with SMTP id 5b1f17b1804b1-4399ac3aa6cmr53537135e9.18.1740038428130;
        Thu, 20 Feb 2025 00:00:28 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915146sm20145491f8f.56.2025.02.20.00.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:00:27 -0800 (PST)
Message-ID: <a6065d54390a8358cd4ed68acb803414e27a1ded.camel@redhat.com>
Subject: Re: [PATCH v7 1/2] sched: Move task_mm_cid_work to mm work_struct
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra	 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	linux-mm@kvack.org
Date: Thu, 20 Feb 2025 09:00:25 +0100
In-Reply-To: <0493b3c4-c37f-4ddd-93ee-6d7946e42846@efficios.com>
References: <20250219113108.325545-1-gmonaco@redhat.com>
	 <20250219113108.325545-2-gmonaco@redhat.com>
	 <8fc793e3-cdfc-4603-afe6-d2ed6785ffbb@efficios.com>
	 <86fad2bd-643d-4d3a-bd41-8ffd9389428b@redhat.com>
	 <0493b3c4-c37f-4ddd-93ee-6d7946e42846@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Wed, 2025-02-19 at 12:08 -0500, Mathieu Desnoyers wrote:
> On 2025-02-19 11:32, Gabriele Monaco wrote:
> >=20
> >=20
> > On Wed, 2025-02-19 at 10:13 -0500, Mathieu Desnoyers wrote:
> > > > On 2025-02-19 06:31, Gabriele Monaco wrote:
> > > > > > Currently, the task_mm_cid_work function is called in a
> > > > > > task work
> > > > > > triggered by a scheduler tick to frequently compact the
> > > > > > mm_cids of
> > > > > > each
> > > > > > process. This can delay the execution of the corresponding
> > > > > > thread
> > > > > > for
> > > > > > the entire duration of the function, negatively affecting
> > > > > > the
> > > > > > response
> > > > > > in case of real time tasks. In practice, we observe
> > > > > > task_mm_cid_work
> > > > > > increasing the latency of 30-35us on a 128 cores system,
> > > > > > this order
> > > > > > of
> > > > > > magnitude is meaningful under PREEMPT_RT.
> > > > > >=20
> > > > > > Run the task_mm_cid_work in a new work_struct connected to
> > > > > > the
> > > > > > mm_struct rather than in the task context before returning
> > > > > > to
> > > > > > userspace.
> > > > > >=20
> > > > > > This work_struct is initialised with the mm and disabled
> > > > > > before
> > > > > > freeing
> > > > > > it. Its execution is no longer triggered by scheduler
> > > > > > ticks: the
> > > > > > queuing
> > > > > > of the work happens while returning to userspace in
> > > > > > __rseq_handle_notify_resume, maintaining the checks to
> > > > > > avoid
> > > > > > running
> > > > > > more frequently than MM_CID_SCAN_DELAY.
> > > > > >=20
> > > > > > The main advantage of this change is that the function can
> > > > > > be
> > > > > > offloaded
> > > > > > to a different CPU and even preempted by RT tasks.
> > > > > >=20
> > > > > > Moreover, this new behaviour is more predictable with
> > > > > > periodic
> > > > > > tasks
> > > > > > with short runtime, which may rarely run during a scheduler
> > > > > > tick.
> > > > > > Now, the work is always scheduled when the task returns to
> > > > > > userspace.
> > > > > >=20
> > > > > > The work is disabled during mmdrop, since the function
> > > > > > cannot sleep
> > > > > > in
> > > > > > all kernel configurations, we cannot wait for possibly
> > > > > > running work
> > > > > > items to terminate. We make sure the mm is valid in case
> > > > > > the task
> > > > > > is
> > > > > > terminating by reserving it with mmgrab/mmdrop, returning
> > > > > > prematurely if
> > > > > > we are really the last user before mmgrab.
> > > > > > This situation is unlikely since we don't schedule the work
> > > > > > for
> > > > > > exiting
> > > > > > tasks, but we cannot rule it out.
> > > > > >=20
> > > > > > Fixes: 223baf9d17f2 ("sched: Fix performance regression
> > > > > > introduced
> > > > > > by mm_cid")
> > > > > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > > > > > ---
> > > > > > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > > > > > index 442aba29bc4cf..f8394ebbb6f4d 100644
> > > > > > --- a/kernel/rseq.c
> > > > > > +++ b/kernel/rseq.c
> > > > > > @@ -419,6 +419,7 @@ void __rseq_handle_notify_resume(struct
> > > > > > ksignal
> > > > > > *ksig, struct pt_regs *regs)
> > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0 if (unlikely(rseq_update_cpu_node_id(t)))
> > > > > > =C2=A0=C2=A0=C2=A0 goto error;
> > > > > > + task_queue_mm_cid(t);
> > > > > > =C2=A0=C2=A0=C2=A0 return;
> > > > > > =C2=A0=20
> > > > > > =C2=A0=C2=A0 error:
> > > > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > > > index 9aecd914ac691..ee35f9962444b 100644
> > > > > > --- a/kernel/sched/core.c
> > > > > > +++ b/kernel/sched/core.c
> > > > > > @@ -5663,7 +5663,6 @@ void sched_tick(void)
> > > > > > =C2=A0=C2=A0=C2=A0 resched_latency =3D cpu_resched_latency(rq);
> > > > > > =C2=A0=C2=A0=C2=A0 calc_global_load_tick(rq);
> > > > > > =C2=A0=C2=A0=C2=A0 sched_core_tick(rq);
> > > > > > - task_tick_mm_cid(rq, donor);
> > > >=20
> > > > I agree that this approach is promising, however I am concerned
> > > > about
> > > > the fact that a task running alone on its runqueue (thus
> > > > without
> > > > preemption) for a long time will never recompact mm_cid, and
> > > > also
> > > > will never update its mm_cid field.
> > > >=20
> > > > So I am tempted to insert this in the sched_tick to cover that
> > > > scenario:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rseq_preempt(current);
> > > >=20
> > > > This would ensure that the task runs
> > > > __rseq_handle_notify_resume() at
> > > > least each tick.
> > > >=20
> >=20
> > Right, I thought about this scenario but forgot to add it in the
> > final patch.
> > We could have a test doing that: instead of sleeping, the task busy
> > waits.
> >=20
> > Does __rseq_handle_notify_resume need to run in this case, besides
> > for the cid compaction, I mean? Otherwise we could again just
> > enqueu
> > the work from there.
>=20
> Yes we need to do both:
>=20
> - compact cid,
> - run __rseq_handle_notify_resume to update the mm_cid.
>=20
> We we don't care much if compacting the cid is done at some point
> and __rseq_handle_notify_resume only updates the mm_cid field on
> the following tick.
>=20
> So enqueuing the work is not sufficient there, I would really
> issue rseq_preempt(current) which makes sure a busy thread both
> triggers cid compaction *and* gets its mm_cid updated.
>=20

Sure, will do.

I've been trying to test this scenario but it's quite hard to achieve.
I set all threads to FIFO and highest priority, removed all system
calls from the leader thread (even the ones to wait for other threads)
and replaced the usleep with a busy wait, running on a VM so not=C2=A0sure
if interrupts can bother. The test still passes..

Anyway it seems a reasonable situation to happens and I guess it won't
hurt to just run an rseq_preempt in the tick.

Testing and sending V8 without touching the selftest.

Thanks,
Gabriele


