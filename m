Return-Path: <linux-kernel+bounces-432076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D9B9E44AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E7C16528E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09D1C3C0A;
	Wed,  4 Dec 2024 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miU2Xxqf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A7188A3B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340891; cv=none; b=YsH3fzBXxEiNOvuyKGwqlJ58typA0DTiQhiu8iUIA/lHATXVQPHXS4j5aHos1t+nxXI12GJuUeb+ooPEDt8/iU8UaUrL/ACvWuuyFNaPVS9YIRhlen+HDvtjBz+0n3x8Ub5cGWopE5swyM/8hHP4ifi02sEh37r3jcov7Qx0d8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340891; c=relaxed/simple;
	bh=J/bb4aBypkcHats8gtZZwQYkheISOYsvrT/INOcjFpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kV0a85uC/+gievOuEivMcd8J9Vr40nuOxCr5ch+ZF1nM1feypTXfHiw0qKINqR7ccu6XdnMQHT/iZgPgFTPhNtKZYYkN7IPzqPIQe8vdBT02Nlxdpxmdz721n5m+hfSzmNfXK7HkE9vuHm29gobz7yADL7qjyP+ZpiMg+giDq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miU2Xxqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA81C4CED6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733340890;
	bh=J/bb4aBypkcHats8gtZZwQYkheISOYsvrT/INOcjFpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=miU2XxqfJJL4NsMTWelivyyqErPZzbJNnGo5dYo5bDtbfsQIeXp3H+yz4jfAUw+FJ
	 cjOdn/2Ue6N0J95nLiby63BhOvMiqOq0IRBf8lvaL2Ul4XYAbcta0fnpVbG5Pu98KY
	 0KLorkD9qFl9x69rpx4Kzs1FvznjhcbBhVE0tRQtDcx2c9c4PFxHzaan45ZA7j4KTt
	 /5/ctRFDejm2KaM1aVw9r9prFkwSdVSy5B9hTthOA5AolIN5frdE49zkZw9wtT5Ijk
	 TCg8nr8xVd3gNuntPPyVc/+gYyDVMbanWnXNHCcNPs6d909DOgxM/z57DVpwaVl1X2
	 R/cBps4fA7Ojg==
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e399f8bb391so125781276.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:34:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgXm7X2nbOGRlaEwoMxpGHTopKZsG5+nFPU+H0GlzHDnfmQzCZqG8IqjNCDoRfqG7FF84BcGyhrFGAs0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzByeuk6OCJm+ncqjZoe2MBXZhEjFKql6CFx3HQQT3078YSQjV+
	aWeAc2CWPT0LE3QMFo8KK2xXRvYXokshBYWHa412ha8vgEqUXS7D5LnJWY3+tjryZfcBrMQn8/3
	UH8T3TNf3Hx9TOWrt3h15/7ly7rA8InVxxTxopg==
X-Google-Smtp-Source: AGHT+IGNDd2/EpIq+vn2u7XwmxMnQSDNF/Opmt/3lNt6whqHIt4TmhNR1XZ6RpGGq8yzXshcriMksekAOda3SPM3ydA=
X-Received: by 2002:a05:690c:6106:b0:6ee:bcdd:b1fb with SMTP id
 00721157ae682-6efad1bdcddmr93194227b3.19.1733340890025; Wed, 04 Dec 2024
 11:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-5-ryncsn@gmail.com>
In-Reply-To: <20241202184154.19321-5-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 4 Dec 2024 11:34:39 -0800
X-Gmail-Original-Message-ID: <CACePvbXD=2Xj0yykQQdeQpaO_KCfyOCw1Q+U9VXugPttqH1bbA@mail.gmail.com>
Message-ID: <CACePvbXD=2Xj0yykQQdeQpaO_KCfyOCw1Q+U9VXugPttqH1bbA@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, swap_cgroup: remove global swap cgroup lock
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
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
> Emulation of 2 bytes cmpxchg/xchg with atomic isn't hard, so implement
> it to get rid of this lock.
>
> Testing using 64G brd and build with build kernel with make -j96 in 1.5G
> memory cgroup using 4k folios showed below improvement (10 test run):
>
> Before this series:
> Sys time: 10730.08 (stdev 49.030728)
> Real time: 171.03 (stdev 0.850355)
>
> After this commit:
> Sys time: 9612.24 (stdev 66.310789), -10.42%
> Real time: 159.78 (stdev 0.577193), -6.57%
>
> With 64k folios and 2G memcg:
> Before this series:
> Sys time: 7626.77 (stdev 43.545517)
> Real time: 136.22 (stdev 1.265544)
>
> After this commit:
> Sys time: 6936.03 (stdev 39.996280), -9.06%
> Real time: 129.65 (stdev 0.880039), -4.82%
>
> Sequential swapout of 8G 4k zero folios (24 test run):
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
>  mm/swap_cgroup.c | 56 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 15 deletions(-)
>
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index a76afdc3666a..028f5e6be3f0 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -5,6 +5,15 @@
>
>  #include <linux/swapops.h> /* depends on mm.h include */
>
> +#define ID_PER_UNIT (sizeof(atomic_t) / sizeof(unsigned short))

You might want to have some compile time assert that (sizeof(atomic_t)
% sizeof(unsigned short)) is zero. Could not hurt.

> +struct swap_cgroup_unit {
> +       union {
> +               int raw;
> +               atomic_t val;
> +               unsigned short __id[ID_PER_UNIT];
> +       };
> +};

I suggest just getting rid of this complicated struct/union and using
bit shift and mask to get the u16 out from the atomic_t.

> +
>  static DEFINE_MUTEX(swap_cgroup_mutex);
>
>  struct swap_cgroup {
> @@ -12,8 +21,10 @@ struct swap_cgroup {
>  };
>
>  struct swap_cgroup_ctrl {
> -       unsigned short  *map;
> -       spinlock_t      lock;
> +       union {
> +               struct swap_cgroup_unit *units;
> +               unsigned short *map;

You really shouldn't access the map as an "unsigned short" array,
therefore, I suggest changing the array pointer to "atomic_t".

> +       };
>  };
>
>  static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
> @@ -31,6 +42,24 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SW=
APFILES];
>   *
>   * TODO: we can push these buffers out to HIGHMEM.
>   */
> +static unsigned short __swap_cgroup_xchg(void *map,
> +                                        pgoff_t offset,
> +                                        unsigned int new_id)
> +{
> +       unsigned int old_id;
> +       struct swap_cgroup_unit *units =3D map;
> +       struct swap_cgroup_unit *unit =3D &units[offset / ID_PER_UNIT];
> +       struct swap_cgroup_unit new, old =3D { .raw =3D atomic_read(&unit=
->val) };
> +
> +       do {
> +               new.raw =3D old.raw;
> +               old_id =3D old.__id[offset % ID_PER_UNIT];
> +               new.__id[offset % ID_PER_UNIT] =3D new_id;
> +       } while (!atomic_try_cmpxchg(&unit->val, &old.raw, new.raw));

I suggest just calculating the atomic_t offset  (offset /
ID_PER_UNIT) and getting the address of the atomic_t.
Then use the mask and shift to construct the new atomic_t value. It is
likely to generate better code.
You don't want the compiler to generate memory load and store for
constructing the temporary new value.
I haven't checked the machine generated code, I suspect the compiler
is not smart enough to convert those into register shift here. Which
is what you really want.

> +
> +       return old_id;
> +}
> +
>  /**
>   * swap_cgroup_record - record mem_cgroup for a set of swap entries
>   * @ent: the first swap entry to be recorded into
> @@ -44,22 +73,19 @@ unsigned short swap_cgroup_record(swp_entry_t ent, un=
signed short id,
>                                   unsigned int nr_ents)
>  {
>         struct swap_cgroup_ctrl *ctrl;
> -       unsigned short *map;
> -       unsigned short old;
> -       unsigned long flags;
>         pgoff_t offset =3D swp_offset(ent);
>         pgoff_t end =3D offset + nr_ents;
> +       unsigned short old, iter;
> +       unsigned short *map;

Make it an atomic_t pointer here as well.

>
>         ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
>         map =3D ctrl->map;
>
> -       spin_lock_irqsave(&ctrl->lock, flags);
> -       old =3D map[offset];
> +       old =3D READ_ONCE(map[offset]);

Ah, you shouldn't perform u16 reading directly. That will get into the
endian problem of how the u16 is arranged into atomic_t. You should do
atomic reading then shift the bits out so you don't have the endian
problem. It is a bad idea mixing atomic updates and reading the middle
of the atomic address location.

Chris

>         do {
> -               VM_BUG_ON(map[offset] !=3D old);
> -               map[offset] =3D id;
> +               iter =3D __swap_cgroup_xchg(map, offset, id);
> +               VM_BUG_ON(iter !=3D old);
>         } while (++offset !=3D end);
> -       spin_unlock_irqrestore(&ctrl->lock, flags);
>
>         return old;
>  }
> @@ -85,20 +111,20 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t ent=
)
>
>  int swap_cgroup_swapon(int type, unsigned long max_pages)
>  {
> -       void *map;
> +       struct swap_cgroup_unit *units;
>         struct swap_cgroup_ctrl *ctrl;
>
>         if (mem_cgroup_disabled())
>                 return 0;
>
> -       map =3D vzalloc(max_pages * sizeof(unsigned short));
> -       if (!map)
> +       units =3D vzalloc(DIV_ROUND_UP(max_pages, ID_PER_UNIT) *
> +                       sizeof(struct swap_cgroup_unit));
> +       if (!units)
>                 goto nomem;
>
>         ctrl =3D &swap_cgroup_ctrl[type];
>         mutex_lock(&swap_cgroup_mutex);
> -       ctrl->map =3D map;
> -       spin_lock_init(&ctrl->lock);
> +       ctrl->units =3D units;
>         mutex_unlock(&swap_cgroup_mutex);
>
>         return 0;
> --
> 2.47.0
>

