Return-Path: <linux-kernel+bounces-518794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8312A394CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C2E172246
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F991DDC07;
	Tue, 18 Feb 2025 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpweTvwy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6831DE3DE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866420; cv=none; b=dMz4NfvJbVgp+37mNoqjBlaIfEfj40TQzekj9au/uQkWq25gzhIxVL5y440DMOOKBeLJMXLpkNTVq4R4UZh9qZwtVc2jIzL9AKelgZFQSADtkAm7bj2KW6UY4f+TDuIEiaQm5W2ZM2z7AOZ3Q6nr1Fcfbw0ItXgw1RhmF104JAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866420; c=relaxed/simple;
	bh=FeDPXmXTmYh9CxP7c2GGmkAgMjeQEUgtNcK3TPj56PQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=birvNtk4SkMKwSSw9hs3BOldCZkV2JvxzsqOWeBrd7sB09LwhTGMxK4K+VgQKyBJVadGRZ33uMdrEU3TR5FZSKMGxQ6hzNU0iLJEoiYzV22UfKlg733BLrmaF0Kzearzfd3oO/Gh+WHCdsuCYvWgFXsvW9gpA5id2HFPVXPU1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpweTvwy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739866416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FeDPXmXTmYh9CxP7c2GGmkAgMjeQEUgtNcK3TPj56PQ=;
	b=GpweTvwynn7FwZqddfuOc4QfHhUYbi7cAYFislvq11QprvSRvdgGuxAvu8Dy58NzcsDWze
	8fQ91lHwNw3s00gsmfU9yvQZHy2bWhI6/R2tkpCRBh8Hw8Ejzvvkn6EeNTPpem4nOdd/mN
	tgY1VXBojky6ut5KJJLQhjAgXcjOZ48=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-3OgLRZtaMFycGYZO_roe8g-1; Tue, 18 Feb 2025 03:13:35 -0500
X-MC-Unique: 3OgLRZtaMFycGYZO_roe8g-1
X-Mimecast-MFC-AGG-ID: 3OgLRZtaMFycGYZO_roe8g_1739866414
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso28344155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866414; x=1740471214;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeDPXmXTmYh9CxP7c2GGmkAgMjeQEUgtNcK3TPj56PQ=;
        b=EmZGLi8t4CV6JGKdjazYb+sEuysVFhw2A1lgaghCz1rjqRLWO5vz9bf6ZIT2VuPEru
         5L6QEpIw+MUMI3YoJ3hVtIesJpnOAcngMNZiDgLqAJ/LgwJirgnvcYoZv5v186E1FMn/
         p/9gnB+W2q2mBI1Erse8MyNO1DalcuHQnVddSMZtdY3o8nn/4SKpgtonI5rM2t5Ktf5C
         ceBUTX4KsBfSci/vmiL+RWKLQf5LO6+45KjSu06OtK2wY2WEkYTLGFzc0z8LRoeQXI2E
         ChGqvrOi5X0mGS31mF9M7zGcjuMvvKbcs1Pk3z/+e0AyQiIhLj3I8W+UiNmJgkPAVf3t
         FGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK+498mh80+Y9JTOF1Y3/8ofR7wjxzLNEP66fVdJHpLoC5RArMFLHq1cN7P/tIdA0WCCTUm6RZnqyi0yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFimj148a/+/NksDFZso96it7o2t7a9+oSzXThqwgBlexrYbh
	VyzQhWfeJSr8TUd1Gi1PyprrIQMGNLbVSPeLuqJz/EoJ+zLKCIBaA0tVajhMymNS5TBF9n3PxaB
	GPLpYGwfQ31CYMvKXVC720q/jl6eK9WF45P0p7GdyH/cCqKN+scIBDRfYGZ82sw==
X-Gm-Gg: ASbGncsE4+zWfx9VRAmj2gLHnNDnn3JBKaNbKqz5sGRsqgJwmTRPr6rfZO8rlYqCLac
	nY3j5UTGi7t3wWMS5kcxrHfB0L16HleQ0J9TvDKLQYtn7mb9NydJIxKvg2bOjA7UaI/I4cRtQho
	ET4EZ9Gb68eaNzOrurLRZ2LKy/1d6thmWHWkuGwsdbU/EU49ep2nGsEKHewzS6xR2XN2dtY35X6
	GPGXvY5qiBWY3Jjvgv+/2Bninqyc+VeAugubrLsxwd8drogNzndgGy3+OY4mixo43FobQdZ9N25
	0T4itYKhxzGcr9V5UyYBU3R2N6ZF1rE=
X-Received: by 2002:a05:600c:4f46:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-4396e779e07mr116394235e9.30.1739866413761;
        Tue, 18 Feb 2025 00:13:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrAP6Lr5EnvBOX+TNpgY2fuT1PM1qaT+TtmaVcIXhRMIV8CzzlxMCmGOLAUMb8R8zxH9NVgA==
X-Received: by 2002:a05:600c:4f46:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-4396e779e07mr116393905e9.30.1739866413333;
        Tue, 18 Feb 2025 00:13:33 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b296afesm93839365e9.0.2025.02.18.00.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:13:32 -0800 (PST)
Message-ID: <e9ef4c7b2b979aec73f948cab33b5b4c0af4a804.camel@redhat.com>
Subject: Re: [PATCH 2/2] rseq/selftests: Add test for mm_cid compaction
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 "Paul E. McKenney"
	 <paulmck@kernel.org>
Date: Tue, 18 Feb 2025 09:13:31 +0100
In-Reply-To: <822a9d2b-a9f3-45b4-8cad-077489015301@efficios.com>
References: <20250217112317.258716-1-gmonaco@redhat.com>
	 <20250217112317.258716-3-gmonaco@redhat.com>
	 <822a9d2b-a9f3-45b4-8cad-077489015301@efficios.com>
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



On Mon, 2025-02-17 at 14:59 -0500, Mathieu Desnoyers wrote:
> On 2025-02-17 06:23, Gabriele Monaco wrote:
> > A task in the kernel (task_mm_cid_work) runs somewhat periodically
> > to
> > compact the mm_cid for each process. Add a test to validate that it
> > runs
> > correctly and timely.
> >=20
> > The test spawns 1 thread pinned to each CPU, then each thread,
> > including
> > the main one, runs in short bursts for some time. During this
> > period, the
> > mm_cids should be spanning all numbers between 0 and nproc.
> >=20
> > At the end of this phase, a thread with high enough mm_cid (>=3D
> > nproc/2)
> > is selected to be the new leader, all other threads terminate.
> >=20
> > After some time, the only running thread should see 0 as mm_cid, if
> > that
> > doesn't happen, the compaction mechanism didn't work and the test
> > fails.
> >=20
> > Since mm_cid compaction is less likely for tasks running in short
> > bursts, we increase the likelihood by just running a busy loop at
> > every
> > iteration. This compaction is a best effort work and this behaviour
> > is
> > currently acceptable.
>=20
> I'm wondering what we can do to make this compaction scheme more
> predictable.
>=20
> The situation here is caused by the fact that the CID compaction
> only happens on scheduler tick. If the workload is periodic and
> runs in short bursts, chances are that the scheduler tick never
> issue task_tick_mm_cid() for a given process, so no compaction.
>=20
> So task_tick_mm_cid() basically does:
>=20
> void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct callback_head *wo=
rk =3D &curr->cid_work;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long now =3D ji=
ffies;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!curr->mm || (curr->=
flags & (PF_EXITING | PF_KTHREAD))
> ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
work->next !=3D work)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (time_before(now, REA=
D_ONCE(curr->mm->mm_cid_next_scan)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No page allocation un=
der rq lock */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 task_work_add(curr, work=
, TWA_RESUME | TWAF_NO_ALLOC);
> }
>=20
> So typically we have a "time_before()" check that is hit and
> paces the execution of this task_work every 100ms or so.
>=20
> If we have periodic tasks, that means those tasks are necessarily
> preempted so they are not current when the tick happens. If the
> task cares about compaction of mm_cid, it means it has returned
> to userspace after that preemption.
>=20
> Sooo, we happen to have code in kernel/rseq.c called exactly at
> that point:
>=20
> __rseq_handle_notify_resume()
>=20
> I wonder if we could perhaps just call task_tick_mm_cid() (or a
> version
> of it renamed to something more meaningful) from
> __rseq_handle_notify_resume() ? By combining time_before() checks
> from
> the scheduler tick and at return to userspace after preemption, AFAIU
> we'd be handling the periodic workload correctly, and therefore this
> test for mm_cid compaction could check for more robust guarantees.
>=20
> Thoughts ?

Alright,=C2=A0that seems better, since the task work already runs there
(resume_user_mode_work), it's only set as pending once we get the tick,
I agree that seems a bit redundant.

In this case I'd see calling the task_mm_cid_work where
rseq_handle_notify_resume is called and not the task_tick_mm_cid.

The way I see it, rseq_handle_notify_resume is behaving essentially
like a task_work with TWA_RESUME (setting TIF_NOTIFY_RESUME on its own
at syscalls, task switches and migrations). task_mm_cid_work, instead
sets TIF_NOTIFY_RESUME on ticks (via the task_work API). This last bit
could change, conceptually I mean, we probably don't want to use
task_work at all in such contexts.

Does this make sense to you?


However, I'm still not particularly fond of running stuff there at all.
If a periodic task needs to run now, it preempts everything else and
should be on its way as soon as possible. A task work is always going
to delay this, although by a tiny bit.

Again, for now I cannot think of a better way without bringing
workqueues into the picture, and in this specific case we have a valid
workaround to reduce the latency.

Thanks,
Gabriele


