Return-Path: <linux-kernel+bounces-386519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDC49B447B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1ED283B62
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD0B20400C;
	Tue, 29 Oct 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T7wNz+9M"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34922038CF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191425; cv=none; b=rni0L4dfR1cdqmJk8PKBZdZvOYUeh/5r2XVudcYYYJQ4zzuJLbyBnAOJsiQJLOvh+LsrSwoYeN40aHJaxtJOlHZj6WshnuF8PB1+9s8SobKi+RCjYWvIqILJuCfjdJYUptyxYblYqd7Qq8gQvpiXaw11BINfr5H5KXw83KnNWPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191425; c=relaxed/simple;
	bh=rjQUBk/h/qOWeOcjPvc050HhC7K3zhpO2LdvAjesrOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiePnJ1NfcIdyBoCOrHoABoDwkiU4k9NcV7rb3U60c63olY5f2MToRrl3x8t7OYTbxlHYxUv8Jc3ZdAxa+C9AdltLXJy/ycRplUSp2inG3BIqnkirdtVuIcyxMS2c7vm/4o4m0br2uFXFcnrqhIfS+eoD/ztlWeve4uZrtl6IKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T7wNz+9M; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-539e59dadebso6055141e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730191420; x=1730796220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BLXKVldI/g3voxoBGLq0d6DqPKPKG/canXisgbzAIBc=;
        b=T7wNz+9MGFnam7GWuDXwRe3XAsxyaBUmKn9yVQRIzSRm3zwKRNT9AUcIMb1Sit6Q4R
         /yHs814bxJ5p5gRKK3wjKuuyuf4eDF80nyZOYqrzGTCH6PSw8jXtxhFZW90zy8JvFg38
         1aJGG/w3Ug2f0dInIO++NCO6TRCEJV1kS5RLJqGn/WwIzDdUwoE0DRAqMo8mOfgHXtNk
         hU5G5WWG1dxpG7ZGPP4NBB5RGc/+FE2vACfGC2mv9CwO4dw+1Un4CxN7/nNBkZWL71SO
         XYy2x80C6bLZ3Prc4EXrZkO1RU6Cqu7SOSbDbbf/Vb7xr8DMATpAVAzR9yPN22eqihqW
         2r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191420; x=1730796220;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLXKVldI/g3voxoBGLq0d6DqPKPKG/canXisgbzAIBc=;
        b=dKURGOMZQkC5jpZgC4ozfd5ADEAnWnucma9nn/WM6/KXPnOqon/xNmsl1PjCCY7VQH
         skbEy5WZwv2T8d4+F0NqsZoRH6oburf2l0iRMkpm/u//ybGS9oC42WbW8sZ1cFHeOGU6
         kQLib3TACkzoJRwUuROh5K+V4h3PrxyUrtU2gqOqGQmAtdxvv+99QG6D6x8LG85FRKtl
         MAovBzUw05l/9Cj6jyZKJoj1HWZx9LfuFa0chzorwQ2J+GzYbbGq5H4mS//PaHz68lDg
         GNIIRCa63cA5HkRw4v58CiGMyMRlCaiW73eSsmF+VG0A7Noz3uLO3wYI4gDdV1X+ikLr
         OkWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhK9N2CzRa7l95ArK3mvrYjchsYKubFRLjRGAqEm8szNWHm/lMK93VZKmLz8PeyZEgpqLscxDiGDLfMfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2QA5i4I8422xZLZHEKadFw3lm95xCLteol5Uy13a5rezTrYMZ
	2U/+/YU9ylmE/RleRxnR3RDNqhA5T240cI4CZgpYbh0WNIiLwZkQ2Ae29rEbdBs=
X-Google-Smtp-Source: AGHT+IEGLZnRrJy/jMMoUb+FFDp/k5KZoUpVk1H48XaQaLGmoEYg9e8WQhMQ+3GpwDXEQHgslaN6KQ==
X-Received: by 2002:a05:6512:238a:b0:539:f949:c027 with SMTP id 2adb3069b0e04-53b348f9b74mr5202491e87.18.1730191419938;
        Tue, 29 Oct 2024 01:43:39 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a4c0esm138314875e9.27.2024.10.29.01.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 01:43:39 -0700 (PDT)
Message-ID: <49593924-4e4a-4341-9a10-5733a9be082b@suse.com>
Date: Tue, 29 Oct 2024 09:43:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Drop allocation of object without mountpoint
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 matthias.bgg@kernel.org, Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20241028-v3d-v1-1-907bee355edf@gmail.com>
 <38486268-ad83-4719-8ad5-ead05935d02d@igalia.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <38486268-ad83-4719-8ad5-ead05935d02d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maria,

On 29/10/2024 01:41, Maíra Canal wrote:
> Hi Matthias,
> 
> Thanks for your patch!
> 
> On 28/10/24 11:27, matthias.bgg@kernel.org wrote:
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> Function drm_gem_shmem_create_with_mnt() creates an object
>> without using the mountpoint if gemfs is NULL.
>>
>> Drop the else branch calling drm_gem_shmem_create().
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>   drivers/gpu/drm/v3d/v3d_bo.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
>> index 
>> 7055f7c7bcfe5700aee10b09ecc0005197323b01..f6df9e0947b6ee06043cdbb42c4f98a71bdeba4d 100644
>> --- a/drivers/gpu/drm/v3d/v3d_bo.c
>> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
>> @@ -157,13 +157,8 @@ struct v3d_bo *v3d_bo_create(struct drm_device *dev, 
>> struct drm_file *file_priv,
>>       struct v3d_bo *bo;
>>       int ret;
>> -    /* Let the user opt out of allocating the BOs with THP */
>> -    if (v3d->gemfs)
>> -        shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
>> +    shmem_obj = drm_gem_shmem_create_with_mnt(dev, unaligned_size,
>>                                 v3d->gemfs);
> 
> Please, run scripts/checkpatch.pl before sending the patch.
> 

I did with b4 prep --check which gave no errors, just double checked with:
$ ./scripts/checkpatch.pl 
0001-drm-v3d-Drop-allocation-of-object-without-mountpoint.patch
total: 0 errors, 0 warnings, 14 lines checked

0001-drm-v3d-Drop-allocation-of-object-without-mountpoint.patch has no obvious 
style problems and is ready for submission.

I suppose you want line "v3d->gemfs" to get an extra tab, correct?

Regards,
Matthias

> Best Regards,
> - Maíra
> 
>> -    else
>> -        shmem_obj = drm_gem_shmem_create(dev, unaligned_size);
>> -
>>       if (IS_ERR(shmem_obj))
>>           return ERR_CAST(shmem_obj);
>>       bo = to_v3d_bo(&shmem_obj->base);
>>
>> ---
>> base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d
>> change-id: 20241028-v3d-1d2546ed92d7
>>
>> Best regards,
> 

