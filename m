Return-Path: <linux-kernel+bounces-270529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1C09440FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4841C23EB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E510146D78;
	Thu,  1 Aug 2024 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH6JXPKv"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515A13D8B2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722478041; cv=none; b=QIeUAcJJ4q8o59K8vcvKpFv+0Ec17HEJPQYOK9Kmkmxl0+bEoZ2Y7VUvDx1QwbmOuBBhm7g270SnuIOg2oHHF61XCxXYV52ZX65OtNsxUaMxO79XqTI9SScOq9L5lK7Tynzzze8h1Zpk01fPWtoYwDEJyZYlG/hQ9zofuNn0g+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722478041; c=relaxed/simple;
	bh=thXno7VyXJkOi/PEvDAxiMKAgIs2zoepFSEvITBlDD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSQJVFqiAZODuNzTpWrTJV8gBgEA4D6NH7soF5QOTOX3N3az/fUrjw9zUuENyMPFe7jhO+TAjJTNqNG8x65pVqRKDUreBoaNDHpm39vnZKfh4OMSeKSAjoD1tE8XFAlhIh2IBxsSaypDlyDhW0m7R32ML2rjU7sndSjtwMrk0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fH6JXPKv; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-492a09d4c42so1549345137.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722478038; x=1723082838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPgCfrE6s1SqmvRg/f6N9INj2p53v7nDyKO2JNF8QsM=;
        b=fH6JXPKv09CnSCOOdHHABjc4jBVAMx562evlINveYS0FiR9bwWObMCZU/YbBZQ2vC6
         HyrzZJp/pTsFEuWhu/Kg/rG4kX8h9LYoXdwHmhdSLu3OdcDTO7WireAg/QqMmoOeBU62
         V9UNA1fCZzykZT0zuZ73WDVHrTzwZ9GBCDuktlu4KH7qzQQj9ywzC+uu2IIN7iU6zIQb
         Bp582P16pCXP7Li4RKD8BqeAaWfRQW5TKbmlWssGX3F9pllsqHjCPZyX0z7HZnfueiHT
         KQNMe3E75/sIV4DdTaMVRQAKT9gmUiFeiP/rzcSYvzsSS34Qcvgml9MnJGbbZ+MveJzw
         U5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722478038; x=1723082838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPgCfrE6s1SqmvRg/f6N9INj2p53v7nDyKO2JNF8QsM=;
        b=Yp+o5riuROVo3l0F8aVrqRQCq3ffKAjAg23+Y8JoODbYX+yIJ15/OAeOrB2esX/bgq
         m46wApdsfLA9/idK25OVhpa/KxudiZCdWZJvB8Kcc5uHbehfMw5DgprChTEuZ0kClGtQ
         hm6hJMxlsU0qMgecHr4Mgk3fZbmulpxk87zD96YBOixe8Z0t4xFrV8FVTUrCeUlFQrWD
         PKKMEidRHkAgxscpBsAdZhDhiURBIJ3GuL6eUeOdWaSoABre2beiS5BOJeCKr4k7NRfO
         RLV416XyUv1VhXRQ/6MKjf5ZjnzpKLWzKilWrGE+C/DMmx/O39WKZXT7ohgmoiCC/LP6
         W8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWDHAgh/kDc+x1sH8WdxUaU931uabiUTQCnDryR1Qv6NINKQLkF+T8y4I1QaQvZ/0vVzvsdVrxz3rZ0Lk1e0zp2vDaUwKbUM1/r67P
X-Gm-Message-State: AOJu0Yzlv8mn0g2PF0O0o0unBf0WMoJ5X/tbhDrNWpzLmwatcesplwkM
	cG3Uwv96l+ofhyVMTTV9MS/FYC29MPTn/5K+Vpy0kGY0iD2skHTDma/N1RaBqpXyfsSz6hOOwK0
	ZCW/OB8fWyDain8QESfxsRVhXAcA=
X-Google-Smtp-Source: AGHT+IE15fWelSv58xepqg5vJWMkjAUBZiws655TLHnU0T2zfZn+o3havsm1pNxPRCjVgSzJVtKiU/Rn3UseSXu3czY=
X-Received: by 2002:a05:6102:38d4:b0:493:b0c2:ad3c with SMTP id
 ada2fe7eead31-4945099bb12mr1786504137.22.1722478038194; Wed, 31 Jul 2024
 19:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730071339.107447-1-21cnbao@gmail.com> <20240730071339.107447-2-21cnbao@gmail.com>
 <874j86oubf.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wH1qbG5hQ8K-OyvO5ut+rFo3Ng_+pUp7wMLWo-1PwERg@mail.gmail.com>
 <87zfpynf2r.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wAUSFn7x3OznRjKnQk2k=mM7gJr8b4CTJt2VwNKdn1jA@mail.gmail.com>
 <871q39kq0e.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871q39kq0e.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 1 Aug 2024 10:07:05 +0800
Message-ID: <CAGsJ_4ypk1RQ3jNnGJ6tgsXaWw55oU2f9Qp84k6+wb5JHUCcmQ@mail.gmail.com>
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

On Thu, Aug 1, 2024 at 9:13=E2=80=AFAM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Jul 31, 2024 at 4:28=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Wed, Jul 31, 2024 at 4:14=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Hi, Barry,
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >> >
> >> >> > Right now, swapcache_prepare() and swapcache_clear() supports one=
 entry
> >> >> > only, to support large folios, we need to handle multiple swap en=
tries.
> >> >> >
> >> >> > To optimize stack usage, we iterate twice in __swap_duplicate(): =
the
> >> >> > first time to verify that all entries are valid, and the second t=
ime
> >> >> > to apply the modifications to the entries.
> >> >> >
> >> >> > Currently, we're using nr=3D1 for the existing users.
> >> >> >
> >> >> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> >> > ---
> >> >> >  include/linux/swap.h |   4 +-
> >> >> >  mm/memory.c          |   6 +--
> >> >> >  mm/swap.h            |   5 ++-
> >> >> >  mm/swap_state.c      |   2 +-
> >> >> >  mm/swapfile.c        | 101 +++++++++++++++++++++++++------------=
------
> >> >> >  5 files changed, 68 insertions(+), 50 deletions(-)
> >> >> >
> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> >> > index ba7ea95d1c57..5b920fa2315b 100644
> >> >> > --- a/include/linux/swap.h
> >> >> > +++ b/include/linux/swap.h
> >> >> > @@ -480,7 +480,7 @@ extern int get_swap_pages(int n, swp_entry_t =
swp_entries[], int order);
> >> >> >  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> >> >> >  extern void swap_shmem_alloc(swp_entry_t);
> >> >> >  extern int swap_duplicate(swp_entry_t);
> >> >> > -extern int swapcache_prepare(swp_entry_t);
> >> >> > +extern int swapcache_prepare(swp_entry_t entry, int nr);
> >> >> >  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >> >> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >> >> > @@ -554,7 +554,7 @@ static inline int swap_duplicate(swp_entry_t =
swp)
> >> >> >       return 0;
> >> >> >  }
> >> >> >
> >> >> > -static inline int swapcache_prepare(swp_entry_t swp)
> >> >> > +static inline int swapcache_prepare(swp_entry_t swp, int nr)
> >> >> >  {
> >> >> >       return 0;
> >> >> >  }
> >> >> > diff --git a/mm/memory.c b/mm/memory.c
> >> >> > index 833d2cad6eb2..b8675617a5e3 100644
> >> >> > --- a/mm/memory.c
> >> >> > +++ b/mm/memory.c
> >> >> > @@ -4081,7 +4081,7 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> >> >> >                        * reusing the same entry. It's undetectabl=
e as
> >> >> >                        * pte_same() returns true due to entry reu=
se.
> >> >> >                        */
> >> >> > -                     if (swapcache_prepare(entry)) {
> >> >> > +                     if (swapcache_prepare(entry, 1)) {
> >> >> >                               /* Relax a bit to prevent rapid rep=
eated page faults */
> >> >> >                               schedule_timeout_uninterruptible(1)=
;
> >> >> >                               goto out;
> >> >> > @@ -4387,7 +4387,7 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> >> >> >  out:
> >> >> >       /* Clear the swap cache pin for direct swapin after PTL unl=
ock */
> >> >> >       if (need_clear_cache)
> >> >> > -             swapcache_clear(si, entry);
> >> >> > +             swapcache_clear(si, entry, 1);
> >> >> >       if (si)
> >> >> >               put_swap_device(si);
> >> >> >       return ret;
> >> >> > @@ -4403,7 +4403,7 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> >> >> >               folio_put(swapcache);
> >> >> >       }
> >> >> >       if (need_clear_cache)
> >> >> > -             swapcache_clear(si, entry);
> >> >> > +             swapcache_clear(si, entry, 1);
> >> >> >       if (si)
> >> >> >               put_swap_device(si);
> >> >> >       return ret;
> >> >> > diff --git a/mm/swap.h b/mm/swap.h
> >> >> > index baa1fa946b34..7c6330561d84 100644
> >> >> > --- a/mm/swap.h
> >> >> > +++ b/mm/swap.h
> >> >> > @@ -59,7 +59,7 @@ void __delete_from_swap_cache(struct folio *fol=
io,
> >> >> >  void delete_from_swap_cache(struct folio *folio);
> >> >> >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
> >> >> >                                 unsigned long end);
> >> >> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t en=
try);
> >> >> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t en=
try, int nr);
> >> >> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
> >> >> >               struct vm_area_struct *vma, unsigned long addr);
> >> >> >  struct folio *filemap_get_incore_folio(struct address_space *map=
ping,
> >> >> > @@ -120,7 +120,7 @@ static inline int swap_writepage(struct page =
*p, struct writeback_control *wbc)
> >> >> >       return 0;
> >> >> >  }
> >> >> >
> >> >> > -static inline void swapcache_clear(struct swap_info_struct *si, =
swp_entry_t entry)
> >> >> > +static inline void swapcache_clear(struct swap_info_struct *si, =
swp_entry_t entry, int nr)
> >> >> >  {
> >> >> >  }
> >> >> >
> >> >> > @@ -172,4 +172,5 @@ static inline unsigned int folio_swap_flags(s=
truct folio *folio)
> >> >> >       return 0;
> >> >> >  }
> >> >> >  #endif /* CONFIG_SWAP */
> >> >> > +
> >> >>
> >> >> NITPICK: Is it necessary to add a blank line here?  But I don't thi=
nk a
> >> >> new version is necessary if this is the only change needed.
> >> >
> >> > No need to add a blank line; it was probably a mistake I made in Vim=
.
> >> >
> >> >>
> >> >> >  #endif /* _MM_SWAP_H */
> >> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> >> >> > index a1726e49a5eb..b06f2a054f5a 100644
> >> >> > --- a/mm/swap_state.c
> >> >> > +++ b/mm/swap_state.c
> >> >> > @@ -477,7 +477,7 @@ struct folio *__read_swap_cache_async(swp_ent=
ry_t entry, gfp_t gfp_mask,
> >> >> >               /*
> >> >> >                * Swap entry may have been freed since our caller =
observed it.
> >> >> >                */
> >> >> > -             err =3D swapcache_prepare(entry);
> >> >> > +             err =3D swapcache_prepare(entry, 1);
> >> >> >               if (!err)
> >> >> >                       break;
> >> >> >
> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> >> > index 5f73a8553371..757d38a86f56 100644
> >> >> > --- a/mm/swapfile.c
> >> >> > +++ b/mm/swapfile.c
> >> >> > @@ -3363,7 +3363,7 @@ void si_swapinfo(struct sysinfo *val)
> >> >> >  }
> >> >> >
> >> >> >  /*
> >> >> > - * Verify that a swap entry is valid and increment its swap map =
count.
> >> >> > + * Verify that nr swap entries are valid and increment their swa=
p map counts.
> >> >> >   *
> >> >> >   * Returns error code in following case.
> >> >> >   * - success -> 0
> >> >> > @@ -3373,60 +3373,77 @@ void si_swapinfo(struct sysinfo *val)
> >> >> >   * - swap-cache reference is requested but the entry is not used=
. -> ENOENT
> >> >> >   * - swap-mapped reference requested but needs continued swap co=
unt. -> ENOMEM
> >> >> >   */
> >> >> > -static int __swap_duplicate(swp_entry_t entry, unsigned char usa=
ge)
> >> >> > +static int __swap_duplicate(swp_entry_t entry, unsigned char usa=
ge, int nr)
> >> >> >  {
> >> >> >       struct swap_info_struct *p;
> >> >> >       struct swap_cluster_info *ci;
> >> >> >       unsigned long offset;
> >> >> >       unsigned char count;
> >> >> >       unsigned char has_cache;
> >> >> > -     int err;
> >> >> > +     int err, i;
> >> >> >
> >> >> >       p =3D swp_swap_info(entry);
> >> >> >
> >> >> >       offset =3D swp_offset(entry);
> >> >> > +     VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTE=
R);
> >> >> >       ci =3D lock_cluster_or_swap_info(p, offset);
> >> >> >
> >> >> > -     count =3D p->swap_map[offset];
> >> >> > +     err =3D 0;
> >> >> > +     for (i =3D 0; i < nr; i++) {
> >> >> > +             count =3D p->swap_map[offset + i];
> >> >> >
> >> >> > -     /*
> >> >> > -      * swapin_readahead() doesn't check if a swap entry is vali=
d, so the
> >> >> > -      * swap entry could be SWAP_MAP_BAD. Check here with lock h=
eld.
> >> >> > -      */
> >> >> > -     if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
> >> >> > -             err =3D -ENOENT;
> >> >> > -             goto unlock_out;
> >> >> > -     }
> >> >> > +             /*
> >> >> > +              * swapin_readahead() doesn't check if a swap entry=
 is valid, so the
> >> >> > +              * swap entry could be SWAP_MAP_BAD. Check here wit=
h lock held.
> >> >> > +              */
> >> >> > +             if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)=
) {
> >> >> > +                     err =3D -ENOENT;
> >> >> > +                     goto unlock_out;
> >> >> > +             }
> >> >> >
> >> >> > -     has_cache =3D count & SWAP_HAS_CACHE;
> >> >> > -     count &=3D ~SWAP_HAS_CACHE;
> >> >> > -     err =3D 0;
> >> >> > +             has_cache =3D count & SWAP_HAS_CACHE;
> >> >> > +             count &=3D ~SWAP_HAS_CACHE;
> >> >> >
> >> >> > -     if (usage =3D=3D SWAP_HAS_CACHE) {
> >> >> > +             if (usage =3D=3D SWAP_HAS_CACHE) {
> >> >> > +                     /* set SWAP_HAS_CACHE if there is no cache =
and entry is used */
> >> >> > +                     if (!has_cache && count)
> >> >> > +                             continue;
> >> >> > +                     else if (has_cache)             /* someone =
else added cache */
> >> >> > +                             err =3D -EEXIST;
> >> >> > +                     else                            /* no users=
 remaining */
> >> >> > +                             err =3D -ENOENT;
> >> >> >
> >> >> > -             /* set SWAP_HAS_CACHE if there is no cache and entr=
y is used */
> >> >> > -             if (!has_cache && count)
> >> >> > -                     has_cache =3D SWAP_HAS_CACHE;
> >> >> > -             else if (has_cache)             /* someone else add=
ed cache */
> >> >> > -                     err =3D -EEXIST;
> >> >> > -             else                            /* no users remaini=
ng */
> >> >> > -                     err =3D -ENOENT;
> >> >> > +             } else if (count || has_cache) {
> >> >> >
> >> >> > -     } else if (count || has_cache) {
> >> >> > +                     if ((count & ~COUNT_CONTINUED) < SWAP_MAP_M=
AX)
> >> >> > +                             continue;
> >> >> > +                     else if ((count & ~COUNT_CONTINUED) > SWAP_=
MAP_MAX)
> >> >> > +                             err =3D -EINVAL;
> >> >> > +                     else if (swap_count_continued(p, offset + i=
, count))
> >> >> > +                             continue;
> >> >>
> >> >> IIUC, this will make the change to swap map directly instead of
> >> >> verification.  If the verification failed for some entry later, the
> >> >> count will be wrong?  Or I missed something?
> >> >
> >> > To avoid using a bitmap or a larger stack, we actually verify during
> >> > the first iteration.
> >> > This ensures that by the second iteration, we can safely commit the
> >> > modification.
> >> >
> >> > I actually put some words in the changelog :-)
> >> >
> >> > To optimize stack usage, we iterate twice in __swap_duplicate(): the
> >> > first time to verify that all entries are valid, and the second time
> >> > to apply the modifications to the entries.
> >>
> >> Yes, I have seen it and I think that it is a good strategy.
> >>
> >> But, IIUC, swap_count_continued() will change the higher bits of the
> >> swap_map instead of verifying.  Or, my understanding is wrong?
> >>
> >
> > Ying, your understanding is 100% correct. but the code also has nothing
> > broken. we didn't extend swap_duplicate() to have argument nr,
> > so all users which can set usage=3D1 will definitely have nr=3D1.
> >
> > int swap_duplicate(swp_entry_t entry)
> > {
> >         int err =3D 0;
> >
> >         while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOMEM)
> >                 err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
> >         return err;
> > }
>
> I understand that we don't have requirements to support "usage =3D=3D 1 &=
&
> nr > 1" case for __swap_duplicate() at least for now.
>
> > Maybe I can add a VM_WARN_ON to warn those people who might
> > want to extend swap_duplicate()? in that case, things could be quite
> > tricky.
> >
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3386,6 +3386,7 @@ static int __swap_duplicate(swp_entry_t entry,
> > unsigned char usage, int nr)
> >
> >         offset =3D swp_offset(entry);
> >         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> > +       VM_WARN_ON(usage =3D=3D 1 && nr > 1);
> >         ci =3D lock_cluster_or_swap_info(p, offset);
> >
> >         err =3D 0;
>
> Please add this.  And, I think that we need to make it explicit in patch
> description and comments to avoid potential confusing.

cool. make sense to me. I will post something for Andrew to squash into.

>
> And, because it's hard to implement the verify and change strategy if
> "usage =3D=3D 1".  Can we only use that strategy for "usage =3D=3D
> SWAP_HAS_CACHE"?

I believe Baolin also needs the case for shmem. I don't feel a strong
need to split two logics(1 and non-1) as the code will be quite ugly :-)

>
> --
> Best Regards,
> Huang, Ying
>
> >> >>
> >> >> > +                     else
> >> >> > +                             err =3D -ENOMEM;
> >> >> > +             } else
> >> >> > +                     err =3D -ENOENT;                  /* unused=
 swap entry */
> >> >> >
> >> >> > -             if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> >> >> > +             if (err)
> >> >> > +                     goto unlock_out;
> >> >> > +     }
> >> >> > +
> >> >> > +     for (i =3D 0; i < nr; i++) {
> >> >> > +             count =3D p->swap_map[offset + i];
> >> >> > +             has_cache =3D count & SWAP_HAS_CACHE;
> >> >> > +             count &=3D ~SWAP_HAS_CACHE;
> >> >> > +
> >> >> > +             if (usage =3D=3D SWAP_HAS_CACHE)
> >> >> > +                     has_cache =3D SWAP_HAS_CACHE;
> >> >> > +             else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> >> >> >                       count +=3D usage;
> >> >> > -             else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> >> >> > -                     err =3D -EINVAL;
> >> >> > -             else if (swap_count_continued(p, offset, count))
> >> >> > -                     count =3D COUNT_CONTINUED;
> >> >> >               else
> >> >> > -                     err =3D -ENOMEM;
> >> >> > -     } else
> >> >> > -             err =3D -ENOENT;                  /* unused swap en=
try */
> >> >> > +                     count =3D COUNT_CONTINUED;
> >> >> >
> >> >> > -     if (!err)
> >> >> > -             WRITE_ONCE(p->swap_map[offset], count | has_cache);
> >> >> > +             WRITE_ONCE(p->swap_map[offset + i], count | has_cac=
he);
> >> >> > +     }
> >> >> >
> >> >> >  unlock_out:
> >> >> >       unlock_cluster_or_swap_info(p, ci);
> >> >> > @@ -3439,7 +3456,7 @@ static int __swap_duplicate(swp_entry_t ent=
ry, unsigned char usage)
> >> >> >   */
> >> >> >  void swap_shmem_alloc(swp_entry_t entry)
> >> >> >  {
> >> >> > -     __swap_duplicate(entry, SWAP_MAP_SHMEM);
> >> >> > +     __swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
> >> >> >  }
> >> >> >
> >> >> >  /*
> >> >> > @@ -3453,29 +3470,29 @@ int swap_duplicate(swp_entry_t entry)
> >> >> >  {
> >> >> >       int err =3D 0;
> >> >> >
> >> >> > -     while (!err && __swap_duplicate(entry, 1) =3D=3D -ENOMEM)
> >> >> > +     while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOMEM=
)
> >> >> >               err =3D add_swap_count_continuation(entry, GFP_ATOM=
IC);
> >> >> >       return err;
> >> >> >  }
> >> >> >
> >> >> >  /*
> >> >> > - * @entry: swap entry for which we allocate swap cache.
> >> >> > + * @entry: first swap entry from which we allocate nr swap cache=
.
> >> >> >   *
> >> >> > - * Called when allocating swap cache for existing swap entry,
> >> >> > + * Called when allocating swap cache for existing swap entries,
> >> >> >   * This can return error codes. Returns 0 at success.
> >> >> >   * -EEXIST means there is a swap cache.
> >> >> >   * Note: return code is different from swap_duplicate().
> >> >> >   */
> >> >> > -int swapcache_prepare(swp_entry_t entry)
> >> >> > +int swapcache_prepare(swp_entry_t entry, int nr)
> >> >> >  {
> >> >> > -     return __swap_duplicate(entry, SWAP_HAS_CACHE);
> >> >> > +     return __swap_duplicate(entry, SWAP_HAS_CACHE, nr);
> >> >> >  }
> >> >> >
> >> >> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t en=
try)
> >> >> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t en=
try, int nr)
> >> >> >  {
> >> >> >       unsigned long offset =3D swp_offset(entry);
> >> >> >
> >> >> > -     cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
> >> >> > +     cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
> >> >> >  }
> >> >> >
> >> >> >  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
> >> >>
> >> >> --
> >> >> Best Regards,
> >> >> Huang, Ying
> >> >

Thanks
Barry

