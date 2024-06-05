Return-Path: <linux-kernel+bounces-202009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE18FC67D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20271C233E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B80F1946C4;
	Wed,  5 Jun 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrFz2pYN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D921946AA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576392; cv=none; b=YWykjkqUqYn3Wqi3WAGCWDfsOGaOH0guJ9xsQl6P1hbKeb6u3WBbnDFKEk0K6HbmOo9v/ef92TKSKTn+Fmxw6U/qGUXHESzY7KXU/5sAnGpg88x2yK5A7ylTvzQGRPw2biFVgWbiyuai0WsNPhIPH8WiU1oqLrJETUggNJsKUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576392; c=relaxed/simple;
	bh=N8QMxywkVzOOXxjekLVtTWzwPdjpkwUkHtDprP5ykUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnJgMKb3jxFYTuEn/m6Z8OKjYCu8idgnnlSyULl1RF21GnMPx41GfdVdiypq8PMueFSoD4H0KRr/ta/fwrPx4axMNoVauYXyp3aP6hSLAIlFux6/8EycwbqGm/YXCrLyy+3fbxKoe0JAmk3UOsJI2vl6h3TY0/fIQV8Zk6bTUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrFz2pYN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717576389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WcOL4hlhqFz7sQJM3WA2WfYapedFCFMjouF+k0iN+Eg=;
	b=RrFz2pYNzjJegpImxT7hT8YFdXHUurSTtE/5vmaAkOk82ymPo5p4WiigXboxhbazJVNfqT
	JZk/kQaohkTgfieYqY1Cj4lwVuSZnM0AYKpT57eQnd8My3cQgOc8oBK77TbCIqY0uAH/HP
	bMOCMbZH0eZkkipe8xw0WyOjTSsLRVI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-woV_LEPjN-GTgyVxF9q57w-1; Wed, 05 Jun 2024 04:33:08 -0400
X-MC-Unique: woV_LEPjN-GTgyVxF9q57w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ea9aeae4e6so40275591fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576386; x=1718181186;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WcOL4hlhqFz7sQJM3WA2WfYapedFCFMjouF+k0iN+Eg=;
        b=VXEaJKKmmpYDq9kb/3VL2f4CG8LtrnS/cTvGaS8kM/MkabLXbSRJWOcAlB5vbAnyGM
         Aj7/tyYECqEXxJWr0VlyM9L+f5l2/f+VO6tQ5RUPGS6usbk4qV/wWVJey5wqHTH8xLub
         3JUnr1lSjEdXsZgqxiNJaoLMUj0Gbxfdh9ZDVt7/FXgrBnk2Dv4/SU/UF7ZxJ9M2g27i
         BlEhJMJs/H2S/lUx/89n8aVmC2uilkYrg/TR0e+ogtSdYl2cUZ0Gl3q2874zf3zdFxWb
         ziq6jlcKKxcGYtEkqnSMqmu4Cz+lXBeQQH2kEsqLxYusVJqcP5Sn/XvOQfkvGUzJ1oKp
         5ppA==
X-Forwarded-Encrypted: i=1; AJvYcCXfPEEM81Qh+J0vy9izLsUKjM43NmvyWm9OOiBDEeVEjDDK7aLxVTBPLr/oxCLow9fXvCaUfphOiXGyDH1rfq9svg2ZsklEV7IB0uLM
X-Gm-Message-State: AOJu0Yx8TAD+sg+qL1nYmxLcwZTiS+/l8YeogBLRCrrF6KKhJ/LrUgXl
	6+ReznKFtu/33q/2yNQta5DABeRKTyu1kdTb7F/v8mgdsxoBowuSgKayCwKFvj34dX+zrYMYA6A
	UPhMYuC/hQ50uYI30n4hIpgiqb0+XtlmqdkDiZN78RaQnScxs7MZPtWkuxkpS9y9DC9jFcQ==
X-Received: by 2002:a05:651c:a05:b0:2e9:821a:82fb with SMTP id 38308e7fff4ca-2eac797fb55mr15326941fa.6.1717576384403;
        Wed, 05 Jun 2024 01:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY2ePoZvVhQ6r6TLFrDS6G2FFhtYEQF5poI8Hqgid3x3wYt25SEseXRe7KH5NRsa+QtBQ6Og==
X-Received: by 2002:a05:651c:a05:b0:2e9:821a:82fb with SMTP id 38308e7fff4ca-2eac797fb55mr15326681fa.6.1717576383992;
        Wed, 05 Jun 2024 01:33:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff? (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de. [2003:cb:c706:3100:19a8:d898:8e69:6aff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04cc0b6sm13597124f8f.44.2024.06.05.01.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 01:33:03 -0700 (PDT)
Message-ID: <62c19f0d-4dfe-4bc8-99b6-c84583747093@redhat.com>
Date: Wed, 5 Jun 2024 10:33:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: ran xiaokai <ranxiaokai627@163.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mhocko@kernel.org, ran.xiaokai@zte.com.cn,
 v-songbaohua@oppo.com, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
 ziy@nvidia.com
References: <05e50d0c-4222-4c1f-b051-c7249f04c661@redhat.com>
 <20240605083008.891170-1-ranxiaokai627@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240605083008.891170-1-ranxiaokai627@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 10:30, ran xiaokai wrote:
>> On 05.06.24 04:20, ran xiaokai wrote:
>>>> On 04.06.24 07:47, xu.xin16@zte.com.cn wrote:
>>>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>>>
>>>>> When I did a large folios split test, a WARNING
>>>>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
>>>>> was triggered. But my test cases are only for anonmous folios.
>>>>> while mapping_large_folio_support() is only reasonable for page
>>>>> cache folios.
>>>>
>>>> Agreed.
>>>>
>>>> I wonder if mapping_large_folio_support() should either
>>>>
>>>> a) Complain if used for anon folios, so we can detect the wrong use more
>>>> easily. (VM_WARN_ON_ONCE())
>>>
>>>> b) Return "true" for anonymous mappings, although that's more debatable.
>>>>
>>>
>>> Hi, David,
>>> Thanks for the review.
>>> I think a) is better.
>>> But we have to add a new parameter "folio" to mapping_large_folio_support(), right ?
>>> something like mapping_large_folio_support(struct address_space *mapping, struct folio *folio) ?
>>> But in the __filemap_get_folio() path,
>>>
>>> __filemap_get_folio()
>>>     no_page:
>>>       ....
>>>       if (!mapping_large_folio_support(mapping))
>>>
>>> the folio is not allocated yet, yes ?
>>> Or do you mean there is some other way to do this ?
>>
>> If we really pass unmodified folio->mapping, you can do what
>> folio_test_anon() would and make sure PAGE_MAPPING_ANON is not set.
> 
> I think I just misunderstood your suggestion.

Likely my use of "folio" was confusing.

> How about this ?
> 
> static inline bool mapping_large_folio_support(struct address_space *mapping)
> {
> 	VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
> 			"Anonymous mapping always supports large folio");
> 
> 	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> 		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> }

Yes, and we should likely document that this is not supposed to be used 
with mappings from anonymous folios.

-- 
Cheers,

David / dhildenb


