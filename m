Return-Path: <linux-kernel+bounces-276809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C69498A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE622831E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE71509A5;
	Tue,  6 Aug 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="hFzXxG54"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C5A145B1C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974075; cv=none; b=s/UqV8p2Vse067lC7flHJf+RWxq3njxeJuHZEzyqoh4cbEwn+xhtSeRQs4AZvZmdg0emfZQrvPsCCaBkqQ4/WyCI7JwTR7fXbvSiJ2hqtmK0m8IdlnSdm5zCNs5YvrJyw0U3T7w9gHiKnbwrjE29m0UQ058Lx0ujjoNeL+yVu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974075; c=relaxed/simple;
	bh=BpiFkizntkuNYYbqLMUh5o6k123HE/GRHqdrd5DtwaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTNxA9AesYGB5KzzWM4NgG8R6Avon3pYd20YOT+wAftG+IkdhseQh3PbSp1cF183WaoGxQ+g1g8yh+M59u/QPUtWOQ8watB3vgTXw8X9NvOXOUbLi8l64gNidAMx8rbgWS4UASHAyM+f4jMwUQ8KAkl6ll3tTltzPerZJRN3Flc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=hFzXxG54; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4519383592aso6342011cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722974072; x=1723578872; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q9KObzHEoTkTzOdnl1Xc1srqmdgq+QKJ4U9b5T6vC08=;
        b=hFzXxG540fxFXv7qNqVoIzoQguhKaBL5jOVxwSaoipixLKDXPh8+AYRJQDO9s0evh5
         O7MNMvmBNPMDQteVb6e7gUHBGYtZnH7TmIJyRT7atnqtXc+YkNV/Nwudi4OrijgxdimO
         3hY+LWhPFBlGjk9CoKw7doiolmXlCrbn6m3H4G0/m9se2bijS3ra0qFWjV17bN4Q6y+L
         MqeL5xoflOe3pgxEw6ytqPiwJVC7PiSb1e8eiKADwhe9gPJzCQlhAVmN4fT9syndSttg
         o3JJVaPIhbNYybBw4L4MkRsCqSMu9RjMnlZ87XOjBmm21v09alOxpqPIuyeBgCggQftZ
         8iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722974072; x=1723578872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9KObzHEoTkTzOdnl1Xc1srqmdgq+QKJ4U9b5T6vC08=;
        b=S3SJzdMVEsCGn5qGDU2J8w7Nhim2URFU0zAuC4BTkNNDQMxG7BxeC48CqR48JUS7/N
         apSbRjOBt+ySoiadLs80ggWMlgFyu54merooacSxxPzyesGZg7pnQ0dgQ58SBYx4ZC6z
         k7gwfuupZjE8YZKefdRcMauEo/lVUfrjdgEf7rWFrgwip0WX0o2yQQnDFBHDjVvdAOyP
         3cdXAhiKfQ8Zi/8kf8UIM7+gAeV9dihQsu98HlwdnukTVjs0AQ9K01FCQ2xZ/g1c6YYd
         Er4iBxJ6TLSwZM6ZL6st8UcVZDKOrzAEd3XGXdt7rV7PbLS4BTl4RpVU+T2AxHk+OaTj
         02MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnjwAKw//1GPA3+tOW+u1kR+SV4PWg/Bh7q6iwPoSwvcoUhj/deOluFVM7pZq97DuufboFW9awNLCL7GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPupKThZSkxO8eTHmMhULTB16VtDRd8722FeUdAb2ZWdj5UGqo
	99dgk5LcuO4I61gLzryiJ6aBFOaPDJnLn/sOsjcry/kQk9VCIfIXOQ3BJltTzZU=
X-Google-Smtp-Source: AGHT+IHtbWCzTzD4UemOkN9Gk7mskcRVQkFIJsa35ZBWCAYvI+WhrKtgZlBUMGgJq6cyyv1rtQTtYA==
X-Received: by 2002:a05:622a:198a:b0:450:319:6b44 with SMTP id d75a77b69052e-45189206d8amr202167641cf.1.1722974071641;
        Tue, 06 Aug 2024 12:54:31 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a756206sm40320921cf.65.2024.08.06.12.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:54:31 -0700 (PDT)
Date: Tue, 6 Aug 2024 15:54:22 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, riel@surriel.com, shakeel.butt@linux.dev,
	roman.gushchin@linux.dev, david@redhat.com, baohua@kernel.org,
	ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
	cerasuolodomenico@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
Message-ID: <20240806195422.GF322282@cmpxchg.org>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
 <20240806173840.GE322282@cmpxchg.org>
 <CAOUHufavZTKjh6sb4n_q0ciLzTS88Kxxkp_2Q1wWVp_ZkFrshQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufavZTKjh6sb4n_q0ciLzTS88Kxxkp_2Q1wWVp_ZkFrshQ@mail.gmail.com>

On Tue, Aug 06, 2024 at 12:06:20PM -0600, Yu Zhao wrote:
> On Tue, Aug 6, 2024 at 11:38 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Aug 01, 2024 at 12:09:16AM -0600, Yu Zhao wrote:
> > > On Tue, Jul 30, 2024 at 6:54 AM Usama Arif <usamaarif642@gmail.com> wrote:
> > > >
> > > > The current upstream default policy for THP is always. However, Meta
> > > > uses madvise in production as the current THP=always policy vastly
> > > > overprovisions THPs in sparsely accessed memory areas, resulting in
> > > > excessive memory pressure and premature OOM killing.
> > > > Using madvise + relying on khugepaged has certain drawbacks over
> > > > THP=always. Using madvise hints mean THPs aren't "transparent" and
> > > > require userspace changes. Waiting for khugepaged to scan memory and
> > > > collapse pages into THP can be slow and unpredictable in terms of performance
> > > > (i.e. you dont know when the collapse will happen), while production
> > > > environments require predictable performance. If there is enough memory
> > > > available, its better for both performance and predictability to have
> > > > a THP from fault time, i.e. THP=always rather than wait for khugepaged
> > > > to collapse it, and deal with sparsely populated THPs when the system is
> > > > running out of memory.
> > > >
> > > > This patch-series is an attempt to mitigate the issue of running out of
> > > > memory when THP is always enabled. During runtime whenever a THP is being
> > > > faulted in or collapsed by khugepaged, the THP is added to a list.
> > > > Whenever memory reclaim happens, the kernel runs the deferred_split
> > > > shrinker which goes through the list and checks if the THP was underutilized,
> > > > i.e. how many of the base 4K pages of the entire THP were zero-filled.
> > > > If this number goes above a certain threshold, the shrinker will attempt
> > > > to split that THP. Then at remap time, the pages that were zero-filled are
> > > > not remapped, hence saving memory. This method avoids the downside of
> > > > wasting memory in areas where THP is sparsely filled when THP is always
> > > > enabled, while still providing the upside THPs like reduced TLB misses without
> > > > having to use madvise.
> > > >
> > > > Meta production workloads that were CPU bound (>99% CPU utilzation) were
> > > > tested with THP shrinker. The results after 2 hours are as follows:
> > > >
> > > >                             | THP=madvise |  THP=always   | THP=always
> > > >                             |             |               | + shrinker series
> > > >                             |             |               | + max_ptes_none=409
> > > > -----------------------------------------------------------------------------
> > > > Performance improvement     |      -      |    +1.8%      |     +1.7%
> > > > (over THP=madvise)          |             |               |
> > > > -----------------------------------------------------------------------------
> > > > Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
> > > > -----------------------------------------------------------------------------
> > > > max_ptes_none=409 means that any THP that has more than 409 out of 512
> > > > (80%) zero filled filled pages will be split.
> > > >
> > > > To test out the patches, the below commands without the shrinker will
> > > > invoke OOM killer immediately and kill stress, but will not fail with
> > > > the shrinker:
> > > >
> > > > echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
> > > > mkdir /sys/fs/cgroup/test
> > > > echo $$ > /sys/fs/cgroup/test/cgroup.procs
> > > > echo 20M > /sys/fs/cgroup/test/memory.max
> > > > echo 0 > /sys/fs/cgroup/test/memory.swap.max
> > > > # allocate twice memory.max for each stress worker and touch 40/512 of
> > > > # each THP, i.e. vm-stride 50K.
> > > > # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
> > > > # killer.
> > > > # Without the shrinker, OOM killer is invoked immediately irrespective
> > > > # of max_ptes_none value and kill stress.
> > > > stress --vm 1 --vm-bytes 40M --vm-stride 50K
> > > >
> > > > Patches 1-2 add back helper functions that were previously removed
> > > > to operate on page lists (needed by patch 3).
> > > > Patch 3 is an optimization to free zapped tail pages rather than
> > > > waiting for page reclaim or migration.
> > > > Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
> > > > subpages when splitting THP.
> > > > Patches 6 adds support for THP shrinker.
> > > >
> > > > (This patch-series restarts the work on having a THP shrinker in kernel
> > > > originally done in
> > > > https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
> > > > The THP shrinker in this series is significantly different than the
> > > > original one, hence its labelled v1 (although the prerequisite to not
> > > > remap clean subpages is the same).)
> > > >
> > > > Alexander Zhu (1):
> > > >   mm: add selftests to split_huge_page() to verify unmap/zap of zero
> > > >     pages
> > > >
> > > > Usama Arif (3):
> > > >   Revert "memcg: remove mem_cgroup_uncharge_list()"
> > > >   Revert "mm: remove free_unref_page_list()"
> > > >   mm: split underutilized THPs
> > > >
> > > > Yu Zhao (2):
> > > >   mm: free zapped tail pages when splitting isolated thp
> > > >   mm: don't remap unused subpages when splitting isolated thp
> > >
> > >  I would recommend shatter [1] instead of splitting so that
> >
> > I agree with Rik, this seems like a possible optimization, not a
> > pre-requisite.

Let me just re-iterate, I don't think this discussion has any bearing
on the THP shrinker. There is data corroborating that the shrinker
as-is is useful today.

Shattering is an independent proposal for an optimization that should
be discussed on its own merits.

> > > 1) whoever underutilized their THPs get punished for the overhead;
> >
> > Is that true?
> 
> Yes :)

It actually sounds like the answer is no.

> > The downgrade is done in a shrinker.
> 
> Ideally, should we charge for the CPU usage of the shrinker and who
> should we charge it to?

There are two contexts it runs in:

1) Task tries to allocate a THP. A physical one cannot be found, so
   direct reclaim and compaction run. The allocating task and its
   cgroup get charged for this effort, regardless of who underutilized
   the page, and regardless of whether we split+compact or shatter.

2) Cgroup tries to charge a THP and hits its limit. The allocating
   task runs limit reclaim, which invokes the shrinker. The job of
   this context is to enforce memory quantity, not contiguity. A limit
   can be hit when the system is 5% utilized, with an abundance of
   free blocks. With the shrinker shattering, the cgroup would be
   needlessly punished. Twice in fact:

   	    a) it would perform unnecessary migration work

	    b) splitting retains PTE contiguity on the remaining
	       subpages, which has benefits on CPUs with TLB
	       coalescing. Shattering would disrupt that needlessly.

   This is the wrong context for contiguity work.

So it seems to me that the punishment of "culprits" is not natural,
reliable, or proportional in any way.

> > With or without
> > shattering, the compaction effort will be on the allocation side.
> 
> If compaction is needed at all.

That's not what I meant.

Shattering IS compaction work. There is a migration source block, and
it moves the individual pages to somewhere else to produce a free THP.

> > The only difference is that
> > compaction would do the work on-demand
> 
> And can often fail to produce 2MB blocks *under memory pressure*

So let's agree that shattering helps if the THP demand is constant.

It doesn't help when THP demand *grows* under pressure. But fixing
this is kind of critical for THPs to be useful.

And fixing the latter obviates the need for a special solution to only
the former.

> > whereas shattering would do it unconditionally
> 
> And always produces a 2MB block

Which can immediately get fragmented by a racing allocation from an
unrelated cgroup. So the next step would be compaction capturing for
the shattering code...

I'm not really sold on this. It's re-inventing compaction in an ad-hoc
scenario that has limited usefulness, instead of addressing the
fundamental issues that make compaction inefficient & unreliable.

Allocation context is the appropriate place to determine whether, and
how much, defragmentation (and all its direct and indirect costs) is
actually warranted. Not opportunistically deep in the reclaim stack.

