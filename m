Return-Path: <linux-kernel+bounces-385814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADA59B3C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5EC1C2193D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09461E0DB6;
	Mon, 28 Oct 2024 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKRoXaPh"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4601E0080
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148142; cv=none; b=jp4IfceLdtoEf+SzWSDQgUhKSsHlzuRcKV+uz9fYQiC9kbtMgqvzPkfUvmzOtEIJ/uvj9sHWinF1mZfxA+3z9XwoL2lRb8xBFs1MSktQZC9S6E/LRqTzWC3vlakQJNfHQIvNcNeKa9WdA6PPYcDaf0VyBJOdxpA2bC4SeVwmRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148142; c=relaxed/simple;
	bh=Su9Uon3IP8qi9BwGx8r1C6Fj3ZBnyqWd0zZelwtXyM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqZi+tpxokSRLxwKMQOmXcndmAaKDiMx+qPkrpMZEFzhBGR2FCG1n4mpbIRAHXbMG2mltxw1DFOHllltAv7fk80h/rzRb1x44VaCxjuNMUla7M8zRSR40ECnraOv49a1uSWBzllI7bkG9I1577LtMiidNRqXENzylKNH0aXmtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKRoXaPh; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50d2d300718so1292329e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730148139; x=1730752939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Su9Uon3IP8qi9BwGx8r1C6Fj3ZBnyqWd0zZelwtXyM4=;
        b=nKRoXaPhXAZ0yWNpEtZiZNeZUFp8YbaxaOOLpukskXKxEIPsJxxAIkDiEW5Bxb/QTB
         zNUhdVV9f/XxxA7QjLFmPMM4aEmD866G/ChCWi7pgxjWmHRc2kLXB3GDwDm/dDncxYZ+
         k+Ao1roMJqZ7R7G+VQaT4KD/z31pVIZC+PyJ4RnXp0+T93mvdlHSBXxNopiaiudmEwiX
         1/WBxfN2kcKv2sZgEsoFUosmMC8y59C/PMC7AL+8j+HhZexoohKEeGzoOv7MHXdbOPIP
         sV+dAaggJTd53L7tSlMUbADdrLkVwM3YhugwJOiEeRD1GlaFRkUhIOr/NTnq7uKkxgdF
         0qgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148139; x=1730752939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su9Uon3IP8qi9BwGx8r1C6Fj3ZBnyqWd0zZelwtXyM4=;
        b=J+n6jrcnZS6OPp775D6tROvmvki87xAwr+p2cVObLu1RoX7/dU2rzCXglgsWuhKIsS
         FGFky0i9XAal/oN4nWba35x8S71MVObZoUpmV3UO8umfpaCfDHg1eP86cJRfifG2/e1l
         m5i6ZzZMf8QPtAkm7YrOcYmrr2n6aH5HaX61ZLBzKSQhKFUypZRpXlofr0g67TxmQNxX
         8HfFM0VRTG4Dw0b6/8NIfeF+8dYeuY9Bkq6aDuwFkypI7vaMpAeHdd/RqnDQqkCCnEu0
         RXXG0Nu7R8DeL4bExLeW3eo4kYne51HxdCfGksoOCtnD/cbbC7/zSjEppN1N+Oyi5ZQi
         vyUg==
X-Forwarded-Encrypted: i=1; AJvYcCXu8tg5aXl73btFF4eIE1X+BBnx9lNK5EFOd4fgcy/oUnFTqP+aTC+DBKfR3n9Ilivh2FfEcGybl0bzgC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMy0RzbKgqSdry9I+t9KT7lzcRDBk7nT7raqg6RHBQjW5VihKV
	Wmb3caZXR0nhbB8ShrzfGuE+z9BD5QQ0fyTvRyWYo3ReKwJQXWVc7A2I8lCqmTKFso074nuPKc7
	A0wmTL7kuOZxNi8xiNHYW/YCb7P8=
X-Google-Smtp-Source: AGHT+IGoNYRYCIo/u+HvnxWyA6vBF1v1euCWLj1/N7iweLOSVdq7Zprlq73XizDS0JU1v1r8KEWGkYpmTyRxWG4a2TE=
X-Received: by 2002:a05:6122:3d0e:b0:507:81f0:f952 with SMTP id
 71dfb90a1353d-510150e50d5mr6269655e0c.9.1730148138619; Mon, 28 Oct 2024
 13:42:18 -0700 (PDT)
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
 <882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com>
In-Reply-To: <882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Oct 2024 04:42:07 +0800
Message-ID: <CAGsJ_4yBkry-rw75AciT8OiYWrw+=D0okcxiyXzzNrz=QJxiBA@mail.gmail.com>
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

On Tue, Oct 29, 2024 at 4:00=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 28/10/2024 19:54, Barry Song wrote:
> > On Tue, Oct 29, 2024 at 1:20=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 28/10/2024 17:08, Yosry Ahmed wrote:
> >>> On Mon, Oct 28, 2024 at 10:00=E2=80=AFAM Usama Arif <usamaarif642@gma=
il.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 28/10/2024 16:33, Nhat Pham wrote:
> >>>>> On Mon, Oct 28, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif642@gm=
ail.com> wrote:
> >>>>>>
> >>>>>> I wonder if instead of having counters, it might be better to keep=
 track
> >>>>>> of the number of zeropages currently stored in zeromap, similar to=
 how
> >>>>>> zswap_same_filled_pages did it. It will be more complicated then t=
his
> >>>>>> patch, but would give more insight of the current state of the sys=
tem.
> >>>>>>
> >>>>>> Joshua (in CC) was going to have a look at that.
> >>>>>
> >>>>> I don't think one can substitute for the other.
> >>>>
> >>>> Yes agreed, they have separate uses and provide different informatio=
n, but
> >>>> maybe wasteful to have both types of counters? They are counters so =
maybe
> >>>> dont consume too much resources but I think we should still think ab=
out
> >>>> it..
> >>>
> >>> Not for or against here, but I would say that statement is debatable
> >>> at best for memcg stats :)
> >>>
> >>> Each new counter consumes 2 longs per-memcg per-CPU (see
> >>> memcg_vmstats_percpu), about 16 bytes, which is not a lot but it can
> >>> quickly add up with a large number of CPUs/memcgs/stats.
> >>>
> >>> Also, when flushing the stats we iterate all of them to propagate
> >>> updates from per-CPU counters. This is already a slowpath so adding
> >>> one stat is not a big deal, but again because we iterate all stats on
> >>> multiple CPUs (and sometimes on each node as well), the overall flush
> >>> latency becomes a concern sometimes.
> >>>
> >>> All of that is not to say we shouldn't add more memcg stats, but we
> >>> have to be mindful of the resources.
> >>
> >> Yes agreed! Plus the cost of incrementing similar counters (which ofco=
urse is
> >> also not much).
> >>
> >> Not trying to block this patch in anyway. Just think its a good point
> >> to discuss here if we are ok with both types of counters. If its too w=
asteful
> >> then which one we should have.
> >
> > Hi Usama,
> > my point is that with all the below three counters:
> > 1. PSWPIN/PSWPOUT
> > 2. ZSWPIN/ZSWPOUT
> > 3. SWAPIN_SKIP/SWAPOUT_SKIP or (ZEROSWPIN, ZEROSWPOUT what ever)
> >
> > Shouldn't we have been able to determine the portion of zeromap
> > swap indirectly?
> >
>
> Hmm, I might be wrong, but I would have thought no?
>
> What if you swapout a zero folio, but then discard it?
> zeromap_swpout would be incremented, but zeromap_swapin would not.

I understand. It looks like we have two issues to tackle:
1. We shouldn't let zeromap swap in or out anything that vanishes into
a black hole
2. We want to find out how much I/O/memory has been saved due to zeromap so=
 far

From my perspective, issue 1 requires a "fix", while issue 2 is more
of an optimization.

I consider issue 1 to be more critical because, after observing a phone
running for some time, I've been able to roughly estimate the portion
zeromap can
help save using only PSWPOUT, ZSWPOUT, and SWAPOUT_SKIP, even without a
SWPIN counter. However, I agree that issue 2 still holds significant value
as a separate patch.

Thanks
Barry

