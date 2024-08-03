Return-Path: <linux-kernel+bounces-273423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8C5946915
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C801C20FF2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B40314D6E6;
	Sat,  3 Aug 2024 10:38:58 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67787173C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722681537; cv=none; b=ehLGA7FCvXhvmhDlIzIr4lMUnfx/N4+xHQ4vxtqkwASCvQjz2Uyw2x3cm9c+tDNkEDCWFuKrHeb9bIUCxA42sCquK1P2eD60FNePZj1nicBUY4N8zw7MXQQTHgSw8CEcqe5EDk0J+vJzdYCWYAnorAdmuCVji4t7wZd2EnalbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722681537; c=relaxed/simple;
	bh=n0RLKhtqXPqPBkPDsMsC0STMXfcsgdoXZxapptAhMB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3RgUjBD59M/JqCP2TKB1ESYke8eTDnWTBFn7ceOM82RqKDBL5AbAcSsSER0O23aNDUArZbdgYVnmHEnqiESwwjfmYi6k9oGPJv3pj80kL6PjW2k1LZDnBBZpVilUmHzn+lP5Il8Tcy664dTm3HQxnJoKSgamBU14IPKmQAcR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-493e8ef36b4so2502784137.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 03:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722681535; x=1723286335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muAGmuHbBXdTRByfVV7oFSS1BtcMM0muLKhOERFMDxI=;
        b=E6Q7uRYLwJ6xIGkdT3kfAHKmLJWrVs87A1piTOS/5lU08sSAiDFQunVnRJPwn5mXNB
         onkQxKyJM9xNRPS+hUoFcn8ATpgoaMNTCJg4Uf9sntRbjOUSd+W8kErbsgxxtJk4oABq
         QKxb31VHtybEDiiWtUxEFGDoTMmSY1M6wg6niXZs1UsAs8NoUxrNd5lZ3p/Fdy9Gdfpy
         mOupMOk0MfPibCdhZxQEmcSHgFeURbTyKnWqiBmAkEsKNU54oWxF87DsQrXhfHBMcf4H
         j2AiqVGDzJ1sPrxe9JuRKvXyP7v1KuGvDBIOrl2LHdDBUZjexsty5J8Q5Q6iKiOGR0LF
         v7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJZHB9L934Q5xRzY1tRK3XCSDeUsQz1S01/z6Oi0wqbsdjnOulaB7JMRH/soXliVT+QgFyaHGiERVRzTyPuJApTpB9v1nGKqW8TqAF
X-Gm-Message-State: AOJu0YxPdeTPBLNoQxuch9pAcwUs7HE8ZOM59o5sKRyeXxBLJM6+tEjE
	O31CJe0LvS9COrb5L3Q3bnCHuvDBVZ5h74Jny/5yKnf8HgdDxuIbep0eFpiglMsKBBexoZQCrJ2
	7o4dUhe11ngSZpRXhdooBSAoYTWw=
X-Google-Smtp-Source: AGHT+IH0h0yRvr9dorbI2WUOUQi38WG0jp3pdwv+elWfjFPN0q+34vtYRmxMPsA1qDeVgws4ae225mgiokXN5NQne+c=
X-Received: by 2002:a05:6102:d8f:b0:493:b0c2:ad3c with SMTP id
 ada2fe7eead31-4945bed096cmr9467619137.22.1722681534511; Sat, 03 Aug 2024
 03:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org> <20240730-swap-allocator-v5-6-cb9c148b9297@kernel.org>
In-Reply-To: <20240730-swap-allocator-v5-6-cb9c148b9297@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Sat, 3 Aug 2024 18:38:41 +0800
Message-ID: <CAGsJ_4zsUCN2vgN6kgPmWZiORgH2d9g8h9kLBYsL+hVQRZhHCg@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] mm: swap: allow cache reclaim to skip slot cache
To: chrisl@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:49=E2=80=AFPM <chrisl@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Currently we free the reclaimed slots through slot cache even
> if the slot is required to be empty immediately. As a result
> the reclaim caller will see the slot still occupied even after a
> successful reclaim, and need to keep reclaiming until slot cache
> get flushed. This caused ineffective or over reclaim when SWAP is
> under stress.
>
> So introduce a new flag allowing the slot to be emptied bypassing
> the slot cache.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 152 +++++++++++++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 109 insertions(+), 43 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9b63b2262cc2..4c0fc0409d3c 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -53,8 +53,15 @@
>  static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
>                                  unsigned char);
>  static void free_swap_count_continuations(struct swap_info_struct *);
> +static void swap_entry_range_free(struct swap_info_struct *si, swp_entry=
_t entry,
> +                                 unsigned int nr_pages);
>  static void swap_range_alloc(struct swap_info_struct *si, unsigned long =
offset,
>                              unsigned int nr_entries);
> +static bool folio_swapcache_freeable(struct folio *folio);
> +static struct swap_cluster_info *lock_cluster_or_swap_info(
> +               struct swap_info_struct *si, unsigned long offset);
> +static void unlock_cluster_or_swap_info(struct swap_info_struct *si,
> +                                       struct swap_cluster_info *ci);
>
>  static DEFINE_SPINLOCK(swap_lock);
>  static unsigned int nr_swapfiles;
> @@ -129,8 +136,25 @@ static inline unsigned char swap_count(unsigned char=
 ent)
>   * corresponding page
>   */
>  #define TTRS_UNMAPPED          0x2
> -/* Reclaim the swap entry if swap is getting full*/
> +/* Reclaim the swap entry if swap is getting full */
>  #define TTRS_FULL              0x4
> +/* Reclaim directly, bypass the slot cache and don't touch device lock *=
/
> +#define TTRS_DIRECT            0x8
> +
> +static bool swap_is_has_cache(struct swap_info_struct *si,
> +                             unsigned long offset, int nr_pages)
> +{
> +       unsigned char *map =3D si->swap_map + offset;
> +       unsigned char *map_end =3D map + nr_pages;
> +
> +       do {
> +               VM_BUG_ON(!(*map & SWAP_HAS_CACHE));
> +               if (*map !=3D SWAP_HAS_CACHE)
> +                       return false;
> +       } while (++map < map_end);
> +
> +       return true;
> +}
>
>  /*
>   * returns number of pages in the folio that backs the swap entry. If po=
sitive,
> @@ -141,12 +165,22 @@ static int __try_to_reclaim_swap(struct swap_info_s=
truct *si,
>                                  unsigned long offset, unsigned long flag=
s)
>  {
>         swp_entry_t entry =3D swp_entry(si->type, offset);
> +       struct address_space *address_space =3D swap_address_space(entry)=
;
> +       struct swap_cluster_info *ci;
>         struct folio *folio;
> -       int ret =3D 0;
> +       int ret, nr_pages;
> +       bool need_reclaim;
>
> -       folio =3D filemap_get_folio(swap_address_space(entry), swap_cache=
_index(entry));
> +       folio =3D filemap_get_folio(address_space, swap_cache_index(entry=
));
>         if (IS_ERR(folio))
>                 return 0;
> +
> +       /* offset could point to the middle of a large folio */
> +       entry =3D folio->swap;
> +       offset =3D swp_offset(entry);
> +       nr_pages =3D folio_nr_pages(folio);
> +       ret =3D -nr_pages;
> +
>         /*
>          * When this function is called from scan_swap_map_slots() and it=
's
>          * called by vmscan.c at reclaiming folios. So we hold a folio lo=
ck
> @@ -154,14 +188,50 @@ static int __try_to_reclaim_swap(struct swap_info_s=
truct *si,
>          * case and you should use folio_free_swap() with explicit folio_=
lock()
>          * in usual operations.
>          */
> -       if (folio_trylock(folio)) {
> -               if ((flags & TTRS_ANYWAY) ||
> -                   ((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
> -                   ((flags & TTRS_FULL) && mem_cgroup_swap_full(folio)))
> -                       ret =3D folio_free_swap(folio);
> -               folio_unlock(folio);
> +       if (!folio_trylock(folio))
> +               goto out;
> +
> +       need_reclaim =3D ((flags & TTRS_ANYWAY) ||
> +                       ((flags & TTRS_UNMAPPED) && !folio_mapped(folio))=
 ||
> +                       ((flags & TTRS_FULL) && mem_cgroup_swap_full(foli=
o)));
> +       if (!need_reclaim || !folio_swapcache_freeable(folio))
> +               goto out_unlock;
> +
> +       /*
> +        * It's safe to delete the folio from swap cache only if the foli=
o's
> +        * swap_map is HAS_CACHE only, which means the slots have no page=
 table
> +        * reference or pending writeback, and can't be allocated to othe=
rs.
> +        */
> +       ci =3D lock_cluster_or_swap_info(si, offset);
> +       need_reclaim =3D swap_is_has_cache(si, offset, nr_pages);
> +       unlock_cluster_or_swap_info(si, ci);
> +       if (!need_reclaim)
> +               goto out_unlock;
> +
> +       if (!(flags & TTRS_DIRECT)) {
> +               /* Free through slot cache */
> +               delete_from_swap_cache(folio);
> +               folio_set_dirty(folio);
> +               ret =3D nr_pages;
> +               goto out_unlock;
>         }
> -       ret =3D ret ? folio_nr_pages(folio) : -folio_nr_pages(folio);
> +
> +       xa_lock_irq(&address_space->i_pages);
> +       __delete_from_swap_cache(folio, entry, NULL);
> +       xa_unlock_irq(&address_space->i_pages);
> +       folio_ref_sub(folio, nr_pages);
> +       folio_set_dirty(folio);
> +
> +       spin_lock(&si->lock);
> +       /* Only sinple page folio can be backed by zswap */
> +       if (!nr_pages)
> +               zswap_invalidate(entry);

I am trying to figure out if I am mad :-)  Does nr_pages =3D=3D 0 means sin=
gle
page folio?

> +       swap_entry_range_free(si, entry, nr_pages);
> +       spin_unlock(&si->lock);
> +       ret =3D nr_pages;
> +out_unlock:
> +       folio_unlock(folio);
> +out:
>         folio_put(folio);
>         return ret;
>  }
> @@ -903,7 +973,7 @@ static int scan_swap_map_slots(struct swap_info_struc=
t *si,
>         if (vm_swap_full() && si->swap_map[offset] =3D=3D SWAP_HAS_CACHE)=
 {
>                 int swap_was_freed;
>                 spin_unlock(&si->lock);
> -               swap_was_freed =3D __try_to_reclaim_swap(si, offset, TTRS=
_ANYWAY);
> +               swap_was_freed =3D __try_to_reclaim_swap(si, offset, TTRS=
_ANYWAY | TTRS_DIRECT);
>                 spin_lock(&si->lock);
>                 /* entry was freed successfully, try to use this again */
>                 if (swap_was_freed > 0)
> @@ -1340,9 +1410,6 @@ void put_swap_folio(struct folio *folio, swp_entry_=
t entry)
>         unsigned long offset =3D swp_offset(entry);
>         struct swap_cluster_info *ci;
>         struct swap_info_struct *si;
> -       unsigned char *map;
> -       unsigned int i, free_entries =3D 0;
> -       unsigned char val;
>         int size =3D 1 << swap_entry_order(folio_order(folio));
>
>         si =3D _swap_info_get(entry);
> @@ -1350,23 +1417,14 @@ void put_swap_folio(struct folio *folio, swp_entr=
y_t entry)
>                 return;
>
>         ci =3D lock_cluster_or_swap_info(si, offset);
> -       if (size > 1) {
> -               map =3D si->swap_map + offset;
> -               for (i =3D 0; i < size; i++) {
> -                       val =3D map[i];
> -                       VM_BUG_ON(!(val & SWAP_HAS_CACHE));
> -                       if (val =3D=3D SWAP_HAS_CACHE)
> -                               free_entries++;
> -               }
> -               if (free_entries =3D=3D size) {
> -                       unlock_cluster_or_swap_info(si, ci);
> -                       spin_lock(&si->lock);
> -                       swap_entry_range_free(si, entry, size);
> -                       spin_unlock(&si->lock);
> -                       return;
> -               }
> +       if (size > 1 && swap_is_has_cache(si, offset, size)) {
> +               unlock_cluster_or_swap_info(si, ci);
> +               spin_lock(&si->lock);
> +               swap_entry_range_free(si, entry, size);
> +               spin_unlock(&si->lock);
> +               return;
>         }
> -       for (i =3D 0; i < size; i++, entry.val++) {
> +       for (int i =3D 0; i < size; i++, entry.val++) {
>                 if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CA=
CHE)) {
>                         unlock_cluster_or_swap_info(si, ci);
>                         free_swap_slot(entry);
> @@ -1526,16 +1584,7 @@ static bool folio_swapped(struct folio *folio)
>         return swap_page_trans_huge_swapped(si, entry, folio_order(folio)=
);
>  }
>
> -/**
> - * folio_free_swap() - Free the swap space used for this folio.
> - * @folio: The folio to remove.
> - *
> - * If swap is getting full, or if there are no more mappings of this fol=
io,
> - * then call folio_free_swap to free its swap space.
> - *
> - * Return: true if we were able to release the swap space.
> - */
> -bool folio_free_swap(struct folio *folio)
> +static bool folio_swapcache_freeable(struct folio *folio)
>  {
>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>
> @@ -1543,8 +1592,6 @@ bool folio_free_swap(struct folio *folio)
>                 return false;
>         if (folio_test_writeback(folio))
>                 return false;
> -       if (folio_swapped(folio))
> -               return false;
>
>         /*
>          * Once hibernation has begun to create its image of memory,
> @@ -1564,6 +1611,25 @@ bool folio_free_swap(struct folio *folio)
>         if (pm_suspended_storage())
>                 return false;
>
> +       return true;
> +}
> +
> +/**
> + * folio_free_swap() - Free the swap space used for this folio.
> + * @folio: The folio to remove.
> + *
> + * If swap is getting full, or if there are no more mappings of this fol=
io,
> + * then call folio_free_swap to free its swap space.
> + *
> + * Return: true if we were able to release the swap space.
> + */
> +bool folio_free_swap(struct folio *folio)
> +{
> +       if (!folio_swapcache_freeable(folio))
> +               return false;
> +       if (folio_swapped(folio))
> +               return false;
> +
>         delete_from_swap_cache(folio);
>         folio_set_dirty(folio);
>         return true;
> @@ -1640,7 +1706,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int =
nr)
>                          * to the next boundary.
>                          */
>                         nr =3D __try_to_reclaim_swap(si, offset,
> -                                             TTRS_UNMAPPED | TTRS_FULL);
> +                                                  TTRS_UNMAPPED | TTRS_F=
ULL);
>                         if (nr =3D=3D 0)
>                                 nr =3D 1;
>                         else if (nr < 0)
>
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

