Return-Path: <linux-kernel+bounces-280645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F2394CD3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37909B214DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB37F19149A;
	Fri,  9 Aug 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFdY83lv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5294D19148D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195359; cv=none; b=OHJ33v+04hZwa21snSdwoP5qGtOhJbnRelJhrQLwGIfJDj9S8YNqtzzb/tErg/UiZ0x9C3ETnVzvrK2/e0ZImV7HVnaCwHihURMOHGS3S9/dcijo9d9+yK2bOahEwO3zGTUdl56D5K9Qwqb2x02piEB+ZIeAM/y2FR25JtiSoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195359; c=relaxed/simple;
	bh=jdYk4YTRrNkooMsni21SZjXI18mLEBXQkuJ8py7nY+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opGU93Z5Nq9rJNWZyEr2Jc1g+e9cygmkQm9GZTkh/9F3Y62rk4I8AbtksTAa8I9Zq3AD0aeNt1R++9p+enSVJbnsV18afOMzYjSOqYVBRSw37AyFi4Eg7ILTzODzMVMZuFIzU0LEbH7N3Q9I4aaNx3dVai0AOVqqHCDuzAKkVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFdY83lv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723195357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BDv163H6Bi3O1k6DViCc+myNqZR4ExwgVShUmudZIdU=;
	b=fFdY83lvm6Y6eWnKns5DmdgY4kgerJUxckRQjYPRJJkg97zjijHqo4VuPHDLyOV4p7Ujof
	vsiHe3mbyF+Joh9Z2YJsJZVRoTnh8ynafmPz5sY9f97MjtaJ8zZvmX9bRZ8WWWfMDIPwgl
	OSTGaw2m5ctdhWc1x9Ga0vaCXhBLDE4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-unywhUFPN66gIvMLW2I_eg-1; Fri, 09 Aug 2024 05:22:34 -0400
X-MC-Unique: unywhUFPN66gIvMLW2I_eg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428207daff2so13320125e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195353; x=1723800153;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BDv163H6Bi3O1k6DViCc+myNqZR4ExwgVShUmudZIdU=;
        b=m6X016CSNem7psE8r1LkpEe5ZG4hF3Rod76uvMjVayYoi12CuMvG3uN0k7MmqZgWCL
         bFdFB0Xc9jCIhItVfrk6CipCY2PPhKtTVwxHRpAZobZXcFKnUYIulae9beWpgCRIrgmh
         AOD8373jkY2Nvo41N1OcC92W0hImVyxbLwgK9ep2ODopSFqUdNDtWhnY7YSa3nc0BGIG
         cociAkJK9km093XNcKAR/q8vp+AO0su4Ewcq4JmDdxwhatXYq0gebNMDXSE5BLR3f3eh
         oizlyaljisDbp1apNC7MUZaZRhjr8pP2Q8bNghyKiwOe0bbJ3c2IKAjzpRktpRdz0axJ
         jRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8u9V3jRfNVZ/fkD9g1QtND9wAXpWJsLNwDuLf/Lm25MhSI0Nmn2hkmgz69dcstP8eBXuQ6XWrQZ/alyMe3YGoLAUX9UypBoDDQ1im
X-Gm-Message-State: AOJu0YyNUzMCKw61LyQIz0xSpPz1UAFPG2SzV1HQBlvbDKR19BhJmONQ
	DvpFb8oZBar8giTGe1vvxhqJDBK8B45cljx68bdVAwxAh+ZhKEPUVlBSkQ/LAVoNZJB+FiiFRwT
	sMbZ6GZHlqPPXFUIg7Q59XFDgGVrFkUfcCA4xXIUeKedgsOVIpqwef2vTH3Gtyw==
X-Received: by 2002:a7b:ce07:0:b0:429:994:41ae with SMTP id 5b1f17b1804b1-429c3a17a22mr6800475e9.2.1723195353639;
        Fri, 09 Aug 2024 02:22:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjQV/rdx8PUo9vUQyfaTjez+THFqUPuYqAd3V1sDHGnyKOutxuvkeX2zQH9nqEVdP3Eeh70w==
X-Received: by 2002:a7b:ce07:0:b0:429:994:41ae with SMTP id 5b1f17b1804b1-429c3a17a22mr6800245e9.2.1723195353063;
        Fri, 09 Aug 2024 02:22:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:4e00:b097:7075:f6ba:300a? (p200300cbc71c4e00b0977075f6ba300a.dip0.t-ipconnect.de. [2003:cb:c71c:4e00:b097:7075:f6ba:300a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c72d551sm67614045e9.2.2024.08.09.02.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 02:22:32 -0700 (PDT)
Message-ID: <c063335f-a29e-433e-9192-39c7b3e5d06e@redhat.com>
Date: Fri, 9 Aug 2024 11:22:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, hanchuanhua@oppo.com,
 Barry Song <v-songbaohua@oppo.com>
References: <20240808010457.228753-1-21cnbao@gmail.com>
 <20240808010457.228753-2-21cnbao@gmail.com>
 <e9f82fd8-e1da-49ea-a735-b174575c02bc@arm.com>
 <1222cd76-e732-4238-9413-61843249c1e8@arm.com>
 <4465afdc-23e9-4844-a0a0-519f49b1229c@redhat.com>
 <616401ea-289d-4ae2-acde-6704b0fa9c46@redhat.com>
 <9f8ba5c8-5bc3-4af2-96d2-2f52ee923ef5@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9f8ba5c8-5bc3-4af2-96d2-2f52ee923ef5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 11:05, Ryan Roberts wrote:
> On 09/08/2024 09:58, David Hildenbrand wrote:
>> On 09.08.24 10:42, David Hildenbrand wrote:
>>>>> Not sure I fully understand why David prefers to do the unaccounting at
>>>>> free-time though? It feels unbalanced to me to increment when first mapped but
>>>>> decrement when freed. Surely its safer to either use alloc/free or use first
>>>>> map/last map?
>>>>>
>>>>> If using alloc/free isn't there a THP constructor/destructor that prepares the
>>>>> deferred list? (My memory may be failing me). Could we use that?
>>>>
>>>> Additionally, if we wanted to extend (eventually) to track the number of shmem
>>>> and file mthps in additional counters, could we also account using similar folio
>>>> free-time hooks? If not, it might be an argument to account in rmap_unmap to be
>>>> consistent for all?
>>>
>>> Again, see NR_FILE_THPS handling. No rmap over-complication please.
>>
>> ... not to mention that it is non-sensical to only count pageache folios that
>> are mapped to user space ;)
> 
> Yes, good point. I'll get back in my box. :)

Well, it was a valuable discussion!

anon folios in the swapcache are interesting: they are only "anon" after 
we first mapped them (harder to change, but would be possible by using a 
NULL mapping maybe, if really worth it; with memdesc that might turn out 
interesting). But once they are anon, they will stay anon until actually 
reclaimed -> freed.

-- 
Cheers,

David / dhildenb


