Return-Path: <linux-kernel+bounces-446098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942DC9F1FDA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1445166D75
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FF9194ACA;
	Sat, 14 Dec 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfBnGkmV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F2522F
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734192443; cv=none; b=X/8vWcD9hCK+4fUxEBelG59C/gt/RFvRTNPwY8ueDenF+IQmJjoMY0WUXKc4MQN1gQvjNjzzfiMAYz2EfyPguDPHZOwF68TsMfzlnPxMjHcvVnFwK8oZZt42z2TQC3yPBYb4TNjwe/gZHHBOBEbdC1lJnJ90NxeS/nTUQ8AVh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734192443; c=relaxed/simple;
	bh=IUFN18xwobR6b8b1Y9hKWc9kSZHPz67g+Ox77EK7m6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3eXVVc8f0aHlPSKT7xfDczyy5fvEPrAmdFo4pqGM3e2ObxwWRxkEt2kJnVfC+crx0lindlUgbsqnLtmlRw5H7Pl5YuLyDIx5Mi+XaoXrDRTSWNWfnRQuDyFhHFnTinP+bB7y9He6EXHEGVlEN8puawMqpF3wKEnPP7Tek3HZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfBnGkmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04261C4CEDF
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734192443;
	bh=IUFN18xwobR6b8b1Y9hKWc9kSZHPz67g+Ox77EK7m6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rfBnGkmVQj8UanQV/m2WidN3OgPudLK2eHguWDMUjnzrUvbaB2oetXuz31KI/SHKi
	 4GkOU+XU09fapnPketUxDS6kpyt4gnsQCfAKgS5q/yWRS3NbpVJnNtCEtungDcHuLf
	 788/j2oKzwkFbq2HjqRO1fOVd7jbOsYOqAPGk4VULrslF/sGxQ+u+pSxZ6bPi9B5Bx
	 SazI8qa7MBqvsEESAD7C2CfJgmSpAGF2awrTN/l8c4D2JChjYPN/uojwcv3GMlKUZE
	 6ZpXuNhb67e3b83H3CXVrtnAIQOSQIRrGlS8nqn8XFvsrJ+PsJLhFN4SmTH0P3Cd2p
	 DczIEBaKtxJ8w==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6efc58fae20so24157487b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 08:07:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHhamS4tbX1EGHB+g8tIL4aNiaJhtNzb5IiW4T9va6jXOvLDUHQLoc73GMG5Jtb2SKSwuGdm9nnubPV5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YySu68hB3sc3j74VZVudu2cD23yNbYHaEBNMjshK35VJytR0eoW
	VjRxLfmIX6X13YFlN1K5F2LOgsss0kUbvMCPcke1vbnUV8Hh3zhYmrru4vm1BNEmFFZffhQhrUw
	zYGmqZaed9fN2PpMcMlpZeC2n6SbSHOJgiZoozw==
X-Google-Smtp-Source: AGHT+IGzRBDJR41i6g3YbVLhRzSxsqzL9a8nS2/9Ko+J3Kf5UgrBs2NPOHkjpEA8phLGCXEcQlyTynqYdWlHaTx52o8=
X-Received: by 2002:a05:690c:f86:b0:6ef:9017:3cc8 with SMTP id
 00721157ae682-6f279b909b0mr65896427b3.31.1734192442196; Sat, 14 Dec 2024
 08:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210092805.87281-1-ryncsn@gmail.com> <20241210092805.87281-4-ryncsn@gmail.com>
In-Reply-To: <20241210092805.87281-4-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 14 Dec 2024 08:07:08 -0800
X-Gmail-Original-Message-ID: <CACePvbUoije1wgy3jPambP9-rbYs_Yq1Pajnv3U1MDOxFGU2fg@mail.gmail.com>
Message-ID: <CACePvbUoije1wgy3jPambP9-rbYs_Yq1Pajnv3U1MDOxFGU2fg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm, swap_cgroup: remove global swap cgroup lock
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@linux.alibaba.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 1:29=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup maintainanc=
e")
> replaced the cmpxchg/xchg with a global irq spinlock because some archs
> doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale well.
>
> And as commented in swap_cgroup.c, this lock is not needed for map
> synchronization.
>
> Emulation of 2 bytes xchg with atomic cmpxchg isn't hard, so implement
> it to get rid of this lock. Introduced two helpers for doing so and they
> can be easily dropped if a generic 2 byte xchg is support.
>
> Testing using 64G brd and build with build kernel with make -j96 in 1.5G
> memory cgroup using 4k folios showed below improvement (10 test run):
>
> Before this series:
> Sys time: 10809.46 (stdev 80.831491)
> Real time: 171.41 (stdev 1.239894)
>
> After this commit:
> Sys time: 9621.26 (stdev 34.620000), -10.42%
> Real time: 160.00 (stdev 0.497814), -6.57%
>
> With 64k folios and 2G memcg:
> Before this series:
> Sys time: 8231.99 (stdev 30.030994)
> Real time: 143.57 (stdev 0.577394)
>
> After this commit:
> Sys time: 7403.47 (stdev 6.270000), -10.06%
> Real time: 135.18 (stdev 0.605000), -5.84%
>
> Sequential swapout of 8G 64k zero folios with madvise (24 test run):
> Before this series:
> 5461409.12 us (stdev 183957.827084)
>
> After this commit:
> 5420447.26 us (stdev 196419.240317)
>
> Sequential swapin of 8G 4k zero folios (24 test run):
> Before this series:
> 19736958.916667 us (stdev 189027.246676)
>
> After this commit:
> 19662182.629630 us (stdev 172717.640614)
>
> Performance is better or at least not worse for all tests above.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_cgroup.c | 73 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index 1770b076f6b7..a0a8547dc85d 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -7,19 +7,20 @@
>
>  static DEFINE_MUTEX(swap_cgroup_mutex);
>
> +/* Pack two cgroup id (short) of two entries in one swap_cgroup (atomic_=
t) */

Might not be two short if the atomic_t is more than 4 bytes. The
assumption here is that short is 2 bytes and atomic_t is 4 bytes. It
is hard to conclude that is the case for all architecture.

> +#define ID_PER_SC (sizeof(atomic_t) / sizeof(unsigned short))

You should use "sizeof(struct swap_cgroup) / sizeof(unsigned short)",
or get rid of struct swap_cgroup and directly use atomic_t.

> +#define ID_SHIFT (BITS_PER_TYPE(unsigned short))
> +#define ID_MASK (BIT(ID_SHIFT) - 1)
>  struct swap_cgroup {
> -       unsigned short          id;
> +       atomic_t ids;

You use struct swap_cgroup and atomic_t which assumes no padding added
to the struct. You might want to build an assert on sizeof(atomic_t)
=3D=3D sizeof(struct swap_cgroup).

>  };
>
>  struct swap_cgroup_ctrl {
>         struct swap_cgroup *map;
> -       spinlock_t      lock;
>  };
>
>  static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
>
> -#define SC_PER_PAGE    (PAGE_SIZE/sizeof(struct swap_cgroup))
> -
>  /*
>   * SwapCgroup implements "lookup" and "exchange" operations.
>   * In typical usage, this swap_cgroup is accessed via memcg's charge/unc=
harge
> @@ -30,19 +31,32 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_S=
WAPFILES];
>   *    SwapCache(and its swp_entry) is under lock.
>   *  - When called via swap_free(), there is no user of this entry and no=
 race.
>   * Then, we don't need lock around "exchange".
> - *
> - * TODO: we can push these buffers out to HIGHMEM.
>   */
> -static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
> -                                       struct swap_cgroup_ctrl **ctrlp)
> +static unsigned short __swap_cgroup_id_lookup(struct swap_cgroup *map,
> +                                             pgoff_t offset)
>  {
> -       pgoff_t offset =3D swp_offset(ent);
> -       struct swap_cgroup_ctrl *ctrl;
> +       unsigned int shift =3D (offset & 1) ? 0 : ID_SHIFT;

Might not want to assume the ID_PER_SC is two. If some architecture
atomic_t is 64 bits then that code will break.

> +       unsigned int old_ids =3D atomic_read(&map[offset / ID_PER_SC].ids=
);

Here assume sizeof(unsigned int) =3D=3D sizeof(atomic_t). Again,some
strange architecture might break it. Better use unsigned version of
aotmic_t;


>
> -       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> -       if (ctrlp)
> -               *ctrlp =3D ctrl;
> -       return &ctrl->map[offset];
> +       return (old_ids & (ID_MASK << shift)) >> shift;

Can be simplified as (old_ids >> shift) & ID_MASK. You might want to
double check that.

> +}
> +
> +static unsigned short __swap_cgroup_id_xchg(struct swap_cgroup *map,
> +                                           pgoff_t offset,
> +                                           unsigned short new_id)
> +{
> +       unsigned short old_id;
> +       unsigned int shift =3D (offset & 1) ? 0 : ID_SHIFT;

Same here, it assumes ID_PER_SC is 2.

> +       struct swap_cgroup *sc =3D &map[offset / ID_PER_SC];
> +       unsigned int new_ids, old_ids =3D atomic_read(&sc->ids);

Again it assumes  sizeof(unsigned int) =3D=3D sizeof(atomic_t).

> +
> +       do {
> +               old_id =3D (old_ids & (ID_MASK << shift)) >> shift;
Can be simplify:
old_id =3D (old_ids >> shift) & ID_MASK;

> +               new_ids =3D (old_ids & ~(ID_MASK << shift));
> +               new_ids |=3D ((unsigned int)new_id) << shift;

new_ids |=3D (atomic_t) new_id << shift;

> +       } while (!atomic_try_cmpxchg(&sc->ids, &old_ids, new_ids));
> +
> +       return old_id;
>  }
>
>  /**
> @@ -58,21 +72,19 @@ unsigned short swap_cgroup_record(swp_entry_t ent, un=
signed short id,
>                                   unsigned int nr_ents)
>  {
>         struct swap_cgroup_ctrl *ctrl;
> -       struct swap_cgroup *sc;
> -       unsigned short old;
> -       unsigned long flags;
>         pgoff_t offset =3D swp_offset(ent);
>         pgoff_t end =3D offset + nr_ents;
> +       unsigned short old, iter;
> +       struct swap_cgroup *map;
>
> -       sc =3D lookup_swap_cgroup(ent, &ctrl);
> +       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> +       map =3D ctrl->map;
>
> -       spin_lock_irqsave(&ctrl->lock, flags);
> -       old =3D sc->id;
> -       for (; offset < end; offset++, sc++) {
> -               VM_BUG_ON(sc->id !=3D old);
> -               sc->id =3D id;
> -       }
> -       spin_unlock_irqrestore(&ctrl->lock, flags);

The above will always assign nr_ents of swap entry atomically.

> +       old =3D __swap_cgroup_id_lookup(map, offset);
> +       do {
> +               iter =3D __swap_cgroup_id_xchg(map, offset, id);
> +               VM_BUG_ON(iter !=3D old);
> +       } while (++offset !=3D end);

Here it is possible that some of the nr_ents can be changed while the
offset is still in the loop. Might want to examine if the caller can
trigger that or not. We want to make sure it is safe to do so, when
removing the spin lock, the nr_ents might not update to the same value
if two callers race it.
>
>         return old;
>  }
> @@ -85,9 +97,13 @@ unsigned short swap_cgroup_record(swp_entry_t ent, uns=
igned short id,
>   */
>  unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
>  {
> +       struct swap_cgroup_ctrl *ctrl;
> +
>         if (mem_cgroup_disabled())
>                 return 0;
> -       return lookup_swap_cgroup(ent, NULL)->id;
> +
> +       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> +       return __swap_cgroup_id_lookup(ctrl->map, swp_offset(ent));
>  }
>
>  int swap_cgroup_swapon(int type, unsigned long max_pages)
> @@ -98,14 +114,15 @@ int swap_cgroup_swapon(int type, unsigned long max_p=
ages)
>         if (mem_cgroup_disabled())
>                 return 0;
>
> -       map =3D vcalloc(max_pages, sizeof(struct swap_cgroup));
> +       BUILD_BUG_ON(!ID_PER_SC);

It is simpler just to assert on: sizeof(atomic_t) >=3D sizeof(unsigned shor=
t).
I think that is what it does here.

You might also want to assert:  !(sizeof(atomic_t) % sizeof(unsigned short)=
)

Chris

> +       map =3D vcalloc(DIV_ROUND_UP(max_pages, ID_PER_SC),
> +                     sizeof(struct swap_cgroup));
>         if (!map)
>                 goto nomem;
>
>         ctrl =3D &swap_cgroup_ctrl[type];
>         mutex_lock(&swap_cgroup_mutex);
>         ctrl->map =3D map;
> -       spin_lock_init(&ctrl->lock);
>         mutex_unlock(&swap_cgroup_mutex);
>
>         return 0;
> --
> 2.47.1
>

