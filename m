Return-Path: <linux-kernel+bounces-196119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695788D5792
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2103B28203D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F472D26A;
	Fri, 31 May 2024 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjL8AtyX"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149E7483
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117556; cv=none; b=aCD589gm2jPWE//jYjQH2KfC7xsExwcwJNls0dHhF5TKtLEsgEP+2fwu/eCB7zE9d3OIAL5aNotyy+TEr7ij0oaG283sxpOvzzQo5THUo9I76XnnpGF35wAoSBp3Ap9gnP3JZYOVyyqHn/xVdlrOK/4mUpsAnzV/GqAOY+1X1vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117556; c=relaxed/simple;
	bh=SfA0y4/G7TKSphJIXPmgkqTenHpG1biYJFLYFNhvoy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eir88VUb9w97T/P3rgMH1j6ZluAcNzj2kqeeDnhDUD6IPXJtb5PFU4dfeyVjqD9piVCiZrjn8RJWmk6qXjT+gEGO6GA/i0Vn61bALdpDAMRtA5vu6bhoe0h695mfviQq06awRjwzNGTsm6+u9pUEk55uh+gbi0sl1QUhi4v1W+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjL8AtyX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a352bbd9so236097466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717117553; x=1717722353; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYGMk+i7S4SptEmVMjkXOdhfLv9S+0xIdSr477hSXzc=;
        b=UjL8AtyXO4Cqs618ckpO8PjSNz8rgrCTjoqmu1tA2zum114RUWrvTTYuDHv0Qk9ncu
         Qr7gGv/We7qpneZyZ0xg6kB1MT3FdAXcJNiK7KLyCUP61f33ySNksjIhmjB9/WgBA5YI
         6xS0pMpQzrtZHgfUiEe3/yJBupMew5c8wUNuQTD+hS8yVua83gbc72qzMXIB4ol1Z/GR
         7dm2YSEijXakyig8EdyhkaA6Tn/aXuIE9Ro9P0EUvlVvxVP9j8HSRTDex3v2XS2PSi90
         c6C3DGpND32wv0NJYOcYUQsuimpOvtyKqdoP8ZBX0T9oX68WnE9zgLZI3ZeKVaeA5T0M
         TiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717117553; x=1717722353;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYGMk+i7S4SptEmVMjkXOdhfLv9S+0xIdSr477hSXzc=;
        b=B51fBWkCKJz0Nuh2cD6fB8DP6BIf0Rc8kt1Ta4IJMb8C9ameRoHluVcM3z/GR0/p//
         aJMus4AE7rSEeHWiOzp6ePtRtYSWzsioMkLdVyKBpw0HPp9Ria/dlpiIsgtYqA6IbjWL
         9yicyKOrQU/BnaI0zd+lBhzjUgy6cr+RJj9yW88bjLmqe3hVQzBzS2v0j+2eLmwFYZBR
         eFhdoCdLSy8eIkQNusSq0Pw8SHyOi5w9lzsGieMWGSEYR3kPdlJznM8rEmU+htEbWSzI
         eW/jK0mK6lH3WVEju6+uU4Q0otPEz+ynaLhleYkd/KeKtKc2MKN83AvQcycubDkr98Sy
         DUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu1OGnT/Z02+RIf0M2meuRl+eZJ2eTW4JFeCQKzmOYXte9C5CeTAuoAqwdyHPdRf6xfI/KxHWvuIQqgEJr+3wh3c0dUtBNvD67wHB9
X-Gm-Message-State: AOJu0Yw0lfMvK9yxTPJxaQyEI2moigJJ4hLvl1/j8bGZTvqGqGLdgV4B
	SMIIf/f52I+I4PS1E85z7G4ZtLu6xBzDWC82mutDWwFwsSbSMui/
X-Google-Smtp-Source: AGHT+IHyFJULbnDpDfOZsWXGdsEzm9WVDmTsUUPTw6KLhP8f5em07Q48sA38sGTvEGG4oJh7NTf7hA==
X-Received: by 2002:a17:906:3b8b:b0:a65:46d4:de5f with SMTP id a640c23a62f3a-a65f0d0c5afmr282628666b.37.1717117552533;
        Thu, 30 May 2024 18:05:52 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e74f0649sm31217466b.86.2024.05.30.18.05.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2024 18:05:51 -0700 (PDT)
Date: Fri, 31 May 2024 01:05:51 +0000
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
Message-ID: <20240531010551.hs67amz34mljyifw@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
 <20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
 <20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>
 <20240529095119epcms1p73f0e9ff756bcb2ee6a14db459128a644@epcms1p7>
 <20240529113519.jupuazcf754zjxzy@master>
 <CAJrd-UuiDq-o=r7tK=CG6Q3yeARQBEAtaov2yqO6e6tBwJZoqQ@mail.gmail.com>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p8>
 <20240530104928epcms1p8108ece61c39c6e3d0361d445c15352d1@epcms1p8>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530104928epcms1p8108ece61c39c6e3d0361d445c15352d1@epcms1p8>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, May 30, 2024 at 07:49:28PM +0900, Jaewon Kim wrote:
>>On Wed, May 29, 2024 at 10:10:29PM +0900, Jaewon Kim wrote:
>>>(Sorry I might forget to change to be plain text)
>>>
>>>Oh good thing, I did not know this patch. Thanks.
>>>
>>>By the way, I've tried to get memblock/memory and kernel log from a
>>>device based on
>>>v6.6.17 kernel device, to see upstream patches above.
>>>memblok/memory does not show region for
>>
>>memblock/memory only shows ranges put in "memory".
>>memblock/reserved shows ranges put in "reserved".
>>
>>If we just put them in "reserved", it will not displayed in "memory".
>
>Hi
>Let me explain more.
>
>In this case, the intially passed memory starts from 0000000081960000 so memblock/memory shows as it is.
>
># xxd -g 8 /proc/device-tree/memory/reg
>00000000: 0000000081960000 00000000000a0000  ................
>00000010: 0000000081a40000 00000000001c0000  ................
>
># cat sys/kernel/debug/memblock/memory
>   0: 0x0000000081960000..0x00000000819fffff    0 NONE
>   1: 0x0000000081a40000..0x0000000081bfffff    0 NONE
>
># cat sys/kernel/debug/memblock/reserved
>   0: 0x0000000082800000..0x00000000847fffff    0 NONE
>
>The memblock information in the kernel log may report like it allocated those memblock regions, as there was not overlapped even though it is already no-map.
>
>(I removed the name.)
><6>[    0.000000][    T0] OF: reserved mem: 0x0000000080000000..0x0000000080dfffff (14336 KiB) nomap non-reusable AAA
><6>[    0.000000][    T0] OF: reserved mem: 0x0000000080e00000..0x00000000811fffff (4096 KiB) nomap non-reusable BBB
><6>[    0.000000][    T0] OF: reserved mem: 0x0000000081200000..0x00000000813fffff (2048 KiB) nomap non-reusable CCC
><6>[    0.000000][    T0] OF: reserved mem: 0x0000000081a00000..0x0000000081a3ffff (256 KiB) nomap non-reusable DDD
>

This looks not printed by memblock_reserve(), right? It is printed by your own
driver?

>So a smart parser should combine the krenel log and the memblock/memory log.
>
>In my memsize feature shows it like this though.
>
>0x0000000081400000-0x0000000081960000 0x00560000 (    5504 KB ) nomap unusable unknown
>
>BR
>

I am sorry, I still not catch your point. Let me try to understand your message.

You mentioned several regions, let me put them in order.

(1)   0x0000000080000000..0x0000000080dfffff    printed by driver
(2)   0x0000000080e00000..0x00000000811fffff    printed by driver
(3)   0x0000000081200000..0x00000000813fffff    printed by driver
(4)   0x0000000081400000..0x0000000081960000    expected to print in new debugfs
(5)   0x0000000081960000..0x00000000819fffff    listed in reg/memory
(6)   0x0000000081a00000..0x0000000081a3ffff    printed by driver
(7)   0x0000000081a40000..0x0000000081bfffff    listed in reg/memory
(8)   0x0000000082800000..0x00000000847fffff    listed in reserved

If you just want information for region (4), sound we can do it in user-space?

BTW, are region 1, 2, 3, 6, reserved in membock?

-- 
Wei Yang
Help you, Help me

