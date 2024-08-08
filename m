Return-Path: <linux-kernel+bounces-279666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411CA94C034
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6387B1C2238D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722541917C2;
	Thu,  8 Aug 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXJMQzPl"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA55518F2C9;
	Thu,  8 Aug 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128379; cv=none; b=EV+NtsDzquQ5AahVC4eJCzb+vKRrugJo74FeD1bVtM3rbKvrRLyg2Ebf/H+F3GvQI5/W0oXWRyaxnOZacPJ9cx2ZFGDGIfo4O96pVJgPAnIPTTZVGzpZstLY7tUIBPnkZGzGSWsSynPshnU9jWb+/A2AseYM523ZLjKaurUIAEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128379; c=relaxed/simple;
	bh=miLeChk55LjsJpbZZR1Q09DkveT2oyE9WCPtgLrJpzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFD/0hcavf8MosI6sLlf8q3J6mqze7bp0BPw7Z2l31J+MNDoZMB3PeYxnSHor8i7dYjmdVblGdR+bFcQomMe6GtK1SlOUG6SvWvdsIkN+v/bvtD0EL9oN2MUh4WBnfxe2uHpj4mJkSH4O/xVFI/H7rL/2bqpnzlvSqFNmgy/+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXJMQzPl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so830258b3a.2;
        Thu, 08 Aug 2024 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723128377; x=1723733177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=y7RqUvuk9RqXJ4ySubcxzx8gLOiFWfFavPmZHPWdUII=;
        b=WXJMQzPliPlZddWlhAs1iN+TBr5ZrCntXmK5QLZvGC3sHy4aKV2FXE0+ylDDXuzwZH
         SeRtXsyB7OsR5fv60y8erjED63FA5TjdVIZWYteyx9lH1ftxEgICYxdsSafSr+7IThkv
         6bA+muGVnQgqHyoUcuC9DB+q8rRnGs8fRqjhSp17Hr8jzH6v0QN5n78ykMK2Z4bb1pHR
         NQdCJ9bpvEVTutK81H3Rx12KV8w5wPcCoVEN1+iADVtf0vSgkaT0rDIvMxwwkGiaJxat
         R5Jb4r7eOMT4R9tMOdsX15qPTvfkEuMlEkDQR/qI+zIhslSPAhZKuwE9nqSu/ZdrOvGu
         Un7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128377; x=1723733177;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7RqUvuk9RqXJ4ySubcxzx8gLOiFWfFavPmZHPWdUII=;
        b=AeBs7jlEiE2853+kjrErc/mdOSOxJOqu1KBVUg1YckwZIRlEwHVB6C0QekwGm1OSki
         8uKa8ygDqg6rxAj54LEoIHrf1iHFFfgVoNm8GtVVqD+S1B+yqjYdQUdmzkJESsdTVZ1A
         m7sYdMcuSWWPg6WbdlB8m2/O06OGZ3He2tfH8LC5ejtx4B58zzJSnIpYMGp+iUVQ5PSj
         nWhU0frpa7MsZlsUO5CAH/g5eNRN0F5aQrpjvjF9qlVlNu0umpzWGhhpJIH8qyCQgKzi
         /ISSH/JT/6xII7UAfC44PoR4d/tRJYL+Cmxp5LlTfBiJ1cy8bjZCw6bXt67bp0HbsEfm
         8HGg==
X-Forwarded-Encrypted: i=1; AJvYcCVh+tZMmJ+zsDGwTLbz0u4q/3prsLqw5CSqUlqIXBFBLcg04mwtFQl5qfNYiMPeMFkBH/7mc6mqfBDsytLwIwgnsnpntIQZCVfGTwFN
X-Gm-Message-State: AOJu0YzwH7RrM3NEd7Ch3pUjZmXIXFI9giBXRRYyilHnQuJQK4KxenA3
	RIb6o3aDtb5QHvjaiTYWa3ZAlWGeZR0346hD8Rzm7gM4m5sJ+6d0
X-Google-Smtp-Source: AGHT+IHTbQ0AQ4QERaIF9kwePuRWOJGoN7noQoLz9akudQdtRV4bGXNwJCQ0GOQ//yCxJLxyML0UYg==
X-Received: by 2002:a05:6a00:240d:b0:70d:2368:d8b7 with SMTP id d2e1a72fcca58-710cadce833mr2746988b3a.13.1723128376855;
        Thu, 08 Aug 2024 07:46:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fb034sm1204416b3a.198.2024.08.08.07.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 07:46:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1d6fc329-7f77-4949-9537-fe27d1bf621c@roeck-us.net>
Date: Thu, 8 Aug 2024 07:46:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Vlastimil Babka <vbabka@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net>
 <7f75fc3e-dc8a-4d3f-b9b5-70f310a3d99c@suse.cz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7f75fc3e-dc8a-4d3f-b9b5-70f310a3d99c@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 00:48, Vlastimil Babka wrote:
> On 8/8/24 03:07, Guenter Roeck wrote:
>> On 8/6/24 16:24, Thomas Gleixner wrote:
>>> Cc+: Helge, parisc ML
>>>
>>> We're chasing a weird failure which has been tracked down to the
>>> placement of the division library functions (I assume they are imported
>>> from libgcc).
>>>
>>> See the thread starting at:
>>>
>>>     https://lore.kernel.org/all/718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net
>>>
>>> On Tue, Aug 06 2024 at 21:25, Vlastimil Babka wrote:
>>>> On 8/6/24 19:33, Thomas Gleixner wrote:
>>>>>
>>>>> So this change adds 16 bytes to __softirq() which moves the division
>>>>> functions up by 16 bytes. That's all it takes to make the stupid go
>>>>> away....
>>>>
>>>> Heh I was actually wondering if the division is somhow messed up because
>>>> maxobj = order_objects() and order_objects() does a division. Now I suspect
>>>> it even more.
>>>
>>> check_slab() calls into that muck, but I checked the disassembly of a
>>> working and a broken kernel and the only difference there is the
>>> displacement offset when the code calculates the call address, but
>>> that's as expected a difference of 16 bytes.
>>>
>>> Now it becomes interesting.
>>>
>>> I added a unused function after __do_softirq() into the softirq text
>>> section and filled it with ASM nonsense so that it occupies exactly one
>>> page. That moves $$divoI, which is what check_slab() calls, exactly one
>>> page forward:
>>>
>>
>> With the above added to my tree, I can also play around with the code.
>> Here is the next weird one:
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 4927edec6a8c..b8a33966d858 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1385,6 +1385,9 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
>>           }
>>
>>           maxobj = order_objects(slab_order(slab), s->size);
>> +
>> +       pr_info_once("##### slab->objects=%u maxobj=%u\n", slab->objects, maxobj);
>> +
>>           if (slab->objects > maxobj) {
>>                   slab_err(s, slab, "objects %u > max %u",
>>                           slab->objects, maxobj);
>>
>> results in:
>>
>> ##### slab->objects=21 maxobj=21
>> =============================================================================
>> BUG kmem_cache_node (Not tainted): objects 21 > max 16
> 
> But is this printed from the same attempt? The pr_info_once() might have
> printed earlier and then stopped (as it's _once) and the error case might
> have happened only later, and there was nothing printed in between as the
> kmalloc caches are created in a loop.
> 

No, of course it isn't. Guess it was too late. Sorry for the noise.
Here is the updated log, after dropping the _once:

...
[    0.000000] ##### slab->objects=21 maxobj=21
[    0.000000] ##### slab->objects=25 maxobj=25
[    0.000000] ##### slab->objects=21 maxobj=16
[    0.000000] =============================================================================
[    0.000000] BUG kmalloc-256 (Not tainted): objects 21 > max 16

So this works many times and then suddenly fails. I thought it was
the other way, that it failed the very first time. Ok, back to debugging.

Thanks!
Guenter


