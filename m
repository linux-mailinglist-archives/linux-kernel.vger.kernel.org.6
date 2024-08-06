Return-Path: <linux-kernel+bounces-276705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD79C949747
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD4B1C212DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B34F6F2EB;
	Tue,  6 Aug 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJ2S5Gj3"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6624211
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967621; cv=none; b=J7LtaLd9k4QXah/dAd7bEZaRA+hVZpaFhn5eEof2vVxCVJqquQEOvByRGclELiSGUq3UD1/gUiy4KiUdUQX3ukA/xLbZ3hQdQfyV8kvJ0GndLn0Z+GnJjCyYr1ZWPoNV4YP0+itBL4hpfhh7FJNAjevmflSA6SIDC/SBSPs4L04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967621; c=relaxed/simple;
	bh=WuhskdTwh3qaEPhMQQjYELqlsIsRhputzcXhW/m4K+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKQL582xeqW7k8x+fPZPz9DHahfsYzjQXOJa9r3aHPHhy7TlFiGIpMh+Y9YDhin+GG2+v7Gmq1LYelgwf6qwkSWM60LNqwQcgVc968+8vNB3CupT8eueEY19oBInRZmfpOgoFnTjAMvZj8+iB646T+CnWmhb16oB//7eUmOfSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJ2S5Gj3; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fdc70e695so591161cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722967619; x=1723572419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkioQVGF+wSLQTbkssOazSN8dIovK/fE4dOy9+EWWvg=;
        b=kJ2S5Gj3gWhW67X2gZ1jSc1EazQ3vo9AYxWdLHInBpGEK1HTVRPOAdWQj8SsflaFvH
         Iy3b0OngTIwzwKvLvoX1FfDjQCstCzG0rH6i+Vgk9i3re3t3qtUkESh2uGI9CTAUUCxY
         kUyWJ88iObv5FYcAHoMWDFWxD5EMlMB738LTiy8uGayHjpMbmE0Z/lOdGIhcBmu8RHMP
         OB7VKxmWFMEULI0wVS45eqfTTLjuRxBcQJJPH92us26TcD/xj5Hx/Hpd35mPBfY+qZZn
         weYiMYHkTyzdbLkc25hHq7eO2G9SsoLC9UH22SjpYngQN99ASoHbOvep+8fRlsZSe+fg
         KY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967619; x=1723572419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkioQVGF+wSLQTbkssOazSN8dIovK/fE4dOy9+EWWvg=;
        b=GqWPOEHXGvxJyOBdDczuk/RDrrSDPYU2y6F71qhFPletG6wUK7Ubw9KKyfwJy1p0zR
         kCKMsNn9QHxBu24lV4EmrjiuHMHqX9DHgsHdLVC+E5UYyEP5wMX2hZtjMAxM4uGMDlIu
         WlU8VaaHgKD1+Qr6dxZTsiwJMOTaUh7GBgKpEiX2PaFohJH/tuyoycnOTAcnVkOs3Hx3
         Rs7Rq6dB6Cp4FvxqGA4IWSWSThfchFuRP5D30iy93J86iDNDaA585bRCH7po59BVkW+P
         fOYFVI+yNXoXkCc2EIktqMxzS7asoajHcBTWcCjnpm5797bx/KSshtOq/s1VwYrwK1dZ
         l2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlWOOCqTjKMGaPi469rlFXx3hdp86BObarj6pVEE/kE/SA4j5PC/gCp5pmFNgqP7m1QDEs7MiD32v9SZI3VLDwHp38JiwIHNAr8n/b
X-Gm-Message-State: AOJu0YyQeKr1iMrg3Gb+JuchMJEliDM1XxV5VRa8ru6cEAa49NAcDe1j
	39NuYNyVMsLDqCuG5IoDWExsCWJLN5g5MoSxiJWFyu3HaVq2rEKj4d6XvP3aJbnT92KZ7m1hTVu
	6KPFncdwHiPoTcPcrRvWWtsf0m/JrJflzv0fp
X-Google-Smtp-Source: AGHT+IHZNrc+FnooCfdfckKFlUU+RkmBQlO7XEnnfitvjHUtcg6asUd2mxT6pVacIbyvDNUzFrYiQJKl5snCiPdsZf8=
X-Received: by 2002:ac8:5743:0:b0:44f:9e0f:bc41 with SMTP id
 d75a77b69052e-451c5bc8aa5mr65871cf.27.1722967618415; Tue, 06 Aug 2024
 11:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com> <20240806173840.GE322282@cmpxchg.org>
In-Reply-To: <20240806173840.GE322282@cmpxchg.org>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 6 Aug 2024 12:06:20 -0600
Message-ID: <CAOUHufavZTKjh6sb4n_q0ciLzTS88Kxxkp_2Q1wWVp_ZkFrshQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 11:38=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Aug 01, 2024 at 12:09:16AM -0600, Yu Zhao wrote:
> > On Tue, Jul 30, 2024 at 6:54=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> > >
> > > The current upstream default policy for THP is always. However, Meta
> > > uses madvise in production as the current THP=3Dalways policy vastly
> > > overprovisions THPs in sparsely accessed memory areas, resulting in
> > > excessive memory pressure and premature OOM killing.
> > > Using madvise + relying on khugepaged has certain drawbacks over
> > > THP=3Dalways. Using madvise hints mean THPs aren't "transparent" and
> > > require userspace changes. Waiting for khugepaged to scan memory and
> > > collapse pages into THP can be slow and unpredictable in terms of per=
formance
> > > (i.e. you dont know when the collapse will happen), while production
> > > environments require predictable performance. If there is enough memo=
ry
> > > available, its better for both performance and predictability to have
> > > a THP from fault time, i.e. THP=3Dalways rather than wait for khugepa=
ged
> > > to collapse it, and deal with sparsely populated THPs when the system=
 is
> > > running out of memory.
> > >
> > > This patch-series is an attempt to mitigate the issue of running out =
of
> > > memory when THP is always enabled. During runtime whenever a THP is b=
eing
> > > faulted in or collapsed by khugepaged, the THP is added to a list.
> > > Whenever memory reclaim happens, the kernel runs the deferred_split
> > > shrinker which goes through the list and checks if the THP was underu=
tilized,
> > > i.e. how many of the base 4K pages of the entire THP were zero-filled=
.
> > > If this number goes above a certain threshold, the shrinker will atte=
mpt
> > > to split that THP. Then at remap time, the pages that were zero-fille=
d are
> > > not remapped, hence saving memory. This method avoids the downside of
> > > wasting memory in areas where THP is sparsely filled when THP is alwa=
ys
> > > enabled, while still providing the upside THPs like reduced TLB misse=
s without
> > > having to use madvise.
> > >
> > > Meta production workloads that were CPU bound (>99% CPU utilzation) w=
ere
> > > tested with THP shrinker. The results after 2 hours are as follows:
> > >
> > >                             | THP=3Dmadvise |  THP=3Dalways   | THP=
=3Dalways
> > >                             |             |               | + shrinke=
r series
> > >                             |             |               | + max_pte=
s_none=3D409
> > > ---------------------------------------------------------------------=
--------
> > > Performance improvement     |      -      |    +1.8%      |     +1.7%
> > > (over THP=3Dmadvise)          |             |               |
> > > ---------------------------------------------------------------------=
--------
> > > Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (=
+2.4%)
> > > ---------------------------------------------------------------------=
--------
> > > max_ptes_none=3D409 means that any THP that has more than 409 out of =
512
> > > (80%) zero filled filled pages will be split.
> > >
> > > To test out the patches, the below commands without the shrinker will
> > > invoke OOM killer immediately and kill stress, but will not fail with
> > > the shrinker:
> > >
> > > echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_no=
ne
> > > mkdir /sys/fs/cgroup/test
> > > echo $$ > /sys/fs/cgroup/test/cgroup.procs
> > > echo 20M > /sys/fs/cgroup/test/memory.max
> > > echo 0 > /sys/fs/cgroup/test/memory.swap.max
> > > # allocate twice memory.max for each stress worker and touch 40/512 o=
f
> > > # each THP, i.e. vm-stride 50K.
> > > # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
> > > # killer.
> > > # Without the shrinker, OOM killer is invoked immediately irrespectiv=
e
> > > # of max_ptes_none value and kill stress.
> > > stress --vm 1 --vm-bytes 40M --vm-stride 50K
> > >
> > > Patches 1-2 add back helper functions that were previously removed
> > > to operate on page lists (needed by patch 3).
> > > Patch 3 is an optimization to free zapped tail pages rather than
> > > waiting for page reclaim or migration.
> > > Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
> > > subpages when splitting THP.
> > > Patches 6 adds support for THP shrinker.
> > >
> > > (This patch-series restarts the work on having a THP shrinker in kern=
el
> > > originally done in
> > > https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
> > > The THP shrinker in this series is significantly different than the
> > > original one, hence its labelled v1 (although the prerequisite to not
> > > remap clean subpages is the same).)
> > >
> > > Alexander Zhu (1):
> > >   mm: add selftests to split_huge_page() to verify unmap/zap of zero
> > >     pages
> > >
> > > Usama Arif (3):
> > >   Revert "memcg: remove mem_cgroup_uncharge_list()"
> > >   Revert "mm: remove free_unref_page_list()"
> > >   mm: split underutilized THPs
> > >
> > > Yu Zhao (2):
> > >   mm: free zapped tail pages when splitting isolated thp
> > >   mm: don't remap unused subpages when splitting isolated thp
> >
> >  I would recommend shatter [1] instead of splitting so that
>
> I agree with Rik, this seems like a possible optimization, not a
> pre-requisite.
>
> > 1) whoever underutilized their THPs get punished for the overhead;
>
> Is that true?

Yes :)

> The downgrade is done in a shrinker.

Ideally, should we charge for the CPU usage of the shrinker and who
should we charge it to?

> With or without
> shattering, the compaction effort will be on the allocation side.

If compaction is needed at all.

> > 2) underutilized THPs are kept intact and can be reused by others.
>
> If migration of the subpages is possible, then compaction can clear
> the block as quickly as shattering can.

Compaction needs to scan and find the block first, assuming that block
is still movable when it gets there.

> The only difference is that
> compaction would do the work on-demand

And can often fail to produce 2MB blocks *under memory pressure*

> whereas shattering would do it unconditionally

And always produces a 2MB block

> whether a THP has been requested or not...

With the former condition being the priority because of *THP=3Dalways*.

