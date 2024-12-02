Return-Path: <linux-kernel+bounces-428263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1A89E0D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F791B38461
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF11DE4D9;
	Mon,  2 Dec 2024 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEgqOY1P"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C612AD21
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167729; cv=none; b=KddK0+W4w0lsLOQDMr+6M8kcaCOHAuUH3CmdXr6JQ9Bbsmgyg7iwbHDAgt+b2syfPu/7n62/xljt0yW/zYPd6X+UPmSO2us9k3d5b7J7adoI3/CrFdewIlDXiyOs+pFuHaB5dXwWh6N+C2wDJQjKO614WiXXd4eJqkQRiZkjyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167729; c=relaxed/simple;
	bh=R8fs7I5IbPbjkRxWiEiNJlqZVgwubOVjE0Uc5f6cs4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlyMGJDjKXQONyHQnF8ghtxliYyVrGpjnRmDOGs52nd0c+ktzSXWAdq3XuvKoK4ClAAw8+7EFC9bO+XUZRaUeMqnzd45y06pYwf0p8s45h9wjB7hPixT3j6VxWk4GzwzFuOaqlBlKlbsh6Vk9kfO58mamGL3Lni17Hd8EGJd1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEgqOY1P; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d87fffeb13so33302486d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733167727; x=1733772527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGF7RbAroiJxVx8e3jT5nECdT705GYeY+ycgQDnbrIk=;
        b=JEgqOY1PAlt4EEYdsgpQtitQ6F2Z0MdtvrIJacdvpD1fif+OVq2L29RYBP6upY+Drf
         3gReWBapgZBrFs2/FKDVnlJ9dPNIi41QALP6weyNXUpFy4pCk6lS9OoSMIVBPKRNl6Mw
         kZJrhnSXFjJcc3UzYOdAN67rTYtrEeTMObr7OdIi/511sjuBaSYx6OuK4ZUKKoFsWeAl
         TZkZXdQBZfkkNcKYvrITstnbHDIw3RGBddkcMpBc25zgLt8f6qXC+Zr9i7LJ5epP/MAY
         OnM/EwN6V5VyU5JUy3J8MRwT2pqOTYlM0tR4h4de8yvjf0Yd5lFafx5wUyLh5bILIUas
         inQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167727; x=1733772527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGF7RbAroiJxVx8e3jT5nECdT705GYeY+ycgQDnbrIk=;
        b=GpkagFD9Ot9k0QWa6spczJJzDKQUHuRzGBX8z9sfFSjLlUOJwoNp4hEvo0wC6qRtzS
         eRYvbniz1c+087PPG6Kf9KFCBY4enK6Vo2FFfyXXy7haqAqnLeI3BEzl6+En4dP4ANQC
         CHsDTjvz4KTlisUMV1xOJ3WQWx3TkAgbuOZ4FKf0QlXBwvkge6qoM+NJdh/KRUJlWiIo
         dXBWE/zHgcozhZLIbsG5CQZ+Pkla9+gu9K9JXfXAW0LUOOo7bRQ3kH/x++rITaiUM7L8
         RrUpzD4auV6ucI+mRm5fkcmy5LjTqWMFR6dkv6UeMW7mWNV9QUYY+47pJK8OgANvx1lI
         Uvqg==
X-Forwarded-Encrypted: i=1; AJvYcCVVWZK4DOS0MDflW85HFl85KXWszW1jZaOjUNdcavFNnRmw8tsCYFfrAIvHO3vt0mzWhPUrD9eohLdAC90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkbVjPxght2LSAR0vBUDvx3cMaBjXMDsj2GbcvJcQQTg2LZvIi
	LCqF/sGVtp5uQnIGOCqBDwnoiJvmdE0FQhl3cchemjLLnx9E/I2HSaZdvjNMLeR9LQJJv+jACGP
	t8IHMlPRjkchP/Ruh0iIpaZ+WSqW7MZ2Av92O
X-Gm-Gg: ASbGncswHqzTL+20x/G9Fak1tSITAz3UgB9oBZtZfs6KJX+q7w4eJLBiyQsN1oL3Wt3
	hs369bICa1v0yrWGeqpbGq8D+oSvH
X-Google-Smtp-Source: AGHT+IHDPlGKD2q6YGQSdjniBfbiR7T8Kq/4oaSX8i8I5QFnRnCPMPWSSmT13fQAzrcDFZLSgWNFL5JUY6hLCszbiLs=
X-Received: by 2002:a05:6214:29c2:b0:6d8:9e9d:c223 with SMTP id
 6a1803df08f44-6d89e9dc6demr106752546d6.7.1733167726726; Mon, 02 Dec 2024
 11:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-5-ryncsn@gmail.com>
In-Reply-To: <20241202184154.19321-5-ryncsn@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 2 Dec 2024 11:28:10 -0800
Message-ID: <CAJD7tkaO2AEeNH9b7utqUqgRqWowLtR-Ud09yC0YAhL5RQU5hw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, swap_cgroup: remove global swap cgroup lock
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
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
> +struct swap_cgroup_unit {
> +       union {
> +               int raw;
> +               atomic_t val;
> +               unsigned short __id[ID_PER_UNIT];
> +       };
> +};

This doubles the size of the per-entry data, right?

Why do we need this? I thought cmpxchg() supports multiple sizes and
will already do the emulation for us.

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
>
>         ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
>         map =3D ctrl->map;
>
> -       spin_lock_irqsave(&ctrl->lock, flags);
> -       old =3D map[offset];
> +       old =3D READ_ONCE(map[offset]);
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

