Return-Path: <linux-kernel+bounces-336760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8B598406F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3661C20A20
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D1150981;
	Tue, 24 Sep 2024 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tjp0P3kf"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15781494DB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166348; cv=none; b=Y4aXYUScUs1eVgusKyZxSyENoycVd3vyk4i41FLGwx7o19ZfaQ+PsY8t/BM4Xv3XCET5Yv2OVCQ2VzRI9a64C0yVlXmgOQ0CpAPiW1dYE4eBr+AuykuoNcEHOoh+7JtSGSlQGLLgpReBHiQiTMHB5L/BTKl3DQtQOXLqsoSSR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166348; c=relaxed/simple;
	bh=nPceuxPVMeKjsBOAEIxSaXQWX78AoFC91ZOBWYM6Shk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=J5ISQb4ubc5c1tCWV5InkVWud81lJ0N9g1HK/9SRjqwHzA8kfVsy2jndANw0LR7iuEjLfX522MFaPLxwsvhEeyqIOz3p6C8HZ/ePCdv8Vb92VfuFmvoU7XQiECF8Ne1MwNDQDhRjBzwIa54AV/0TwDFXX00UopxfZn22d04EzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tjp0P3kf; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727166344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1y5CwMb2yKa3w/NIt/ri0sQu3/1xDcimH4xSI7fLtgQ=;
	b=Tjp0P3kfHa/lcIBU5PC1B0bQQCvLGfyq8015xxHclGgdFLLPxO/1pTOinxm0BDuczsBQUv
	m5ZY1EvglHhF0Inymte3gC1+yKjYpSfigpVX8d8pHJhpC3jeMXjhqqORPMtLQ/ZViMl3ti
	cU3EvV03qYBYxqNC+aDS+qZDaTycsVA=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 10/13] mm: page_vma_mapped_walk: map_pte() use pte_offset_map_rw_nolock()
Date: Tue, 24 Sep 2024 16:25:06 +0800
Message-Id: <E2AAD3DA-4C73-4785-939C-13164FA8543D@linux.dev>
References: <ecffb7d71363fa79048c0a929780215e0fa93491.1727148662.git.zhengqi.arch@bytedance.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <ecffb7d71363fa79048c0a929780215e0fa93491.1727148662.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Sep 24, 2024, at 14:11, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>=20
> =EF=BB=BFIn the caller of map_pte(), we may modify the pvmw->pte after acq=
uiring
> the pvmw->ptl, so convert it to using pte_offset_map_rw_nolock(). At
> this time, the pte_same() check is not performed after the pvmw->ptl held,=

> so we should get pmdval and do pmd_same() check to ensure the stability of=

> pvmw->pmd.
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> mm/page_vma_mapped.c | 25 ++++++++++++++++++++-----
> 1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index ae5cc42aa2087..6410f29b37c1b 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -13,9 +13,11 @@ static inline bool not_found(struct page_vma_mapped_wal=
k *pvmw)
>    return false;
> }
>=20
> -static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)=

> +static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
> +            spinlock_t **ptlp)
> {
>    pte_t ptent;
> +    pmd_t pmdval;

Why declare a new variable? Can=E2=80=99t we use *pmdvalp instead?

>=20
>    if (pvmw->flags & PVMW_SYNC) {
>        /* Use the stricter lookup */
> @@ -25,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, s=
pinlock_t **ptlp)
>        return !!pvmw->pte;
>    }
>=20
> +again:
>    /*
>     * It is important to return the ptl corresponding to pte,
>     * in case *pvmw->pmd changes underneath us; so we need to
> @@ -32,10 +35,11 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw,=
 spinlock_t **ptlp)
>     * proceeds to loop over next ptes, and finds a match later.
>     * Though, in most cases, page lock already protects this.
>     */
> -    pvmw->pte =3D pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
> -                      pvmw->address, ptlp);
> +    pvmw->pte =3D pte_offset_map_rw_nolock(pvmw->vma->vm_mm, pvmw->pmd,
> +                         pvmw->address, &pmdval, ptlp);
>    if (!pvmw->pte)
>        return false;
> +    *pmdvalp =3D pmdval;
>=20
>    ptent =3D ptep_get(pvmw->pte);
>=20
> @@ -67,8 +71,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, s=
pinlock_t **ptlp)
>    } else if (!pte_present(ptent)) {
>        return false;
>    }
> +    spin_lock(*ptlp);
> +    if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pvmw->pmd)))) {
> +        pte_unmap_unlock(pvmw->pte, *ptlp);
> +        goto again;
> +    }
>    pvmw->ptl =3D *ptlp;
> -    spin_lock(pvmw->ptl);
> +
>    return true;
> }
>=20
> @@ -278,7 +287,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *=
pvmw)
>            step_forward(pvmw, PMD_SIZE);
>            continue;
>        }
> -        if (!map_pte(pvmw, &ptl)) {
> +        if (!map_pte(pvmw, &pmde, &ptl)) {
>            if (!pvmw->pte)
>                goto restart;
>            goto next_pte;
> @@ -307,6 +316,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk=
 *pvmw)
>        if (!pvmw->ptl) {
>            pvmw->ptl =3D ptl;
>            spin_lock(pvmw->ptl);
> +            if (unlikely(!pmd_same(pmde, pmdp_get_lockless(pvmw->pmd)))) {=

> +                pte_unmap_unlock(pvmw->pte, pvmw->ptl);
> +                pvmw->ptl =3D NULL;
> +                pvmw->pte =3D NULL;
> +                goto restart;
> +            }
>        }
>        goto this_pte;
>    } while (pvmw->address < end);
> --
> 2.20.1
>=20

