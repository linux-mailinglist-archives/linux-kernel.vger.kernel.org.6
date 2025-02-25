Return-Path: <linux-kernel+bounces-531708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87EA443DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5BE188F652
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137026B093;
	Tue, 25 Feb 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MLWQZpXz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7AB26BD90
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495909; cv=none; b=rRx+3W17FUJbTpmsmrAKyEge41KYkF9ii9scQzFcNG+SjoU110MXyFL6w81FFemPN4EZc81V5nBvoP9cyT+QUMgc+yieD9s63bjodPAgWIQ6K3vr/p7wTgoYhEOmoIEuiXbqrsxqvFxka5z/IEJArC3kyhvC3L52Q8r7tT9/mJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495909; c=relaxed/simple;
	bh=xCTtrHDdXUTIma0E6i1UNMQGYB9gWHwdyQbD5ikxQig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5UBf8Um1fr7ic4IEKKOFrGkYl9zNE8x5tU2ym3XxJ0C3Hc5xfms2PQ2MRjKhWdqpMqVg4Bq12E0tUuRY55+4d+Xe6hFKAS1mXrDBktcHThFIEHQrs9tDCXzxo0yQTPukmP0Z2aqFmUO/nOBnVld7lKEzbp/+4JH4g9gdoycUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MLWQZpXz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740495905;
	bh=xCTtrHDdXUTIma0E6i1UNMQGYB9gWHwdyQbD5ikxQig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MLWQZpXzxGEwiizt3jBSXSieYKq5MHfftP6Zw4kzkzUVZ6eyd+EhyCwqgrrWqKnt7
	 mFhuEpstRuKMWuY+ONICCuMs6jxVOefolMEMx5fOWERsqa33NhtVvhDv70yl289oP6
	 QD/r/0Al8nXN/t34OV6fYGmiWrNsv0jvWyplMxHH6Rj7Mth47iRccC2Plk0YxNcWoC
	 Sb43qL4SUXJBtWDfBwra2nSbj9AzwcDhlED0Vs4poJMHQNRryp3taSnw7qgZUGqv5k
	 sRN3og3MfutSmqt5eUrelyAn8fTtH15NvKNbyskHebDYD083sC0+boRJRBaEdwVnSR
	 P0h26cIWx6I2A==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9FB5217E0CFA;
	Tue, 25 Feb 2025 16:05:04 +0100 (CET)
Date: Tue, 25 Feb 2025 16:04:59 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Steven
 Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com
Subject: Re: [RFC PATCH 6/7] drm/panfrost: Use shmem sparse allocation for
 heap BOs
Message-ID: <20250225160459.664ce342@collabora.com>
In-Reply-To: <20250218232552.3450939-7-adrian.larumbe@collabora.com>
References: <20250218232552.3450939-1-adrian.larumbe@collabora.com>
	<20250218232552.3450939-7-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 23:25:36 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Panfrost heap BOs grow on demand when the GPU triggers a page fault after
> accessing an address within the BO's virtual range.
>=20
> We still store the sgts we get back from the shmem sparse allocation func=
tion,
> since it was decided management of sparse memory SGTs should be done by c=
lient
> drivers rather than the shmem subsystem.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 12 ++--
>  drivers/gpu/drm/panfrost/panfrost_gem.h |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 85 +++++--------------------
>  3 files changed, 25 insertions(+), 74 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index 8e0ff3efede7..0cda2c4e524f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -40,10 +40,10 @@ static void panfrost_gem_free_object(struct drm_gem_o=
bject *obj)
>  		int n_sgt =3D bo->base.base.size / SZ_2M;
> =20
>  		for (i =3D 0; i < n_sgt; i++) {
> -			if (bo->sgts[i].sgl) {
> -				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
> +			if (bo->sgts[i]) {
> +				dma_unmap_sgtable(pfdev->dev, bo->sgts[i],
>  						  DMA_BIDIRECTIONAL, 0);
> -				sg_free_table(&bo->sgts[i]);
> +				sg_free_table(bo->sgts[i]);
>  			}
>  		}
>  		kvfree(bo->sgts);
> @@ -274,7 +274,11 @@ panfrost_gem_create(struct drm_device *dev, size_t s=
ize, u32 flags)
>  	if (flags & PANFROST_BO_HEAP)
>  		size =3D roundup(size, SZ_2M);
> =20
> -	shmem =3D drm_gem_shmem_create(dev, size);
> +	if (flags & PANFROST_BO_HEAP)
> +		shmem =3D drm_gem_shmem_create_sparse(dev, size);
> +	else
> +		shmem =3D drm_gem_shmem_create(dev, size);
> +
>  	if (IS_ERR(shmem))
>  		return ERR_CAST(shmem);
> =20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.h
> index 7516b7ecf7fe..2a8d0752011e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> @@ -11,7 +11,7 @@ struct panfrost_mmu;
> =20
>  struct panfrost_gem_object {
>  	struct drm_gem_shmem_object base;
> -	struct sg_table *sgts;
> +	struct sg_table **sgts;

I guess using an xarray here would make sense. Or maybe even an
sg_append_table, since we don't expect holes in the populated pages.
This makes me wonder if we really want the gem_shmem layer to automate
sgt creation for sparse GEM objects. Looks like something the driver
can easily optimize for its use-case.

