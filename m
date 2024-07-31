Return-Path: <linux-kernel+bounces-268980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D5942BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25930B20E77
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BD91AC422;
	Wed, 31 Jul 2024 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSQ6U+Bw"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A18801
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421406; cv=none; b=NY1i9ZApOo4eDF5kjsybKTttdrdYubGSxIYAoF3j8cmNnrMFfX/AjpysCH/I+fGaTXGxz59HULFWXW3cSHRk81hugtqQei4jPtg0AgQ4iALt2ktiRh+EU/l2EES8XECrcqN5FNhQQ92VjV6NlaD57eabHzpnhITyzYgg44SVQCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421406; c=relaxed/simple;
	bh=eL9tAP5TjD+VRSLElQ/0Xj5tkfF3Vz4FPAbzTbPR7ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raW7w72g214JiJMxr0fG+JvOJSh80jmx8DnEHFCqtS/nzMJf9Ik7h+MunX9xL3yjQN9NHgtUHc3t7XQXzCTXYSzq5dWLGgOxzjV2KU8Py2QAIPj3g8uWXO+EeTFsTLFbtsb0+yryljYLYPIv63JkkD67CQj3w6dz4WIp6uUsEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSQ6U+Bw; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49299323d71so1522290137.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722421403; x=1723026203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFmQVShAHj9eLaCuGgxCH1jsKTl/l8rQteiLrzZiBsw=;
        b=ZSQ6U+Bwkym7StSUkXIHAAuU+OaDGKoON32NsoRHj+p11lztuHi9RWgVwqn08PIUZ4
         WYzDEalzZkFiK2aE3pP1AWtcB5Or9bdknClWPssFA0ISvPAg2zCYNhyEUMkL4A5A/5DT
         LPwY9x7sq+MQxNlqnEhPJ2R071PbWPIlcUZZ7Xw8rp1JvoLVElwPVLrJR4oMlz3JEdzg
         ccdzYoPxcZI13/S7QDX2DnJdKIb1FmB2zKixOkWZ9IUbHK37UVKw3KITaztilSWo7lDz
         Pi5+jYFxekDN6DqZnsQK9KVnVWCi82de5KlIStGKsirJfbkdVLZsln4q1ymwuBFh7D05
         OEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722421403; x=1723026203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFmQVShAHj9eLaCuGgxCH1jsKTl/l8rQteiLrzZiBsw=;
        b=OJHDxSv3GE6ZlOJFyg2iIAgAQVDO3zYKzWwLY1gt1hThWhtsnbNE8G49TmtlKAMhfF
         Hjedco7fguiXYhQth2yLQQQLzzPeIQwJ26QCWFvvJo3BS2m7Cn+Qk1qhL+Zdv5nC/zNB
         KbpJyHKCWReyoSvvPvFuSAEqQVJhUxCocROKpcTC18hKsVphBYR8NvFb3Y6nH8Y1fuVE
         aErevmFcuCkkXY7nGeyUxTjlEt7dvBPJIDZQL/0meKhnnaQV6fHRu2kPQNZLu9GAPxyg
         loz86Ou+dNNq3yUVqk25+vX27MAQC1vRyqFnZxUXigc8kKdIDCrkKBKQ5HZ7DhmmTPVP
         ue8w==
X-Forwarded-Encrypted: i=1; AJvYcCUC5SIQGIEzgvBXN/XWdFj2os/LZdMCZSqreFF1p8uYHrWr5X/W4pcGKKqKYFfxaT/eYvr5rwJaoeLSp8k42UZm/n6NppPGTZ8bee09
X-Gm-Message-State: AOJu0Yy+A1XLus++sOnuQFvN/yc+kWkQJQwNxfyqYwhAVAs7eNOHJZog
	2eyk0I5rgCVHLpeyyUmkk2Qb8hayIV8MoRu6RpNcDnTzgkgV00HCMrmtHj94IHoZYHvcRMyGFGV
	HBP1Gj8hhWx6bBkFTzKVK9XkSNf4=
X-Google-Smtp-Source: AGHT+IE6T6qCBdXInX5r6zrKwIKTZBwCXC2KCf/joU6AbvNPxLssLAwURAjVzgEBk9dEYD2w3BWFMh5S5GrmYLWKmEM=
X-Received: by 2002:a05:6102:38ce:b0:492:9394:d2e with SMTP id
 ada2fe7eead31-493fa1c7700mr16224459137.16.1722421402781; Wed, 31 Jul 2024
 03:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730071339.107447-1-21cnbao@gmail.com> <20240730071339.107447-2-21cnbao@gmail.com>
 <874j86oubf.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wH1qbG5hQ8K-OyvO5ut+rFo3Ng_+pUp7wMLWo-1PwERg@mail.gmail.com>
 <87zfpynf2r.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87zfpynf2r.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 31 Jul 2024 18:23:11 +0800
Message-ID: <CAGsJ_4wAUSFn7x3OznRjKnQk2k=mM7gJr8b4CTJt2VwNKdn1jA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: swap: add nr argument in swapcache_prepare and
 swapcache_clear to support large folios
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	xiang@kernel.org, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:28=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Jul 31, 2024 at 4:14=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Hi, Barry,
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >
> >> > Right now, swapcache_prepare() and swapcache_clear() supports one en=
try
> >> > only, to support large folios, we need to handle multiple swap entri=
es.
> >> >
> >> > To optimize stack usage, we iterate twice in __swap_duplicate(): the
> >> > first time to verify that all entries are valid, and the second time
> >> > to apply the modifications to the entries.
> >> >
> >> > Currently, we're using nr=3D1 for the existing users.
> >> >
> >> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> > ---
> >> >  include/linux/swap.h |   4 +-
> >> >  mm/memory.c          |   6 +--
> >> >  mm/swap.h            |   5 ++-
> >> >  mm/swap_state.c      |   2 +-
> >> >  mm/swapfile.c        | 101 +++++++++++++++++++++++++---------------=
---
> >> >  5 files changed, 68 insertions(+), 50 deletions(-)
> >> >
> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> > index ba7ea95d1c57..5b920fa2315b 100644
> >> > --- a/include/linux/swap.h
> >> > +++ b/include/linux/swap.h
> >> > @@ -480,7 +480,7 @@ extern int get_swap_pages(int n, swp_entry_t swp=
_entries[], int order);
> >> >  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> >> >  extern void swap_shmem_alloc(swp_entry_t);
> >> >  extern int swap_duplicate(swp_entry_t);
> >> > -extern int swapcache_prepare(swp_entry_t);
> >> > +extern int swapcache_prepare(swp_entry_t entry, int nr);
> >> >  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >> > @@ -554,7 +554,7 @@ static inline int swap_duplicate(swp_entry_t swp=
)
> >> >       return 0;
> >> >  }
> >> >
> >> > -static inline int swapcache_prepare(swp_entry_t swp)
> >> > +static inline int swapcache_prepare(swp_entry_t swp, int nr)
> >> >  {
> >> >       return 0;
> >> >  }
> >> > diff --git a/mm/memory.c b/mm/memory.c
> >> > index 833d2cad6eb2..b8675617a5e3 100644
> >> > --- a/mm/memory.c
> >> > +++ b/mm/memory.c
> >> > @@ -4081,7 +4081,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >                        * reusing the same entry. It's undetectable a=
s
> >> >                        * pte_same() returns true due to entry reuse.
> >> >                        */
> >> > -                     if (swapcache_prepare(entry)) {
> >> > +                     if (swapcache_prepare(entry, 1)) {
> >> >                               /* Relax a bit to prevent rapid repeat=
ed page faults */
> >> >                               schedule_timeout_uninterruptible(1);
> >> >                               goto out;
> >> > @@ -4387,7 +4387,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >  out:
> >> >       /* Clear the swap cache pin for direct swapin after PTL unlock=
 */
> >> >       if (need_clear_cache)
> >> > -             swapcache_clear(si, entry);
> >> > +             swapcache_clear(si, entry, 1);
> >> >       if (si)
> >> >               put_swap_device(si);
> >> >       return ret;
> >> > @@ -4403,7 +4403,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >               folio_put(swapcache);
> >> >       }
> >> >       if (need_clear_cache)
> >> > -             swapcache_clear(si, entry);
> >> > +             swapcache_clear(si, entry, 1);
> >> >       if (si)
> >> >               put_swap_device(si);
> >> >       return ret;
> >> > diff --git a/mm/swap.h b/mm/swap.h
> >> > index baa1fa946b34..7c6330561d84 100644
> >> > --- a/mm/swap.h
> >> > +++ b/mm/swap.h
> >> > @@ -59,7 +59,7 @@ void __delete_from_swap_cache(struct folio *folio,
> >> >  void delete_from_swap_cache(struct folio *folio);
> >> >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
> >> >                                 unsigned long end);
> >> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry=
);
> >> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry=
, int nr);
> >> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
> >> >               struct vm_area_struct *vma, unsigned long addr);
> >> >  struct folio *filemap_get_incore_folio(struct address_space *mappin=
g,
> >> > @@ -120,7 +120,7 @@ static inline int swap_writepage(struct page *p,=
 struct writeback_control *wbc)
> >> >       return 0;
> >> >  }
> >> >
> >> > -static inline void swapcache_clear(struct swap_info_struct *si, swp=
_entry_t entry)
> >> > +static inline void swapcache_clear(struct swap_info_struct *si, swp=
_entry_t entry, int nr)
> >> >  {
> >> >  }
> >> >
> >> > @@ -172,4 +172,5 @@ static inline unsigned int folio_swap_flags(stru=
ct folio *folio)
> >> >       return 0;
> >> >  }
> >> >  #endif /* CONFIG_SWAP */
> >> > +
> >>
> >> NITPICK: Is it necessary to add a blank line here?  But I don't think =
a
> >> new version is necessary if this is the only change needed.
> >
> > No need to add a blank line; it was probably a mistake I made in Vim.
> >
> >>
> >> >  #endif /* _MM_SWAP_H */
> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> >> > index a1726e49a5eb..b06f2a054f5a 100644
> >> > --- a/mm/swap_state.c
> >> > +++ b/mm/swap_state.c
> >> > @@ -477,7 +477,7 @@ struct folio *__read_swap_cache_async(swp_entry_=
t entry, gfp_t gfp_mask,
> >> >               /*
> >> >                * Swap entry may have been freed since our caller obs=
erved it.
> >> >                */
> >> > -             err =3D swapcache_prepare(entry);
> >> > +             err =3D swapcache_prepare(entry, 1);
> >> >               if (!err)
> >> >                       break;
> >> >
> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> > index 5f73a8553371..757d38a86f56 100644
> >> > --- a/mm/swapfile.c
> >> > +++ b/mm/swapfile.c
> >> > @@ -3363,7 +3363,7 @@ void si_swapinfo(struct sysinfo *val)
> >> >  }
> >> >
> >> >  /*
> >> > - * Verify that a swap entry is valid and increment its swap map cou=
nt.
> >> > + * Verify that nr swap entries are valid and increment their swap m=
ap counts.
> >> >   *
> >> >   * Returns error code in following case.
> >> >   * - success -> 0
> >> > @@ -3373,60 +3373,77 @@ void si_swapinfo(struct sysinfo *val)
> >> >   * - swap-cache reference is requested but the entry is not used. -=
> ENOENT
> >> >   * - swap-mapped reference requested but needs continued swap count=
. -> ENOMEM
> >> >   */
> >> > -static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> >> > +static int __swap_duplicate(swp_entry_t entry, unsigned char usage,=
 int nr)
> >> >  {
> >> >       struct swap_info_struct *p;
> >> >       struct swap_cluster_info *ci;
> >> >       unsigned long offset;
> >> >       unsigned char count;
> >> >       unsigned char has_cache;
> >> > -     int err;
> >> > +     int err, i;
> >> >
> >> >       p =3D swp_swap_info(entry);
> >> >
> >> >       offset =3D swp_offset(entry);
> >> > +     VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> >> >       ci =3D lock_cluster_or_swap_info(p, offset);
> >> >
> >> > -     count =3D p->swap_map[offset];
> >> > +     err =3D 0;
> >> > +     for (i =3D 0; i < nr; i++) {
> >> > +             count =3D p->swap_map[offset + i];
> >> >
> >> > -     /*
> >> > -      * swapin_readahead() doesn't check if a swap entry is valid, =
so the
> >> > -      * swap entry could be SWAP_MAP_BAD. Check here with lock held=
.
> >> > -      */
> >> > -     if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
> >> > -             err =3D -ENOENT;
> >> > -             goto unlock_out;
> >> > -     }
> >> > +             /*
> >> > +              * swapin_readahead() doesn't check if a swap entry is=
 valid, so the
> >> > +              * swap entry could be SWAP_MAP_BAD. Check here with l=
ock held.
> >> > +              */
> >> > +             if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
> >> > +                     err =3D -ENOENT;
> >> > +                     goto unlock_out;
> >> > +             }
> >> >
> >> > -     has_cache =3D count & SWAP_HAS_CACHE;
> >> > -     count &=3D ~SWAP_HAS_CACHE;
> >> > -     err =3D 0;
> >> > +             has_cache =3D count & SWAP_HAS_CACHE;
> >> > +             count &=3D ~SWAP_HAS_CACHE;
> >> >
> >> > -     if (usage =3D=3D SWAP_HAS_CACHE) {
> >> > +             if (usage =3D=3D SWAP_HAS_CACHE) {
> >> > +                     /* set SWAP_HAS_CACHE if there is no cache and=
 entry is used */
> >> > +                     if (!has_cache && count)
> >> > +                             continue;
> >> > +                     else if (has_cache)             /* someone els=
e added cache */
> >> > +                             err =3D -EEXIST;
> >> > +                     else                            /* no users re=
maining */
> >> > +                             err =3D -ENOENT;
> >> >
> >> > -             /* set SWAP_HAS_CACHE if there is no cache and entry i=
s used */
> >> > -             if (!has_cache && count)
> >> > -                     has_cache =3D SWAP_HAS_CACHE;
> >> > -             else if (has_cache)             /* someone else added =
cache */
> >> > -                     err =3D -EEXIST;
> >> > -             else                            /* no users remaining =
*/
> >> > -                     err =3D -ENOENT;
> >> > +             } else if (count || has_cache) {
> >> >
> >> > -     } else if (count || has_cache) {
> >> > +                     if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> >> > +                             continue;
> >> > +                     else if ((count & ~COUNT_CONTINUED) > SWAP_MAP=
_MAX)
> >> > +                             err =3D -EINVAL;
> >> > +                     else if (swap_count_continued(p, offset + i, c=
ount))
> >> > +                             continue;
> >>
> >> IIUC, this will make the change to swap map directly instead of
> >> verification.  If the verification failed for some entry later, the
> >> count will be wrong?  Or I missed something?
> >
> > To avoid using a bitmap or a larger stack, we actually verify during
> > the first iteration.
> > This ensures that by the second iteration, we can safely commit the
> > modification.
> >
> > I actually put some words in the changelog :-)
> >
> > To optimize stack usage, we iterate twice in __swap_duplicate(): the
> > first time to verify that all entries are valid, and the second time
> > to apply the modifications to the entries.
>
> Yes, I have seen it and I think that it is a good strategy.
>
> But, IIUC, swap_count_continued() will change the higher bits of the
> swap_map instead of verifying.  Or, my understanding is wrong?
>

Ying, your understanding is 100% correct. but the code also has nothing
broken. we didn't extend swap_duplicate() to have argument nr,
so all users which can set usage=3D1 will definitely have nr=3D1.

int swap_duplicate(swp_entry_t entry)
{
        int err =3D 0;

        while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOMEM)
                err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
        return err;
}

Maybe I can add a VM_WARN_ON to warn those people who might
want to extend swap_duplicate()? in that case, things could be quite
tricky.

--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3386,6 +3386,7 @@ static int __swap_duplicate(swp_entry_t entry,
unsigned char usage, int nr)

        offset =3D swp_offset(entry);
        VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
+       VM_WARN_ON(usage =3D=3D 1 && nr > 1);
        ci =3D lock_cluster_or_swap_info(p, offset);

        err =3D 0;


> --
> Best Regards,
> Huang, Ying
>
> >>
> >> > +                     else
> >> > +                             err =3D -ENOMEM;
> >> > +             } else
> >> > +                     err =3D -ENOENT;                  /* unused sw=
ap entry */
> >> >
> >> > -             if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> >> > +             if (err)
> >> > +                     goto unlock_out;
> >> > +     }
> >> > +
> >> > +     for (i =3D 0; i < nr; i++) {
> >> > +             count =3D p->swap_map[offset + i];
> >> > +             has_cache =3D count & SWAP_HAS_CACHE;
> >> > +             count &=3D ~SWAP_HAS_CACHE;
> >> > +
> >> > +             if (usage =3D=3D SWAP_HAS_CACHE)
> >> > +                     has_cache =3D SWAP_HAS_CACHE;
> >> > +             else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> >> >                       count +=3D usage;
> >> > -             else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> >> > -                     err =3D -EINVAL;
> >> > -             else if (swap_count_continued(p, offset, count))
> >> > -                     count =3D COUNT_CONTINUED;
> >> >               else
> >> > -                     err =3D -ENOMEM;
> >> > -     } else
> >> > -             err =3D -ENOENT;                  /* unused swap entry=
 */
> >> > +                     count =3D COUNT_CONTINUED;
> >> >
> >> > -     if (!err)
> >> > -             WRITE_ONCE(p->swap_map[offset], count | has_cache);
> >> > +             WRITE_ONCE(p->swap_map[offset + i], count | has_cache)=
;
> >> > +     }
> >> >
> >> >  unlock_out:
> >> >       unlock_cluster_or_swap_info(p, ci);
> >> > @@ -3439,7 +3456,7 @@ static int __swap_duplicate(swp_entry_t entry,=
 unsigned char usage)
> >> >   */
> >> >  void swap_shmem_alloc(swp_entry_t entry)
> >> >  {
> >> > -     __swap_duplicate(entry, SWAP_MAP_SHMEM);
> >> > +     __swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
> >> >  }
> >> >
> >> >  /*
> >> > @@ -3453,29 +3470,29 @@ int swap_duplicate(swp_entry_t entry)
> >> >  {
> >> >       int err =3D 0;
> >> >
> >> > -     while (!err && __swap_duplicate(entry, 1) =3D=3D -ENOMEM)
> >> > +     while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOMEM)
> >> >               err =3D add_swap_count_continuation(entry, GFP_ATOMIC)=
;
> >> >       return err;
> >> >  }
> >> >
> >> >  /*
> >> > - * @entry: swap entry for which we allocate swap cache.
> >> > + * @entry: first swap entry from which we allocate nr swap cache.
> >> >   *
> >> > - * Called when allocating swap cache for existing swap entry,
> >> > + * Called when allocating swap cache for existing swap entries,
> >> >   * This can return error codes. Returns 0 at success.
> >> >   * -EEXIST means there is a swap cache.
> >> >   * Note: return code is different from swap_duplicate().
> >> >   */
> >> > -int swapcache_prepare(swp_entry_t entry)
> >> > +int swapcache_prepare(swp_entry_t entry, int nr)
> >> >  {
> >> > -     return __swap_duplicate(entry, SWAP_HAS_CACHE);
> >> > +     return __swap_duplicate(entry, SWAP_HAS_CACHE, nr);
> >> >  }
> >> >
> >> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry=
)
> >> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry=
, int nr)
> >> >  {
> >> >       unsigned long offset =3D swp_offset(entry);
> >> >
> >> > -     cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
> >> > +     cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
> >> >  }
> >> >
> >> >  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
> >>
> >> --
> >> Best Regards,
> >> Huang, Ying
> >
> > Thanks
> > Barry

