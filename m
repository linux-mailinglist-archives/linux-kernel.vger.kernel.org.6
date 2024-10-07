Return-Path: <linux-kernel+bounces-353451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FAC992E00
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A10F28221E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D6F1D47D7;
	Mon,  7 Oct 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCAz7XjW"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2118BB98
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309417; cv=none; b=Z5NTzdtce4uJSEV/sHjhmeU/JvBfoQU2mRv7/D4aZKcWED+cxtf29OOgqMEDF6Rtf5T0yKhAo2aAfphEj9vL5N4JeyqydQJ8WlXmSTs3J1gAhFmS/zQc+6dEoSaR8qbRjFcLwhhPF6qJuPUSX5bk93BTGYgPvNZUZiQFEP6e3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309417; c=relaxed/simple;
	bh=r75f3uzomJcknMTFVX/ipGjpIWLZT/vLX7515W0C/7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DclGQ7upIkf9l+DgcXZBZ8jTnh0X/lKH0qn9gNhEc+Q+//Hn6Q7aelBa20fRJV0hFkK8eTpdWstEn58wM/Qn00yKwb3Oyz/7f4UvgsjG1IZ/t6M/JBKAPu8hgP/Uz/QIRpDTqtHnqTirT2uyUKWRHWt3WGahar5r68MwY5oYrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCAz7XjW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cce5b140bso3113450f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728309414; x=1728914214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQ61dB7jkql91Wwl4QMMI6l5ptFCuhAlraxPtLhCqb0=;
        b=KCAz7XjWBXjHLyyv3xV9Hot45S2gf8bSFp8nEhvV/ndMBeYc9HTNKN6PluuA/BQhmY
         xT7ubjRq/AhH3k0IF3hvX/m6k8z7kY5WNeoGxhc6tbXbLhvoqBnrQ4pXL5rQ0tYOLXJZ
         cNOJpkZk/HS1T9z9RKwlyQJzML6SzyDOHAjGj4J1crnAGRPX1FTOLwA4oj+gxS3Wu8tQ
         f/+DROGe8AfIBnmaQN2N/zuMCW8f1qLumPer9F6u4/YZOqxu6hkQBwxNYiwm7CNP25we
         8rmbAHi61CBvP8Ko7xPVdEF5FrzrNTdkZiZGKvlDTgxwYMnmV+vaCzRNsyFXqJtfucrM
         w/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309414; x=1728914214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ61dB7jkql91Wwl4QMMI6l5ptFCuhAlraxPtLhCqb0=;
        b=Y6ajXUo7X8iFG/eAm5sEyg32lGWjlAXIKCK3EtmPKDve+TqQvE3qF96XZPgboPxXDx
         sNaise0bu7DrG6g90TN4Q2+ui0e9kqIw7F2sWzC4fWRcIdxdV267JjeW43EIVxuLpZ0n
         5MQgX82ylAe+JIcMOmz3/aHkzcSWFKY3zxZHkVF20jFgoWvUq+WWDGbXLXLRefxMAaiI
         WKBMobfSY6cuOlNNJCxhgSObqiJ2ARbhiqv+DIqvoWFseQdD85E3eO37q2HlL50kbVYe
         a3eXhREQL1UUh3SuF5FUK61h168iT9hciZmEO6XK00uq4/lcWBOGzKB6W7EAiQqnoK12
         D8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWOtffVB5eqcgeoPg9FRmGX/zzXzik/L8FQ/x3hGJaJZrfFvfZfIVTKNug0KDZ9YBPwjdLBuIBzLB9/mNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZhn8ExUo/pHB11rV6Ol7+vj/HKJ3P3Yz+5p5/+tiOO0+9s8G
	phGY2282l4RZX3Zn0Q9MPNiDrYrOZ8U8KUH56Azy0Ok0QG1r6aVb
X-Google-Smtp-Source: AGHT+IH/q1VTtfjLXfrhmwRg+gLiNkYH+OCAEiAquIhPhab6OE1vVHnQyi4Iedws4f5SFu+JB3JeZA==
X-Received: by 2002:adf:ba4d:0:b0:37c:ced2:843f with SMTP id ffacd0b85a97d-37d0e737753mr6460202f8f.16.1728309413887;
        Mon, 07 Oct 2024 06:56:53 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e7e2sm5799578f8f.84.2024.10.07.06.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 06:56:53 -0700 (PDT)
Message-ID: <82c60f1b-a52a-4bc7-a635-06198dba0e13@gmail.com>
Date: Mon, 7 Oct 2024 15:56:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next] Fix unintentional integer overflow
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>,
 "Sundararaju, Sathishkumar" <sasundar@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, leo.liu@amd.com, sathishkumar.sundararaju@amd.com,
 saleemkhan.jamadar@amd.com, Veerabadhran.Gopalakrishnan@amd.com,
 sonny.jiang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, anupnewsmail@gmail.com,
 "Lazar, Lijo" <lijo.lazar@amd.com>
References: <20241004081618.27599-1-advaitdhamorikar@gmail.com>
 <00761132-75f3-41fd-b571-30b0cbe5565d@amd.com>
 <CADnq5_OKww1YZ1R_OytEMLcNVwdq=-ckc2gqQ+WMyOv6AZ9kqg@mail.gmail.com>
 <007679b9-b7b6-4385-9a2e-2be392cb5f58@amd.com>
 <CAJ7bepLv3Z9RwuxoBS3SfkMjeBkN1LRTjLEjT8Lv4Jdu-CXb6Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAJ7bepLv3Z9RwuxoBS3SfkMjeBkN1LRTjLEjT8Lv4Jdu-CXb6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.10.24 um 09:05 schrieb Advait Dhamorikar:
> Hi Sathish,
>
>> Please collate the changes together with Lijo's suggestion as well,
>> "1ULL <<" instead of typecast, there are 3 occurrences of the error in
>> f0b19b84d391.
> I could only observe two instances of this error in f0b19b84d391 at:
> 'mask = (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;`
> and `mask |= 1 << ((i * adev->jpeg.num_jpeg_rings) + j);`
>
> There are a few instances where we can use 1U instead of int as
> harvest_config uses unsigned int
> (adev->jpeg.harvest_config & (1 << i)
> However I think they should be fixed in a separate patch?

No, all of this are numerical problems where not taken into account the 
size of the destination type.

Saying that all of that are basically just style cleanups which doesn't 
need to be back-ported in any way, so please drop the Fixes: tag.

And you should probably change the subject line to something like 
"drm/amdgpu: cleanup shift coding style".

Regards,
Christian.

>
> Thanks and regards,
> Advait
>
> On Sat, 5 Oct 2024 at 09:05, Sundararaju, Sathishkumar <sasundar@amd.com> wrote:
>>
>>
>> On 10/4/2024 11:30 PM, Alex Deucher wrote:
>>> On Fri, Oct 4, 2024 at 5:15 AM Sundararaju, Sathishkumar
>>> <sasundar@amd.com> wrote:
>>>> All occurrences of this error fix should have been together in a single patch both in _get and _set callbacks corresponding to f0b19b84d391, please avoid separate patch for each occurrence.
>>>>
>>>> Sorry Alex, I missed to note this yesterday.
>>> I've dropped the patch.  Please pick it up once it's fixed up appropriately.
>> Thanks Alex.
>>
>> Hi Advait,
>> Please collate the changes together with Lijo's suggestion as well,
>> "1ULL <<" instead of typecast, there are 3 occurrences of the error in
>> f0b19b84d391.
>>
>> Regards,
>> Sathish
>>> Thanks,
>>>
>>> Alex
>>>
>>>> Regards,
>>>> Sathish
>>>>
>>>>
>>>> On 10/4/2024 1:46 PM, Advait Dhamorikar wrote:
>>>>
>>>> Fix shift-count-overflow when creating mask.
>>>> The expression's value may not be what the
>>>> programmer intended, because the expression is
>>>> evaluated using a narrower integer type.
>>>>
>>>> Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
>>>> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>> index 95e2796919fc..7df402c45f40 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>> @@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(void *data, u64 *val)
>>>>     for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>>>     ring = &adev->jpeg.inst[i].ring_dec[j];
>>>>     if (ring->sched.ready)
>>>> - mask |= 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
>>>> + mask |= (u64)1 << ((i * adev->jpeg.num_jpeg_rings) + j);
>>>>     }
>>>>     }
>>>>     *val = mask;


