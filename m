Return-Path: <linux-kernel+bounces-336472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DEA983B45
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2217D1C21C65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DCDD531;
	Tue, 24 Sep 2024 02:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsT0Qx/f"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248161B85DA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727145717; cv=none; b=Yhs6MPwq99JqrO6tPb53tiJDsc4a0T4UafCaIPT2bVD634z2MtubKm8FfOcD1rPOCUxr2Rw2w/0vxCk2KzYDaw8zA2I/bRP+OCk5wvqwLru+J95OxUvbOdUZgFe6NGrMOE+9Q7e+tPP4iGiFxjiM3psSmCki8TtJKh8Iyi9hBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727145717; c=relaxed/simple;
	bh=/Xqf+kdpMR9ATJ79zLA/fz8JJEdj/9PRFFs8fcsqCyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsd+8ZgxW3EDxE237OmMwgJzbFwC6fOw1gwg/Ia7mVVvh7X1QgDKR+mW0DCXi/dtZiiyptfDqGRuDm2eoE7JhM4+phquI7StJHw1OCTKyOcTeqPTlm8xQ8daSC7rbolNw92vbvwjUOg6K2d+zuPd75bhaSneGAwXJIwR6vyXrNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsT0Qx/f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2068acc8b98so46364925ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727145715; x=1727750515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tPr5YFQGalQdSoHnZNCpVGMxpdSy3ExtALogU8mrC+4=;
        b=YsT0Qx/f4etmJhRExpJXaT6KXqGpvCOHTFXhcJvlvka8C7T0f/fbKmRDJnyIZ2aVRp
         u3j+NBNLO8HBYuJZsaNr+6U90lLnOXiiCqJWJvl08HRRFHj4lataoqNrNkP6WyL2rj9D
         /cqJjYoiVwNAmu/SF2H1B2hJYDwQuJNqkSDMxmZrgLOSWQGwjC/OMgmyHXBewjh7riE+
         21NKIGK1P2AA2m/dAMnbuKuIxsCQxxMYmzEAV0v1K+Htn4GUuvKG7FBCYkP1WQ9UnWpU
         6ryuD+9rOvq+HU7sL8kuf3oumZl+CWte9DX89u2urFC7LehP5/+3uDdZ+ql0lyfpRrWO
         I98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727145715; x=1727750515;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPr5YFQGalQdSoHnZNCpVGMxpdSy3ExtALogU8mrC+4=;
        b=H2wb8ME3N/nFev4KmNbq2dzui5x+DnJ9CGa/Aum/Mqhb/TOhwHmWiAiRhZtrzWVHMZ
         aGQykFhHlZSpbAhjRCgRAEXOaywk4wTmlHFqzZx9y2srkoRSXor3NQvoJusZbqUiqnQe
         +/vU8gzwIhLvLNTfouNdCu4jpt1rD7RlqEKC0nbFy1qrinJ3+ZhLR6s50PNfZVox90sH
         p6drDy5AkNasJB2TJYJ995CqOaUNz7wgQpr4Nnh3xbLdwX+1S0N92nGUDlFmEkryAhPT
         9FD0EQvi0G4vJeFjEdvu9+TMCSgfuZD9WV/1spGmkaWlFsqNu7qfYJP3shKmtVyF0aTJ
         PZGg==
X-Forwarded-Encrypted: i=1; AJvYcCWmrkCb8WBpFspd7vB8UQERoA0+AG8Jwlc1O2y4FV8KFMFM6mVpPVZZxVrk46niP2ChuQqt5u30cI7dZjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuFoVKZhmtfccB8i+8nPj2Bcf+RWVHyil/x8zXfe9iAP/Jb2w5
	LJ/2qHXkw+PpL96V1XBBNkWXA+e79CRD+OXN1mfl1+udTW/v+Q+UgDFnKA==
X-Google-Smtp-Source: AGHT+IFt6XIOnPF2lrWpFyiW2mkuyQGUpXmVIOvJsF0JYAt3nsiHgPyZ3l2v4O22FqwzAfaEcHjAHw==
X-Received: by 2002:a17:903:2b0d:b0:207:17f6:9efc with SMTP id d9443c01a7336-208d83b95bdmr197100275ad.25.1727145715225;
        Mon, 23 Sep 2024 19:41:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229ecsm2029505ad.86.2024.09.23.19.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 19:41:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0247886e-595e-4774-b515-ff628966f2be@roeck-us.net>
Date: Mon, 23 Sep 2024 19:41:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240922225041.603186-1-linux@roeck-us.net>
 <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
 <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
 <87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87msjxu9qr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 18:21, Huang, Ying wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
>> On 9/23/24 05:58, Geert Uytterhoeven wrote:
>>> Hi Günter,
>>> On Mon, Sep 23, 2024 at 12:50 AM Guenter Roeck <linux@roeck-us.net>
>>> wrote:
>>>> Building allmodconfig images on systems with SPARSEMEM=n results in
>>>> the following message.
>>>>
>>>> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>>>>     Depends on [n]: SPARSEMEM [=n]
>>>>     Selected by [m]:
>>>>     - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]
>>>>
>>>> and the build ultimately fails.
>>> Really? What's the build error?
>>
>> I saw it on hexagon, and I didn't bother writing down the actual build error
>> message. But it turns out you are correct, the m68k machine does build with
>> CONFIG_RESOURCE_KUNIT_TEST=y even though SPARSEMEM and with it GET_FREE_REGION
>> are not set. Never mind, I don't really want or have time to argue. I'll just
>> disable CONFIG_RESOURCE_KUNIT_TEST when building hexagon images and wherever
>> else I see the problem.
>>
>>> It does build for me on m68k, after fixing:
>>>       --- a/include/linux/mm.h
>>>       +++ b/include/linux/mm.h
>>>       @@ -101,7 +101,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
>>>        # ifdef MAX_PHYSMEM_BITS
>>>        # define PHYSMEM_END   ((1ULL << MAX_PHYSMEM_BITS) - 1)
>>>        # else
>>>       -# define PHYSMEM_END   (-1ULL)
>>>      +# define PHYSMEM_END   ((phys_addr_t)-1)
>>>        # endif
>>>        #endif
> 
> After Linus' fix for PHYSMEM_END, GET_FREE_REGION doesn't need to depend
> on SPARSEMEM anymore.  So, I think we can remove the dependency.  Can
> you check whether the following patch work for you on top of latest
> upstream kernel (with Linus' fix).
> 

It works for m68k. I'll run a complete test on all architectures/platforms
tonight.

Guenter

> ------------------------8<-------------------------------
>>From ce1a930f74192a4a85c20564098470356f8c2ed4 Mon Sep 17 00:00:00 2001
> From: Huang Ying <ying.huang@intel.com>
> Date: Mon, 23 Sep 2024 09:24:03 +0800
> Subject: [PATCH] resource: Remove dependency on SPARSEMEM from GET_FREE_REGION
> 
> We want to use the functions configured via GET_FREE_REGION in
> resource kunit tests.  However, GET_FREE_REGION depends on SPARSEMEM.
> This makes resource kunit tests cannot be built on some architectures
> lacking SPARSEMEM.  In fact, these functions doesn't depend on
> SPARSEMEM now.  So, remove dependency on SPARSEMEM from
> GET_FREE_REGION.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>   mm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b72e7d040f78..f287b0d1c5fc 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1060,7 +1060,6 @@ config HMM_MIRROR
>   	depends on MMU
>   
>   config GET_FREE_REGION
> -	depends on SPARSEMEM
>   	bool
>   
>   config DEVICE_PRIVATE


