Return-Path: <linux-kernel+bounces-426548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549F09DF4A1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 05:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B301FB22B6B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 04:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E9233086;
	Sun,  1 Dec 2024 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHN+P8YR"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918D15A8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733026826; cv=none; b=X4mpUi9Jon3+iu4rXAdNtER4CxBb9S5IeWmr3xswtyD9b9eTVvxlRWeeqc4O9KyQNJq5ngxwSBgGjH/lnDwpVUD0djLdA34pMreFk1TPMLbYmdUrT8GewrTJ+bNzEuXJPdQlnSQzA7Vjp9pQuSDMajUBbrwgNYMCO8qYNyTFVmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733026826; c=relaxed/simple;
	bh=VUkUjqL7Rbye/eCuqMhzkEXg8ZZ5YVQQ7/KMUt9x5M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqtH40dt7xe3czgZ9HkydvAeFCS1wkHtogHiXlj8lEDIwP6ZS2nOZK/74e48mr9Yyuj7N1Sur/UVLB1bxD6lCufpOtBY0zklx2VKrXz6qzXyfIQ6FrKGiW41Dxc0OUz3/0EWLvqNmppDF4ovl8X0677zEdiqfEgGu9hX0RDSWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KHN+P8YR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so4268a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 20:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733026823; x=1733631623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmPhZNGPE8mMemtgd5DQsk0URwF4+NKg4toOn7tg90Y=;
        b=KHN+P8YRictlIp4zi9jiiOxzUGruQbk80l+JbnKPj3o2/xDh8h2kZHUfuZiHlCW3+s
         +su7CkuS4Yilc3DjnNgjZ9czh6H6E33OY4OX9HZY4quWvCXyWajB7hHjJ6Y3vbqbTp7e
         92w5IRcnV5IxlEVN7/p3+gKCYcF4M1H/R46YYlO8gtynIGuEbl5mOre+Mj2HudDbVv8Y
         D4GP7A8lT9QoweJRkeqCQTm2pBezxAQuezFvlbqEv54UZj1e0kmoC3mCDhHve6X0MCvc
         jsP/hJf/KXZ/xuymQmTCMeXjKL8FHi8Bxyc9i94fGI0AP4x+tpLEvfVan69z1sf8/YnE
         exOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733026823; x=1733631623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmPhZNGPE8mMemtgd5DQsk0URwF4+NKg4toOn7tg90Y=;
        b=uEVl6B0fVAz+iD9877wJm29NjHUD/r42rJA10S+KtX2hGk4Xjmz9s3dCCCoO0y98lZ
         C688m82oyGkdSnFKyVGnuY8SL6+AakcPat+euRMykA7W2BBvWYlwBHJxII3UcGZt6Tlf
         F65P2KHuCRRHF18yQpPkh3aNlj/U2uonaMCz6JT412lLn4yh0fc3jmBQT/rBFRrzaPLk
         /LQ7Z4loNqUOymIRHbtKqGOqIpsXp7VeUjitNsY9X67/fEykQn0MhJbuhwJz0QbENSja
         hkd8uaXqON6Ofwxfsk6m1j1Cd3CUdjslCBCQJ19nVLMwFtVrHfebJXHMP4lz9GnJOX0x
         REhw==
X-Gm-Message-State: AOJu0Yz9eQr4zdAA234FTUT9n51hYhY8SxlWhFdZS3ZAPYNEdhV0WZMk
	5s2t//DZzuZ4qAjv/fvuf/yTbYdeD9phY739PSVaf6nZcQlXWXhk70DVtWmQJ7a9VMTYtzZ0x2Y
	AR1WJkB+idqcb8N8Rt3nUsZP/1MxWO89dVpaR
X-Gm-Gg: ASbGncsAQPjkDJACKi4mg/0SvyrzEo7cfIKxGfoV8qvTsxmcbtP/sR+r3YpyPMkD4wW
	RerLwrEDusUGi7CjPU7aF09/8pCX9raUfkobdWIEGVKyvz0hqqPxvlqbSTe8tDOdL
X-Google-Smtp-Source: AGHT+IHoeM3ZWdsXpysbtXILaOMhF4g1b9pNpRPjgClx7+msxAyieBJRdcI07s8YXo322NaVWIhNiRHRu3rHoGsXDnc=
X-Received: by 2002:a50:cd5d:0:b0:5d0:bd0d:fc06 with SMTP id
 4fb4d7f45d1cf-5d0bd0dfd4emr82853a12.4.1733026822501; Sat, 30 Nov 2024
 20:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024162516.2005652-1-smostafa@google.com> <20241024162516.2005652-2-smostafa@google.com>
In-Reply-To: <20241024162516.2005652-2-smostafa@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sat, 30 Nov 2024 20:20:10 -0800
Message-ID: <CAE2F3rDyj8WohXHTa1H3_gqTndyJL3cUEfBnXCEibNo1oYTt3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Fix stage-2 map/umap for
 concatenated tables
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 9:26=E2=80=AFAM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> When calculating the max number of entries in a table, Where
> RM_LPAE_LVL_IDX() understands the concatenated pgds and can return
> an index spanning more than one concatenated table (for ex for 4K
> page size > 512).
> But then, max_entries is calculated as follows:
> max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
>
> This leads to a negative index in the page table, where for:
> - map: do nothing (no OOB) as fortunately all comparisons are signed,
>   but it would return a negative mapped value.
>
> - unmap: it would leak any child tables as it skips the loop over
>   =E2=80=9C__arm_lpae_free_pgtable=E2=80=9D
>
> This bug only happens when map/unmap is requested with a page size
> equals to the first level of the concatenated table (for 40 bits input
> and 4K granule would be 1GB) and can be triggered from userspace with
> VFIO, by choosing a VM IPA in a concatenated table > 0 and using
> huge pages to mmap with the first level size.
>
> For example, I was able to reproduce it with the following command
> with mainline linux and mainline kvmtool:
>
> ./lkvm run --irqchip gicv3 -k {$KERNEL} -p "earlycon" -d {$ROOTFS}  --for=
ce-pci -c \
> `nproc` --debug -m 4096@525312 --vfio-pci 0000:00:03.0  --hugetlbfs  /hug=
epages
>
> Where huge pages with 1GB would be used and using IPA in the second table
> (512GB for 40 bits SMMU and 4K granule).
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-ar=
m.c
> index 0e67f1721a3d..3ecbc024e440 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -199,6 +199,17 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte=
,
>         return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MASK <=
< 4);
>  }
>
> +/*
> + * Using an index returned from ARM_LPAE_PGD_IDX(), which can point to
> + * concatenated PGD concatenated, get the max entries of a that table.

I believe the macro that returns an index is called ARM_LPAE_LVL_IDX
not ARM_LPAE_PGD_IDX.

> + */
> +static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable=
 *data)
> +{
> +       int ptes_per_table =3D ARM_LPAE_PTES_PER_TABLE(data);
> +
> +       return ptes_per_table - (i & (ptes_per_table - 1));
> +}
> +
>  static bool selftest_running =3D false;
>
>  static dma_addr_t __arm_lpae_dma_addr(void *pages)
> @@ -390,7 +401,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable =
*data, unsigned long iova,
>
>         /* If we can install a leaf entry at this level, then do so */
>         if (size =3D=3D block_size) {
> -               max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - map_idx_s=
tart;
> +               max_entries =3D arm_lpae_max_entries(map_idx_start, data)=
;
>                 num_entries =3D min_t(int, pgcount, max_entries);
>                 ret =3D arm_lpae_init_pte(data, iova, paddr, prot, lvl, n=
um_entries, ptep);
>                 if (!ret)
> @@ -592,7 +603,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpa=
e_io_pgtable *data,
>
>         if (size =3D=3D split_sz) {
>                 unmap_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
> -               max_entries =3D ptes_per_table - unmap_idx_start;
> +               max_entries =3D arm_lpae_max_entries(unmap_idx_start, dat=
a);
>                 num_entries =3D min_t(int, pgcount, max_entries);
>         }
>
> @@ -650,7 +661,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgt=
able *data,
>
>         /* If the size matches this level, we're in the right place */
>         if (size =3D=3D ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> -               max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx=
_start;
> +               max_entries =3D arm_lpae_max_entries(unmap_idx_start, dat=
a);
>                 num_entries =3D min_t(int, pgcount, max_entries);
>
>                 /* Find and handle non-leaf entries */
> --
> 2.47.0.105.g07ac214952-goog
>
>

