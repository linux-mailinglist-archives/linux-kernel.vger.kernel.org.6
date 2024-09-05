Return-Path: <linux-kernel+bounces-317618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8583C96E122
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F87287A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B411A38E1;
	Thu,  5 Sep 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zb/Pg07G"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA92119CCFC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557539; cv=none; b=HkDkeMDGHAwg7YWZHwHzflVbRDw9dBm6nzWF3QC6jaiG/dTgIkUg9kyaIt2e5tozfm7fubxy1mo6QzyuHo3eTIgz20xV/Aup+WOf5N5cI5XOjg01K/ckTB1WxZ7EAW0MGFrFiCMo6B06VGRFg0un8DD1IiRFFeCJEeAAYKfWJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557539; c=relaxed/simple;
	bh=K0BVq6SjvECar05inDGHUNgLBdnK/PfskwK3F0OFvIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpMisO/7sYODqoM0sxDtEec/JZC3xQUv6wu9/eq50+M/yU9ocIzXTdKijbzX02GKZjDk+KbcA3vboxTH7sKWIiscJMNXAh01bdqWOj2YR3lOq8pVwu4r96d5ENBHFx87g43XmYr9BgUPN8PEpOHtKYMGZ3PpbubxBlp2OZlxMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zb/Pg07G; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c26852af8fso1144626a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725557536; x=1726162336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=La3gWx3dLLSUBsyYmKlxjF/BBx5o3oL64jxWJcre0cY=;
        b=zb/Pg07GOtyJTvOI1PDM0agDsFzdjCuVIPSiLlEnmY00/K+CyqWTGpGP+01Dtht29s
         koLh5W2R5ExdFiPwnEODXVGfW46mlfcgYLHBfLfTjmWgJ/mqCtUQreiiyX2M+wycprft
         LXdOdmA9oEFSUhKdTjVzPC0GnmubAggyFzZRDa0BczPcNRZbyngKMphpSJ2dcS8uEZzG
         obx/lLxk0+W8IyD1ptKtPyE8rWmxCBZqzPcNYcyuZhlOI8Bb37dx4AOOJkBOUh99+I7V
         sFm+PYbo1d7bE8B41wRiAYx+rSCV8r620htMwqXGIWa8pNNjaQcaWZLhrfB1rSSsBRhh
         cmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725557536; x=1726162336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=La3gWx3dLLSUBsyYmKlxjF/BBx5o3oL64jxWJcre0cY=;
        b=W9Xn1d9+1+BNQB7HgVLhovE76u7Nvj9afTxlc82Hkb/ZrjecX1K4o0KXBfgQ6s6nmh
         t5dBdAZS6c2BCbrnqdsVhJQuOFbsYeqJ9s+ipXwhvP0suVdmJiSBO4fVrcu2cleW6NnP
         EVwvBookOYkSuyJLG4xCaBr3HOmy5ZOch3cdnOAS3Qoac/se3ofmQ9N5TnfSZ/V3XI4L
         X83jGhBQ57/EYTckKVE/sfotBkjEQesn7s5L0IOZHkMIPTKEftEvRX33kNu+IQ5w66Oe
         nGcg7feBz358mxAIY7fPF52z2H+GLJjS/hjxd98Ljc9fEtDVCOBiPMHxKVf0Die9SJpq
         H0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU9U3b5+8UAPu1wC+OID+Ddtkc/ork/O6TOu+Jv/XR8MRBu9cZ7eO5IqTpELuzqM3YwDhuFlw2OaTgka8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5wSp93rB0oF7AatYwxHlUeuUNYrHJxU4Bjhg8/w+5dNwEk/9
	N0JltOZ/3IKchoDy9CzDuOnuoNuPm70iUWuUZxtBF4yfBYGT+yLeWYehANX0A2p8Glzc+2DOVu+
	bs2eOApRkFs0APFLWm7yThWEPyeQ08QH6xa1p
X-Google-Smtp-Source: AGHT+IHuEHg6iFJmi96ZdHpr/erJcBCYC0Xlx/zvHuaYnuSuywkb734wF9h4NCsjsZ87amd8NqQi2xJ/YplnroqMhL8=
X-Received: by 2002:a17:907:ea3:b0:a86:a12b:2cea with SMTP id
 a640c23a62f3a-a897fad6ff4mr2128470966b.67.1725557535314; Thu, 05 Sep 2024
 10:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172547884995.206112.808619042206173396.stgit@firesoul>
 <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com> <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org>
In-Reply-To: <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 5 Sep 2024 10:31:37 -0700
Message-ID: <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	mfleming@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

[..]
> >> @@ -299,6 +301,67 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
> >>          spin_unlock_irq(&cgroup_rstat_lock);
> >>   }
> >>
> >> +static inline bool cgroup_is_root(struct cgroup *cgrp)
> >> +{
> >> +       return cgroup_parent(cgrp) == NULL;
> >> +}
> >> +
> >> +/**
> >> + * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flusher
> >> + * @cgrp: target cgroup
> >> + *
> >> + * Function return value follow trylock semantics. Returning true when lock is
> >> + * obtained. Returning false when not locked and it detected flushing can be
> >> + * skipped as another ongoing flusher is taking care of the flush.
> >> + *
> >> + * For callers that depend on flush completing before returning a strict option
> >> + * is provided.
> >> + */
> >> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp, bool strict)
> >> +{
> >> +       struct cgroup *ongoing;
> >> +
> >> +       if (strict)
> >> +               goto lock;
> >> +
> >> +       /*
> >> +        * Check if ongoing flusher is already taking care of this.  Descendant
> >> +        * check is necessary due to cgroup v1 supporting multiple root's.
> >> +        */
> >> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
> >> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing))
> >> +               return false;
> >
> > Why did we drop the agreed upon method of waiting until the flushers
> > are done? This is now a much more intrusive patch which makes all
> > flushers skip if a root is currently flushing. This causes
> > user-visible problems and is something that I worked hard to fix. I
> > thought we got good results with waiting for the ongoing flusher as
> > long as it is a root? What changed?
> >
>
> I disagree with the idea of waiting until the flusher is done.
> As Shakeel have pointed out before, we don't need accurate stats.
> This caused issues and 'completions' complicated the code too much.

I think Shakeel was referring specifically to the flush in the reclaim
path. I don't think this statement holds for all cgroup flushers,
especially those exposed to userspace.

>
> When multiple (12) kswapd's are running, then waiting for ongoing
> flusher will cause us to delay all other kswapd threads, for on my
> production system approx 24 ms (see attached prod graph).
> Matt (Cc) is currently[1] looking into page alloc failures that are
> happening across the fleet, when NIC RX packets as those allocs are
> GFP_ATOMIC.  So, basically kswapd isn't reclaiming memory fast enough on
> our systems, which could be related to this flush latency.  (Quick calc,
> prod server RX 1,159,695 pps, thus in 24 ms period 27,832 packets are
> handled, that exceed RX ring size 1024).
>
>   [1]
> https://lore.kernel.org/all/CAGis_TWzSu=P7QJmjD58WWiu3zjMTVKSzdOwWE8ORaGytzWJwQ@mail.gmail.com/
>
> For this reason, I don't want to have code that waits for ongoing
> flushers to finish.  This is why I changed the code.

My understanding was that the previous versions solved most of the
problem. However, if it's not enough and we need to completely skip
the flush, then I don't think this patch is the right way to go. This
affects all flushers, not just the reclaim path, and not even just the
memcg flushers. Waiting for ongoing flushers was a generic approach
that should work for all flushers, but completely skipping the flush
is not.

If your problem is specifically the flush in the reclaim path, then
Shakeel's patch to replace that flush with the ratelimited version
should fix your problem. It was already merged into mm-stable (so
headed toward v6.11 AFAICT).

>
>
> > You also never addressed my concern here about 'ongoing' while we are
> > accessing it, and never responded to my question in v8 about expanding
> > this to support non-root cgroups once we shift to a mutex.
> >
>
> I don't think we should expand this to non-root cgroups.  My production
> data from this V10 shows we don't need this for non-root cgroups.

Right, because you are concerned with the flush in the kswapd path
specifically. This patch touches affects much more than that.

>
>
> > I don't appreciate the silent yet drastic change made in this version
> > and without addressing concerns raised in previous versions. Please
> > let me know if I missed something.
> >
>
> IMHO we needed a drastic change, because patch was getting too
> complicated, and my production experiments showed that it was no-longer
> solving the contention issue (due to allowing non-root cgroups to become
> ongoing).

I thought we agreed to wait for the ongoing flusher to complete, but
only allow root cgroups to become the ongoing flusher (at least
initially). Not sure what changed.

>
> Production servers with this V10 patch applied shows HUGE improvements.
> Let me grab a graf showing level-0 contention events being reduced from
> 1360 event/sec to 0.277 events/sec.  I had to change to a log-scale graf
> to make improvement visible.  The wait-time is also basically gone.  The
> improvements are so convincing and highly needed, that we are going to
> deploy this improvement.  I usually have a very strong upstream first
> principle, but we simply cannot wait any-longer for a solution to this
> production issue.

Of course there is a huge improvement, you are completely skipping the
flush :) You are gaining a lot of performance but you'll also lose
something, there is no free lunch here. This may be an acceptable
tradeoff for the reclaim path, but definitely not for all flushers.

>
>
> >> +
> >> +       /* Grab right to be ongoing flusher */
> >> +       if (!ongoing && cgroup_is_root(cgrp)) {
> >> +               struct cgroup *old;
> >> +
> >> +               old = cmpxchg(&cgrp_rstat_ongoing_flusher, NULL, cgrp);
> >> +               if (old) {
> >> +                       /* Lost race for being ongoing flusher */
> >> +                       if (cgroup_is_descendant(cgrp, old))
> >> +                               return false;
> >> +               }
> >> +               /* Due to lock yield combined with strict mode record ID */
> >> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, current);
> >
> > I am not sure I understand why we need this, do you mind elaborating?
>
> Let me expand the comment. Due to lock yield an ongoing (root) flusher
> can yield the lock, which would allow a root flush in strict mode to
> obtain the lock, which then in the unlock call (see below) will clear
> cgrp_rstat_ongoing_flusher (as cgrp in both cases have "root" cgrp ptr),
> unless it have this flush_ID to tell them apart.

The pointers should be different for different roots though, right?
Why do we need the ID to tell them apart? I am not sure I follow.

