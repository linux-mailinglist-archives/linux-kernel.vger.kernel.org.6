Return-Path: <linux-kernel+bounces-276707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DF194974C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F071F22019
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92DA6F2EB;
	Tue,  6 Aug 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhcPK7FU"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916B2A1D3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967797; cv=none; b=r7PbVxTeMbyyAXEisypqTppLec/unERb9rsvF5tNnjLuJYYiA3j60ovmFGfR7sI9aW7/w2VZdVRbeQj08CG2imWGiv9ujOfcsZmTY1eyK4xtSRgontvANP6gVGz8qzXJzBysSw+yeoREYVuBjAhglRnXjPO/be8fETo/qhZuzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967797; c=relaxed/simple;
	bh=MYCKGSoA0crixweqme2V+2Cpqcw5PlOTjUrxddzVQog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3XdLYv1BNqC6+9lV84fuD7zIpTxK/pECjVgjj/fCuMZ8IhaoS4YlF1y59lhEBqkQWapofvmMifcSgtQkW/y48M8l5ywuD4HNE72eT5ffPpa8fj5GqOfbsvEbnv1taiOgi9HC8HRstfUGqCyH/SJ8yshGD01xVuf0kf1V4nKoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhcPK7FU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so646442a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722967795; x=1723572595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu4ZkLsQR3EhtYRPUHDgtFLgh0dHHtlaWa1gWv/pt+Y=;
        b=lhcPK7FUay4q3Y39PgLB3YVCswOfq9hVG3DqmwM8SoqIKutcr/7ojrIhjpnJmHijKJ
         DB66ZW3njthsAR1r8EHm2KqEh9PiVsWxEpxTPwU+vV03rShTSW/eV0ZlIAWxlinvKnLs
         zQsKPwHX63uJjPeTTQRRf0nMtksSyuhd421clCZY2B6zspsC4wxhfy308/frJ6EiHqgR
         4/GMM4I5nrOKrV46yiUv6xWAlGo9F92rjr9BspfefWCPfI3Drpa9jSeHidZ7t/HUHH/K
         5ojwIzTWNwx462tDinvlvt47UBv3su2/LZN2dMUFS+nIppSdwQepRBClNEFaWsL46Lxh
         CJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967795; x=1723572595;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu4ZkLsQR3EhtYRPUHDgtFLgh0dHHtlaWa1gWv/pt+Y=;
        b=i7vbrYljtSIEUCEHNez1HkCtvG8nQFahbEaW6LPeUBY8XwnDO60CA1RHjDaGybTF+2
         TNZE7n7YDJprjXGzTzqb0+2+vwmfe5VqO17+hDwPwbKbLBVCDyPE6bZIis0WfKYnWR6/
         Ei6zgOpV0rNFQ1nnv1k6Io4PlArFrAfPkjgwJmYhzKFie/kG+8uQT/sty5FjjVYPUIZR
         k7yF7U1UPyHrzZORuy2bkpKE5AQ49xtzl+LZgxhB34iRJDC5dw1AM8IPksybmRdQAJQ/
         9tS4zq1yB1ZBrdGvymhVW39TtRPR0BVsh2XAbqV768cdg4v2o04/AQ/Oj5vJnUJ06bSb
         f3BA==
X-Gm-Message-State: AOJu0YwzZMb1hIlJWKfN30Ce/48rlWxn7TChf3Th6+1Iq3NoHAWkLfQY
	PNSXrQUbAwUKC/AReYHY2azIeB7gjPNEZSTLjPZQ+zv1UUG1TgWQPIFleQ==
X-Google-Smtp-Source: AGHT+IG1s2KFIUxaPZDYvdjFY1OxR9xcFqzDNAw6sezY2TaPp2nNhBJrHPN76j4tsLnr4rLpljResw==
X-Received: by 2002:a17:90b:350d:b0:2c9:6187:98ca with SMTP id 98e67ed59e1d1-2cff946ab1emr15580535a91.22.1722967794679;
        Tue, 06 Aug 2024 11:09:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc461016sm12882065a91.29.2024.08.06.11.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 11:09:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4f71784a-e896-4512-b1e5-600d0497037c@roeck-us.net>
Date: Tue, 6 Aug 2024 11:09:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Vlastimil Babka <vbabka@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 04:02, Vlastimil Babka wrote:
> On 8/6/24 04:40, Linus Torvalds wrote:
>> [ Let's drop random people and bring in Vlastimil ]
> 
> tglx was reproducing it so I add him back
> 
>> Vlastimil,
>>   it turns out that the "this patch" is entirely a red herring, and the
>> problem comes and goes randomly with just some code layout issues. See
>>
>>     http://server.roeck-us.net/qemu/parisc64-6.10.3/
>>
>> for more detail, particularly you'll see the "log.bad.gz" with the full log.
> 
> [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
> [    0.000000] Slab 0x0000000041ed0000 objects=21 used=5 fp=0x00000000434003d0 flags=0x200(workingset|section=0|zone=0)
> 
> flags tell us this came from the partial list (workingset), there's no head flag so order-0
> 
> since the error was detected it basically throws the slab page away and tries another one
> 
> [    0.000000] BUG kmem_cache (Tainted: G    B             ): objects 25 > max 16
> [    0.000000] Slab 0x0000000041ed0080 objects=25 used=6 fp=0x0000000043402790 flags=0x240(workingset|head|section=0|zone=0)
> 
> this was also from the partial list but head flag so at least order-1, two things are weird:
> - max=16 is same as above even though it should be at least double as
> slab page's order is larger
> - objects=25 also isn't at least twice than objects=21
> 
> All the following are:
> [    0.000000] BUG kmem_cache (Tainted: G    B             ): objects 25 > max 16
> [    0.000000] Slab 0x0000000041ed0300 objects=25 used=1 fp=0x000000004340c150 flags=0x40(head|section=0|zone=0)
> 
> we depleted the partial list so it's allocating new slab pages, that are
> also at least order-1
> 
> It looks like maxobj calculation is bogus, would be useful to see what values it
> calculates from. I'm attaching a diff, but maybe it will also hide the issue...
> 

If I am really careful I can catch the problem. Adding a parameter to slab_err()
makes it disappear. Calling slab_order() multiple times makes it disappear. But I can
assign the result of slab_order() to a variable and go from there, by changing the
parameters to slab_err() one at a time. Here is what I get by combining multiple
test runs.

objects 21 max 16 order 0 size 192
  with:
   Slab 0x0000000041ed0000 objects=21 used=5 fp=0x00000000434003d0 flags=0x200(workingset|section=0|zone=0)
objects 25 max 16 order 1 size 320 (many times)
  with:
   Slab 0x0000000041ed0080 objects=25 used=6 fp=0x0000000043402790 flags=0x240(workingset|head|section=0|zone=0)
   Slab 0x0000000041ed0300 objects=25 used=1 fp=0x000000004340c150 flags=0x40(head|section=0|zone=0)
   Slab 0x0000000041ed0380 objects=25 used=1 fp=0x000000004340e150 flags=0x40(head|section=0|zone=0)
   and so on

If I add a log message into check_slab() and display every check I get:

objects 21 max 21 (order 0 size 192)
objects 25 max 25 (order 1 size 320)
objects 25 max 25 (order 1 size 320)
objects 25 max 25 (order 1 size 320)
objects 21 max 21 (order 0 size 192)

and so on. I guess that confirms that the maxobj calculation is wrong in the failure case.
That seems weird, though, given that order_objects() should return a constant based on
order and size. PAGE_SIZE is 4096, meaning order_objects() should return 21 and 25, never
16. That does make me really wonder if there is an emulation problem, though I don't
really understand why that would not be persistent.

Any idea what else I could test ?

Thanks,
Guenter


