Return-Path: <linux-kernel+bounces-270551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39695944154
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903D9283A07
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE463136E3F;
	Thu,  1 Aug 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2nb7l6K"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D21EB49E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480185; cv=none; b=VawO66RyvbB2XW0kVd9WcnUElawyJPCqQqe/qgWKS+kWoeMUL/7Vi+9hqThWDfbvffcXQIOyEZAx8jn78b3sW3WKVNOUSfG+9lqjqoNlgn19tc90ia+vpyZ1jasY7lKSr6KrxPUI1zFzKB9yDulmqHbYBTrIGBJAu3A3wVJrsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480185; c=relaxed/simple;
	bh=qgLpU7edfVq1+x/AF2LOiiiVxWoHhmjX6UMooqNSAMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyRAyRjfHtH9kpsjbz37KXM830ci+k76BibKIVxFK2L7369gAcv3Z7uckXQ8+Q0tw1mPiMcdvPVxrq1Dk3VH1PV9ZIlCteuOLePKtlle3emA88BO8AiD7h4Dv/gJiJEsQe5eVWqDRUZv/NiZ0pFlg91TivauDh/kC6yUbHd3EiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2nb7l6K; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4f6be9d13cdso1925848e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722480182; x=1723084982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rakkb5FBCQKqLPVAz3DMrKm2zFVKJm0vW4XKM6tVmCw=;
        b=c2nb7l6K0S2FknVdTGziv6emDQQKntwL+pOZThPjjYOvDSPiypL9ZUkLM5NFjfMHYv
         sK5E0u5MCanRr2XCc5UEnSg1rNr4kDzYTnQfN2cJ8TDJgeUcnrIqsPr4oZ4awAXeGRkg
         5upfDikvP0eml5JYZN4jwyMgJorZuhE1oE9UtQwbi+9W87wopB1WaTBgjr5WtRMQ2EQw
         b1urUxd6JgNE+JGsoIFRAPJbcvw7CHn3bB0n2N/misr90czBk4qu1GDZBewHfUb7uNzk
         pOHYzHZPPI7LDInOonDEqHF0pAd40h97/XG3kdF5Xq8yzm+fmalVfEZQzLiGdi+wfMlA
         CRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722480182; x=1723084982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rakkb5FBCQKqLPVAz3DMrKm2zFVKJm0vW4XKM6tVmCw=;
        b=i8V889tyvfeGXpR1nZH48DXc0JMaOpIygHWtUV7En+B2PJrVAgj+/dUnDDYJrSwGeN
         jXixdEt/d5M5lXYFoO8kNww6OntLWgJwEdse4708o/8pq44tk+RxvTDBwclN+l5+Ym4Z
         EjVMkmHqSdPLSgh/s2pBB0oxfHv5gn56euSzJFlky2hhO6jitNqMgCl+liXYmB8/ayHy
         PdjUjtwl0IS3MIAaZHtHtwCQBcNZeeKEo528xSP1dc37ME+J0NgLiFh6euaSs7570Qbd
         JyOv4vH5cWmy9Mk6ZpTOn5XtkUdW7Mvtds/K93ZhMrS8xIc1hzs68oaPs2SCxcdAItVl
         cmgg==
X-Forwarded-Encrypted: i=1; AJvYcCWtjJ8ZboOIkWNMHQmj+WHvU+hd0BTijqINSAvQTsuHtmBUx4DEIESf50Buvo2XMtWGlvhoK6zYJlqdeTx0ZWr3Hou5ZNPZ28mjT0Iz
X-Gm-Message-State: AOJu0YwWCt+LzrX5ogeERWc0esWwJau1T0msWmLrxINkcSGmJ0ALvlUp
	Y/OimRwUihJP/6qH4AquWYOgdhBA8mCInSVrtE2jsJSiJ25YAxuy/eThcIW9KjNkXmHgdpJ3Ixj
	s4nPPT8UR2FDbgXUv5M6gtCpbyRg=
X-Google-Smtp-Source: AGHT+IFFtfyzDy7nHkIlV9+7nEx+8AuXTEheU1GQ/rLmeoZtQoEV+H4CfKlj7a8Lf5b6fTMKD/aNM3Plst94TJHmCGc=
X-Received: by 2002:a05:6122:2507:b0:4ef:6865:8ffd with SMTP id
 71dfb90a1353d-4f8965f01a1mr1630272e0c.10.1722480181782; Wed, 31 Jul 2024
 19:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730071339.107447-1-21cnbao@gmail.com> <20240730071339.107447-2-21cnbao@gmail.com>
 <874j86oubf.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wH1qbG5hQ8K-OyvO5ut+rFo3Ng_+pUp7wMLWo-1PwERg@mail.gmail.com>
 <87zfpynf2r.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wAUSFn7x3OznRjKnQk2k=mM7gJr8b4CTJt2VwNKdn1jA@mail.gmail.com>
 <871q39kq0e.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4ypk1RQ3jNnGJ6tgsXaWw55oU2f9Qp84k6+wb5JHUCcmQ@mail.gmail.com>
 <87wml1j7l9.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wml1j7l9.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 1 Aug 2024 10:42:49 +0800
Message-ID: <CAGsJ_4wq+TZ-+Ht9OY2ETWkWy94PmYDKm1iE52q0xYi0q883ug@mail.gmail.com>
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

On Thu, Aug 1, 2024 at 10:37=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Thu, Aug 1, 2024 at 9:13=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Wed, Jul 31, 2024 at 4:28=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Wed, Jul 31, 2024 at 4:14=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
> >> >> >>
> >> >> >> Hi, Barry,
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >>
> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >
> >> >> >> > Right now, swapcache_prepare() and swapcache_clear() supports =
one entry
> >> >> >> > only, to support large folios, we need to handle multiple swap=
 entries.
> >> >> >> >
> >> >> >> > To optimize stack usage, we iterate twice in __swap_duplicate(=
): the
> >> >> >> > first time to verify that all entries are valid, and the secon=
d time
> >> >> >> > to apply the modifications to the entries.
> >> >> >> >
> >> >> >> > Currently, we're using nr=3D1 for the existing users.
> >> >> >> >
> >> >> >> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> >> >> > ---
> >> >> >> >  include/linux/swap.h |   4 +-
> >> >> >> >  mm/memory.c          |   6 +--
> >> >> >> >  mm/swap.h            |   5 ++-
> >> >> >> >  mm/swap_state.c      |   2 +-
> >> >> >> >  mm/swapfile.c        | 101 +++++++++++++++++++++++++---------=
---------
> >> >> >> >  5 files changed, 68 insertions(+), 50 deletions(-)
> >> >> >> >
> >> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> >> >> > index ba7ea95d1c57..5b920fa2315b 100644
> >> >> >> > --- a/include/linux/swap.h
> >> >> >> > +++ b/include/linux/swap.h
> >> >> >> > @@ -480,7 +480,7 @@ extern int get_swap_pages(int n, swp_entry=
_t swp_entries[], int order);
> >> >> >> >  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> >> >> >> >  extern void swap_shmem_alloc(swp_entry_t);
> >> >> >> >  extern int swap_duplicate(swp_entry_t);
> >> >> >> > -extern int swapcache_prepare(swp_entry_t);
> >> >> >> > +extern int swapcache_prepare(swp_entry_t entry, int nr);
> >> >> >> >  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >> >> >> >  extern void swapcache_free_entries(swp_entry_t *entries, int =
n);
> >> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr)=
;
> >> >> >> > @@ -554,7 +554,7 @@ static inline int swap_duplicate(swp_entry=
_t swp)
> >> >> >> >       return 0;
> >> >> >> >  }
> >> >> >> >
> >> >> >> > -static inline int swapcache_prepare(swp_entry_t swp)
> >> >> >> > +static inline int swapcache_prepare(swp_entry_t swp, int nr)
> >> >> >> >  {
> >> >> >> >       return 0;
> >> >> >> >  }
> >> >> >> > diff --git a/mm/memory.c b/mm/memory.c
> >> >> >> > index 833d2cad6eb2..b8675617a5e3 100644
> >> >> >> > --- a/mm/memory.c
> >> >> >> > +++ b/mm/memory.c
> >> >> >> > @@ -4081,7 +4081,7 @@ vm_fault_t do_swap_page(struct vm_fault =
*vmf)
> >> >> >> >                        * reusing the same entry. It's undetect=
able as
> >> >> >> >                        * pte_same() returns true due to entry =
reuse.
> >> >> >> >                        */
> >> >> >> > -                     if (swapcache_prepare(entry)) {
> >> >> >> > +                     if (swapcache_prepare(entry, 1)) {
> >> >> >> >                               /* Relax a bit to prevent rapid =
repeated page faults */
> >> >> >> >                               schedule_timeout_uninterruptible=
(1);
> >> >> >> >                               goto out;
> >> >> >> > @@ -4387,7 +4387,7 @@ vm_fault_t do_swap_page(struct vm_fault =
*vmf)
> >> >> >> >  out:
> >> >> >> >       /* Clear the swap cache pin for direct swapin after PTL =
unlock */
> >> >> >> >       if (need_clear_cache)
> >> >> >> > -             swapcache_clear(si, entry);
> >> >> >> > +             swapcache_clear(si, entry, 1);
> >> >> >> >       if (si)
> >> >> >> >               put_swap_device(si);
> >> >> >> >       return ret;
> >> >> >> > @@ -4403,7 +4403,7 @@ vm_fault_t do_swap_page(struct vm_fault =
*vmf)
> >> >> >> >               folio_put(swapcache);
> >> >> >> >       }
> >> >> >> >       if (need_clear_cache)
> >> >> >> > -             swapcache_clear(si, entry);
> >> >> >> > +             swapcache_clear(si, entry, 1);
> >> >> >> >       if (si)
> >> >> >> >               put_swap_device(si);
> >> >> >> >       return ret;
> >> >> >> > diff --git a/mm/swap.h b/mm/swap.h
> >> >> >> > index baa1fa946b34..7c6330561d84 100644
> >> >> >> > --- a/mm/swap.h
> >> >> >> > +++ b/mm/swap.h
> >> >> >> > @@ -59,7 +59,7 @@ void __delete_from_swap_cache(struct folio *=
folio,
> >> >> >> >  void delete_from_swap_cache(struct folio *folio);
> >> >> >> >  void clear_shadow_from_swap_cache(int type, unsigned long beg=
in,
> >> >> >> >                                 unsigned long end);
> >> >> >> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t=
 entry);
> >> >> >> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t=
 entry, int nr);
> >> >> >> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
> >> >> >> >               struct vm_area_struct *vma, unsigned long addr);
> >> >> >> >  struct folio *filemap_get_incore_folio(struct address_space *=
mapping,
> >> >> >> > @@ -120,7 +120,7 @@ static inline int swap_writepage(struct pa=
ge *p, struct writeback_control *wbc)
> >> >> >> >       return 0;
> >> >> >> >  }
> >> >> >> >
> >> >> >> > -static inline void swapcache_clear(struct swap_info_struct *s=
i, swp_entry_t entry)
> >> >> >> > +static inline void swapcache_clear(struct swap_info_struct *s=
i, swp_entry_t entry, int nr)
> >> >> >> >  {
> >> >> >> >  }
> >> >> >> >
> >> >> >> > @@ -172,4 +172,5 @@ static inline unsigned int folio_swap_flag=
s(struct folio *folio)
> >> >> >> >       return 0;
> >> >> >> >  }
> >> >> >> >  #endif /* CONFIG_SWAP */
> >> >> >> > +
> >> >> >>
> >> >> >> NITPICK: Is it necessary to add a blank line here?  But I don't =
think a
> >> >> >> new version is necessary if this is the only change needed.
> >> >> >
> >> >> > No need to add a blank line; it was probably a mistake I made in =
Vim.
> >> >> >
> >> >> >>
> >> >> >> >  #endif /* _MM_SWAP_H */
> >> >> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> >> >> >> > index a1726e49a5eb..b06f2a054f5a 100644
> >> >> >> > --- a/mm/swap_state.c
> >> >> >> > +++ b/mm/swap_state.c
> >> >> >> > @@ -477,7 +477,7 @@ struct folio *__read_swap_cache_async(swp_=
entry_t entry, gfp_t gfp_mask,
> >> >> >> >               /*
> >> >> >> >                * Swap entry may have been freed since our call=
er observed it.
> >> >> >> >                */
> >> >> >> > -             err =3D swapcache_prepare(entry);
> >> >> >> > +             err =3D swapcache_prepare(entry, 1);
> >> >> >> >               if (!err)
> >> >> >> >                       break;
> >> >> >> >
> >> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> >> >> > index 5f73a8553371..757d38a86f56 100644
> >> >> >> > --- a/mm/swapfile.c
> >> >> >> > +++ b/mm/swapfile.c
> >> >> >> > @@ -3363,7 +3363,7 @@ void si_swapinfo(struct sysinfo *val)
> >> >> >> >  }
> >> >> >> >
> >> >> >> >  /*
> >> >> >> > - * Verify that a swap entry is valid and increment its swap m=
ap count.
> >> >> >> > + * Verify that nr swap entries are valid and increment their =
swap map counts.
> >> >> >> >   *
> >> >> >> >   * Returns error code in following case.
> >> >> >> >   * - success -> 0
> >> >> >> > @@ -3373,60 +3373,77 @@ void si_swapinfo(struct sysinfo *val)
> >> >> >> >   * - swap-cache reference is requested but the entry is not u=
sed. -> ENOENT
> >> >> >> >   * - swap-mapped reference requested but needs continued swap=
 count. -> ENOMEM
> >> >> >> >   */
> >> >> >> > -static int __swap_duplicate(swp_entry_t entry, unsigned char =
usage)
> >> >> >> > +static int __swap_duplicate(swp_entry_t entry, unsigned char =
usage, int nr)
> >> >> >> >  {
> >> >> >> >       struct swap_info_struct *p;
> >> >> >> >       struct swap_cluster_info *ci;
> >> >> >> >       unsigned long offset;
> >> >> >> >       unsigned char count;
> >> >> >> >       unsigned char has_cache;
> >> >> >> > -     int err;
> >> >> >> > +     int err, i;
> >> >> >> >
> >> >> >> >       p =3D swp_swap_info(entry);
> >> >> >> >
> >> >> >> >       offset =3D swp_offset(entry);
> >> >> >> > +     VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLU=
STER);
> >> >> >> >       ci =3D lock_cluster_or_swap_info(p, offset);
> >> >> >> >
> >> >> >> > -     count =3D p->swap_map[offset];
> >> >> >> > +     err =3D 0;
> >> >> >> > +     for (i =3D 0; i < nr; i++) {
> >> >> >> > +             count =3D p->swap_map[offset + i];
> >> >> >> >
> >> >> >> > -     /*
> >> >> >> > -      * swapin_readahead() doesn't check if a swap entry is v=
alid, so the
> >> >> >> > -      * swap entry could be SWAP_MAP_BAD. Check here with loc=
k held.
> >> >> >> > -      */
> >> >> >> > -     if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
> >> >> >> > -             err =3D -ENOENT;
> >> >> >> > -             goto unlock_out;
> >> >> >> > -     }
> >> >> >> > +             /*
> >> >> >> > +              * swapin_readahead() doesn't check if a swap en=
try is valid, so the
> >> >> >> > +              * swap entry could be SWAP_MAP_BAD. Check here =
with lock held.
> >> >> >> > +              */
> >> >> >> > +             if (unlikely(swap_count(count) =3D=3D SWAP_MAP_B=
AD)) {
> >> >> >> > +                     err =3D -ENOENT;
> >> >> >> > +                     goto unlock_out;
> >> >> >> > +             }
> >> >> >> >
> >> >> >> > -     has_cache =3D count & SWAP_HAS_CACHE;
> >> >> >> > -     count &=3D ~SWAP_HAS_CACHE;
> >> >> >> > -     err =3D 0;
> >> >> >> > +             has_cache =3D count & SWAP_HAS_CACHE;
> >> >> >> > +             count &=3D ~SWAP_HAS_CACHE;
> >> >> >> >
> >> >> >> > -     if (usage =3D=3D SWAP_HAS_CACHE) {
> >> >> >> > +             if (usage =3D=3D SWAP_HAS_CACHE) {
> >> >> >> > +                     /* set SWAP_HAS_CACHE if there is no cac=
he and entry is used */
> >> >> >> > +                     if (!has_cache && count)
> >> >> >> > +                             continue;
> >> >> >> > +                     else if (has_cache)             /* someo=
ne else added cache */
> >> >> >> > +                             err =3D -EEXIST;
> >> >> >> > +                     else                            /* no us=
ers remaining */
> >> >> >> > +                             err =3D -ENOENT;
> >> >> >> >
> >> >> >> > -             /* set SWAP_HAS_CACHE if there is no cache and e=
ntry is used */
> >> >> >> > -             if (!has_cache && count)
> >> >> >> > -                     has_cache =3D SWAP_HAS_CACHE;
> >> >> >> > -             else if (has_cache)             /* someone else =
added cache */
> >> >> >> > -                     err =3D -EEXIST;
> >> >> >> > -             else                            /* no users rema=
ining */
> >> >> >> > -                     err =3D -ENOENT;
> >> >> >> > +             } else if (count || has_cache) {
> >> >> >> >
> >> >> >> > -     } else if (count || has_cache) {
> >> >> >> > +                     if ((count & ~COUNT_CONTINUED) < SWAP_MA=
P_MAX)
> >> >> >> > +                             continue;
> >> >> >> > +                     else if ((count & ~COUNT_CONTINUED) > SW=
AP_MAP_MAX)
> >> >> >> > +                             err =3D -EINVAL;
> >> >> >> > +                     else if (swap_count_continued(p, offset =
+ i, count))
> >> >> >> > +                             continue;
> >> >> >>
> >> >> >> IIUC, this will make the change to swap map directly instead of
> >> >> >> verification.  If the verification failed for some entry later, =
the
> >> >> >> count will be wrong?  Or I missed something?
> >> >> >
> >> >> > To avoid using a bitmap or a larger stack, we actually verify dur=
ing
> >> >> > the first iteration.
> >> >> > This ensures that by the second iteration, we can safely commit t=
he
> >> >> > modification.
> >> >> >
> >> >> > I actually put some words in the changelog :-)
> >> >> >
> >> >> > To optimize stack usage, we iterate twice in __swap_duplicate(): =
the
> >> >> > first time to verify that all entries are valid, and the second t=
ime
> >> >> > to apply the modifications to the entries.
> >> >>
> >> >> Yes, I have seen it and I think that it is a good strategy.
> >> >>
> >> >> But, IIUC, swap_count_continued() will change the higher bits of th=
e
> >> >> swap_map instead of verifying.  Or, my understanding is wrong?
> >> >>
> >> >
> >> > Ying, your understanding is 100% correct. but the code also has noth=
ing
> >> > broken. we didn't extend swap_duplicate() to have argument nr,
> >> > so all users which can set usage=3D1 will definitely have nr=3D1.
> >> >
> >> > int swap_duplicate(swp_entry_t entry)
> >> > {
> >> >         int err =3D 0;
> >> >
> >> >         while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOMEM)
> >> >                 err =3D add_swap_count_continuation(entry, GFP_ATOMI=
C);
> >> >         return err;
> >> > }
> >>
> >> I understand that we don't have requirements to support "usage =3D=3D =
1 &&
> >> nr > 1" case for __swap_duplicate() at least for now.
> >>
> >> > Maybe I can add a VM_WARN_ON to warn those people who might
> >> > want to extend swap_duplicate()? in that case, things could be quite
> >> > tricky.
> >> >
> >> > --- a/mm/swapfile.c
> >> > +++ b/mm/swapfile.c
> >> > @@ -3386,6 +3386,7 @@ static int __swap_duplicate(swp_entry_t entry,
> >> > unsigned char usage, int nr)
> >> >
> >> >         offset =3D swp_offset(entry);
> >> >         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER=
);
> >> > +       VM_WARN_ON(usage =3D=3D 1 && nr > 1);
> >> >         ci =3D lock_cluster_or_swap_info(p, offset);
> >> >
> >> >         err =3D 0;
> >>
> >> Please add this.  And, I think that we need to make it explicit in pat=
ch
> >> description and comments to avoid potential confusing.
> >
> > cool. make sense to me. I will post something for Andrew to squash into=
.
> >
> >>
> >> And, because it's hard to implement the verify and change strategy if
> >> "usage =3D=3D 1".  Can we only use that strategy for "usage =3D=3D
> >> SWAP_HAS_CACHE"?
> >
> > I believe Baolin also needs the case for shmem. I don't feel a strong
> > need to split two logics(1 and non-1) as the code will be quite ugly :-=
)
>
> Don't need to split like that, it could be something like
>
>         for (i =3D 0; i < nr; i++) {
>                 if (usage =3D=3D SWAP_HAS_CACHE) {
>                         /* Only verify for SWAP_HAS_CACHE */
>                 }
>         }
>
>         for (i =3D 0; i < nr; i++) {
>                 if (usage =3D=3D SWAP_HAS_CACHE) {
>                 } else {
>                         /* Verify and change for usage =3D=3D 1 */
>                 }
>         }
>

but we also have cases where nr can be > 1
        __swap_duplicate(entry, SWAP_MAP_SHMEM, 1);

> --
> Best Regards,
> Huang, Ying
>
> >>
> >> >> >>
> >> >> >> > +                     else
> >> >> >> > +                             err =3D -ENOMEM;
> >> >> >> > +             } else
> >> >> >> > +                     err =3D -ENOENT;                  /* unu=
sed swap entry */
> >> >> >> >
> >> >> >> > -             if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> >> >> >> > +             if (err)
> >> >> >> > +                     goto unlock_out;
> >> >> >> > +     }
> >> >> >> > +
> >> >> >> > +     for (i =3D 0; i < nr; i++) {
> >> >> >> > +             count =3D p->swap_map[offset + i];
> >> >> >> > +             has_cache =3D count & SWAP_HAS_CACHE;
> >> >> >> > +             count &=3D ~SWAP_HAS_CACHE;
> >> >> >> > +
> >> >> >> > +             if (usage =3D=3D SWAP_HAS_CACHE)
> >> >> >> > +                     has_cache =3D SWAP_HAS_CACHE;
> >> >> >> > +             else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_M=
AX)
> >> >> >> >                       count +=3D usage;
> >> >> >> > -             else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_M=
AX)
> >> >> >> > -                     err =3D -EINVAL;
> >> >> >> > -             else if (swap_count_continued(p, offset, count))
> >> >> >> > -                     count =3D COUNT_CONTINUED;
> >> >> >> >               else
> >> >> >> > -                     err =3D -ENOMEM;
> >> >> >> > -     } else
> >> >> >> > -             err =3D -ENOENT;                  /* unused swap=
 entry */
> >> >> >> > +                     count =3D COUNT_CONTINUED;
> >> >> >> >
> >> >> >> > -     if (!err)
> >> >> >> > -             WRITE_ONCE(p->swap_map[offset], count | has_cach=
e);
> >> >> >> > +             WRITE_ONCE(p->swap_map[offset + i], count | has_=
cache);
> >> >> >> > +     }
> >> >> >> >
> >> >> >> >  unlock_out:
> >> >> >> >       unlock_cluster_or_swap_info(p, ci);
> >> >> >> > @@ -3439,7 +3456,7 @@ static int __swap_duplicate(swp_entry_t =
entry, unsigned char usage)
> >> >> >> >   */
> >> >> >> >  void swap_shmem_alloc(swp_entry_t entry)
> >> >> >> >  {
> >> >> >> > -     __swap_duplicate(entry, SWAP_MAP_SHMEM);
> >> >> >> > +     __swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
> >> >> >> >  }
> >> >> >> >
> >> >> >> >  /*
> >> >> >> > @@ -3453,29 +3470,29 @@ int swap_duplicate(swp_entry_t entry)
> >> >> >> >  {
> >> >> >> >       int err =3D 0;
> >> >> >> >
> >> >> >> > -     while (!err && __swap_duplicate(entry, 1) =3D=3D -ENOMEM=
)
> >> >> >> > +     while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENO=
MEM)
> >> >> >> >               err =3D add_swap_count_continuation(entry, GFP_A=
TOMIC);
> >> >> >> >       return err;
> >> >> >> >  }
> >> >> >> >
> >> >> >> >  /*
> >> >> >> > - * @entry: swap entry for which we allocate swap cache.
> >> >> >> > + * @entry: first swap entry from which we allocate nr swap ca=
che.
> >> >> >> >   *
> >> >> >> > - * Called when allocating swap cache for existing swap entry,
> >> >> >> > + * Called when allocating swap cache for existing swap entrie=
s,
> >> >> >> >   * This can return error codes. Returns 0 at success.
> >> >> >> >   * -EEXIST means there is a swap cache.
> >> >> >> >   * Note: return code is different from swap_duplicate().
> >> >> >> >   */
> >> >> >> > -int swapcache_prepare(swp_entry_t entry)
> >> >> >> > +int swapcache_prepare(swp_entry_t entry, int nr)
> >> >> >> >  {
> >> >> >> > -     return __swap_duplicate(entry, SWAP_HAS_CACHE);
> >> >> >> > +     return __swap_duplicate(entry, SWAP_HAS_CACHE, nr);
> >> >> >> >  }
> >> >> >> >
> >> >> >> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t=
 entry)
> >> >> >> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t=
 entry, int nr)
> >> >> >> >  {
> >> >> >> >       unsigned long offset =3D swp_offset(entry);
> >> >> >> >
> >> >> >> > -     cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
> >> >> >> > +     cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
> >> >> >> >  }
> >> >> >> >
> >> >> >> >  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
> >> >> >>
> >> >> >> --
> >> >> >> Best Regards,
> >> >> >> Huang, Ying
> >> >> >
> >
> > Thanks
> > Barry

