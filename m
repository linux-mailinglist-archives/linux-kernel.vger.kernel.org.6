Return-Path: <linux-kernel+bounces-256564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A26E93503F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2441C20E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C5414533D;
	Thu, 18 Jul 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RalfMmnf"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33C144D0F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318171; cv=none; b=NxTX521kKmQAyg/NZqr0+YRTn4BEJDbumSo1y3uCDp45020VPHif78s90XNOJ9LkgbTJ1XIg0EoUO9468tojeu0ASEuVWT82yhEyKT7hcX8QQSkQlcEbp5PyByA0ID3wgTC9wQUsP76sGvH8r2+ZKMR2RfddHQH/gQut4EhEVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318171; c=relaxed/simple;
	bh=1pOANHGT3ZDBfZJaJvyg3dRQGTHF5cppcYVLUfHUi3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raavbcLOSqAcV99qykK9YZ7m/hcEvYZ0maKezuK+rEI22Z57+HFPAUzz5HsdV/8U7jd5x+foMwveo2prPJu/7wxT6otDu1QpOP5/b8thPrxnALp9FWMhCfqCunB/9bYnrQpKuF0RdzUys9Ti7du3l1MYlD24U65E7GLKc8oqRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RalfMmnf; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea929ea56so1039561e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721318168; x=1721922968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxgux2vbdZYB6RZEvo07oOPDR4FUj2S7XQtL1IHtKck=;
        b=RalfMmnfd8Hzx1eaniyp/RsHiZmIyAQGL4S3b+GgM5b03t9vtycPnXGeUGwbRsfPds
         12QtWTKT4STxESr3Ea31HS/G+QJDnhikM+kDu0JIn8B04FoeePIF6O0NT6CUGjZ68dzH
         kPWN0dByF2dR+4baU8+RqavouF06ztycPTo46OLuWYDV7JNxMky1Yf0zj0S7ahFpQLhp
         QKZyrkVPrDXB2My8RKksTsfIvU4nkRv4THU7Q+MPdo2nqCHmnhL+AGsV9WtGuBbc9PiY
         qGHjE9Z6jhD9aEgYREyZ6FCPlZoq7ybvps3PHDNmqMysied8nfgPqdQ49nXtYwOShIBz
         cS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721318168; x=1721922968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxgux2vbdZYB6RZEvo07oOPDR4FUj2S7XQtL1IHtKck=;
        b=Q6WKEIB4ML0yYwz5qA5ppOPXUwmsc34xjKxtdygbo6cnrd/0UNJb30fLTP8LKedUBd
         SLtQWlHJSwB+2oKcPDHskX+Zmc2yQkdNrqlJYPOZ7vQUy6JEBFHOOH7+Gf2CA2KhbNDU
         WCIP3wU7jYbnkzgV+JU2obFNVurWHKnEC2KmvbLGTkPE8Ad6M8cNPNXLx9qNrKqnwTsl
         0DU9ZYe21uBquwlYlKnJIJ2odYAEQCO4naRNfgo1WXKYrRz/6jklAxpspFVlxNINo/8f
         RrR+Ta0zM2GcAcVOk1dvgirXkhvQDXKi0V5dWdBBQKIqOIT7W01hXSsJaBTcDRZY8V9f
         GeJg==
X-Forwarded-Encrypted: i=1; AJvYcCWPNmfi8jK4uJN4kk4bneEJuf/XECvoRNN47COq7kozwdKby5sIVVkOZmCjCYyBlTJthnoMnlocxL9Ws1EE+M/W27Ds8SMW01ftz+pY
X-Gm-Message-State: AOJu0Yw7Eh90GnNiat+rsSLB3/Yehc8Z/2VEdSbG9MAn4YX+QeRU2whc
	gqJqm8ksW7oswgRj1aV/yq0yu2wHdHOLGQ9/iuF8J0DmJ4KhLkpdZUw/LvuTGM+3W90FFRd5EUq
	J8g4/Yv7HDLlfEb87ByL5M/4ysQmdx35pdcwl
X-Google-Smtp-Source: AGHT+IFPE0lghj2YZixrbpHmgxoF0kZ8549vynInTdXVmmjQgeXJvlltx3tprAguDK2P3x48GSK3zddRYlWRwkMyDkE=
X-Received: by 2002:a05:6512:1318:b0:52c:e05f:9052 with SMTP id
 2adb3069b0e04-52ee5435136mr4625806e87.47.1721318167063; Thu, 18 Jul 2024
 08:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org> <CAJD7tkaBKTiMzSkXfaKO5EO58aN708L4XBS3cX85JvxVpcNkQQ@mail.gmail.com>
 <c2ac13d7-f280-4be7-929a-d46c1dc7692c@kernel.org>
In-Reply-To: <c2ac13d7-f280-4be7-929a-d46c1dc7692c@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Jul 2024 08:55:28 -0700
Message-ID: <CAJD7tkZ5nxoa7aCpAix1bYOoYiLVfn+aNkq7jmRAZqsxruHYLw@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 1:12=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 17/07/2024 18.49, Yosry Ahmed wrote:
> > On Wed, Jul 17, 2024 at 9:36=E2=80=AFAM Jesper Dangaard Brouer <hawk@ke=
rnel.org> wrote:
> >>
> >>
> >> On 17/07/2024 02.35, Yosry Ahmed wrote:
> >>> [..]
> >>>>
> >>>>
> >>>> This is a clean (meaning no cadvisor interference) example of kswapd
> >>>> starting simultaniously on many NUMA nodes, that in 27 out of 98 cas=
es
> >>>> hit the race (which is handled in V6 and V7).
> >>>>
> >>>> The BPF "cnt" maps are getting cleared every second, so this
> >>>> approximates per sec numbers.  This patch reduce pressure on the loc=
k,
> >>>> but we are still seeing (kfunc:vmlinux:cgroup_rstat_flush_locked) fu=
ll
> >>>> flushes approx 37 per sec (every 27 ms). On the positive side
> >>>> ongoing_flusher mitigation stopped 98 per sec of these.
> >>>>
> >>>> In this clean kswapd case the patch removes the lock contention issu=
e
> >>>> for kswapd. The lock_contended cases 27 seems to be all related to
> >>>> handled_race cases 27.
> >>>>
> >>>> The remaning high flush rate should also be addressed, and we should
> >>>> also work on aproaches to limit this like my ealier proposal[1].
> >>>
> >>> I honestly don't think a high number of flushes is a problem on its
> >>> own as long as we are not spending too much time flushing, especially
> >>> when we have magnitude-based thresholding so we know there is
> >>> something to flush (although it may not be relevant to what we are
> >>> doing).
> >>>
> >>
> >> We are "spending too much time flushing" see below.
> >>
> >>> If we keep observing a lot of lock contention, one thing that I
> >>> thought about is to have a variant of spin_lock with a timeout. This
> >>> limits the flushing latency, instead of limiting the number of flushe=
s
> >>> (which I believe is the wrong metric to optimize).
> >>>
> >>> It also seems to me that we are doing a flush each 27ms, and your
> >>> proposed threshold was once per 50ms. It doesn't seem like a
> >>> fundamental difference.
> >>>
> >>
> >>
> >> Looking at the production numbers for the time the lock is held for le=
vel 0:
> >>
> >> @locked_time_level[0]:
> >> [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               =
|
> >> [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
|
> >> [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   =
|
> >> [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    =
|
> >>
> >> The time is in nanosec, so M corresponds to ms (milliseconds).
> >>
> >> With 36 flushes per second (as shown earlier) this is a flush every
> >> 27.7ms.  It is not unreasonable (from above data) that the flush time
> >> also spend 27ms, which means that we spend a full CPU second flushing.
> >> That is spending too much time flushing.
> >>
> >> This around 1 sec CPU usage for kswapd is also quite clear in the
> >> attached grafana graph for when server was rebooted into this V7 kerne=
l.
> >>
> >> I choose 50ms because at the time I saw flush taking around 30ms, and =
I
> >> view the flush time as queue service-time.  When arrival-rate is faste=
r
> >> than service-time, then a queue will form.  So, choosing 50ms as
> >> arrival-rate gave me some headroom.  As I mentioned earlier, optimally
> >> this threshold should be dynamically measured.
> >
> > Thanks for the data. Yeah this doesn't look good.
> >
> > Does it make sense to just throttle flushers at some point to increase
> > the chances of coalescing multiple flushers?
> >
> > Otherwise I think it makes sense in this case to ratelimit flushing in
> > general. Although instead of just checking how much time elapsed since
> > the last flush, can we use something like __ratelimit()?
> >
> > This will make sure that we skip flushes when we actually have a high
> > rate of flushing over a period of time, not because two flushes
> > happened to be requested in close succession and the flushing rate is
> > generally low.
> >
>
> I really think "time elapsed since the last flush" is the right solution
> here.  As, we *do* want to catch the case you describe "two flushes
> happened to be requested in close succession and the flushing rate is
> generally low."
>
> (After this patch fixing the lock contention triggered by kswapd).
> The remaining problem with kswapd is that those flushes that doesn't
> "collide" on the lock, will be flushing in close succession.  And we
> likely have a generally low flushing rate, until kswapd starts up.

I do not disagree, I think I may have misrepresented my intention.

Time since last flush is essentially ratelimiting to 2 flushes per
(let's say) 50 ms. So if we only have 2 flushes in an entire second,
but they happen to occur <50ms apart, the latter will be skipped
(arguably unnecessarily).

What I am trying to say is to make it more generalized/less-granular,
and apply ratelimiting when we are actually spending a large portion
of our time flushing. For example, cap it at 20 flushes per 1s. I
think __ratelimit() does exactly that, although it's currently mostly
used to ratelimit warnings, but I think we can reuse it here.

Ideally, of course, the number would be dynamic as you described
before, but we can start with a reasonable static value based on data.
What we do when the limit is hit could be changed later as well. We
can just skip flushes initially, and later we can be smarter about it
and throttle them in a way that makes them collide more effectively.

>
> Some production data from a "slow" period where only kswapd is active:
>
> 05:59:32 @ongoing_flusher_cnt[kswapd11]: 1
> @ongoing_flusher_cnt[kswapd7]: 1
> @ongoing_flusher_cnt[kswapd3]: 1
> @ongoing_flusher_cnt[kswapd5]: 1
> @ongoing_flusher_cnt[kswapd10]: 1
> @ongoing_flusher_cnt[kswapd6]: 2
> @ongoing_flusher_cnt[kswapd8]: 2
> @ongoing_flusher_cnt[kswapd1]: 2
> @ongoing_flusher_cnt[kswapd9]: 2
> @ongoing_flusher_cnt[kswapd0]: 2
> @ongoing_flusher_cnt[kswapd2]: 2
> @ongoing_flusher_cnt[kswapd4]: 2
> @ongoing_flusher_cnt[handled_race]: 2
> @ongoing_flusher_cnt[all]: 14
> @cnt[tracepoint:cgroup:cgroup_rstat_lock_contended]: 2
> @cnt[tracepoint:cgroup:cgroup_ongoing_flusher_wait]: 10
> @cnt[kfunc:vmlinux:cgroup_rstat_flush_locked]: 43
> @cnt[tracepoint:cgroup:cgroup_rstat_locked]: 51
>
> We observe that ongoing_flusher scheme saves/avoids 14 of the flushes
> great, but we still have 43 flushes in this period.  I think only kswapd
> is doing the flushing here, so I claim 41 flushes are likely unnecessary
> (as there are indication of 2 kswapd startups in the period).  Also
> observe that some of the kswapdNN processes only have
> ongoing_flusher_cnt 1, which indicate they didn't fully "collide" with
> an ongoing flusher, while others have 2.
>
> --Jesper

