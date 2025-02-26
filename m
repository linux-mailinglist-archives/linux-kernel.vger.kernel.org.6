Return-Path: <linux-kernel+bounces-534857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9C8A46BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7EC7A4B82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0C21CC79;
	Wed, 26 Feb 2025 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgr0cl4J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F1275602
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600367; cv=none; b=Y0oLUFdjpRqIRsoxGVujnLORnD1yJD7YXJpKFxHoxMCt9f3tfK3kJ6hlyDQ4xotyJbfBjR7MHXbmiaGeRYL+Wdb53QZcUkhpzTqAoJmXQmCSnWYmZ/kqC6bPXWDgPNmtZXMb/io1Tt6CT7i39e6BIuIvGPikmBNJr81BzesbIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600367; c=relaxed/simple;
	bh=yfQM1CqTfquiWJhwLZj9JaiA7Bh+UIirxNzXo464XAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufYcNGHNjfib3SmdFMUQ3j2M2BoAHDksvYW09hEUPB050V6hLgLz3lT6HwcfI0zWSdJ63LdLnC+FctT2+QvXWQFqENvD52iX9aHf/Ti4EYd1Ntye7YukM0Q0SnAbtpi5ELuOmsCH/nmV0MLxK4zmqSVGBm1RYU7Eotrcrbw21Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgr0cl4J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740600363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VkP4TuFVcedC8r8X6iUSdW1moEur4w/J0xKrd7lJWeA=;
	b=cgr0cl4JyGILmdMqaia6RBFIkBiU6Wyqu1kQuzIHHUcH7SdKABEQjYt9lxnB+Fpt/Y5e17
	meJaea0+343TeiNPBQUt9lxuarF6PwcIxfvh3DNYtbJ7eQ7Cerp7wnecxxSteni7yNgl9s
	T5XHwiF4cRzUdKXNODgRVPUVg9UH6sI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-xL-DKwQ6O4eMDGAQ2oT6KA-1; Wed, 26 Feb 2025 15:06:02 -0500
X-MC-Unique: xL-DKwQ6O4eMDGAQ2oT6KA-1
X-Mimecast-MFC-AGG-ID: xL-DKwQ6O4eMDGAQ2oT6KA_1740600361
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43947979ce8so832445e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600361; x=1741205161;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VkP4TuFVcedC8r8X6iUSdW1moEur4w/J0xKrd7lJWeA=;
        b=KUkodlONanvhdIu1OS5L0NkqvqL+ZH0YMkwrjsnGbvi85rgbMhFRzf0XOxqJK6lGVX
         hdZKQU0owNJaLZ8D6fOIppR+Mm+cS0uW6EcHxtfME5H+gJcEh1fiwgjTjAfAbZtUNB4h
         SWd6kW/doX23k/UCcQmEP67+Gp/W9eaUgT3TRACNF+PMhZLsa4w00fb+PyDi5W5ZMSyp
         Q6Mo8tYHBbQCegyQ4xUja/UxhiEqV/xjYrg4x24Fa1jlx43j6O++Hr+afUpg0gWyscGn
         r94Kkz5dlfsVHlXKZ45wMwOdNbiXFyAvoRPwtCfIAC7gjMy5fyrABwYc5uEjEYZ0utg7
         EqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtmnw2XDtkR5tUbqQ9RKbUUSf78KF5079wHgRKUxIDiB3/RYpCrylnRfFVCKpRGykQiOBJDcogE+43vSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATjjhzypalrOHK+2GppijpSibiPcEAKsJi+EQC/5JEotOtkP7
	5PbzVlmbG9h2pSJKNhet/DeNzfaxoqEOzYiCRnXtohnO/mF7FnFzfmrek1nRK4jjTdMtkSeJ6P7
	McuXN0Y1b3sSIrSU90uUgtBdVDTFBE4rYkJxsSgxrDwvR6gr1Pyx6Y7sZ099TbA==
X-Gm-Gg: ASbGncsXURr8+ULAkeYb4XA1GyrK9dJfhsG1Nv/UAXKW/B9e15Odbx9sR/a/WkqkfM4
	LeThW7KWp+We/BaVHFbkflSvJF87LN4Ajbq51GwoTVgDob/ltHxJHX2wWblgZPtjB0FebQN4LzM
	t9QFrDuUGxJxs5npU6Q3XYGB4f5hZPF2YZfs5duuGpSHa2/j6GDo3i4jLXo2dcwblbRd84UqN3K
	lfJIPVKaW1xo751rZlUnSpGqFWO1bfAwE8IH/9Mxg0d9VgZ0nQX+nwQajtNzcj0mEJf5Cl6nU2E
	uBsnw5wlaR/15cG8OKVcA+TzNmd1iAdu7lF7cm5PhMMP
X-Received: by 2002:a05:600c:4ed1:b0:439:a155:549d with SMTP id 5b1f17b1804b1-439ae1eacfdmr199361685e9.12.1740600361058;
        Wed, 26 Feb 2025 12:06:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSLrbCY8KNtNI+AO0sxh7vDOX9ToRLiD06mZNoQeMc6k2mNBytgFCMdXePpXFhkuvOF0ZMYA==
X-Received: by 2002:a05:600c:4ed1:b0:439:a155:549d with SMTP id 5b1f17b1804b1-439ae1eacfdmr199361515e9.12.1740600360655;
        Wed, 26 Feb 2025 12:06:00 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6611.dip0.t-ipconnect.de. [91.12.102.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5711dfsm32306775e9.27.2025.02.26.12.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 12:06:00 -0800 (PST)
Message-ID: <2be79033-187f-4dff-af2b-d97a52a450a8@redhat.com>
Date: Wed, 26 Feb 2025 21:05:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] mm: Provide address mask in struct
 follow_pfnmap_args
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
 mitchell.augustin@canonical.com, clg@redhat.com, jgg@nvidia.com,
 akpm@linux-foundation.org, linux-mm@kvack.org
References: <20250218222209.1382449-1-alex.williamson@redhat.com>
 <20250218222209.1382449-6-alex.williamson@redhat.com>
 <3d1315ab-ba94-46c2-8dbf-ef26454f7007@redhat.com>
 <20250226125435.72bbb00a.alex.williamson@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250226125435.72bbb00a.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.25 20:54, Alex Williamson wrote:
> On Wed, 19 Feb 2025 09:31:48 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 18.02.25 23:22, Alex Williamson wrote:
>>> follow_pfnmap_start() walks the page table for a given address and
>>> fills out the struct follow_pfnmap_args in pfnmap_args_setup().
>>> The address mask of the page table level is already provided to this
>>> latter function for calculating the pfn.  This address mask can also
>>> be useful for the caller to determine the extent of the contiguous
>>> mapping.
>>>
>>> For example, vfio-pci now supports huge_fault for pfnmaps and is able
>>> to insert pud and pmd mappings.  When we DMA map these pfnmaps, ex.
>>> PCI MMIO BARs, we iterate follow_pfnmap_start() to get each pfn to test
>>> for a contiguous pfn range.  Providing the mapping address mask allows
>>> us to skip the extent of the mapping level.  Assuming a 1GB pud level
>>> and 4KB page size, iterations are reduced by a factor of 256K.  In wall
>>> clock time, mapping a 32GB PCI BAR is reduced from ~1s to <1ms.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: linux-mm@kvack.org
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
>>> Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks, David!
> 
> Is there any objection from mm folks to bring this in through the vfio
> tree?

I assume it's fine. Andrew is on CC, so he should be aware of it. I'm 
not aware of possible clashes.

-- 
Cheers,

David / dhildenb


