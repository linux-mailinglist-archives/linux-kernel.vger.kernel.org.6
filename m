Return-Path: <linux-kernel+bounces-555613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3F4A5BA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1857A7AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E39A224247;
	Tue, 11 Mar 2025 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RC5XNDhs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602B224244
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679558; cv=none; b=hl9Or9Q1NbipdN+x+1gI3f40ETjEOq3xX/kO8IfKmN5VtCShoyUMnqCqaMAdiymRWXCx7EgSppKSvnM+UxqHANgVyUdpxFOgdWI3DkLpmsoxQLxm4EUT7rFLC8m9UuWnbJP+sdi1jtEKhKka4yPbKb6C0jqPgZe61OMUspzs1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679558; c=relaxed/simple;
	bh=EimAiqOb8wjiUPBJICf8ehV1iDRon72lxCFcAtQyG1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRoixCVy547bqripCSCxdSh2amnbjj3sOJEjy3A6tapri3pM65BsNT6/CTeGknZKM2hgtZ3K6vdKB0YLZjOmxgFoXWJUn4/hSWOMc5Yy8mfyScz2hhrnfLr0zcDtxDKNt8O0sB1xWS3ANfClm+sw2NofStArLt3n2snESsHeP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RC5XNDhs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741679553;
	bh=EimAiqOb8wjiUPBJICf8ehV1iDRon72lxCFcAtQyG1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RC5XNDhswZec48hvGwJO3Ne0/FLgT7vITlZQ0t2ppxFhr8b6Yinjer64D49aJuXVm
	 fb9xWd3Gx9HrmuCr1BCZpoc4Ys4/wHamUXeX56j75E+9niet0Ku/ZEjbQwrIME+QYy
	 WbzAXLVyPRvs4dFaPXa+azYplQUMs8IMaY/r9XlLbb2iLnIlMo21YzuQH4cV4kGg+j
	 RnMiqz2lA5/i5lJfPYa7YhSyD/+RDtCEmSHM9r+ekNcwNvkNux4Dt9hBoEsUuEL9qP
	 aq17fyGgqimLjGUfkXGm3OjulnGBOaImG4LYUH4Gm3JXD+EjbgQXQ/ThqNupvPZlHR
	 qd+uYu7o8NyiA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A8B5817E0237;
	Tue, 11 Mar 2025 08:52:32 +0100 (CET)
Date: Tue, 11 Mar 2025 08:51:58 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com
Subject: Re: [PATCH v1 3/6] drm/panfrost: Unify panfrost_mmu_enable/disable
 common code
Message-ID: <20250311085158.37329b0c@collabora.com>
In-Reply-To: <20250310195921.157511-4-ariel.dalessandro@collabora.com>
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
	<20250310195921.157511-4-ariel.dalessandro@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 16:59:18 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> Both these functions write to MMU_AS_CONTROL register in the same way.
> Define a common _panfrost_mmu_as_control_write function with the shared
> code.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 33 ++++++++++++-------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 294f86b3c25e7..31df3a96f89bd 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -121,38 +121,37 @@ static int mmu_hw_do_operation(struct panfrost_device *pfdev,
>  	return ret;
>  }
>  
> -static void panfrost_mmu_enable(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
> +static void
> +_panfrost_mmu_as_control_write(struct panfrost_device *pfdev, u32 as_nr,
> +			       u64 transtab, u64 memattr)

I'm honestly not convinced this is needed. Let's just stick to
panfrost_mmu_enable/disable().

>  {
> -	int as_nr = mmu->as;
> -	struct io_pgtable_cfg *cfg = &mmu->pgtbl_cfg;
> -	u64 transtab = cfg->arm_mali_lpae_cfg.transtab;
> -	u64 memattr = cfg->arm_mali_lpae_cfg.memattr;
> -
>  	mmu_hw_do_operation_locked(pfdev, as_nr, 0, ~0ULL, AS_COMMAND_FLUSH_MEM);
>  
>  	mmu_write(pfdev, AS_TRANSTAB_LO(as_nr), lower_32_bits(transtab));
>  	mmu_write(pfdev, AS_TRANSTAB_HI(as_nr), upper_32_bits(transtab));
>  
> -	/* Need to revisit mem attrs.
> -	 * NC is the default, Mali driver is inner WT.
> -	 */
>  	mmu_write(pfdev, AS_MEMATTR_LO(as_nr), lower_32_bits(memattr));
>  	mmu_write(pfdev, AS_MEMATTR_HI(as_nr), upper_32_bits(memattr));
>  
>  	write_cmd(pfdev, as_nr, AS_COMMAND_UPDATE);
>  }
>  
> -static void panfrost_mmu_disable(struct panfrost_device *pfdev, u32 as_nr)
> +static void panfrost_mmu_enable(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
>  {
> -	mmu_hw_do_operation_locked(pfdev, as_nr, 0, ~0ULL, AS_COMMAND_FLUSH_MEM);
> -
> -	mmu_write(pfdev, AS_TRANSTAB_LO(as_nr), 0);
> -	mmu_write(pfdev, AS_TRANSTAB_HI(as_nr), 0);
> +	int as_nr = mmu->as;
> +	struct io_pgtable_cfg *cfg = &mmu->pgtbl_cfg;
> +	u64 transtab = cfg->arm_mali_lpae_cfg.transtab;
> +	u64 memattr = cfg->arm_mali_lpae_cfg.memattr;
>  
> -	mmu_write(pfdev, AS_MEMATTR_LO(as_nr), 0);
> -	mmu_write(pfdev, AS_MEMATTR_HI(as_nr), 0);
> +	/* Need to revisit mem attrs.
> +	 * NC is the default, Mali driver is inner WT.
> +	 */
> +	_panfrost_mmu_as_control_write(pfdev, as_nr, transtab, memattr);
> +}
>  
> -	write_cmd(pfdev, as_nr, AS_COMMAND_UPDATE);
> +static void panfrost_mmu_disable(struct panfrost_device *pfdev, u32 as_nr)
> +{
> +	_panfrost_mmu_as_control_write(pfdev, as_nr, 0, 0);
>  }
>  
>  u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)


