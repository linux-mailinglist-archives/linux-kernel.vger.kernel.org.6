Return-Path: <linux-kernel+bounces-350827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39513990A31
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699301C22234
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053671D9A56;
	Fri,  4 Oct 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQQn6NIy"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6750A63
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063234; cv=none; b=sq9emCohTA+njtq7qunN3u0+FROUZGDQbMZYSLgCKaXeB0Bb5Fty0Ev7qRiw0z1YEE/5rN3QdkPmV73oTXdyCdSJZ2GFCO9QefCBsFF8HCxAk3jNA4/L+albCJYFsYfRqAwIVzIk/e6WZ+xhbFM9GhMZPkH7qathoaIKcXWkIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063234; c=relaxed/simple;
	bh=9NfMVBeKjnG18KjI5a74a/1RrTVNQPTbdHtavUmMzL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OP2/K7kwQUxVVOMZNUac+tqWiTtKipsw3yQ0CRwnEGmf2rQH0G/NBV15YEMKvzu3XrobjlX5o+Tc0MxfdnS83ZLV24PjLoIkwEigbeepw7bEAZoL2G67yL4aNuF0St8rFKbgL31ckB5I6h3dp3HSiTqOjWhlNKVELDqHzModp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQQn6NIy; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82aac438539so104183539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728063232; x=1728668032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgjqbFQ8hXrOjTXuOvQSjPVxsFmi6mOfY4A+dK7+CZQ=;
        b=JQQn6NIy4HXRGISvV7b0uIM3Jg3UR6gYf0/5ElYG4M7oqPqN6Ke5BWXUJCElxtwYUs
         MundUE4g+MgFSBPGMA5C5BA1cTR7crqAwtibGaJGSnddL+NXclXh4CRBQLUAYyosTaEK
         pMCLsKExlXKoEVCLn+tdA5IMLAaWO3/gR/kp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728063232; x=1728668032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgjqbFQ8hXrOjTXuOvQSjPVxsFmi6mOfY4A+dK7+CZQ=;
        b=MSyn7hOAiomkEli9PFnU7wkcmgPrKNf43ID01qcAFFCGRWqtUGi89NXb5XZd4kpfzx
         YnJqQwZ6lmHri/C2ygT40Je1+Yv2TVEEkUW5LPhpE6H17rNJWdvQ0qOs47DbEJun1lT5
         xduct1JK0lZgxg9b/pYLPaxiangV3mzur2ctD3fkyWmHvNG6GIaKEtQFCTI36feqIaVj
         RckhsD8votqJwnY1qjpekUMn1iRWiV7rM3u8mvUcGkqPUKQvHODJgAb2gCNbgVADQogA
         cA0V9qPAy1M6sp+ZcX5KMvwPSbE456ed+XLpAtDSnEqhp7DD+SJ1o2WzVM/Nh/Em8E10
         A12w==
X-Forwarded-Encrypted: i=1; AJvYcCUGJGayQErr+eTFWYOLfGcRp8E9CHUL6F4ICb72Y/nmSSa4hQ6guHmsb4/NzVRH11OGhuS8Taru1l782PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Jx8jHWlIpiYnvLYZPn+jBGTQCJlHfKnTkPg0Pe5c3P16pPvz
	pAQOkRt8BMw13hzqmtKRB0eACwhzZh8fg+OYO5Z0a5JiJPyMwbLBbBLGc/iBKok=
X-Google-Smtp-Source: AGHT+IFWtN+nePXXWQrjbLcWtHgnNNN+hX6zEwqzI13DzO7+hHBsT7GAMCn6f/EhVXGV2DP3eQ9Jew==
X-Received: by 2002:a05:6602:3f93:b0:82c:fa71:2326 with SMTP id ca18e2360f4ac-834f7cfb296mr299279739f.8.1728063231607;
        Fri, 04 Oct 2024 10:33:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503b154b5sm4227339f.43.2024.10.04.10.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:33:51 -0700 (PDT)
Message-ID: <7e1d5d2d-1b6d-4232-8d1b-6523849708b5@linuxfoundation.org>
Date: Fri, 4 Oct 2024 11:33:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next] Fix unintentional integer overflow
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Advait Dhamorikar <advaitdhamorikar@gmail.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, leo.liu@amd.com, sathishkumar.sundararaju@amd.com,
 saleemkhan.jamadar@amd.com, Veerabadhran.Gopalakrishnan@amd.com,
 sonny.jiang@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, anupnewsmail@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241004081618.27599-1-advaitdhamorikar@gmail.com>
 <00761132-75f3-41fd-b571-30b0cbe5565d@amd.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <00761132-75f3-41fd-b571-30b0cbe5565d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 03:15, Sundararaju, Sathishkumar wrote:
> 
> All occurrences of this error fix should have been together in a single patch both in _get and _set callbacks corresponding to f0b19b84d391, please avoid separate patch for each occurrence.
> 
> Sorry Alex, I missed to note this yesterday.
> 
> 
> Regards,
> Sathish

Sathish,

Please don't post on top when responding to kernel emails
and patches. It makes it difficult to follow the discussions

> 
> 
> On 10/4/2024 1:46 PM, Advait Dhamorikar wrote:
>> Fix shift-count-overflow when creating mask.
>> The expression's value may not be what the
>> programmer intended, because the expression is
>> evaluated using a narrower integer type.
>>
>> Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
>> Signed-off-by: Advait Dhamorikar<advaitdhamorikar@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> index 95e2796919fc..7df402c45f40 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> @@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(void *data, u64 *val)
>>   		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>   			ring = &adev->jpeg.inst[i].ring_dec[j];
>>   			if (ring->sched.ready)
>> -				mask |= 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
>> +				mask |= (u64)1 << ((i * adev->jpeg.num_jpeg_rings) + j);
>>   		}
>>   	}
>>   	*val = mask;

thanks,
-- Shuah

