Return-Path: <linux-kernel+bounces-514464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB456A3575C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BF3166C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1BC202F93;
	Fri, 14 Feb 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7n+O2rX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCABF1FFC47
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515464; cv=none; b=siUXQJyZI7w4lv3EOgblUCe3B2lQq31NhO3Qz62+h9eR2dhcF91ZSIwMObLYGpYV3Ll96LKUHyxqBQRoucyLOicLMH4gG0CMS/dvIWZEczwmvrGE3VAyFTh3q3XuImm3q2w9BJckwKmBR0qmD1UDrR4exMKGHCAgw65WgMah0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515464; c=relaxed/simple;
	bh=XihkKkwRTgcC1tBSr2qqSHWBzOdbjJF6xX07acAUnTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uJU7P1Ol0if1htlZu/Jo5Vv2vqO2GkVPG4yS+4L6F7PSuQQPgOoBdCUl5TwOURRAXdUQk20lI1h8CE4uuXYtmsUsJOTkmvB5phvDvdAsBebWwBQIjdsZZbwkUhSE7msijUkpCNLsfKKi5gZv7trs6r7b6ENanqMl7dHXnMfP6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7n+O2rX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739515461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XihkKkwRTgcC1tBSr2qqSHWBzOdbjJF6xX07acAUnTs=;
	b=g7n+O2rXEkdEkN9jpaIhqlRaa4cpgrpQscI+hYlEAYByK9f8alvJB1koIF6WITK8AsyYCj
	SsyKJ6xwHcYHFfU3yn2kSpY5OnxF21JvympkvoHz5S4x8SfsN6NPg8xr8UduUzaGSOZz/H
	3xgTtRkmmPg65xNkGoZw6p8TbeKHdQo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-qysHMD8tOXSdei4YvB4i_w-1; Fri, 14 Feb 2025 01:44:18 -0500
X-MC-Unique: qysHMD8tOXSdei4YvB4i_w-1
X-Mimecast-MFC-AGG-ID: qysHMD8tOXSdei4YvB4i_w_1739515457
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4395b5d6f8fso9085835e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739515457; x=1740120257;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XihkKkwRTgcC1tBSr2qqSHWBzOdbjJF6xX07acAUnTs=;
        b=eHVrnha1mlprcI4C264tIGhEVleu/sMIpewvBeknt+bSVzBR3UhXVfcuueAmXAEKS+
         S0Ae9+iF87tq5/zEsEyYlptoQONsZ3c8EbDo+GZ916wMy/9GTd5ragQVsjnmGz34jdlv
         JLqCR1aOavWPZO40nk+KCNwu7f1JaU4mt2Hfi0UbvYDcSwTkpRF4H3/TiMTA1Mkj4xw1
         00ApWoBIc3O06OvWIDEViTJqp1edW7Ae4aqev/tE+2il+wWDvEkX9r7EGZTKJt4kqD6M
         zdf1/Azc4YcSn43FFTjHZPAxEh7vy1/CnkScSd193JINmmT35qZ3Ih6XtXLKeayx3bDz
         qY0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNSLoXdF0KdDG/hvvuOC5zOivkierlTPUbyu7msgucZh39SIXPAp0cVoE45F0J1eEIOPmPyACRKwgQASA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCm/dIBdOgz39YNe+ZANdC6PYHv5zYypqjACG+9gN/ikgH2aA
	hERCUTaOfV+D9JtvzjHWRB4X3AAc5jE8HGOamSpEOVqfvJYa2wdcjDxtHPPwcRil1Q9VZQWdzcy
	y1cu78X3IxwtufM3xwfDREzKT4dTwbVq72MgAomExcekz4YYMWlAagp0BQFx42Q==
X-Gm-Gg: ASbGncuHLWp8QegmbDBa7ZfNIbdJ6/q2q0JFXAtte06tXA/krxUNY2SBTW/2Hw43UYe
	ZCoc2LYtOMi0gnRryi7F/7dTVk1H3uhGY9IleXZMbTURi5NeWbH6Mka8qLl+VY/YYwjc/p209Zi
	uj2OKfFbFtzvt5dwhtqxUkJc+NwRNNRNbTtNSSt89LaiQLEsaTr5h7PFgmFQWwlR9M29g6QuUPG
	700FeJC9xG1H3A4z380FZZiV+Uwv0BOCJ1PT6HggyhmvSCl6AYuM0F/1lkJRUFnQS8I6qWaEqWi
	tyuLSdeutZ6MVnIUsJKRwq4IY6jj3A0=
X-Received: by 2002:a05:600c:5491:b0:439:4036:e925 with SMTP id 5b1f17b1804b1-43960179ba8mr97826495e9.11.1739515456625;
        Thu, 13 Feb 2025 22:44:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+4qyDYkNuw8fexMMX5Tv8MINKZo1rNtIj/rzbP3sO9nv/Yi7cp+xrxqZ2bhBRgtfshVQgtA==
X-Received: by 2002:a05:600c:5491:b0:439:4036:e925 with SMTP id 5b1f17b1804b1-43960179ba8mr97826195e9.11.1739515456190;
        Thu, 13 Feb 2025 22:44:16 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43960e937c7sm23906515e9.3.2025.02.13.22.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 22:44:15 -0800 (PST)
Message-ID: <ed5ff8e242c7abb760f408b4fea9701d9b39d08d.camel@redhat.com>
Subject: Re: [PATCH v6 2/3] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, aubrey.li@linux.intel.com, yu.c.chen@intel.com,
 Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar	 <mingo@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Shuah Khan	 <shuah@kernel.org>
Date: Fri, 14 Feb 2025 07:44:13 +0100
In-Reply-To: <0888d6a3-8dea-455b-893f-d8d929e827e2@efficios.com>
References: <202502131405.1ba0803f-lkp@intel.com>
	 <17bda9071b6962414f61668698fa840501819172.camel@redhat.com>
	 <0888d6a3-8dea-455b-893f-d8d929e827e2@efficios.com>
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



On Thu, 2025-02-13 at 12:31 -0500, Mathieu Desnoyers wrote:
> On 2025-02-13 08:25, Gabriele Monaco wrote:
> > On Thu, 2025-02-13 at 14:52 +0800, kernel test robot wrote:
> > > kernel test robot noticed
> > > "WARNING:at_kernel/workqueue.c:#__queue_delayed_work" on:
> > >=20
> > > [=C2=A0=C2=A0=C2=A0 2.640924][=C2=A0=C2=A0=C2=A0 T0] ------------[ cu=
t here ]------------
> > > [ 2.641646][ T0] WARNING: CPU: 0 PID: 0 at
> > > kernel/workqueue.c:2495
> > > __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9))
> > > [=C2=A0=C2=A0=C2=A0 2.642874][=C2=A0=C2=A0=C2=A0 T0] Modules linked i=
n:
> > > [=C2=A0=C2=A0=C2=A0 2.643381][=C2=A0=C2=A0=C2=A0 T0] CPU: 0 UID: 0 PI=
D: 0 Comm: swapper Not
> > > tainted
> > > 6.14.0-rc2-00002-g287adf9e9c1f #1
> > > [=C2=A0=C2=A0=C2=A0 2.644582][=C2=A0=C2=A0=C2=A0 T0] Hardware name: Q=
EMU Standard PC (i440FX +
> > > PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > [ 2.645943][ T0] RIP: 0010:__queue_delayed_work
> > > (kernel/workqueue.c:2495 (discriminator 9))
> >=20
> > There seem to be major problems with this configuration, I'm trying
> > to
> > understand what's wrong but, for the time being, this patchset is
> > not
> > ready for inclusion.
>=20
> I'm staring at this now, and I'm thinking we could do a simpler
> change
> that would solve your RT issues without having to introduce a
> dependency
> on workqueue.c.
>=20
> So if the culprit is that task_mm_cid_work() runs for too long on
> large
> many-cpus systems, why not break it up into smaller iterations ?
>=20
> So rather than iterating on "for_each_possible_cpu", we could simply
> break this down into iteration on at most N cpus, so:
>=20
> tick #1: iteration on CPUs 0 ..=C2=A0=C2=A0 N - 1
> tick #2: iteration on CPUs N .. 2*N - 1
> ...
> circling back to 0 when it reaches the number of possible cpus.
>=20
> This N value could be configurable, e.g. CONFIG_RSEQ_CID_SCAN_BATCH,
> with a sane default. An RT system could decide to make that value
> lower.
>=20
> Then all we need to do is remember which was that last observed cpu
> number in the mm struct, so the next tick picks up from there.
>=20
> The main downside of this approach compared to scheduling delayed
> work in a workqueue is that it depends on having the mm be current
> when
> the scheduler tick happens. But perhaps this is something we could
> fix
> in a different way that does not add a dependency on workqueue. I'm
> not
> sure how though.
>=20
> Thoughts ?

Mmh, that's indeed neat, what is not so good about this type of task
work is that it's a pure latency, it will happen before scheduling the
task and can't be interrupted.
The only acceptable latency is a bounded one and your idea is going in
that direction.

As you mentioned, this will make the compaction of mm_cid even more
rare and will likely have the test in 3/3 fail even more often, I'm not
sure if this is necessarily a bad thing though, since mm_cid compaction
is mainly aesthetic, so we could just increase the duration of the test
or even add a busy loop inside to make the task more likely to run this
compaction.

I gave a thought about this whole thing, don't take this too seriously,
but what I see essentially flawed in this approach is:
1. task_works are set on tick
2. task_works are run returning to userspace

1. is the issue with frequency and 2. can be mitigated by your idea,
but not essentially solved. What if we (also) did:
1+. set this task_work while switching in
2+. run this task_work while switching out to sleep (i.e. no
preemption)

1+. would make sure all threads have this task_work scheduled at a
certain point (perhaps a bit too much, but we have a periodicity check
in place). 2+. can effectively run the task in a moment when it is not
problematic for the real time response: on a preemptible kernel, as
soon as a task with higher priority is ready to run, it will preempt
the currently running one, the fact current is going to sleep willingly
implies there's no higher priority task ready, so likely no task really
caring about RT response is going to run after.
Not all tasks are ever going to sleep, so we must keep the original
TWA_RESUME in the task_work, especially for those long-running or low-
priority, both unlikely to be RT tasks.

I'm going to try a patch with this CONFIG_RSEQ_CID_SCAN_BATCH and
tuning the test to pass. In the future we can see if those ideas make
sense and perhaps bring them in.

Thanks,
Gabriele


