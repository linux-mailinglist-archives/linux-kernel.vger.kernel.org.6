Return-Path: <linux-kernel+bounces-316420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4096CF56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6D01F223B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290C118C345;
	Thu,  5 Sep 2024 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RLu7mycF"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF2187FFC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518014; cv=none; b=UKwoto5RiDmD6BBxRx74eY4aJyAvQlpjWk/7qyD8DbZ+bnicqGnEW4edsC92Yi1uEOaXEjX01Ply4ZuHcVQIIUh07Gx935D6p8K+ry+o1exONh5ER/rz4l1MxD5T/u4qmQXSrB51Yh3eQFsekJEAaG7Emb8hb/mS5OIRKYnSy40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518014; c=relaxed/simple;
	bh=YcPCgQYRELZvl2kjL3rdrZSA+jEpwRFWGaRBLNwMsiU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XIUvP5bYdsfN3sa+TZMz3bofofCnuiwC4sVlxJYXtEAhmkkqS/uMA/sT5eibctHbRxlchKxh1jrE9k1MovS7VLwHTVf9wU/hCire2/lkysRo1Pdw8gQ2x/uu3gwNEc4GE87JqsYcr4P9svhjbDHkiQgT3pnIoU1p5sn9YkA5rzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RLu7mycF; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725518009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksx22GPeHsqr/AARD3Kz3GMedfunDXYI9hMA6uigG5g=;
	b=RLu7mycFOgF59AgkyN6sSQyBId6kbznssyisAv642gvR8ipqt29Lkad550xwM3XC5i0xuy
	w6vXjYG+TmTANMF23rlD1fddyYK7eqC0z5dDGe19Hl9oqA7jJgbrpuYJ7VxlJVwrKc2DzX
	9JP+wn68fbsvBkV8OiiriUiBUa01AUs=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 07/14] mm: khugepaged: collapse_pte_mapped_thp() use
 pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <cd137540-ae01-46a1-93d2-062bc21b827c@bytedance.com>
Date: Thu, 5 Sep 2024 14:32:48 +0800
Cc: David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>,
 Vishal Moola <vishal.moola@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 christophe.leroy2@cs-soprasteria.com,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <05955456-8743-448A-B7A4-BC45FABEA628@linux.dev>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <c377dab2bf55950e6155ea051aba3887ed5a2773.1724310149.git.zhengqi.arch@bytedance.com>
 <24be821f-a95f-47f1-879a-c392a79072cc@linux.dev>
 <cd137540-ae01-46a1-93d2-062bc21b827c@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 30, 2024, at 14:54, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>=20
>=20
>=20
> On 2024/8/29 16:10, Muchun Song wrote:
>> On 2024/8/22 15:13, Qi Zheng wrote:
>>> In collapse_pte_mapped_thp(), we may modify the pte and pmd entry =
after
>>> acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). =
At
>>> this time, the write lock of mmap_lock is not held, and the =
pte_same()
>>> check is not performed after the PTL held. So we should get pgt_pmd =
and do
>>> pmd_same() check after the ptl held.
>>>=20
>>> For the case where the ptl is released first and then the pml is =
acquired,
>>> the PTE page may have been freed, so we must do pmd_same() check =
before
>>> reacquiring the ptl.
>>>=20
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>  mm/khugepaged.c | 16 +++++++++++++++-
>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 53bfa7f4b7f82..15d3f7f3c65f2 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1604,7 +1604,7 @@ int collapse_pte_mapped_thp(struct mm_struct =
*mm, unsigned long addr,
>>>      if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
>>>          pml =3D pmd_lock(mm, pmd);
>>> -    start_pte =3D pte_offset_map_nolock(mm, pmd, haddr, &ptl);
>>> +    start_pte =3D pte_offset_map_rw_nolock(mm, pmd, haddr, =
&pgt_pmd, &ptl);
>>>      if (!start_pte)        /* mmap_lock + page lock should prevent =
this */
>>>          goto abort;
>>>      if (!pml)
>>> @@ -1612,6 +1612,9 @@ int collapse_pte_mapped_thp(struct mm_struct =
*mm, unsigned long addr,
>>>      else if (ptl !=3D pml)
>>>          spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>> +    if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
>>> +        goto abort;
>>> +
>>>      /* step 2: clear page table and adjust rmap */
>>>      for (i =3D 0, addr =3D haddr, pte =3D start_pte;
>>>           i < HPAGE_PMD_NR; i++, addr +=3D PAGE_SIZE, pte++) {
>>> @@ -1657,6 +1660,16 @@ int collapse_pte_mapped_thp(struct mm_struct =
*mm, unsigned long addr,
>>>      /* step 4: remove empty page table */
>>>      if (!pml) {
>>>          pml =3D pmd_lock(mm, pmd);
>>> +        /*
>>> +         * We called pte_unmap() and release the ptl before =
acquiring
>>> +         * the pml, which means we left the RCU critical section, =
so the
>>> +         * PTE page may have been freed, so we must do pmd_same() =
check
>>> +         * before reacquiring the ptl.
>>> +         */
>>> +        if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
>>> +            spin_unlock(pml);
>>> +            goto pmd_change;
>> Seems we forget to flush TLB since we've cleared some pte entry?
>=20
> See comment above the ptep_clear():
>=20
> /*
> * Must clear entry, or a racing truncate may re-remove it.
> * TLB flush can be left until pmdp_collapse_flush() does it.
> * PTE dirty? Shmem page is already dirty; file is read-only.
> */
>=20
> The TLB flush was handed over to pmdp_collapse_flush(). If a

But you skipped pmdp_collapse_flush().

> concurrent thread free the PTE page at this time, the TLB will
> also be flushed after pmd_clear().
>=20
>>> +        }
>>>          if (ptl !=3D pml)
>>>              spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>>      }
>>> @@ -1688,6 +1701,7 @@ int collapse_pte_mapped_thp(struct mm_struct =
*mm, unsigned long addr,
>>>          pte_unmap_unlock(start_pte, ptl);
>>>      if (pml && pml !=3D ptl)
>>>          spin_unlock(pml);
>>> +pmd_change:
>>>      if (notified)
>>>          mmu_notifier_invalidate_range_end(&range);
>>>  drop_folio:


