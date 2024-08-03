Return-Path: <linux-kernel+bounces-273431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D094692C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85930B2167E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3EF13A242;
	Sat,  3 Aug 2024 10:57:20 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AE135417
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682639; cv=none; b=HORQstFqrerBddqkirhNoyaJUXiUOB2UhyL8waHKXtubfrjRYh5yFYAkZLI3GfMPZvietlbtgSDs3gY/VJPiF+35CASQvR7LstHw+c03Q+IUpjRsygeJh75zjI/v/hXuO3Xx4Oyt/j06CAibiq/uz25WWaqjkz3DpciWK+L8zA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682639; c=relaxed/simple;
	bh=luoKbgZfu0feIeIeaxQCHBtRwmeTHLi1jCpAv3Rv/dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1NkYIA4Jsl1ZXwONpHCelMU1zWVBsJ7wfIMQ3owklGSOC8REWgVVk4fPL8kiQpP27gwAl67aNp6ViygdfpjCIeYMgKux9wNAYvIvKCv3C08hGvDu0TPtcyR9Ps0mqtnvzDgFXRm+s+B+OAyDgBAb0n1oLNtq3U6ycVs8oG2ln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4929754aee9so1951090137.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 03:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722682636; x=1723287436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3gycogCNf/Ydh3QW7k4kTbyy8kxDZNintYR40hSSM8=;
        b=eNgLJ0fChi/kShXaRM8iEGeLY4n6p3EcvrZy3qdxd8eafJwTfjux7HPd4rGm/EJsUv
         /8L+5D6gOky/0nU9kIfBhNfRI+i5ZUrHCP3jiHac2mFsr/paiFoX6lfEhV2qqRLL8pxY
         SDZNk0KKz2Z1Gzjm/OvSn3qNk49tmv8TiQB2+PBXPzIInnTO6I4A8nz1Mz3G39WAwGgP
         mCdkKynqh2hzV2ATRpOvvLmkKhddOPe7/E9WSeim+gO2DHjXFKK+3fzf8kjFKVhQ7QHg
         1vp3+ISP4DaSmdqdzA06Dmiv1bVYJA58AYWZwracBar9XG2fR38JXM36aj/cVw6ahp2R
         7qig==
X-Forwarded-Encrypted: i=1; AJvYcCVuReeZZSgqwIsKRfT129giRQetPdmFD3yNknTT9cnapIecrRVxyAA1kjKPCba5XrDvO0VoymDIS98wxm8qBXUFaeP9Q4ufpqjiUDnX
X-Gm-Message-State: AOJu0Yw0gzLTg0QPCNgTgBbrUVDb5PnMA2VktIDIlJl/FvMZzpLhHy53
	/APlFewUupcCd4vF56Azd9SATs6YLvlNqLJjeoGs1kTw2zKKk54fXeCeHS4s2GGlv0tFC2RR6rN
	16jvNzzEepc6YoPm1GlX4BKUC1Dk=
X-Google-Smtp-Source: AGHT+IGI8H27B7+GjJSoyZnw1NjMlWP14PChzaAB7wTYhC5mW0hqZf3wzGJ5TTP6frQT4/WiYz4fweWWtgb319Hfm9w=
X-Received: by 2002:a05:6102:f10:b0:48f:40c1:3cd0 with SMTP id
 ada2fe7eead31-4945be0bbbdmr6461553137.12.1722682636380; Sat, 03 Aug 2024
 03:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-5-cb9c148b9297@kernel.org> <20240803091118.84274-1-21cnbao@gmail.com>
In-Reply-To: <20240803091118.84274-1-21cnbao@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 3 Aug 2024 22:57:05 +1200
Message-ID: <CAGsJ_4wPnQqKOHx6iQcwO8bQzoBXKr2qY2AgSxMwTQCj3-8YWw@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] mm: swap: skip slot cache on freeing for mTHP
To: chrisl@kernel.org
Cc: akpm@linux-foundation.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, ying.huang@intel.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 9:11=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Wed, Jul 31, 2024 at 6:49=E2=80=AFPM <chrisl@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently when we are freeing mTHP folios from swap cache, we free
> > then one by one and put each entry into swap slot cache. Slot
> > cache is designed to reduce the overhead by batching the freeing,
> > but mTHP swap entries are already continuous so they can be batch
> > freed without it already, it saves litle overhead, or even increase
> > overhead for larger mTHP.
> >
> > What's more, mTHP entries could stay in swap cache for a while.
> > Contiguous swap entry is an rather rare resource so releasing them
> > directly can help improve mTHP allocation success rate when under
> > pressure.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Acked-by: Barry Song <baohua@kernel.org>
>
> I believe this is the right direction to take. Currently, entries are rel=
eased
> one by one, even when they are contiguous in the swap file(those nr_pages
> entries are definitely in the same cluster and same si), leading to numer=
ous
> lock and unlock operations.
> This approach provides batched support.
>
> free_swap_and_cache_nr() has the same issue, so I drafted a patch based o=
n
> your code. I wonder if you can also help test and review before I send it
> officially:
>
> From 4bed5c08bc0f7769ee2849812acdad70c4e32ead Mon Sep 17 00:00:00 2001
> From: Barry Song <v-songbaohua@oppo.com>
> Date: Sat, 3 Aug 2024 20:21:14 +1200
> Subject: [PATCH RFC] mm: attempt to batch free swap entries for zap_pte_r=
ange()
>
> Zhiguo reported that swap release could be a serious bottleneck
> during process exits[1]. With mTHP, we have the opportunity to
> batch free swaps.
> Thanks to the work of Chris and Kairui[2], I was able to achieve
> this optimization with minimal code changes by building on their
> efforts.
>
> [1] https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@viv=
o.com/
> [2] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148=
b9297@kernel.org/
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/swapfile.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ea023fc25d08..9def6dba8d26 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_struc=
t *si,
>         return true;
>  }
>
> +static bool swap_is_last_map(struct swap_info_struct *si,
> +                             unsigned long offset, int nr_pages,
> +                             bool *any_only_cache)
> +{
> +       unsigned char *map =3D si->swap_map + offset;
> +       unsigned char *map_end =3D map + nr_pages;
> +       bool cached =3D false;
> +
> +       do {
> +               if ((*map & ~SWAP_HAS_CACHE) !=3D 1)
> +                       return false;
> +               if (*map & SWAP_HAS_CACHE)
> +                       cached =3D true;
> +       } while (++map < map_end);
> +
> +       *any_only_cache =3D cached;
> +       return true;
> +}
> +
>  /*
>   * returns number of pages in the folio that backs the swap entry. If po=
sitive,
>   * the folio was reclaimed. If negative, the folio was not reclaimed. If=
 0, no
> @@ -1808,6 +1827,29 @@ void free_swap_and_cache_nr(swp_entry_t entry, int=
 nr)
>         if (WARN_ON(end_offset > si->max))
>                 goto out;
>
> +       if (nr > 1) {
> +               struct swap_cluster_info *ci;
> +               bool batched_free;
> +               int i;
> +
> +               ci =3D lock_cluster_or_swap_info(si, start_offset);
> +               if ((batched_free =3D swap_is_last_map(si, start_offset, =
nr, &any_only_cache))) {
> +                       for (i =3D 0; i < nr; i++)
> +                               WRITE_ONCE(si->swap_map[start_offset + i]=
, SWAP_HAS_CACHE);
> +               }
> +               unlock_cluster_or_swap_info(si, ci);
> +
> +               if (batched_free) {
> +                       spin_lock(&si->lock);
> +                       pr_err("%s offset:%lx nr:%lx\n", __func__,start_o=
ffset, nr);
> +                       swap_entry_range_free(si, entry, nr);
> +                       spin_unlock(&si->lock);
> +                       if (any_only_cache)
> +                               goto reclaim;
> +                       goto out;
> +               }

Sorry, what I actually meant was that the two gotos are reversed.

                if (batched_free) {
                        if (any_only_cache)
                                goto reclaim;

                        spin_lock(&si->lock);
                        swap_entry_range_free(si, entry, nr);
                        spin_unlock(&si->lock);
                        goto out;
                }

> +       }
> +
>         /*
>          * First free all entries in the range.
>          */
> @@ -1828,6 +1870,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int =
nr)
>         if (!any_only_cache)
>                 goto out;
>
> +reclaim:
>         /*
>          * Now go back over the range trying to reclaim the swap cache. T=
his is
>          * more efficient for large folios because we will only try to re=
claim
> --
> 2.34.1
>
>
>
> > ---
> >  mm/swapfile.c | 59 ++++++++++++++++++++++++++-------------------------=
--------
> >  1 file changed, 26 insertions(+), 33 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 34e6ea13e8e4..9b63b2262cc2 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -479,20 +479,21 @@ static void inc_cluster_info_page(struct swap_inf=
o_struct *p,
> >  }
> >
> >  /*
> > - * The cluster ci decreases one usage. If the usage counter becomes 0,
> > + * The cluster ci decreases @nr_pages usage. If the usage counter beco=
mes 0,
> >   * which means no page in the cluster is in use, we can optionally dis=
card
> >   * the cluster and add it to free cluster list.
> >   */
> > -static void dec_cluster_info_page(struct swap_info_struct *p, struct s=
wap_cluster_info *ci)
> > +static void dec_cluster_info_page(struct swap_info_struct *p,
> > +                                 struct swap_cluster_info *ci, int nr_=
pages)
> >  {
> >         if (!p->cluster_info)
> >                 return;
> >
> > -       VM_BUG_ON(ci->count =3D=3D 0);
> > +       VM_BUG_ON(ci->count < nr_pages);
> >         VM_BUG_ON(cluster_is_free(ci));
> >         lockdep_assert_held(&p->lock);
> >         lockdep_assert_held(&ci->lock);
> > -       ci->count--;
> > +       ci->count -=3D nr_pages;
> >
> >         if (!ci->count) {
> >                 free_cluster(p, ci);
> > @@ -998,19 +999,6 @@ static int scan_swap_map_slots(struct swap_info_st=
ruct *si,
> >         return n_ret;
> >  }
> >
> > -static void swap_free_cluster(struct swap_info_struct *si, unsigned lo=
ng idx)
> > -{
> > -       unsigned long offset =3D idx * SWAPFILE_CLUSTER;
> > -       struct swap_cluster_info *ci;
> > -
> > -       ci =3D lock_cluster(si, offset);
> > -       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> > -       ci->count =3D 0;
> > -       free_cluster(si, ci);
> > -       unlock_cluster(ci);
> > -       swap_range_free(si, offset, SWAPFILE_CLUSTER);
> > -}
> > -
> >  int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_or=
der)
> >  {
> >         int order =3D swap_entry_order(entry_order);
> > @@ -1269,21 +1257,28 @@ static unsigned char __swap_entry_free(struct s=
wap_info_struct *p,
> >         return usage;
> >  }
> >
> > -static void swap_entry_free(struct swap_info_struct *p, swp_entry_t en=
try)
> > +/*
> > + * Drop the last HAS_CACHE flag of swap entries, caller have to
> > + * ensure all entries belong to the same cgroup.
> > + */
> > +static void swap_entry_range_free(struct swap_info_struct *p, swp_entr=
y_t entry,
> > +                                 unsigned int nr_pages)
> >  {
> > -       struct swap_cluster_info *ci;
> >         unsigned long offset =3D swp_offset(entry);
> > -       unsigned char count;
> > +       unsigned char *map =3D p->swap_map + offset;
> > +       unsigned char *map_end =3D map + nr_pages;
> > +       struct swap_cluster_info *ci;
> >
> >         ci =3D lock_cluster(p, offset);
> > -       count =3D p->swap_map[offset];
> > -       VM_BUG_ON(count !=3D SWAP_HAS_CACHE);
> > -       p->swap_map[offset] =3D 0;
> > -       dec_cluster_info_page(p, ci);
> > +       do {
> > +               VM_BUG_ON(*map !=3D SWAP_HAS_CACHE);
> > +               *map =3D 0;
> > +       } while (++map < map_end);
> > +       dec_cluster_info_page(p, ci, nr_pages);
> >         unlock_cluster(ci);
> >
> > -       mem_cgroup_uncharge_swap(entry, 1);
> > -       swap_range_free(p, offset, 1);
> > +       mem_cgroup_uncharge_swap(entry, nr_pages);
> > +       swap_range_free(p, offset, nr_pages);
> >  }
> >
> >  static void cluster_swap_free_nr(struct swap_info_struct *sis,
> > @@ -1343,7 +1338,6 @@ void swap_free_nr(swp_entry_t entry, int nr_pages=
)
> >  void put_swap_folio(struct folio *folio, swp_entry_t entry)
> >  {
> >         unsigned long offset =3D swp_offset(entry);
> > -       unsigned long idx =3D offset / SWAPFILE_CLUSTER;
> >         struct swap_cluster_info *ci;
> >         struct swap_info_struct *si;
> >         unsigned char *map;
> > @@ -1356,19 +1350,18 @@ void put_swap_folio(struct folio *folio, swp_en=
try_t entry)
> >                 return;
> >
> >         ci =3D lock_cluster_or_swap_info(si, offset);
> > -       if (size =3D=3D SWAPFILE_CLUSTER) {
> > +       if (size > 1) {
> >                 map =3D si->swap_map + offset;
> > -               for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
> > +               for (i =3D 0; i < size; i++) {
> >                         val =3D map[i];
> >                         VM_BUG_ON(!(val & SWAP_HAS_CACHE));
> >                         if (val =3D=3D SWAP_HAS_CACHE)
> >                                 free_entries++;
> >                 }
> > -               if (free_entries =3D=3D SWAPFILE_CLUSTER) {
> > +               if (free_entries =3D=3D size) {
> >                         unlock_cluster_or_swap_info(si, ci);
> >                         spin_lock(&si->lock);
> > -                       mem_cgroup_uncharge_swap(entry, SWAPFILE_CLUSTE=
R);
> > -                       swap_free_cluster(si, idx);
> > +                       swap_entry_range_free(si, entry, size);
> >                         spin_unlock(&si->lock);
> >                         return;
> >                 }
> > @@ -1413,7 +1406,7 @@ void swapcache_free_entries(swp_entry_t *entries,=
 int n)
> >         for (i =3D 0; i < n; ++i) {
> >                 p =3D swap_info_get_cont(entries[i], prev);
> >                 if (p)
> > -                       swap_entry_free(p, entries[i]);
> > +                       swap_entry_range_free(p, entries[i], 1);
> >                 prev =3D p;
> >         }
> >         if (p)
> >
> > --
> > 2.46.0.rc1.232.g9752f9e123-goog
> >
>
> Thanks
> Barry
>

