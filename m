Return-Path: <linux-kernel+bounces-278762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD46C94B468
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E60D1F22A7C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582A4A2D;
	Thu,  8 Aug 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSC0Ucer"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9020E6;
	Thu,  8 Aug 2024 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079252; cv=none; b=Al2DfsRtgcn0OsoNm4EnjrewZkLiBpo6d3oOcuqSYFDj1/UB+WtCnrOVqA7Ou6zMGdja4Gw7oGgRyMoH5ynHEyiCVyM/IeymqX15+M5FozZiv4Cqj8vl+NblUM6o3RDDXKc+npG0pa5cEBgwuhRCxStiREhmlDzFc88QWxaNdJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079252; c=relaxed/simple;
	bh=LdL/hDIIb7dQfh4Ko6DZ9omFSOdwFjIwomx0PFhqbQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OW38jE22q2IL7ta9CKgjacyXNIsjV/7qfOLQxu9oHVLZN9xqb0nydK2KufBtImWqwrBoLFX4+UlE+AKhtbVYgJOL2gpOKhzFoUHXm+04c7J/jUKG8pQoWjSzreSsZ4LEjzaOZSdOfqzSmaVNn5MUwJAFkROMI3JVkh/MyYaobK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSC0Ucer; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a103ac7be3so306656a12.3;
        Wed, 07 Aug 2024 18:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723079249; x=1723684049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xe6bIqlnRissxAc0QQf03njofG5ELO2QawM43kqHGSU=;
        b=KSC0UcervAkE6v9+60znD9jtN6t0K3ToZK9onKEAvsDfOLRPhO+f7+5g7GmZ8tFExW
         WF+8J+YqkiaxJpuP60RjxX4f4TSb15woQoOhIT+xJWMdualIBB1wUJ98xBPV7vyH0X4U
         JjpBmD/mH6Gebvk1u+WfgpRo5AWi5CTpPrQNo2pjheHRF/f1AiLBC2Kw/yj5cwNq6zbt
         PGYIsWx7S0La6PdEyI4lcYfbHgvM5rAxAYDvpBf9k+FDOtEQWwKE4awoYnCCGEytn5fj
         sViP7+CWKrH7VH3UPZ6SCcqBGEk7b9dnDBpi7KdpPrpsyYU1RDCuY/0PUWMwzWAIupyQ
         NT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723079249; x=1723684049;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe6bIqlnRissxAc0QQf03njofG5ELO2QawM43kqHGSU=;
        b=JYkJlOZlLNaTKWT2q6wHjqsL7KdwCUKfR0PGEXxQVx1ZRyEH2xsIaBFn7/HAu0n01q
         Jlyxxz/ZnMjeXIzJ/CqH2USKvnAK7OwimiT8GdioIfIhLMMLfKOnpZAKiYhfBDUjQ5a7
         hHE0Whg7eCm9Xkc6qZA9jokKpHjWTRCpfPobUjwDUhQOWuO5rArjwrRTRk6bSo6tB88z
         U7j6BadOp9fqD3I9ucYO4tMcndNk8WW/+DFcx+mb3CswJ74vzW4CptkHTmGAW1tZ9TFr
         3wYLRMAthxwAFJuw3Gf5CoBKyP63mPRGFKYpyZPBKi16OsqpGoiwkoX/v8JYpGG3VPDn
         2oaA==
X-Forwarded-Encrypted: i=1; AJvYcCXOy+YXVYlxM2zMwaAZn4dBVm4EbD4uNYuRscuaazTRyebn6rA/NAvuocoFbN9gFAgOYDdJBGYNANOJr+xa87MTr2GewMK2vTc5IEuj
X-Gm-Message-State: AOJu0Yz+gXeAjOvK4FgMxfJ4tGnX4TZo5DoyU1Tc1fLJBXFtotAbuyxH
	kwblbeWpqXF5WJGenH4Jfw27jRjE9/UN+kYA0ZNpOI6hSCGk19HD
X-Google-Smtp-Source: AGHT+IFTeMnxuvqptJw+GyDeR4/vlSyUN/k/RyKrPTCZ736yAnYaqtZMG9eELn+gCdAH+s3MSe+vmA==
X-Received: by 2002:a17:902:f54b:b0:1fb:81ec:26e5 with SMTP id d9443c01a7336-2009526cdd0mr4597165ad.28.1723079248794;
        Wed, 07 Aug 2024 18:07:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f60abesm112666425ad.113.2024.08.07.18.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 18:07:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net>
Date: Wed, 7 Aug 2024 18:07:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87frrh44mf.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 16:24, Thomas Gleixner wrote:
> Cc+: Helge, parisc ML
> 
> We're chasing a weird failure which has been tracked down to the
> placement of the division library functions (I assume they are imported
> from libgcc).
> 
> See the thread starting at:
> 
>    https://lore.kernel.org/all/718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net
> 
> On Tue, Aug 06 2024 at 21:25, Vlastimil Babka wrote:
>> On 8/6/24 19:33, Thomas Gleixner wrote:
>>>
>>> So this change adds 16 bytes to __softirq() which moves the division
>>> functions up by 16 bytes. That's all it takes to make the stupid go
>>> away....
>>
>> Heh I was actually wondering if the division is somhow messed up because
>> maxobj = order_objects() and order_objects() does a division. Now I suspect
>> it even more.
> 
> check_slab() calls into that muck, but I checked the disassembly of a
> working and a broken kernel and the only difference there is the
> displacement offset when the code calculates the call address, but
> that's as expected a difference of 16 bytes.
> 
> Now it becomes interesting.
> 
> I added a unused function after __do_softirq() into the softirq text
> section and filled it with ASM nonsense so that it occupies exactly one
> page. That moves $$divoI, which is what check_slab() calls, exactly one
> page forward:
> 

With the above added to my tree, I can also play around with the code.
Here is the next weird one:

diff --git a/mm/slub.c b/mm/slub.c
index 4927edec6a8c..b8a33966d858 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1385,6 +1385,9 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
         }

         maxobj = order_objects(slab_order(slab), s->size);
+
+       pr_info_once("##### slab->objects=%u maxobj=%u\n", slab->objects, maxobj);
+
         if (slab->objects > maxobj) {
                 slab_err(s, slab, "objects %u > max %u",
                         slab->objects, maxobj);

results in:

##### slab->objects=21 maxobj=21
=============================================================================
BUG kmem_cache_node (Not tainted): objects 21 > max 16

As Thomas noticed, this only happens if the divide assembler code is within a certain
address range.

Ok, now I am really lost.

Guenter


