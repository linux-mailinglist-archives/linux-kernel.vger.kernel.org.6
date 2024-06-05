Return-Path: <linux-kernel+bounces-201735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B78FC27D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056DE282964
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B57346F;
	Wed,  5 Jun 2024 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdQLKgOq"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF7C2E3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717559941; cv=none; b=WoCm5YLbR/fq/R1Q6aTXfniwky1H6exChdptoyUHg7qBForwkd9YeVpRhA8QZ9mmJUbKotKeJ2uVvjtcorxcH5mv4oW5fgZhWNqWK17a09x3kdSfpDk2mqHWNrZQYGyPSp1e5W36N/GEMa9wWEROqAdQbPGdqeTervgRUOq8vBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717559941; c=relaxed/simple;
	bh=NP5Aw2nMjZMgodnMxQn6guUitfuYWAkiyDxssP1ovzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hu3hXNho+jIl48F53rDj0+66PNsF0PMhWbSH2xoEPeXpaZKCbYPl20qxAP6yPP9nD44HxTpbgtfD6PKAQfby765t+eql/EH1JhB9sSUTu6mPcBrWOkTGdFewmnvWp5VhBkOaQ/v/VKI45sr+WVHO1W41Xax4p+EnhuHjZ/PozDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdQLKgOq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f48b825d8cso15968945ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 20:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717559940; x=1718164740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54k4JVJ2VfsnpnXkzAM0LcBwi0z2trB1l7d+zq3pvf4=;
        b=TdQLKgOqlyecmfyiRsITIFV60Y1oUNsPZFW502JI/6xQr6No5gcv9A+Sl77+10s92f
         0CDj1KRaBKmeVO09TWzGWhm/JgNYjLRC6zGFobm5lks19ePWrYnpBTF6VXbPcuK0Ld68
         6nJUOJXUcYi0Ghf8GMPHFuy6MgMMyRGSWtzI/2PZ5xUlETjPNaC7yv3G+dpSV4IfAcBJ
         7tQnw1E5bJ2uO27eo/ONQN2khTX5AwPjVsJqqVX4QA6TL+Fr/cJJ5vn+n514nQmPGbC7
         KmEv2MxrRdq2V38LZOME7DOyd2EiVWw0lZ3AOjHuTPEyreZDYQv0feIcNgCyHUiyFCQp
         REaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717559940; x=1718164740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54k4JVJ2VfsnpnXkzAM0LcBwi0z2trB1l7d+zq3pvf4=;
        b=swdtC+QreCQr/8YBtvVk+/SoUWRenqvZO11kbsf84WrRdG4NOMCqu3AuxuQSyBGvA8
         HpKQ5qyd9X5kmu9gzdc36VQgfTGm9PVt3jh9u6obeU4loj8cwtDRm2kbZzx6skVXWA3h
         6RsLpxPcOb5EGGMLC+vYB5gNOBHDruOI9D3o1cw9Ch/LMQgAkVWDae5n13z/TjLMJJ/K
         uFyGHwMv/cgyKPmrtyzbgToMOWrS79Sfias2BfnVRY/3Gthf8/7EwTA4xRX2A+Q20dM3
         LUboT+mDaThVQibgBy/Nk8BI38BrJjt9VMCoan17FURv0A7nRY9Ig5tatkOOVKXjs0x5
         BPdw==
X-Forwarded-Encrypted: i=1; AJvYcCXH+rvgR3E1ORr8suv+MyV3ymKzn+VCo72d+n+qCC980Cw1miqTfzKcYDhKXSsem2tG+pPO92PMrmj6doPDtkz1Jo2kYAp216sczMZN
X-Gm-Message-State: AOJu0YyewykF9N2StgHN+CIq7IHOZ8DRhGAHBdRxduaWLXYp1VkhWIcO
	SeCUtOrfi0IRo/3eJ4OfkjWJ14ZYYCclu8nyEhNUm+Rn+D6iqHTa
X-Google-Smtp-Source: AGHT+IE3tPaE85dvArgrwiDJsTFKRfY975PcDsEMBCKjm98mHDhrWWgCegkkSL7nEGU4MgFPgy/16Q==
X-Received: by 2002:a17:903:2446:b0:1f6:6591:67ad with SMTP id d9443c01a7336-1f6a5a26e4bmr17151125ad.34.1717559939630;
        Tue, 04 Jun 2024 20:58:59 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632379db9sm91096445ad.110.2024.06.04.20.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 20:58:59 -0700 (PDT)
Message-ID: <cf5a0d4a-5291-4d4c-92e5-9340dfa4e8ac@gmail.com>
Date: Wed, 5 Jun 2024 11:58:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm/ksm: skip subpages of compound pages
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-3-alexs@kernel.org>
 <8d3a60d5-06c5-4df4-aeda-2fbec45a8ae0@redhat.com>
 <b3e242b5-c589-47fd-9a02-1e488bed9d15@gmail.com>
 <00dcd224-6333-4f1e-9087-bdb5024ac236@redhat.com>
 <9f4f6f0e-81e8-4bd0-9f20-412a543a452d@gmail.com>
 <3d2ad8a3-30c6-41d6-841b-e8c376d01da3@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <3d2ad8a3-30c6-41d6-841b-e8c376d01da3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/24 9:14 PM, David Hildenbrand wrote:
> On 04.06.24 15:10, Alex Shi wrote:
>>
>>
>> On 6/4/24 6:43 PM, David Hildenbrand wrote:
>>>>>>
>>>>>> @@ -2680,7 +2685,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>>>>>                 }
>>>>>>     next_page:
>>>>>>                 put_page(*page);
>>>>>> -            ksm_scan.address += PAGE_SIZE;
>>>>>> +            ksm_scan.address += nr * PAGE_SIZE;
>>>>>>                 cond_resched();
>>>>>>             }
>>>>>>         }
>>>>>
>>>>> You might be jumping over pages that don't belong to that folio. What you would actually want to do is somehow use folio_pte_batch() to really know the PTEs point at the same folio, so you can skip them. But that's not that easy when using follow_page() ...
>>>>>
>>>>> So I suggest dropping this change for now.
>>>>>
>>>>
>>>> Hi David,
>>>>
>>>> Forgive my stupidity, where I jump over normal page that not to belong to the folio?
>>>
>>> IIUC, you assume that the folio is fully mapped by all PTEs that could span it, and that follow_page() would give you the head page, correct?
>>>
>>> As a simple example, assume only a single page of a large folio is still mapped, which could be any tail page. You couldn't jump over any PTEs.
>>>
>>> Or am I missing something?
>>
>> Uh, thanks for explanations. for what's we concerned, the following code could take care of the FULL or ERR pages. And it still keep the step of single page.
>>                          page = follow_page(vma, ksm_scan.address, FOLL_GET);
>>                          if (IS_ERR_OR_NULL(page)) {
>>                                  ksm_scan.address += PAGE_SIZE;
>>                                  cond_resched();
>>                                  continue;
>>                          }
>> And after the above code, step folio_nr_pages on address should be safe, isn't it?
> 
> Not sure if I follow. Let me try explaining once again:
> 
> Assume a PTE maps some tail page of the large anonymous folio. The other PTEs around it map some other anonymous folios, not pages of that large anonymous folio.


Sorry, David,

Do you meaning there are 2 folio pages, in a same vma, in their address, 'ksm_scan.address', would be overlapped in a folio size space?
If so, that do out of my expect. I do have no idea of this thing. Could you give me more hints of this problem or how things work on it in current kernel?

Thanks a lot!
Alex
 
> 
> Without looking at the other PTEs you don't know how much you can skip.
 
> 

