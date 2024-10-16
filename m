Return-Path: <linux-kernel+bounces-367601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEF79A0447
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F35D281CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D201F80D8;
	Wed, 16 Oct 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0XqPGsE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB41F80BD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067495; cv=none; b=rIX3jf6IoHomwnhhY6LhBj3DKO5reCbnX6VRxrvlHhO3SVAoZLevWdlYcN/s36iEYXmwLlMRo3ZcDB+Bw5uscp6ICnyNRP4kXMnVDiYF1NoRySpuD5/Blck6FKSZNKsufYMv9paosP0NSh9MwdCQi9sY+flHQPIg7s3blMmk4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067495; c=relaxed/simple;
	bh=Pifhc11SkTsMNc3KroRtnEcwItM55j24QRt+ElvzQoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ky04XpkbSTuZxLrQ24dQgi4ZYcgw0nF/R5/KLqBBCV3oA7jzELxCPCEjULpx9J8TwbADhBLPsUBnJESxvipLHJKCjxNSIp4QzN21yFoj6z0alMZENlsD/iYmC67Hg3PEhZsJKhnRnCAErL7qTfznnrI4UiYCo9wMx+cWJR5pTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0XqPGsE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729067492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nxJAESLDCyGs6G7Q1PYYxxCmB1EZ5PkkRq59RpUu3oA=;
	b=b0XqPGsEf7SxXpefNJTrjcZXMhC07ynEeYG6UlZQ5R0bM3gxkgtwdO7sSKqpEpsshQf8lg
	HgvdobogNyDhCPPl1DfY4gLhxO2ZxmxIAHB5qjSq8Icls3fUR2pSjR4HqtuCG+1dUYH9OC
	aMWqpMTFf1+wAqSkM5ABDjn9/cvjlGM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-P0Dj1jZvMeSxCeAd8pX21Q-1; Wed, 16 Oct 2024 04:31:31 -0400
X-MC-Unique: P0Dj1jZvMeSxCeAd8pX21Q-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-536800baa8aso7625425e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067490; x=1729672290;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nxJAESLDCyGs6G7Q1PYYxxCmB1EZ5PkkRq59RpUu3oA=;
        b=tawcs2hqRd2itdFGBeUkJqqtJUa7uJh6r49xqdb9kZIF79daUTnO0Il2U0cD7QRdbR
         5FczcGzcTzwHAGc5BAOYRN8kBBJQnk2OBc1xAwiIO7BFYxTQkyE19pbWsHU7Rz97+ETf
         vVC82cweG1ttxGXfh4S6oUiedL32jtFQfgcCZLXGkBshj9N4XmcPRtXs+3vIDBd6Th2k
         Fi3ryO6G1iO2vgnnovBZ2nBVg01oBTzn/H6Yto/t8D4v3iFI4g1SIov+A426cGMXhW91
         7v0O+tVWz6Ikls4WnPvYTD/TrhroWq7rkwP19/Ze+8n0ZpXaHgjxaSHuKMjzFpjx2a17
         AsDA==
X-Forwarded-Encrypted: i=1; AJvYcCUCCwQAmeAnze/CVtXJS7bDpzrePrzA41H0wdkx69XKUlKDr5iL7i5o4Gdc7yGv4et4ZfTqAA0wvjP5pPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6d5VrSc0qaH3EAHaa0b/TeT6dsf8Bttr/7jre3Jqre+f9HwS+
	8CqPIcjThk23GeOhvdGgYBKvL+OBny0VVPSCHLCnHTtXyQ2TGjgCFhA8v0jIfUDIItEK7fRbKhz
	lZ3W0Fso5DavUC3MJ6HMAHTviE/7ffuTkXZEOfv25cnsj2alfAJHHpT9TS5PA2Q==
X-Received: by 2002:a05:6512:3351:b0:53a:40e:d53d with SMTP id 2adb3069b0e04-53a040ed6demr1230427e87.13.1729067489658;
        Wed, 16 Oct 2024 01:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhlUjLz+Z5x8H1s+KOjW+omWy8l3iv8HfRIL4Tv8iqCoGTTUWh+h2d8eVtiPJ/72N1r4azpw==
X-Received: by 2002:a05:6512:3351:b0:53a:40e:d53d with SMTP id 2adb3069b0e04-53a040ed6demr1230412e87.13.1729067489152;
        Wed, 16 Oct 2024 01:31:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:a200:af8e:d144:6284:4f93? (p200300cbc742a200af8ed14462844f93.dip0.t-ipconnect.de. [2003:cb:c742:a200:af8e:d144:6284:4f93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43151dfbef4sm9990855e9.17.2024.10.16.01.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:31:28 -0700 (PDT)
Message-ID: <ca7de613-d568-49db-982e-f34d3be5f0a9@redhat.com>
Date: Wed, 16 Oct 2024 10:31:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] resource: Remove dependency on SPARSEMEM from
 GET_FREE_REGION
To: Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20241016014730.339369-1-ying.huang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241016014730.339369-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.24 03:47, Huang Ying wrote:
> We want to use the functions (get_free_mem_region()) configured via
> GET_FREE_REGION in resource kunit tests.  However, GET_FREE_REGION
> depends on SPARSEMEM now.  This makes resource kunit tests cannot be
> built on some architectures lacking SPARSEMEM, or causes config
> warning as follows,
> 
>    WARNING: unmet direct dependencies detected for GET_FREE_REGION
>    Depends on [n]: SPARSEMEM [=n]
>    Selected by [y]:
>    - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]
> 
> When get_free_mem_region() was introduced the only consumers were
> those looking to pass the address range to memremap_pages(). That
> address range needed to be mindful of the maximum addressable platform
> physical address which at the time only SPARSMEM defined via
> MAX_PHYSMEM_BITS.
> 
> Given that memremap_pages() also depended on SPARSEMEM via
> ZONE_DEVICE, it was easier to just depend on that definition than
> invent a general MAX_PHYSMEM_BITS concept outside of SPARSEMEM.
> 
> Turns out that decision was buggy and did not account for KASAN
> consumption of physical address space. That problem was resolved
> recently with commit ea72ce5da228 ("x86/kaslr: Expose and use the end
> of the physical memory address space"), and GET_FREE_REGION dropped
> its MAX_PHYSMEM_BITS dependency.
> 
> Then commit 99185c10d5d9 ("resource, kunit: add test case for
> region_intersects()"), went ahead and fixed up the only remaining
> dependency on SPARSEMEM which was usage of the PA_SECTION_SHIFT macro
> for setting the default alignment. A PAGE_SIZE fallback is fine in the
> SPARSEMEM=n case.
> 
> With those build dependencies gone GET_FREE_REGION no longer depends
> on SPARSEMEM.  So, the patch removes dependency on SPARSEMEM from
> GET_FREE_REGION to fix the build issues.
> 
> Link: https://lore.kernel.org/lkml/20240922225041.603186-1-linux@roeck-us.net/
> Fixes: 99185c10d5d9 ("resource, kunit: add test case for region_intersects()")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   mm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4c9f5ea13271..33fa51d608dc 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1085,7 +1085,6 @@ config HMM_MIRROR
>   	depends on MMU
>   
>   config GET_FREE_REGION
> -	depends on SPARSEMEM
>   	bool
>   
>   config DEVICE_PRIVATE

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


