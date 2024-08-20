Return-Path: <linux-kernel+bounces-294513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F406958E96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829C0B21634
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CE015AAB6;
	Tue, 20 Aug 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONbvTHCr"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7119478
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181860; cv=none; b=sDfA4SOrX97VRqCF4AL+71PjBTAnAs6oDEEAMJKWVKEy0jlTNs5qyI2UV/Nr6Y0UCm7JRQNIt9oeOJYWr206fsJ1H50dAzP1ZulIVXECBpNQ32O5jq7/3/GZ21DQyNCuMHDe7mBLQVv8vNavkTvEon3c2W6bV/I2cWl0I4Kd+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181860; c=relaxed/simple;
	bh=t299G4wo/LSPzgYyloGPTadap2yC1DGA8zL2zSBsoTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfD8hLCLJM2wOGFiw9U2DjXNcSoPyPerKMKw3IPzBkDzt7XsjLPx2tlqicvX9KsY1JbChV2GU2Kfl6VzRxC83O7dwyfiE3WfNBb3jFGILiq/x6xPyFywWQ9fXAoqkHY8fvlXkTvAWfFlkHPtYELrS45DHYCa8avtxsdIleWXhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONbvTHCr; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-494556dfa3aso1754001137.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724181857; x=1724786657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1tmc8256vAJgUbRussYJhC9pRhaSG2mZOYaopGSWZw=;
        b=ONbvTHCrF9CuWf/0w7LibPO0Z1AjX0/v7wLEW99pDejp4dAy/ginGDeXxEMIytdYa9
         RNbahDrzxeKutOk3dlCTpQL6ThuUGdPyn9VpJ818S9dZ7sYUHqW5owIeXpvxgWCwLXT1
         hO/ktF/dh183moiB0VMLf0LCkj4GxAC7/1lmWCRdeli2reZwjcnYqUxzVjKxjB7Wfxty
         EtKUTVALpu9W99aIjRqKboZFgNIQF/8sB+opAHwhKAbWz38HiwxotUyDWPNeQ0e0adxr
         oeD22RCL0vDAXNxYZJc2X4auVpdp9ma2S1Q1pRkqxhbnClldXe7Rth4B/U0TZXaHOKgH
         I5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724181857; x=1724786657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1tmc8256vAJgUbRussYJhC9pRhaSG2mZOYaopGSWZw=;
        b=XSWZsFc1LkRSc9QrdNCVB3YExecvYFqW7PYTrfTQ3NnouTQ8nPcjUpR7y93bCqK8La
         5tIRxS/ZY4w4V1323t7rB6TAj6OdYtEs+hmMqL3O2EfaJl6IQ/TwbGwXsAT2jHEcvyVi
         pF8xfiz3R3iji0qOPn6OdA7a3XH2znxBTKX9e9uGhfLNkSXtoXG5OaVSipU2ZY97As3t
         dooURd0hDJMGOLK+nscSYVgljdNoyPMiVG5ozkk/4PHadTHPKT9tSu7Qhd+qvImRrK1s
         ctzHZLBySWVa16+fxZmpHqqFfXpalE6i1G4pS/iAeV+ycDVR114oKoDFlqxdu8b+UML0
         irgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWKF6ggHTu5svrKSvLDwQ3mVE/VkiZgSP/w3yJJnS2QwgQMBwM/7d5NNpY/umpyCUmfB3JHWnuW0Qfetg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD6QEdHvGRKE18mCVHWBY+XnVJITKzWHaEv/QFHQJ95ccSiKGP
	3HK/jxlMyJhh7Y9plGDe3shh4M04Mks4J2H2YnpIFhsBzAVAfktMprpdgHW3pz8FC6U9EwnsntQ
	OVMT7qxj5wzkAxMSYe4YO8u8au1g=
X-Google-Smtp-Source: AGHT+IFY2u+n2n/e06BscZuEAQwIezb1O2o7j3+4kMxl1BnN3srbwIJ5I/Lxw2uojzdORefUqRGnSPfHUc9eN4WlX04=
X-Received: by 2002:a05:6102:38cd:b0:498:d1b0:210f with SMTP id
 ada2fe7eead31-498d3deec3cmr135794137.11.1724181857571; Tue, 20 Aug 2024
 12:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-numa_policy-v1-1-f096cff543ee@gentwo.org>
In-Reply-To: <20240819-numa_policy-v1-1-f096cff543ee@gentwo.org>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 20 Aug 2024 12:24:05 -0700
Message-ID: <CAHbLzkqH6TtRb4dX0mhDuO-MBk6P9L5pOprYFQ-jjgPFnA7CPg@mail.gmail.com>
Subject: Re: [PATCH] Reenable NUMA policy support in the slab allocator
To: cl@gentwo.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:54=E2=80=AFAM Christoph Lameter via B4 Relay
<devnull+cl.gentwo.org@kernel.org> wrote:
>
> From: Christoph Lameter <cl@gentwo.org>
>
> Revert commit 8014c46ad991 ("slub: use alloc_pages_node() in alloc_slab_p=
age()").
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
> on a single numa node.
>
> SLUB does not apply memory policies to individual object allocations.
> However, it relies on the page allocators support of memory policies
> through alloc_pages() to do the NUMA memory allocations on a per
> folio or page level. SLUB also applies memory policies when retrieving
> partial allocated slab pages from the partial list.
>
> Fixes: 8014c46ad991 ("slub: use alloc_pages_node() in alloc_slab_page()")
> Cc: stable@kernel.org
> Signed-off-by: Christoph Lameter <cl@gentwo.org>

Reviewed-by: Yang Shi <shy828301@gmail.com>

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
> base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
> change-id: 20240806-numa_policy-5188f44ba0d8
>
> Best regards,
> --
> Christoph Lameter <cl@gentwo.org>
>
>

