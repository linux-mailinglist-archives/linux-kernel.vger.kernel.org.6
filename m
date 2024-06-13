Return-Path: <linux-kernel+bounces-213320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D080F9073B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24CAEB21B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5A144303;
	Thu, 13 Jun 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UR+BIyxP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CB143C50
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285348; cv=none; b=d6aCAA0IszKD8Qa6sdrFfdDo5pGZN+piA9Acp7oS2JaItpb2f1/kZF3QQuEGvBOjM++YGiSnHv1dB7SW066UmPFiGJW7WX1XIZZOzX3y6xrzlssa7ZWttO3wSIe6bFyBalxgieQtALDntPLfrhxm/MFvuX8c3y6D+z8mfrAP2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285348; c=relaxed/simple;
	bh=kEUyYpeN+Fks9phUF46RaR7/sBLTLvnFTGUnsCXezEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Esh36tYCnBHPFJZe+DS/IzrA9RnU+R4m7TVevk0w60teSK48Su42e7F9BphocAo7rFC0j6iHLCO0WwDxb10YBr39e6zbGEztPdYH9GWRr3JgLA/pN4eBuS5yPp5JZUrKItXntJ+w05ja0vuJnqoCyqUUtG5FOFtoMdiCT+DsHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UR+BIyxP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718285345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9MpkKxwzq2w2aCJw7lO134Yt2Yq2mSP410Q+/QHmPLI=;
	b=UR+BIyxPfADdCqCjZuV8U7kRS1IsYwP6JpSKOK0ZOOC7aLN6V8iqg0nUMOa3zRGV/l+OQR
	NDnW/1/gFQl1blS5YgOnSpyqEZYd2c3G3zf6WTINfd1TUQLhircz7qTP5XgV0+PxgMXnQD
	Lpe57s5wLCF7N8bKVZPiFP94B7XO0xs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Nx6k2RzkP6ukX-7y2CJ9iA-1; Thu, 13 Jun 2024 09:29:04 -0400
X-MC-Unique: Nx6k2RzkP6ukX-7y2CJ9iA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-422a0f21366so7891505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285343; x=1718890143;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9MpkKxwzq2w2aCJw7lO134Yt2Yq2mSP410Q+/QHmPLI=;
        b=rDNycIhaUZtoRoFXtSTPhyB+mh92UIPLtzLke/TYVVu6+abZ1ZullxDTx7PG8S/F3O
         AnRc7GxAuprCSI1i2sTpR815jOT+k77/VoBWASLR5U4SaXUisIUgi5LPQLsnsMLDET7y
         v0oK2ptwvcZNtkuah2HDaPmUG2jqfKnjOAVp1Gkjb16bS4pfIYUEWyFex8ZXdM9B5nJH
         tktfS9pxKhFML3okeUJsFlWlp/tEW25awMyrF3enR9wAzEG0EeDnBgSOFaj/rxc4fXV8
         m8I/Zj0Sitx6jQdoNvPS3qZhHzdF0UawSUzuLqHlqDkJtsb2XAPtcpyIWo7ex+SW5UOT
         JFpA==
X-Forwarded-Encrypted: i=1; AJvYcCX/ajo8cX0ulazxYjR8vCePMPjKQXcm/tu/hvnKMjRr8M6bnDMgUul7dj445tLL8qNBr+ARDlnEgwkRqbt26cOMVL514pnGi2NbpGkJ
X-Gm-Message-State: AOJu0YwIaPQePWanD8bJf5iLw4meu+vImmZM0DXopCbiBlrxyMr/5QrW
	FUcrrJ+JdLGdZIz8PvntKGDAe9bWKLe65SauP/ZZh5pxLLWAstwF07pG8fnXKRv4elj2msXQeL6
	mOpgMdPfBh1pSCK/CMyKJIoEQMQQNORPWwY0BdFHXIY0s5xy3EmMM48gXXawvGw==
X-Received: by 2002:a05:600c:4f88:b0:420:177f:c2a6 with SMTP id 5b1f17b1804b1-422c2c64dbfmr25325715e9.10.1718285343104;
        Thu, 13 Jun 2024 06:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcbh3n93XeUmI5nh9ei6KF78qtSGnP9NCToujLpbKUppOIbe8XIp7XjVkJIG2reWqARepP/A==
X-Received: by 2002:a05:600c:4f88:b0:420:177f:c2a6 with SMTP id 5b1f17b1804b1-422c2c64dbfmr25325425e9.10.1718285342586;
        Thu, 13 Jun 2024 06:29:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:fe00:10fe:298:6bf1:d163? (p200300cbc703fe0010fe02986bf1d163.dip0.t-ipconnect.de. [2003:cb:c703:fe00:10fe:298:6bf1:d163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eefa07sm62689845e9.8.2024.06.13.06.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 06:29:02 -0700 (PDT)
Message-ID: <59d82010-c24b-4e83-a9a8-0add8ba1bc82@redhat.com>
Date: Thu, 13 Jun 2024 15:29:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] mm/rmap: remove duplicated exit code in pagewalk
 loop
To: Lance Yang <ioworker0@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 willy@infradead.org, sj@kernel.org, baolin.wang@linux.alibaba.com,
 maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240610120209.66311-1-ioworker0@gmail.com>
 <20240610120209.66311-2-ioworker0@gmail.com>
 <CAGsJ_4y4sKXbq4_ra9tTD-LWgB-x-HECyouxm_9r_N7Kw2We4g@mail.gmail.com>
 <be85ddcc-88ee-4f8d-9f73-b388f4d47b71@redhat.com>
 <CAK1f24kWHWL=nT2uDp=GF6dLp9AYuEVr4=ipUsWGK=cf9Qbfbg@mail.gmail.com>
 <CAK1f24k24dEYWsoQ3avPufaL-A1EaudWtscLpc6XeVOdrZFcFw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24k24dEYWsoQ3avPufaL-A1EaudWtscLpc6XeVOdrZFcFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.06.24 14:43, Lance Yang wrote:
> On Thu, Jun 13, 2024 at 4:49 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> On Thu, Jun 13, 2024 at 4:27 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 13.06.24 09:52, Barry Song wrote:
>>>> On Tue, Jun 11, 2024 at 12:02 AM Lance Yang <ioworker0@gmail.com> wrote:
>>>>>
>>>>> Introduce the labels walk_done and walk_done_err as exit points to
>>>>> eliminate duplicated exit code in the pagewalk loop.
>>>>>
>>>>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>>>
>>
>> Hi Barry and David,
>>
>> Thanks for taking time to review!
>>
>>>> I don't think "return false" necessarily indicates an error, so
>>>> "walk_done_err" doesn't seem like an appropriate name.
>>>> However, this is a minor issue.
>>>
>>> Agreed. As we only have a single walk_done user, should we instead
>>> remove "walk_done", keep the "page_vma_mapped_walk_done" for that single
>>> user, and rename "walk_done_err" to "abort_walk" ?
>>
>> Yeah, I agree that 'abort_walk' is better than 'walk_done_err', and let's
>> keep 'page_vma_mapped_walk_done' for that single user ;)
> 
> I just realized that there is another walk_done user, which is
> unmap_huge_pmd_locked().
> 
> Could I keep "walk_done" but rename it to "done_walk"?

Sure. "walk_done"/"walk_abort" might sound better.

-- 
Cheers,

David / dhildenb


