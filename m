Return-Path: <linux-kernel+bounces-389578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D439B6EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5071C2134E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00E1E0489;
	Wed, 30 Oct 2024 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvnqL8Fc"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433241CBEA3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323129; cv=none; b=bnmFJyw/Q57G0wEPX7CAg8GC2ZyLx2iyV8yXQqTjIpjkrTRULH4aO8v14ng3d/kvO0+29sfeiEEXs+KhtHFCtP1nOLA0jXioU0HUPrqNG8MNUBpnhlbyshzm1MDVTL4yYXvXg2yja9EtovRvrYpIkMrzsktokX9Vzi7c6IC8zG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323129; c=relaxed/simple;
	bh=gBj8Er8NMrOYhbRjUej2vh8pNnsdyKz70XmQboypEJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dv2cjnIqmrCAEA7g1YO0mJC2iU2+p71i2Ma4vCvvXU+js50YGg5Nz8yXf4KHxw5pyGhpkwpbxTTSftSJw2x92hcavMkxZaBnvb9ffo7XhiLV+ZRp3T1gm0cjLzV9c9VqELz3popFzUuVJSDaHKHD3Arz4n5CDh3iqEQniTkFjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jvnqL8Fc; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46089a6849bso1918711cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730323126; x=1730927926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBj8Er8NMrOYhbRjUej2vh8pNnsdyKz70XmQboypEJ4=;
        b=jvnqL8FcjZlEsBfFdgJlYjhToUF+RcBFXEyERWCK0UgJulIKImwZ+irxpmIn0mwUky
         /TZnG8JIRdVmWHLyul2wqVAM7ZuAWug0+cuISZAobAoaiU6p4JPIg4tEYRRRXK2IMgVp
         XNdzsxXrywkAOy6EazC54zTXT43P1I/F9jg9XahKd8/VTjZ7l8IYp1MP+QUlz5DM8YcO
         3YcV40K5P1jf666DldphCqYdRSyLQenru30Aw/mPmfE3lOevJLBBpdpPc34sBpESdQyP
         r6Z4YQMFwB4RDWSRH30WJnf3+P4ez7WZTZnMRE/NlInfJAYftIxOJZMrMHIIxw2BQhlu
         1wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323126; x=1730927926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBj8Er8NMrOYhbRjUej2vh8pNnsdyKz70XmQboypEJ4=;
        b=PBeHzPc+BLcOU15DDSBOHYtSN7FlCivc+ivJoYcKcqaD0tsnh5sr3PbjgzAPUr1JOT
         T4eMyO/EFFWXXSz/uuJ9ke2esuTnQbSmFGhVYI6itsmusNB8542SwOVROBwjcisiDAZ7
         a5f8cvZLqb3psSE6yuPQC4DW8+eYJ08/XU4aAWiwOsxCqcbyv3sL4c6TrZcl/yaPtYz9
         kMAX+VswetH5lC7RSAeLapABrQUtAct3dDugGReQe5YZ1DwMF88itJjjRZrqlhpEuWUV
         ++MqSR/Ivn3NmS3B7HNXn3S9bvk6Bt5C1eL/XknHrAc9MMoK6QJRJXeWw5UszRtwpRGU
         9MIw==
X-Forwarded-Encrypted: i=1; AJvYcCXV19gh3v7ySS4OymUJ/o0+F8V+SYvu7BzUW04MY4WDwW2/jTfieTSVOG+7T/E9gmZUcfjMDiwb/9XD+Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtUJx7Vqg3moCx5+vCUFDc+4xudqLO2VyS1tUj50c4q3phNKnv
	MyjJ5dWlSCMBxN0EZYnc7rbhneAxLYaWLKOEeIsmwMBzhoRDm8wKSkYq6Hmh70ibc51as7UGKZd
	eBYPMqyOzSDH2nP9MF1GNmIN6iGe3j4UvawAQ
X-Google-Smtp-Source: AGHT+IHxI3w9cOo1L55Sdi+cgh5+XY+pSQKUVCS3e1+2Yp8Xa0xDfZtTA6XPuIairOm84cmvRC727x8Z9h9wQ67ANzE=
X-Received: by 2002:a05:622a:15c5:b0:461:15a1:788a with SMTP id
 d75a77b69052e-462ab30a280mr13532511cf.57.1730323125830; Wed, 30 Oct 2024
 14:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027001444.3233-1-21cnbao@gmail.com> <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
 <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
 <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com> <CAJD7tkZ60ROeHek92jgO0z7LsEfgPbfXN9naUC5j7QjRQxpoKw@mail.gmail.com>
 <852211c6-0b55-4bdd-8799-90e1f0c002c1@gmail.com> <CAJD7tkaXL_vMsgYET9yjYQW5pM2c60fD_7r_z4vkMPcqferS8A@mail.gmail.com>
 <c76635d7-f382-433a-8900-72bca644cdaa@gmail.com>
In-Reply-To: <c76635d7-f382-433a-8900-72bca644cdaa@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 30 Oct 2024 14:18:09 -0700
Message-ID: <CAJD7tkYSRCjtEwP=o_n_ZhdfO8nga-z-a=RirvcKL7AYO76XJw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 2:13=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 30/10/2024 21:01, Yosry Ahmed wrote:
> > On Wed, Oct 30, 2024 at 1:25=E2=80=AFPM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 30/10/2024 19:51, Yosry Ahmed wrote:
> >>> [..]
> >>>>> My second point about the mitigation is as follows: For a system (o=
r
> >>>>> memcg) under severe memory pressure, especially one without hardwar=
e TLB
> >>>>> optimization, is enabling mTHP always the right choice? Since mTHP =
operates at
> >>>>> a larger granularity, some internal fragmentation is unavoidable, r=
egardless
> >>>>> of optimization. Could the mitigation code help in automatically tu=
ning
> >>>>> this fragmentation?
> >>>>>
> >>>>
> >>>> I agree with the point that enabling mTHP always is not the right th=
ing to do
> >>>> on all platforms. I also think it might be the case that enabling mT=
HP
> >>>> might be a good thing for some workloads, but enabling mTHP swapin a=
long with
> >>>> it might not.
> >>>>
> >>>> As you said when you have apps switching between foreground and back=
ground
> >>>> in android, it probably makes sense to have large folio swapping, as=
 you
> >>>> want to bringin all the pages from background app as quickly as poss=
ible.
> >>>> And also all the TLB optimizations and smaller lru overhead you get =
after
> >>>> you have brought in all the pages.
> >>>> Linux kernel build test doesnt really get to benefit from the TLB op=
timization
> >>>> and smaller lru overhead, as probably the pages are very short lived=
. So I
> >>>> think it doesnt show the benefit of large folio swapin properly and
> >>>> large folio swapin should probably be disabled for this kind of work=
load,
> >>>> eventhough mTHP should be enabled.
> >>>>
> >>>> I am not sure that the approach we are trying in this patch is the r=
ight way:
> >>>> - This patch makes it a memcg issue, but you could have memcg disabl=
ed and
> >>>> then the mitigation being tried here wont apply.
> >>>
> >>> Is the problem reproducible without memcg? I imagine only if the
> >>> entire system is under memory pressure. I guess we would want the sam=
e
> >>> "mitigation" either way.
> >>>
> >> What would be a good open source benchmark/workload to test without li=
miting memory
> >> in memcg?
> >> For the kernel build test, I can only get zswap activity to happen if =
I build
> >> in cgroup and limit memory.max.
> >
> > You mean a benchmark that puts the entire system under memory
> > pressure? I am not sure, it ultimately depends on the size of memory
> > you have, among other factors.
> >
> > What if you run the kernel build test in a VM? Then you can limit is
> > size like a memcg, although you'd probably need to leave more room
> > because the entire guest OS will also subject to the same limit.
> >
>
> I had tried this, but the variance in time/zswap numbers was very high.
> Much higher than the AMD numbers I posted in reply to Barry. So found
> it very difficult to make comparison.

Hmm yeah maybe more factors come into play with global memory
pressure. I am honestly not sure how to test this scenario, and I
suspect variance will be high anyway.

We can just try to use whatever technique we use for the memcg limit
though, if possible, right?

>
> >>
> >> I can just run zswap large folio zswapin in production and see, but th=
at will take me a few
> >> days. tbh, running in prod is a much better test, and if there isn't a=
ny sort of thrashing,
> >> then maybe its not really an issue? I believe Barry doesnt see an issu=
e in android
> >> phones (but please correct me if I am wrong), and if there isnt an iss=
ue in Meta
> >> production as well, its a good data point for servers as well. And may=
be
> >> kernel build in 4G memcg is not a good test.
> >
> > If there is a regression in the kernel build, this means some
> > workloads may be affected, even if Meta's prod isn't. I understand
> > that the benchmark is not very representative of real world workloads,
> > but in this instance I think the thrashing problem surfaced by the
> > benchmark is real.
> >
> >>
> >>>> - Instead of this being a large folio swapin issue, is it more of a =
readahead
> >>>> issue? If we zswap (without the large folio swapin series) and chang=
e the window
> >>>> to 1 in swap_vma_readahead, we might see an improvement in linux ker=
nel build time
> >>>> when cgroup memory is limited as readahead would probably cause swap=
 thrashing as
> >>>> well.
> >>>
> >>> I think large folio swapin would make the problem worse anyway. I am
> >>> also not sure if the readahead window adjusts on memory pressure or
> >>> not.
> >>>
> >> readahead window doesnt look at memory pressure. So maybe the same thi=
ng is being
> >> seen here as there would be in swapin_readahead?
> >
> > Maybe readahead is not as aggressive in general as large folio
> > swapins? Looking at swap_vma_ra_win(), it seems like the maximum order
> > of the window is the smaller of page_cluster (2 or 3) and
> > SWAP_RA_ORDER_CEILING (5).
> Yes, I was seeing 8 pages swapin (order 3) when testing. So might
> be similar to enabling 32K mTHP?

Not quite.

>
> >
> > Also readahead will swapin 4k folios AFAICT, so we don't need a
> > contiguous allocation like large folio swapin. So that could be
> > another factor why readahead may not reproduce the problem.

Because of this ^.

