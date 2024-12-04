Return-Path: <linux-kernel+bounces-432024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38029E43E2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5677D16256C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4231A8F9C;
	Wed,  4 Dec 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="hKIO6NN7"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03CC1A8F74
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338694; cv=pass; b=qFKNWXGCratmtoyruDgbQosxu953754p8/v4bPDsMAG/WZSXhxDMWM/BB5VprOwb2x0Db+/LpJRZz5DfT96Ji4CvLfKNZj4l/c80XeLncDy/DcFZs039UbR6QpBzOYZARt/5XbP2kaAcCUA5FzOHekTbX9b/MZM8P8XMJuC5Wrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338694; c=relaxed/simple;
	bh=kL0wHnRKyt75a71rQDBmS5MAneELeYb7/NZPPiIpxVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpMEIJFWUlfh6a543w22Bs5BrI29E8YOxmqrb96gQ/gWw2FZmst4lGWENG8m4EPurukZJqf5BH+y29BUX8RcWU396gTLd2ZSGR9ws10ygv5Yb6danIFEz9/6nAdMHVgxXCZfXqWZwQQXTibNsXh0B31FTKgeg9BJWCVuOP+GhHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=hKIO6NN7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733338670; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HLze4pzrbha0zcN1WjZEWN2pIoFijb6iPIl6xBJjqO4GhH6FJg3zxe2TFBo8j22GM1FbYD4ANcAWxSXhmbqyaxg8xtRDYXrZpGK3+ryNXke/v5nz7VK/Rd3Ig8lIhP5xzcLg8aJ1xbUjXQ25C9322zCs9ZbVVYnqMa92pPtZX7Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733338670; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jD5EgxmC/9STTH3q9eeIrSSBkYjwxLOo+Pfdmbxo/+c=; 
	b=D7Ph3g+eX/FCaAmF8JaL/JiLCFBNNldf/eqCrsKZ19+abPfT5nFYXUc+W10uC1UIStefHKD2uLryYNb5O+UDPGHRpnu7gxnM0Hn7YYn/pCpiKre3pHkI7eZxbRIOYNK0XWGq+d3XmJ0Vk12izAljWez4tXJzqDS3JMMXHsWONO8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733338670;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=jD5EgxmC/9STTH3q9eeIrSSBkYjwxLOo+Pfdmbxo/+c=;
	b=hKIO6NN7/sp2JOjCaqxTxsmxldXDJjNdzez6SqfGrbBG2KrxUpj4gNOuJs8jbmhL
	gSLuMYl82Mc/+HTGRK2qBzE68c2agQp01/ZA2umUx/lQfk8PdU4CjLbhorxBE9wjYj0
	77sjXrW0plnmQuWLKCmiX/EO+I6e0fQvTICExAa0=
Received: by mx.zohomail.com with SMTPS id 1733338670037314.62844329298014;
	Wed, 4 Dec 2024 10:57:50 -0800 (PST)
Date: Wed, 4 Dec 2024 18:57:46 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] drm/panfrost: Handle error when allocating AS
 number
Message-ID: <tseqozsin6zltqyksnhj476kbzvg27kp4xmyo7kdzvwa4hj2mf@5unrjfg5ezuv>
References: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
 <20241204184945.1477677-5-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204184945.1477677-5-adrian.larumbe@collabora.com>

On 04.12.2024 18:49, Adrián Larumbe wrote:
> If we reach the beginning of the LRU AS list, then return an error.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c     | 6 +++++-
>  drivers/gpu/drm/panfrost/panfrost_mmu.c     | 5 +++--
>  drivers/gpu/drm/panfrost/panfrost_mmu.h     | 2 +-
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 9 ++++++++-
>  4 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 83bc74f6044e..d10f66f4cc53 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -214,7 +214,11 @@ static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  		goto err_hwsubmit;
>  	}
>  
> -	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
> +	ret = panfrost_mmu_as_get(pfdev, job->mmu);
> +	if (ret < 0)
> +		goto err_hwsubmit;
> +
> +	cfg = ret;
>  
>  	job_write(pfdev, JS_HEAD_NEXT_LO(js), lower_32_bits(jc_head));
>  	job_write(pfdev, JS_HEAD_NEXT_HI(js), upper_32_bits(jc_head));
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 2189e42d2bfa..03ac527b35e7 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -155,7 +155,7 @@ static void panfrost_mmu_disable(struct panfrost_device *pfdev, u32 as_nr)
>  	write_cmd(pfdev, as_nr, AS_COMMAND_UPDATE);
>  }
>  
> -u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
> +int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
>  {
>  	int as;
>  
> @@ -197,7 +197,8 @@ u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
>  			if (!atomic_read(&lru_mmu->as_count))
>  				break;
>  		}
> -		WARN_ON(&lru_mmu->list == &pfdev->as_lru_list);
> +		if (WARN_ON(&lru_mmu->list == &pfdev->as_lru_list))
> +			return -EBUSY;
>  
>  		list_del_init(&lru_mmu->list);
>  		as = lru_mmu->as;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
> index 022a9a74a114..e6e6966a0cca 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
> @@ -16,7 +16,7 @@ void panfrost_mmu_fini(struct panfrost_device *pfdev);
>  void panfrost_mmu_reset(struct panfrost_device *pfdev);
>  void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev);
>  
> -u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
> +int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
>  void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
>  
>  struct panfrost_mmu *panfrost_mmu_ctx_get(struct panfrost_mmu *mmu);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index f30817bcf8ba..c551fa1ddfe5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -130,7 +130,12 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  
>  	perfcnt->user = user;
>  
> -	as = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> +	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> +	if (ret)
> +		goto err_unsetuser;

Just realised this should be 'if (ret < 0)', will fix in a following revision.

> +
> +	as = ret;
> +
>  	cfg = GPU_PERFCNT_CFG_AS(as) |
>  	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
>  
> @@ -164,6 +169,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  
>  	return 0;
>  
> +err_unsetuser:
> +	perfcnt->user = NULL;
>  err_vunmap:
>  	drm_gem_vunmap_unlocked(&bo->base, &map);
>  err_put_mapping:
> -- 
> 2.47.0


Adrian Larumbe

