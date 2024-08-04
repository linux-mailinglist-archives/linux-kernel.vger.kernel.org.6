Return-Path: <linux-kernel+bounces-274039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D26E9471C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14571C2084E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865E13BAE4;
	Sun,  4 Aug 2024 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQyuTlaT"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419A11755C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 23:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722813880; cv=none; b=bOVCfdnfOi83+UxhpHV6AHqitoPviNEPjKpYh/Pkh69QUL1hzMo8GoydkC05LdEIVtUkzrJs9yEvA59GplxKkmxRZJFp+QQZ/k86p8YW84KNSRFK4W19FHGz5yPNB/N8e/jrY6GuHzqhibBX6uIyHwdyZtn1p9M97I66Fy18KCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722813880; c=relaxed/simple;
	bh=q0cU32TywMidNJy3sQJuba1Ba+KWPc5LcodaJ2iRSB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miP0aj5CC7Mn2P+Z+8mIzO+p3lH93MjdJ8yrnqeNQRRKN5XYv2eqmrrTXUwP+RIMs6YbTy3olV8mibAksCsHkNlqdJpf1QCswvJjHK/IlJCnc9+KMPZ5a0h5n/9WztDo0pcPuEKOyyLAWTU3pE1Z8RncObgeex91GaLcd7pKLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQyuTlaT; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4518d9fa2f4so614711cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 16:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722813877; x=1723418677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suSEtVR1I2xIVSc3Ex8NF0vFCDbOUuicRVSQsETi9/g=;
        b=nQyuTlaTqMVsTa6/iIQDdNWEe7RtDh4f1YakHSZoUviMVnQeTItJ2T14w9NoXbRH+/
         /zwmWkxvj7mmSLc1QEElNNCjPgYVqjMWwyTExsKtQookdDZ63XX35RnKZJ+UvzLMggF4
         XZR1fQQNI97Ah7zrCv2usZOkzaBtvmpecRoor/SL0Anix1ZNsojJS/fyvGhBij2e4HY4
         TiYWTifwcoG3iG4a9vC0cD6u4CTbuW0EUGmo2zKl2Xcp+uatlDj/nLYvLW0tKfHtQohB
         Kkxz2JObYPp+0do+gyIJq3JYOzUJYHn8BM4OOk6y8mFX2dfy9ZmGQz9f/kgyadkOquUx
         DSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722813877; x=1723418677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suSEtVR1I2xIVSc3Ex8NF0vFCDbOUuicRVSQsETi9/g=;
        b=VBw77UZZOxCqk87PiPDoxyrApnRhNtJW9j/V/SYYaMtfuZhpc0RBW/4LuF3KYgKl84
         n88yCtx6BbjYw9297U8lG4OaybSWMv53P2sUrdv3B3Hu0rQT+8WMtVgJnZz3UAQZMkw4
         51X8qdTY9OEf3mS6AHdwParWSdolug0xaksXzRJ/Pr+khCtwUeUhxbouQDVr8+4sJmJ8
         mZLQnQu6V7IWqff3yN7WIh+qnAAFDC3tZMkvyNdjKZO+VxOyBRS1V3HgTmnyN78YivtC
         rr14vRHtI1JxZWo5YT1q+HZQjm4I1LIzrN4UyP0KgMzWm41bkekCJ4pWjQKv0YAAfslP
         qq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWduF6tzhBJ6QC6EPE1qp8Nv7qLr27624l16Lp1qBrzGpU0VUpsRiq0Y7ofE66fJfSGCCem8ojdDIXhWmGDZFzsiiT3tmf+66K2IQje
X-Gm-Message-State: AOJu0Yw4BN/ACpdUYJhRbXj+FP5KgxAt2Pd5cAAHDO4u16/uBQYjCRbk
	FJUSdTivs0H9+1VD9MuVLFcsyZ5VNGjNDD2jPvfc4Q+rcMSZ7IgOy5lW/ihemkzUmfOx/+4th8t
	fbyVpmpXXBfLAjjaz8JkyXTUUlR6BVBRLwPmb
X-Google-Smtp-Source: AGHT+IGu2BLZ1Xcsuy9DvPcV0ZGyp2G746XQkt9mJ0BJ1uphUDo9aLZEoy3WeHcw/GDVMOkr07Uzk43OlYElH9/IMxA=
X-Received: by 2002:a05:622a:1a8a:b0:447:e728:d9b with SMTP id
 d75a77b69052e-4519ae1ee8emr3138701cf.26.1722813876807; Sun, 04 Aug 2024
 16:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com> <f5c5f602-718a-4408-95d3-ed114398ac26@gmail.com>
In-Reply-To: <f5c5f602-718a-4408-95d3-ed114398ac26@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 4 Aug 2024 17:23:58 -0600
Message-ID: <CAOUHufY9B6UEgOG1atezS_U7rsfr-1exavccpRUKhmOwUd2kdQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org, 
	willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:22=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 01/08/2024 07:09, Yu Zhao wrote:
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
> >>                             | THP=3Dmadvise |  THP=3Dalways   | THP=3D=
always
> >>                             |             |               | + shrinker=
 series
> >>                             |             |               | + max_ptes=
_none=3D409
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
> >>   mm: add selftests to split_huge_page() to verify unmap/zap of zero
> >>     pages
> >>
> >> Usama Arif (3):
> >>   Revert "memcg: remove mem_cgroup_uncharge_list()"
> >>   Revert "mm: remove free_unref_page_list()"
> >>   mm: split underutilized THPs
> >>
> >> Yu Zhao (2):
> >>   mm: free zapped tail pages when splitting isolated thp
> >>   mm: don't remap unused subpages when splitting isolated thp
> >
> >  I would recommend shatter [1] instead of splitting so that
> > 1) whoever underutilized their THPs get punished for the overhead;
> > 2) underutilized THPs are kept intact and can be reused by others.
> >
> > [1] https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com/
>
> The objective of this series is to reduce memory usage, while trying to k=
eep the performance benefits you get of using THP=3Dalways.

Of course.

> Punishing any applications performance is the opposite of what I am tryin=
g to do here.

For applications that prefer THP=3Dalways, you would punish them more by
using split.

> For e.g. if there is only one main application running in production, and=
 its using majority of the THPs, then reducing its performance doesn't make=
 sense.

Exactly, and that's why I recommended shatter.

Let's walk through the big picture, and hopefully you'll agree.

Applications prefer THP=3Dalways because they want to allocate THPs. As
you mentioned above, the majority of their memory would be backed by
THPs, highly utilized.

You also mentioned that those applications can run into memory
pressure or even OOMs, which I agree, and this is essentially what we
are trying to solve here. Otherwise, with unlimited memory, we
wouldn't need to worry about internal fragmentation in this context.

So on one hand, we want to allocate THPs; on the other, we run into
memory pressure. It's obvious that splitting under this specific
condition can't fully solve our problem -- after splitting, we still
have to do compaction to fulfill new THP allocation requests.
Theoretically, splitting plus compaction is more expensive than
shattering itself: expressing the efficiency in
compact_success/(compact_success+fail), the latter is 100%; the former
is nowhere near it, and our experiments agree with this.

If applications opt for direct compaction, they'd pay for THP
allocation latency; if they don't want to wait, i.e., with background
compaction, but they'd pay for less THP coverage. So they are punished
either way, not in the THP shrinker path, but in their allocation
path. In comparison, shattering wins in both cases, as I explained
above.

> Also, just going through the commit, and found the line "The advantage of=
 shattering is that it keeps the original THP intact" a bit confusing. I am=
 guessing the THP is freed?

Yes, so that we don't have to do compaction.

> i.e. if a 2M THP has 10 non-zero filled base pages and the rest are zero-=
filled, then after shattering we will have 10*4K memory and not 2M+10*4K?

Correct.

> Is it the case the THP is reused at next fault?

Yes, and this is central to our condition: we are under memory
pressure with THP=3Dalways.

