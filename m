Return-Path: <linux-kernel+bounces-336808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4840998411E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0805E28109F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832B1531D2;
	Tue, 24 Sep 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y/NlUSsN"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ACD450EE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168001; cv=none; b=f5HZlWVgYh3PWqyDuYJZuO30KxBtcNej1+AI+hJ++vX/UdG85iUN6Qn9VpnjlTCViMHxE63/Tr6wUO3K5yiKM7LeYwv+ZmB+1ccf1PFBPTIK1x66QQ5fpTQFNeqekpTa4dmcy5+ZY+7OPnEyNad9yCtwK2a83ufjaHlDEVgEy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168001; c=relaxed/simple;
	bh=AwIJlQYCQ+VfX3Y6n/rzeDK3O1xeCqsjV5gozeKXdN8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IdPI7WoJJR20bGvtHa1v8QZRPUbUGhP0CZu9pif4ACZO3DgElfKiox4glBW/KJYhlbdJzmtGhiR9sAvpTOKFpDTghA/CiF2w7KLWHDFeFbsvQW5QfMEo8Ttlc6iKjCYT11k69jxHExKly9Vd3De24UsDD8e/LxRcahdjU5h/Lt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y/NlUSsN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727167995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpyNjX3SywB8uvA6z8NNxtoy61vc2SVjYp0FLcYU0Bg=;
	b=Y/NlUSsNLr1ACfiVoikNI877ntJ8eQYVJ79owK8l2o96uz/W+SW5BzZ9Yl2sW1QHthH6qw
	/K38dLAstL3gN/S/H9vCtK6QVpg/3wmjbBNVlh8Sm8CfOZrojR5+YCAeqlErfWBM3S6tYR
	84G6gXzxoUGE03YcUoZZL6IjT8URxhc=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v4 07/13] mm: khugepaged: collapse_pte_mapped_thp() use
 pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2343da2e-f91f-4861-bb22-28f77db98c52@bytedance.com>
Date: Tue, 24 Sep 2024 16:52:34 +0800
Cc: david@redhat.com,
 hughd@google.com,
 willy@infradead.org,
 vbabka@kernel.org,
 akpm@linux-foundation.org,
 rppt@kernel.org,
 vishal.moola@gmail.com,
 peterx@redhat.com,
 ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D1872F1-7280-4F43-8213-A720C56B0646@linux.dev>
References: <07d975c50fe09c246e087303b39998430b1a66bd.1727148662.git.zhengqi.arch@bytedance.com>
 <79699B24-0D99-4051-91F3-5695D32D62AC@linux.dev>
 <2343da2e-f91f-4861-bb22-28f77db98c52@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 24, 2024, at 15:29, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>=20
>=20
>=20
> On 2024/9/24 15:14, Muchun Song wrote:
>>> On Sep 24, 2024, at 14:11, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>>> =EF=BB=BFIn collapse_pte_mapped_thp(), we may modify the pte and pmd =
entry after
>>> acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). =
At
>>> this time, the pte_same() check is not performed after the PTL held. =
So we
>>> should get pgt_pmd and do pmd_same() check after the ptl held.
>>>=20
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>> mm/khugepaged.c | 14 +++++++++++---
>>> 1 file changed, 11 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 6498721d4783a..8ab79c13d077f 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1605,7 +1605,7 @@ int collapse_pte_mapped_thp(struct mm_struct =
*mm, unsigned long addr,
>>>    if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
>>>        pml =3D pmd_lock(mm, pmd);
>>>=20
>>> -    start_pte =3D pte_offset_map_nolock(mm, pmd, haddr, &ptl);
>>> +    start_pte =3D pte_offset_map_rw_nolock(mm, pmd, haddr, =
&pgt_pmd, &ptl);
>>>    if (!start_pte)        /* mmap_lock + page lock should prevent =
this */
>>>        goto abort;
>>>    if (!pml)
>>> @@ -1613,6 +1613,9 @@ int collapse_pte_mapped_thp(struct mm_struct =
*mm, unsigned long addr,
>>>    else if (ptl !=3D pml)
>>>        spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>>=20
>>> +    if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
>>> +        goto abort;
>>> +
>>>    /* step 2: clear page table and adjust rmap */
>>>    for (i =3D 0, addr =3D haddr, pte =3D start_pte;
>>>         i < HPAGE_PMD_NR; i++, addr +=3D PAGE_SIZE, pte++) {
>>> @@ -1645,7 +1648,6 @@ int collapse_pte_mapped_thp(struct mm_struct =
*mm, unsigned long addr,
>>>        nr_ptes++;
>>>    }
>>>=20
>>> -    pte_unmap(start_pte);
>>>    if (!pml)
>>>        spin_unlock(ptl);
>>>=20
>>> @@ -1658,13 +1660,19 @@ int collapse_pte_mapped_thp(struct mm_struct =
*mm, unsigned long addr,
>>>    /* step 4: remove empty page table */
>>>    if (!pml) {
>>>        pml =3D pmd_lock(mm, pmd);
>>> -        if (ptl !=3D pml)
>>> +        if (ptl !=3D pml) {
>>>            spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>> +            if (unlikely(!pmd_same(pgt_pmd, =
pmdp_get_lockless(pmd)))) {
>>> +                spin_unlock(pml);
>>> +                goto abort;
>> Drop the reference of folio and the mm counter twice at the label of =
abort and the step 3.
>=20
> My bad, should set nr_ptes to 0 and call flush_tlb_mm() here, right?

Or add a new label "out" just below the "abort". Then go to out.

>=20
>>> +            }
>>> +        }
>>>    }
>>>    pgt_pmd =3D pmdp_collapse_flush(vma, haddr, pmd);
>>>    pmdp_get_lockless_sync();
>>>    if (ptl !=3D pml)
>>>        spin_unlock(ptl);
>>> +    pte_unmap(start_pte);
>>>    spin_unlock(pml);
>> Why not?
>> pte_unmap_unlock(start_pte, ptl);
>> if (pml !=3D ptl)
>>         spin_unlock(pml);
>=20
> Both are fine, will do.
>=20
> Thanks,
> Qi
>=20
>>>=20
>>>    mmu_notifier_invalidate_range_end(&range);
>>> --
>>> 2.20.1



