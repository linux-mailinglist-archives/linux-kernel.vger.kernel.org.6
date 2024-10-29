Return-Path: <linux-kernel+bounces-386116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BF99B3F45
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1AE1F230B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D751DD53F;
	Tue, 29 Oct 2024 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WsOo4j2Y"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A929A2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730162511; cv=none; b=h/lV6GMJ7P8O/luGJdvKUYBEILzAMSwPHTfZHM4P8vYsMJDshouly7U1m17ILpeOoAmqkGLxHq3cVecV0yxtf8cserZHlilKrvFHcmTZBKG7ctxYLJw4ku8AsMvyqKqZoZPtKEk8USBa2SQ+Sm+RTcm8PTNr2QdL0gcCX6qpDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730162511; c=relaxed/simple;
	bh=Sg2Gdno0/YosylKsPtRmRXJ3jkTNS70TalrTeGxZ7bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5UY3ZWURDhKT58XW0eMPv0Wii6chBxjCbIUydoCGZQCYLBgw9u1Qiq8aq6bddByazR6YyoO2qH6Cf8W5ySaJOezYTqMlt+IPhgQyTaGuAqDpBFZz29IYoHXLkn3fL7y275gmjs3GICypN1v5NKbgVfU5ORloZUX7HoSg2SZuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WsOo4j2Y; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8Dq2glZ0NfqhvV5y6suDwt/Z1dbtk682WCmFRR6oDqs=; b=WsOo4j2YQHKycPmIT2RZgxRVav
	vk1RYMj3ZTACmClMc5CN9VtyG9MLN2Uc5CvNXCbRXKds1yTrW8c7jjMIymSq/fGmWo2lHLnDeKiHB
	pLA+xNGnFjwutMRHOXRuBPtlPMGCzJLpGYzLb1M1W5/G7b0ucRPKDPyjfo6oARiosotTFHz0SAf9Z
	XzO3d0RWTCOfrIyjNzuxVwQoUihzoQV02dCYUrpBHPztw/TQWNmKeMOkZEB+006VktgrrgE0JK/b6
	eVRvGKZrn6OWWhoihHlQlAKMQYmHl03LXe0TU6Ymx7m4+drqiVw4UCAf1buwy7lxOVECYxHhCcrDz
	hr8IdSww==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t5aIj-00GJ8x-Lu; Tue, 29 Oct 2024 01:41:37 +0100
Message-ID: <38486268-ad83-4719-8ad5-ead05935d02d@igalia.com>
Date: Mon, 28 Oct 2024 21:41:32 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Drop allocation of object without mountpoint
To: matthias.bgg@kernel.org, Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20241028-v3d-v1-1-907bee355edf@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20241028-v3d-v1-1-907bee355edf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Matthias,

Thanks for your patch!

On 28/10/24 11:27, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Function drm_gem_shmem_create_with_mnt() creates an object
> without using the mountpoint if gemfs is NULL.
> 
> Drop the else branch calling drm_gem_shmem_create().
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>   drivers/gpu/drm/v3d/v3d_bo.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index 7055f7c7bcfe5700aee10b09ecc0005197323b01..f6df9e0947b6ee06043cdbb42c4f98a71bdeba4d 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -157,13 +157,8 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, struct drm_file *file_priv,
>   	struct v3d_bo *bo;
>   	int ret;
>   
> -	/* Let the user opt out of allocating the BOs with THP */
> -	if (v3d->gemfs)
> -		shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
> +	shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
>   							  v3d->gemfs);

Please, run scripts/checkpatch.pl before sending the patch.

Best Regards,
- Maíra

> -	else
> -		shmem_obj = drm_gem_shmem_create(dev, unaligned_size);
> -
>   	if (IS_ERR(shmem_obj))
>   		return ERR_CAST(shmem_obj);
>   	bo = to_v3d_bo(&shmem_obj->base);
> 
> ---
> base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d
> change-id: 20241028-v3d-1d2546ed92d7
> 
> Best regards,


