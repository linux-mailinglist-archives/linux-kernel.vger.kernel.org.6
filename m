Return-Path: <linux-kernel+bounces-276674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274DF9496D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACE61F25AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD84E4C62E;
	Tue,  6 Aug 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfCdEeqI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40064A2C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965438; cv=none; b=lbYPJGrphfLbntAFH8Ac3EC88XUlGiVRo/I4r6gO82DiOnTeDVtbtqwrds9WqEOHIecD3ogMn4GsPGgy94wnlKBJPGWvhrKsB3HeIJE2LUMxnkf4Nscx37p8t0RxgogwQf8bV2XrNKn6062OaOrdGjO9w/r9nIp7rX5Y3g+ki6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965438; c=relaxed/simple;
	bh=c98tjF12oc7cRowbzizu4sQLmk2Ls/IXuyl4ZD+lvd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0nRbcYqYMqkj7i3sGg9/1pvEkcl1kmohH+mYDxNp8JcGsiOFsOoGDgPpxrAGySFq7qJlVuJwSi23EfzqWhioDBvpdVcwaex//2zyW/khPtELRhevRRDtCajVi2fEtDcY1PajE80/GVYaFb/FDYUDcjydiHv9M6Yg2+IOttvaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfCdEeqI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722965435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L95HKWn21UDCku/Fr+iBmxOcLIFQjrV6E2Z9fB2IFWM=;
	b=HfCdEeqIlMUFpejXnJ13MPTBj1bQ/xaoWy/nq/A5UK9wy1Slnfv7UX+dyzQUU7cGEtLJmO
	dVCRbUO3XWd7lmz1SWup44ORHve+Yd2hdKTWWfiS2H9ynf/pcdR/CFYG4RfPbP0YEelFQd
	fNt8zgJ2QTwtX9BlrArWXnj6e+nqt2o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-JVFV4nIvO2CDmB6VMXryng-1; Tue, 06 Aug 2024 13:30:34 -0400
X-MC-Unique: JVFV4nIvO2CDmB6VMXryng-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef23ec8dcfso9198331fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965433; x=1723570233;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L95HKWn21UDCku/Fr+iBmxOcLIFQjrV6E2Z9fB2IFWM=;
        b=JVCZ6ZH8WA+vsTHBrhFuMNJhvPIW297PM3vlk/J/Npty4+H19sa3VvcyZqJEAmytDL
         AJe+rinZgVCK8a00+PALMoHPBRtRm+nFwzJ+oql6Mx4vo5pFwHMAW3Schn69riBc5oDa
         s72tJHCH0tiu7ywyjoA/noToOnvjFu56zd2oflyyvqzpliVGWK+Yf2NXd7n3hnOcN7y2
         M0+kYphzldME0X3EuJERxslTuUg6lnWfN3eRh3cyVpnWpDAFpm6JgQa/ZcgQZIc0+TDZ
         d+/M1FpfsG9hrgwehjh0JDF4yLhabb5TE413qD+LiIC8gHLpzxXH1PzXJbxMaX8/JGd2
         b6BA==
X-Forwarded-Encrypted: i=1; AJvYcCVFcVaBOFT6S7WMpSidUHfjTDE4K9NlWplPsYuS+66r4FykLcwD2bbb+5Q3O5v00wjKTRHl378hNsGSdsVNBCvxc1HMpoO8jOFqBHen
X-Gm-Message-State: AOJu0YxcE/gR8JcLTDj0SlpLDO8GYRCRbCm8zKXEFsQ7BSg+WQ2ljQga
	VbNemrQAEnE826LBvoUkQPE+ebTqBgyOHIe3htcp7goIE9AEvJG5UU7ZiU1IC8CRwb+X3Q31Brv
	18k17IV5WDOmi0VXVxgZodg3oBJAqY4WgfRkG1lxiya0kbrU9moyqw1eEiu63tQ==
X-Received: by 2002:a2e:968c:0:b0:2ef:2525:be90 with SMTP id 38308e7fff4ca-2f15aaf6231mr120107531fa.31.1722965432851;
        Tue, 06 Aug 2024 10:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoWeBtDiVy9AJYs2t34YgKJ8ZanZJOOVS/+2V8zA7zkmiF4itIKZNQW8yZFUI4CJf7XP6/uA==
X-Received: by 2002:a2e:968c:0:b0:2ef:2525:be90 with SMTP id 38308e7fff4ca-2f15aaf6231mr120107231fa.31.1722965432236;
        Tue, 06 Aug 2024 10:30:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428fecf3f75sm22230775e9.1.2024.08.06.10.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:30:31 -0700 (PDT)
Message-ID: <d302a026-b49b-45d9-ba06-ad2f1c3f14e6@redhat.com>
Date: Tue, 6 Aug 2024 19:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <dc00a32f-e4aa-4f48-b82a-176c9f615f3e@redhat.com>
 <3cd1b07d-7b02-4d37-918a-5759b23291fb@gmail.com>
 <73b97a03-3742-472f-9a36-26ba9009d715@gmail.com>
 <95ed1631-ff62-4627-8dc6-332096e673b4@redhat.com>
 <01899bc3-1920-4ff2-a470-decd1c282e38@gmail.com>
 <4b9a9546-e97b-4210-979b-262d8cf37ba0@redhat.com>
 <64c3746a-7b44-4dd6-a51b-e5b90557a30a@gmail.com>
 <fc63e14d-8269-4db8-9ed2-feb2c5b38c6c@redhat.com>
 <204af83b-57ec-40d0-98c0-038bfeb393a3@gmail.com>
 <58025293-c70f-4377-b8be-39994136af83@redhat.com>
 <930e111a-b13b-43d9-93f8-5bf28f343074@gmail.com>
 <842f3fd3-9d95-4050-8bed-9631a6adca6d@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <842f3fd3-9d95-4050-8bed-9631a6adca6d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.24 19:17, Usama Arif wrote:
> 
> 
> On 05/08/2024 00:04, Usama Arif wrote:
>>
>>
>> On 01/08/2024 07:36, David Hildenbrand wrote:
>>>>> I just added a bunch of quick printfs to QEMU and ran a precopy+postcopy live migration. Looks like my assumption was right:
>>>>>
>>>>> On the destination:
>>>>>
>>>>> Writing received pages during precopy # ram_load_precopy()
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Writing received pages during precopy
>>>>> Disabling THP: MADV_NOHUGEPAGE # postcopy_ram_prepare_discard()
>>>>> Discarding pages # loadvm_postcopy_ram_handle_discard()
>>>>> Discarding pages
>>>>> Discarding pages
>>>>> Discarding pages
>>>>> Discarding pages
>>>>> Discarding pages
>>>>> Discarding pages
>>>>> Registering UFFD # postcopy_ram_incoming_setup()
>>>>>
>>>>
>>>> Thanks for this, yes it makes sense after you mentioned postcopy_ram_incoming_setup.
>>>> postcopy_ram_incoming_setup happens in the Listen phase, which is after the discard phase, so I was able to follow in code in qemu the same sequence of events that the above prints show.
>>>
>>>
>>> I just added another printf to postcopy_ram_supported_by_host(), where we temporarily do a UFFDIO_REGISTER on some test area.
>>>
>>> Sensing UFFD support # postcopy_ram_supported_by_host()
>>> Sensing UFFD support
>>> Writing received pages during precopy # ram_load_precopy()
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Writing received pages during precopy
>>> Disabling THP: MADV_NOHUGEPAGE # postcopy_ram_prepare_discard()
>>> Discarding pages # loadvm_postcopy_ram_handle_discard()
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Discarding pages
>>> Registering UFFD # postcopy_ram_incoming_setup()
>>>
>>> We could think about using this "ever user uffd" to avoid the shared zeropage in most processes.
>>>
>>> Of course, there might be other applications where that wouldn't work, but I think this behavior (write to area before enabling uffd) might be fairly QEMU specific already.
>>>
>>> Avoiding the shared zeropage has the benefit that a later write fault won't have to do a TLB flush and can simply install a fresh anon page.
>>>
>>
>> I checked CRIU and that does a check at the start as well before attempting to use uffd: https://github.com/checkpoint-restore/criu/blob/criu-dev/criu/kerndat.c#L1349
>>
>> If writing to an area before enabling uffd is likely to be QEMU specific, then you make a good point to clear pte instead of using shared zeropage to avoid the TLB flush if uffd is ever used.
>>
>> I think "ever used uffd" would need to be tracked using mm_struct. This also won't cause an issue if the check is done in a parent process and the actual use is in a forked process, as copy_mm should take care of it.
>> The possibilities would then be:
>> 1) Have a new bit in mm->flags, set it in new_userfaultfd and test it in try_to_unmap_unused, but unfortunately all the bits in mm->flags are taken.
>> 2) We could use mm->def_flags as it looks like there is an unused bit (0x800) just before VM_UFFD_WP. But that makes the code confusing as its used to initialize the default flags for VMAs and is not supposed to be used as a "mm flag".
>> 3) Introducing mm->flags2 and set/test as 1. This would introduce a 8 byte overhead for all mm_structs.
>>
>> I am not sure either 2 or 3 are acceptable upstream, unless there is a need for more flags in the near future and the 8 byte overhead starts to make sense. Maybe we go with shared zeropage?
>  >
> There is an another option to use bit 32 of mm->flags for 64 bit kernel only for ever_used_uffd, but considering the 2 reasons below, I will send a v2 of the series (in a few days incase any more comments come up) with shared zeropage in all circumstances (and addressing the comments in the other patches).
> - "ever used uffd" is not a 100% safe, i.e. someone might not check uffd support before using it and do the same sequence of events as qemu precopy + postcopy (+ some bitmap to track and check whether to request a page from uffd handler). Its very unlikely that anyone else does this, but we have to cater for all current and future usecases.

Possible, but IMHO unlikely :) I'd be willing to take a risk here if we 
make sure CRIU is also fine.

> - If THP shrinker is splitting and pointing pages to a shared zeropage, then the page was considered "unused" and unlikely to have a write fault at some point in the near future, hence the probability of incurring that TLB flush on write fault is low.

Surely evidence might help. But it's easy to find cases where this might 
not be the true: populated a THP for a VM and the VM only used some of 
the memory. Then we split, then the VM wants to use the remaining pieces.


Reading your prior email I just wanted to say that mm->flags is unsigned 
long and you should just make the shrinker 64bit-specific and use bit 33 
in mm->flags.

But starting with "all shared zeropage" as a first step also works.

-- 
Cheers,

David / dhildenb


