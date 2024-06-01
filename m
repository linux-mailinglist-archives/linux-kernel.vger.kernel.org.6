Return-Path: <linux-kernel+bounces-197632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495D08D6D4B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EA11F23497
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D663D0;
	Sat,  1 Jun 2024 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4e8F1KJ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC75A29
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206050; cv=none; b=SQB12Oze6JYu1dhEr35bCINOzk1xn3U2nKGbN/SmA5CTnUljG/qmU6yP9R4aI3iMALKd5M09HHZo4BrDdhmKnWF1Q8Q85lrZ4zHmelkgPEbsBzl7hKbEb7MusAGqBXyap0vvZCv82chBaloOCdKksSWp/v8v6bY4rBk1pAt7z+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206050; c=relaxed/simple;
	bh=2HkF+6fWxbSeQjXNDjW8uMHoMiv2ELdbQbtuOGxC78g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0OPPIhrJJnL0PlFbiazs1t85UzuChIo9u7dp8F4wVt9bQInAorh+OZD3GAHdGl2QjthYz4nAvOwG13MtZGiEyaoT4/LPAfCP/3wpQzPf2bhUXMWFyapqmx5Vnbu6CE+3LwBMEBkKFWrPSWwb+hK8QL7WvwTt++rgimA7VNm7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4e8F1KJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so4582334a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717206047; x=1717810847; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjOHl1wOhX5TnmlUnEwReTihPRICcI/82ZuID7RA0Pc=;
        b=h4e8F1KJs9U2FpSc1/rlPG3+7oGqgarqkLWiTT0TNTDswU3RTdvS3uEQLcObohoB+C
         xP50lm9l7laBiihfbMsz8Lfmawxs+f0ircnCL3SAU38aGnI+VvI+8/cjpHxYKpI5Ra0h
         KAySPcY+2LT+ZSaQE6oV8Xm54T4vgxDKGLnUse+U3xMoSjcHW+GRcJHFiIElhd/CE5hk
         Q23CUSoRnResHxl6HnRxejNdDGCzrN74qirAvUAVMlFfi+eGu9DNRZgrQO3TfT5UvNxa
         3B46Y01MyM9U4E8jgBfsQdU58/cWS9yp6bma5XJjSgPmiWMT2RXPrK7dWP4OdE04vsNO
         2EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206047; x=1717810847;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FjOHl1wOhX5TnmlUnEwReTihPRICcI/82ZuID7RA0Pc=;
        b=Q3R05AbjK8GGVCZ3Ccv4dZOAe/pZCP7rzB+Q1ILUJPlPNXDB1g/ylBsA5mTuBGBW6J
         LDUL1SIgnB+VN22SG6E1PW9wivTmDn9/6FVrdMvm1HmMJcMsjtDsSKsINtOfqMI1EGH6
         vwcrIB63ITCtoMj9oJbJgRysq13zohMwc00LXcG+Gk5/3lTrum7fM1nxRg2PLcG8Up7k
         Ge3E8l5afT6JJNhWKoepdCWrc93OPpTLwR4eziaUa26s0sVImOSRM9LgWT5Nuzv9IOwf
         sFr1BuA0LLoy4U/2Aixwv8bNgv4JHAruytJDbJcktroOqI+zPYYFDAm5IKHwWpGXKRIw
         roog==
X-Forwarded-Encrypted: i=1; AJvYcCVSYpN8MadzVCJ8UeG17ELghphP80FMahpLptxH879op7gIwSkOHzH8myv/uh/J/UtoFs8pgNmvVfeMH4TbPNt1/hIcaFFZLYlsWhEz
X-Gm-Message-State: AOJu0YylE5arHA5ifbXc/j6AjSJatSrXSI/WQrThnToo4QBuJ/CudRiQ
	MqOhkEvi83PizogTE526jrceKD66kWGUEnG3PXbRkxEYjClMLnBG
X-Google-Smtp-Source: AGHT+IGsOwecO3L7jlAJRHay/1doV/X5ideh6MAQspfpuUObYwnhWa0Zlmfl4iZTBXwVdzeBvE1R4Q==
X-Received: by 2002:a50:9349:0:b0:578:6484:24ff with SMTP id 4fb4d7f45d1cf-57a19f546ddmr5802199a12.6.1717206046824;
        Fri, 31 May 2024 18:40:46 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a468ebb00sm387592a12.52.2024.05.31.18.40.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2024 18:40:46 -0700 (PDT)
Date: Sat, 1 Jun 2024 01:40:45 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
	Jaewon Kim <jaewon31.kim@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tkjos@google.com" <tkjos@google.com>,
	Pintu Agarwal <pintu.ping@gmail.com>
Subject: Re: (2) (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Message-ID: <20240601014045.jkk3ydsu4zns2bfc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
 <20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
 <20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>
 <20240529095119epcms1p73f0e9ff756bcb2ee6a14db459128a644@epcms1p7>
 <20240529113519.jupuazcf754zjxzy@master>
 <CAJrd-UuiDq-o=r7tK=CG6Q3yeARQBEAtaov2yqO6e6tBwJZoqQ@mail.gmail.com>
 <20240530104928epcms1p8108ece61c39c6e3d0361d445c15352d1@epcms1p8>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p4>
 <20240531082141epcms1p49d8d2048e04e90eca45644723614faa8@epcms1p4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531082141epcms1p49d8d2048e04e90eca45644723614faa8@epcms1p4>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, May 31, 2024 at 05:21:41PM +0900, Jaewon Kim wrote:
>>On Thu, May 30, 2024 at 07:49:28PM +0900, Jaewon Kim wrote:
>>>>On Wed, May 29, 2024 at 10:10:29PM +0900, Jaewon Kim wrote:
>>>>>(Sorry I might forget to change to be plain text)
>>>>>
>>>>>Oh good thing, I did not know this patch. Thanks.
>>>>>
>>>>>By the way, I've tried to get memblock/memory and kernel log from a
>>>>>device based on
>>>>>v6.6.17 kernel device, to see upstream patches above.
>>>>>memblok/memory does not show region for
>>>>
>>>>memblock/memory only shows ranges put in "memory".
>>>>memblock/reserved shows ranges put in "reserved".
>>>>
>>>>If we just put them in "reserved", it will not displayed in "memory".
>>>
>>>Hi
>>>Let me explain more.
>>>
>>>In this case, the intially passed memory starts from 0000000081960000 so memblock/memory shows as it is.
>>>
>>># xxd -g 8 /proc/device-tree/memory/reg
>>>00000000: 0000000081960000 00000000000a0000  ................
>>>00000010: 0000000081a40000 00000000001c0000  ................
>>>
>>># cat sys/kernel/debug/memblock/memory
>>>   0: 0x0000000081960000..0x00000000819fffff    0 NONE
>>>   1: 0x0000000081a40000..0x0000000081bfffff    0 NONE
>>>
>>># cat sys/kernel/debug/memblock/reserved
>>>   0: 0x0000000082800000..0x00000000847fffff    0 NONE
>>>
>>>The memblock information in the kernel log may report like it allocated those memblock regions, as there was not overlapped even though it is already no-map.
>>>
>>>(I removed the name.)
>>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000080000000..0x0000000080dfffff (14336 KiB) nomap non-reusable AAA
>>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000080e00000..0x00000000811fffff (4096 KiB) nomap non-reusable BBB
>>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000081200000..0x00000000813fffff (2048 KiB) nomap non-reusable CCC
>>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000081a00000..0x0000000081a3ffff (256 KiB) nomap non-reusable DDD
>>>
>>
>>This looks not printed by memblock_reserve(), right? It is printed by your own
>>driver?
>
>AFAIK these log came from the commit below.
>aeb9267eb6b1 of: reserved-mem: print out reserved-mem details during boot
>
>>
>>>So a smart parser should combine the krenel log and the memblock/memory log.
>>>
>>>In my memsize feature shows it like this though.
>>>
>>>0x0000000081400000-0x0000000081960000 0x00560000 (    5504 KB ) nomap unusable unknown
>>>
>>>BR
>>>
>>
>>I am sorry, I still not catch your point. Let me try to understand your message.
>>
>>You mentioned several regions, let me put them in order.
>>
>>(1)   0x0000000080000000..0x0000000080dfffff    printed by driver
>>(2)   0x0000000080e00000..0x00000000811fffff    printed by driver
>>(3)   0x0000000081200000..0x00000000813fffff    printed by driver
>>(4)   0x0000000081400000..0x0000000081960000    expected to print in new debugfs
>>(5)   0x0000000081960000..0x00000000819fffff    listed in reg/memory
>>(6)   0x0000000081a00000..0x0000000081a3ffff    printed by driver
>>(7)   0x0000000081a40000..0x0000000081bfffff    listed in reg/memory
>>(8)   0x0000000082800000..0x00000000847fffff    listed in reserved
>>
>>If you just want information for region (4), sound we can do it in user-space?
>>
>>BTW, are region 1, 2, 3, 6, reserved in membock?
>
>Yes correct, I though (4) case could be shown to easily catch these hidden regions.
>As I said, I think 1, 2, 3, 6 seem to be not passed to kernel, it was just tried as
>they are defined in kernel device tree.
>

As you mentioned above, 1, 2, 3, 6, is printed by "of" driver. And those
information is not shown in memblock/reserve.

I am afraid the proper way is to let memblock know those ranges. Sounds "of"
driver doesn't tell memblock about these.

>
>>
>>-- 
>>Wei Yang
>>Help you, Help me

-- 
Wei Yang
Help you, Help me

