Return-Path: <linux-kernel+bounces-277166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1D3949D69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB8B22EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D585E15B98F;
	Wed,  7 Aug 2024 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InEEFb0b"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1503910E6;
	Wed,  7 Aug 2024 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722994719; cv=none; b=jfGy1mZLNEkj6MYatOjeofp7lCKYQ0DHgusGH3X7qLm1oknIjlTv2l51S+C7tETCtn0REqXJkp14Ah8Lguv12GW7/+SxfwipjIIxQ4r32R0CHfzmyp71CjWdWYv4CROwbJueGVRYQ2zkCGiwr4V90dj781paa+zD0+Bf5fEqU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722994719; c=relaxed/simple;
	bh=aq571yIABuYPvn/nuYMrjdNF9xC2kKU/Qby+jvtGjXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6fzIkp+T+jUyD8Sdt8ne+IgNQWfcu/yI60Oy8MMajgA3uS9K7y8v2aIQ9IMORFhpezG/WtwMl7FpsGkRnamNR5Ydmo6qxOf6LTwL2P3UrBRPWhZMzo81rk2spab7a6QxZOgu/n8GSlCPrCgDf6R8Qs7Cs+/1Tl4/3Q2URINbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InEEFb0b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc56fd4de1so3128595ad.0;
        Tue, 06 Aug 2024 18:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722994717; x=1723599517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NlI5kXXyG7eO9dy96MNv0FUqgJQRkfbNuYx0yu4wY+4=;
        b=InEEFb0bINUKXGRwn9dCLhBQT3hfrbSkVWkHdUi+3ed0MnMJ3a0lf0wuZaB0vLHAFs
         4qrgeM63rK3p2zTUsTVfZEAYfVQmwV/kwr/PLfzxg97LUFMinb+8chNSPZyt6+9zUgbX
         nDjST/EWrrv2PcjcBL4dlgTv/mLP+S+v8Xv/oiW0PQLFLitYjQvtPZt2F7BY4cOAqgct
         N7+DXlCBGWEXmLffhuSJcTKyfXDGU7Tan/0d8Bd8RNnuOQje2iiHNXq3LnFMofg8Cem8
         svN9DqWKryTi8v4oygJvQoYN51Ue6BU+SFcIgPDbCVE+DmCjAJGaM5h6HH03BscMIuS4
         Nl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722994717; x=1723599517;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlI5kXXyG7eO9dy96MNv0FUqgJQRkfbNuYx0yu4wY+4=;
        b=ZDaNVCqJDTYoR/eYyUT3i84a4zHvhobw1qAWhlrbGtDlP3wD9dsFBCeYk/vR75sFry
         j6rWz7B2bcxLwhsKfu9UPHVmi4k8Vych9eb6Dxr+stsC6V5EDsDsJDolAPDxwlz5wz6U
         zziEH3ugTTFPRKXWoQAa0w6+QyoAzxZyfj/bDN+8mhFgs5b9Dc8rm56OdGy5L6Je+lyQ
         7oiXDPH5nZgTw6Lc7urRgFTGH2JCl17ZAyghzdoIdbHJJco9S5g5f0ppTgisrdO9AxsD
         HWbNNxiB1Ytp7BVhziwcO7FSDeYQ9+7EQpOFAa4IcMEsHSkiZacPL+u/8wSBn1WzzMe5
         eBBA==
X-Forwarded-Encrypted: i=1; AJvYcCXrxuedtrYxkYa6zNkPlV8QRuSYVDztWb+TFq1rhj08GgKHzJqTD3uKJvan70+GOseoEHwXzZL2pwXTcxt9RxDs5qxWoOqUJTC5TXjX
X-Gm-Message-State: AOJu0YwUXGXVPYPir2Il/vHTnyIxyWbrdfCYCh3kfTS/q1oY5TtFQqIw
	EO7x22LMKHLrb+7bbzCtdbEGWHrPMXfs7MlKfFa5/13JfwkaWiLh
X-Google-Smtp-Source: AGHT+IF8HBsHSr2X8dtCiVhdRxQ/ZczgPzO4my7ifdx42r5vf4h9UT+TqZPDpLkpkkbrpcDDemBXsw==
X-Received: by 2002:a17:902:c403:b0:1fd:6033:f94e with SMTP id d9443c01a7336-200855683a3mr9677265ad.27.1722994716991;
        Tue, 06 Aug 2024 18:38:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19cb7sm94081565ad.33.2024.08.06.18.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 18:38:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <78933046-09ec-4dc9-9ab1-f00b4cceab27@roeck-us.net>
Date: Tue, 6 Aug 2024 18:38:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <c54ab27ff0f0bb3e9e681eec9a62549e5e245a6b.camel@HansenPartnership.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c54ab27ff0f0bb3e9e681eec9a62549e5e245a6b.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/24 17:49, James Bottomley wrote:
> On Wed, 2024-08-07 at 01:24 +0200, Thomas Gleixner wrote:
>> Cc+: Helge, parisc ML
>>
>> We're chasing a weird failure which has been tracked down to the
>> placement of the division library functions (I assume they are
>> imported
>> from libgcc).
>>
>> See the thread starting at:
>>
>>   
>> https://lore.kernel.org/all/718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net
>>
>> On Tue, Aug 06 2024 at 21:25, Vlastimil Babka wrote:
>>> On 8/6/24 19:33, Thomas Gleixner wrote:
>>>>
>>>> So this change adds 16 bytes to __softirq() which moves the
>>>> division
>>>> functions up by 16 bytes. That's all it takes to make the stupid
>>>> go
>>>> away....
>>>
>>> Heh I was actually wondering if the division is somhow messed up
>>> because
>>> maxobj = order_objects() and order_objects() does a division. Now I
>>> suspect
>>> it even more.
>>
>> check_slab() calls into that muck, but I checked the disassembly of a
>> working and a broken kernel and the only difference there is the
>> displacement offset when the code calculates the call address, but
>> that's as expected a difference of 16 bytes.
>>
>> Now it becomes interesting.
>>
>> I added a unused function after __do_softirq() into the softirq text
>> section and filled it with ASM nonsense so that it occupies exactly
>> one
>> page. That moves $$divoI, which is what check_slab() calls, exactly
>> one
>> page forward:
>>
>>      -0000000041218c70 T $$divoI
>>      +0000000041219c70 T $$divoI
>>
>> Guess what happens? If falls on it's nose again.
>>
>> Now with that ASM gunk I can steer the size conveniently. It works up
>> to:
>>
>>      0000000041219c50 T $$divoI
>>
>> and fails for
>>
>>      0000000041219c60 T $$divoI
>>      0000000041219c70 T $$divoI
>>
>> and works again at
>>
>>      0000000041219c80 T $$divoI
> 
> So just on this, you seem to have proved that only exact multiples of
> 48 work.  In terms of how PA-RISC caching works that's completely nuts
> ... however, there may be something else at work, like stack frame
> alignment.
> 
>>
>> So I added the following:
>>
>> +extern void testme(void);
>> +extern unsigned int testsize;
>> +
>> +unsigned int testsize = 192;
>> +
>> +void __init testme(void)
>> +{
>> +       pr_info("TESTME: %lu\n", PAGE_SIZE / testsize);
>> +}
>>
>> called that _before_ mm_core_init() from init/main.c and adjusted my
>> ASM hack to make $$divoI be at:
>>
>>      0000000041219c70 T $$divoI
>>
>> again and surprisingly the output is:
>>
>>      [    0.000000] softirq: TESTME: 21
> 
> OK, why is that surprising?  4096/192 is 21 due to integer rounding.
> 

Problem is that it sometimes wrongly returns 16. But not always.
The surprise may be that it is not consistently wrong, even if
divU is at the same location.

>> Now I went back to the hppa64 gcc version 12.2.0 again and did the
>> same ASM gunk adjustment so that $$divoI ends up at the offset 0xc70
>> in the page and the same happens.
>>
>> So it's not a compiler dependent problem.
>>
>> But then I added a testme() call to the error path and get:
>>
>> [    0.000000] softirq: TESTME: 21
>> [    0.000000]
>> =====================================================================
>> ========
>> [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
>> size 192 sorder 0
>>
>> Now what's wrong?
>>
>> Adding more debug:
>>
>> [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
>> size 192 sorder 0 21
>>
>> where the last '21' is the output of the same call which made maxobj
>> go
>> south:
>>
>>   static int check_slab(struct kmem_cache *s, struct slab *slab)
>>   {
>>          int maxobj;
>> @@ -1386,8 +1388,10 @@ static int check_slab(struct kmem_cache
>>   
>>          maxobj = order_objects(slab_order(slab), s->size);
>>          if (slab->objects > maxobj) {
>> -               slab_err(s, slab, "objects %u > max %u",
>> -                       slab->objects, maxobj);
>> +               testme();
>> +               slab_err(s, slab, "objects %u > max %u size %u sorder
>> %u %u",
>> +                        slab->objects, maxobj, s->size,
>> slab_order(slab),
>> +                        order_objects(slab_order(slab), s->size));
>>                  return 0;
>>          }
>>          if (slab->inuse > slab->objects) {
>>
>> I don't know and I don't want to know TBH...
> 
> OK, so you're telling us we have a problem with slab_order on parisc
> ... that's folio_order, so it smells like a parisc bug with
> folio_test_large?  Unfortuntely I'm a bit pissed in an airport lounge
> on my way to the UK, so I've lost access to my pa test rig and can't
> test further for a while.
> 

I think the problem is rather that divU, for some unknown reason, sometimes returns
bad results. The divU implementation in libgcc isn't exactly easy to understand.
There may be some context problem, such as the upper bits of some register not
being cleared under some circumstances. Look at my recent commits into
arch/parisc for examples how similar problems survived for a long time in the
Linux kernel.

I'd strongly suspect a qemu emulation problem if it wasn't for those other
problems. Still, I think it is very likely that the problem lies in qemu,
but we might need a confirmation one way or the other from a test on real
hardware.

Thanks,
Guenter


