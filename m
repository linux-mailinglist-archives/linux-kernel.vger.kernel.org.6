Return-Path: <linux-kernel+bounces-186881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F4D8CCA53
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E1D282581
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319E31878;
	Thu, 23 May 2024 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYVuueve"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732BEC7
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426967; cv=none; b=AgnV/ybGjjdKtr5mHfrHLLWb2ELScBbOr4CuVsuV932wP44fM62Cu2pcZw2Y2KQWweBULXIDcNyiFpdbB/aVc5JwZIrbZa+5TfVZNOnd9tUEarlk/1YQ3Z6A5TqfgxthMbtJyikBktehgOCnIKm0zlXtJTF/Dnusm6k6koW3Kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426967; c=relaxed/simple;
	bh=CcmpbpVJhasgLmfwQZTQL9+xSZY9u/4K8p1LLNjO9is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uZr0NmN+7IeF9nJLU+ZepcbKDy+eWN13xM1/yEBpYYXM6ps2GLPA2dOYS+RatztgXpvTIV7VkmzrLRH8KDPl+uburtKWM0x0hmccgtGX4iqNrqRB5PrR6bsXL/pdLXLak6Hsg3Sa0Np3WRabJ30ZlNzal1lOOBTJbIsh+Dhv9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYVuueve; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716426965; x=1747962965;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=CcmpbpVJhasgLmfwQZTQL9+xSZY9u/4K8p1LLNjO9is=;
  b=KYVuueveiaEH7cqsh9tPWIHdYX1uvd0nkUdlvdDSi3br+83eq1gFrz+q
   /o3kdGUxAp69LF7ckjxdlInmWH09/49tE4EDT0rA5lkk4GQf0FXZabbEQ
   00LkVwZ/v0jzmbQNOz3wjk+sICxWyg9L9oOt+hLwkoujq1YTwUS5Icq/e
   mN99j2v8qQbIB9YNM9AjEk4NiOLN3dPPiLZ7qHNdOtkREeS8gIQOWYAKs
   ChQN5FICNdsZgmdofbzZjUJ5zcqibdmiSm1tSnt+feAnFnX1uIRPlsroX
   0g7W/+1vaR2cE6OBw6c61ef3K2iWM3Zk2o+YRY4ASdgtgQ8VUZIwvIo+O
   A==;
X-CSE-ConnectionGUID: V+U/EoZjQquRs6oqw+DI8g==
X-CSE-MsgGUID: YwlO8DDWQeCcxn7UPLXF6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12945507"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12945507"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 18:16:04 -0700
X-CSE-ConnectionGUID: UCpiy+V+RKOtiYFej2ZQHQ==
X-CSE-MsgGUID: TeAwZUKuRM6ypEBLA74fXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38325908"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 18:16:02 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,  David Hildenbrand
 <david@redhat.com>,  akpm@linux-foundation.org,  willy@infradead.org,
  ryan.roberts@arm.com,  ziy@nvidia.com,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
In-Reply-To: <CAGsJ_4zSuOTPi+zkS_kvS5T0MsdMBR+2gpXukJt0aMPrEnCDZg@mail.gmail.com>
	(Barry Song's message of "Wed, 22 May 2024 22:40:20 +1200")
References: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
	<22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com>
	<51ba1fc1-fd77-4601-8d27-459162fd008c@linux.alibaba.com>
	<CAGsJ_4zSuOTPi+zkS_kvS5T0MsdMBR+2gpXukJt0aMPrEnCDZg@mail.gmail.com>
Date: Thu, 23 May 2024 09:14:10 +0800
Message-ID: <875xv5ba8t.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, May 22, 2024 at 9:38=E2=80=AFPM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/5/22 16:58, David Hildenbrand wrote:
>> > On 22.05.24 10:51, Baolin Wang wrote:
>> >> The mTHP swap related counters: 'anon_swpout' and
>> >> 'anon_swpout_fallback' are
>> >> confusing with an 'anon_' prefix, since the shmem can swap out
>> >> non-anonymous
>> >> pages. So drop the 'anon_' prefix to keep consistent with the old swap
>> >> counter
>> >> names.
>> >>
>> >> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> >> ---
>> >
>> > Am I daydreaming or did we add the anon_ for a reason and discussed the
>> > interaction with shmem? At least I remember some discussion around tha=
t.
>>
>> Do you mean the shmem mTHP allocation counters in previous
>> discussion[1]? But for 'anon_swpout' and 'anon_swpout_fallback', I can
>> not find previous discussions that provided a reason for adding the
>> =E2=80=98anon_=E2=80=99 prefix. Barry, any comments? Thanks.
>
> HI Baolin,
> We had tons of emails discussing about namin and I found this email,
>
> https://lore.kernel.org/all/bca6d142-15fd-4af5-9f71-821f891e8305@redhat.c=
om/
>
> David had this comment,
> "I'm wondering if these should be ANON specific for now. We might want to
> add others (shmem, file) in the future."
>
> This is likely how the 'anon_' prefix started being added, although it
> wasn't specifically
> targeting swapout.
>
> I sense your patch slightly alters the behavior of thp_swpout_fallback
> in /proc/vmstat.
> Previously, we didn't classify them as THP_SWPOUT_FALLBACK, even though we
> always split them.

IIUC, "fallback" means you try to do something, but fail, so try
something else as fallback.  If so, then we don't need to count
splitting shmem large folio as fallback.

For example, before commit 5ed890ce5147 ("mm: vmscan: avoid split during
shrink_folio_list()"), if folio_entire_mapcount() =3D=3D 0, we will split
the THP.  But we will not count it as "fallback" because we haven't
tried to swap it out as a whole.

>
>                 if (folio_test_anon(folio) && folio_test_swapbacked(folio=
)) {
>                         ...
>                                 if (!add_to_swap(folio)) {
>                                         int __maybe_unused order =3D
> folio_order(folio);
>
>                                         if (!folio_test_large(folio))
>                                                 goto activate_locked_spli=
t;
>                                         /* Fallback to swap normal pages =
*/
>                                         if (split_folio_to_list(folio,
> folio_list))
>                                                 goto activate_locked;
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>                                         if (nr_pages >=3D HPAGE_PMD_NR) {
>                                                 count_memcg_folio_events(=
folio,
>                                                         THP_SWPOUT_FALLBA=
CK, 1);
>
> count_vm_event(THP_SWPOUT_FALLBACK);
>                                         }
>                                         count_mthp_stat(order,
> MTHP_STAT_ANON_SWPOUT_FALLBACK);
> #endif
>                                         if (!add_to_swap(folio))
>                                                 goto activate_locked_spli=
t;
>                                 }
>                         }
>                 } else if (folio_test_swapbacked(folio) &&
>                            folio_test_large(folio)) {
>                         /* Split shmem folio */
>                         if (split_folio_to_list(folio, folio_list))
>                                 goto keep_locked;
>                 }
>
>
>
> If the goal is to incorporate pmd-mapped shmem under thp_swpout* in
> /proc/vmstat,
> and if there is consistency between /proc/vmstat and sys regarding
> their definitions,
> then I have no objection to this patch. However, shmem_swpout and shmem_s=
wpout_*
> appear more intuitive, given that thp_swpout_* in /proc/vmstat has
> never shown any
> increments for shmem until now - we have been always splitting shmem in v=
mscan.
>
> By the way, if this patch is accepted, it must be included in version
> 6.10 to maintain
> ABI compatibility. Additionally, documentation must be updated accordingl=
y.
>
>>
>> [1]
>> https://lore.kernel.org/all/05d0096e4ec3e572d1d52d33a31a661321ac1551.171=
3755580.git.baolin.wang@linux.alibaba.com/
>

--
Best Regards,
Huang, Ying

