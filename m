Return-Path: <linux-kernel+bounces-274018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D4A9470EB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525D2B20D2D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 21:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B9E1428E4;
	Sun,  4 Aug 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNoUi4fm"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897613E881
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722808537; cv=none; b=uLxmoTVX8Cqw9mQYvqKLXZDndwj2ECK7oaDMPSkqdJthORio+n60DDL6VLKRR7rowyf6eO5l1v153sSW2ozSuJU2Y6bmVJY6g+LziuflZHsQyrV2QCiT/JgDU1G3qizM0nxG8DXwyCVpg++x/Wp0ymSNlKeQEiHIHAQT7Wu5/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722808537; c=relaxed/simple;
	bh=QYoMfwmKvpsnQt/hTVfgfdrvBR0EWL2Xjo/mAdvPVUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzLqySF55jvdv+ScITuWRMVIR2ZeAjJLOhQpIpEXF2B8Fd1F7uJT8we80AJvht834ry/FgpKwl7Uix9/PcOZ0SNhiRa6kTL3JhHJYjFLTkXrX+tXMkjiO3ucLdxnKMcyns/ZUHrSbwcjPX34fBAyOrrD3GUXswRqDCCb0D4Jqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNoUi4fm; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-45029af1408so198661cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722808534; x=1723413334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8s6/ypPv2wbuWHf/ATun4VhYJJ06DR5ZHtUhhgqlE8=;
        b=uNoUi4fm6Dj1HunXCL0Xc2wx3pzpxJAAb0Mjhssw1bg+9TTGkLsO4nSCDQlkYcVcnL
         v5C80tkX1WkX5tkkhTKJ9BCHt97F7nguYN1E2GUAbvydEBFVbCfetAw2O2cm2wbT5Hmv
         kWzbbLllLrnxnUhC001XkxCb5nn4J/NkI54D3L2qakPdWj8hDiULsETOiTteY6JudHtd
         EjasX6nXZbWoZpc9zWxeeKBvSjdE5+AYLjzsM+2F1SJDM2TswxDrXymVTczI3/YdZEq+
         LnGsvD4UTk4hhojYJApCSu8rPUAy0IG1YCDyR0hktUB9hDkagxo0wjzInoWvFOz9rKT/
         oW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722808534; x=1723413334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8s6/ypPv2wbuWHf/ATun4VhYJJ06DR5ZHtUhhgqlE8=;
        b=AGfRO8+g2hcTC+um82Ih20csw+ej7Y03Xe6WbRo+OE/NtSXvVeZgCx3ctJPxji5IGL
         8G/fWjd9Aa7JPr+TvMRp7/b5VMJ63bYO96asejwB1Etr89F54L+3u2/rQWSulErHTCMK
         9zcH20j6La7PKTcoJrfI5i49Jt9LA3nZxdAFe6GnKsJrtq7zM0hJFv3sSaYvXXUY6J8B
         E/fnSAhjJjJVxJ+zJxaJEF0Wh6YRh+5oQJwX1uqz6LnZdyUj/vICC85QEFk+F3O3jFbd
         vAhjtnBVLyVMi6wH/HOSdqs1dMXlOcL66TjQNv3SAElG+DtE+bEO3atJuC1/DTyiMhMM
         dfXg==
X-Forwarded-Encrypted: i=1; AJvYcCVo6W+oL+C6xn4560vN1fHk9tCYJS3xdnwsB4LlIeMFr28J1krVeL3/WPhTeHyuEcO8/W55nn5MK+biRmJmk/Xhe3R7bLXyZoZrVn/g
X-Gm-Message-State: AOJu0YzAEYijK9iz9NVn2FS8svgTACc+qf2hCNgR4l3gSrgykE6/JhzE
	W01zg3XuNgs0ie2OOBIE7oqgw1tqIzZ4QGf9X89iG3geLre46UVQYmVV4CLUVGrBZVm30/nttVb
	FkS5HPULUCxz31Lqdp1GNT5uY+9Jy3B30L3SR
X-Google-Smtp-Source: AGHT+IEqf9okWn67PocUy8Jocw+dhghNQyk3Kfdq2yIp+/9Gkk10jzuGIlDmiYcXIwua7o+f+NVqtl0RNtMVswl/hqQ=
X-Received: by 2002:ac8:7e8b:0:b0:447:dd54:2cd4 with SMTP id
 d75a77b69052e-4519adec1a8mr3133101cf.22.1722808533991; Sun, 04 Aug 2024
 14:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com> <aea333fb-44ab-41eb-9060-472b08e3010d@redhat.com>
In-Reply-To: <aea333fb-44ab-41eb-9060-472b08e3010d@redhat.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 4 Aug 2024 15:54:57 -0600
Message-ID: <CAOUHufZ=Oquy_UGBC0FTjJ5QvQnhk0UipHBMfJ5yqSYn06qevg@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: David Hildenbrand <david@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
	roman.gushchin@linux.dev, baohua@kernel.org, ryan.roberts@arm.com, 
	rppt@kernel.org, willy@infradead.org, cerasuolodomenico@gmail.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 9:47=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 01.08.24 08:09, Yu Zhao wrote:
> > On Tue, Jul 30, 2024 at 6:54=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >> The current upstream default policy for THP is always. However, Meta
> >> uses madvise in production as the current THP=3Dalways policy vastly
> >> overprovisions THPs in sparsely accessed memory areas, resulting in
> >> excessive memory pressure and premature OOM killing.
> >> Using madvise + relying on khugepaged has certain drawbacks over
> >> THP=3Dalways. Using madvise hints mean THPs aren't "transparent" and
> >> require userspace changes. Waiting for khugepaged to scan memory and
> >> collapse pages into THP can be slow and unpredictable in terms of perf=
ormance
> >> (i.e. you dont know when the collapse will happen), while production
> >> environments require predictable performance. If there is enough memor=
y
> >> available, its better for both performance and predictability to have
> >> a THP from fault time, i.e. THP=3Dalways rather than wait for khugepag=
ed
> >> to collapse it, and deal with sparsely populated THPs when the system =
is
> >> running out of memory.
> >>
> >> This patch-series is an attempt to mitigate the issue of running out o=
f
> >> memory when THP is always enabled. During runtime whenever a THP is be=
ing
> >> faulted in or collapsed by khugepaged, the THP is added to a list.
> >> Whenever memory reclaim happens, the kernel runs the deferred_split
> >> shrinker which goes through the list and checks if the THP was underut=
ilized,
> >> i.e. how many of the base 4K pages of the entire THP were zero-filled.
> >> If this number goes above a certain threshold, the shrinker will attem=
pt
> >> to split that THP. Then at remap time, the pages that were zero-filled=
 are
> >> not remapped, hence saving memory. This method avoids the downside of
> >> wasting memory in areas where THP is sparsely filled when THP is alway=
s
> >> enabled, while still providing the upside THPs like reduced TLB misses=
 without
> >> having to use madvise.
> >>
> >> Meta production workloads that were CPU bound (>99% CPU utilzation) we=
re
> >> tested with THP shrinker. The results after 2 hours are as follows:
> >>
> >>                              | THP=3Dmadvise |  THP=3Dalways   | THP=
=3Dalways
> >>                              |             |               | + shrinke=
r series
> >>                              |             |               | + max_pte=
s_none=3D409
> >> ----------------------------------------------------------------------=
-------
> >> Performance improvement     |      -      |    +1.8%      |     +1.7%
> >> (over THP=3Dmadvise)          |             |               |
> >> ----------------------------------------------------------------------=
-------
> >> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+=
2.4%)
> >> ----------------------------------------------------------------------=
-------
> >> max_ptes_none=3D409 means that any THP that has more than 409 out of 5=
12
> >> (80%) zero filled filled pages will be split.
> >>
> >> To test out the patches, the below commands without the shrinker will
> >> invoke OOM killer immediately and kill stress, but will not fail with
> >> the shrinker:
> >>
> >> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_non=
e
> >> mkdir /sys/fs/cgroup/test
> >> echo $$ > /sys/fs/cgroup/test/cgroup.procs
> >> echo 20M > /sys/fs/cgroup/test/memory.max
> >> echo 0 > /sys/fs/cgroup/test/memory.swap.max
> >> # allocate twice memory.max for each stress worker and touch 40/512 of
> >> # each THP, i.e. vm-stride 50K.
> >> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
> >> # killer.
> >> # Without the shrinker, OOM killer is invoked immediately irrespective
> >> # of max_ptes_none value and kill stress.
> >> stress --vm 1 --vm-bytes 40M --vm-stride 50K
> >>
> >> Patches 1-2 add back helper functions that were previously removed
> >> to operate on page lists (needed by patch 3).
> >> Patch 3 is an optimization to free zapped tail pages rather than
> >> waiting for page reclaim or migration.
> >> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
> >> subpages when splitting THP.
> >> Patches 6 adds support for THP shrinker.
> >>
> >> (This patch-series restarts the work on having a THP shrinker in kerne=
l
> >> originally done in
> >> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
> >> The THP shrinker in this series is significantly different than the
> >> original one, hence its labelled v1 (although the prerequisite to not
> >> remap clean subpages is the same).)
> >>
> >> Alexander Zhu (1):
> >>    mm: add selftests to split_huge_page() to verify unmap/zap of zero
> >>      pages
> >>
> >> Usama Arif (3):
> >>    Revert "memcg: remove mem_cgroup_uncharge_list()"
> >>    Revert "mm: remove free_unref_page_list()"
> >>    mm: split underutilized THPs
> >>
> >> Yu Zhao (2):
> >>    mm: free zapped tail pages when splitting isolated thp
> >>    mm: don't remap unused subpages when splitting isolated thp
> >
> >   I would recommend shatter [1] instead of splitting so that
> > 1) whoever underutilized their THPs get punished for the overhead;
> > 2) underutilized THPs are kept intact and can be reused by others.
> >
> > [1] https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com/
> >
>
> Do you have any plans to upstream the shattering also during "ordinary"
> deferred splitting?

Yes, once we finish verifying it in our production.

