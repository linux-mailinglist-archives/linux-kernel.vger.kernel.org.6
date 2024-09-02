Return-Path: <linux-kernel+bounces-310494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2262967DB4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BC51F222F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC3282F7;
	Mon,  2 Sep 2024 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8iO1ons"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ADB8F6C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725243171; cv=none; b=W68TwnhT7Ftj86+TDf10sSadqPBEkP2f+nUU4/RxjXC6myH0uZk03hI/z06INiL4566DdG6KD/wVLmZPTFKlVBBjn05JF/iUcSDfjijiah8Dw+6QhwS4mTgizw6wfSGjbtStMES+2W4G1nv45jTDOc3nxlu0voT8MX0DqypUh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725243171; c=relaxed/simple;
	bh=3fwQPkIk5njmpureZ7Rm2wYb57YoZ3UCifkx6IOZM3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cv7lJDHSvjIZ/FpKGzE1hRudh2uhtVyxjtEoo0ft8hI6I4DFgNgWzGQWOYBDWfqnMuuC+h8dwcrh2bV0+B1HM3WbAz0Dl+HP05asEUY03TZ9/wrDDKKNN7ZPMqXaIarVuAC7bIuIWvtGtirTbujohjfR/dF7BhOe36tswHq9rco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8iO1ons; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27080f38697so110924fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 19:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725243169; x=1725847969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b792rUVkG8/zhwMnRgEC8EhFO8Dc1UTuLdj5Vohh2ik=;
        b=A8iO1onsVXrgME5MIR1HqDEP/1vLfRxHm93wZqKlT2Y7/fDswf2vw8a7K0u9HhbIS1
         bwkf+p7qNcULNjbXOKvY9071Cu2FSaPJUfSe+w1/qwbZBkwPRlL8+NkSH2n8lQSr07qo
         QmDtdvNtvbGPUpaILiURHXLvne+7YIe1oaS6F5wW56hNVptjG9eToThE2FkkptElyUvb
         mHuo9X14ow3Xam5Scl1q2yVnSP696MmvxJ53kNV5JB9lI1asOFliqG/hR8kA4Xk5WJxl
         ZVIde9RjMOSrKl1oq3Q6nnDRX8K0/CBjo4qAt8xG3bV4amnOkP5cwNkzMKy//l4elU3n
         IwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725243169; x=1725847969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b792rUVkG8/zhwMnRgEC8EhFO8Dc1UTuLdj5Vohh2ik=;
        b=HeHNO3Oa7yd+Z3sqXszu/Zn+bJRtrd2gkvkiezcEImItGxDlLY5gZGGK0ZkZS8Im7S
         61Tu4znqpnEW6jGux86P5Dag/DijtXUsSQMOfw+akR/Y4LC1t60T1JvEB7Fhg1r+3EXs
         Y7O4S0PpmZ+DcUtrtCFdvYuCLiuiH0g8BqiDDfO+HE6dJq4buF/bTNzebXi/HrOb7J7Y
         Js90ZI5YmBvAnf6GBjdc70UOnoUHITNkxVcqE8CLEC0tWyw5T+MLpmIctvOGslMAJm8A
         YVmwEMFcx3jSWtdinN//sMyIohH7mRidkHS+ro8rMQX7bnr5f/QOjFWb0YM3QZ9m2vzs
         FeKw==
X-Forwarded-Encrypted: i=1; AJvYcCVA0Sa5kjh/Xn0aJuxkv5otouSkwowteTcrPVhQjHp6skOW6l2vpaA+PyQtjVXwP8/qp+/LmgQsY71+mr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLmBtNE/MVlXjUrKd/bJ/KOqFbgEtSMDNmP+TZ0ZQAFDu6iqhp
	m7OXbzdGrJ38xnIzDTsN5Mt8t+mGdOee0t/d+ZIa6Y7+x4h1y8Ws
X-Google-Smtp-Source: AGHT+IFMAs2cZr4pjh4kG68h1+g/vrnvbfijv+qYYLq3KZuz/Gmo07oPDwE4Su2kN7oDT7Cfx/cMGg==
X-Received: by 2002:a05:6870:d192:b0:25e:44b9:b2ee with SMTP id 586e51a60fabf-277b0b536b8mr4829847fac.2.1725243168765;
        Sun, 01 Sep 2024 19:12:48 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:5003:d466:54ba:50ca? ([2402:e280:214c:86:5003:d466:54ba:50ca])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d8843sm5883355b3a.160.2024.09.01.19.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 19:12:48 -0700 (PDT)
Message-ID: <bd613707-18b5-4b92-ac59-ed7cec88b769@gmail.com>
Date: Mon, 2 Sep 2024 07:42:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Removed @freeptr_offset to prevent doc warning
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240901055311.20905-1-prosunofficial@gmail.com>
 <898571c5-a150-4a0a-8a18-513fb49aecdc@suse.cz>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <898571c5-a150-4a0a-8a18-513fb49aecdc@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/24 00:56, Vlastimil Babka wrote:
> On 9/1/24 07:53, R Sundar wrote:
>> ./mm/slab_common.c:385: warning: Excess function parameter 'freeptr_offset' description in 'kmem_cache_create_usercopy'
>> Removed @freeptr_offset to fix above doc warning.
>>
>> Signed-off-by: R Sundar <prosunofficial@gmail.com>
> 
> This is for Christian's vfs tree, so added him to recipients.
> There was also a lkp report:
> https://lore.kernel.org/all/202408292249.5oUpnCbS-lkp@intel.com/
> 
Hi,

Thanks for adding recipients.

Sent a v2 patch after adding Reported-by and Closes Tag.

https://lore.kernel.org/all/20240902020555.11506-1-prosunofficial@gmail.com/

Thanks,
Sundar


>> ---
>>   mm/slab_common.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index d48ef4fe1ea8..ad438ba62485 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -353,7 +353,6 @@ do_kmem_cache_create_usercopy(const char *name,
>>    * for copying to userspace
>>    * @name: A string which is used in /proc/slabinfo to identify this cache.
>>    * @size: The size of objects to be created in this cache.
>> - * @freeptr_offset: Custom offset for the free pointer in RCU caches
>>    * @align: The required alignment for the objects.
>>    * @flags: SLAB flags
>>    * @useroffset: Usercopy region offset
> 


