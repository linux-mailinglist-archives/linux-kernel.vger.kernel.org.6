Return-Path: <linux-kernel+bounces-316071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2896CAC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F92C1C24A5A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE00172760;
	Wed,  4 Sep 2024 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZlHvmLz"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D947F4D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492454; cv=none; b=mhIeEr43MNkFugh2nHmjXVwm4HsvBfVtAXw20c2DVq113M4Cyo6Mj04KfTPKdKXxYtDrrvQqNf8W9CRVnz8t/6Q0iXpoNHW4mlN3eUvy7DvDORv6ntPJ9HB0cEg4QemWCl87OoKgz5q9EQHlHtehN27gx5kSzT6beKUEe4dHNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492454; c=relaxed/simple;
	bh=pU5+OR1iuHylxae+DySFuT22cOF4zrA1zLtIHRMJAHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B46XZTodGRtz8pp63nmh+04uaEURzLD92kEaDLMkiWhRWFpgDICDcqhecQ8DJP4LZCftXvuI72UfbrhDXI4JuDQzK9yiQk10epiu0z94tMn0cMAqIZTiD76Iy1lS+J5yA1XKWOD7C8dLS9zKAy67EJdRO/0hGLqrCZIEBYEcv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZlHvmLz; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-498eb76145bso47077137.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725492452; x=1726097252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CVB6NjO4vGSa7X2qTrnLEWBdQAEUawVJKFhtty1RSs=;
        b=nZlHvmLzzrZKgcHXtH3h+OyiR9rQVpjC3P5i02eT9cNH5Fpi+kxXaGCiP5d3via6+5
         TmD8ZsAqJO6hxZl/voCT5vrpzEuQ3O3/4eSpd+gYmx7nPDQL7Akk0yHyKpFJ1O1lW5LO
         M1u6J1kdHDn6tg9aWhDeHjbLHf50L3eiJuCCFjOKprmfz/2fAerBEDJYsTUEbK6LgcgM
         wtQV+ldExUPeFfMQwViB+lW0/ccHY9hYNTqnJDz5cTZmmoLuYYzQJnmAba8DGe/a8KAq
         64LdQsm0PzpA6og+4Ws7XtaKAdxCbG/sjSGXIZeYrIxX0cig6VDDAihk/znZwPhzgd8E
         WbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725492452; x=1726097252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CVB6NjO4vGSa7X2qTrnLEWBdQAEUawVJKFhtty1RSs=;
        b=MLVO29qXe5tlBAZaIaILH6oxoXhEUDbAY20pmfpsF7IIE8sKuIJB0QDgdZd4k5TOzS
         gt4SNhIARhOCbUgMBtJbzusYPwcfBm/lBFQhSpmLylfuK1DO/jvArwMrYTODEqScXQbE
         92rBmdinT4u/dLdpmxdrRWd2nkkeqZFMdwJlG375YLWjCwVRaKHInRcGsd/Nnf7QUv8E
         SR82CFrIHql6i4enOzjFSSsi+bv4tzcz8K6XppKQrCaTN3T2c+sGNWt/KVZu18d1Pjsv
         yffIqaUg3URuCDYnr+MvgR+BZOewOYn9NnDJKzqRLy7dPfgLdRLLy0U3nwTzVRScuN9I
         iZNg==
X-Forwarded-Encrypted: i=1; AJvYcCX59T435doF26H0IgqzeQNQiksAfFhpG3cqXDy+t7tih6y2mkkY2F0PYouy1o+on6NGDoOv1ev32xi/PeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEiSA2Y6BqYsT/O2QEUGgtWMUUVD/vhX4fuR+Sjl3nCbWa0amd
	zn0lQBrO8vE8aLO+AAVNiBSOFYDBUsuTYNTmiG1jIJsC9B0LG4bz36xom543I61vPIXd0RsBDi1
	Ui/PJdXsO3kyQV7NWAsZyNfWtPPI=
X-Google-Smtp-Source: AGHT+IEryQ59FsHoDv/++0Kig5/0baRUl4VeAn4/vqIFOVlRWbLFSAES/B0wP2dYzORn+8//6Tv4n1sZNEEirGeRaI0=
X-Received: by 2002:a05:6102:3054:b0:48f:4a50:233e with SMTP id
 ada2fe7eead31-49a79bc8888mr14914282137.21.1725492452099; Wed, 04 Sep 2024
 16:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821074541.516249-1-hanchuanhua@oppo.com> <20240821074541.516249-3-hanchuanhua@oppo.com>
 <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
 <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
 <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
 <CAGsJ_4wjgPS1Pj_RbLcpXH3dx2StCdSiUo5AL7vQFPZGyzESAQ@mail.gmail.com>
 <CAJD7tkaXvm95mRH04OX0KJtiBuTaaDyyJQirbAjUV0B+DjaWJA@mail.gmail.com>
 <94eb70cd-b508-42ef-b5d2-acc29e22eb0e@gmail.com> <CAGsJ_4yX7xmyDokYgc_H7MaxcOptcLeQs-SB1O22bSRHFdvVhQ@mail.gmail.com>
 <bf232555-3653-40c7-bbdc-a8fe58a93a9e@gmail.com>
In-Reply-To: <bf232555-3653-40c7-bbdc-a8fe58a93a9e@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Sep 2024 11:27:18 +1200
Message-ID: <CAGsJ_4x6HuUhkDxyVQArsKXa89bnut8pkNcOYNejo2LNEgFWYQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <ryncsn@gmail.com>, hanchuanhua@oppo.com, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org, 
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org, 
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:23=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 05/09/2024 00:10, Barry Song wrote:
> > On Thu, Sep 5, 2024 at 9:30=E2=80=AFAM Usama Arif <usamaarif642@gmail.c=
om> wrote:
> >>
> >>
> >>
> >> On 03/09/2024 23:05, Yosry Ahmed wrote:
> >>> On Tue, Sep 3, 2024 at 2:36=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> >>>>
> >>>> On Wed, Sep 4, 2024 at 8:08=E2=80=AFAM Andrew Morton <akpm@linux-fou=
ndation.org> wrote:
> >>>>>
> >>>>> On Tue, 3 Sep 2024 11:38:37 -0700 Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >>>>>
> >>>>>>> [   39.157954] RBP: 0000000000000000 R08: 0000000000000000 R09: 0=
000000000000007
> >>>>>>> [   39.158288] R10: 0000000000000000 R11: 0000000000000246 R12: 0=
000000000000001
> >>>>>>> [   39.158634] R13: 0000000000002b9a R14: 0000000000000000 R15: 0=
0007ffd619d5518
> >>>>>>> [   39.158998]  </TASK>
> >>>>>>> [   39.159226] ---[ end trace 0000000000000000 ]---
> >>>>>>>
> >>>>>>> After reverting this or Usama's "mm: store zero pages to be swapp=
ed
> >>>>>>> out in a bitmap", the problem is gone. I think these two patches =
may
> >>>>>>> have some conflict that needs to be resolved.
> >>>>>>
> >>>>>> Yup. I saw this conflict coming and specifically asked for this
> >>>>>> warning to be added in Usama's patch to catch it [1]. It served it=
s
> >>>>>> purpose.
> >>>>>>
> >>>>>> Usama's patch does not handle large folio swapin, because at the t=
ime
> >>>>>> it was written we didn't have it. We expected Usama's series to la=
nd
> >>>>>> sooner than this one, so the warning was to make sure that this se=
ries
> >>>>>> handles large folio swapin in the zeromap code. Now that they are =
both
> >>>>>> in mm-unstable, we are gonna have to figure this out.
> >>>>>>
> >>>>>> I suspect Usama's patches are closer to land so it's better to han=
dle
> >>>>>> this in this series, but I will leave it up to Usama and
> >>>>>> Chuanhua/Barry to figure this out :)
> >>>>
> >>>> I believe handling this in swap-in might violate layer separation.
> >>>> `swap_read_folio()` should be a reliable API to call, regardless of
> >>>> whether `zeromap` is present. Therefore, the fix should likely be
> >>>> within `zeromap` but not this `swap-in`. I=E2=80=99ll take a look at=
 this with
> >>>> Usama :-)
> >>>
> >>> I meant handling it within this series to avoid blocking Usama
> >>> patches, not within this code. Thanks for taking a look, I am sure yo=
u
> >>> and Usama will figure out the best way forward :)
> >>
> >> Hi Barry and Yosry,
> >>
> >> Is the best (and quickest) way forward to have a v8 of this with
> >> https://lore.kernel.org/all/20240904055522.2376-1-21cnbao@gmail.com/
> >> as the first patch, and using swap_zeromap_entries_count in alloc_swap=
_folio
> >> in this support large folios swap-in patch?
> >
> > Yes, Usama. i can actually do a check:
> >
> > zeromap_cnt =3D swap_zeromap_entries_count(entry, nr);
> >
> > /* swap_read_folio() can handle inconsistent zeromap in multiple entrie=
s */
> > if (zeromap_cnt > 0 && zeromap_cnt < nr)
> >        try next order;
> >
> > On the other hand, if you read the code of zRAM, you will find zRAM has
> > exactly the same mechanism as zeromap but zRAM can even do more
> > by same_pages filled. since zRAM does the job in swapfile layer, there
> > is no this kind of consistency issue like zeromap.
> >
> > So I feel for zRAM case, we don't need zeromap at all as there are dupl=
icated
> > efforts while I really appreciate your job which can benefit all swapfi=
les.
> > i mean, zRAM has the ability to check "zero"(and also non-zero but same
> > content). after zeromap checks zeromap, zRAM will check again:
> >
>
> Yes, so there is a reason for having the zeromap patches, which I have ou=
tlined
> in the coverletter.
>
> https://lore.kernel.org/all/20240627105730.3110705-1-usamaarif642@gmail.c=
om/
>
> There are usecases where zswap/zram might not be used in production.
> We can reduce I/O and flash wear in those cases by a large amount.
>
> Also running in Meta production, we found that the number of non-zero fil=
led
> complete pages were less than 1%, so essentially its only the zero-filled=
 pages
> that matter.

I don't have data on Android phones, i'd like to see if phones have exactly
the same ratio that non-zero same page is rare.

>
> I believe after zeromap, it might be a good idea to remove the page_same_=
filled
> check from zram code? Its not really a problem if its kept as well as I d=
ont
> believe any zero-filled pages should reach zram_write_page?
>
> > static int zram_write_page(struct zram *zram, struct page *page, u32 in=
dex)
> > {
> >        ...
> >
> >         if (page_same_filled(mem, &element)) {
> >                 kunmap_local(mem);
> >                 /* Free memory associated with this sector now. */
> >                 flags =3D ZRAM_SAME;
> >                 atomic64_inc(&zram->stats.same_pages);
> >                 goto out;
> >         }
> >         ...
> > }
> >
> > So it seems that zeromap might slightly impact my zRAM use case. I'm no=
t
> > blaming you, just pointing out that there might be some overlap in effo=
rt
> > here :-)
> >
> >>
> >> Thanks,
> >> Usama
> >

Thanks
Barry

