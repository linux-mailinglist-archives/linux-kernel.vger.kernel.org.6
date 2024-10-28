Return-Path: <linux-kernel+bounces-385881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3959B3CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2CF282D10
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA5E1E25F8;
	Mon, 28 Oct 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9P01oL2"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D7188904
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151647; cv=none; b=LQZk8KuvrBowLTBgZG1rEiSGAhtUOG4V34N3EAHm6ONWCVhyExjpS+xWYFPSk3JKJHFu3PUhMQPJmgoPuY+zniajoO9aJqs+5b0D9CpOcVwXOpRfJrjqaoaid9zg1uWu6WjNUFh4Diu83VD5zr6E8vjsXhSVsArB0wsuh+Gl42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151647; c=relaxed/simple;
	bh=2s8BEfzXfzLm9lw/3mg6kk22d4x4jEBxL+In4u3q7Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3Qw0hYiTQla8PPgufvMRGntZTNzvW8yNam5OxCGhQb0BkqEkhTUpbmubVpHKrDld1dnh/5nH9c28UdacudhsCRcf6HKVPdczBjEm4W6p+wURKjlbNka8yETpc77YqQpdo94cwzwCGdUYZWESx1e7PPOU8CVvhDleeQULbkNDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9P01oL2; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a492f73befso1434004137.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730151644; x=1730756444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s8BEfzXfzLm9lw/3mg6kk22d4x4jEBxL+In4u3q7Sg=;
        b=b9P01oL2705xP2USwrf0s/c3aAHoR1Bl1wiyB8FymG0QA72cnMh7E20HCVhKJWtrUl
         gj3Vj13j+yd/WBltwE+iFMdSlhFmMXb/cE0fqtHg6XtZ86BhNxwYLX2BK4E/zOOkQJOc
         92wxI0IwO7P+xsBrliPpLWT7pQvod/7T2JAkQuMhZRzwHaOcArrHFfvlfWMi3hCtZO+c
         OHYucBdZQyXtc4NMwwhj1v91ut0qiVMMnDGhTVJZPv6aZFgNJMTW16IZ/iJl/kazHSwx
         5L9ZHApVjeBnG/FRZLAOUPBypsckrXT7au1Uy21p5rHJrQgXUQV80dhQIwxOh39C3gRn
         FGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151644; x=1730756444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2s8BEfzXfzLm9lw/3mg6kk22d4x4jEBxL+In4u3q7Sg=;
        b=aauIHASsyAcYRdyMm1vei3dvlAXG2R6lmGDfrU90ztXnBhzRhMVH0rxH+RmtygHfwV
         tSJQ3hxslCIEym4X1Nl1ReguNjiypjMOnXv7WDahHfIW8up7gkmyrHq8/9UKdcQKDxsJ
         uODM+rJaL2/ttqDJ5Ijy9MmbMF+UuhLDPh/nOLTlclCUhXG9uDh/K521bsp4dIDjQbW6
         0H16Iw7WiSs7re/8+ag98SxGocDqb7rRO37903+ITJG/goFQ8bA4JKWCnZYaQD9WIAJR
         CCKa5BkrLzBhU3tOH5xPnB1WIN6CMCCBoZomrpvnzgtvHRu5seOBf5PWBOVAT8pLG/ey
         W8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4mTEmJU/RcpoHbK6AFfPW9ViipjkvTbEnvRh0xiQd06fztgbRnAzURHgS4tvxAh0zaRvl5NNXowe1FGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVes3RdUZ+zalEUNB9hO99xF3W2RqOsoo5vOwZ5Byu9i2nU6F
	HrQG8plZyMjJnjaimM44p5Zy5G1uGfnzarciNdxb70WHU8Xdf4CTQdUZwK09vyKA1jk7iBf4bXq
	6uFALcGl7L2ymH3Twj3CSM+/SMkw=
X-Google-Smtp-Source: AGHT+IGtW1SJibHNISw8SW9HAsPcmFd1euEk8iVYuw9ii0pUsA1oDKqXjb0e7VMl4uMeMay3AOlzUhnHQok6d2LI73U=
X-Received: by 2002:a05:6102:5109:b0:4a7:4900:4b39 with SMTP id
 ada2fe7eead31-4a8cfb4451dmr7873278137.4.1730151643991; Mon, 28 Oct 2024
 14:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com> <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
 <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com> <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
 <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com> <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
 <882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com> <CAGsJ_4yBkry-rw75AciT8OiYWrw+=D0okcxiyXzzNrz=QJxiBA@mail.gmail.com>
 <cba36cb0-66c7-45c1-97c3-a96ea48a6cf0@gmail.com> <CAGsJ_4wXO2Hjs0HZBGsGegBAeE8YxJbCF6ZXQQ6ZnVxgR82AuQ@mail.gmail.com>
 <228c428d-d116-4be1-9d0d-0591667b7ccb@gmail.com>
In-Reply-To: <228c428d-d116-4be1-9d0d-0591667b7ccb@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Oct 2024 05:40:32 +0800
Message-ID: <CAGsJ_4zLNA-1+3j4snNLiujT3NLcmKEVFA4+eD1Sk1bOkqAGYw@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 5:24=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 28/10/2024 21:15, Barry Song wrote:
> > On Tue, Oct 29, 2024 at 4:51=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 28/10/2024 20:42, Barry Song wrote:
> >>> On Tue, Oct 29, 2024 at 4:00=E2=80=AFAM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 28/10/2024 19:54, Barry Song wrote:
> >>>>> On Tue, Oct 29, 2024 at 1:20=E2=80=AFAM Usama Arif <usamaarif642@gm=
ail.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 28/10/2024 17:08, Yosry Ahmed wrote:
> >>>>>>> On Mon, Oct 28, 2024 at 10:00=E2=80=AFAM Usama Arif <usamaarif642=
@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 28/10/2024 16:33, Nhat Pham wrote:
> >>>>>>>>> On Mon, Oct 28, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif64=
2@gmail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> I wonder if instead of having counters, it might be better to =
keep track
> >>>>>>>>>> of the number of zeropages currently stored in zeromap, simila=
r to how
> >>>>>>>>>> zswap_same_filled_pages did it. It will be more complicated th=
en this
> >>>>>>>>>> patch, but would give more insight of the current state of the=
 system.
> >>>>>>>>>>
> >>>>>>>>>> Joshua (in CC) was going to have a look at that.
> >>>>>>>>>
> >>>>>>>>> I don't think one can substitute for the other.
> >>>>>>>>
> >>>>>>>> Yes agreed, they have separate uses and provide different inform=
ation, but
> >>>>>>>> maybe wasteful to have both types of counters? They are counters=
 so maybe
> >>>>>>>> dont consume too much resources but I think we should still thin=
k about
> >>>>>>>> it..
> >>>>>>>
> >>>>>>> Not for or against here, but I would say that statement is debata=
ble
> >>>>>>> at best for memcg stats :)
> >>>>>>>
> >>>>>>> Each new counter consumes 2 longs per-memcg per-CPU (see
> >>>>>>> memcg_vmstats_percpu), about 16 bytes, which is not a lot but it =
can
> >>>>>>> quickly add up with a large number of CPUs/memcgs/stats.
> >>>>>>>
> >>>>>>> Also, when flushing the stats we iterate all of them to propagate
> >>>>>>> updates from per-CPU counters. This is already a slowpath so addi=
ng
> >>>>>>> one stat is not a big deal, but again because we iterate all stat=
s on
> >>>>>>> multiple CPUs (and sometimes on each node as well), the overall f=
lush
> >>>>>>> latency becomes a concern sometimes.
> >>>>>>>
> >>>>>>> All of that is not to say we shouldn't add more memcg stats, but =
we
> >>>>>>> have to be mindful of the resources.
> >>>>>>
> >>>>>> Yes agreed! Plus the cost of incrementing similar counters (which =
ofcourse is
> >>>>>> also not much).
> >>>>>>
> >>>>>> Not trying to block this patch in anyway. Just think its a good po=
int
> >>>>>> to discuss here if we are ok with both types of counters. If its t=
oo wasteful
> >>>>>> then which one we should have.
> >>>>>
> >>>>> Hi Usama,
> >>>>> my point is that with all the below three counters:
> >>>>> 1. PSWPIN/PSWPOUT
> >>>>> 2. ZSWPIN/ZSWPOUT
> >>>>> 3. SWAPIN_SKIP/SWAPOUT_SKIP or (ZEROSWPIN, ZEROSWPOUT what ever)
> >>>>>
> >>>>> Shouldn't we have been able to determine the portion of zeromap
> >>>>> swap indirectly?
> >>>>>
> >>>>
> >>>> Hmm, I might be wrong, but I would have thought no?
> >>>>
> >>>> What if you swapout a zero folio, but then discard it?
> >>>> zeromap_swpout would be incremented, but zeromap_swapin would not.
> >>>
> >>> I understand. It looks like we have two issues to tackle:
> >>> 1. We shouldn't let zeromap swap in or out anything that vanishes int=
o
> >>> a black hole
> >>> 2. We want to find out how much I/O/memory has been saved due to zero=
map so far
> >>>
> >>> From my perspective, issue 1 requires a "fix", while issue 2 is more
> >>> of an optimization.
> >>
> >> Hmm I dont understand why point 1 would be an issue.
> >>
> >> If its discarded thats fine as far as I can see.
> >
> > it is fine to you and probably me who knows zeromap as well :-) but
> > any userspace code
> > as below might be entirely confused:
> >
> > p =3D malloc(1G);
> > write p to 0; or write part of p to 0
> > madv_pageout(p, 1g)
> > read p to swapin.
> >
> > The entire procedure used to involve 1GB of swap out and 1GB of swap in=
 by any
> > means. Now, it has recorded 0 swaps counted.
> >
> > I don't expect userspace is as smart as you :-)
> >
> Ah I completely agree, we need to account for it in some metric. I probab=
ly
> misunderstood when you said "We shouldn't let zeromap swap in or out anyt=
hing that
> vanishes into a black hole", by we should not have the zeromap optimizati=
on for those
> cases. What I guess you meant is we need to account for it in some metric=
.
>
> >>
> >> As a reference, memory.stat.zswapped !=3D memory.stat.zswapout - memor=
y.stat.zswapin.
> >> Because zswapped would take into account swapped out anon memory freed=
, MADV_FREE,
> >> shmem truncate, etc as Yosry said about zeromap, But zswapout and zswa=
pin dont.
> >
> > I understand. However, I believe what we really need to focus on is
> > this: if we=E2=80=99ve
> > swapped out, for instance, 100GB in the past hour, how much of that 100=
GB is
> > zero? This information can help us assess the proportion of zero data i=
n the
> > workload, along with the potential benefits that zeromap can provide fo=
r memory,
> > I/O space, or read/write operations. Additionally, having the second co=
unt
> > can enhance accuracy when considering MADV_DONTNEED, FREE, TRUNCATE,
> > and so on.
> >
> Yes completely agree!
>
> I think we can look into adding all three metrics, zeromap_swapped, zerom=
ap_swpout,
> zeromap_swpin (or whatever name works).

It's great to reach an agreement. Let me work on some patches for it.

By the way, I recently had an idea: if we can conduct the zeromap check
earlier - for example - before allocating swap slots and pageout(), could
we completely eliminate swap slot occupation and allocation/release
for zeromap data? For example, we could use a special swap
entry value in the PTE to indicate zero content and directly fill it with
zeros when swapping back. We've observed that swap slot allocation and
freeing can consume a lot of CPU and slow down functions like
zap_pte_range and swap-in. If we can entirely skip these steps, it
could improve performance. However, I'm uncertain about the benefits we
would gain if we only have 1-2% zeromap data.

I'm just putting this idea out there to see if you're interested in moving
forward with it. :-)

>
> >>
> >>
> >>>
> >>> I consider issue 1 to be more critical because, after observing a pho=
ne
> >>> running for some time, I've been able to roughly estimate the portion
> >>> zeromap can
> >>> help save using only PSWPOUT, ZSWPOUT, and SWAPOUT_SKIP, even without=
 a
> >>> SWPIN counter. However, I agree that issue 2 still holds significant =
value
> >>> as a separate patch.
> >>>
> >

Thanks
Barry

