Return-Path: <linux-kernel+bounces-389833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209C89B7204
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DDC1F262F4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D649638;
	Thu, 31 Oct 2024 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlUJaWlR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F47D2FB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338528; cv=none; b=SPSA34TlX8yD4MVpCSeYxVIIXUMn8ucyrEoOW+222SfmCrj99kCFZ0OL5nRKeYK+Zi5UQAjVljwIyzCZPpbu74rHjPzXbJQ/gp0USfzIV3IxvqUu81JIoAZdebi+UYIqveVfECxlAcNcnWixZMiXgHP1bykvQxqJbusFfRTUOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338528; c=relaxed/simple;
	bh=WuF36lZjHaYlPv9BbCV28pQgEqIcnbHQ6qVMkSkkZmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s5GZHwYMm95xAwOw2L3qLvqyHkcEmfNKuVrYeToyGe7MhVHmwNRmTFHif16Xv3qHAJM4aaV2k6o9ACjCbhxyaXfqE/HiR+xphhXAvADe4pH4koMYdlf7cxXmLyDHN4O09t938Z2NcFCDZgl5Ht7Fv5kGP9SHEpQhWVGE2hnS+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlUJaWlR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730338525; x=1761874525;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=WuF36lZjHaYlPv9BbCV28pQgEqIcnbHQ6qVMkSkkZmY=;
  b=ZlUJaWlR2AlXokEol8hQEoxPMHH/lckOKvhj6lDq1a4bjol7W7QSlrbE
   FK6s+HGsYsdC7hNXNkcevuzdsb3qzQ1EpU115URuokg2gI6kDlDh+5a2O
   VW2K95eA+DwUCPyxEdGYSM0mbtvl37/pUtm2pYkQEgGtRuQAqK1NSjCpu
   +bnjvVdrBePHUoL2DfpjYej+fE0cEvdAploB/taPhzSc4VnAxoFwGAJii
   rRZhcYV9J5n/0k1zWpqo5WhkUEsG7zCFZBZwDkC+D4Dotgu6fAXlRZWpO
   x0QJ74HppPIoOP1qJFajCQ1H6zCOCVc1vS5HpBpQy55ZphN3yghpLiCVq
   w==;
X-CSE-ConnectionGUID: sYOGP6vjR2CHOGi3Ryg+WA==
X-CSE-MsgGUID: Txbdn7tlRom3fmRgsgqtDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="32905321"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="32905321"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 18:35:25 -0700
X-CSE-ConnectionGUID: wHR1di9uTNG5o719ddQRoA==
X-CSE-MsgGUID: UJv52kH3So2KKh/nVFQeDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="87088100"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 18:35:21 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Barry Song <v-songbaohua@oppo.com>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,  David Hildenbrand
 <david@redhat.com>,  Chris Li <chrisl@kernel.org>,  Yosry Ahmed
 <yosryahmed@google.com>,  Kairui Song <kasong@tencent.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  Kanchana P Sridhar
 <kanchana.p.sridhar@intel.com>,  Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH v2] mm: add per-order mTHP swpin counters
In-Reply-To: <CAGsJ_4wemLBdoV4TMaeSWThMtVJtU+HjyAVwKDV978mAOqkhBA@mail.gmail.com>
	(Barry Song's message of "Thu, 31 Oct 2024 14:13:04 +1300")
References: <20241030233423.80759-1-21cnbao@gmail.com>
	<87cyjh9khr.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wemLBdoV4TMaeSWThMtVJtU+HjyAVwKDV978mAOqkhBA@mail.gmail.com>
Date: Thu, 31 Oct 2024 09:31:49 +0800
Message-ID: <878qu59hx6.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Oct 31, 2024 at 1:39=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > From: Barry Song <v-songbaohua@oppo.com>
>> >
>> > This helps profile the sizes of folios being swapped in. Currently,
>> > only mTHP swap-out is being counted.
>> > The new interface can be found at:
>> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>> >          swpin
>>
>> This looks strange, why isn't it
>>
>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/swpin
>>
>> ?
>
> I might be mistaken, but I want to highlight the path and new interface
> separately, as I=E2=80=99ve done in ec33687c67493 ("mm: add per-order mTHP
> anon_fault_alloc and anon_fault_fallback counters"):
>
> If you prefer it on the same line, I=E2=80=99m completely fine with sendi=
ng v3
> to make the change.

I am fine to highlight the new interface.  May be something like

In /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats, 'swpin'
is added for ...

However, I have no strong opinion here.  If everyone except me feels
confusing, that should be fine.

>>
>> > For example,
>> > cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
>> > 12809
>> > cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
>> > 4763
>>
>> You miss "$"?
>
> Yes.
>
>>
>> $ cat /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
>> 12809
>> $ cat /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
>> 4763
>>
>> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> > Acked-by: David Hildenbrand <david@redhat.com>
>> > Cc: Chris Li <chrisl@kernel.org>
>> > Cc: Yosry Ahmed <yosryahmed@google.com>
>> > Cc: "Huang, Ying" <ying.huang@intel.com>
>> > Cc: Kairui Song <kasong@tencent.com>
>> > Cc: Ryan Roberts <ryan.roberts@arm.com>
>> > Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
>> > Cc: Usama Arif <usamaarif642@gmail.com>
>> > ---
>> >  -v2:
>> >  * collect Baolin's reviewed-by and David's acked-by, thanks!
>> >  * add some examples for the interface in the changelog, Per
>> >    Huang, Ying. thanks!
>> >  * add a blank line in doc which was missed in v1.
>> >
>> >  Documentation/admin-guide/mm/transhuge.rst | 4 ++++
>> >  include/linux/huge_mm.h                    | 1 +
>> >  mm/huge_memory.c                           | 3 +++
>> >  mm/page_io.c                               | 3 +++
>> >  4 files changed, 11 insertions(+)
>> >
>> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentatio=
n/admin-guide/mm/transhuge.rst
>> > index 2a171ed5206e..5caa3fb2feb1 100644
>> > --- a/Documentation/admin-guide/mm/transhuge.rst
>> > +++ b/Documentation/admin-guide/mm/transhuge.rst
>> > @@ -534,6 +534,10 @@ zswpout
>> >       is incremented every time a huge page is swapped out to zswap in=
 one
>> >       piece without splitting.
>> >
>> > +swpin
>> > +     is incremented every time a huge page is swapped in from a non-z=
swap
>> > +     swap device in one piece.
>> > +
>> >  swpout
>> >       is incremented every time a huge page is swapped out to a non-zs=
wap
>> >       swap device in one piece without splitting.
>> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> > index c59e5aa9b081..b94c2e8ee918 100644
>> > --- a/include/linux/huge_mm.h
>> > +++ b/include/linux/huge_mm.h
>> > @@ -120,6 +120,7 @@ enum mthp_stat_item {
>> >       MTHP_STAT_ANON_FAULT_FALLBACK,
>> >       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>> >       MTHP_STAT_ZSWPOUT,
>> > +     MTHP_STAT_SWPIN,
>> >       MTHP_STAT_SWPOUT,
>> >       MTHP_STAT_SWPOUT_FALLBACK,
>> >       MTHP_STAT_SHMEM_ALLOC,
>> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> > index b26c6503e993..f92068864469 100644
>> > --- a/mm/huge_memory.c
>> > +++ b/mm/huge_memory.c
>> > @@ -616,6 +616,7 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_=
ANON_FAULT_ALLOC);
>> >  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLB=
ACK);
>> >  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAUL=
T_FALLBACK_CHARGE);
>> >  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>> > +DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>> >  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>> >  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>> >  #ifdef CONFIG_SHMEM
>> > @@ -635,6 +636,7 @@ static struct attribute *anon_stats_attrs[] =3D {
>> >       &anon_fault_fallback_charge_attr.attr,
>> >  #ifndef CONFIG_SHMEM
>> >       &zswpout_attr.attr,
>> > +     &swpin_attr.attr,
>> >       &swpout_attr.attr,
>> >       &swpout_fallback_attr.attr,
>> >  #endif
>> > @@ -666,6 +668,7 @@ static struct attribute_group file_stats_attr_grp =
=3D {
>> >  static struct attribute *any_stats_attrs[] =3D {
>> >  #ifdef CONFIG_SHMEM
>> >       &zswpout_attr.attr,
>> > +     &swpin_attr.attr,
>> >       &swpout_attr.attr,
>> >       &swpout_fallback_attr.attr,
>> >  #endif
>> > diff --git a/mm/page_io.c b/mm/page_io.c
>> > index c69fab5060a1..5d9b6e6cf96c 100644
>> > --- a/mm/page_io.c
>> > +++ b/mm/page_io.c
>> > @@ -487,6 +487,7 @@ static void sio_read_complete(struct kiocb *iocb, =
long ret)
>> >               for (p =3D 0; p < sio->pages; p++) {
>> >                       struct folio *folio =3D page_folio(sio->bvec[p].=
bv_page);
>> >
>> > +                     count_mthp_stat(folio_order(folio), MTHP_STAT_SW=
PIN);
>> >                       count_memcg_folio_events(folio, PSWPIN, folio_nr=
_pages(folio));
>> >                       folio_mark_uptodate(folio);
>> >                       folio_unlock(folio);
>> > @@ -573,6 +574,7 @@ static void swap_read_folio_bdev_sync(struct folio=
 *folio,
>> >        * attempt to access it in the page fault retry time check.
>> >        */
>> >       get_task_struct(current);
>> > +     count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
>> >       count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>> >       count_vm_events(PSWPIN, folio_nr_pages(folio));
>> >       submit_bio_wait(&bio);
>> > @@ -589,6 +591,7 @@ static void swap_read_folio_bdev_async(struct foli=
o *folio,
>> >       bio->bi_iter.bi_sector =3D swap_folio_sector(folio);
>> >       bio->bi_end_io =3D end_swap_bio_read;
>> >       bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
>> > +     count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
>> >       count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>> >       count_vm_events(PSWPIN, folio_nr_pages(folio));
>> >       submit_bio(bio);
>>

--
Best Regards,
Huang, Ying

