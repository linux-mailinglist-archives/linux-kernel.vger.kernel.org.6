Return-Path: <linux-kernel+bounces-359523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21AF998C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A38281AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6C1CC88D;
	Thu, 10 Oct 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU/bDYwA"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B314207F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576092; cv=none; b=KU6SBBBCkfRhU1siCsbWNwOnJpKmmFP9XTFaFVUldlAOMMBeUFLdCtxyX8ZJjuDStzqzWfVbtmwaoGlR0NcyLp/4YjsW7jQrzcoxz/jPlivixOp0pE2pdP2VHBYrMytBnd8xbjd/yNnu1OlTAoMsIQoq9DdfQyjEkmTcDlwtV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576092; c=relaxed/simple;
	bh=6eYeo+2EktEAqPewy4c449rei8a49qZDjIv8pd6LkkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUp07EO6YOKBH1rTY1vQ8Hc5VoG/sImhbd2y9+7mgFU50k7v7OkJ0ojZvmnLaW24nXuTlCSCDPyAJRs1iLXuy230kQ1oIB2yKkfUn7kd1aIMXHE0au+GvKekEZKouihxjPiN5PEVLo4NGzZKGyvWPj7LLS/wCWMRNFOF2RTIQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU/bDYwA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso8683625ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728576090; x=1729180890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mDLS5yl8ggOWqXel6a4xI1+f8HA9YbqC4BEi2BAUgkw=;
        b=nU/bDYwAgHhhpns3NzZP8HDmAcMMZgHjxjGH3dnHmd9b+LzCjccGx8FG6nfnkRTZpu
         +eaBxLKCmXQCrFSbzAsd4w0WJIql8seVZziiyMbTM05IMw69dX5ALY87Ych1FsDkvnRk
         3U/gO/iRT2b3/1ZM5ZViSDe8oE7cYH69mnqTu1NR2mksw+vQLt1F2pF9o1l+1IZpFwaX
         v3MNFpT0AogJ5UShChfa6eljGahN9jpqDRsvLvYdp2dYxtX8SIy+fvim7O7ILH24QZ2P
         vpp6IT/bRGAyxveEDm7bSrKqH/aBaHDPcHGyLxjTbAPaa1uny8v8PsM9gPYfCOLgL4mI
         WqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728576090; x=1729180890;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDLS5yl8ggOWqXel6a4xI1+f8HA9YbqC4BEi2BAUgkw=;
        b=pn7ifQV7IuPj8d7DD72bHz14e20phjXyTVPubTqKtil6nAn+O7rGMODC+oubke9JRz
         n7txSMvSiDSo+Hw0l1D0DPEtI7bPOIs1s1ucJAecjrFKPZrWkXoMnaWH46zyEUhA5Ytb
         JeOVG3TUNY/RleyOPVAXz79/Wzhxa7LONuupIvvoLeVgRISxW4dXrPywzEkAR3OD7cV+
         pDzF6tWsgpqwY++8lDVshv+E+7uWLtYUQRAUNQ+TQqxsXPB6foDq2uRPSZyMQbbdd1t3
         q5+4HBGKz5lSE3F52Vo0Xj95QxZfxWy79r06NSuHAAN/wosRQ6wNtrYPBr13XRcB2C3n
         BxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9biUM0UtrL36YbPQJLVfAofowbu7EK4Auu0UpuPdWaMmWeUgZw1Fs3c+P/IAXwOu5Fgv/84OE2jQBjj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDsE6HXmT7kh+EF+h9hjlTt2z4Nsjbtn232d3toX5afqPHwUd
	CZQNPAIaI4s99GsHd+2QzpSye5FIqcGAK9MkhWwtTk1aleQOv9vs
X-Google-Smtp-Source: AGHT+IHr0bsG67yzmsxdXOfZgoBwt9+QvI/S6LNjevVFYoqWJFtg6nE4mFOsDZ81Zh9otyyu84KNnw==
X-Received: by 2002:a17:902:e5d1:b0:20c:769b:f045 with SMTP id d9443c01a7336-20c769bf1famr90509615ad.9.1728576089631;
        Thu, 10 Oct 2024 09:01:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc0ca8dsm11026215ad.84.2024.10.10.09.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 09:01:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <21eae385-ba7e-417c-b2c5-2071c3c7d8f5@roeck-us.net>
Date: Thu, 10 Oct 2024 09:01:27 -0700
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
 <0247886e-595e-4774-b515-ff628966f2be@roeck-us.net>
 <878quwbgv0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <878quwbgv0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/24 23:40, Huang, Ying wrote:
> Hi, Guenter,
> 
> Guenter Roeck <linux@roeck-us.net> writes:
> 
>> On 9/23/24 18:21, Huang, Ying wrote:
>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>
>>>> On 9/23/24 05:58, Geert Uytterhoeven wrote:
>>>>> Hi Günter,
>>>>> On Mon, Sep 23, 2024 at 12:50 AM Guenter Roeck <linux@roeck-us.net>
>>>>> wrote:
>>>>>> Building allmodconfig images on systems with SPARSEMEM=n results in
>>>>>> the following message.
>>>>>>
>>>>>> WARNING: unmet direct dependencies detected for GET_FREE_REGION
>>>>>>      Depends on [n]: SPARSEMEM [=n]
>>>>>>      Selected by [m]:
>>>>>>      - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]
>>>>>>
>>>>>> and the build ultimately fails.
>>>>> Really? What's the build error?
>>>>
>>>> I saw it on hexagon, and I didn't bother writing down the actual build error
>>>> message. But it turns out you are correct, the m68k machine does build with
>>>> CONFIG_RESOURCE_KUNIT_TEST=y even though SPARSEMEM and with it GET_FREE_REGION
>>>> are not set. Never mind, I don't really want or have time to argue. I'll just
>>>> disable CONFIG_RESOURCE_KUNIT_TEST when building hexagon images and wherever
>>>> else I see the problem.
>>>>
>>>>> It does build for me on m68k, after fixing:
>>>>>        --- a/include/linux/mm.h
>>>>>        +++ b/include/linux/mm.h
>>>>>        @@ -101,7 +101,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
>>>>>         # ifdef MAX_PHYSMEM_BITS
>>>>>         # define PHYSMEM_END   ((1ULL << MAX_PHYSMEM_BITS) - 1)
>>>>>         # else
>>>>>        -# define PHYSMEM_END   (-1ULL)
>>>>>       +# define PHYSMEM_END   ((phys_addr_t)-1)
>>>>>         # endif
>>>>>         #endif
>>> After Linus' fix for PHYSMEM_END, GET_FREE_REGION doesn't need to
>>> depend
>>> on SPARSEMEM anymore.  So, I think we can remove the dependency.  Can
>>> you check whether the following patch work for you on top of latest
>>> upstream kernel (with Linus' fix).
>>>
>>
>> It works for m68k. I'll run a complete test on all architectures/platforms
>> tonight.
> 
> Does it work in the complete test?
> 

Sorry, I dropped that one. Yes, it does.

Thanks,
Guenter

> --
> Thanks,
> Huang, Ying
> 
>>> ------------------------8<-------------------------------
>>> >From ce1a930f74192a4a85c20564098470356f8c2ed4 Mon Sep 17 00:00:00 2001
>>> From: Huang Ying <ying.huang@intel.com>
>>> Date: Mon, 23 Sep 2024 09:24:03 +0800
>>> Subject: [PATCH] resource: Remove dependency on SPARSEMEM from GET_FREE_REGION
>>> We want to use the functions configured via GET_FREE_REGION in
>>> resource kunit tests.  However, GET_FREE_REGION depends on SPARSEMEM.
>>> This makes resource kunit tests cannot be built on some architectures
>>> lacking SPARSEMEM.  In fact, these functions doesn't depend on
>>> SPARSEMEM now.  So, remove dependency on SPARSEMEM from
>>> GET_FREE_REGION.
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Cc: Nathan Chancellor <nathan@kernel.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>    mm/Kconfig | 1 -
>>>    1 file changed, 1 deletion(-)
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index b72e7d040f78..f287b0d1c5fc 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1060,7 +1060,6 @@ config HMM_MIRROR
>>>    	depends on MMU
>>>      config GET_FREE_REGION
>>> -	depends on SPARSEMEM
>>>    	bool
>>>      config DEVICE_PRIVATE


