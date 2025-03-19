Return-Path: <linux-kernel+bounces-567323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F57A6848C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB757A7588
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B49520CCE6;
	Wed, 19 Mar 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsP2l423"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB1382
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742361520; cv=none; b=L6MzfEMjxsm4VGUt/AJUiWwY+71xswAjxp4WLAlGTP2vixcBhuIP9kRYbUMWMgleeBko5HtAQmTM6fm1+BX1u9+5G3EMW9Kp5KDl8LkVeotNS9GVZ16dryEspTejVTIjTOm6c9a7CJg9PbJfsStFVZfipfIsSPSKNPz31Fa3/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742361520; c=relaxed/simple;
	bh=4VSO4ZOGKY43XjsmJackT1ArW5LwxV5WGyW4wSHyIk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwzBaQxRcucD8sfwaoHB1YTctP43SptvGTrw7spMMgOqvv9bCFm61LCjXJYJ0HvAcRMuWWGCwamy+GRD3Vdae2PnBuWSDoeww2tFpNJu0AFmiXooWi8KCVBgg0aWhqzFHwV/iLJpKbqpcayeifhzt0ZUmRacZM/TR322oOx/I0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsP2l423; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so56759621fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742361516; x=1742966316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcdHh+ZqJmIjlzhWFYZhMTNXLUfn7HW8EBdWnfguqsg=;
        b=HsP2l423bctr9DAUZMa9uqyuTB3HXSZ7cIxJPEQt3MAorb1dD1caIjPOSfeLk0FosY
         7XmuJTATGJqCnmXDGH1peLlpBaF4EVd1B2tIpaHwIn7Z0nJLczWCTFfcxOYK91u9AhbZ
         kFyOrbJyuf6HHyeMxOTIpI/rQieaXERSxG4Vkfxgt4ve7ZwYgstl0+5bdC+70yGwd/gG
         Po0NuvxfEVkwruv8uaRAGuENB8SmbPL7qwPhgVaWHVLOlZ/rbWBzniCChTM1h1UMIAoC
         l5WpPrqZnouWN6Fy8t2PIzGBGCqpmpO5rzqsCdNLg0YMc6cjcra2RMTZRrFX/EHsVOmH
         UXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742361516; x=1742966316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcdHh+ZqJmIjlzhWFYZhMTNXLUfn7HW8EBdWnfguqsg=;
        b=g8SyDLpIFhnfkUxE6s2ns5gxh/1cztD1hK+jFA+dlznhPOUXXpwl8oLPHQtSEExDU0
         PxgXmEosppvaPxERDBIHiR7Cqa+zhavDAaUHQUzGq8CFvB4iMSqYM1lM0xWiJ6Q6Y0dY
         18EdEavOP0R2YOCcVHlO2sYLti9kmUclClxg0XjUHQUoIx2uTDv09HEOME/ghHN/fPyx
         a1eJC8ZoGgJ37hycxQRTvhJb6Xin7H/84bowUs6lnfuHeyHGSC2uK9iRwy5yzllJ2JjM
         xiV9IKy6+rSqekWwy0U1AwXpYo09X+YAeh/8PSl4PvpMjl/Es1cG4FKx8z2oodjpZlyx
         zJYg==
X-Forwarded-Encrypted: i=1; AJvYcCWJNggZ5OqwkjdIew46VCTexZyjOKn34bYwwk0hYApuLTD2CIvzk90vgojhxSZIOFceFyPxxZ8P4B/UHQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDn2dL5lw5KoYL8uT8FBNwsCFMPD0o0/6Lnhys5YfV/WUc5b6E
	sGX9sO26L5LzEmDxh8Ch3CV6Uf9kbRCdgVC4R59mJDvmBidtzcNzdqv810TYh9K0myQ7w9q0CoV
	e9vHe6sHDKOYRzyQhKzqziak9+t8=
X-Gm-Gg: ASbGnctTYckmvwLCqKTOXTRSHuScaVLHds2ALkKUX3J625enqjB57gru/cROWywy7ZO
	plnwr/FMtOYjk7KG5KR81BHyvK0s8ZkNz734oBm/WSfVOqHe1jNHPq5WlxChsHPcfWoy1n1N5Yn
	fp7rPXgDNKRX/Fy0wshWRIls4xAQ==
X-Google-Smtp-Source: AGHT+IGdIm89bRDmxx8rmw4XgWSt4s1PDbjkyc5EgX7IBl3BSoG0My4/EXOwZwnzzSY+8PHrDGc0nXfmWmNolvRHjj8=
X-Received: by 2002:a05:651c:19a4:b0:30c:467f:cda2 with SMTP id
 38308e7fff4ca-30d6a3c54b5mr5020861fa.10.1742361515916; Tue, 18 Mar 2025
 22:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318150614.6415-1-shikemeng@huaweicloud.com> <20250318150614.6415-3-shikemeng@huaweicloud.com>
In-Reply-To: <20250318150614.6415-3-shikemeng@huaweicloud.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 19 Mar 2025 13:18:19 +0800
X-Gm-Features: AQ5f1JoR1KJI_JDaN2aLJ0kalXS1sxMROQERP5mVGN9MaAMurzFJ0nz6ilMyUV4
Message-ID: <CAMgjq7BR5afYGvKqLXdp7kHB-n+JRxgcsmX-rn+Y9YKY1ZXtTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] mm: swap: remove unneeded VM_BUG_ON(*map !=
 SWAP_HAS_CACHE) in swap_entry_range_free()
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:10=E2=80=AFPM Kemeng Shi <shikemeng@huaweicloud.c=
om> wrote:
>
> As all callers of swap_entry_range_free() have already ensured slots to
> be freed are marked as SWAP_HAS_CACHE while holding the cluster lock,
> the BUG_ON check can be safely removed. After this, the function
> swap_entry_range_free() could drop any kind of last flag, rename it to
> swap_entries_free() and update it's comment accordingly.
>
> This is a preparation to use swap_entries_free() to drop last ref count
> and SWAP_MAP_SHMEM flag.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  mm/swapfile.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5a775456e26c..0aa7ce82c013 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -52,9 +52,9 @@
>  static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
>                                  unsigned char);
>  static void free_swap_count_continuations(struct swap_info_struct *);
> -static void swap_entry_range_free(struct swap_info_struct *si,
> -                                 struct swap_cluster_info *ci,
> -                                 swp_entry_t entry, unsigned int nr_page=
s);
> +static void swap_entries_free(struct swap_info_struct *si,
> +                             struct swap_cluster_info *ci,
> +                             swp_entry_t entry, unsigned int nr_pages);
>  static void swap_range_alloc(struct swap_info_struct *si,
>                              unsigned int nr_entries);
>  static bool folio_swapcache_freeable(struct folio *folio);
> @@ -1463,7 +1463,7 @@ static unsigned char swap_entry_put(struct swap_inf=
o_struct *si,
>         ci =3D lock_cluster(si, offset);
>         usage =3D swap_entry_put_locked(si, offset, 1);
>         if (!usage)
> -               swap_entry_range_free(si, ci, swp_entry(si->type, offset)=
, 1);
> +               swap_entries_free(si, ci, swp_entry(si->type, offset), 1)=
;
>         unlock_cluster(ci);
>
>         return usage;
> @@ -1493,7 +1493,7 @@ static bool swap_entries_put_nr(struct swap_info_st=
ruct *si,
>         for (i =3D 0; i < nr; i++)
>                 WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
>         if (!has_cache)
> -               swap_entry_range_free(si, ci, entry, nr);
> +               swap_entries_free(si, ci, entry, nr);
>         unlock_cluster(ci);
>
>         return has_cache;
> @@ -1512,12 +1512,12 @@ static bool swap_entries_put_nr(struct swap_info_=
struct *si,
>  }
>
>  /*
> - * Drop the last HAS_CACHE flag of swap entries, caller have to
> - * ensure all entries belong to the same cgroup.
> + * Drop the last flag(1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM) of swap entri=
es,
> + * caller have to ensure all entries belong to the same cgroup and clust=
er.
>   */
> -static void swap_entry_range_free(struct swap_info_struct *si,
> -                                 struct swap_cluster_info *ci,
> -                                 swp_entry_t entry, unsigned int nr_page=
s)
> +static void swap_entries_free(struct swap_info_struct *si,
> +                             struct swap_cluster_info *ci,
> +                             swp_entry_t entry, unsigned int nr_pages)
>  {
>         unsigned long offset =3D swp_offset(entry);
>         unsigned char *map =3D si->swap_map + offset;
> @@ -1530,7 +1530,6 @@ static void swap_entry_range_free(struct swap_info_=
struct *si,
>
>         ci->count -=3D nr_pages;
>         do {
> -               VM_BUG_ON(*map !=3D SWAP_HAS_CACHE);

Hi Kemeng

Instead of just dropping this check, maybe it's better to change it to
something like VM_BUG_ON(!*map); to catch potential SWAP double free?
I've found this check very helpful for debugging, especially for
catching concurrency problems.

Or more strictly: VM_BUG_ON(*map !=3D  SWAP_HAS_CACHE && *map !=3D 1 &&
*map !=3D SWAP_MAP_SHMEM);, you may introduce a helper to check if a
entry is the "last map" like this and use it somewhere else too.


>                 *map =3D 0;
>         } while (++map < map_end);
>
> @@ -1553,7 +1552,7 @@ static void cluster_swap_free_nr(struct swap_info_s=
truct *si,
>         ci =3D lock_cluster(si, offset);
>         do {
>                 if (!swap_entry_put_locked(si, offset, usage))
> -                       swap_entry_range_free(si, ci, swp_entry(si->type,=
 offset), 1);
> +                       swap_entries_free(si, ci, swp_entry(si->type, off=
set), 1);
>         } while (++offset < end);
>         unlock_cluster(ci);
>  }
> @@ -1596,11 +1595,11 @@ void put_swap_folio(struct folio *folio, swp_entr=
y_t entry)
>
>         ci =3D lock_cluster(si, offset);
>         if (swap_only_has_cache(si, offset, size))
> -               swap_entry_range_free(si, ci, entry, size);
> +               swap_entries_free(si, ci, entry, size);
>         else {
>                 for (int i =3D 0; i < size; i++, entry.val++) {
>                         if (!swap_entry_put_locked(si, offset + i, SWAP_H=
AS_CACHE))
> -                               swap_entry_range_free(si, ci, entry, 1);
> +                               swap_entries_free(si, ci, entry, 1);
>                 }
>         }
>         unlock_cluster(ci);
> --
> 2.30.0
>

