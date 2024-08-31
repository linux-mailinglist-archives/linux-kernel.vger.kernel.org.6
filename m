Return-Path: <linux-kernel+bounces-309870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEAC967155
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6928728281F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AB917E005;
	Sat, 31 Aug 2024 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tuiw6oRC"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25E17C21C;
	Sat, 31 Aug 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725104195; cv=none; b=DIqRvSgaDUPSjuLf9DlpgB2aDaXx5H6ldJwscXooqUkA0IDwbXDd0iwes+kYsH5KkDbDytAf3A/uJExuXPE6F+UT9nJAfGwupBbtL/ooGvAla97W7HRP/Wk4DqyKrVZaJT60+xSJdAbo+xNYI+SekZNriXXsGEIlkGHYlfNs7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725104195; c=relaxed/simple;
	bh=OyGTBD0zWa3blsUCOwFvlsbl9D8mhJOLTNMIcOsRCpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwR6lvJAr4/iqJCvcWeZw3qbC4ER/WLC1UMc21ShJ5Don044kiv1oYkbitZsT3mOXWHtUstaXhDQ1iu7tg20G8UAYp2CLz6Bu8IaTSaMUkdYvYB/GGzGRoZbOVDt3L0BsXg+bgfhvJqdkOI+2WKyEkJ7A47eNsx06OEBQW/vK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tuiw6oRC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3eabcd293so29524231fa.2;
        Sat, 31 Aug 2024 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725104191; x=1725708991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DW5o2YvVHbNPYWo6fwu2OHoD9wQjry9RZ8/xUuq9ccU=;
        b=Tuiw6oRCt9xyGIRE/YGScU6atq6MoZb38HRoLKUFRIaO7+zLFMwLKnEZYHEIR4NcPw
         oGtlB7zq8NTDjWpMzIl/4xq6XWh3n3B7kQ6+mz2JrZmbSIYry0rTpTMDwpP947JA7ajM
         3+WBZlODOIMMKahVcxcEYqmOkGP4bfxcpz6Ixs1fJWTB9oL96/OLqQuewecHK/cp6bFA
         I99yko8YpJ6rt0aLRtN9ZXX3ayOOIloeY4CmvPEewcqK29E+RwmWxYRpm6lrbNcquPZY
         /2MhtybO2N8vEO0Q5Hv+9k/MqwXCl4Ppuw8MDupIDS0ZXKhDQ0H/iMVNsENRgUF0J6QY
         5gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725104191; x=1725708991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DW5o2YvVHbNPYWo6fwu2OHoD9wQjry9RZ8/xUuq9ccU=;
        b=LwsHdp+hfsEhKRBZtXcLVy5JbTui9/xz7VI4yRnEehiSeGvAEWdvyk2dcmObVGzSYR
         RHTjFnQW1BgUiXTo45TMBEv3TBP4gRUHlBOYKmECdXDoPtBwz74wIDkMaDeGShYjA2Uu
         YBxvJ34XjJs1yvgvE5A4Xq+TG1oMuYx9P/be5KsFVCJhtLKANfr4x7TR+nRmNaAQA4gN
         DdEJ/ms8fr8Kheqv39FwmKX7KWLrn4+zM6mTXMlhtwsGc+hZsmOMRTbY6SGqFk2AyDR2
         AaPvz04e4mMoxUeeWuWXkRHqpmt79dEHF3lD/BSptoAQfDbBvIR0KElJa7BnjZ3V/hC4
         izeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU8rxHPyu/FD9r0WSU6a5vNM8QaAHXqLhRvjFjNxg9aNP7bM5l8sQoYyiUwHTCFGmDKLamcqgKZSWC@vger.kernel.org, AJvYcCWxojzw+XgTHC1xzgedGGcspdIXpWgBq8TcglxCihHzONEUI4KHHWgB274g0F4cj/p4CEDnqT65ztLOthKn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yIXdu6arpNAiBkmdHpM15I3bkDVbC6oBTF7JHhlwAHBmAo2b
	vaWJKjCL7H7YxU2rXUBRkIlHCy9O8v02XV4Z0yuMjE4Y9DRYEtTy
X-Google-Smtp-Source: AGHT+IHHNejUCl2NXL5+Twx1GLp1uz8JoLh9RVEQPg+qgl3Oa4CJXifFuSUIJs/dn4QjoxCNq1qJPw==
X-Received: by 2002:a2e:be9e:0:b0:2f3:aed8:aa9b with SMTP id 38308e7fff4ca-2f62902dcd4mr10651691fa.5.1725104190488;
        Sat, 31 Aug 2024 04:36:30 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed1787sm10456961fa.10.2024.08.31.04.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 04:36:30 -0700 (PDT)
Message-ID: <4b6295c6-d792-4fc8-893c-3be0b26cd22c@gmail.com>
Date: Sat, 31 Aug 2024 13:36:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] Dynamic Allocation of the reserved_mem array
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, robh@kernel.org
Cc: andy@black.fi.intel.com, aisheng.dong@nxp.com, catalin.marinas@arm.com,
 devicetree@vger.kernel.org, hch@lst.de, iommu@lists.linux.dev,
 kernel@quicinc.com, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
 robin.murphy@arm.com, saravanak@google.com, will@kernel.org
References: <20240830162857.2821502-1-quic_obabatun@quicinc.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240830162857.2821502-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024-08-30 18:28, Oreoluwa Babatunde wrote:
> The reserved_mem array is used to store data for the different
> reserved memory regions defined in the DT of a device.  The array
> stores information such as region name, node reference, start-address,
> and size of the different reserved memory regions.
> 
> The array is currently statically allocated with a size of
> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
> will not have enough space to store the information for all the regions.
> 
> This can be fixed by making the reserved_mem array a dynamically sized
> array which is allocated using memblock_alloc() based on the exact
> number of reserved memory regions defined in the DT.
> 
> On architectures such as arm64, memblock allocated memory is not
> writable until after the page tables have been setup.
> This is an issue because the current implementation initializes the
> reserved memory regions and stores their information in the array before
> the page tables are setup. Hence, dynamically allocating the
> reserved_mem array and attempting to write information to it at this
> point will fail.
> 
> Therefore, the allocation of the reserved_mem array will need to be done
> after the page tables have been setup, which means that the reserved
> memory regions will also need to wait until after the page tables have
> been setup to be stored in the array.
> 
> When processing the reserved memory regions defined in the DT, these
> regions are marked as reserved by calling memblock_reserve(base, size).
> Where:  base = base address of the reserved region.
> 	size = the size of the reserved memory region.
> 
> Depending on if that region is defined using the "no-map" property,
> memblock_mark_nomap(base, size) is also called.
> 
> The "no-map" property is used to indicate to the operating system that a
> mapping of the specified region must NOT be created. This also means
> that no access (including speculative accesses) is allowed on this
> region of memory except when it is coming from the device driver that
> this region of memory is being reserved for.[1]
> 
> Therefore, it is important to call memblock_reserve() and
> memblock_mark_nomap() on all the reserved memory regions before the
> system sets up the page tables so that the system does not unknowingly
> include any of the no-map reserved memory regions in the memory map.
> 
> There are two ways to define how/where a reserved memory region is
> placed in memory:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a set start address and size using the
>       "reg" property in the DT.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying a range of addresses where they can
>       be placed in memory using the "alloc_ranges" and "size" properties
>       in the DT.
> 
> The dynamically-placed reserved memory regions get assigned a start
> address only at runtime. And this needs to  be done before the page
> tables are setup so that memblock_reserve() and memblock_mark_nomap()
> can be called on the allocated region as explained above.
> Since the dynamically allocated reserved_mem array can only be
> available after the page tables have been setup, the information for
> the dynamically-placed reserved memory regions needs to be stored
> somewhere temporarily until the reserved_mem array is available.
> 
> Therefore, this series makes use of a temporary static array to store
> the information of the dynamically-placed reserved memory regions until
> the reserved_mem array is allocated.
> Once the reserved_mem array is available, the information is copied over
> from the temporary array into the reserved_mem array, and the memory for
> the temporary array is freed back to the system.
> 
> The information for the statically-placed reserved memory regions does
> not need to be stored in a temporary array because their starting
> address is already stored in the devicetree.
> Once the reserved_mem array is allocated, the information for the
> statically-placed reserved memory regions is added to the array.
> 
> Note:
> Because of the use of a temporary array to store the information of the
> dynamically-placed reserved memory regions, there still exists a
> limitation of 64 for this particular kind of reserved memory regions.
>  From my observation, these regions are typically small in number and
> hence I expect this to not be an issue for now.
> 

I tested the series on the same systems as previously and did not see 
anything suspicious.

In addition I tested my x86_64 desktop with CONFIG_OF enabled and this 
new version boots fine for me and did not show any new issues from what 
I could tell.

Regards,
Tested-by: Klara Modin <klarasmodin@gmail.com>

