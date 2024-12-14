Return-Path: <linux-kernel+bounces-446173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E572E9F20A2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 20:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1AE7A12E2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 19:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA61AB52F;
	Sat, 14 Dec 2024 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqFvrVra"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42B63C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734205705; cv=none; b=Vpjf83YnSyP/E/CpaHFszsbw7cHoTTQ28s37iz1r1+tLmSOmojeCMVApyaJCA6mRct2RA8Kka/rb/rss1Yv0kg2QqwCSCJDzMdiqn0iAyNKkxOmeYR3gqRTf7+Nfpy1VqzOifVK26Hv28zMetYE8q2xGSBy+swF6uw96HkD1EDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734205705; c=relaxed/simple;
	bh=2LrgK9YggMsaM0j+1p8RTVCuI9JQdNKs/3QV98i8Rvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQY/m/2dEM5q3PNRHJeb7ZTD3kKmyDnD6Ppzgrx83S928iax0JxU9tvfmwe0mnsxHJalTNfTkzuFxBA+sjZW21ET1G73nzTws52HSF5h/V/BbbOx96yApfXA6qeF5cLXb3WnzpTpWptktkElDEqAtE34Bz7PcJRBe7I9tlew5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqFvrVra; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3022c61557cso28088251fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 11:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734205701; x=1734810501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSQSgzaRW5fOqEulzLp9bARmMa7yGmW3doMqXtDqWeU=;
        b=dqFvrVra5ZlEaEBzRaBxpxjQ+LSlwud+HD4Iasy+rTEPqF8JFrsHyyGavOUpldRomY
         2QA3zGLdDFydMtNdemIcjmght1UDVbp4m0ODPjSdRn8MVcg4OG5ymZETVubBaGjqe609
         wO0NKacawpEx8uMQmTmg4rs9iuxw4WNR8yyG/dqrOXjMbJILPvIeuf1r62U8aCA0Ughr
         /Kiyzmur6y2oGjzJPAU0XG1+EeKIPpsPlHZpT7MEYhlSgVZToQgK+7SaEA0O1Dz0J35x
         C3ixSUzic2JEcoJCfTsxkP++8ss8kvwVb0+FZoGcknUaGz4L6RXcr416kuFMkDT8dF0p
         OBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734205701; x=1734810501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSQSgzaRW5fOqEulzLp9bARmMa7yGmW3doMqXtDqWeU=;
        b=pRFmFQu0ww6cQfLNpptTRXmO728MjwTJ5PNTDCK2eKeubRt1m/mzZ8pZx8rHzGnPYB
         UgyOO6c2zpBYU/39kW7lEJ8hQE5n88k24fIYAOrkKl6RfTRIdk3wp55iVFs1cXgVZxvQ
         UsdsX5zQ32TtRAv89+Ek3TwgrQBGbZ2h2uclIFVqhVuNAFuX28pdbcJAx119kbijYPYK
         hOH4DCRhH8pGSQVM4Quxmct6ezyhuNsiuNAr8Qw3BSUOCB1xatLTZqqwCOjJEu0xqPTY
         5eS9rz98YXpGLbkzXNt45Ve1s7TrbC4r0Xkh6virdfU4m34cESNVKWQcCvF1NPg3mKF8
         WmcA==
X-Forwarded-Encrypted: i=1; AJvYcCXd7KdL9zzpusdGiFw9dt6/ikVYhhuFoXuGXSb7bDvP2D7yUo3XxMmtDOWCSiT0QjoGzdah9AMo60J7lvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3IYCocB3mlYjuKLI5SmVtIDclEl/pnHFXUWwT3jDewMRp+/9s
	WRQKcde+z/HKxJTG7eJvIEYX+icQi4oQtdn3uU9sZ+H7uZeGLIWu7JgdcNdIWuT3CF/ldqoUqrU
	pYaXyBuuE2zlpqrg92aVJEvJyr50=
X-Gm-Gg: ASbGncv8/8ymLFFXUcr6j/9y/IFWGwn0zvcemqCdRDY7bRqvRnm3MjcaPfAcW83LYt2
	VinBnxlodgkMOgz7FEhMjNRAq24GkurAnUPsxSA==
X-Google-Smtp-Source: AGHT+IHQKWezJ4q3nN2riv4xr7TQGAZ+cxTTseQa4VvURR2rkwdhKpo6YmdoC8uGcHkx8t5Mh3YJBWZbbzX8ow6KJ+A=
X-Received: by 2002:a2e:b8c6:0:b0:302:336a:84e5 with SMTP id
 38308e7fff4ca-302544d3a4amr26870521fa.39.1734205701350; Sat, 14 Dec 2024
 11:48:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210092805.87281-1-ryncsn@gmail.com> <20241210092805.87281-4-ryncsn@gmail.com>
 <CACePvbUoije1wgy3jPambP9-rbYs_Yq1Pajnv3U1MDOxFGU2fg@mail.gmail.com>
In-Reply-To: <CACePvbUoije1wgy3jPambP9-rbYs_Yq1Pajnv3U1MDOxFGU2fg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 15 Dec 2024 03:48:05 +0800
Message-ID: <CAMgjq7D43TQtvdrUyECq0GfaobbEpA2ANgyAqBnh-yJ3n74YAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm, swap_cgroup: remove global swap cgroup lock
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@linux.alibaba.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 12:07=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Tue, Dec 10, 2024 at 1:29=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup maintaina=
nce")
> > replaced the cmpxchg/xchg with a global irq spinlock because some archs
> > doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale well.
> >
> > And as commented in swap_cgroup.c, this lock is not needed for map
> > synchronization.
> >
> > Emulation of 2 bytes xchg with atomic cmpxchg isn't hard, so implement
> > it to get rid of this lock. Introduced two helpers for doing so and the=
y
> > can be easily dropped if a generic 2 byte xchg is support.
> >
> > Testing using 64G brd and build with build kernel with make -j96 in 1.5=
G
> > memory cgroup using 4k folios showed below improvement (10 test run):
> >
> > Before this series:
> > Sys time: 10809.46 (stdev 80.831491)
> > Real time: 171.41 (stdev 1.239894)
> >
> > After this commit:
> > Sys time: 9621.26 (stdev 34.620000), -10.42%
> > Real time: 160.00 (stdev 0.497814), -6.57%
> >
> > With 64k folios and 2G memcg:
> > Before this series:
> > Sys time: 8231.99 (stdev 30.030994)
> > Real time: 143.57 (stdev 0.577394)
> >
> > After this commit:
> > Sys time: 7403.47 (stdev 6.270000), -10.06%
> > Real time: 135.18 (stdev 0.605000), -5.84%
> >
> > Sequential swapout of 8G 64k zero folios with madvise (24 test run):
> > Before this series:
> > 5461409.12 us (stdev 183957.827084)
> >
> > After this commit:
> > 5420447.26 us (stdev 196419.240317)
> >
> > Sequential swapin of 8G 4k zero folios (24 test run):
> > Before this series:
> > 19736958.916667 us (stdev 189027.246676)
> >
> > After this commit:
> > 19662182.629630 us (stdev 172717.640614)
> >
> > Performance is better or at least not worse for all tests above.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_cgroup.c | 73 +++++++++++++++++++++++++++++-------------------
> >  1 file changed, 45 insertions(+), 28 deletions(-)
> >
> > diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> > index 1770b076f6b7..a0a8547dc85d 100644
> > --- a/mm/swap_cgroup.c
> > +++ b/mm/swap_cgroup.c
> > @@ -7,19 +7,20 @@
> >
> >  static DEFINE_MUTEX(swap_cgroup_mutex);
> >
> > +/* Pack two cgroup id (short) of two entries in one swap_cgroup (atomi=
c_t) */
>
> Might not be two short if the atomic_t is more than 4 bytes. The
> assumption here is that short is 2 bytes and atomic_t is 4 bytes. It
> is hard to conclude that is the case for all architecture.
>
> > +#define ID_PER_SC (sizeof(atomic_t) / sizeof(unsigned short))
>
> You should use "sizeof(struct swap_cgroup) / sizeof(unsigned short)",
> or get rid of struct swap_cgroup and directly use atomic_t.
>
> > +#define ID_SHIFT (BITS_PER_TYPE(unsigned short))
> > +#define ID_MASK (BIT(ID_SHIFT) - 1)
> >  struct swap_cgroup {
> > -       unsigned short          id;
> > +       atomic_t ids;
>
> You use struct swap_cgroup and atomic_t which assumes no padding added
> to the struct. You might want to build an assert on sizeof(atomic_t)
> =3D=3D sizeof(struct swap_cgroup).

Good idea, asserting struct swap_croup is an atomic_t ensures no
unexpected behaviour.

>
> >  };
> >
> >  struct swap_cgroup_ctrl {
> >         struct swap_cgroup *map;
> > -       spinlock_t      lock;
> >  };
> >
> >  static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
> >
> > -#define SC_PER_PAGE    (PAGE_SIZE/sizeof(struct swap_cgroup))
> > -
> >  /*
> >   * SwapCgroup implements "lookup" and "exchange" operations.
> >   * In typical usage, this swap_cgroup is accessed via memcg's charge/u=
ncharge
> > @@ -30,19 +31,32 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX=
_SWAPFILES];
> >   *    SwapCache(and its swp_entry) is under lock.
> >   *  - When called via swap_free(), there is no user of this entry and =
no race.
> >   * Then, we don't need lock around "exchange".
> > - *
> > - * TODO: we can push these buffers out to HIGHMEM.
> >   */
> > -static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
> > -                                       struct swap_cgroup_ctrl **ctrlp=
)
> > +static unsigned short __swap_cgroup_id_lookup(struct swap_cgroup *map,
> > +                                             pgoff_t offset)
> >  {
> > -       pgoff_t offset =3D swp_offset(ent);
> > -       struct swap_cgroup_ctrl *ctrl;
> > +       unsigned int shift =3D (offset & 1) ? 0 : ID_SHIFT;
>
> Might not want to assume the ID_PER_SC is two. If some architecture
> atomic_t is 64 bits then that code will break.

Good idea, atomic_t is by defining an int, not sure if there is any
strange archs will change the size though, more robust code is always
better.

Can change this to (offset % ID_PER_SC) instead, the generated machine
code should be still the same for most archs.

>
> > +       unsigned int old_ids =3D atomic_read(&map[offset / ID_PER_SC].i=
ds);
>
> Here assume sizeof(unsigned int) =3D=3D sizeof(atomic_t). Again,some
> strange architecture might break it. Better use unsigned version of
> aotmic_t;
>
>
> >
> > -       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> > -       if (ctrlp)
> > -               *ctrlp =3D ctrl;
> > -       return &ctrl->map[offset];
> > +       return (old_ids & (ID_MASK << shift)) >> shift;
>
> Can be simplified as (old_ids >> shift) & ID_MASK. You might want to
> double check that.
>
> > +}
> > +
> > +static unsigned short __swap_cgroup_id_xchg(struct swap_cgroup *map,
> > +                                           pgoff_t offset,
> > +                                           unsigned short new_id)
> > +{
> > +       unsigned short old_id;
> > +       unsigned int shift =3D (offset & 1) ? 0 : ID_SHIFT;
>
> Same here, it assumes ID_PER_SC is 2.
>
> > +       struct swap_cgroup *sc =3D &map[offset / ID_PER_SC];
> > +       unsigned int new_ids, old_ids =3D atomic_read(&sc->ids);
>
> Again it assumes  sizeof(unsigned int) =3D=3D sizeof(atomic_t).

I think this should be OK? The document says "atomic_t, atomic_long_t
and atomic64_t use int, long and s64 respectively".

Could change this with some wrapper but I think it's unnecessary.

>
> > +
> > +       do {
> > +               old_id =3D (old_ids & (ID_MASK << shift)) >> shift;
> Can be simplify:
> old_id =3D (old_ids >> shift) & ID_MASK;
>
> > +               new_ids =3D (old_ids & ~(ID_MASK << shift));
> > +               new_ids |=3D ((unsigned int)new_id) << shift;
>
> new_ids |=3D (atomic_t) new_id << shift;

atomic_t doesn't work with bit operations, it must be an arithmetic
type, so here I think it has to stay like this.

>
> > +       } while (!atomic_try_cmpxchg(&sc->ids, &old_ids, new_ids));
> > +
> > +       return old_id;
> >  }
> >
> >  /**
> > @@ -58,21 +72,19 @@ unsigned short swap_cgroup_record(swp_entry_t ent, =
unsigned short id,
> >                                   unsigned int nr_ents)
> >  {
> >         struct swap_cgroup_ctrl *ctrl;
> > -       struct swap_cgroup *sc;
> > -       unsigned short old;
> > -       unsigned long flags;
> >         pgoff_t offset =3D swp_offset(ent);
> >         pgoff_t end =3D offset + nr_ents;
> > +       unsigned short old, iter;
> > +       struct swap_cgroup *map;
> >
> > -       sc =3D lookup_swap_cgroup(ent, &ctrl);
> > +       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> > +       map =3D ctrl->map;
> >
> > -       spin_lock_irqsave(&ctrl->lock, flags);
> > -       old =3D sc->id;
> > -       for (; offset < end; offset++, sc++) {
> > -               VM_BUG_ON(sc->id !=3D old);
> > -               sc->id =3D id;
> > -       }
> > -       spin_unlock_irqrestore(&ctrl->lock, flags);
>
> The above will always assign nr_ents of swap entry atomically.
>
> > +       old =3D __swap_cgroup_id_lookup(map, offset);
> > +       do {
> > +               iter =3D __swap_cgroup_id_xchg(map, offset, id);
> > +               VM_BUG_ON(iter !=3D old);
> > +       } while (++offset !=3D end);
>
> Here it is possible that some of the nr_ents can be changed while the
> offset is still in the loop. Might want to examine if the caller can
> trigger that or not. We want to make sure it is safe to do so, when
> removing the spin lock, the nr_ents might not update to the same value
> if two callers race it.

Right, the problem is explained with the comments in the beginning of
this file, I can update that with more details:

Entries are always charged / uncharged belonging to one folio, or
being uncharged with no folio related (no more users, other folios
can't use these entries unless freeing is done).

As a folio is always charged or uncharged as a whole, and charge /
uncharge never happens concurrently, and the xchg here implies full
barrier, so the set of entries will also always be used as a whole.

So yes this function does implies the caller must always pass in swap
entries belonging to one single folio, or entries that have no users.
It's quite fragile indeed, I can make the caller pass in the folio as
an argument to clarify this, with some more WARN or BUG_ON.

> >
> >         return old;
> >  }
> > @@ -85,9 +97,13 @@ unsigned short swap_cgroup_record(swp_entry_t ent, u=
nsigned short id,
> >   */
> >  unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
> >  {
> > +       struct swap_cgroup_ctrl *ctrl;
> > +
> >         if (mem_cgroup_disabled())
> >                 return 0;
> > -       return lookup_swap_cgroup(ent, NULL)->id;
> > +
> > +       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> > +       return __swap_cgroup_id_lookup(ctrl->map, swp_offset(ent));
> >  }
> >
> >  int swap_cgroup_swapon(int type, unsigned long max_pages)
> > @@ -98,14 +114,15 @@ int swap_cgroup_swapon(int type, unsigned long max=
_pages)
> >         if (mem_cgroup_disabled())
> >                 return 0;
> >
> > -       map =3D vcalloc(max_pages, sizeof(struct swap_cgroup));
> > +       BUILD_BUG_ON(!ID_PER_SC);
>
> It is simpler just to assert on: sizeof(atomic_t) >=3D sizeof(unsigned sh=
ort).
> I think that is what it does here.
>
> You might also want to assert:  !(sizeof(atomic_t) % sizeof(unsigned shor=
t))

Good idea.


>
> Chris
>
> > +       map =3D vcalloc(DIV_ROUND_UP(max_pages, ID_PER_SC),
> > +                     sizeof(struct swap_cgroup));
> >         if (!map)
> >                 goto nomem;
> >
> >         ctrl =3D &swap_cgroup_ctrl[type];
> >         mutex_lock(&swap_cgroup_mutex);
> >         ctrl->map =3D map;
> > -       spin_lock_init(&ctrl->lock);
> >         mutex_unlock(&swap_cgroup_mutex);
> >
> >         return 0;
> > --
> > 2.47.1
> >
>

