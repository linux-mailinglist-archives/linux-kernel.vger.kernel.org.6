Return-Path: <linux-kernel+bounces-227973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509B391592C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0721B284972
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B76C1A0B04;
	Mon, 24 Jun 2024 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GaXD+SM3"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D88F6B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265422; cv=none; b=rllowQ0wEvFAM2fbP32WMkMje1frLgfwnrCiTc4d6oF2lx6QrCJ5ERwCsTew9dJ2vsZjkzYUlYzASTm9ux0H2NuMw6qJCpKjX5dRWl4f2UQFN6J9AVOGtSyF+bbxkVlJp6avOjUqcu6aOfAaLuXnY5sq1y0WiCogj72cm4FUXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265422; c=relaxed/simple;
	bh=KBQQkF7jnFf1unx0i+gasghZQg9ERLHRTAKjxia0KvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIn1TSJjCGvf5Jbbis7LajZCQRZi1JrHAqlvOtC5SMwG+8UiCnjW+2UMbZ4QCSb81BeZchNslq+qfmgjumkrpS1Z0z1Urvhn3V9ai35vKgmJjw4/bjtkXgVDNc2PlW1qvnhTHguywPtnbLZvXr8pZtyhQnQfhozgRvd/z4iZAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GaXD+SM3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a72510ebc3fso221068166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719265419; x=1719870219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBQQkF7jnFf1unx0i+gasghZQg9ERLHRTAKjxia0KvA=;
        b=GaXD+SM3A3szjTCkbzNNfKLFwKJOEeIFNag9hRc2BYjLPOeAmGXUtqV50E3S35nGX1
         2q3t0hyeezv9MzUCOC3MVdOcwHZJpd7XkQlYJsjdrqjVWcqe9ONp8zg5IKm/4+Dj4y7C
         hDYtJJ+5wzJFnEd6vR91P0o6+vqd7+2yAYF/7kzqUf+jlYcRjrpj2GdcyLUsOmecRyHs
         VPRWkdAgNnjrKISMZG8BnvOF58osfxr3fvSBsojeM+KaivGEKyLU4qgOu1z1nLal8cP5
         IyTopg6ZOiz5NhbfE/E3DdnhgTYlWThKpK6WxgNEI0afHtj9ODB6TWqKirFBgfejPHXw
         7Qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719265419; x=1719870219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBQQkF7jnFf1unx0i+gasghZQg9ERLHRTAKjxia0KvA=;
        b=oZx4eOcWgkj8eEnrTjvzXG6zTByc0SiGzc4yGGd4Kym/4nuZ4/BHR4FZlUKbGEXQNo
         haJZk6Ri1lE3ww+BoLfssw95RwzGVZPDkFTKy4xS6RvdSwLHSIjFL5Nz8KTIFj1uToFJ
         4lf7j3WmOJ+eTePuSCWZlgAWZEsnRloeo5I50k1KP3QYpJmbdaDWaA1bOHXVBenfSwVV
         ov1avN8DukmDwTL2foj0ogY5DEDs+8y/4ZuHR77JbTGlb3bhJm3TKlbNrD8HzIsGM5K3
         QACz04un1TTQSRS2q2hKWVuN+Tiiq/UIlbllMAZttOswO2024RLktwrhhVOQ2vugEBHd
         JdLA==
X-Forwarded-Encrypted: i=1; AJvYcCXFxGX1n5g8097vmHot6VXK5MN327xjsMipKgL79X0Y0NTt/Q2l/c0FtCAwJ+9EiIfvboF9yOTNwXLcrO3YHPxRWZZVr7WtgnsJPifw
X-Gm-Message-State: AOJu0Ywd1ZLUeWmZZBnyooz/OBN48DlnEkrtSMsRfbr8hsIDJVPf/Cxo
	2K2TgJeaB7r2EuINrZH8Jp+W1aR+7/IpFzkNz5h40IfZeXRZ71N+tbUOXvntKl/A3JWr+u3vZ8L
	nyg53uHIH3EQrr4gnIz8c/3iBnpuj1Ol4TLpl
X-Google-Smtp-Source: AGHT+IHSGsOvZormRUjChRBfHCy0njIO3YyoJFfM96/78++UPsUyWr7g001iVi2mXjSIPG08qRLkYSTJbqmI4kZ4JGA=
X-Received: by 2002:a17:906:9814:b0:a70:c038:ed01 with SMTP id
 a640c23a62f3a-a7242c39c54mr413051766b.27.1719265418462; Mon, 24 Jun 2024
 14:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
 <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
 <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
 <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
 <CAJD7tkaJXNfWQtoURyf-YWS7WGPMGEc5qDmZrxhH2+RE-LeEEg@mail.gmail.com> <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
In-Reply-To: <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 14:43:02 -0700
Message-ID: <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 1:18=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jun 24, 2024 at 12:37:30PM GMT, Yosry Ahmed wrote:
> > On Mon, Jun 24, 2024 at 12:29=E2=80=AFPM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Mon, Jun 24, 2024 at 10:40:48AM GMT, Yosry Ahmed wrote:
> > > > On Mon, Jun 24, 2024 at 10:32=E2=80=AFAM Shakeel Butt <shakeel.butt=
@linux.dev> wrote:
> > > > >
> > > > > On Mon, Jun 24, 2024 at 05:46:05AM GMT, Yosry Ahmed wrote:
> > > > > > On Mon, Jun 24, 2024 at 4:55=E2=80=AFAM Jesper Dangaard Brouer =
<hawk@kernel.org> wrote:
> > > > > >
> > > > > [...]
> > > > > > I am assuming this supersedes your other patch titled "[PATCH R=
FC]
> > > > > > cgroup/rstat: avoid thundering herd problem on root cgrp", so I=
 will
> > > > > > only respond here.
> > > > > >
> > > > > > I have two comments:
> > > > > > - There is no reason why this should be limited to the root cgr=
oup. We
> > > > > > can keep track of the cgroup being flushed, and use
> > > > > > cgroup_is_descendant() to find out if the cgroup we want to flu=
sh is a
> > > > > > descendant of it. We can use a pointer and cmpxchg primitives i=
nstead
> > > > > > of the atomic here IIUC.
> > > > > >
> > > > > > - More importantly, I am not a fan of skipping the flush if the=
re is
> > > > > > an ongoing one. For all we know, the ongoing flush could have j=
ust
> > > > > > started and the stats have not been flushed yet. This is anothe=
r
> > > > > > example of non deterministic behavior that could be difficult t=
o
> > > > > > debug.
> > > > >
> > > > > Even with the flush, there will almost always per-cpu updates whi=
ch will
> > > > > be missed. This can not be fixed unless we block the stats update=
rs as
> > > > > well (which is not going to happen). So, we are already ok with t=
his
> > > > > level of non-determinism. Why skipping flushing would be worse? O=
ne may
> > > > > argue 'time window is smaller' but this still does not cap the am=
ount of
> > > > > updates. So, unless there is concrete data that this skipping flu=
shing
> > > > > is detrimental to the users of stats, I don't see an issue in the
> > > > > presense of periodic flusher.
> > > >
> > > > As you mentioned, the updates that happen during the flush are
> > > > unavoidable anyway, and the window is small. On the other hand, we
> > > > should be able to maintain the current behavior that at least all t=
he
> > > > stat updates that happened *before* the call to cgroup_rstat_flush(=
)
> > > > are flushed after the call.
> > > >
> > > > The main concern here is that the stats read *after* an event occur=
s
> > > > should reflect the system state at that time. For example, a proact=
ive
> > > > reclaimer reading the stats after writing to memory.reclaim should
> > > > observe the system state after the reclaim operation happened.
> > >
> > > What about the in-kernel users like kswapd? I don't see any before or
> > > after events for the in-kernel users.
> >
> > The example I can think of off the top of my head is the cache trim
> > mode scenario I mentioned when discussing your patch (i.e. not
> > realizing that file memory had already been reclaimed).
>
> Kswapd has some kind of cache trim failure mode where it decides to skip
> cache trim heuristic. Also for global reclaim there are couple more
> condition in play as well.

I was mostly concerned about entering cache trim mode when we
shouldn't, not vice versa, as I explained in the other thread. Anyway,
I think the problem of missing stat updates of events is more
pronounced with userspace reads.

>
> > There is also
> > a heuristic in zswap that may writeback more (or less) pages that it
> > should to the swap device if the stats are significantly stale.
> >
>
> Is this the ratio of MEMCG_ZSWAP_B and MEMCG_ZSWAPPED in
> zswap_shrinker_count()? There is already a target memcg flush in that
> function and I don't expect root memcg flush from there.

I was thinking of the generic approach I suggested, where we can avoid
contending on the lock if the cgroup is a descendant of the cgroup
being flushed, regardless of whether or not it's the root memcg. I
think this would be more beneficial than just focusing on root
flushes.

