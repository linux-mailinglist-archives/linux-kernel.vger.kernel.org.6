Return-Path: <linux-kernel+bounces-438991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B99EA93B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6858168BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42437227599;
	Tue, 10 Dec 2024 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMzQAO3W"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED77DA6C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814352; cv=none; b=ttK0Xpe7aZLehua970gDy6ABUrdr/+qGHJ38cFM5HEmacr1g21Vsx6YdWWhlSParzm2FnKJC9ffTSZ+Vqd+n/HnSiMyl/apwkA58h7gANbSE50JuaPwaQ5XqTa44Q/WioK6uhAls2LRP20GCXciCHr0QNXVu2VsyC2DJ+k3sJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814352; c=relaxed/simple;
	bh=/E01dvAT+77VjZi3WL+hOTXDKafUlM+cCZnWoMbawKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfAdkv4LnvQed+PRseiDjRSCEWTo+QF0kpcjatKP13WywlSL21L+wfkBBWglimJnaRNK80SyzrB25WjTDaNvhj8GwGsJKQTBhKMvwPvjGDx5fLx0871EsamRhFhW8v3YdrXyw8DSQ8pI6YvBSC59uxcLQzIBFFYqEn5X/29kC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMzQAO3W; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso56449811fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 23:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733814348; x=1734419148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r40tdqGxedKVHyxQ11mMVfv6cV8xIj7UlzXlFGqZx0=;
        b=mMzQAO3W2s0citVznLPPMesUxqj2qWWIWi/iba5pTMUy7F7c4fPqmuwEuqaGkfT4R4
         F3txYLjhFc6+u3CBJ6To73yLzraaHO2gCFNJZC6mMuptU1it5PUjzPWtWukf+fKIF9RW
         qNRExaa2WlIjOncQecw8vhSe/HTb37VUJqj/7rY5rzAw5zzzE+VWKnAhSs22Ly7xHbK7
         NxalRKy2P2sqUrv9/X1I9XKBvYXYg4KqR6EFVoKF6DEa9jvZFC+EJOOyTWkdCp8pvuNv
         H/p7xN3I4Bf+HkrnsDIKda3tT6N7AmOETbuzf+rPaK0l50vBGcPBM7YYB+5AMuWpVmtr
         MgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733814348; x=1734419148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+r40tdqGxedKVHyxQ11mMVfv6cV8xIj7UlzXlFGqZx0=;
        b=plyVBB3YW3/rlGv1F2VNbIzUSsTI4uZesXlHtT30dxFyQbXmylBWgM4h2+hCt5vsNi
         f1Bz967am1iLRqjgirY/z8wrT/GOSyu/jFKjy5tGW4II4PMsscjJV5f0ZYer/iCRpW1R
         sZ2idtCrW9XsxtsHs+Tc1SpMDauVQ3hJMTsJ+tSGq8fXH64JdDxT9EkhwsniaMQL4INU
         OupL4RQBrGU2IUk6R4biNi7rLpRntXHE47vfdvpm/604tAQQCEJP6/qWAlTMCYSIowZ9
         RgYYz/X8CkpiSIK9df/uPPtDs+GvXy4Bq2Sog5XMIVCxI2Z1rivp+eNfANIcDZVd79m5
         Kb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVumXC5m4aEzJ+P51qmDKLsrERFsfs9CFx7yiPbyXM8Gx6bpNQh3wVFarhoPF4NGGwI4UfAdgu/PQFcKI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOB2zKtOquK1H3vK4+v06gqvnS8GNPOFGwTCczOCQpZ6eQYwfl
	xXWQC+zM+DUAeoqyUkyIA5f7gi+SFD2pUzEEzjcOuIYDbw5ViSIHpDv7HzgfTAbSNGmXrdN1d5l
	SmIwBUN3UN0QQTjZ1e4ZwActstZQ=
X-Gm-Gg: ASbGncuh08HBP9LZ5qjCDBQumbnFDTt0rna75L2RYMDKPjp09aQRbZdeYgEC57/g7E9
	urDTsaQ1Zk0rte/YnQ5Z1mfI4j5fRjfKRNv0=
X-Google-Smtp-Source: AGHT+IEjoI16xcnZF00aY7SZ9MT7aVBjK3lvkjb0W6tTxbslbqdA3eSBFAwxcLHXTBxMh/ShOeZiwD7vHDwNxwkCxfs=
X-Received: by 2002:a05:651c:1556:b0:2ff:a89b:4210 with SMTP id
 38308e7fff4ca-3022fb3ef21mr11751991fa.8.1733814348062; Mon, 09 Dec 2024
 23:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-5-ryncsn@gmail.com>
 <CACePvbXD=2Xj0yykQQdeQpaO_KCfyOCw1Q+U9VXugPttqH1bbA@mail.gmail.com>
In-Reply-To: <CACePvbXD=2Xj0yykQQdeQpaO_KCfyOCw1Q+U9VXugPttqH1bbA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 10 Dec 2024 15:05:31 +0800
Message-ID: <CAMgjq7AFjXa0bkeeeCYSvuFu4EDTEKSczRJG1G=vXAf=9BAYFw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, swap_cgroup: remove global swap cgroup lock
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:40=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
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
> > Emulation of 2 bytes cmpxchg/xchg with atomic isn't hard, so implement
> > it to get rid of this lock.
> >
> > Testing using 64G brd and build with build kernel with make -j96 in 1.5=
G
> > memory cgroup using 4k folios showed below improvement (10 test run):
> >
> > Before this series:
> > Sys time: 10730.08 (stdev 49.030728)
> > Real time: 171.03 (stdev 0.850355)
> >
> > After this commit:
> > Sys time: 9612.24 (stdev 66.310789), -10.42%
> > Real time: 159.78 (stdev 0.577193), -6.57%
> >
> > With 64k folios and 2G memcg:
> > Before this series:
> > Sys time: 7626.77 (stdev 43.545517)
> > Real time: 136.22 (stdev 1.265544)
> >
> > After this commit:
> > Sys time: 6936.03 (stdev 39.996280), -9.06%
> > Real time: 129.65 (stdev 0.880039), -4.82%
> >
> > Sequential swapout of 8G 4k zero folios (24 test run):
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
> >  mm/swap_cgroup.c | 56 +++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 41 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> > index a76afdc3666a..028f5e6be3f0 100644
> > --- a/mm/swap_cgroup.c
> > +++ b/mm/swap_cgroup.c
> > @@ -5,6 +5,15 @@
> >
> >  #include <linux/swapops.h> /* depends on mm.h include */
> >
> > +#define ID_PER_UNIT (sizeof(atomic_t) / sizeof(unsigned short))
>
> You might want to have some compile time assert that (sizeof(atomic_t)
> % sizeof(unsigned short)) is zero. Could not hurt.
>
> > +struct swap_cgroup_unit {
> > +       union {
> > +               int raw;
> > +               atomic_t val;
> > +               unsigned short __id[ID_PER_UNIT];
> > +       };
> > +};
>
> I suggest just getting rid of this complicated struct/union and using
> bit shift and mask to get the u16 out from the atomic_t.

Good suggestion.

>
> > +
> >  static DEFINE_MUTEX(swap_cgroup_mutex);
> >
> >  struct swap_cgroup {
> > @@ -12,8 +21,10 @@ struct swap_cgroup {
> >  };
> >
> >  struct swap_cgroup_ctrl {
> > -       unsigned short  *map;
> > -       spinlock_t      lock;
> > +       union {
> > +               struct swap_cgroup_unit *units;
> > +               unsigned short *map;
>
> You really shouldn't access the map as an "unsigned short" array,
> therefore, I suggest changing the array pointer to "atomic_t".
>
> > +       };
> >  };
> >
> >  static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
> > @@ -31,6 +42,24 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_=
SWAPFILES];
> >   *
> >   * TODO: we can push these buffers out to HIGHMEM.
> >   */
> > +static unsigned short __swap_cgroup_xchg(void *map,
> > +                                        pgoff_t offset,
> > +                                        unsigned int new_id)
> > +{
> > +       unsigned int old_id;
> > +       struct swap_cgroup_unit *units =3D map;
> > +       struct swap_cgroup_unit *unit =3D &units[offset / ID_PER_UNIT];
> > +       struct swap_cgroup_unit new, old =3D { .raw =3D atomic_read(&un=
it->val) };
> > +
> > +       do {
> > +               new.raw =3D old.raw;
> > +               old_id =3D old.__id[offset % ID_PER_UNIT];
> > +               new.__id[offset % ID_PER_UNIT] =3D new_id;
> > +       } while (!atomic_try_cmpxchg(&unit->val, &old.raw, new.raw));
>
> I suggest just calculating the atomic_t offset  (offset /
> ID_PER_UNIT) and getting the address of the atomic_t.
> Then use the mask and shift to construct the new atomic_t value. It is
> likely to generate better code.
> You don't want the compiler to generate memory load and store for
> constructing the temporary new value.
> I haven't checked the machine generated code, I suspect the compiler
> is not smart enough to convert those into register shift here. Which
> is what you really want.
>
> > +
> > +       return old_id;
> > +}
> > +
> >  /**
> >   * swap_cgroup_record - record mem_cgroup for a set of swap entries
> >   * @ent: the first swap entry to be recorded into
> > @@ -44,22 +73,19 @@ unsigned short swap_cgroup_record(swp_entry_t ent, =
unsigned short id,
> >                                   unsigned int nr_ents)
> >  {
> >         struct swap_cgroup_ctrl *ctrl;
> > -       unsigned short *map;
> > -       unsigned short old;
> > -       unsigned long flags;
> >         pgoff_t offset =3D swp_offset(ent);
> >         pgoff_t end =3D offset + nr_ents;
> > +       unsigned short old, iter;
> > +       unsigned short *map;
>
> Make it an atomic_t pointer here as well.
>
> >
> >         ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> >         map =3D ctrl->map;
> >
> > -       spin_lock_irqsave(&ctrl->lock, flags);
> > -       old =3D map[offset];
> > +       old =3D READ_ONCE(map[offset]);
>
> Ah, you shouldn't perform u16 reading directly. That will get into the
> endian problem of how the u16 is arranged into atomic_t. You should do
> atomic reading then shift the bits out so you don't have the endian
> problem. It is a bad idea mixing atomic updates and reading the middle
> of the atomic address location.

Good suggestion, convert the whole map into atomic_t and access / xchg
with bit shifts is also OK, mixing atomic with other types may lead to
misuse indeed.

>
> Chris
>
> >         do {
> > -               VM_BUG_ON(map[offset] !=3D old);
> > -               map[offset] =3D id;
> > +               iter =3D __swap_cgroup_xchg(map, offset, id);
> > +               VM_BUG_ON(iter !=3D old);
> >         } while (++offset !=3D end);
> > -       spin_unlock_irqrestore(&ctrl->lock, flags);
> >
> >         return old;
> >  }
> > @@ -85,20 +111,20 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t e=
nt)
> >
> >  int swap_cgroup_swapon(int type, unsigned long max_pages)
> >  {
> > -       void *map;
> > +       struct swap_cgroup_unit *units;
> >         struct swap_cgroup_ctrl *ctrl;
> >
> >         if (mem_cgroup_disabled())
> >                 return 0;
> >
> > -       map =3D vzalloc(max_pages * sizeof(unsigned short));
> > -       if (!map)
> > +       units =3D vzalloc(DIV_ROUND_UP(max_pages, ID_PER_UNIT) *
> > +                       sizeof(struct swap_cgroup_unit));
> > +       if (!units)
> >                 goto nomem;
> >
> >         ctrl =3D &swap_cgroup_ctrl[type];
> >         mutex_lock(&swap_cgroup_mutex);
> > -       ctrl->map =3D map;
> > -       spin_lock_init(&ctrl->lock);
> > +       ctrl->units =3D units;
> >         mutex_unlock(&swap_cgroup_mutex);
> >
> >         return 0;
> > --
> > 2.47.0
> >
>

