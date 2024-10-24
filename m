Return-Path: <linux-kernel+bounces-380142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C719AE972
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046EA1F235A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE77B1E7671;
	Thu, 24 Oct 2024 14:55:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1DA1E7661
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781730; cv=none; b=IINCaMB+T+FkUSvBhn7K+kF0C+6LaZLEG1NtCARUWB/PkiJYixOVXDqoV3SqG1umu4SR4ue305DHiVh6l7UvFuenRHaiAnMCb3B643xsIvs00zTVcVbKs0QGB1iwesEwA8xAGHiLAiqB6xuiYkENnZSVEuiaXHzjnaOINHPQixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781730; c=relaxed/simple;
	bh=eiy24wb+/m3Zp1g4Qno9prLh3/M1XwvFhKaX852Aks4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4Z9WYKjnxOtOPjSSZ721nS/x4SpPLPaTZTchjoSH0L8jOOyXmSMNhRVThm/ydQClbg/30znw3gzXnLvqdS9EoOaWssYxUwgIOrnBwdvy/3uVkkdyytVZ9zTRKAT+LYb/yIdhj+6/+VmQaivkih8nLqZdTMXPeN5I0myaMEXWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1FE7165C;
	Thu, 24 Oct 2024 07:55:57 -0700 (PDT)
Received: from [10.1.30.45] (e122027.cambridge.arm.com [10.1.30.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34DE33F528;
	Thu, 24 Oct 2024 07:55:26 -0700 (PDT)
Message-ID: <1561ac0a-5322-4867-927f-13dcf1316d8d@arm.com>
Date: Thu, 24 Oct 2024 15:55:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/panfrost: handle inexistent GPU during probe
To: Boris Brezillon <boris.brezillon@collabora.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241014233758.994861-1-adrian.larumbe@collabora.com>
 <20241014233758.994861-2-adrian.larumbe@collabora.com>
 <20241021160642.1dbeb772@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241021160642.1dbeb772@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/10/2024 15:06, Boris Brezillon wrote:
> On Tue, 15 Oct 2024 00:31:37 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
>> Just in case we're dealing with a yet not recognised device.
> 
> While I can see how problematic it would be if we expose a GPU that
> requires kernel quirks we don't know about, I suspect the original
> authors had a good reason to allow probing of unknown GPUs (ease of GPU
> bringup), so I'll defer that one to Steve and Rob.

Unless I'm missing something as things currently stand the code will
just walk off the end of the array. So this patch is really a bug fix.

I might have said something about being able to probe unknown GPUs being
good. But given we're not expecting any future job manager based GPUs I
don't think it matters.

Reviewed-by: Steven Price <steven.price@arm.com>

>>
>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>> ---
>>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> index 5a33919fa213..495621324de1 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> @@ -237,9 +237,10 @@ static const struct panfrost_model gpu_models[] = {
>>  	 */
>>  	GPU_MODEL(g57, 0x9003,
>>  		GPU_REV(g57, 0, 0)),
>> +	{0},
>>  };
>>  
>> -static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
>> +static int panfrost_gpu_init_features(struct panfrost_device *pfdev)
>>  {
>>  	u32 gpu_id, num_js, major, minor, status, rev;
>>  	const char *name = "unknown";
>> @@ -324,6 +325,12 @@ static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
>>  		break;
>>  	}
>>  
>> +	if (!model->name) {
>> +		dev_err(pfdev->base.dev, "GPU model not found: mali-%s id rev %#x %#x\n",
>> +			name, gpu_id, rev);
>> +		return -ENODEV;
>> +	}
>> +
>>  	bitmap_from_u64(pfdev->features.hw_features, hw_feat);
>>  	bitmap_from_u64(pfdev->features.hw_issues, hw_issues);
>>  
>> @@ -344,6 +351,8 @@ static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
>>  
>>  	dev_info(pfdev->base.dev, "shader_present=0x%0llx l2_present=0x%0llx",
>>  		 pfdev->features.shader_present, pfdev->features.l2_present);
>> +
>> +	return 0;
>>  }
>>  
>>  void panfrost_cycle_counter_get(struct panfrost_device *pfdev)
>> @@ -486,7 +495,9 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
>>  	if (err)
>>  		return err;
>>  
>> -	panfrost_gpu_init_features(pfdev);
>> +	err = panfrost_gpu_init_features(pfdev);
>> +	if (err)
>> +		return err;
>>  
>>  	err = dma_set_mask_and_coherent(pfdev->base.dev,
>>  					DMA_BIT_MASK(FIELD_GET(0xff00,
> 


