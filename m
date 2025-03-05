Return-Path: <linux-kernel+bounces-546158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C16D3A4F718
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC467A30D6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9081DA617;
	Wed,  5 Mar 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Uw5Un704"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054541C8619
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156127; cv=none; b=b+9bFBTuC3CP9/KB2+FzNGvSzcryQMXoHFK/tKO++JYTOZruLcKbi93HMLsBOIKRbq54cgXUJK+n6vhdxAUmfP72C3G1HPx+dh8mcUWocPifyQT/tpGz01aKWxA6aD12/vMbeC5cPrTtomAg8ppTMInaQt+mAqWbnoS13v/oo4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156127; c=relaxed/simple;
	bh=t/6e/ltGMRHU92W+9yTJqxRggh9x/8FcNku7LBXvBiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZLIRlsF4fIloOaDRgdqElYC4LCCkqb3GKjW0Ox8boKVhrWx7iK4jX7jCUHOrfAXrG9ZSyB6HJzC5B/2Qmg3SmgB+TwpD4RbEcysWPJ7lhHtzySzOv4/PuGxTiDibztqGrkSSSs0uxB3I7gGiuEliRi8fIpiE+mUw2R9XNclvJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Uw5Un704; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fe98d173daso10341070a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 22:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741156124; x=1741760924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1br0TfBhxe+q8vQJ6EGSi6bewa7fYQgAi2UemQoWNc=;
        b=Uw5Un704en3U5hnAevSG3CjtSTVi6fmXQqNxvRen+0BM0kLEGcMNtPM6Y86uu7STLp
         4mxt7pjqBer6SivYN9pCekj5R2ZObA1dgOMn6GbOJ9abnyzeK07uS0piD4GW4rUJisar
         Dq12bjKkgEMgDqUIvpZ+sBvWLCkzNjAeiTXcU2BnToX0L9G84ZeW+5e8BuFLWRj3OH7h
         MNlmXKpvjcMd/PY/TvQqsB25QSJq+Bnv2y7hNxP2W42S50VvyWr6QAl2K/kUVmBUZwiH
         P6utDqWoZtCcXEYrQQTPIJw7epRd7VJBdLMLlbBl7+SLbXMHZBYMFU4Weor4tdV75OyI
         gw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741156124; x=1741760924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1br0TfBhxe+q8vQJ6EGSi6bewa7fYQgAi2UemQoWNc=;
        b=Y8uxbXd2puOHYMb9uDJdVJWt1EylvQPOC2bjLwbFkeZh0+gps8gkb/5/r+rEC5/Cdx
         0v8FhmuiodYDURNmPH3arlToLfMiiwtYamkv2FJJgBCg8nkiozD92IRQYbpc51uugv82
         t77/Q+Zwul1DDFs1C+WCjykPJYIxz8Rl2HtKo1WJZ95R4qgi5CrPJGmO1ODoQLmZ7wJ0
         DV2SV7wClnsi9Co8stq6tt7aiBitvmTNrtFdWyxTWxP+ByF71EhuNiJwG4OTHTMeWxz8
         1jIosT/2fbbBIZPN2s+PkdQ6lTNZhWttanqD8tXCIsXM+ZIMU+WkBRGC/mGRAcsNitgn
         13zw==
X-Forwarded-Encrypted: i=1; AJvYcCVlNpQFUF9Gxzd/A8LKMALw32CZ+FDnmP94mTvI2peDSaQc3MLullkwZVEuiPMH3/HH4Yzpc4BV+B8Z05E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0UKFD1hsZZXrrfmg1OETHUVmajhXcq0jMfdF1joBXWwpK/04
	7LLK6wdyHPBDQdjCievS+RFDOPuMEuqbmbrrL2rN3aUTVwJogrU7AH1hr3e4CmE=
X-Gm-Gg: ASbGncs/C1E9ARzG/I5/77RcN0gGDBaa7aKcHteHIThLitvj5ULrg0gb2UaPbuYIJh+
	MRbxTVANzL/PYS3hC7aUBRY4uNZciLz9oqTf3SU2KiXFt4xy6DxyfI5LjOxzbDTk7X/MA7+0x0q
	ukdSLOoRPDq/AVQ0VDU6K8OhnfPn/I9S5R0Zm0jIAXY2XhBXeFqxy0yxsx8eDuSiukGDp1Ye0kO
	PVITpBjdEajZ7z/ThT3smaDkkSlFaFuycc5Iq1pGYK8vwqhgVuVXfAUAAwkt7gnCEaw6CQkdUZT
	AV6IxSqItWcJfYw3XRQ1g7fHY+eIqjvJhVi1xs2C1nQ/SlbCqrugSgZ5yJqWBNutIy6V
X-Google-Smtp-Source: AGHT+IFWp6vyYuA3zvhSY2pdqGCwKrLQ/BQB4dKiswdbQTNJ3HH6jVPtGk51GXe+z7B/xPOhUWxq0Q==
X-Received: by 2002:a17:90b:4a82:b0:2fe:7fae:59f7 with SMTP id 98e67ed59e1d1-2ff497ff87cmr4107681a91.33.1741156124141;
        Tue, 04 Mar 2025 22:28:44 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7899f7sm529690a91.22.2025.03.04.22.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 22:28:43 -0800 (PST)
Message-ID: <da4ae4e2-4cda-4a86-b71d-f6b46e6f9772@bytedance.com>
Date: Wed, 5 Mar 2025 14:28:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shrinker_debug: Fix possible memory leak in
 shrinker_debugfs_rename function.
To: liuye <liuye@kylinos.cn>
Cc: akpm@linux-foundation.org, david@fromorbit.com, roman.gushchin@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>
References: <20250305020123.605496-1-liuye@kylinos.cn>
 <99A7645C-B8FB-4F28-B4B8-D5372F4C001E@linux.dev>
 <a2b3609c-9907-4ee6-a0df-6b4c84100d33@bytedance.com>
 <875d80ee-d99a-4580-8648-36adb1e8591c@kylinos.cn>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <875d80ee-d99a-4580-8648-36adb1e8591c@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/5/25 2:10 PM, liuye wrote:
> 
> 在 2025/3/5 11:26, Qi Zheng 写道:
>>
>>
>> On 3/5/25 11:17 AM, Muchun Song wrote:
>>>
>>>
>>>> On Mar 5, 2025, at 10:01, Liu Ye <liuye@kylinos.cn> wrote:
>>>>
>>>> After calling debugfs_change_name function, the return value should be
>>>> checked and the old name restored. If debugfs_change_name fails, the 
>>>> new
>>>> name memory should be freed.
>>>
>>> Seems it is not a big problem, no memory leak at least. The effect is 
>>> that
>>> the shrinker->name is not consistent with the name displayed in debugfs.
>>> Right? But the improvement LGTM. So:
>>
>> Right, so the subject needs to be changed.
>>
>> Maybe:
>>
>> mm: shrinker: fix name consistency issue in shrinker_debugfs_rename()
>>
>> ?
> 
>   I will send a new patch using this subject later.
> And add  Reviewed-by：Qi Zheng <zhengqi.arch@bytedance.com> ？

Sure, with the changes to the subject:

Reviewed-by：Qi Zheng <zhengqi.arch@bytedance.com>

Thanks.

> 
> 
>>
>> BTW, it seems that the callers of shrinker_debugfs_rename() did not
>> process the return value of the function?
> 
> Yes,  At the same time, I also found that many positions using
> debugfs_change_name did not determine the return value.
> 
>>
>>>
>>> Reviewed-by: Muchun Song <muchun.song@linux.dev>
>>>
>>> Thanks.
> Thanks.
>>>
>>>>
>>>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>>>> ---
>>>> mm/shrinker_debug.c | 8 ++++++--
>>>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
>>>> index 794bd433cce0..20eaee3e97f7 100644
>>>> --- a/mm/shrinker_debug.c
>>>> +++ b/mm/shrinker_debug.c
>>>> @@ -214,10 +214,14 @@ int shrinker_debugfs_rename(struct shrinker 
>>>> *shrinker, const char *fmt, ...)
>>>> ret = debugfs_change_name(shrinker->debugfs_entry, "%s-%d",
>>>> shrinker->name, shrinker->debugfs_id);
>>>>
>>>> +     if (ret) {
>>>> +         shrinker->name = old;
>>>> +         kfree_const(new);
>>>> +     } else {
>>>> +         kfree_const(old);
>>>> +     }
>>>>     mutex_unlock(&shrinker_mutex);
>>>>
>>>> -     kfree_const(old);
>>>> -
>>>>     return ret;
>>>> }
>>>> EXPORT_SYMBOL(shrinker_debugfs_rename);
>>>> -- 
>>>> 2.25.1
>>>>
>>>
>>


