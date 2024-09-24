Return-Path: <linux-kernel+bounces-339901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF0D986BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729BCB249B6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F00D5588E;
	Thu, 26 Sep 2024 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UP1SYrY6"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C879C4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727328332; cv=none; b=Hdon46Hfb1cXR9jwOTYZQpae8TmdbjwVRpRowXdHqsST5lvlOX9BQOYRZ9MDFlsdDSiIl/Nhe/cSBZEIl+tv+gv/w8Jm+/qPIlFucWOXC37kGIy3POjfrmOyIKui+wkHjTf/9JhH/xZ+4trnJ1Li1G1zG0z5BfjPLzuYOg146tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727328332; c=relaxed/simple;
	bh=4N2kpRy1useREFPbJn9t5g5N8Pk7h3iVO0H8S/NCqeQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=m9omD6ztgYSHvEIZoH0mXjjNVdInVVZ8feTgi4KiMqcL1kWhXJLoRFz2IeW/tmy3vIKsiqRuCZYK1MtQgS0u3lFFG4i2mWpboibRG/rdwC+ubZOPE6eLOmkDfqp/t62Ytca9whhIXU0ZJ6jCQtHt+32+AsjxnqgegiLJ1dAwD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UP1SYrY6; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727328326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp82X1gEUMsH0cTyMFodXGf6d6eN6K2y3H6Zo3CY6V4=;
	b=UP1SYrY6JNvaw/mqwf7M8PBn5o0rhDki+ijb1ln0L0MUcljBYuE/XJ3+2eVvuQI7dGuJG5
	4C4rVEWKofEycZYjhgvQDINKY95NSLfQBiyugpfuLu+TYKtPny66Ux7rXAt+3IgCR2wE/m
	MES1uFoQEEs5qXOLCDAw/xaJxHyq/LY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 07/13] mm: khugepaged: collapse_pte_mapped_thp() use pte_offset_map_rw_nolock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <07d975c50fe09c246e087303b39998430b1a66bd.1727148662.git.zhengqi.arch@bytedance.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Sep 2024 15:14:25 +0800
Message-Id: <79699B24-0D99-4051-91F3-5695D32D62AC@linux.dev>
References: <07d975c50fe09c246e087303b39998430b1a66bd.1727148662.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 24, 2024, at 14:11, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> =EF=BB=BFIn collapse_pte_mapped_thp(), we may modify the pte and pmd entry=
 after
> acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). At
> this time, the pte_same() check is not performed after the PTL held. So we=

> should get pgt_pmd and do pmd_same() check after the ptl held.
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> mm/khugepaged.c | 14 +++++++++++---
> 1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6498721d4783a..8ab79c13d077f 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1605,7 +1605,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, un=
signed long addr,
>    if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
>        pml =3D pmd_lock(mm, pmd);
>=20
> -    start_pte =3D pte_offset_map_nolock(mm, pmd, haddr, &ptl);
> +    start_pte =3D pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl=
);
>    if (!start_pte)        /* mmap_lock + page lock should prevent this */
>        goto abort;
>    if (!pml)
> @@ -1613,6 +1613,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, un=
signed long addr,
>    else if (ptl !=3D pml)
>        spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>=20
> +    if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
> +        goto abort;
> +
>    /* step 2: clear page table and adjust rmap */
>    for (i =3D 0, addr =3D haddr, pte =3D start_pte;
>         i < HPAGE_PMD_NR; i++, addr +=3D PAGE_SIZE, pte++) {
> @@ -1645,7 +1648,6 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, un=
signed long addr,
>        nr_ptes++;
>    }
>=20
> -    pte_unmap(start_pte);
>    if (!pml)
>        spin_unlock(ptl);
>=20
> @@ -1658,13 +1660,19 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, u=
nsigned long addr,
>    /* step 4: remove empty page table */
>    if (!pml) {
>        pml =3D pmd_lock(mm, pmd);
> -        if (ptl !=3D pml)
> +        if (ptl !=3D pml) {
>            spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +            if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
> +                spin_unlock(pml);
> +                goto abort;

Drop the reference of folio and the mm counter twice at the label of abort a=
nd the step 3.

> +            }
> +        }
>    }
>    pgt_pmd =3D pmdp_collapse_flush(vma, haddr, pmd);
>    pmdp_get_lockless_sync();
>    if (ptl !=3D pml)
>        spin_unlock(ptl);
> +    pte_unmap(start_pte);
>    spin_unlock(pml);

Why not?

pte_unmap_unlock(start_pte, ptl);
if (pml !=3D ptl)
        spin_unlock(pml);

>=20
>    mmu_notifier_invalidate_range_end(&range);
> --
> 2.20.1

