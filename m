Return-Path: <linux-kernel+bounces-272035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13247945618
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68922286A14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319B15AC4;
	Fri,  2 Aug 2024 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9itwkHr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AD8F70
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722563406; cv=none; b=WQeHTHZXsGVBhT9RNKRNNrBXPXpO12ujI5NVpRIJ/7zKURvcvJFVpEms8AoOF8E4chnDrUpWfX/3Cpa9U8AG9CCwT6N8idhh+y38U94CvcZnNS4f10tF6PGCs6G6jy3QJMXT1EIvFeNRk8S68aiH0OEqQ3GIOYVgIkHPHtKPZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722563406; c=relaxed/simple;
	bh=jtVXwOC3H2mJ2d488Y50qTsU4T1kBZRFPLHRRqzbIaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EaaE5jQROP27ulua49RX55ktkjDcImrWCi0SlXdwGhow4P2JDCvamP/r6WcLkhj6KS2jjGivJ5YFB8TI49sKThXe6cLrlHAilIl95uUrdcyYfAJmmmQc95ybMjRwTF8DdyOsEosov3TFmYsQ0CQNMSUxc2R/zhQ3tWtJqSzyG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9itwkHr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722563402; x=1754099402;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=jtVXwOC3H2mJ2d488Y50qTsU4T1kBZRFPLHRRqzbIaI=;
  b=T9itwkHrNMlVlWGA/2fqYPEZqSOcArNC8hcaWsa/+GCrHbj6FRMFFh9L
   ipRBKX/P5AkFMR7vUV3EKjSCzQravuUAj96fq4JrfwKe/0+Yc65SXDzuk
   qYFGSqoJ6rxutxOGkyu57kf3MGo5UtdSkHxK7Qt5qlq2EWp3e3DrVhKUl
   W0cbrDd5JO2UWim4tUyXF0YWAgEjnaVRrZ399wuHQYMdA1XJn/VooxeXg
   wB8biNg7jOFxEA0vbudCWeMC5PP/W1zh/gUbCuvIQ7HjX5ntFqJtvrXKE
   3CXBRd/ggfBwWv4iM+wSRH4rlrkKnr2uWRIGjcxQmc6dACu4vwdH9wXGO
   w==;
X-CSE-ConnectionGUID: Mcyi/S8DSnapBv0YRNdDGw==
X-CSE-MsgGUID: J2t/ZIN5Q76LI96iJ/DYig==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="38068036"
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="38068036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 18:50:01 -0700
X-CSE-ConnectionGUID: y0DTHLyPS6mgfFD5s7cKdg==
X-CSE-MsgGUID: CFulMNsJT3OnDqNmz06ebg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="59571867"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 18:49:56 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  baolin.wang@linux.alibaba.com,
  chrisl@kernel.org,  david@redhat.com,  hannes@cmpxchg.org,
  hughd@google.com,  kaleshsingh@google.com,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  mhocko@suse.com,
  minchan@kernel.org,  nphamcs@gmail.com,  ryan.roberts@arm.com,
  senozhatsky@chromium.org,  shakeel.butt@linux.dev,  shy828301@gmail.com,
  surenb@google.com,  v-songbaohua@oppo.com,  willy@infradead.org,
  xiang@kernel.org,  yosryahmed@google.com
Subject: Re: [PATCH 1/1] mm: swap: add nr argument in swapcache_prepare and
 swapcache_clear to support large folios
In-Reply-To: <20240801092014.41549-1-21cnbao@gmail.com> (Barry Song's message
	of "Thu, 1 Aug 2024 21:20:14 +1200")
References: <87sevpj6xp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240801092014.41549-1-21cnbao@gmail.com>
Date: Fri, 02 Aug 2024 09:46:23 +0800
Message-ID: <87bk2bk87k.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Aug 1, 2024 at 2:50=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Thu, Aug 1, 2024 at 10:37=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Thu, Aug 1, 2024 at 9:13=E2=80=AFAM Huang, Ying <ying.huang@inte=
l.com> wrote:
>> >> >>
>> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >>
>> >> >> > On Wed, Jul 31, 2024 at 4:28=E2=80=AFPM Huang, Ying <ying.huang@=
intel.com> wrote:
>> >> >> >>
>> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >> >>
>> >> >> >> > On Wed, Jul 31, 2024 at 4:14=E2=80=AFPM Huang, Ying <ying.hua=
ng@intel.com> wrote:
>> >> >> >> >>
>> >> >> >> >> Hi, Barry,
>> >> >> >> >>
>> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >> >> >>
>> >> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
>> >> >> >> >> >
>> >> >> >> >> > Right now, swapcache_prepare() and swapcache_clear() suppo=
rts one entry
>> >> >> >> >> > only, to support large folios, we need to handle multiple =
swap entries.
>> >> >> >> >> >
>> >> >> >> >> > To optimize stack usage, we iterate twice in __swap_duplic=
ate(): the
>> >> >> >> >> > first time to verify that all entries are valid, and the s=
econd time
>> >> >> >> >> > to apply the modifications to the entries.
>> >> >> >> >> >
>> >> >> >> >> > Currently, we're using nr=3D1 for the existing users.
>> >> >> >> >> >
>> >> >> >> >> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> >> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> >> >> >> >> > ---
>> >> >> >> >> > =C2=A0include/linux/swap.h | =C2=A0 4 +-
>> >> >> >> >> > =C2=A0mm/memory.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 6 +--
>> >> >> >> >> > =C2=A0mm/swap.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 5 ++-
>> >> >> >> >> > =C2=A0mm/swap_state.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 2 +-
>> >> >> >> >> > =C2=A0mm/swapfile.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| 101 +++++=
++++++++++++++++++++------------------
>> >> >> >> >> > =C2=A05 files changed, 68 insertions(+), 50 deletions(-)
>> >> >> >> >> >
>> >> >> >> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
>> >> >> >> >> > index ba7ea95d1c57..5b920fa2315b 100644
>> >> >> >> >> > --- a/include/linux/swap.h
>> >> >> >> >> > +++ b/include/linux/swap.h
>> >> >> >> >> > @@ -480,7 +480,7 @@ extern int get_swap_pages(int n, swp_e=
ntry_t swp_entries[], int order);
>> >> >> >> >> > =C2=A0extern int add_swap_count_continuation(swp_entry_t, =
gfp_t);
>> >> >> >> >> > =C2=A0extern void swap_shmem_alloc(swp_entry_t);
>> >> >> >> >> > =C2=A0extern int swap_duplicate(swp_entry_t);
>> >> >> >> >> > -extern int swapcache_prepare(swp_entry_t);
>> >> >> >> >> > +extern int swapcache_prepare(swp_entry_t entry, int nr);
>> >> >> >> >> > =C2=A0extern void swap_free_nr(swp_entry_t entry, int nr_p=
ages);
>> >> >> >> >> > =C2=A0extern void swapcache_free_entries(swp_entry_t *entr=
ies, int n);
>> >> >> >> >> > =C2=A0extern void free_swap_and_cache_nr(swp_entry_t entry=
, int nr);
>> >> >> >> >> > @@ -554,7 +554,7 @@ static inline int swap_duplicate(swp_e=
ntry_t swp)
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 return 0;
>> >> >> >> >> > =C2=A0}
>> >> >> >> >> >
>> >> >> >> >> > -static inline int swapcache_prepare(swp_entry_t swp)
>> >> >> >> >> > +static inline int swapcache_prepare(swp_entry_t swp, int =
nr)
>> >> >> >> >> > =C2=A0{
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 return 0;
>> >> >> >> >> > =C2=A0}
>> >> >> >> >> > diff --git a/mm/memory.c b/mm/memory.c
>> >> >> >> >> > index 833d2cad6eb2..b8675617a5e3 100644
>> >> >> >> >> > --- a/mm/memory.c
>> >> >> >> >> > +++ b/mm/memory.c
>> >> >> >> >> > @@ -4081,7 +4081,7 @@ vm_fault_t do_swap_page(struct vm_fa=
ult *vmf)
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0* reusing the same entry. It's undetectable as
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0* pte_same() returns true due to entry reuse.
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (swapcache_prepare(entry)) {
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (swapcache_prepare(entry, 1)) {
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Relax a bit to prevent =
rapid repeated page faults */
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_timeout_uninterru=
ptible(1);
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>> >> >> >> >> > @@ -4387,7 +4387,7 @@ vm_fault_t do_swap_page(struct vm_fa=
ult *vmf)
>> >> >> >> >> > =C2=A0out:
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 /* Clear the swap cache pin for direc=
t swapin after PTL unlock */
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 if (need_clear_cache)
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 swapcache_clea=
r(si, entry);
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 swapcache_clea=
r(si, entry, 1);
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 if (si)
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_swap_=
device(si);
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 return ret;
>> >> >> >> >> > @@ -4403,7 +4403,7 @@ vm_fault_t do_swap_page(struct vm_fa=
ult *vmf)
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 folio_put=
(swapcache);
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 }
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 if (need_clear_cache)
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 swapcache_clea=
r(si, entry);
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 swapcache_clea=
r(si, entry, 1);
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 if (si)
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_swap_=
device(si);
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 return ret;
>> >> >> >> >> > diff --git a/mm/swap.h b/mm/swap.h
>> >> >> >> >> > index baa1fa946b34..7c6330561d84 100644
>> >> >> >> >> > --- a/mm/swap.h
>> >> >> >> >> > +++ b/mm/swap.h
>> >> >> >> >> > @@ -59,7 +59,7 @@ void __delete_from_swap_cache(struct fol=
io *folio,
>> >> >> >> >> > =C2=A0void delete_from_swap_cache(struct folio *folio);
>> >> >> >> >> > =C2=A0void clear_shadow_from_swap_cache(int type, unsigned=
 long begin,
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long end);
>> >> >> >> >> > -void swapcache_clear(struct swap_info_struct *si, swp_ent=
ry_t entry);
>> >> >> >> >> > +void swapcache_clear(struct swap_info_struct *si, swp_ent=
ry_t entry, int nr);
>> >> >> >> >> > =C2=A0struct folio *swap_cache_get_folio(swp_entry_t entry,
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vm=
_area_struct *vma, unsigned long addr);
>> >> >> >> >> > =C2=A0struct folio *filemap_get_incore_folio(struct addres=
s_space *mapping,
>> >> >> >> >> > @@ -120,7 +120,7 @@ static inline int swap_writepage(struc=
t page *p, struct writeback_control *wbc)
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 return 0;
>> >> >> >> >> > =C2=A0}
>> >> >> >> >> >
>> >> >> >> >> > -static inline void swapcache_clear(struct swap_info_struc=
t *si, swp_entry_t entry)
>> >> >> >> >> > +static inline void swapcache_clear(struct swap_info_struc=
t *si, swp_entry_t entry, int nr)
>> >> >> >> >> > =C2=A0{
>> >> >> >> >> > =C2=A0}
>> >> >> >> >> >
>> >> >> >> >> > @@ -172,4 +172,5 @@ static inline unsigned int folio_swap_=
flags(struct folio *folio)
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 return 0;
>> >> >> >> >> > =C2=A0}
>> >> >> >> >> > =C2=A0#endif /* CONFIG_SWAP */
>> >> >> >> >> > +
>> >> >> >> >>
>> >> >> >> >> NITPICK: Is it necessary to add a blank line here? =C2=A0But=
 I don't think a
>> >> >> >> >> new version is necessary if this is the only change needed.
>> >> >> >> >
>> >> >> >> > No need to add a blank line; it was probably a mistake I made=
 in Vim.
>> >> >> >> >
>> >> >> >> >>
>> >> >> >> >> > =C2=A0#endif /* _MM_SWAP_H */
>> >> >> >> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> >> >> >> >> > index a1726e49a5eb..b06f2a054f5a 100644
>> >> >> >> >> > --- a/mm/swap_state.c
>> >> >> >> >> > +++ b/mm/swap_state.c
>> >> >> >> >> > @@ -477,7 +477,7 @@ struct folio *__read_swap_cache_async(=
swp_entry_t entry, gfp_t gfp_mask,
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* S=
wap entry may have been freed since our caller observed it.
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D swapca=
che_prepare(entry);
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D swapca=
che_prepare(entry, 1);
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!err)
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 break;
>> >> >> >> >> >
>> >> >> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> >> >> >> >> > index 5f73a8553371..757d38a86f56 100644
>> >> >> >> >> > --- a/mm/swapfile.c
>> >> >> >> >> > +++ b/mm/swapfile.c
>> >> >> >> >> > @@ -3363,7 +3363,7 @@ void si_swapinfo(struct sysinfo *val)
>> >> >> >> >> > =C2=A0}
>> >> >> >> >> >
>> >> >> >> >> > =C2=A0/*
>> >> >> >> >> > - * Verify that a swap entry is valid and increment its sw=
ap map count.
>> >> >> >> >> > + * Verify that nr swap entries are valid and increment th=
eir swap map counts.
>> >> >> >> >> > =C2=A0 *
>> >> >> >> >> > =C2=A0 * Returns error code in following case.
>> >> >> >> >> > =C2=A0 * - success -> 0
>> >> >> >> >> > @@ -3373,60 +3373,77 @@ void si_swapinfo(struct sysinfo *v=
al)
>> >> >> >> >> > =C2=A0 * - swap-cache reference is requested but the entry=
 is not used. -> ENOENT
>> >> >> >> >> > =C2=A0 * - swap-mapped reference requested but needs conti=
nued swap count. -> ENOMEM
>> >> >> >> >> > =C2=A0 */
>> >> >> >> >> > -static int __swap_duplicate(swp_entry_t entry, unsigned c=
har usage)
>> >> >> >> >> > +static int __swap_duplicate(swp_entry_t entry, unsigned c=
har usage, int nr)
>> >> >> >> >> > =C2=A0{
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 struct swap_info_struct *p;
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 struct swap_cluster_info *ci;
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 unsigned long offset;
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 unsigned char count;
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 unsigned char has_cache;
>> >> >> >> >> > - =C2=A0 =C2=A0 int err;
>> >> >> >> >> > + =C2=A0 =C2=A0 int err, i;
>> >> >> >> >> >
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 p =3D swp_swap_info(entry);
>> >> >> >> >> >
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 offset =3D swp_offset(entry);
>> >> >> >> >> > + =C2=A0 =C2=A0 VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset =
% SWAPFILE_CLUSTER);
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 ci =3D lock_cluster_or_swap_info(p, o=
ffset);
>> >> >> >> >> >
>> >> >> >> >> > - =C2=A0 =C2=A0 count =3D p->swap_map[offset];
>> >> >> >> >> > + =C2=A0 =C2=A0 err =3D 0;
>> >> >> >> >> > + =C2=A0 =C2=A0 for (i =3D 0; i < nr; i++) {
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D p->s=
wap_map[offset + i];
>> >> >> >> >> >
>> >> >> >> >> > - =C2=A0 =C2=A0 /*
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0* swapin_readahead() doesn't check i=
f a swap entry is valid, so the
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0* swap entry could be SWAP_MAP_BAD. =
Check here with lock held.
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0*/
>> >> >> >> >> > - =C2=A0 =C2=A0 if (unlikely(swap_count(count) =3D=3D SWAP=
_MAP_BAD)) {
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOEN=
T;
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unlock_ou=
t;
>> >> >> >> >> > - =C2=A0 =C2=A0 }
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* swapin=
_readahead() doesn't check if a swap entry is valid, so the
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* swap e=
ntry could be SWAP_MAP_BAD. Check here with lock held.
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(s=
wap_count(count) =3D=3D SWAP_MAP_BAD)) {
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 err =3D -ENOENT;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 goto unlock_out;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >> >> >> >> >
>> >> >> >> >> > - =C2=A0 =C2=A0 has_cache =3D count & SWAP_HAS_CACHE;
>> >> >> >> >> > - =C2=A0 =C2=A0 count &=3D ~SWAP_HAS_CACHE;
>> >> >> >> >> > - =C2=A0 =C2=A0 err =3D 0;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_cache =3D =
count & SWAP_HAS_CACHE;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count &=3D ~SW=
AP_HAS_CACHE;
>> >> >> >> >> >
>> >> >> >> >> > - =C2=A0 =C2=A0 if (usage =3D=3D SWAP_HAS_CACHE) {
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (usage =3D=
=3D SWAP_HAS_CACHE) {
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* set SWAP_HAS_CACHE if there is no cache and entry is used =
*/
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (!has_cache && count)
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 else if (has_cache) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* someone else added cache */
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EEXIST;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 else =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* no users remaining */
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOENT;
>> >> >> >> >> >
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* set SWAP_HA=
S_CACHE if there is no cache and entry is used */
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!has_cache=
 && count)
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 has_cache =3D SWAP_HAS_CACHE;
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (has_c=
ache) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* someone else added cache=
 */
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 err =3D -EEXIST;
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* no users remaining */
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 err =3D -ENOENT;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (cou=
nt || has_cache) {
>> >> >> >> >> >
>> >> >> >> >> > - =C2=A0 =C2=A0 } else if (count || has_cache) {
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 else if (swap_count_continued(p, offset + i, count))
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> >> >> >> >>
>> >> >> >> >> IIUC, this will make the change to swap map directly instead=
 of
>> >> >> >> >> verification. =C2=A0If the verification failed for some entr=
y later, the
>> >> >> >> >> count will be wrong? =C2=A0Or I missed something?
>> >> >> >> >
>> >> >> >> > To avoid using a bitmap or a larger stack, we actually verify=
 during
>> >> >> >> > the first iteration.
>> >> >> >> > This ensures that by the second iteration, we can safely comm=
it the
>> >> >> >> > modification.
>> >> >> >> >
>> >> >> >> > I actually put some words in the changelog :-)
>> >> >> >> >
>> >> >> >> > To optimize stack usage, we iterate twice in __swap_duplicate=
(): the
>> >> >> >> > first time to verify that all entries are valid, and the seco=
nd time
>> >> >> >> > to apply the modifications to the entries.
>> >> >> >>
>> >> >> >> Yes, I have seen it and I think that it is a good strategy.
>> >> >> >>
>> >> >> >> But, IIUC, swap_count_continued() will change the higher bits o=
f the
>> >> >> >> swap_map instead of verifying. =C2=A0Or, my understanding is wr=
ong?
>> >> >> >>
>> >> >> >
>> >> >> > Ying, your understanding is 100% correct. but the code also has =
nothing
>> >> >> > broken. we didn't extend swap_duplicate() to have argument nr,
>> >> >> > so all users which can set usage=3D1 will definitely have nr=3D1.
>> >> >> >
>> >> >> > int swap_duplicate(swp_entry_t entry)
>> >> >> > {
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 int err =3D 0;
>> >> >> >
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (!err && __swap_duplicate(entr=
y, 1, 1) =3D=3D -ENOMEM)
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D =
add_swap_count_continuation(entry, GFP_ATOMIC);
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
>> >> >> > }
>> >> >>
>> >> >> I understand that we don't have requirements to support "usage =3D=
=3D 1 &&
>> >> >> nr > 1" case for __swap_duplicate() at least for now.
>> >> >>
>> >> >> > Maybe I can add a VM_WARN_ON to warn those people who might
>> >> >> > want to extend swap_duplicate()? in that case, things could be q=
uite
>> >> >> > tricky.
>> >> >> >
>> >> >> > --- a/mm/swapfile.c
>> >> >> > +++ b/mm/swapfile.c
>> >> >> > @@ -3386,6 +3386,7 @@ static int __swap_duplicate(swp_entry_t en=
try,
>> >> >> > unsigned char usage, int nr)
>> >> >> >
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D swp_offset(entry);
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 VM_WARN_ON(nr > SWAPFILE_CLUSTER - o=
ffset % SWAPFILE_CLUSTER);
>> >> >> > + =C2=A0 =C2=A0 =C2=A0 VM_WARN_ON(usage =3D=3D 1 && nr > 1);
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 ci =3D lock_cluster_or_swap_info(p, =
offset);
>> >> >> >
>> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 0;
>> >> >>
>> >> >> Please add this. =C2=A0And, I think that we need to make it explic=
it in patch
>> >> >> description and comments to avoid potential confusing.
>> >> >
>> >> > cool. make sense to me. I will post something for Andrew to squash =
into.
>> >> >
>> >> >>
>> >> >> And, because it's hard to implement the verify and change strategy=
 if
>> >> >> "usage =3D=3D 1". =C2=A0Can we only use that strategy for "usage =
=3D=3D
>> >> >> SWAP_HAS_CACHE"?
>> >> >
>> >> > I believe Baolin also needs the case for shmem. I don't feel a stro=
ng
>> >> > need to split two logics(1 and non-1) as the code will be quite ugl=
y :-)
>> >>
>> >> Don't need to split like that, it could be something like
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < nr; i++) {
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (usage =3D=
=3D SWAP_HAS_CACHE) {
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 /* Only verify for SWAP_HAS_CACHE */
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < nr; i++) {
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (usage =3D=
=3D SWAP_HAS_CACHE) {
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 /* Verify and change for usage =3D=3D 1 */
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> >>
>> >
>> > but we also have cases where nr can be > 1
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 __swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
>>
>> If we can do verification for "usage =3D=3D SWAP_MAP_SHMEM", we can add =
that
>> in the first loop.
>>
>> That is, we only do verification in the first loop, not do committing.
>> In the second loop, we can ignore verifying if we have done that in the
>> first loop.
>>
>> IMHO, this make code easier to be understood.
>
> Right. I believe the change below can help improve readability and also
> clarify the swap_count_continued() case.
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2fa29bdec171..75a89ce18edc 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3538,6 +3538,7 @@ static int __swap_duplicate(swp_entry_t entry, unsi=
gned char usage, int nr)
>=20=20
>  	offset =3D swp_offset(entry);
>  	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> +	VM_WARN_ON(usage =3D=3D 1 && nr > 1);
>  	ci =3D lock_cluster_or_swap_info(p, offset);
>=20=20
>  	err =3D 0;
> @@ -3564,17 +3565,9 @@ static int __swap_duplicate(swp_entry_t entry, uns=
igned char usage, int nr)
>  				err =3D -EEXIST;
>  			else				/* no users remaining */
>  				err =3D -ENOENT;
> -
>  		} else if (count || has_cache) {
> -
> -			if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> -				continue;
> -			else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> +			if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
>  				err =3D -EINVAL;
> -			else if (swap_count_continued(p, offset + i, count))
> -				continue;
> -			else
> -				err =3D -ENOMEM;
>  		} else
>  			err =3D -ENOENT;			/* unused swap entry */
>=20=20
> @@ -3591,8 +3584,12 @@ static int __swap_duplicate(swp_entry_t entry, uns=
igned char usage, int nr)
>  			has_cache =3D SWAP_HAS_CACHE;
>  		else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
>  			count +=3D usage;
> -		else
> +		else if (swap_count_continued(p, offset + i, count))
>  			count =3D COUNT_CONTINUED;
> +		else {
> +			err =3D -ENOMEM;
> +			goto unlock_out;
> +		}
>=20=20
>  		WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
>  	}
>
> This makes the two iterations become:
>
> 	for (i =3D 0; i < nr; i++) {
> 		count =3D p->swap_map[offset + i];
>
> 		/*
> 		 * swapin_readahead() doesn't check if a swap entry is valid, so the
> 		 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
> 		 */
> 		if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
> 			err =3D -ENOENT;
> 			goto unlock_out;
> 		}
>
> 		has_cache =3D count & SWAP_HAS_CACHE;
> 		count &=3D ~SWAP_HAS_CACHE;
>
> 		if (usage =3D=3D SWAP_HAS_CACHE) {
> 			/* set SWAP_HAS_CACHE if there is no cache and entry is used */

The comments doen't apply now, we don't "set" here.

> 			if (!has_cache && count)
> 				continue;
> 			else if (has_cache)		/* someone else added cache */
> 				err =3D -EEXIST;
> 			else				/* no users remaining */
> 				err =3D -ENOENT;
> 		} else if (count || has_cache) {
> 			if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> 				err =3D -EINVAL;
> 		} else
> 			err =3D -ENOENT;			/* unused swap entry */

It seems that this can be simplified to:

                if (!count && !has_cache) {
                        err =3D -ENOENT;
                } else if (usage =3D=3D SWAP_HAS_CACHE) {
                        if (has_cache)
                                err =3D -EEXIST;
                } else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
                        err =3D -EINVAL;
                }

> 		if (err)
> 			goto unlock_out;
> 	}
>
> 	for (i =3D 0; i < nr; i++) {
> 		count =3D p->swap_map[offset + i];
> 		has_cache =3D count & SWAP_HAS_CACHE;
> 		count &=3D ~SWAP_HAS_CACHE;
>
> 		if (usage =3D=3D SWAP_HAS_CACHE)
> 			has_cache =3D SWAP_HAS_CACHE;
> 		else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> 			count +=3D usage;
> 		else if (swap_count_continued(p, offset + i, count))
> 			count =3D COUNT_CONTINUED;
> 		else {

Better to add some comments here,

                        /*
                         * Don't need to rollback changes, because if
                         * usage =3D=3D 1, there must be nr =3D=3D 1.
                         */

> 			err =3D -ENOMEM;
> 			goto unlock_out;
> 		}
>
> 		WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
> 	}
>
> Ying, do you feel more satisfied with the version above
> compared to the code in mm-unstable?

This looks good to me except some minor comments above.  Thanks!

--
Best Regards,
Huang, Ying

> Baolin, I'd also appreciate it if you could re-test your
> shmem case if Ying is okay with the enhancement above.
>
>>
>> --
>> Best Regards,
>> Huang, Ying
>>
>> >> >>
>> >> >> >> >>
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 else
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOMEM;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 err =3D -ENOENT; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* unused swap entry */
>> >> >> >> >> >
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((count & ~=
COUNT_CONTINUED) < SWAP_MAP_MAX)
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err)
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 goto unlock_out;
>> >> >> >> >> > + =C2=A0 =C2=A0 }
>> >> >> >> >> > +
>> >> >> >> >> > + =C2=A0 =C2=A0 for (i =3D 0; i < nr; i++) {
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D p->s=
wap_map[offset + i];
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_cache =3D =
count & SWAP_HAS_CACHE;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count &=3D ~SW=
AP_HAS_CACHE;
>> >> >> >> >> > +
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (usage =3D=
=3D SWAP_HAS_CACHE)
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 has_cache =3D SWAP_HAS_CACHE;
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if ((coun=
t & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 count +=3D usage;
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if ((coun=
t & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 err =3D -EINVAL;
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (swap_=
count_continued(p, offset, count))
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 count =3D COUNT_CONTINUED;
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 err =3D -ENOMEM;
>> >> >> >> >> > - =C2=A0 =C2=A0 } else
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENOEN=
T; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* unused =
swap entry */
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 count =3D COUNT_CONTINUED;
>> >> >> >> >> >
>> >> >> >> >> > - =C2=A0 =C2=A0 if (!err)
>> >> >> >> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WRITE_ONCE(p->=
swap_map[offset], count | has_cache);
>> >> >> >> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WRITE_ONCE(p->=
swap_map[offset + i], count | has_cache);
>> >> >> >> >> > + =C2=A0 =C2=A0 }
>> >> >> >> >> >
>> >> >> >> >> > =C2=A0unlock_out:
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 unlock_cluster_or_swap_info(p, ci);
>> >> >> >> >> > @@ -3439,7 +3456,7 @@ static int __swap_duplicate(swp_entr=
y_t entry, unsigned char usage)
>> >> >> >> >> > =C2=A0 */
>> >> >> >> >> > =C2=A0void swap_shmem_alloc(swp_entry_t entry)
>> >> >> >> >> > =C2=A0{
>> >> >> >> >> > - =C2=A0 =C2=A0 __swap_duplicate(entry, SWAP_MAP_SHMEM);
>> >> >> >> >> > + =C2=A0 =C2=A0 __swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
>> >> >> >> >> > =C2=A0}
>> >> >> >> >> >
>> >> >> >> >> > =C2=A0/*
>> >> >> >> >> > @@ -3453,29 +3470,29 @@ int swap_duplicate(swp_entry_t ent=
ry)
>> >> >> >> >> > =C2=A0{
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 int err =3D 0;
>> >> >> >> >> >
>> >> >> >> >> > - =C2=A0 =C2=A0 while (!err && __swap_duplicate(entry, 1) =
=3D=3D -ENOMEM)
>> >> >> >> >> > + =C2=A0 =C2=A0 while (!err && __swap_duplicate(entry, 1, =
1) =3D=3D -ENOMEM)
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D a=
dd_swap_count_continuation(entry, GFP_ATOMIC);
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 return err;
>> >> >> >> >> > =C2=A0}
>> >> >> >> >> >
>> >> >> >> >> > =C2=A0/*
>> >> >> >> >> > - * @entry: swap entry for which we allocate swap cache.
>> >> >> >> >> > + * @entry: first swap entry from which we allocate nr swa=
p cache.
>> >> >> >> >> > =C2=A0 *
>> >> >> >> >> > - * Called when allocating swap cache for existing swap en=
try,
>> >> >> >> >> > + * Called when allocating swap cache for existing swap en=
tries,
>> >> >> >> >> > =C2=A0 * This can return error codes. Returns 0 at success.
>> >> >> >> >> > =C2=A0 * -EEXIST means there is a swap cache.
>> >> >> >> >> > =C2=A0 * Note: return code is different from swap_duplicat=
e().
>> >> >> >> >> > =C2=A0 */
>> >> >> >> >> > -int swapcache_prepare(swp_entry_t entry)
>> >> >> >> >> > +int swapcache_prepare(swp_entry_t entry, int nr)
>> >> >> >> >> > =C2=A0{
>> >> >> >> >> > - =C2=A0 =C2=A0 return __swap_duplicate(entry, SWAP_HAS_CA=
CHE);
>> >> >> >> >> > + =C2=A0 =C2=A0 return __swap_duplicate(entry, SWAP_HAS_CA=
CHE, nr);
>> >> >> >> >> > =C2=A0}
>> >> >> >> >> >
>> >> >> >> >> > -void swapcache_clear(struct swap_info_struct *si, swp_ent=
ry_t entry)
>> >> >> >> >> > +void swapcache_clear(struct swap_info_struct *si, swp_ent=
ry_t entry, int nr)
>> >> >> >> >> > =C2=A0{
>> >> >> >> >> > =C2=A0 =C2=A0 =C2=A0 unsigned long offset =3D swp_offset(e=
ntry);
>> >> >> >> >> >
>> >> >> >> >> > - =C2=A0 =C2=A0 cluster_swap_free_nr(si, offset, 1, SWAP_H=
AS_CACHE);
>> >> >> >> >> > + =C2=A0 =C2=A0 cluster_swap_free_nr(si, offset, nr, SWAP_=
HAS_CACHE);
>> >> >> >> >> > =C2=A0}
>> >> >> >> >> >
>> >> >> >> >> > =C2=A0struct swap_info_struct *swp_swap_info(swp_entry_t e=
ntry)
>> >> >> >> >>
>> >> >> >> >> --
>> >> >> >> >> Best Regards,
>> >> >> >> >> Huang, Ying
>> >> >> >> >
>> >> >
>
> Thanks
> Barry

