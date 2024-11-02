Return-Path: <linux-kernel+bounces-393405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D33E9BA023
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62FB1F21979
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C518A947;
	Sat,  2 Nov 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSzy9XXY"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E318A6DE
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730552400; cv=none; b=UMRpAkvl5Hoj6LQlDuK9xOnjV0Z7icuI2uNC/YwzCXBN/drglzTWCXnVBk+6zSZ76e2fa58FAKcQgbsoEhWU3UOTwr87ZxNTrfe/h0jmSne0whlR4EDUnlshK3hhlVgtpe/5sbcx0bs/+wfdhpiT9FEqH7L0K69B7GKv4bmed8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730552400; c=relaxed/simple;
	bh=QPCeBxQs18nl+bQ+3tpTaNIt4O4c459EfvCocRLHwWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGHnWAcSAVBJnKcF/5hdHZodxJXwfqK/7BVsXnETBKBRmpgnCOj3rjtXCCJvg/15J027i3FNToGvnpeMHewCoPIFlsfbqk699wSWGRtTWYmR7emoV+1/5aRpeKbaCA5XVOlqBWQCcciwfJmsGuAIPVTKcoz4jIZJIMQey7mCLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSzy9XXY; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84fd50f2117so798204241.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730552397; x=1731157197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9eY34h26T5YqsifdWK+fuQaARCStH94lZ0P8RHpef8=;
        b=nSzy9XXYX1ly9wt/9To+Vcyu2ZyfwIgn3/HxKOloSDhvtxXWh/UvwzWFC0EzZetQ7D
         YHb1uv7aQZNWm6y5IUgn+X8lfllkDjF0aMWzN6Sd2WmrHlwqv47+Ye5XhWuA+rcEd0iz
         6WUCrhmn2jISQPZaiLpnoi+gk5JDC3hs5wYG2fbU616jM3+TFepi4uc+ra3SLTRmODd4
         JH2oS1XWvIJi6d2vzT+wZC68O15CitMHyAlGewXOq7JKnRXlnVQbnYVbKqXWRYVDu/iB
         OZyumOpqbOluH4cymf5j8Tiq7Qki7EotNpcmBITmBtMrAgSmZHaD6O4GEYxkeJUrJ+jK
         JqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730552397; x=1731157197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9eY34h26T5YqsifdWK+fuQaARCStH94lZ0P8RHpef8=;
        b=qAOm2wLb8Vhwf0ApbbZVAAP0vbFL7sxijEYcm7OZ9Ng5mGujfbpfQWaMcXJW3GNG3t
         1jxf2447io/kGOv4PwCOA2LxjJeLy8eXIVCelX0Ez31AETjZkxInQRayAXdxZWYAGfAq
         G9WXdCbsTK74k90zGfi1rj60dX9NflT2PmFhulB46VduVlGhUrHiVPmnJ2OiVOIEwJaQ
         mSMciS1vf0uNeI5Oct1JUW3iZomdpnsXqpihNRRYvKVRkLYhZP1+1db/YOTfxCqxw0vz
         H0Rj9728n+rO1AvvxynoaqM3bycV+BgBDpB7unExzdfBHO/RMydnCSlf9sQcJjJ7cFZH
         xSLg==
X-Forwarded-Encrypted: i=1; AJvYcCW68xYN3LhbUtWRogMZIY+H4JZ08pqIus1d4yfaR0cgh6h8O9Fg+iRnzGqy9yG/5eKjzHTVf1vjU7iaTI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwc+5xSJKIsFcSVhwhbrv+cHZGhp9QV2ME8nXqUVwwQLRS8zv
	mtJUaLvEOI0DMRtKlwP2GOEkc1S/1McZf+/EMKS8b1eJQgUzU3orpdBbceQTHrm/o7P+Tlhyw6D
	VqB2xLf4HGwRfJO4P7rh8QW/74AY=
X-Google-Smtp-Source: AGHT+IFd1mg+M9K1+toPlgwgdi4V28Fps9AKszqZUKFKsd6bMDxy3FFIoFwzWjoZIHM8wvWSUZnH9kGxjEd4Mh3lIYg=
X-Received: by 2002:a05:6102:1610:b0:4a4:93d0:df13 with SMTP id
 ada2fe7eead31-4a8cfb8572amr26375078137.16.1730552397476; Sat, 02 Nov 2024
 05:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102101240.35072-1-21cnbao@gmail.com> <6c14ab2c-7917-489b-b51e-401d208067f3@gmail.com>
In-Reply-To: <6c14ab2c-7917-489b-b51e-401d208067f3@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 2 Nov 2024 20:59:46 +0800
Message-ID: <CAGsJ_4wpdf6Fky7jj8O6OuLc0WTBjKXTfEqxE0cXiUjxxuLgZA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 8:32=E2=80=AFPM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
>
>
> On 02/11/2024 10:12, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > When the proportion of folios from the zero map is small, missing their
> > accounting may not significantly impact profiling. However, it=E2=80=99=
s easy
> > to construct a scenario where this becomes an issue=E2=80=94for example=
,
> > allocating 1 GB of memory, writing zeros from userspace, followed by
> > MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
> > and swap-in counts seem to vanish into a black hole, potentially
> > causing semantic ambiguity.
> >
> > We have two ways to address this:
> >
> > 1. Add a separate counter specifically for the zero map.
> > 2. Continue using the current accounting, treating the zero map like
> > a normal backend. (This aligns with the current behavior of zRAM
> > when supporting same-page fills at the device level.)
> >
> > This patch adopts option 1 as pswpin/pswpout counters are that they
> > only apply to IO done directly to the backend device (as noted by
> > Nhat Pham).
> >
> > We can find these counters from /proc/vmstat (counters for the whole
> > system) and memcg's memory.stat (counters for the interested memcg).
> >
> > For example:
> >
> > $ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
> > swpin_zero 1648
> > swpout_zero 33536
> >
> > $ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.s=
tat
> > swpin_zero 3905
> > swpout_zero 3985
> >
> > Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitma=
p")
> I don't think its a hotfix (or even a fix). It was discussed in the initi=
al
> series to add these as a follow up and Joshua was going to do this soon.
> Its not fixing any bug in the initial series.

I would prefer that all kernel versions with zeromap include this
counter; otherwise,
it could be confusing to determine where swap-in and swap-out have occurred=
,
as shown by the small program below:

p =3Dmalloc(1g);
write p to zero
madvise_pageout
read p;

Previously, there was 1GB of swap-in and swap-out activity reported, but
now nothing is shown.

I don't mean to suggest that there's a bug in the zeromap code; rather,
having this counter would help clear up any confusion.

I didn't realize Joshua was handling it. Is he still planning to? If
so, I can leave it
with Joshua if that was the plan :-)

>
> > Cc: Usama Arif <usamaarif642@gmail.com>
> > Cc: Chengming Zhou <chengming.zhou@linux.dev>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: Nhat Pham <nphamcs@gmail.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  -v2:
> >  * add separate counters rather than using pswpin/out; thanks
> >  for the comments from Usama, David, Yosry and Nhat;
> >  * Usama also suggested a new counter like swapped_zero, I
> >  prefer that one be separated as an enhancement patch not
> >  a hotfix. will probably handle it later on.
> >
> I dont think either of them would be a hotfix.

As mentioned above, this isn't about fixing a bug; it's simply to ensure
that swap-related metrics don't disappear.

>
> >  Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++++
> >  include/linux/vm_event_item.h           |  2 ++
> >  mm/memcontrol.c                         |  4 ++++
> >  mm/page_io.c                            | 16 ++++++++++++++++
> >  mm/vmstat.c                             |  2 ++
> >  5 files changed, 34 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index db3799f1483e..984eb3c9d05b 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1599,6 +1599,16 @@ The following nested keys are defined.
> >         pglazyfreed (npn)
> >               Amount of reclaimed lazyfree pages
> >
> > +       swpin_zero
> > +             Number of pages moved into memory with zero content, mean=
ing no
> > +             copy exists in the backend swapfile, allowing swap-in to =
avoid
> > +             I/O read overhead.
> > +
> > +       swpout_zero
> > +             Number of pages moved out of memory with zero content, me=
aning no
> > +             copy is needed in the backend swapfile, allowing swap-out=
 to avoid
> > +             I/O write overhead.
> > +
>
> Maybe zero-filled pages might be a better term in both.

Do you mean dropping "with zero content" and replacing it by
Number of zero-filled pages moved out of memory ? I'm fine
with the change.

>
> >         zswpin
> >               Number of pages moved in to memory from zswap.
> >
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_ite=
m.h
> > index aed952d04132..f70d0958095c 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -134,6 +134,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPO=
UT,
> >  #ifdef CONFIG_SWAP
> >               SWAP_RA,
> >               SWAP_RA_HIT,
> > +             SWPIN_ZERO,
> > +             SWPOUT_ZERO,
> >  #ifdef CONFIG_KSM
> >               KSM_SWPIN_COPY,
> >  #endif
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 5e44d6e7591e..7b3503d12aaf 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -441,6 +441,10 @@ static const unsigned int memcg_vm_event_stat[] =
=3D {
> >       PGDEACTIVATE,
> >       PGLAZYFREE,
> >       PGLAZYFREED,
> > +#ifdef CONFIG_SWAP
> > +     SWPIN_ZERO,
> > +     SWPOUT_ZERO,
> > +#endif
> >  #ifdef CONFIG_ZSWAP
> >       ZSWPIN,
> >       ZSWPOUT,
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index 5d9b6e6cf96c..4b4ea8e49cf6 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -204,7 +204,9 @@ static bool is_folio_zero_filled(struct folio *foli=
o)
> >
> >  static void swap_zeromap_folio_set(struct folio *folio)
> >  {
> > +     struct obj_cgroup *objcg =3D get_obj_cgroup_from_folio(folio);
> >       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> > +     int nr_pages =3D folio_nr_pages(folio);
> >       swp_entry_t entry;
> >       unsigned int i;
> >
> > @@ -212,6 +214,12 @@ static void swap_zeromap_folio_set(struct folio *f=
olio)
> >               entry =3D page_swap_entry(folio_page(folio, i));
> >               set_bit(swp_offset(entry), sis->zeromap);
> >       }
> > +
> > +     count_vm_events(SWPOUT_ZERO, nr_pages);
> > +     if (objcg) {
> > +             count_objcg_events(objcg, SWPOUT_ZERO, nr_pages);
> > +             obj_cgroup_put(objcg);
> > +     }
> >  }
> >
> >  static void swap_zeromap_folio_clear(struct folio *folio)
> > @@ -507,6 +515,7 @@ static void sio_read_complete(struct kiocb *iocb, l=
ong ret)
> >  static bool swap_read_folio_zeromap(struct folio *folio)
> >  {
> >       int nr_pages =3D folio_nr_pages(folio);
> > +     struct obj_cgroup *objcg;
> >       bool is_zeromap;
> >
> >       /*
> > @@ -521,6 +530,13 @@ static bool swap_read_folio_zeromap(struct folio *=
folio)
> >       if (!is_zeromap)
> >               return false;
> >
> > +     objcg =3D get_obj_cgroup_from_folio(folio);
> > +     count_vm_events(SWPIN_ZERO, nr_pages);
> > +     if (objcg) {
> > +             count_objcg_events(objcg, SWPIN_ZERO, nr_pages);
> > +             obj_cgroup_put(objcg);
> > +     }
> > +
> >       folio_zero_range(folio, 0, folio_size(folio));
> >       folio_mark_uptodate(folio);
> >       return true;
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 22a294556b58..c8ef7352f9ed 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1418,6 +1418,8 @@ const char * const vmstat_text[] =3D {
> >  #ifdef CONFIG_SWAP
> >       "swap_ra",
> >       "swap_ra_hit",
> > +     "swpin_zero",
> > +     "swpout_zero",
> >  #ifdef CONFIG_KSM
> >       "ksm_swpin_copy",
> >  #endif
>

Thanks
Barry

