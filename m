Return-Path: <linux-kernel+bounces-374758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F85D9A6F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A751C2318C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4BC199EB2;
	Mon, 21 Oct 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LSd9bRRY"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77A14A90
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528353; cv=none; b=Gmn+3cSVuyg6k3KJNlNyFRVcq3HdnwiY9hEYhq74HfKjeA7xQtZW6c/YK1BHTuk0CA+scGXxuhUW5o3XKjoB/e+zAoKfUPieztss1pomr0TOaQbQpK5pJljakFQz+HCMe7dMVRDrOpA2NPbPK4Jg4eOIly7+nuzbxzPiDV2JvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528353; c=relaxed/simple;
	bh=E3lS7p+zqLiyYZBkWceRW3zq+hXvF7xLouOfzARj1rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctHRKClYYdAYT34desBGdTPFQIGqK5c2CnJ0+hGEroELOOZKghmc+uG58UD0OdAZaZ1KPrZ+Us8/jBPBs42T06IG3BSv+Lxtm91w+eoSBiwi/wPnAayKh4sJYGPHO1WZN+adnzd0BLSWGsCAwdD9NM/nubcH3PQgPTpHz0j5RIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LSd9bRRY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1467af9dbso346839185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729528350; x=1730133150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHfRv1yebnwDS+0649iwM+sezGHIHt8yRwmS2Zjf4z8=;
        b=LSd9bRRYtc+RZmYvr977e71g76AJRuirqw9kQC8XTenWCKzgIa0rdsc9pXeYqrYOBL
         v79HZIEYAd57h7t2yi9jE5C035JOc4uwMgkUvBA/KU8nmebVjdeqb+RjCsVax3hV5mRm
         D1WKpGPHy92lLWErRnfm30ECca4ssQnYOw5Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528350; x=1730133150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHfRv1yebnwDS+0649iwM+sezGHIHt8yRwmS2Zjf4z8=;
        b=t20UKlJIDzNzPWtW8sI8cw6BjhvE7PSVrnTP2QoMXZ3/sa1rLn60D7AdDwg3M7T5nu
         YSqWO94dNSkKDIRGEklFV/AwtoGl+yCkdASQhUvy9L5Zjs/ZbJAFa4sEqR5yVGVDmfD9
         GbESfclyBLfeFRya5lYwpL2sJIbZNkcH1B7EUWhqbLMIpgwU24J6+vwTTu14k12/PKNG
         V8sGUuuysvCrseCXBOVDjMjiVL5DBY8IlViSo+7rsIZyhvqS4asbT501NWdPjyuw18N3
         dF+qOV+/Hs3AlmyjVzgor/yrlrCkGXVcNqgpLMjaQLFYY8XfobMPO1wYIHNx2/mPsmW7
         jBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwophwnlkLdW44Zz/C8q8MKw2dlaS6BvgxYOwgjJl2qFk/WzdivI4NGsEOXMYkiFZB0mWffiAdyKAUUJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdREfIXl0GlVOmeufUTq6HLiMC1ovIMrg5o+7rgRtRZBaxmvQ
	bIdHFrSgjsLZ8IFkH3/APvLjmwdhZUd7VrF2/h2gQ0p1lc9/+R1/jdJoxHZn5OLUwX5gHd17VQf
	E
X-Google-Smtp-Source: AGHT+IF2ndIsKYZ615eG2r9/sHSdksxj4pxybb+WSp/kSj8q4070u+VV6MOvXqQbugvlBagjMw1tgQ==
X-Received: by 2002:a05:6e02:1389:b0:3a3:41cf:f594 with SMTP id e9e14a558f8ab-3a4cb398915mr8414045ab.12.1729528338472;
        Mon, 21 Oct 2024 09:32:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a400aead41sm12467675ab.47.2024.10.21.09.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 09:32:17 -0700 (PDT)
Message-ID: <a85b21a6-e1f6-4b46-9eb7-c1d687888e16@linuxfoundation.org>
Date: Mon, 21 Oct 2024 10:32:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: fix -Wunused-result in linux.c
To: David Laight <David.Laight@ACULAB.COM>,
 "'Liam R. Howlett'" <Liam.Howlett@oracle.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "vbabka@suse.cz" <vbabka@suse.cz>,
 "sidhartha.kumar@oracle.com" <sidhartha.kumar@oracle.com>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241011225155.27607-1-skhan@linuxfoundation.org>
 <ddepbtajvjqoftjqanab7dpcx62pjrl4s3cowhciocevfa43wa@sncxpv75hpjp>
 <13ddebb3e15b4a94b466c6ee5f3f2f42@AcuMS.aculab.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <13ddebb3e15b4a94b466c6ee5f3f2f42@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/24 10:10, David Laight wrote:
> From: Liam R. Howlett
>> Sent: 15 October 2024 02:11
>>
>> * Shuah Khan <skhan@linuxfoundation.org> [241011 18:52]:
>>> Fix the following -Wunused-result warnings on posix_memalign()
>>> return values and add error handling.
>>>
>>> ./shared/linux.c:100:25: warning: ignoring return value of ‘posix_memalign’ declared with attribute
>> ‘warn_unused_result’ [-Wunused-result]
>>>    100 |          posix_memalign(&p, cachep->align, cachep->size);
>>>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../shared/linux.c: In function ‘kmem_cache_alloc_bulk’:
>>> ../shared/linux.c:198:33: warning: ignoring return value of ‘posix_memalign’ declared with attribute
>> ‘warn_unused_result’ [-Wunused-result]
>>>    198 |          posix_memalign(&p[i], cachep->align,
>>>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    199 |                                cachep->size);
>>>        |                                ~~~~~~~~~~~~~
>>>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>>
>>> ---
>>>   tools/testing/shared/linux.c | 14 +++++++++-----
>>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
>>> index 17263696b5d8..66dbb362385f 100644
>>> --- a/tools/testing/shared/linux.c
>>> +++ b/tools/testing/shared/linux.c
>>> @@ -96,10 +96,13 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>>>   		p = node;
>>>   	} else {
>>>   		pthread_mutex_unlock(&cachep->lock);
>>> -		if (cachep->align)
>>> -			posix_memalign(&p, cachep->align, cachep->size);
>>> -		else
>>> +		if (cachep->align) {
>>> +			if (posix_memalign(&p, cachep->align, cachep->size) < 0)
>>> +				return NULL;
>>> +		} else {
>>>   			p = malloc(cachep->size);
>>> +		}
>>> +
> 
> You really ought to be checking malloc() as well.
> Perhaps:
> 		if (...) {
> 			if (posix_memalign(...) < 0)
> 				p = NULL;
> 		} else {
> 			p = malloc(...);
> 		}
> 		if (!p)
> 			return NULL;
> 
> Or just use a hack to get the compiler to STFU :-)

Yes you are right. I will spin another version to cover
the malloc and I just noticed another posix_memalign()
with -Wunused-result that compiler didn't flag in
kmem_cache_alloc_bulk() to fix as well in the next version.

thanks,
-- Shuah

