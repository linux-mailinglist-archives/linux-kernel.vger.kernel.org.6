Return-Path: <linux-kernel+bounces-273465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAE9946997
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 14:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADCA281E34
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF89514E2E9;
	Sat,  3 Aug 2024 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGrAPTzd"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB05847B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722687557; cv=none; b=P+dSD85zUM0zbyClPXBAlRnEPfGWosGaj9o+/3G6xblaImW387nK0T3NYSW/Grzy0IN3Er7A2Qksv8Hk73rtsBVZsqw6Ey3Dof5QTa6O+i/cDq3OmvfX0thH6cfzQR9rnjUd30otXafeZR2+gYBwsBuxw+rxfFIYLL9giGRvszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722687557; c=relaxed/simple;
	bh=shHQRvjoE+wkaV62kC3qm5/fwSn0hgTF05bx4MMJdpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMvJBIxpneI28/xYR1EZxXz4mCuBbzI4sTlk5ji57pfk0cHjiCAYy3097qr8u0GFn0kd6ruW8uTP9rYuwrFVbfEV+D+ESCVEt/zxVIE/p/4V4FieAGq36Ej+zVZI2kvW+5r6iws3UiQmRluRODfrZxXPx0sICYcl0r9DU0q2r8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGrAPTzd; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so105439521fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 05:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722687554; x=1723292354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4AP6Vgl2PdbHBiN7CjLamuTMAEWvLdQm4Pq+kIPd38=;
        b=hGrAPTzd9mJSoT9VEu5VXu3+MslmWme0X0w4enChGGpTSDHtLX4vxLZqqNc99xEu0q
         EGKZbWCPCZBdVaiFQtyHTFa8t4Ai0p1SKcahQRPVpiYClJLO8P7J7NtR9f18BonQit2u
         voIG5fVUYtPhhLIQUs0e4lhYaMwrRb7AN1gN0toJBJw9V0z13ulcThCq0V7zKm6T4qM3
         ygVfKtNJ76lt0tE+7TFK+sCpMVQRz5u839jeofj/1CpXMuijYEs4TRlJL01SPzUPj0fO
         JwA053ImmIeSgHpUTwBjX14GUcxxkLvl8hQi+JmEQan11Hs2rTimj8KarkdojzaPyzSn
         ViKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722687554; x=1723292354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4AP6Vgl2PdbHBiN7CjLamuTMAEWvLdQm4Pq+kIPd38=;
        b=PBPiAmk2Gv5/GAylBwKG7k8fMwoNgDRMRKJxxE+O88hVSZYbnkfBzJDGmqZb6KIc1B
         KVbjSp/0d4ZOdFgFwLsXBGivSMsgKM3B6e6Ryd3sFfpXgX967c7JjFF4d9NDUh2pxurh
         KnQjJH4wniby+LYV6wnepKglMmrg7gPi4akR+hxcJYeNA6nVL2TkvIgR5ZbOgHkyyTe2
         rZAEoDNgpVKL5HLJRV+NZjJ9DBQQviR1jK0G1L8DfY17poWAtk/AHMZ8fy9gC4uXghsw
         G8sao2yhIK8JvYE5ZCHtte3dCteAYnPsv80dcxnuRygH+T14Nf3FQN9VWK4b6pyOCx6s
         LV2A==
X-Forwarded-Encrypted: i=1; AJvYcCXZVJj3nBfkOHzR6F7dytqvagR8uclNHcczZ8g53L43By+6ZzTArlE1mRvJWE2l2yBZ/dEsrm3eta/sigayDYI9mxgsiJ+qoKS//cGi
X-Gm-Message-State: AOJu0YwPpYQGKWS8hLGXWD5HdygxxiowjILt1WOze1myEfhd7yJBlP6w
	EcfFWuXgOm9wDdFKbqdOpQhzO+tjELMUoZvtU6oHB2G4xOmj6zJVlKsI1ZlX4TJQxG1dnX8b72Z
	M90YFVZlkSpWkuodt6RBZ7Ix2g64=
X-Google-Smtp-Source: AGHT+IF9L1bpaO+SnO/rNrZIW4y2VDSvcLjYUMl7eymbp1PZQppn7B/p2LYl+K7fxmQzyF5ISXytN4Z4YECroqDBVdE=
X-Received: by 2002:a2e:9c48:0:b0:2eb:68d0:88be with SMTP id
 38308e7fff4ca-2f15aa8736amr43177531fa.12.1722687553493; Sat, 03 Aug 2024
 05:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <20240730-swap-allocator-v5-6-cb9c148b9297@kernel.org> <CAGsJ_4zsUCN2vgN6kgPmWZiORgH2d9g8h9kLBYsL+hVQRZhHCg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zsUCN2vgN6kgPmWZiORgH2d9g8h9kLBYsL+hVQRZhHCg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 3 Aug 2024 20:18:57 +0800
Message-ID: <CAMgjq7CXcZ4DnPUfPBw8OXYp-zP+Pb_p4KqO0O6kkYvyGLZDYg@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] mm: swap: allow cache reclaim to skip slot cache
To: Barry Song <baohua@kernel.org>
Cc: chrisl@kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 6:39=E2=80=AFPM Barry Song <baohua@kernel.org> wrote=
:
>
> On Wed, Jul 31, 2024 at 2:49=E2=80=AFPM <chrisl@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently we free the reclaimed slots through slot cache even
> > if the slot is required to be empty immediately. As a result
> > the reclaim caller will see the slot still occupied even after a
> > successful reclaim, and need to keep reclaiming until slot cache
> > get flushed. This caused ineffective or over reclaim when SWAP is
> > under stress.
> >
> > So introduce a new flag allowing the slot to be emptied bypassing
> > the slot cache.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swapfile.c | 152 +++++++++++++++++++++++++++++++++++++++++---------=
--------
> >  1 file changed, 109 insertions(+), 43 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 9b63b2262cc2..4c0fc0409d3c 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -53,8 +53,15 @@
> >  static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
> >                                  unsigned char);
> >  static void free_swap_count_continuations(struct swap_info_struct *);
> > +static void swap_entry_range_free(struct swap_info_struct *si, swp_ent=
ry_t entry,
> > +                                 unsigned int nr_pages);
> >  static void swap_range_alloc(struct swap_info_struct *si, unsigned lon=
g offset,
> >                              unsigned int nr_entries);
> > +static bool folio_swapcache_freeable(struct folio *folio);
> > +static struct swap_cluster_info *lock_cluster_or_swap_info(
> > +               struct swap_info_struct *si, unsigned long offset);
> > +static void unlock_cluster_or_swap_info(struct swap_info_struct *si,
> > +                                       struct swap_cluster_info *ci);
> >
> >  static DEFINE_SPINLOCK(swap_lock);
> >  static unsigned int nr_swapfiles;
> > @@ -129,8 +136,25 @@ static inline unsigned char swap_count(unsigned ch=
ar ent)
> >   * corresponding page
> >   */
> >  #define TTRS_UNMAPPED          0x2
> > -/* Reclaim the swap entry if swap is getting full*/
> > +/* Reclaim the swap entry if swap is getting full */
> >  #define TTRS_FULL              0x4
> > +/* Reclaim directly, bypass the slot cache and don't touch device lock=
 */
> > +#define TTRS_DIRECT            0x8
> > +
> > +static bool swap_is_has_cache(struct swap_info_struct *si,
> > +                             unsigned long offset, int nr_pages)
> > +{
> > +       unsigned char *map =3D si->swap_map + offset;
> > +       unsigned char *map_end =3D map + nr_pages;
> > +
> > +       do {
> > +               VM_BUG_ON(!(*map & SWAP_HAS_CACHE));
> > +               if (*map !=3D SWAP_HAS_CACHE)
> > +                       return false;
> > +       } while (++map < map_end);
> > +
> > +       return true;
> > +}
> >
> >  /*
> >   * returns number of pages in the folio that backs the swap entry. If =
positive,
> > @@ -141,12 +165,22 @@ static int __try_to_reclaim_swap(struct swap_info=
_struct *si,
> >                                  unsigned long offset, unsigned long fl=
ags)
> >  {
> >         swp_entry_t entry =3D swp_entry(si->type, offset);
> > +       struct address_space *address_space =3D swap_address_space(entr=
y);
> > +       struct swap_cluster_info *ci;
> >         struct folio *folio;
> > -       int ret =3D 0;
> > +       int ret, nr_pages;
> > +       bool need_reclaim;
> >
> > -       folio =3D filemap_get_folio(swap_address_space(entry), swap_cac=
he_index(entry));
> > +       folio =3D filemap_get_folio(address_space, swap_cache_index(ent=
ry));
> >         if (IS_ERR(folio))
> >                 return 0;
> > +
> > +       /* offset could point to the middle of a large folio */
> > +       entry =3D folio->swap;
> > +       offset =3D swp_offset(entry);
> > +       nr_pages =3D folio_nr_pages(folio);
> > +       ret =3D -nr_pages;
> > +
> >         /*
> >          * When this function is called from scan_swap_map_slots() and =
it's
> >          * called by vmscan.c at reclaiming folios. So we hold a folio =
lock
> > @@ -154,14 +188,50 @@ static int __try_to_reclaim_swap(struct swap_info=
_struct *si,
> >          * case and you should use folio_free_swap() with explicit foli=
o_lock()
> >          * in usual operations.
> >          */
> > -       if (folio_trylock(folio)) {
> > -               if ((flags & TTRS_ANYWAY) ||
> > -                   ((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) |=
|
> > -                   ((flags & TTRS_FULL) && mem_cgroup_swap_full(folio)=
))
> > -                       ret =3D folio_free_swap(folio);
> > -               folio_unlock(folio);
> > +       if (!folio_trylock(folio))
> > +               goto out;
> > +
> > +       need_reclaim =3D ((flags & TTRS_ANYWAY) ||
> > +                       ((flags & TTRS_UNMAPPED) && !folio_mapped(folio=
)) ||
> > +                       ((flags & TTRS_FULL) && mem_cgroup_swap_full(fo=
lio)));
> > +       if (!need_reclaim || !folio_swapcache_freeable(folio))
> > +               goto out_unlock;
> > +
> > +       /*
> > +        * It's safe to delete the folio from swap cache only if the fo=
lio's
> > +        * swap_map is HAS_CACHE only, which means the slots have no pa=
ge table
> > +        * reference or pending writeback, and can't be allocated to ot=
hers.
> > +        */
> > +       ci =3D lock_cluster_or_swap_info(si, offset);
> > +       need_reclaim =3D swap_is_has_cache(si, offset, nr_pages);
> > +       unlock_cluster_or_swap_info(si, ci);
> > +       if (!need_reclaim)
> > +               goto out_unlock;
> > +
> > +       if (!(flags & TTRS_DIRECT)) {
> > +               /* Free through slot cache */
> > +               delete_from_swap_cache(folio);
> > +               folio_set_dirty(folio);
> > +               ret =3D nr_pages;
> > +               goto out_unlock;
> >         }
> > -       ret =3D ret ? folio_nr_pages(folio) : -folio_nr_pages(folio);
> > +
> > +       xa_lock_irq(&address_space->i_pages);
> > +       __delete_from_swap_cache(folio, entry, NULL);
> > +       xa_unlock_irq(&address_space->i_pages);
> > +       folio_ref_sub(folio, nr_pages);
> > +       folio_set_dirty(folio);
> > +
> > +       spin_lock(&si->lock);
> > +       /* Only sinple page folio can be backed by zswap */
> > +       if (!nr_pages)
> > +               zswap_invalidate(entry);
>
> I am trying to figure out if I am mad :-)  Does nr_pages =3D=3D 0 means s=
ingle
> page folio?
>

Hi Barry

I'm sorry, this should be nr_pages =3D=3D 1, I messed up order and nr, as
zswap only works for single page folios.

