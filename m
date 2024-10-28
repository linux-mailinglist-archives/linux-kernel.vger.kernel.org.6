Return-Path: <linux-kernel+bounces-385852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F2E9B3C93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698811F22D52
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63DA19048F;
	Mon, 28 Oct 2024 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7sfmi3n"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275D1CC17A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150151; cv=none; b=MzFOahNvqj7JulP/e/sMXcBzlpQa3YoTRVl2960Oq85Wz6ByHRwgvJwE/GTNV1IaMcQSZtuf262/82Pfy1wa8lhqyyf4t63ky8xeoGYxoaHWBrXzX+2RIBmOR1DLR5PRAcqkLyrtiycoDDrUmq2CKLXF5YKw1/v6+5dpZFrHdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150151; c=relaxed/simple;
	bh=kq2tEiK0l3TgU9HmbeUL45Km2z3ZsaUVG9pn1JTmUs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfScJwu8Jc+jgvAExrXamNSutA3H1469IL2NpF3e3x5nsPV5U1dFMXD+KHjyarEwFHCtpOg0cnyIkQdwFDynkn8DnVhnCnfv4U7a0Xi7pH4HB8UrI+wtb0Ji2YkzbCNuWxuz8mpvtc9FO8fKrhdNRbZrm1VxZ0/AZTkQWGqKaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7sfmi3n; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4a492f73befso1427876137.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730150148; x=1730754948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq2tEiK0l3TgU9HmbeUL45Km2z3ZsaUVG9pn1JTmUs0=;
        b=T7sfmi3nhcf/VXEsyPM4y2ZQIb8n4AkkvgF70hIvlDSnGojAoSHNMMEAaYSkc5NEu9
         9vIkCa/CFBGkpGp782Z/xA1iK1hcVVphYnB9ggmvdHNc/5/0b345yAxY1MMPPNj9sJTV
         2QBxNP/cDionu9r1Q5ZVi+CGOL4urM9215Qe8DGln5pJnwIHr7p7YM9DsHV6y10TsluI
         d1cTpSRLctEOj4qQoQT7tLHIdKzQAIJFj5uVSXgpLCFz/HcGmj4Q8qTsB9fQjNl6ST1m
         Rn88QlvnSsYr+28D/kptZSbBZgesc+QAuecMcrh32jgGm2eDGpAmLwmGOslqaWvXFhA1
         qpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730150148; x=1730754948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq2tEiK0l3TgU9HmbeUL45Km2z3ZsaUVG9pn1JTmUs0=;
        b=qIEycJN1ebmHsBhRUvynslHRmatzgG74CVbnqa65BI9qcYJZIahgcFKdtxl3PzOQJ0
         Ijgz9kymiNHdS559WxkH2vGuBM+/EJGpY+L8FFhe/W+ZEPXmrIuQrGsMlhdsvvuk3QCz
         pNrD/BYcXzn1J8hkWTK5IO2ficc5nWkr3aPMP2HS/ozZ4PFOSYjrjZbAytIjZ+WBXhWI
         kOyPFo4U/6Wk9fbjyBaHmtkPiDPgWG7QQ7HojqTm28D4ORcS4BYn3TAx2DJfzbxUq2h/
         UtLkWUIB27nOSE7+XuJiJKPlz5Dob1TCs0NTMtHdMzJZaeZ62ibvRNz34wR5FSoGUSkj
         yjRg==
X-Forwarded-Encrypted: i=1; AJvYcCX5fCvlJx2zPApQxP/Wdl6QupRCZIFE9/n2GQNUinGFr/RL+1tUH4u80rD+UtFVg7Eq+q3RBx8h18eSL/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAejFzdlikBTNMi5HbTTRYMMTiA7kdWpfB6DURx7/uj9QVyEQm
	05S4VDJiPMUoJboPKY3cZqcA+ZZPU5COPqW9WG4ekQUwmSRWcYs1zG7ovq/iQCe6X7dXkJ0Y7dm
	qV6pEoDQKicbJBih3RwSpL4w5AKQ=
X-Google-Smtp-Source: AGHT+IEG/Uuyrczwyf5WLTJPgbRl1hvGIiRh8dG5l0lRnNLaf+CGNsr8PiCwy92WDAG1Pn6+14XQjINk/mZXbIyEmUo=
X-Received: by 2002:a05:6102:5109:b0:4a7:4900:4b39 with SMTP id
 ada2fe7eead31-4a8cfb4451dmr7818180137.4.1730150147697; Mon, 28 Oct 2024
 14:15:47 -0700 (PDT)
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
 <cba36cb0-66c7-45c1-97c3-a96ea48a6cf0@gmail.com>
In-Reply-To: <cba36cb0-66c7-45c1-97c3-a96ea48a6cf0@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Oct 2024 05:15:36 +0800
Message-ID: <CAGsJ_4wXO2Hjs0HZBGsGegBAeE8YxJbCF6ZXQQ6ZnVxgR82AuQ@mail.gmail.com>
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

On Tue, Oct 29, 2024 at 4:51=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 28/10/2024 20:42, Barry Song wrote:
> > On Tue, Oct 29, 2024 at 4:00=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 28/10/2024 19:54, Barry Song wrote:
> >>> On Tue, Oct 29, 2024 at 1:20=E2=80=AFAM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 28/10/2024 17:08, Yosry Ahmed wrote:
> >>>>> On Mon, Oct 28, 2024 at 10:00=E2=80=AFAM Usama Arif <usamaarif642@g=
mail.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 28/10/2024 16:33, Nhat Pham wrote:
> >>>>>>> On Mon, Oct 28, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif642@=
gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> I wonder if instead of having counters, it might be better to ke=
ep track
> >>>>>>>> of the number of zeropages currently stored in zeromap, similar =
to how
> >>>>>>>> zswap_same_filled_pages did it. It will be more complicated then=
 this
> >>>>>>>> patch, but would give more insight of the current state of the s=
ystem.
> >>>>>>>>
> >>>>>>>> Joshua (in CC) was going to have a look at that.
> >>>>>>>
> >>>>>>> I don't think one can substitute for the other.
> >>>>>>
> >>>>>> Yes agreed, they have separate uses and provide different informat=
ion, but
> >>>>>> maybe wasteful to have both types of counters? They are counters s=
o maybe
> >>>>>> dont consume too much resources but I think we should still think =
about
> >>>>>> it..
> >>>>>
> >>>>> Not for or against here, but I would say that statement is debatabl=
e
> >>>>> at best for memcg stats :)
> >>>>>
> >>>>> Each new counter consumes 2 longs per-memcg per-CPU (see
> >>>>> memcg_vmstats_percpu), about 16 bytes, which is not a lot but it ca=
n
> >>>>> quickly add up with a large number of CPUs/memcgs/stats.
> >>>>>
> >>>>> Also, when flushing the stats we iterate all of them to propagate
> >>>>> updates from per-CPU counters. This is already a slowpath so adding
> >>>>> one stat is not a big deal, but again because we iterate all stats =
on
> >>>>> multiple CPUs (and sometimes on each node as well), the overall flu=
sh
> >>>>> latency becomes a concern sometimes.
> >>>>>
> >>>>> All of that is not to say we shouldn't add more memcg stats, but we
> >>>>> have to be mindful of the resources.
> >>>>
> >>>> Yes agreed! Plus the cost of incrementing similar counters (which of=
course is
> >>>> also not much).
> >>>>
> >>>> Not trying to block this patch in anyway. Just think its a good poin=
t
> >>>> to discuss here if we are ok with both types of counters. If its too=
 wasteful
> >>>> then which one we should have.
> >>>
> >>> Hi Usama,
> >>> my point is that with all the below three counters:
> >>> 1. PSWPIN/PSWPOUT
> >>> 2. ZSWPIN/ZSWPOUT
> >>> 3. SWAPIN_SKIP/SWAPOUT_SKIP or (ZEROSWPIN, ZEROSWPOUT what ever)
> >>>
> >>> Shouldn't we have been able to determine the portion of zeromap
> >>> swap indirectly?
> >>>
> >>
> >> Hmm, I might be wrong, but I would have thought no?
> >>
> >> What if you swapout a zero folio, but then discard it?
> >> zeromap_swpout would be incremented, but zeromap_swapin would not.
> >
> > I understand. It looks like we have two issues to tackle:
> > 1. We shouldn't let zeromap swap in or out anything that vanishes into
> > a black hole
> > 2. We want to find out how much I/O/memory has been saved due to zeroma=
p so far
> >
> > From my perspective, issue 1 requires a "fix", while issue 2 is more
> > of an optimization.
>
> Hmm I dont understand why point 1 would be an issue.
>
> If its discarded thats fine as far as I can see.

it is fine to you and probably me who knows zeromap as well :-) but
any userspace code
as below might be entirely confused:

p =3D malloc(1G);
write p to 0; or write part of p to 0
madv_pageout(p, 1g)
read p to swapin.

The entire procedure used to involve 1GB of swap out and 1GB of swap in by =
any
means. Now, it has recorded 0 swaps counted.

I don't expect userspace is as smart as you :-)

>
> As a reference, memory.stat.zswapped !=3D memory.stat.zswapout - memory.s=
tat.zswapin.
> Because zswapped would take into account swapped out anon memory freed, M=
ADV_FREE,
> shmem truncate, etc as Yosry said about zeromap, But zswapout and zswapin=
 dont.

I understand. However, I believe what we really need to focus on is
this: if we=E2=80=99ve
swapped out, for instance, 100GB in the past hour, how much of that 100GB i=
s
zero? This information can help us assess the proportion of zero data in th=
e
workload, along with the potential benefits that zeromap can provide for me=
mory,
I/O space, or read/write operations. Additionally, having the second count
can enhance accuracy when considering MADV_DONTNEED, FREE, TRUNCATE,
and so on.

>
>
> >
> > I consider issue 1 to be more critical because, after observing a phone
> > running for some time, I've been able to roughly estimate the portion
> > zeromap can
> > help save using only PSWPOUT, ZSWPOUT, and SWAPOUT_SKIP, even without a
> > SWPIN counter. However, I agree that issue 2 still holds significant va=
lue
> > as a separate patch.
> >

Thanks
 Barry

