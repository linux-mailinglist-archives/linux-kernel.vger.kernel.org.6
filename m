Return-Path: <linux-kernel+bounces-427328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658B9DFFE4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77A1160EDE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0A41FDE2E;
	Mon,  2 Dec 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZtQ0OH60"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891D1FDE12
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138053; cv=none; b=gVcvqByyUClBq743Hmxv1nxb5Mt6b1npLD9brL431rdr7jA3Uk/+D5DoaL3BpqYPsmYc7WhCD4fyyhbk6jAECY1wIO43JENL5T1v2BDNYmyCMQcujiaezsyFlHEtPQ4a5hOOELJbu6PvGqJXFVrXgA36wFtkqsCj9SUqQnJfl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138053; c=relaxed/simple;
	bh=fSLEP0Xznoe5DG2bDkv2mmSE1zr9GRef9sdxJ5jCOTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuqq+STeaePf9Kshi1+lDXb3VVrbXzqeqMJmjJyOiQj1LZlwIRFJ//VMyfN/COhMkoh0cfLBYNAVgx7jEt2O/l1O1rSOzccwvK3WH+tNSYXqKAxN9YQMt0bEVlW4FQ9n4smB1asJCWUfujKmfKWUvhARn50b5vQbWq0skD+qmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZtQ0OH60; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733138049;
	bh=fSLEP0Xznoe5DG2bDkv2mmSE1zr9GRef9sdxJ5jCOTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZtQ0OH60JrW5Fzz16wCGtnzgXokG7jqhstLHKJPJ6yJE2xKlqhA0dupEjOLZ/4+ea
	 fv+85nROVve4xdlCviyDXIVAxowexk+3eRkuMXDxkn3CRoJ3OJahbL74LpnzQbMA6P
	 HsjcbdSx/bqJoRpBGGCqCbBzFwD6yiB4/MIUOJzNDGKoxjHhJZ18HtcBsZ8nZJACqG
	 bJp6QvilIsnBaFcRN/qbOmC2oDrqNjV+BgcMvAXFB7pfgayYjemghXEQVlLQJaCbo8
	 R29PiiaYGadGZ4vtz8f37jyl3NTZ2o4rZefAbKvovtFYx7iecLQeQ9ELFGo9jZkNeT
	 Si19aANxm3jUg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ACA3217E3613;
	Mon,  2 Dec 2024 12:14:08 +0100 (CET)
Date: Mon, 2 Dec 2024 12:14:02 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Philipp Zabel
 <p.zabel@pengutronix.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] drm/panfrost: Handle page mapping failure
Message-ID: <20241202121402.0d564c5c@collabora.com>
In-Reply-To: <20241128211223.1805830-6-adrian.larumbe@collabora.com>
References: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
	<20241128211223.1805830-6-adrian.larumbe@collabora.com>
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

On Thu, 28 Nov 2024 21:06:20 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> When mapping the pages of a BO, either a heap type at page fault time or
> else a non-heap BO at object creation time, if the ARM page table mapping
> function fails, we unmap what had been mapped so far and bail out.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 44 ++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 03ac527b35e7..5e30888bea0e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -290,13 +290,31 @@ static void panfrost_mmu_flush_range(struct panfros=
t_device *pfdev,
>  	pm_runtime_put_autosuspend(pfdev->base.dev);
>  }
> =20
> +static void mmu_unmap_range(size_t len, u64 iova, struct io_pgtable_ops =
*ops)

Can we use the following prototype instead?

static void mmu_unmap_range(struct panfrost_mmu *mmu,
			    u64 iova, size_t len)

> +{
> +	size_t pgsize, unmapped_len =3D 0;
> +	size_t unmapped_page, pgcount;
> +
> +	while (unmapped_len < len) {
> +		pgsize =3D get_pgsize(iova, len - unmapped_len, &pgcount);
> +
> +		unmapped_page =3D ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
> +		WARN_ON(unmapped_page !=3D pgsize * pgcount);
> +
> +		iova +=3D pgsize * pgcount;
> +		unmapped_len +=3D pgsize * pgcount;
> +	}
> +}
> +
>  static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu=
 *mmu,
>  		      u64 iova, int prot, struct sg_table *sgt)
>  {
>  	unsigned int count;
>  	struct scatterlist *sgl;
>  	struct io_pgtable_ops *ops =3D mmu->pgtbl_ops;
> +	size_t total_mapped =3D 0;
>  	u64 start_iova =3D iova;
> +	int ret =3D 0;
> =20
>  	for_each_sgtable_dma_sg(sgt, sgl, count) {
>  		unsigned long paddr =3D sg_dma_address(sgl);
> @@ -310,10 +328,15 @@ static int mmu_map_sg(struct panfrost_device *pfdev=
, struct panfrost_mmu *mmu,
>  			size_t pgcount, mapped =3D 0;
>  			size_t pgsize =3D get_pgsize(iova | paddr, len, &pgcount);
> =20
> -			ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
> +			ret =3D ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
>  				       GFP_KERNEL, &mapped);
> +			if (ret) {
> +				mmu_unmap_range(total_mapped, start_iova, ops);
> +				return ret;

I general, I'm not a huge fan of those error paths where things are
undone manually, because they tend to be overlooked when new steps are
added. I'd rather have a  "goto error_unmap_pages;" here, and the
according label defined at the end of the function.

> +			}
>  			/* Don't get stuck if things have gone wrong */
>  			mapped =3D max(mapped, pgsize);
> +			total_mapped +=3D mapped;
>  			iova +=3D mapped;
>  			paddr +=3D mapped;
>  			len -=3D mapped;
> @@ -333,6 +356,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *map=
ping)
>  	struct panfrost_device *pfdev =3D to_panfrost_device(obj->dev);
>  	struct sg_table *sgt;
>  	int prot =3D IOMMU_READ | IOMMU_WRITE;
> +	int ret;
> =20
>  	if (WARN_ON(mapping->active))
>  		return 0;
> @@ -344,8 +368,13 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *ma=
pping)
>  	if (WARN_ON(IS_ERR(sgt)))
>  		return PTR_ERR(sgt);
> =20
> -	mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
> -		   prot, sgt);
> +	ret =3D mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_S=
HIFT,
> +			 prot, sgt);
> +	if (ret) {
> +		drm_gem_shmem_put_pages(shmem);

Same here.

> +		return ret;
> +	}
> +
>  	mapping->active =3D true;
> =20
>  	return 0;
> @@ -532,8 +561,10 @@ static int panfrost_mmu_map_fault_addr(struct panfro=
st_device *pfdev, int as,
>  	if (ret)
>  		goto err_map;
> =20
> -	mmu_map_sg(pfdev, bomapping->mmu, addr,
> -		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
> +	ret =3D mmu_map_sg(pfdev, bomapping->mmu, addr,
> +			 IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
> +	if (ret)
> +		goto err_mmu_map_sg;
> =20
>  	bomapping->active =3D true;
>  	bo->heap_rss_size +=3D SZ_2M;
> @@ -547,6 +578,9 @@ static int panfrost_mmu_map_fault_addr(struct panfros=
t_device *pfdev, int as,
> =20
>  	return 0;
> =20
> +err_mmu_map_sg:
> +	dma_unmap_sgtable(pfdev->base.dev, sgt,
> +			  DMA_BIDIRECTIONAL, 0);
>  err_map:
>  	sg_free_table(sgt);
>  err_unlock:


