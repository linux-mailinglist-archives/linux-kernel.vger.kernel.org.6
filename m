Return-Path: <linux-kernel+bounces-227238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19905914DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A692850EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E645613D511;
	Mon, 24 Jun 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSsrsHzG"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365382556F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233914; cv=none; b=S67WTw4FDHD9cVMU5Yc8TQ6mYzzC77RVCi0rhwfY542geLe6WBRfMYx8W/eP6QCSwsL4fZFyi8WBCxqVEFVytIlZMlYxPs5mK6sZKoY/vpo4GoHGm8CWQhZBgo8nXSVEtz//3XtcCoK/sXaoGBEpev2ic8Wxatk+mFVlv1zNH0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233914; c=relaxed/simple;
	bh=+v+7BRyLJ1ohCm2ckG9JfDQ7O4yGh9CdsiC9bRgDzMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5mpMZMpy8aqEJFpDPgZMdIL3IzoZ5GPRlFEP2qliCeMBspvS5PC35FTchZaKW1beNeJowCSzMdW0lqjPFaA5DbfFcIGSjZGHlwjVDErK0F6TNZqmmcFmdCjez8ViixNohseQSGdlpj2rSpd2KPNnagI9MDtB5Qa1XZgiH+HrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSsrsHzG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdebf9f53so1679290e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719233909; x=1719838709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=svysHleJ3ThFEGjJZROMuYTbIejZlxCKTHG9F3C7waE=;
        b=wSsrsHzGnuhTLELocfe46XLqkhDQtwapcGv1MkP+ScN1CeZmMKjJHDKma9AR9dWQCt
         jHY1yC84RXtzeceUG3T7EERgYKePaOfU3wUFXKLTrTMCCKdPQg1W0+im+TWzksRG9kKx
         cxcneSFRUE88Wq2eSiApQyIuWIN6xgwwjY3JbPuRd0GgJ1IgmvZQ+NscUqwC+sN/Kkxz
         BNcVEyKmbkQNth5DVwvZdu4tAruda5jMBWDiu4ZEFKHEHkcPv77GtQpkceqw87FzXmcn
         Y4eR2afMNOiLoxj1Fjp429cT6kFu9eXGYSXYEqRjKY3+IVfV4I7nVDMsJjOF6eMDzfYW
         dDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233909; x=1719838709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svysHleJ3ThFEGjJZROMuYTbIejZlxCKTHG9F3C7waE=;
        b=NvpTpcYe/p6eVF/SR5ph1rCtHXDUMrom+BJzgqt3k/lwSJYjh0a5aAqg1P445kNbxV
         aGTLNYU++UjwQiB1k/Z7eHRezT0hdlesj4eWgn4TLQZJs1tGQ4Q0EE9j4KS1KFQ8dtre
         8amv0XwBE+nEAmDxolpDZ2rlwv1SPnQHRZI1t8xfjSzRPtJv5s7cyt8OEyPsCz9kDiov
         YOS0ZJ+SfEeJkGfQx1f9oPd0RKkR4rs86UNS6IQb7L1nX077gQBGQvShaZWzMYzN8yNP
         6oCABplls0R653Cda2elvSUxneC6Rjven1lWrvNIIRFj52n5Nq1yA1ERRHdnnynETRxR
         LMiA==
X-Forwarded-Encrypted: i=1; AJvYcCWkwQyVXrTSYSfUjK9en2utAA+YyuKaSyM3lUzjzmdlCM8qvyOb+g0bH+2xfZAC/xbwO86htDJfKnllKz40Tjm+8eGwzYzGfhq6W6vQ
X-Gm-Message-State: AOJu0YwcR0HiMT5ma94qmRwcLhuYigEPZPzeDgWxy7P1wLG81sjFdUoE
	1sWEAtPMqRVvYPDN0D8rbGgbmS9JteqjVXJ8IVoHpVqYKY7pTqU+cyOQhZfd3XdMtBIiN/etD7i
	HDqmUyjRpDJsvBOzaVuS5AdeR/zteOqsVUHFx
X-Google-Smtp-Source: AGHT+IHR7EnIshHsOqxNajTCo/Fv6RaPV0imh+5nzrEusg/Kf5PiQf2EoH4z2P2/4yiiFNpQtoqoMY20WvudUWJbugw=
X-Received: by 2002:a05:6512:39c6:b0:52b:c0b1:ab9e with SMTP id
 2adb3069b0e04-52ce063d750mr3852298e87.5.1719233908660; Mon, 24 Jun 2024
 05:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com> <tbi7h7lw4gvl2lsobco4s2qq5phln4uilfvpzpqytlwwmerynd@5nrl5odpwcrx>
In-Reply-To: <tbi7h7lw4gvl2lsobco4s2qq5phln4uilfvpzpqytlwwmerynd@5nrl5odpwcrx>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 05:57:51 -0700
Message-ID: <CAJD7tka-Wa95t29G0EY4xd8TWXkw1q_QNQ-QjzNvqnUQovMtQw@mail.gmail.com>
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Muchun Song <songmuchun@bytedance.com>, Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > and I will explain why below. I know it may be a necessary
> > evil, but I would like us to make sure there is no other option before
> > going forward with this.
>
> Instead of necessary evil, I would call it a pragmatic approach i.e.
> resolve the ongoing pain with good enough solution and work on long term
> solution later.

It seems like there are a few ideas for solutions that may address
longer-term concerns, let's make sure we try those out first before we
fall back to the short-term mitigation.

[..]
> >
> > - Reclaim code is an iterative process, so not updating the stats on
> > every retry is very counterintuitive. We are retrying reclaim using
> > the same stats and heuristics used by a previous iteration,
> > essentially dismissing the effects of those previous iterations.
> >
>
> I think I explained in the commit message why we don't need the precise
> metrics for this specific case but let me reiterate.
>
> The stats are needed for two specific heuristics in this case:
>
> 1. Deactivate LRUs
> 2. Cache trim mode
>
> The deactivate LRUs heuristic is to maintain a desirable inactive:active
> ratio of the LRUs. The specific stats needed are WORKINGSET_ACTIVATE*
> and the hierarchical LRU size. The WORKINGSET_ACTIVATE* is needed to
> check if there is a refault since last snapshot and the LRU size are
> needed for the desirable ratio between inactive and active LRUs. See the
> table below on how the desirable ratio is calculated.
>
> /* total     target    max
>  * memory    ratio     inactive
>  * -------------------------------------
>  *   10MB       1         5MB
>  *  100MB       1        50MB
>  *    1GB       3       250MB
>  *   10GB      10       0.9GB
>  *  100GB      31         3GB
>  *    1TB     101        10GB
>  *   10TB     320        32GB
>  */
>
> The desirable ratio only changes at the boundary of 1 GiB, 10 GiB,
> 100 GiB, 1 TiB and 10 TiB. There is no need for the precise and accurate
> LRU size information to calculate this ratio. In addition, if
> deactivation is skipped for some LRU, the kernel will force deactive on
> the severe memory pressure situation.

Thanks for explaining this in such detail. It does make me feel
better, but keep in mind that the above heuristics may change in the
future and become more sensitive to stale stats, and very likely no
one will remember that we decided that stale stats are fine
previously.

>
> For the cache trim mode, inactive file LRU size is read and the kernel
> scales it down based on the reclaim iteration (file >> sc->priority) and
> only checks if it is zero or not. Again precise information is not
> needed.

It sounds like it is possible that we enter the cache trim mode when
we shouldn't if the stats are stale. Couldn't this lead to
over-reclaiming file memory?

>
> > - Indeterministic behavior like this one is very difficult to debug if
> > it causes problems. The missing updates in the last 2s (or whatever
> > period) could be of any magnitude. We may be ignoring GBs of
> > free/allocated memory. What's worse is, if it causes any problems,
> > tracing it back to this flush will be extremely difficult.
>
> This is indeed an issue but that is common with the heuristics in
> general. They work most of the time and fail for small set of cases.
>
> Anyways, I am not arguing to remove sync flush for all cases. Rather I
> am arguing for this specific case, we don't need to be precise as I have
> explained above.
>
> >
> > What can we do?
> >
> > - Try to make more fundamental improvements to the flushing code (for
> > memcgs or cgroups in general). The per-memcg flushing thresholding is
> > an example of this. For example, if flushing is taking too long
> > because we are flushing all subsystems, it may make sense to have
> > separate rstat trees for separate subsystems.
>
> Yes separate flushing for each subsystems make sense and can be done
> orthogonally.
>
> >
> > One other thing we can try is add a mutex in the memcg flushing path.
> > I had initially had this in my subtree flushing series [1], but I
> > dropped it as we thought it's not very useful. Currently in
> > mem_cgroup_flush_stats(), we check if there are enough pending updates
> > to flush, then we call cgroup_flush_stats() and spin on the lock. It
> > is possible that while we spin, those pending updates we observed have
> > been flushed. If we add back the mutex like in [1], then once we
> > acquire the mutex we check again to make sure there are still enough
> > stats to flush.
> >
> > [1]https://lore.kernel.org/all/20231010032117.1577496-6-yosryahmed@google.com/
>
> My main beef with the global mutex is the possible priority inversion.
> Unless you agree to add try_lock() and skip flushing i.e. no one sleeps
> on the mutex, this is a no go.

Jesper is working on ways to mitigate the possible priority inversion
AFAICT. Let's see what comes out of this (I commented on Jesper's
patch).

>
> >
> > - Try to avoid the need for flushing in this path. I am not sure what
> > approach MGLRU uses to avoid the flush, but if we can do something
> > similar for classic LRUs that would be preferable. I am guessing MGLRU
> > may be maintaining its own stats outside of the rstat framework.
>
> MGLRU simply don't use these heuristics (Yu Zhao please correct me if I
> am wrong).
>
> >
> > - Try to figure out if one (or a few) update paths are regressing all
> > flushers. If one specific stat or stats update path is causing most of
> > the updates, we can try to fix that instead. Especially if it's a
> > counter that is continuously being increased and decreases (so the net
> > change is not as high as we think).
>
> This is actually a good point. I remember Jasper telling that MEMCG_KMEM
> might be the one with most updates. I can try to collect from Meta fleet
> what is the cause of most updates.

Let's also wait and see what comes out of this. It would be
interesting if we can fix this on the update side instead.

>
> >
> > At the end of the day, all of the above may not work, and we may have
> > to live with just using the ratelimited approach. But I *really* hope
> > we could actually go the other way. Fix things on a more fundamental
> > level and eventually drop the ratelimited variants completely.
> >
> > Just my 2c. Sorry for the long email :)
>
> Please note that this is not some user API which can not be changed
> later. We can change and disect however we want. My only point is not to
> wait for the perfect solution and have some intermediate and good enough
> solution.

I agree that we shouldn't wait for a perfect solution, but it also
seems like there are a few easy-ish solutions that we can discover
first (Jesper's patch, investigating update paths, etc). If none of
those pan out, we can fall back to the ratelimited flush, ideally with
a plan on next steps for a longer-term solution.

