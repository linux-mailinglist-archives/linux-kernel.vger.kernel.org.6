Return-Path: <linux-kernel+bounces-273972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A158794703B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 20:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3321B20ED8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364386A325;
	Sun,  4 Aug 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OID3zu6B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4888379C2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722794821; cv=none; b=Q4sQoags5CHuttFRJNlfVQV+ru4S4/CWSXeQhxh3uERgD4Y5F/qckSipssLJqxp3GkZYyFl1R4GSAX5rzIlq+R2+pYLxzY0nCNwZtGKb8LAVUw54vdOgoOZe/3OghYKGpAKPH2kb61d7d9SbtvGcDb0HJ6Zqs2c7rZRPCSDcMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722794821; c=relaxed/simple;
	bh=FPMZXAZ9bG2MhzosXGiGwqY/p8xJdCmEhGLR/Ovnpoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxKrOBszGwHekb6kttJ+7x6ZySHzhOxRy2HgJK23miM7LXPQkY0JDrOvSLsMLuh6LLxniW/xAN8xXHYgXJ1QAUG+B/QYztMaw5iPf3TtYOp62b+PRYRIxXx0pRpKVGf5G3YJBWF2UIc0c1S1rhUJMcm5XqPvrreeVCI4Kt7fW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OID3zu6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6DBC4AF11
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722794821;
	bh=FPMZXAZ9bG2MhzosXGiGwqY/p8xJdCmEhGLR/Ovnpoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OID3zu6BjdZ8/p/mPdNClAhv9gTjN/Jbt/Xw2JB0Lnl3YrG+Fzvf2u/PiDzhsgj1a
	 6QpzlTJhPQ+wweLYtu+JdDp1n5TdjLnvdRbeIzdflKr2ZUCD0Cpo6T+0qlkNTfVJSY
	 1QYMEMqxjVloDNqH9Y221av/lqu2ehoPtKkaWeJOkNaRABd+D566X68zZO3dseZ8Kj
	 edoR+DaTkOh3ZMi2p0uhakI9/b53LboN6q3fEMQDIN7VzWImFUBbn9+XmICLD7SIGS
	 xWL6Bf9FY1/TQNFFExy+TQm8kooi/k2cwyJ6nQdw+GN0cYL4YEQWmMig7cj/F0R7J6
	 oCuwRTAqk932A==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66108213e88so82229017b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 11:07:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtX50dlxhU1HZ6J8ckdx+ND6y4TJ7wRo5PrwmlaEZbVPnxxmUXR7eG71jm50PjFTijcSG8xIgDuycJGv5nabfsMbD6xdRDOkaKG5Gk
X-Gm-Message-State: AOJu0YxSPgJywcOSEhgxqC+XNr7j62D7HrFGSQrb8mLuaqufTiX36IDv
	ATrpEV8ZkoNDrSY+xnXMnHMEbV9CW2mYRt7flD1fhwMi+9HiSs48o89Km9FKUQELkkl+WS2J4V4
	achDYV6lPEJXDSJgw942HIWfoIVDEa+40Tj5e4Q==
X-Google-Smtp-Source: AGHT+IGhIY16ROzZCifuV0PA+enuIA5D4n8kLAH9MdzNE9E7yeJulo0twps8z+X66oVReUil1BvGZa4DNFS9bFyCRUU=
X-Received: by 2002:a81:8183:0:b0:65f:8209:3ede with SMTP id
 00721157ae682-689641a40cfmr116350167b3.44.1722794820298; Sun, 04 Aug 2024
 11:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <20240730-swap-allocator-v5-6-cb9c148b9297@kernel.org> <CAGsJ_4zsUCN2vgN6kgPmWZiORgH2d9g8h9kLBYsL+hVQRZhHCg@mail.gmail.com>
 <CAMgjq7CXcZ4DnPUfPBw8OXYp-zP+Pb_p4KqO0O6kkYvyGLZDYg@mail.gmail.com>
In-Reply-To: <CAMgjq7CXcZ4DnPUfPBw8OXYp-zP+Pb_p4KqO0O6kkYvyGLZDYg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 4 Aug 2024 11:06:43 -0700
X-Gmail-Original-Message-ID: <CACePvbXkM1E56exMYKC5VsBFd+3+V60yPXx-qnq8ZNgOG1yVrg@mail.gmail.com>
Message-ID: <CACePvbXkM1E56exMYKC5VsBFd+3+V60yPXx-qnq8ZNgOG1yVrg@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] mm: swap: allow cache reclaim to skip slot cache
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 5:19=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Sat, Aug 3, 2024 at 6:39=E2=80=AFPM Barry Song <baohua@kernel.org> wro=
te:
> >
> > On Wed, Jul 31, 2024 at 2:49=E2=80=AFPM <chrisl@kernel.org> wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Currently we free the reclaimed slots through slot cache even
> > > if the slot is required to be empty immediately. As a result
> > > the reclaim caller will see the slot still occupied even after a
> > > successful reclaim, and need to keep reclaiming until slot cache
> > > get flushed. This caused ineffective or over reclaim when SWAP is
> > > under stress.
> > >
> > > So introduce a new flag allowing the slot to be emptied bypassing
> > > the slot cache.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/swapfile.c | 152 +++++++++++++++++++++++++++++++++++++++++-------=
----------
> > >  1 file changed, 109 insertions(+), 43 deletions(-)
> > >
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 9b63b2262cc2..4c0fc0409d3c 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -53,8 +53,15 @@
> > >  static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
> > >                                  unsigned char);
> > >  static void free_swap_count_continuations(struct swap_info_struct *)=
;
> > > +static void swap_entry_range_free(struct swap_info_struct *si, swp_e=
ntry_t entry,
> > > +                                 unsigned int nr_pages);
> > >  static void swap_range_alloc(struct swap_info_struct *si, unsigned l=
ong offset,
> > >                              unsigned int nr_entries);
> > > +static bool folio_swapcache_freeable(struct folio *folio);
> > > +static struct swap_cluster_info *lock_cluster_or_swap_info(
> > > +               struct swap_info_struct *si, unsigned long offset);
> > > +static void unlock_cluster_or_swap_info(struct swap_info_struct *si,
> > > +                                       struct swap_cluster_info *ci)=
;
> > >
> > >  static DEFINE_SPINLOCK(swap_lock);
> > >  static unsigned int nr_swapfiles;
> > > @@ -129,8 +136,25 @@ static inline unsigned char swap_count(unsigned =
char ent)
> > >   * corresponding page
> > >   */
> > >  #define TTRS_UNMAPPED          0x2
> > > -/* Reclaim the swap entry if swap is getting full*/
> > > +/* Reclaim the swap entry if swap is getting full */
> > >  #define TTRS_FULL              0x4
> > > +/* Reclaim directly, bypass the slot cache and don't touch device lo=
ck */
> > > +#define TTRS_DIRECT            0x8
> > > +
> > > +static bool swap_is_has_cache(struct swap_info_struct *si,
> > > +                             unsigned long offset, int nr_pages)
> > > +{
> > > +       unsigned char *map =3D si->swap_map + offset;
> > > +       unsigned char *map_end =3D map + nr_pages;
> > > +
> > > +       do {
> > > +               VM_BUG_ON(!(*map & SWAP_HAS_CACHE));
> > > +               if (*map !=3D SWAP_HAS_CACHE)
> > > +                       return false;
> > > +       } while (++map < map_end);
> > > +
> > > +       return true;
> > > +}
> > >
> > >  /*
> > >   * returns number of pages in the folio that backs the swap entry. I=
f positive,
> > > @@ -141,12 +165,22 @@ static int __try_to_reclaim_swap(struct swap_in=
fo_struct *si,
> > >                                  unsigned long offset, unsigned long =
flags)
> > >  {
> > >         swp_entry_t entry =3D swp_entry(si->type, offset);
> > > +       struct address_space *address_space =3D swap_address_space(en=
try);
> > > +       struct swap_cluster_info *ci;
> > >         struct folio *folio;
> > > -       int ret =3D 0;
> > > +       int ret, nr_pages;
> > > +       bool need_reclaim;
> > >
> > > -       folio =3D filemap_get_folio(swap_address_space(entry), swap_c=
ache_index(entry));
> > > +       folio =3D filemap_get_folio(address_space, swap_cache_index(e=
ntry));
> > >         if (IS_ERR(folio))
> > >                 return 0;
> > > +
> > > +       /* offset could point to the middle of a large folio */
> > > +       entry =3D folio->swap;
> > > +       offset =3D swp_offset(entry);
> > > +       nr_pages =3D folio_nr_pages(folio);
> > > +       ret =3D -nr_pages;
> > > +
> > >         /*
> > >          * When this function is called from scan_swap_map_slots() an=
d it's
> > >          * called by vmscan.c at reclaiming folios. So we hold a foli=
o lock
> > > @@ -154,14 +188,50 @@ static int __try_to_reclaim_swap(struct swap_in=
fo_struct *si,
> > >          * case and you should use folio_free_swap() with explicit fo=
lio_lock()
> > >          * in usual operations.
> > >          */
> > > -       if (folio_trylock(folio)) {
> > > -               if ((flags & TTRS_ANYWAY) ||
> > > -                   ((flags & TTRS_UNMAPPED) && !folio_mapped(folio))=
 ||
> > > -                   ((flags & TTRS_FULL) && mem_cgroup_swap_full(foli=
o)))
> > > -                       ret =3D folio_free_swap(folio);
> > > -               folio_unlock(folio);
> > > +       if (!folio_trylock(folio))
> > > +               goto out;
> > > +
> > > +       need_reclaim =3D ((flags & TTRS_ANYWAY) ||
> > > +                       ((flags & TTRS_UNMAPPED) && !folio_mapped(fol=
io)) ||
> > > +                       ((flags & TTRS_FULL) && mem_cgroup_swap_full(=
folio)));
> > > +       if (!need_reclaim || !folio_swapcache_freeable(folio))
> > > +               goto out_unlock;
> > > +
> > > +       /*
> > > +        * It's safe to delete the folio from swap cache only if the =
folio's
> > > +        * swap_map is HAS_CACHE only, which means the slots have no =
page table
> > > +        * reference or pending writeback, and can't be allocated to =
others.
> > > +        */
> > > +       ci =3D lock_cluster_or_swap_info(si, offset);
> > > +       need_reclaim =3D swap_is_has_cache(si, offset, nr_pages);
> > > +       unlock_cluster_or_swap_info(si, ci);
> > > +       if (!need_reclaim)
> > > +               goto out_unlock;
> > > +
> > > +       if (!(flags & TTRS_DIRECT)) {
> > > +               /* Free through slot cache */
> > > +               delete_from_swap_cache(folio);
> > > +               folio_set_dirty(folio);
> > > +               ret =3D nr_pages;
> > > +               goto out_unlock;
> > >         }
> > > -       ret =3D ret ? folio_nr_pages(folio) : -folio_nr_pages(folio);
> > > +
> > > +       xa_lock_irq(&address_space->i_pages);
> > > +       __delete_from_swap_cache(folio, entry, NULL);
> > > +       xa_unlock_irq(&address_space->i_pages);
> > > +       folio_ref_sub(folio, nr_pages);
> > > +       folio_set_dirty(folio);
> > > +
> > > +       spin_lock(&si->lock);
> > > +       /* Only sinple page folio can be backed by zswap */
> > > +       if (!nr_pages)
> > > +               zswap_invalidate(entry);
> >
> > I am trying to figure out if I am mad :-)  Does nr_pages =3D=3D 0 means=
 single
> > page folio?
> >
>
> Hi Barry
>
> I'm sorry, this should be nr_pages =3D=3D 1, I messed up order and nr, as
> zswap only works for single page folios.
Ack. Should be  nr_pages =3D=3D 1.

Barry, thanks for catching that.

Chris

