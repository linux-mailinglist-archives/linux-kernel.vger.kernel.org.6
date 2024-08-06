Return-Path: <linux-kernel+bounces-276889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3309494999B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DC51F2295A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576815C121;
	Tue,  6 Aug 2024 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDm5CXkx"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247BF158DDC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977654; cv=none; b=UDj/UY/nFS8pwcHyyzyJGfGCAXAfleMP/g/037als80k7MW5ibTdRMxLw81hlj+4O5PIsNWjJYpNWtoQoqNxHYkUtciai9XSFrAwpotSXuc4oCzKtqMgW/HyMnPOjQGxDeJfHW5U0RQqYJ9eqBLTH76CeVbMQQUAWeD3yUbFeF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977654; c=relaxed/simple;
	bh=1BB7NOUEkzEpOT8VuEnyI73PzkivLXuyKV6GFPhlLUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btn+V/5xt14jBYAjd7Zy71HnkqkdhUOML3Jz+PtNi8n27Vdwf+mfuJcR5xC7iscYIzL4L/iv1HQ97kKbg9oGcLr+OHKcxlDdggVgxtMEYkIFq6/HA/s2HbWTYllRgS0n2NK79cL/CZk1ulxJhVv7EDmoxwQc9qf0VfzOn2NvUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QDm5CXkx; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45029af1408so354141cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722977652; x=1723582452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxyvc7RXqu4zNbUBZnpHSq/Hs5VyzEbi0996tSmCPes=;
        b=QDm5CXkxHswHMCqqDjRSKwX5HdOpmh1UOlsuBZgWljpM+kqYtaRvGRZYWqj4ePDOro
         yWefyA27ThkCzU2Fv/2RWLl7OraYLFIZv40+2hv/0/CN93yJBX92/cU9WYzO4f//8Kjl
         G/DYaQU7wnPtLzSS/Ccj7ibe8kav1t2bIbpkfsPumNhUd40Hfj1NMNqOY8NgG7WHTVBe
         LZVlfaAA0w6ZXCwIeXs3kMkumIIo0rWwvaAqehZrHCz2ICIQhgbphNZfe0WonhYpW5w/
         S/uzbW6KxI6ZnfcFkRFWvLFmRFk4Mdo7vFIJPZjZhzj6ye4572MyleMhTdH5cYr9fz64
         knrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977652; x=1723582452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxyvc7RXqu4zNbUBZnpHSq/Hs5VyzEbi0996tSmCPes=;
        b=s70L5gV4rSMl+9hpz70KwBBcCb8IaCydD3Qe4H2WTlAcJQiBj2p9pGe0+In76iZrFv
         VH90QAod+ThTBW5CoGaiWJjXwjcu8jHTrXu7i6fae7PKZAHLAPCdbXTarjgBSW/BNFpu
         /50XC/WqepSGdigbpxqaP64kb0OSjPyV2mHlMY3stF4vRhaSJ6WblF76HzqM8kJGTDBT
         BAMM7sc4Lifio7WtdvCjRuIEnawZiBhBoVN1fv6xmSz+Tw++i7ek2mfMpaPvuRZPpGqM
         qATTVByK0XDorwxh9/xpkcEVY6kSNauOx68ysLLW3r2EK67wUbNo1OjwWQHYh+3loqG8
         2IUA==
X-Forwarded-Encrypted: i=1; AJvYcCWrrrDnmZu3lEV+/4kDA5c6AUeujiln2vDxf3vZIg2K95L2A4Gtt5wOeZZSAvEoTZ63ntogCwuWFxH4o+6pGQqHPBBYfCekVaAbjvhy
X-Gm-Message-State: AOJu0YyH+rdV/87bShre2I9Y218FxY7HwwIbZMBYHbcGwhmSs1664SlU
	7cOnDgv4JAH4cMT6deZqy6q/ZVA9ZGDxfr25KmejXdsvZPdp+2xj1WdU1wvazKJDk7WB5nGx06b
	7cYD+w+uxxdMYMKa+cf9iBzyIT6S29W+CawlM
X-Google-Smtp-Source: AGHT+IEbsxjtAnAT0vOH9sYdMkGg1rLWr+I+XI5SXIODVuLDmTP0V/isbEpWMnidA3wi8g2jQnkkcigZTnpm0eMlFNY=
X-Received: by 2002:ac8:5f8b:0:b0:447:e393:fed1 with SMTP id
 d75a77b69052e-451c7815e2emr136261cf.7.1722977651643; Tue, 06 Aug 2024
 13:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
 <20240806173840.GE322282@cmpxchg.org> <CAOUHufavZTKjh6sb4n_q0ciLzTS88Kxxkp_2Q1wWVp_ZkFrshQ@mail.gmail.com>
 <20240806195422.GF322282@cmpxchg.org>
In-Reply-To: <20240806195422.GF322282@cmpxchg.org>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 6 Aug 2024 14:53:33 -0600
Message-ID: <CAOUHufZ8Sp66uH0NdS4p-8-pkXV1jP6w=OtTY+oP2vgE7ZA1hA@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 1:54=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Tue, Aug 06, 2024 at 12:06:20PM -0600, Yu Zhao wrote:
> > On Tue, Aug 6, 2024 at 11:38=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Thu, Aug 01, 2024 at 12:09:16AM -0600, Yu Zhao wrote:
> > > > On Tue, Jul 30, 2024 at 6:54=E2=80=AFAM Usama Arif <usamaarif642@gm=
ail.com> wrote:
> > > > >
> > > > > The current upstream default policy for THP is always. However, M=
eta
> > > > > uses madvise in production as the current THP=3Dalways policy vas=
tly
> > > > > overprovisions THPs in sparsely accessed memory areas, resulting =
in
> > > > > excessive memory pressure and premature OOM killing.
> > > > > Using madvise + relying on khugepaged has certain drawbacks over
> > > > > THP=3Dalways. Using madvise hints mean THPs aren't "transparent" =
and
> > > > > require userspace changes. Waiting for khugepaged to scan memory =
and
> > > > > collapse pages into THP can be slow and unpredictable in terms of=
 performance
> > > > > (i.e. you dont know when the collapse will happen), while product=
ion
> > > > > environments require predictable performance. If there is enough =
memory
> > > > > available, its better for both performance and predictability to =
have
> > > > > a THP from fault time, i.e. THP=3Dalways rather than wait for khu=
gepaged
> > > > > to collapse it, and deal with sparsely populated THPs when the sy=
stem is
> > > > > running out of memory.
> > > > >
> > > > > This patch-series is an attempt to mitigate the issue of running =
out of
> > > > > memory when THP is always enabled. During runtime whenever a THP =
is being
> > > > > faulted in or collapsed by khugepaged, the THP is added to a list=
.
> > > > > Whenever memory reclaim happens, the kernel runs the deferred_spl=
it
> > > > > shrinker which goes through the list and checks if the THP was un=
derutilized,
> > > > > i.e. how many of the base 4K pages of the entire THP were zero-fi=
lled.
> > > > > If this number goes above a certain threshold, the shrinker will =
attempt
> > > > > to split that THP. Then at remap time, the pages that were zero-f=
illed are
> > > > > not remapped, hence saving memory. This method avoids the downsid=
e of
> > > > > wasting memory in areas where THP is sparsely filled when THP is =
always
> > > > > enabled, while still providing the upside THPs like reduced TLB m=
isses without
> > > > > having to use madvise.
> > > > >
> > > > > Meta production workloads that were CPU bound (>99% CPU utilzatio=
n) were
> > > > > tested with THP shrinker. The results after 2 hours are as follow=
s:
> > > > >
> > > > >                             | THP=3Dmadvise |  THP=3Dalways   | T=
HP=3Dalways
> > > > >                             |             |               | + shr=
inker series
> > > > >                             |             |               | + max=
_ptes_none=3D409
> > > > > -----------------------------------------------------------------=
------------
> > > > > Performance improvement     |      -      |    +1.8%      |     +=
1.7%
> > > > > (over THP=3Dmadvise)          |             |               |
> > > > > -----------------------------------------------------------------=
------------
> > > > > Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.=
9G (+2.4%)
> > > > > -----------------------------------------------------------------=
------------
> > > > > max_ptes_none=3D409 means that any THP that has more than 409 out=
 of 512
> > > > > (80%) zero filled filled pages will be split.
> > > > >
> > > > > To test out the patches, the below commands without the shrinker =
will
> > > > > invoke OOM killer immediately and kill stress, but will not fail =
with
> > > > > the shrinker:
> > > > >
> > > > > echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_pte=
s_none
> > > > > mkdir /sys/fs/cgroup/test
> > > > > echo $$ > /sys/fs/cgroup/test/cgroup.procs
> > > > > echo 20M > /sys/fs/cgroup/test/memory.max
> > > > > echo 0 > /sys/fs/cgroup/test/memory.swap.max
> > > > > # allocate twice memory.max for each stress worker and touch 40/5=
12 of
> > > > > # each THP, i.e. vm-stride 50K.
> > > > > # With the shrinker, max_ptes_none of 470 and below won't invoke =
OOM
> > > > > # killer.
> > > > > # Without the shrinker, OOM killer is invoked immediately irrespe=
ctive
> > > > > # of max_ptes_none value and kill stress.
> > > > > stress --vm 1 --vm-bytes 40M --vm-stride 50K
> > > > >
> > > > > Patches 1-2 add back helper functions that were previously remove=
d
> > > > > to operate on page lists (needed by patch 3).
> > > > > Patch 3 is an optimization to free zapped tail pages rather than
> > > > > waiting for page reclaim or migration.
> > > > > Patch 4 is a prerequisite for THP shrinker to not remap zero-fill=
ed
> > > > > subpages when splitting THP.
> > > > > Patches 6 adds support for THP shrinker.
> > > > >
> > > > > (This patch-series restarts the work on having a THP shrinker in =
kernel
> > > > > originally done in
> > > > > https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/=
.
> > > > > The THP shrinker in this series is significantly different than t=
he
> > > > > original one, hence its labelled v1 (although the prerequisite to=
 not
> > > > > remap clean subpages is the same).)
> > > > >
> > > > > Alexander Zhu (1):
> > > > >   mm: add selftests to split_huge_page() to verify unmap/zap of z=
ero
> > > > >     pages
> > > > >
> > > > > Usama Arif (3):
> > > > >   Revert "memcg: remove mem_cgroup_uncharge_list()"
> > > > >   Revert "mm: remove free_unref_page_list()"
> > > > >   mm: split underutilized THPs
> > > > >
> > > > > Yu Zhao (2):
> > > > >   mm: free zapped tail pages when splitting isolated thp
> > > > >   mm: don't remap unused subpages when splitting isolated thp
> > > >
> > > >  I would recommend shatter [1] instead of splitting so that
> > >
> > > I agree with Rik, this seems like a possible optimization, not a
> > > pre-requisite.
>
> Let me just re-iterate, I don't think this discussion has any bearing
> on the THP shrinker.

I'm not sure why you think one of the two ways to free zero pages from
a THP has no bearing on each other.

> There is data corroborating that the shrinker
> as-is is useful today.

I had data that showed it too, before posting the two patches included
in this series over 3 years ago. I have also made additional findings
since then, as I was sharing with you.

> Shattering is an independent proposal for an optimization that should
> be discussed on its own merits.

I'm not trying to derail it. I only listed an option for you to
consider, based on my new findings. And as I said earlier to Rik, I'm
fine with whatever you prefer.

> > > > 1) whoever underutilized their THPs get punished for the overhead;
> > >
> > > Is that true?
> >
> > Yes :)
>
> It actually sounds like the answer is no.
>
> > > The downgrade is done in a shrinker.
> >
> > Ideally, should we charge for the CPU usage of the shrinker and who
> > should we charge it to?
>
> There are two contexts it runs in:
>
> 1) Task tries to allocate a THP. A physical one cannot be found, so
>    direct reclaim and compaction run. The allocating task and its
>    cgroup get charged for this effort, regardless of who underutilized
>    the page, and regardless of whether we split+compact or shatter.
>
> 2) Cgroup tries to charge a THP and hits its limit. The allocating
>    task runs limit reclaim, which invokes the shrinker. The job of
>    this context is to enforce memory quantity, not contiguity. A limit
>    can be hit when the system is 5% utilized, with an abundance of
>    free blocks. With the shrinker shattering, the cgroup would be
>    needlessly punished. Twice in fact:
>
>             a) it would perform unnecessary migration work
>
>             b) splitting retains PTE contiguity on the remaining
>                subpages, which has benefits on CPUs with TLB
>                coalescing. Shattering would disrupt that needlessly.
>
>    This is the wrong context for contiguity work.
>
> So it seems to me that the punishment of "culprits" is not natural,
> reliable, or proportional in any way.

I see why we are disagreeing with each other, because we are viewing
the problem in very different frames.

Never mind. We can find another time in another thread to sync up.

> > > With or without
> > > shattering, the compaction effort will be on the allocation side.
> >
> > If compaction is needed at all.
>
> That's not what I meant.
>
> Shattering IS compaction work. There is a migration source block, and
> it moves the individual pages to somewhere else to produce a free THP.
>
> > > The only difference is that
> > > compaction would do the work on-demand
> >
> > And can often fail to produce 2MB blocks *under memory pressure*
>
> So let's agree that shattering helps if the THP demand is constant.
>
> It doesn't help when THP demand *grows* under pressure. But fixing
> this is kind of critical for THPs to be useful.

Same here.

A quick answer is that I'm thinking (and working) in the frame of THP
memcg-prioritized (fragmentation containerized), which might add
another thing you disagree with.

So yes, that should be a different discussion somewhere else.




> And fixing the latter obviates the need for a special solution to only
> the former.
>
> > > whereas shattering would do it unconditionally
> >
> > And always produces a 2MB block
>
> Which can immediately get fragmented by a racing allocation from an
> unrelated cgroup. So the next step would be compaction capturing for
> the shattering code...
>
> I'm not really sold on this. It's re-inventing compaction in an ad-hoc
> scenario that has limited usefulness, instead of addressing the
> fundamental issues that make compaction inefficient & unreliable.
>
> Allocation context is the appropriate place to determine whether, and
> how much, defragmentation (and all its direct and indirect costs) is
> actually warranted. Not opportunistically deep in the reclaim stack.

