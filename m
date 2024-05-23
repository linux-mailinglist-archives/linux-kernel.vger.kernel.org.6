Return-Path: <linux-kernel+bounces-186873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6CD8CCA38
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E588A28276A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F74187F;
	Thu, 23 May 2024 01:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGrJD8NY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D1AD24
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426247; cv=none; b=eLuv4tlLTuEUaiLqHK4lZbXmrUvXpIRGE2ws7bO8zDKWNQlNG6W8ks9aMo5gwQTPzMUDrJxI1iKAWkxb6ojyPCsoGA12QNqKx8ZAHSPiNtOjL51D58KzSQ7O2eKm7KQXXFFUHkWLjrBFUEH2kxbpDXn7dy+qLFEeJwl7ubqWFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426247; c=relaxed/simple;
	bh=xuVimXmATg4JcE4J/zHQiQR6R8dLYbJIHSZrB0l2/6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTfalPLtX5it2Ghdzvxo7ymJojank93A3kaMl3n6cPuIGcpV4QcqAwqV5zKvGwKaJHJQ/4aj8Qpr5ZetmrQVHcb9+Re5aVyFVx1Pfb2Xtej7fIfWREIzfnuewGGNlKEO/Yq/KgVANdUDzkARIWZOUNdwXPXSDwL+ydfcuZYU57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGrJD8NY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716426245; x=1747962245;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=xuVimXmATg4JcE4J/zHQiQR6R8dLYbJIHSZrB0l2/6c=;
  b=eGrJD8NYRuvS1EEPTOnOnK1ToVVY9+ozVHG/KQGe/AgScTg0L0wm+fmf
   hJ8vepKBtR6mj7takRH1rcId5wm/N6WZ7a62NRWr7uT2ZOPwcQc9So07z
   3D2yoHa1gAazor+SwGU5o8aaW3PePXr3TwxU4tfsCMYvAlHA0NKFjRsO6
   o9YTCeRkqr2wDlilxc2kfp+TwD2kmNzQMUQj64Ci0aH2EBFO4QIvgb546
   d0IJd176ASM3Zc4SZUCGjIJxxMV7XwDA93Nacd4dfwWIRPsXtagB4BbS/
   SfDU2KK8TBfh7cQDCr2b12MgK3k+7qy1LiItrqIZKl0pVFPldc+DOjnMl
   w==;
X-CSE-ConnectionGUID: eqsKvP+AR3Cmx02luT3xLQ==
X-CSE-MsgGUID: BJsco8VYTs6oOb/av4KA4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12590217"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12590217"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 18:04:05 -0700
X-CSE-ConnectionGUID: AsK3JofGRmuXrtneQVWPmw==
X-CSE-MsgGUID: UHc51AbVReeemWx1TNt4tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33546735"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 18:04:02 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,  <akpm@linux-foundation.org>,
  <willy@infradead.org>,  <ryan.roberts@arm.com>,  <ziy@nvidia.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
In-Reply-To: <c55648d4-cec2-48ca-9ca9-c8fc2aecc741@linux.alibaba.com> (Baolin
	Wang's message of "Wed, 22 May 2024 19:24:45 +0800")
References: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
	<22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com>
	<51ba1fc1-fd77-4601-8d27-459162fd008c@linux.alibaba.com>
	<CAGsJ_4zSuOTPi+zkS_kvS5T0MsdMBR+2gpXukJt0aMPrEnCDZg@mail.gmail.com>
	<c55648d4-cec2-48ca-9ca9-c8fc2aecc741@linux.alibaba.com>
Date: Thu, 23 May 2024 09:02:10 +0800
Message-ID: <87a5khbast.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 2024/5/22 18:40, Barry Song wrote:
>> On Wed, May 22, 2024 at 9:38=E2=80=AFPM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> On 2024/5/22 16:58, David Hildenbrand wrote:
>>>> On 22.05.24 10:51, Baolin Wang wrote:
>>>>> The mTHP swap related counters: 'anon_swpout' and
>>>>> 'anon_swpout_fallback' are
>>>>> confusing with an 'anon_' prefix, since the shmem can swap out
>>>>> non-anonymous
>>>>> pages. So drop the 'anon_' prefix to keep consistent with the old swap
>>>>> counter
>>>>> names.
>>>>>
>>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>
>>>> Am I daydreaming or did we add the anon_ for a reason and discussed the
>>>> interaction with shmem? At least I remember some discussion around tha=
t.
>>>
>>> Do you mean the shmem mTHP allocation counters in previous
>>> discussion[1]? But for 'anon_swpout' and 'anon_swpout_fallback', I can
>>> not find previous discussions that provided a reason for adding the
>>> =E2=80=98anon_=E2=80=99 prefix. Barry, any comments? Thanks.
>> HI Baolin,
>> We had tons of emails discussing about namin and I found this email,
>> https://lore.kernel.org/all/bca6d142-15fd-4af5-9f71-821f891e8305@redhat.=
com/
>> David had this comment,
>> "I'm wondering if these should be ANON specific for now. We might want to
>> add others (shmem, file) in the future."
>> This is likely how the 'anon_' prefix started being added, although
>> it
>> wasn't specifically
>> targeting swapout.
>
> That's what I missed before. Thanks Barry.
>
>> I sense your patch slightly alters the behavior of thp_swpout_fallback
>> in /proc/vmstat.
>> Previously, we didn't classify them as THP_SWPOUT_FALLBACK, even though =
we
>> always split them.
>
> Sorry I did not get you here. I just re-name the mTHP swpout_fallback,
> how can this patch change the THP_SWPOUT_FALLBACK statistic counted by
> count_vm_event()?
>
>>                  if (folio_test_anon(folio) && folio_test_swapbacked(fol=
io)) {
>>                          ...
>>                                  if (!add_to_swap(folio)) {
>>                                          int __maybe_unused order =3D
>> folio_order(folio);
>>                                          if
>> (!folio_test_large(folio))
>>                                                  goto activate_locked_sp=
lit;
>>                                          /* Fallback to swap normal page=
s */
>>                                          if (split_folio_to_list(folio,
>> folio_list))
>>                                                  goto activate_locked;
>> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>                                          if (nr_pages >=3D HPAGE_PMD_NR)=
 {
>>                                                  count_memcg_folio_event=
s(folio,
>>                                                          THP_SWPOUT_FALL=
BACK, 1);
>> count_vm_event(THP_SWPOUT_FALLBACK);
>>                                          }
>>                                          count_mthp_stat(order,
>> MTHP_STAT_ANON_SWPOUT_FALLBACK);
>> #endif
>>                                          if (!add_to_swap(folio))
>>                                                  goto activate_locked_sp=
lit;
>>                                  }
>>                          }
>>                  } else if (folio_test_swapbacked(folio) &&
>>                             folio_test_large(folio)) {
>>                          /* Split shmem folio */
>>                          if (split_folio_to_list(folio, folio_list))
>>                                  goto keep_locked;
>>                  }
>> If the goal is to incorporate pmd-mapped shmem under thp_swpout* in
>> /proc/vmstat,
>> and if there is consistency between /proc/vmstat and sys regarding
>> their definitions,
>> then I have no objection to this patch.=20
>
> I think this is the goal, moreover shmem will support large folio (not
> only THP) in future, so swpout related counters should be defined as
> clear as possible.
>
> However, shmem_swpout and shmem_swpout_*
>> appear more intuitive, given that thp_swpout_* in /proc/vmstat has
>> never shown any
>> increments for shmem until now - we have been always splitting shmem in =
vmscan.
>
> This is somewhat similar to our previous discussion on the naming of
> the shmem's mTHP counter[1], as David suggested, we should keep
> counter name consistency for now and add more in the future as needed.
>
> [1]
> https://lore.kernel.org/all/ce6be451-7c5a-402f-8340-be40699829c2@redhat.c=
om/

Yes.  I don't find that it's necessary to distinguish anonymous and
shmem mTHP swap-out now.  If we need it in the future, we can add that
at that time.

>> By the way, if this patch is accepted, it must be included in
>> version
>> 6.10 to maintain
>> ABI compatibility. Additionally, documentation must be updated according=
ly.
>
> Sure. I missed update the documentation, and will do in next version.

--
Best Regards,
Huang, Ying

