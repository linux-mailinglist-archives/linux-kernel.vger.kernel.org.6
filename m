Return-Path: <linux-kernel+bounces-270548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F03944168
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B764B21A0E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4452132106;
	Thu,  1 Aug 2024 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUPsaTFL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C949647
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722479877; cv=none; b=NkuVqAMpOxmu2OcYQt0H4KPXuuLucXWg64bfRIN3xYuIzxATQBbpEHiV9NEgdKWs/sGFJF5K4f8Kcjb3Bz6eWaz/cv4S4KqM7fp7XEg6s8tyS0R7s1EbvT21BFAw6VdgLMWfYBxZMB5v8QvloeJxKdBTmzC3GvoYK607g83mnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722479877; c=relaxed/simple;
	bh=mh93zm0rpx6HFPCWgyzbWKNBDwO1dj00g9JWm5LWCXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fctblnLktbHPoNq+3TiLCZx+8gRjXeY3kdOf/BiHAzhd2350ZOJ7zfzR3LK4GrhkbryYlB/h/TDfwA1RAbnRHunmtf2tRIJ7h8O8911jWD9fkwuBr2dUrWcll48GlRS61PE6Y6U6fWkt55qf8WNobanRDDfGwanXvVEO8VKT3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUPsaTFL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722479875; x=1754015875;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=mh93zm0rpx6HFPCWgyzbWKNBDwO1dj00g9JWm5LWCXc=;
  b=XUPsaTFLP6OgDq1bocGd94hrsk83DAwgHxcPO6rjp0gfWhBgE+o0BPbb
   HvhilENKLrxQlgthw2oAfxvedDlb10aD+R8pr+13Bu2lm0AcqCUrkm53d
   3t2thNRgVzB/bovMjqLBJE3pfFqfaMspbhkvf4r7VHFdcRQlxyKrYaasb
   RBz3//tZy6hWDMIpL7ufcatd5iCPtoWrJ4gH018MRF2FLt0wWaPQxj8hN
   sW9mHQ6HfxBgbTi/ybDg5Z4uMppvIWsHehYAqqQ+i8KHNaPK8kLl14vwh
   YGuvJnvpOFghygewMz/zWmAmdBfZoWyGIkxa911I8wF6Z6DBKuQ0b3LbP
   Q==;
X-CSE-ConnectionGUID: Za8jX4yGQImV71o6AskJoA==
X-CSE-MsgGUID: 1sLW2crvRvivpT9hPfHjMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="19986005"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="19986005"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 19:36:30 -0700
X-CSE-ConnectionGUID: z3/V1uzhTO2R+/7LuhcN8w==
X-CSE-MsgGUID: /3h3tcugR8OkJw5rOctE6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59924069"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 19:36:24 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hannes@cmpxchg.org,  hughd@google.com,  kaleshsingh@google.com,
  kasong@tencent.com,  linux-kernel@vger.kernel.org,  mhocko@suse.com,
  minchan@kernel.org,  nphamcs@gmail.com,  ryan.roberts@arm.com,
  senozhatsky@chromium.org,  shakeel.butt@linux.dev,  shy828301@gmail.com,
  surenb@google.com,  v-songbaohua@oppo.com,  willy@infradead.org,
  xiang@kernel.org,  yosryahmed@google.com
Subject: Re: [PATCH 1/1] mm: swap: add nr argument in swapcache_prepare and
 swapcache_clear to support large folios
In-Reply-To: <CAGsJ_4ypk1RQ3jNnGJ6tgsXaWw55oU2f9Qp84k6+wb5JHUCcmQ@mail.gmail.com>
	(Barry Song's message of "Thu, 1 Aug 2024 10:07:05 +0800")
References: <20240730071339.107447-1-21cnbao@gmail.com>
	<20240730071339.107447-2-21cnbao@gmail.com>
	<874j86oubf.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wH1qbG5hQ8K-OyvO5ut+rFo3Ng_+pUp7wMLWo-1PwERg@mail.gmail.com>
	<87zfpynf2r.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wAUSFn7x3OznRjKnQk2k=mM7gJr8b4CTJt2VwNKdn1jA@mail.gmail.com>
	<871q39kq0e.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4ypk1RQ3jNnGJ6tgsXaWw55oU2f9Qp84k6+wb5JHUCcmQ@mail.gmail.com>
Date: Thu, 01 Aug 2024 10:32:50 +0800
Message-ID: <87wml1j7l9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Thu, Aug 1, 2024 at 9:13=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Wed, Jul 31, 2024 at 4:28=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Wed, Jul 31, 2024 at 4:14=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Hi, Barry,
>> >> >>
>> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >>
>> >> >> > From: Barry Song <v-songbaohua@oppo.com>
>> >> >> >
>> >> >> > Right now, swapcache_prepare() and swapcache_clear() supports on=
e entry
>> >> >> > only, to support large folios, we need to handle multiple swap e=
ntries.
>> >> >> >
>> >> >> > To optimize stack usage, we iterate twice in __swap_duplicate():=
 the
>> >> >> > first time to verify that all entries are valid, and the second =
time
>> >> >> > to apply the modifications to the entries.
>> >> >> >
>> >> >> > Currently, we're using nr=3D1 for the existing users.
>> >> >> >
>> >> >> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> >> >> > ---
>> >> >> >  include/linux/swap.h |   4 +-
>> >> >> >  mm/memory.c          |   6 +--
>> >> >> >  mm/swap.h            |   5 ++-
>> >> >> >  mm/swap_state.c      |   2 +-
>> >> >> >  mm/swapfile.c        | 101 +++++++++++++++++++++++++-----------=
-------
>> >> >> >  5 files changed, 68 insertions(+), 50 deletions(-)
>> >> >> >
>> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
>> >> >> > index ba7ea95d1c57..5b920fa2315b 100644
>> >> >> > --- a/include/linux/swap.h
>> >> >> > +++ b/include/linux/swap.h
>> >> >> > @@ -480,7 +480,7 @@ extern int get_swap_pages(int n, swp_entry_t=
 swp_entries[], int order);
>> >> >> >  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>> >> >> >  extern void swap_shmem_alloc(swp_entry_t);
>> >> >> >  extern int swap_duplicate(swp_entry_t);
>> >> >> > -extern int swapcache_prepare(swp_entry_t);
>> >> >> > +extern int swapcache_prepare(swp_entry_t entry, int nr);
>> >> >> >  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>> >> >> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>> >> >> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>> >> >> > @@ -554,7 +554,7 @@ static inline int swap_duplicate(swp_entry_t=
 swp)
>> >> >> >       return 0;
>> >> >> >  }
>> >> >> >
>> >> >> > -static inline int swapcache_prepare(swp_entry_t swp)
>> >> >> > +static inline int swapcache_prepare(swp_entry_t swp, int nr)
>> >> >> >  {
>> >> >> >       return 0;
>> >> >> >  }
>> >> >> > diff --git a/mm/memory.c b/mm/memory.c
>> >> >> > index 833d2cad6eb2..b8675617a5e3 100644
>> >> >> > --- a/mm/memory.c
>> >> >> > +++ b/mm/memory.c
>> >> >> > @@ -4081,7 +4081,7 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
>> >> >> >                        * reusing the same entry. It's undetectab=
le as
>> >> >> >                        * pte_same() returns true due to entry re=
use.
>> >> >> >                        */
>> >> >> > -                     if (swapcache_prepare(entry)) {
>> >> >> > +                     if (swapcache_prepare(entry, 1)) {
>> >> >> >                               /* Relax a bit to prevent rapid re=
peated page faults */
>> >> >> >                               schedule_timeout_uninterruptible(1=
);
>> >> >> >                               goto out;
>> >> >> > @@ -4387,7 +4387,7 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
>> >> >> >  out:
>> >> >> >       /* Clear the swap cache pin for direct swapin after PTL un=
lock */
>> >> >> >       if (need_clear_cache)
>> >> >> > -             swapcache_clear(si, entry);
>> >> >> > +             swapcache_clear(si, entry, 1);
>> >> >> >       if (si)
>> >> >> >               put_swap_device(si);
>> >> >> >       return ret;
>> >> >> > @@ -4403,7 +4403,7 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
>> >> >> >               folio_put(swapcache);
>> >> >> >       }
>> >> >> >       if (need_clear_cache)
>> >> >> > -             swapcache_clear(si, entry);
>> >> >> > +             swapcache_clear(si, entry, 1);
>> >> >> >       if (si)
>> >> >> >               put_swap_device(si);
>> >> >> >       return ret;
>> >> >> > diff --git a/mm/swap.h b/mm/swap.h
>> >> >> > index baa1fa946b34..7c6330561d84 100644
>> >> >> > --- a/mm/swap.h
>> >> >> > +++ b/mm/swap.h
>> >> >> > @@ -59,7 +59,7 @@ void __delete_from_swap_cache(struct folio *fo=
lio,
>> >> >> >  void delete_from_swap_cache(struct folio *folio);
>> >> >> >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>> >> >> >                                 unsigned long end);
>> >> >> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t e=
ntry);
>> >> >> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t e=
ntry, int nr);
>> >> >> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
>> >> >> >               struct vm_area_struct *vma, unsigned long addr);
>> >> >> >  struct folio *filemap_get_incore_folio(struct address_space *ma=
pping,
>> >> >> > @@ -120,7 +120,7 @@ static inline int swap_writepage(struct page=
 *p, struct writeback_control *wbc)
>> >> >> >       return 0;
>> >> >> >  }
>> >> >> >
>> >> >> > -static inline void swapcache_clear(struct swap_info_struct *si,=
 swp_entry_t entry)
>> >> >> > +static inline void swapcache_clear(struct swap_info_struct *si,=
 swp_entry_t entry, int nr)
>> >> >> >  {
>> >> >> >  }
>> >> >> >
>> >> >> > @@ -172,4 +172,5 @@ static inline unsigned int folio_swap_flags(=
struct folio *folio)
>> >> >> >       return 0;
>> >> >> >  }
>> >> >> >  #endif /* CONFIG_SWAP */
>> >> >> > +
>> >> >>
>> >> >> NITPICK: Is it necessary to add a blank line here?  But I don't th=
ink a
>> >> >> new version is necessary if this is the only change needed.
>> >> >
>> >> > No need to add a blank line; it was probably a mistake I made in Vi=
m.
>> >> >
>> >> >>
>> >> >> >  #endif /* _MM_SWAP_H */
>> >> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> >> >> > index a1726e49a5eb..b06f2a054f5a 100644
>> >> >> > --- a/mm/swap_state.c
>> >> >> > +++ b/mm/swap_state.c
>> >> >> > @@ -477,7 +477,7 @@ struct folio *__read_swap_cache_async(swp_en=
try_t entry, gfp_t gfp_mask,
>> >> >> >               /*
>> >> >> >                * Swap entry may have been freed since our caller=
 observed it.
>> >> >> >                */
>> >> >> > -             err =3D swapcache_prepare(entry);
>> >> >> > +             err =3D swapcache_prepare(entry, 1);
>> >> >> >               if (!err)
>> >> >> >                       break;
>> >> >> >
>> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> >> >> > index 5f73a8553371..757d38a86f56 100644
>> >> >> > --- a/mm/swapfile.c
>> >> >> > +++ b/mm/swapfile.c
>> >> >> > @@ -3363,7 +3363,7 @@ void si_swapinfo(struct sysinfo *val)
>> >> >> >  }
>> >> >> >
>> >> >> >  /*
>> >> >> > - * Verify that a swap entry is valid and increment its swap map=
 count.
>> >> >> > + * Verify that nr swap entries are valid and increment their sw=
ap map counts.
>> >> >> >   *
>> >> >> >   * Returns error code in following case.
>> >> >> >   * - success -> 0
>> >> >> > @@ -3373,60 +3373,77 @@ void si_swapinfo(struct sysinfo *val)
>> >> >> >   * - swap-cache reference is requested but the entry is not use=
d. -> ENOENT
>> >> >> >   * - swap-mapped reference requested but needs continued swap c=
ount. -> ENOMEM
>> >> >> >   */
>> >> >> > -static int __swap_duplicate(swp_entry_t entry, unsigned char us=
age)
>> >> >> > +static int __swap_duplicate(swp_entry_t entry, unsigned char us=
age, int nr)
>> >> >> >  {
>> >> >> >       struct swap_info_struct *p;
>> >> >> >       struct swap_cluster_info *ci;
>> >> >> >       unsigned long offset;
>> >> >> >       unsigned char count;
>> >> >> >       unsigned char has_cache;
>> >> >> > -     int err;
>> >> >> > +     int err, i;
>> >> >> >
>> >> >> >       p =3D swp_swap_info(entry);
>> >> >> >
>> >> >> >       offset =3D swp_offset(entry);
>> >> >> > +     VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUST=
ER);
>> >> >> >       ci =3D lock_cluster_or_swap_info(p, offset);
>> >> >> >
>> >> >> > -     count =3D p->swap_map[offset];
>> >> >> > +     err =3D 0;
>> >> >> > +     for (i =3D 0; i < nr; i++) {
>> >> >> > +             count =3D p->swap_map[offset + i];
>> >> >> >
>> >> >> > -     /*
>> >> >> > -      * swapin_readahead() doesn't check if a swap entry is val=
id, so the
>> >> >> > -      * swap entry could be SWAP_MAP_BAD. Check here with lock =
held.
>> >> >> > -      */
>> >> >> > -     if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
>> >> >> > -             err =3D -ENOENT;
>> >> >> > -             goto unlock_out;
>> >> >> > -     }
>> >> >> > +             /*
>> >> >> > +              * swapin_readahead() doesn't check if a swap entr=
y is valid, so the
>> >> >> > +              * swap entry could be SWAP_MAP_BAD. Check here wi=
th lock held.
>> >> >> > +              */
>> >> >> > +             if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD=
)) {
>> >> >> > +                     err =3D -ENOENT;
>> >> >> > +                     goto unlock_out;
>> >> >> > +             }
>> >> >> >
>> >> >> > -     has_cache =3D count & SWAP_HAS_CACHE;
>> >> >> > -     count &=3D ~SWAP_HAS_CACHE;
>> >> >> > -     err =3D 0;
>> >> >> > +             has_cache =3D count & SWAP_HAS_CACHE;
>> >> >> > +             count &=3D ~SWAP_HAS_CACHE;
>> >> >> >
>> >> >> > -     if (usage =3D=3D SWAP_HAS_CACHE) {
>> >> >> > +             if (usage =3D=3D SWAP_HAS_CACHE) {
>> >> >> > +                     /* set SWAP_HAS_CACHE if there is no cache=
 and entry is used */
>> >> >> > +                     if (!has_cache && count)
>> >> >> > +                             continue;
>> >> >> > +                     else if (has_cache)             /* someone=
 else added cache */
>> >> >> > +                             err =3D -EEXIST;
>> >> >> > +                     else                            /* no user=
s remaining */
>> >> >> > +                             err =3D -ENOENT;
>> >> >> >
>> >> >> > -             /* set SWAP_HAS_CACHE if there is no cache and ent=
ry is used */
>> >> >> > -             if (!has_cache && count)
>> >> >> > -                     has_cache =3D SWAP_HAS_CACHE;
>> >> >> > -             else if (has_cache)             /* someone else ad=
ded cache */
>> >> >> > -                     err =3D -EEXIST;
>> >> >> > -             else                            /* no users remain=
ing */
>> >> >> > -                     err =3D -ENOENT;
>> >> >> > +             } else if (count || has_cache) {
>> >> >> >
>> >> >> > -     } else if (count || has_cache) {
>> >> >> > +                     if ((count & ~COUNT_CONTINUED) < SWAP_MAP_=
MAX)
>> >> >> > +                             continue;
>> >> >> > +                     else if ((count & ~COUNT_CONTINUED) > SWAP=
_MAP_MAX)
>> >> >> > +                             err =3D -EINVAL;
>> >> >> > +                     else if (swap_count_continued(p, offset + =
i, count))
>> >> >> > +                             continue;
>> >> >>
>> >> >> IIUC, this will make the change to swap map directly instead of
>> >> >> verification.  If the verification failed for some entry later, the
>> >> >> count will be wrong?  Or I missed something?
>> >> >
>> >> > To avoid using a bitmap or a larger stack, we actually verify during
>> >> > the first iteration.
>> >> > This ensures that by the second iteration, we can safely commit the
>> >> > modification.
>> >> >
>> >> > I actually put some words in the changelog :-)
>> >> >
>> >> > To optimize stack usage, we iterate twice in __swap_duplicate(): the
>> >> > first time to verify that all entries are valid, and the second time
>> >> > to apply the modifications to the entries.
>> >>
>> >> Yes, I have seen it and I think that it is a good strategy.
>> >>
>> >> But, IIUC, swap_count_continued() will change the higher bits of the
>> >> swap_map instead of verifying.  Or, my understanding is wrong?
>> >>
>> >
>> > Ying, your understanding is 100% correct. but the code also has nothing
>> > broken. we didn't extend swap_duplicate() to have argument nr,
>> > so all users which can set usage=3D1 will definitely have nr=3D1.
>> >
>> > int swap_duplicate(swp_entry_t entry)
>> > {
>> >         int err =3D 0;
>> >
>> >         while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOMEM)
>> >                 err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
>> >         return err;
>> > }
>>
>> I understand that we don't have requirements to support "usage =3D=3D 1 =
&&
>> nr > 1" case for __swap_duplicate() at least for now.
>>
>> > Maybe I can add a VM_WARN_ON to warn those people who might
>> > want to extend swap_duplicate()? in that case, things could be quite
>> > tricky.
>> >
>> > --- a/mm/swapfile.c
>> > +++ b/mm/swapfile.c
>> > @@ -3386,6 +3386,7 @@ static int __swap_duplicate(swp_entry_t entry,
>> > unsigned char usage, int nr)
>> >
>> >         offset =3D swp_offset(entry);
>> >         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
>> > +       VM_WARN_ON(usage =3D=3D 1 && nr > 1);
>> >         ci =3D lock_cluster_or_swap_info(p, offset);
>> >
>> >         err =3D 0;
>>
>> Please add this.  And, I think that we need to make it explicit in patch
>> description and comments to avoid potential confusing.
>
> cool. make sense to me. I will post something for Andrew to squash into.
>
>>
>> And, because it's hard to implement the verify and change strategy if
>> "usage =3D=3D 1".  Can we only use that strategy for "usage =3D=3D
>> SWAP_HAS_CACHE"?
>
> I believe Baolin also needs the case for shmem. I don't feel a strong
> need to split two logics(1 and non-1) as the code will be quite ugly :-)

Don't need to split like that, it could be something like

	for (i =3D 0; i < nr; i++) {
                if (usage =3D=3D SWAP_HAS_CACHE) {
                        /* Only verify for SWAP_HAS_CACHE */
                }
        }

        for (i =3D 0; i < nr; i++) {
                if (usage =3D=3D SWAP_HAS_CACHE) {
                } else {
                        /* Verify and change for usage =3D=3D 1 */
                }
        }

--
Best Regards,
Huang, Ying

>>
>> >> >>
>> >> >> > +                     else
>> >> >> > +                             err =3D -ENOMEM;
>> >> >> > +             } else
>> >> >> > +                     err =3D -ENOENT;                  /* unuse=
d swap entry */
>> >> >> >
>> >> >> > -             if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
>> >> >> > +             if (err)
>> >> >> > +                     goto unlock_out;
>> >> >> > +     }
>> >> >> > +
>> >> >> > +     for (i =3D 0; i < nr; i++) {
>> >> >> > +             count =3D p->swap_map[offset + i];
>> >> >> > +             has_cache =3D count & SWAP_HAS_CACHE;
>> >> >> > +             count &=3D ~SWAP_HAS_CACHE;
>> >> >> > +
>> >> >> > +             if (usage =3D=3D SWAP_HAS_CACHE)
>> >> >> > +                     has_cache =3D SWAP_HAS_CACHE;
>> >> >> > +             else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
>> >> >> >                       count +=3D usage;
>> >> >> > -             else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
>> >> >> > -                     err =3D -EINVAL;
>> >> >> > -             else if (swap_count_continued(p, offset, count))
>> >> >> > -                     count =3D COUNT_CONTINUED;
>> >> >> >               else
>> >> >> > -                     err =3D -ENOMEM;
>> >> >> > -     } else
>> >> >> > -             err =3D -ENOENT;                  /* unused swap e=
ntry */
>> >> >> > +                     count =3D COUNT_CONTINUED;
>> >> >> >
>> >> >> > -     if (!err)
>> >> >> > -             WRITE_ONCE(p->swap_map[offset], count | has_cache);
>> >> >> > +             WRITE_ONCE(p->swap_map[offset + i], count | has_ca=
che);
>> >> >> > +     }
>> >> >> >
>> >> >> >  unlock_out:
>> >> >> >       unlock_cluster_or_swap_info(p, ci);
>> >> >> > @@ -3439,7 +3456,7 @@ static int __swap_duplicate(swp_entry_t en=
try, unsigned char usage)
>> >> >> >   */
>> >> >> >  void swap_shmem_alloc(swp_entry_t entry)
>> >> >> >  {
>> >> >> > -     __swap_duplicate(entry, SWAP_MAP_SHMEM);
>> >> >> > +     __swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
>> >> >> >  }
>> >> >> >
>> >> >> >  /*
>> >> >> > @@ -3453,29 +3470,29 @@ int swap_duplicate(swp_entry_t entry)
>> >> >> >  {
>> >> >> >       int err =3D 0;
>> >> >> >
>> >> >> > -     while (!err && __swap_duplicate(entry, 1) =3D=3D -ENOMEM)
>> >> >> > +     while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOME=
M)
>> >> >> >               err =3D add_swap_count_continuation(entry, GFP_ATO=
MIC);
>> >> >> >       return err;
>> >> >> >  }
>> >> >> >
>> >> >> >  /*
>> >> >> > - * @entry: swap entry for which we allocate swap cache.
>> >> >> > + * @entry: first swap entry from which we allocate nr swap cach=
e.
>> >> >> >   *
>> >> >> > - * Called when allocating swap cache for existing swap entry,
>> >> >> > + * Called when allocating swap cache for existing swap entries,
>> >> >> >   * This can return error codes. Returns 0 at success.
>> >> >> >   * -EEXIST means there is a swap cache.
>> >> >> >   * Note: return code is different from swap_duplicate().
>> >> >> >   */
>> >> >> > -int swapcache_prepare(swp_entry_t entry)
>> >> >> > +int swapcache_prepare(swp_entry_t entry, int nr)
>> >> >> >  {
>> >> >> > -     return __swap_duplicate(entry, SWAP_HAS_CACHE);
>> >> >> > +     return __swap_duplicate(entry, SWAP_HAS_CACHE, nr);
>> >> >> >  }
>> >> >> >
>> >> >> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t e=
ntry)
>> >> >> > +void swapcache_clear(struct swap_info_struct *si, swp_entry_t e=
ntry, int nr)
>> >> >> >  {
>> >> >> >       unsigned long offset =3D swp_offset(entry);
>> >> >> >
>> >> >> > -     cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
>> >> >> > +     cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
>> >> >> >  }
>> >> >> >
>> >> >> >  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
>> >> >>
>> >> >> --
>> >> >> Best Regards,
>> >> >> Huang, Ying
>> >> >
>
> Thanks
> Barry

