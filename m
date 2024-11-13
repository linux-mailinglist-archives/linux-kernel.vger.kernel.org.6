Return-Path: <linux-kernel+bounces-407712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C2B9C7438
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C7B25962
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8768418FDA7;
	Wed, 13 Nov 2024 13:52:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FA0175A5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505968; cv=none; b=Yi+VfnYofZYm0ksodYX2x5Wb1ooCr8ncgVRFUY1jQV+AeLjwgft5u1ZBpFOCDMM8RvTG4HoHHc9lBuIzEHf42oFg6HpgsB4z/Dv2cJptg6JVyrO1rtX/Tc9PJ7FgpxcpS5TfA0iRP/UeNzFcgtIdEjSPD+kUg6AV8NQJv/eUdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505968; c=relaxed/simple;
	bh=Tkvn00KpFb3/WXoCEUiiU6C9/7Y4PKiw4S3iLUNvKG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSiXgTWIvOH0x5PPUZvHfUfrGpipsa0sDbq4IvfPJJ2dM6UHjgSwPqqMg2VTbj0DWrl4fgvrB2m9UQDLRt5cH51zdZpn3i6WFs1iXotuDhgq30ES5UDlI+o+51KaysKNIhUikKYY+agTjMZ8PXEl6tAlSsKZq4f0yR6wmp1G6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F7001655;
	Wed, 13 Nov 2024 05:53:12 -0800 (PST)
Received: from [10.1.27.47] (e122027.cambridge.arm.com [10.1.27.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCDDD3F6A8;
	Wed, 13 Nov 2024 05:52:40 -0800 (PST)
Message-ID: <ff468880-2435-4674-9f06-91bd0cdfe856@arm.com>
Date: Wed, 13 Nov 2024 13:52:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Add GPU ID for MT8188 Mali-G57 MC3
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 boris.brezillon@collabora.com
Cc: robh@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20241113112622.123044-1-angelogioacchino.delregno@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241113112622.123044-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 11:26, AngeloGioacchino Del Regno wrote:
> The MediaTek MT8188 SoC has a Mali-G57 MC3 GPU and, similarly to
> MT8192, it has yet another special GPU ID.
> 
> Add the GPU ID to the list and treat it as a standard Mali-G57.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Looks reasonable to me - I wonder how many different MediaTek specials
there are out there ;)

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index f5abde3866fb..174e190ba40f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -236,6 +236,10 @@ static const struct panfrost_model gpu_models[] = {
>  	 */
>  	GPU_MODEL(g57, 0x9003,
>  		GPU_REV(g57, 0, 0)),
> +
> +	/* MediaTek MT8188 Mali-G57 MC3 */
> +	GPU_MODEL(g57, 0x9093,
> +		GPU_REV(g57, 0, 0)),
>  };
>  
>  static void panfrost_gpu_init_features(struct panfrost_device *pfdev)


