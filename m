Return-Path: <linux-kernel+bounces-409430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0769C8CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C23B36822
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912A213A86C;
	Thu, 14 Nov 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q65I34nK"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D87DA6D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593619; cv=none; b=eHIgjWPnaOhWkgpkAGnnAzVNgcpUDFQ0+p1wEg+qpav6XEBBzOP0XmYVMxKjaNDtf4ntGYIvkYvQnRwEPNqNgMVFJ2TotqqOizRyh7DOQUwS0UyVVPxWhicLnCpSzMNpGwVjCexDdW7dADI5YfSn4tAfna1+wEjAj8caYpcBejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593619; c=relaxed/simple;
	bh=jAueMCrVLHz6hW6+P1APcL4I7TaT8EWX0cQ5d5SFnCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQJPvaNBbyrENssJGloCna2ogn/I7Lh9+ZbsdYDGw8R6RK7D+hWkN5sDME01XGjQe2Yhw4A1xvSFbbFwwyA/chHMgpDkkKlLP6dEhkpH4UEFoN1mtvCybG/7jyOsz+2f1FSyVH4M5Y/cWBBfP/3zCGez5PG7lFv5CA2coP14VDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q65I34nK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314b316495so6064265e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731593615; x=1732198415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9nDCcI8uWVsMCWJBreUtziPU45Z0RE7kcz0JaYgb/s=;
        b=Q65I34nKXv+YrESO+8DA7nEHPHrkYqAzh159Ux02AuL5uaO4LqFvF4tf2JchmzkDNN
         MbtDaSc1Ufm1tZwEvw4ICwaEcCyHcgEUnM3UKhhxe79+1YJfuFB0MG8X/R5ETPwwI0KX
         A1fehpWNNLDJZeIMvEAhcd6tNLqP8DCosT8+QTXHZTJm9fv7kPjcuGYNQk9VaXVQ/jBS
         EU/NI04UD+6AKKwD/0nuZ6YcEciALC4Yct4kZg54HFv0oNx7ZECDBkFboD/dh1UII9jn
         ZrMHiEpe/sLCaUEwAiuyL2LtR5IBSZwF0CT91KMzgVdFMIDewURwg0/lckcM7wJQM1O1
         LoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731593615; x=1732198415;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9nDCcI8uWVsMCWJBreUtziPU45Z0RE7kcz0JaYgb/s=;
        b=dukNKw1REGeGBHlcaIZwCOgiz0U+OBjDBJLjOQDCBKegJKXqNgUyRMmSWcEFEkBsND
         ZNd8b2g89dluiqMc8wFvk4HLGPKnYigEhtu3Oz5dyrkQkjccGT2p5rjVnOCNapL0vF+O
         qQBuHbxMvQO/MCFlUYaJ5rQnRvP4NEGhOegyTTQ602T6S63iadkwR2iqlXkB5ZRhlUaB
         sTfXPjoCz//kiWcKwEnIefsskQ/ypjguRCsXiU6L9g62G/Ty6mRu54vmehd9O3UH861j
         qpY+v6HTg0zOS/stORRIhBga3LucJOqkdQmmWgcHJ3IHv7xlJZmHvnVGRKSgD/LAQHsP
         xTvg==
X-Forwarded-Encrypted: i=1; AJvYcCXkkS2CvoHm5/i9A1lrbWatwW5UT5b2Zuqsy8QYIeFUyHDuvbcNem2sbBnwQnKaWVmJ/yeYTs5i62sykZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypbgVQViOzRbNC/2WZv2hSByDGgaF0cq1TPeYwC9ZZbjoUHPZx
	TLG1kYECnqP49kjAQSe38pGpt8S4fkHt5hSoV9C1h74J+gJxWYQabWidoB3eOXdzngobZkSJmqr
	c
X-Google-Smtp-Source: AGHT+IH0qPe0yKoxHwX7ypx3vuKI7XiRDCpO9zV7bwIAu51AB7c0vxmc2BAcdMhofyduGMdIZ+hFjQ==
X-Received: by 2002:a05:600c:46c8:b0:431:51e5:22fb with SMTP id 5b1f17b1804b1-432d4aaf30fmr67044435e9.14.1731593615133;
        Thu, 14 Nov 2024 06:13:35 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada2f25sm1616230f8f.9.2024.11.14.06.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:13:34 -0800 (PST)
Message-ID: <3fd8368f-fb21-452c-b9da-5382fcf4f657@suse.com>
Date: Thu, 14 Nov 2024 16:13:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] x86/microcode/AMD: Make __verify_patch_size() return
 bool
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
References: <20241018155151.702350-1-nik.borisov@suse.com>
 <20241018155151.702350-3-nik.borisov@suse.com>
 <20241114125818.GFZzXz6vdhwPdSa4dk@fat_crate.local>
 <d5708abe-40ed-4885-919c-b491f61cceb7@suse.com>
 <20241114140154.GFZzYC0ifEztvQ49-P@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20241114140154.GFZzYC0ifEztvQ49-P@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14.11.24 г. 16:01 ч., Borislav Petkov wrote:
> On Thu, Nov 14, 2024 at 03:19:33PM +0200, Nikolay Borisov wrote:
>> For the older families we have a hard upper bound so we want to ensure that
>> the size in the header is strictly <= than buf_size, which in turn must be
>> <= max_size .
>>
>>
>> i.e Is it not valid to have sh_psize < buf_size rather than strictly equal ?
> 
> Let's look at all possible cases:
> 
> * sh_psize > min_t(sh_psize, buf_size) == buf_size -- means the buffer is
> truncated so the patch is incomplete
> 
> * sh_psize < min_t(sh_psize, buf_size) == buf_size -- this is actually ok
> because we're working with the whole buffer and there can be other patches
> following. Now I remember why I had ">" there.
> 
> * sh_psize > min_t(u32, buf_size, max_size) == buf_size -- truncated buffer
> 
> * sh_psize < min_t(u32, buf_size, max_size) == buf_size -- that's ok
> 
> * sh_psize > min_t(u32, buf_size, max_size) == max_size -- some mismatch, fail
> 
> * sh_psize < min_t(u32, buf_size, max_size) == max_size -- ditto.
> 
> So this needs more staring and I need to make it more readable.
> 
> Btw, one more spot:
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 01ea25f31c0c..7554d83f00e6 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -303,7 +303,7 @@ static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
>   		break;
>   	default:
>   		WARN(1, "%s: WTF family: 0x%x\n", __func__, family);
> -		return 0;
> +		return false;
>   	}
>   
>   	return sh_psize == min_t(u32, buf_size, max_size);
> 
> ---
> 
> IOW, I'm thinking about something like this (pasting the whole function here):
> 
> static bool __verify_patch_size(u32 sh_psize, size_t buf_size)
> {
>          u8 family = x86_family(bsp_cpuid_1_eax);
>          u32 max_size;
> 
>          if (family >= 0x15)
>                  goto ret;
> 
> #define F1XH_MPB_MAX_SIZE 2048
> #define F14H_MPB_MAX_SIZE 1824
> 
>          switch (family) {
>          case 0x10 ... 0x12:
>                  max_size = F1XH_MPB_MAX_SIZE;
>                  break;
>          case 0x14:
>                  max_size = F14H_MPB_MAX_SIZE;
>                  break;
>          default:
>                  WARN(1, "%s: WTF family: 0x%x\n", __func__, family);
>                  return false;
>          }
> 
>          if (sh_psize != max_size)
>                  return false;

Isn't sh_psize < max_size valid here?

>                  
> ret:
>          /* Working with the whole buffer so < is ok. */
>          return sh_psize <= buf_size;
> }
> 


