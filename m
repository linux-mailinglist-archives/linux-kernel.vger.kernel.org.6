Return-Path: <linux-kernel+bounces-385961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0C99B3D87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC6F283702
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAA419005F;
	Mon, 28 Oct 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoGxTwl4"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5FD1CF5CA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153502; cv=none; b=jonOJWG/Eerji6DZTjDvFz1evnrPPYTt8i0NuwwYE6IFtOIr1/HuNmhrtx65O0soBTxNLTKFwxTvmjH4mpKZgYIc+v9ARd/aBkliN5fG0O2hnYE1X9dZiCWayiZBFqRJ36kk9l7s+LuOxXTMOsdhenyHT+RjEkdnZ0dGTgztcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153502; c=relaxed/simple;
	bh=X/BU+pdAKTbnfpAfLFBXKeutwwFr70bY4iy5qLivOUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6IWr+S6UlIGkb5FVeDs0WeJXlWukCV/c4+KI5o8mwW1toAvAQUo5j/4hSOsYxoz5tb1X8/ldupC062Qbzxq8uwNKctO6ZwTTA07xh1tt+1BR9GvHzACctkVNbc1UK4ny9wgXiZdGmmPTq3k6FF31CNaK0jw5D96Kop96OpBhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoGxTwl4; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84fc7b58d4dso1135421241.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730153499; x=1730758299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/BU+pdAKTbnfpAfLFBXKeutwwFr70bY4iy5qLivOUQ=;
        b=DoGxTwl4UFzFMQnUWwybAsSqxxv4YjMdGo0fYOlySjnSq9xgSzTj1hPoDknF4zaU7q
         JJaLD4vgqvQIyRZSpe7DxIK+0I2/nKB8TVKMwVzyxiei5qfx0Q2W3o9XndUFJ80oEhMj
         oU/i/e4B+bqE4GBPdGgscdMN/UqDgqeL/wlTwE/KrzYZ+oWEmG2cyl1F1u2zFzqBWMaI
         qd4P9sM9VknAFDT2asaCERsJEDxpBJX9ouPtSwI15pGx/kNPsOxyfPvHGKDqTl8E5cG+
         MQpGSG2DSkHIdwzQWky0aR93wBJ+bjdTeVsPlcdq7kLFEmePtu0UoYtqoOVynX4+S1t3
         9Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153499; x=1730758299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/BU+pdAKTbnfpAfLFBXKeutwwFr70bY4iy5qLivOUQ=;
        b=B/QpKmkKtuD4jf5d7sbHRhCfCqx/07whpgWUEDwthKO02WD8eROb8mJoT7zvzkby5R
         69se6nbsx8j9MhtWK8/TNFC/euCxA9NnEDUlnByMGtADdZiuaMwrfcS8m4XKhAY3Mzux
         oVXeW/18n8TiftnpWwAvIZb7frbqgxn68XpvnwEjRpoTC8x5mcDotuZY6805Cm7HED4s
         QJcaDdxCHmxjaAWgGzn/MC6qK4AW03i3PhTClb9QiWPIIvCypSOCENsnvrNcrUNIKH+j
         JkZHZLqM6oDpbqPk5CbbJskugqDK8eoieA8noU+TH0VRM3cGNNVLgAnuP4W0N+4tdOKP
         v4mg==
X-Forwarded-Encrypted: i=1; AJvYcCUAbPMX6uD5KhUthGM+6/us0MuznMWDzTjD0g6aFAY5H7i08J512waIL3qVaj+jw3s3Egib01lGln8p7M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdhGZfX3Tz6AthTou/W15UqDBaFROF3Y8Q6p3pf5jd5lgKbGz
	RlyMkqcwJ7FZ82U9Px5moZ6EF1Q6JaJFuzu6RLy3IfQO3BQGtNDYxBn00QOCisycHWAAsn2R76e
	t9qZpIx59tSJmkAKxNNFjHI7H1jk=
X-Google-Smtp-Source: AGHT+IEVO+AkNDqaXEljKov4umzoPqup0Z2wBZCcXV/aYqkRSYSjyQ3ZZBQy5CvP3f2DYkF5MrO1b5lWNq5YlszWXuE=
X-Received: by 2002:a05:6122:7cc:b0:50f:fe39:a508 with SMTP id
 71dfb90a1353d-5101523f155mr7128353e0c.11.1730153499113; Mon, 28 Oct 2024
 15:11:39 -0700 (PDT)
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
 <228c428d-d116-4be1-9d0d-0591667b7ccb@gmail.com> <CAGsJ_4zLNA-1+3j4snNLiujT3NLcmKEVFA4+eD1Sk1bOkqAGYw@mail.gmail.com>
 <03d4c776-4b2e-4f3d-94f0-9b716bfd74d2@gmail.com>
In-Reply-To: <03d4c776-4b2e-4f3d-94f0-9b716bfd74d2@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Oct 2024 06:11:27 +0800
Message-ID: <CAGsJ_4zRZFpJ0rWQ3XzspfSXN6xXN4eftCdL3xHPTqqYLUhQcA@mail.gmail.com>
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

On Tue, Oct 29, 2024 at 5:49=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 28/10/2024 21:40, Barry Song wrote:
> > On Tue, Oct 29, 2024 at 5:24=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 28/10/2024 21:15, Barry Song wrote:
> >>> On Tue, Oct 29, 2024 at 4:51=E2=80=AFAM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 28/10/2024 20:42, Barry Song wrote:
> >>>>> On Tue, Oct 29, 2024 at 4:00=E2=80=AFAM Usama Arif <usamaarif642@gm=
ail.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 28/10/2024 19:54, Barry Song wrote:
> >>>>>>> On Tue, Oct 29, 2024 at 1:20=E2=80=AFAM Usama Arif <usamaarif642@=
gmail.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 28/10/2024 17:08, Yosry Ahmed wrote:
> >>>>>>>>> On Mon, Oct 28, 2024 at 10:00=E2=80=AFAM Usama Arif <usamaarif6=
42@gmail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 28/10/2024 16:33, Nhat Pham wrote:
> >>>>>>>>>>> On Mon, Oct 28, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif=
642@gmail.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> I wonder if instead of having counters, it might be better t=
o keep track
> >>>>>>>>>>>> of the number of zeropages currently stored in zeromap, simi=
lar to how
> >>>>>>>>>>>> zswap_same_filled_pages did it. It will be more complicated =
then this
> >>>>>>>>>>>> patch, but would give more insight of the current state of t=
he system.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Joshua (in CC) was going to have a look at that.
> >>>>>>>>>>>
> >>>>>>>>>>> I don't think one can substitute for the other.
> >>>>>>>>>>
> >>>>>>>>>> Yes agreed, they have separate uses and provide different info=
rmation, but
> >>>>>>>>>> maybe wasteful to have both types of counters? They are counte=
rs so maybe
> >>>>>>>>>> dont consume too much resources but I think we should still th=
ink about
> >>>>>>>>>> it..
> >>>>>>>>>
> >>>>>>>>> Not for or against here, but I would say that statement is deba=
table
> >>>>>>>>> at best for memcg stats :)
> >>>>>>>>>
> >>>>>>>>> Each new counter consumes 2 longs per-memcg per-CPU (see
> >>>>>>>>> memcg_vmstats_percpu), about 16 bytes, which is not a lot but i=
t can
> >>>>>>>>> quickly add up with a large number of CPUs/memcgs/stats.
> >>>>>>>>>
> >>>>>>>>> Also, when flushing the stats we iterate all of them to propaga=
te
> >>>>>>>>> updates from per-CPU counters. This is already a slowpath so ad=
ding
> >>>>>>>>> one stat is not a big deal, but again because we iterate all st=
ats on
> >>>>>>>>> multiple CPUs (and sometimes on each node as well), the overall=
 flush
> >>>>>>>>> latency becomes a concern sometimes.
> >>>>>>>>>
> >>>>>>>>> All of that is not to say we shouldn't add more memcg stats, bu=
t we
> >>>>>>>>> have to be mindful of the resources.
> >>>>>>>>
> >>>>>>>> Yes agreed! Plus the cost of incrementing similar counters (whic=
h ofcourse is
> >>>>>>>> also not much).
> >>>>>>>>
> >>>>>>>> Not trying to block this patch in anyway. Just think its a good =
point
> >>>>>>>> to discuss here if we are ok with both types of counters. If its=
 too wasteful
> >>>>>>>> then which one we should have.
> >>>>>>>
> >>>>>>> Hi Usama,
> >>>>>>> my point is that with all the below three counters:
> >>>>>>> 1. PSWPIN/PSWPOUT
> >>>>>>> 2. ZSWPIN/ZSWPOUT
> >>>>>>> 3. SWAPIN_SKIP/SWAPOUT_SKIP or (ZEROSWPIN, ZEROSWPOUT what ever)
> >>>>>>>
> >>>>>>> Shouldn't we have been able to determine the portion of zeromap
> >>>>>>> swap indirectly?
> >>>>>>>
> >>>>>>
> >>>>>> Hmm, I might be wrong, but I would have thought no?
> >>>>>>
> >>>>>> What if you swapout a zero folio, but then discard it?
> >>>>>> zeromap_swpout would be incremented, but zeromap_swapin would not.
> >>>>>
> >>>>> I understand. It looks like we have two issues to tackle:
> >>>>> 1. We shouldn't let zeromap swap in or out anything that vanishes i=
nto
> >>>>> a black hole
> >>>>> 2. We want to find out how much I/O/memory has been saved due to ze=
romap so far
> >>>>>
> >>>>> From my perspective, issue 1 requires a "fix", while issue 2 is mor=
e
> >>>>> of an optimization.
> >>>>
> >>>> Hmm I dont understand why point 1 would be an issue.
> >>>>
> >>>> If its discarded thats fine as far as I can see.
> >>>
> >>> it is fine to you and probably me who knows zeromap as well :-) but
> >>> any userspace code
> >>> as below might be entirely confused:
> >>>
> >>> p =3D malloc(1G);
> >>> write p to 0; or write part of p to 0
> >>> madv_pageout(p, 1g)
> >>> read p to swapin.
> >>>
> >>> The entire procedure used to involve 1GB of swap out and 1GB of swap =
in by any
> >>> means. Now, it has recorded 0 swaps counted.
> >>>
> >>> I don't expect userspace is as smart as you :-)
> >>>
> >> Ah I completely agree, we need to account for it in some metric. I pro=
bably
> >> misunderstood when you said "We shouldn't let zeromap swap in or out a=
nything that
> >> vanishes into a black hole", by we should not have the zeromap optimiz=
ation for those
> >> cases. What I guess you meant is we need to account for it in some met=
ric.
> >>
> >>>>
> >>>> As a reference, memory.stat.zswapped !=3D memory.stat.zswapout - mem=
ory.stat.zswapin.
> >>>> Because zswapped would take into account swapped out anon memory fre=
ed, MADV_FREE,
> >>>> shmem truncate, etc as Yosry said about zeromap, But zswapout and zs=
wapin dont.
> >>>
> >>> I understand. However, I believe what we really need to focus on is
> >>> this: if we=E2=80=99ve
> >>> swapped out, for instance, 100GB in the past hour, how much of that 1=
00GB is
> >>> zero? This information can help us assess the proportion of zero data=
 in the
> >>> workload, along with the potential benefits that zeromap can provide =
for memory,
> >>> I/O space, or read/write operations. Additionally, having the second =
count
> >>> can enhance accuracy when considering MADV_DONTNEED, FREE, TRUNCATE,
> >>> and so on.
> >>>
> >> Yes completely agree!
> >>
> >> I think we can look into adding all three metrics, zeromap_swapped, ze=
romap_swpout,
> >> zeromap_swpin (or whatever name works).
> >
> > It's great to reach an agreement. Let me work on some patches for it.
>
> Thanks!
>
> >
> > By the way, I recently had an idea: if we can conduct the zeromap check
> > earlier - for example - before allocating swap slots and pageout(), cou=
ld
> > we completely eliminate swap slot occupation and allocation/release
> > for zeromap data? For example, we could use a special swap
> > entry value in the PTE to indicate zero content and directly fill it wi=
th
> > zeros when swapping back. We've observed that swap slot allocation and
> > freeing can consume a lot of CPU and slow down functions like
> > zap_pte_range and swap-in. If we can entirely skip these steps, it
> > could improve performance. However, I'm uncertain about the benefits we
> > would gain if we only have 1-2% zeromap data.
>
> If I remember correctly this was one of the ideas floated around in the
> initial version of the zeromap series, but it was evaluated as a lot more
> complicated to do than what the current zeromap code looks like. But I
> think its definitely worth looking into!

Sorry for the noise. I didn't review the initial discussion. But my feeling
is that it might be valuable considering the report from Zhiguo:

https://lore.kernel.org/linux-mm/20240805153639.1057-1-justinjiang@vivo.com=
/

In fact, our recent benchmark also indicates that swap free could account
for a significant portion in do_swap_page().

>
> >
> > I'm just putting this idea out there to see if you're interested in mov=
ing
> > forward with it. :-)
> >
> >>
> >>>>
> >>>>
> >>>>>
> >>>>> I consider issue 1 to be more critical because, after observing a p=
hone
> >>>>> running for some time, I've been able to roughly estimate the porti=
on
> >>>>> zeromap can
> >>>>> help save using only PSWPOUT, ZSWPOUT, and SWAPOUT_SKIP, even witho=
ut a
> >>>>> SWPIN counter. However, I agree that issue 2 still holds significan=
t value
> >>>>> as a separate patch.
> >>>>>
> >>>
> >

Thanks
Barry

