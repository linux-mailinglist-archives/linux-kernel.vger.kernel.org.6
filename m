Return-Path: <linux-kernel+bounces-428260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6888C9E0D08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E74B2DE8E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81F31DE4D4;
	Mon,  2 Dec 2024 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZsBWoSG"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4E1DE3DF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167572; cv=none; b=SZjjAxwbxGQbcRtaiMF6RR7Thci5pBskb2R9/z5HRn6Lw+87XO2h2OUiGQADbEFbPPmsMpmXUyT0FhPcGpYDXjRVF9rZtObSNp5zwKeJiQSeGEsuGRPdtF4L0OhX9NkT/Z4rtbJIz3KPkHHrsRuOOT2F5PACotSYsMiU+YJS3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167572; c=relaxed/simple;
	bh=o3oFpN5+0icf2Kch71ra+GrrBdKQ7MoFph2ESAD4b3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sm+cDVrdU7c3X5bg+O7URhCyIPiaKqFtJk7kZJL88z1aDR4lPEfoOzxk092yVkkltD/X79HDSCe6qeLijdINdaTgglzUmZ1TgE98Uk3rsW0XkVc9MA+8cejJYglooHl/mh+fVsFhsPLNmG/Wn+X56YkJtpEML7JpP/IsIsxSqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZsBWoSG; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d888c38841so25661576d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733167569; x=1733772369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kWp+b2vAKxwZc2Adf1FEMAvh7npem3wGK6470DLZVY=;
        b=YZsBWoSG/cx3MHG4wOmW/S9ucGdHJzymJogbnzXMowtF7DL2aZnzGcrAujQCsH+U8N
         ELGUJwdSwNqjK8IeSyPKWQir55kvy3Zm6C5fVCRBvUNO4332VYMNe8bkoYcVQdDBvFXU
         rL5HXlYJLrjgIorxsEtVqzVfa+E/MCw/jp2UzumDgk1qmsQEaapuU0/PVig2VYPIuck7
         SE9u4TZq51yQAJndYjBilxvwrfS+web6ZzI8Mga4MVKOG+vOX0HSGT2jONuDDRF/Kxh2
         /9ZuFtUPJ33GeC7PZ0mVmmEZ4/WT7COVCe4QiLxE2hRv0/ia4sRuSqiI/y/nh7KBDFkN
         IW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167569; x=1733772369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kWp+b2vAKxwZc2Adf1FEMAvh7npem3wGK6470DLZVY=;
        b=b+B+Wm4GbDR57ahh0dB1xGWLnpvgr7N2yRaUWOnQr7hsaBenlAT9Fg+QoWIQQhHDBh
         ahy/4dwUvE3kaHRpFdktffx9XffNkSpGAK8laYBoEUd86GTEHIQzThIVWxXiT8i/CcQU
         HkssVIF9uNgpEL5R2LJSO92E1RDUOX+mrlCSv7oii9TMFeA5BZaKzVikTyfxHmmmoxVN
         OOl3+Xvmp0iOoz8NzD1MZizWFfEztHX8xtwrMUcW4RsGeyR/jZEXpI1doy9tMBD1ruda
         c599p2b93NlJD8oZu7/cmzEv9Qf2WT6p0rWEINrILmnPaBWYlOZZBt3YMwWxIFdwxLB5
         6Zmw==
X-Forwarded-Encrypted: i=1; AJvYcCX6IqRq6Wejau1iYJEAAOvmXIrQhAmrxTrrDdtdha0P0Fj7rT7dPd80wvnpoGgnhzTMLjsP3BdVyi1KglM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3JdWOTFWNV3V0UduROXaOWMwUgjiYHnNJ9Xa5Q7h15FS/sUAr
	oSLXreXFMVn7VGjW49SA2kAM0aRGzGNNfVUutuk2S6Y7wdpgNu5DX2DzHotwH3fYszOaGf1Uj6o
	K+t7O8+ei6u0JMGw1MB1hesxxwBDLuaJI2Ax9
X-Gm-Gg: ASbGnculRLrkfDOXbBtOO7xUDkqN0y9YehPh9g92iFy370I5om6TyIBbiXgvfYHmTtu
	mKwoBoW+c/xbuJbSq8qKt8p6sqYpZ
X-Google-Smtp-Source: AGHT+IH63gD0V9cyca6pGe0rkEWNUsWMypkh7ldUNn7dEp9D+W12/cWnl/an8g4+ohud5nI3LvTbL6azXYZGZT9KKjY=
X-Received: by 2002:a05:6214:482:b0:6d4:1f86:b1e6 with SMTP id
 6a1803df08f44-6d864d44715mr350526716d6.22.1733167569122; Mon, 02 Dec 2024
 11:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-4-ryncsn@gmail.com>
In-Reply-To: <20241202184154.19321-4-ryncsn@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 2 Dec 2024 11:25:32 -0800
Message-ID: <CAJD7tkarH0G_5oYOY56Erz_4kqAEBrqnxkW6Q+jRCAfj+zt6eA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/swap_cgroup: simplify swap cgroup definitions
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
> Remove the intermediate struct swap_cgroup, it just a unsigned short
> wrapper, simplify the code.

Did you actually remove the struct? It doesn't seem like it.

>
> Also zero the map on initialization to prevent unexpected behaviour as
> swap cgroup helpers are suppose to return 0 on error.

All the callers lookup the id of an already swapped out page, so it
should never be uninitialized. Maybe we should WARN if the result of
the lookup is 0 in this case?

>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_cgroup.c | 45 +++++++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
>
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index 1770b076f6b7..a76afdc3666a 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -12,14 +12,12 @@ struct swap_cgroup {
>  };
>
>  struct swap_cgroup_ctrl {
> -       struct swap_cgroup *map;
> +       unsigned short  *map;
>         spinlock_t      lock;
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
> @@ -33,18 +31,6 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SW=
APFILES];
>   *
>   * TODO: we can push these buffers out to HIGHMEM.
>   */
> -static struct swap_cgroup *lookup_swap_cgroup(swp_entry_t ent,
> -                                       struct swap_cgroup_ctrl **ctrlp)
> -{
> -       pgoff_t offset =3D swp_offset(ent);
> -       struct swap_cgroup_ctrl *ctrl;
> -
> -       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> -       if (ctrlp)
> -               *ctrlp =3D ctrl;
> -       return &ctrl->map[offset];
> -}
> -
>  /**
>   * swap_cgroup_record - record mem_cgroup for a set of swap entries
>   * @ent: the first swap entry to be recorded into
> @@ -58,20 +44,21 @@ unsigned short swap_cgroup_record(swp_entry_t ent, un=
signed short id,
>                                   unsigned int nr_ents)
>  {
>         struct swap_cgroup_ctrl *ctrl;
> -       struct swap_cgroup *sc;
> +       unsigned short *map;
>         unsigned short old;
>         unsigned long flags;
>         pgoff_t offset =3D swp_offset(ent);
>         pgoff_t end =3D offset + nr_ents;
>
> -       sc =3D lookup_swap_cgroup(ent, &ctrl);
> +       ctrl =3D &swap_cgroup_ctrl[swp_type(ent)];
> +       map =3D ctrl->map;
>
>         spin_lock_irqsave(&ctrl->lock, flags);
> -       old =3D sc->id;
> -       for (; offset < end; offset++, sc++) {
> -               VM_BUG_ON(sc->id !=3D old);
> -               sc->id =3D id;
> -       }
> +       old =3D map[offset];
> +       do {
> +               VM_BUG_ON(map[offset] !=3D old);
> +               map[offset] =3D id;
> +       } while (++offset !=3D end);

Why did you change the for loop here?

>         spin_unlock_irqrestore(&ctrl->lock, flags);
>
>         return old;
> @@ -85,20 +72,26 @@ unsigned short swap_cgroup_record(swp_entry_t ent, un=
signed short id,
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
> +       pgoff_t offset =3D swp_offset(ent);
> +
> +       return READ_ONCE(ctrl->map[offset]);

The READ_ONCE() does not exist today in lookup_swap_cgroup(). Why is it nee=
ded?

>  }
>
>  int swap_cgroup_swapon(int type, unsigned long max_pages)
>  {
> -       struct swap_cgroup *map;
> +       void *map;
>         struct swap_cgroup_ctrl *ctrl;
>
>         if (mem_cgroup_disabled())
>                 return 0;
>
> -       map =3D vcalloc(max_pages, sizeof(struct swap_cgroup));
> +       map =3D vzalloc(max_pages * sizeof(unsigned short));
>         if (!map)
>                 goto nomem;
>
> @@ -117,7 +110,7 @@ int swap_cgroup_swapon(int type, unsigned long max_pa=
ges)
>
>  void swap_cgroup_swapoff(int type)
>  {
> -       struct swap_cgroup *map;
> +       void *map;

Why void?

>         struct swap_cgroup_ctrl *ctrl;
>
>         if (mem_cgroup_disabled())
> --
> 2.47.0
>

