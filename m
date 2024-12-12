Return-Path: <linux-kernel+bounces-442919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E159EE401
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9BA1889A30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB32101AF;
	Thu, 12 Dec 2024 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MRiqTXAg"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13518B467
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998930; cv=none; b=XKkcDpkWitB4Ew26LEHN9UEbDiomfzuGBPXUT0kVg228ABs/YVYwtwZT76I4P7Je5bOsJ2la2MmKqxjLdcwgAcEitAXNLcGwMOAWMBlGX+1ib83ncoUZvowU9/+XL0vdB510JCfliYEiEIG6SXl+N2OIHjth9rY5rShhl6dtJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998930; c=relaxed/simple;
	bh=0WjRTqsRl1idaLk0Obzmu+C+MjSbu/qou87tjORo4jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzENCj1fCdi6bfmPcSCWzJ4TT3sSUehMHz17u7zcRGDRmKFEprkrHMUo702DdFaaLxXR60Ye/EpPomfNzFAHWM4g9dKYmR07LSOVHJ2MVoXYXrn4yIQMAWKjwEknUOqIViveyIxDIOHWwiYTkPDPv6oK1bGitYxU0K8EgJ3oUHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MRiqTXAg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso2824215e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733998926; x=1734603726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c645PNElfeFM12UdgKMeAmcuHLZRg8JK7eBZ7/1+xnY=;
        b=MRiqTXAg5UVObnVSW4U2BdNwcRgX5W4owvE2uQJoNavAOsuf4SLMxYmYqKWMSP1h0v
         +CHokkmGOYgsl05VR4uacPrIErCT9Z9YZ4mkjSTzwR3TwPLWyy7BXu/UPWzD8w+rqoFc
         NmSJNeNpxyLrajlvLTgSwOTKSkXdnUgDhYmBZJS7H8H7tGw7Eq5DPIdjfWr6CBOYp8uG
         mRBndsu+pR20qI6HxoGiRMTDasO0R3fhV65bnrf1sDw98fzMZBGNYKQhWbhnSjK0DwX4
         J9LizszZmHubAUKp8h6foRFMADAX01mAJV4dytBhuFX3FwUMPlQyfvH9xZqYdWkKoYFI
         tC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998926; x=1734603726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c645PNElfeFM12UdgKMeAmcuHLZRg8JK7eBZ7/1+xnY=;
        b=dwhURDKxmf+MeYbZOmDEBm3AR5mkqcDiZOF1mjrnvPQz4wygR1uBy0OTRlPQ8RTyZw
         QJQ+1uhHfeS559VYdHc9wd8T4df/lC5tyXXBaORjn67rYo7aZXQTYttDkvqVs2bcsWbW
         FVxjdRF0+bljC5UjwmWrGnIx7ocKjgUHEaxMSi5rXLNGurF6nAKsHbe3d9QfYxRM1HbH
         mgBr9gYtq0L9ONUNGVx9Gfmnbb9KG0BMbcFl2iK8ono123ErDW/FOymTFzX7Ol7OBWre
         IFewXkQYKXXyG6+mQRnIofUqx8sJhdbo0y3wyHBUYN1eE0RJdnBC3BE6uPKibTNBaqwU
         6T2A==
X-Forwarded-Encrypted: i=1; AJvYcCXOxXqGdt21Cl6UcyRqrg9VrM9e+dEzsN0SbPIqNbN6j0R997hWy+mipA+///cNUHwPhQ+A7AZzOuCf4AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznqcmD5yJWcXTf9YyjXORA/Jm/9FjMmQNeFkFC0KFhVSVxya9z
	PKYNMUptQ/itc8Bmw21mPDd10FZDWxCtEF7PUQFclsV82R29aq5k7qJ2nsYTD/RlVPwJ4CV6ikg
	=
X-Gm-Gg: ASbGnctfFvRpJLQVx8FS7An2+hzA0T3D06yJ9SSIDsQVeoXRElDZuQjL/eAwYiRKTuL
	mSHWxOM2UIk7+ACm42bMd9ETUpHRQHqnjBGuknokIaEDKxB9KxeS7Pp+AnT9YDlsdWSQVFl0BVY
	agXJUpeCO34UYbj5g5onha2f+B4Z3sSCi/89O+F/qMEXhareRIUWeGjo1unPhS2oRWJ7gOJUxOA
	2VOs7PlNurndBmwvGvqzkkNpIo/XOTtm7PAu/7UzgP+BLosPP2bpZuiV7JRYBItmP8vzuyjqwgz
	/tCPV37gFdPI1syan6FG1ZqCrhuqNQc6JQ2D5larVQ==
X-Google-Smtp-Source: AGHT+IEEpl5WnfVqD5Eyl1PeCZc5X0OZKvY51dNZlWpRgEl0ZIGnyTAoD5sXkKoKOCY9S9gRMv6sMg==
X-Received: by 2002:a05:600c:4450:b0:436:1aa6:b8ee with SMTP id 5b1f17b1804b1-4361c346a7emr52444405e9.2.1733998926105;
        Thu, 12 Dec 2024 02:22:06 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559eaf6sm12181355e9.20.2024.12.12.02.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 02:22:05 -0800 (PST)
Message-ID: <cbc389e4-3b69-4681-ad66-6102b0ed0cae@suse.com>
Date: Thu, 12 Dec 2024 11:22:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen/mmu: Increase MAX_CONTIG_ORDER
To: Thierry Escande <thierry.escande@vates.tech>
Cc: sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
 linux-kernel@vger.kernel.org
References: <20241204171346.458105-1-thierry.escande@vates.tech>
 <ccb28ccc-531c-4ead-9a27-76cc430f8c35@suse.com>
 <cc61bdce-47af-45ea-8ace-173adef9ae41@vates.tech>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <cc61bdce-47af-45ea-8ace-173adef9ae41@vates.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.12.2024 19:20, Thierry Escande wrote:
> Hi Jan,
> 
> On 09/12/2024 11:04, Jan Beulich wrote:
>> On 04.12.2024 18:14, Thierry Escande wrote:
>>> With change 9f40ec84a797 (xen/swiotlb: add alignment check for dma
>>> buffers), the driver mpt3sas fails to load because it cannot allocate
>>> its DMA pool for an allocation size of ~2,3 MBytes. This is because the
>>> alignement check added by 9f40ec84a797 fails and
>>> xen_swiotlb_alloc_coherent() ends up calling
>>> xen_create_contiguous_region() with a size order of 10 which is too high
>>> for the current max value.
>>>
>>> This patch increases the MAX_CONTIG_ORDER from 9 to 10 (4MB) to allow
>>> such allocations.
>>>
>>> Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
>>> ---
>>>  arch/x86/xen/mmu_pv.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
>>> index 55a4996d0c04..7f110740e1a2 100644
>>> --- a/arch/x86/xen/mmu_pv.c
>>> +++ b/arch/x86/xen/mmu_pv.c
>>> @@ -2200,7 +2200,7 @@ void __init xen_init_mmu_ops(void)
>>>  }
>>>  
>>>  /* Protected by xen_reservation_lock. */
>>> -#define MAX_CONTIG_ORDER 9 /* 2MB */
>>> +#define MAX_CONTIG_ORDER 10 /* 4MB */
>>>  static unsigned long discontig_frames[1<<MAX_CONTIG_ORDER];
>>
>> While lacking respective commentary, bumping this value imo also needs to
>> take into account Xen itself, at least commit-message-wise. The bumping is
>> fine for Dom0 in any event. It is also fine for DomU-s with the defaults
>> built into the hypervisor (orders 12 and 10 respectively for x86 and Arm),
>> yet especially for Arm (and in the future PPC and RISC-V) any further
>> bumping would be less straightforward.
> 
> Thanks for pointing this out. On the Xen side, CONFIG_CTLDOM_MAX_ORDER
> and CONFIG_HWDOM_MAX_ORDER seem big enough on all architectures. But I
> see CONFIG_DOMU_MAX_ORDER set to 9 (also all archs). Won't that be a
> problem for drivers trying to allocate more than that from a domU ?

A driver assumes a (physical) device to be in the DomU, at which point it
is CONFIG_PTDOM_MAX_ORDER which applies (PT standing for pass-through).

>> However - does the driver really need this big a contiguous chunk? It
>> would seem far more desirable to me to break that up some, if possible.
> 
> Since this works on bare metal I'm afraid the driver maintainer (mpt
> fusion driver) will just tell me to fix Xen.

Well. The bigger such allocations, the larger the risk that on systems
that have been up for a while such allocations can't be fulfilled anymore
even in the bare metal case.

Jan

