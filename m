Return-Path: <linux-kernel+bounces-285243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312B5950B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635951C24749
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F551A254F;
	Tue, 13 Aug 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2/wkYSr"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9437E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568746; cv=none; b=M8wF3uqKkxJY7VM9/f3gZeTYWHJSHltdgiFk+zAsEAAFRTdRM8CHvOhcB7jJWgFWezQ2VWLNoFyT1SUkTA/M+OEWch8zr7A8M6SYYb+oaZHcHhRULO9J/q/f9+KkO/Y0RNfQe/s1j9WmTmOCBjKCrWqAusLVjFwbwsOXfCbR1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568746; c=relaxed/simple;
	bh=7Nkr/05BHI2sNeYewbZ6QoRmVufFqUqQCW3Ocr7/PPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn5uMrdPNcG9EFO5keLHsLi+GTyTzr463A6ASEJxbi67JhXP4z1YuCNj8c4YQsf3azt0DVjUz5rEm+10+l9PJ1RbidgwOzdhvoTOxRA54fGs6GDve12ebuMtkhPUzha+OGBXUWasgehbJsBHmgs2zUlX+Ei7XUb1mTJsrqppTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2/wkYSr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a8553db90so681099366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723568743; x=1724173543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOz+svYSfLxFvq4Zy72aYEHt1zXxUJBN8hR7YMAL2+0=;
        b=a2/wkYSrZlt2xJGuLqbux1KCiCcCKvskxBA8Tb8hYEuTzxJs6jZV4a/NjQIby2BgLW
         Yjaf1Cde/1NglL2wvDTnvJPf8A0jhUe5vypHov7k+C8efk9+HFMTHNISrASjTlm/saAz
         UVAIo9IGPiumrEeEhAwLsIKFGqlAvXvQidzaKNMD7xr6tWBwyqHdDhrytu8faI2qeYnw
         xnushS8sezwJBgZmc1Sr3ZZWJ8TEMt2XcjjpMG1pVXrCbkkcpVPdw2JOIkx42grAjx1z
         4gt4YoPtAavSYCgdUKISWvfIIiE4phhyYN9NIDW6Dj4hjV1soPAAvgiko764rHG0TxPZ
         zX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568743; x=1724173543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOz+svYSfLxFvq4Zy72aYEHt1zXxUJBN8hR7YMAL2+0=;
        b=moNGZHTViBe9Xk65JH4pCJ87Lte+5EvAMIT7QIazEsF6B7kvttRwq6acSBXDgXRocU
         kR0A1yIwY/7Mmy6xFVDT2jHntjJLCkZUQRCYFnrRWYe/3YkSM+44bYdpifKFxK397wsn
         GN9gMSJdwmtxcmuCJYWRC9Lej9Yq2yRgukb1M961CeCEvl22/68Cf4tzi4y9dbnhd/2B
         jHpry8sQhnzKrsQRtoreflf4j8ygZ+7tSaGiZ724037Zk7DGlEWEAJMig4mi2dTIW80d
         nYyhThv0YaQRoS7PeHDGREfNRTeSPUpPqxxGFuDn7MymLSxHq0LNH3xhkH0WvzL7tdsX
         DsoA==
X-Forwarded-Encrypted: i=1; AJvYcCX2VQcVDHj2DktPGtdB7z+7VFKP7rSNBH6j5ekgzhVBVTLud60H5n53xzgI1N5ZuCpLfTDzLNNO9Tt6exa2uaWvdAsxjaoSUcn7PWEX
X-Gm-Message-State: AOJu0YwgVV14UkTcE87+0T4kg57fytRolc6z7glN+2gq9O2SEutYLdvY
	vcdZR0q6+1rw0kiB0+eTowhiMV3NfWTcTW3KpRZyqD/4qLpDYx0+3Wl8QWcmRBG+3yo3t3xLlLA
	DETTmUOzTGv7CnoTOU/ZES3Lvujo=
X-Google-Smtp-Source: AGHT+IGh48Faj6W98ywLsGY4D6XVjmDKjngdRIBi6kpYNkZqiI7S1Wr5wlNq36Mi9HRPG/yqIyiZRI5lPNa70w1HzBI=
X-Received: by 2002:a17:907:f782:b0:a7a:9f0f:ab14 with SMTP id
 a640c23a62f3a-a8366d7786fmr692466b.33.1723568743267; Tue, 13 Aug 2024
 10:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812-numa_policy-v1-1-1732602b976c@gentwo.org>
In-Reply-To: <20240812-numa_policy-v1-1-1732602b976c@gentwo.org>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 13 Aug 2024 10:05:31 -0700
Message-ID: <CAHbLzkqeKLPt=HDaFNgUyFF0QLVsbyi-nBZvpoi=7B8gWq-_Qg@mail.gmail.com>
Subject: Re: [PATCH] Reenable NUMA policy support in the slab allocator
To: cl@gentwo.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:55=E2=80=AFAM Christoph Lameter via B4 Relay
<devnull+cl.gentwo.org@kernel.org> wrote:
>
> From: Christoph Lameter <cl@gentwo.org>
>
> Revert commit 8014c46ad991f05b15ffbc0c6ae130bdf911187b
> ("slub: use alloc_pages_node() in alloc_slab_page()").
>
> The patch disabled the numa policy support in the slab allocator. It
> did not consider that alloc_pages() uses memory policies but
> alloc_pages_node() does not.
>
> As a result of this patch slab memory allocations are no longer spread vi=
a
> interleave policy across all available NUMA nodes on bootup. Instead
> all slab memory is allocated close to the boot processor. This leads to
> an imbalance of memory accesses on NUMA systems.
>
> Also applications using MPOL_INTERLEAVE as a memory policy will no longer
> spread slab allocations over all nodes in the interleave set but allocate
> memory locally. This may also result in unbalanced allocations
> on a single node if f.e. a certain process does the memory allocation on
> behalf of all the other processes.
>
> SLUB does not apply memory policies to individual object allocations.
> However, it relies on the page allocators support of memory policies
> through alloc_pages() to do the NUMA memory allocations on a per
> folio or page level. SLUB also applies memory policies when retrieving
> partial allocated slab pages from the partial list.
>

Please add Fixes id. And should it be sent to stable?

The patch makes sense to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

> Signed-off-by: Christoph Lameter <cl@gentwo.org>
> ---
>  mm/slub.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index c9d8a2497fd6..4dea3c7df5ad 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2318,7 +2318,11 @@ static inline struct slab *alloc_slab_page(gfp_t f=
lags, int node,
>         struct slab *slab;
>         unsigned int order =3D oo_order(oo);
>
> -       folio =3D (struct folio *)alloc_pages_node(node, flags, order);
> +       if (node =3D=3D NUMA_NO_NODE)
> +               folio =3D (struct folio *)alloc_pages(flags, order);
> +       else
> +               folio =3D (struct folio *)__alloc_pages_node(node, flags,=
 order);
> +
>         if (!folio)
>                 return NULL;
>
>
> ---
> base-commit: d74da846046aeec9333e802f5918bd3261fb5509
> change-id: 20240806-numa_policy-5188f44ba0d8
>
> Best regards,
> --
> Christoph Lameter <cl@gentwo.org>
>
>
>

