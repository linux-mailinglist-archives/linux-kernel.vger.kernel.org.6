Return-Path: <linux-kernel+bounces-279683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6951794C06D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC253B27D6F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233C74055;
	Thu,  8 Aug 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBXSPy6R"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55D18C925;
	Thu,  8 Aug 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129198; cv=none; b=XrVH1ba03bz6EbjkEuYAD+RXWP5p2+jXrjcyawS6pLUCPCQBu5Xoc65GdJuiuKRtj6aWEapVH+Ckv3DSz7f2iWx81GGl1tAbstlCJCFXVOKCpvEA6TcTzxf8KtHhWueXyacfZTHir+vLAvn/jyaP0XIqPusBLCJbDRO40ueZzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129198; c=relaxed/simple;
	bh=1igJfdwsjCHDbyKySsYHDdYZcMmZsd28TOXC6bXDbzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFYP+lHaYycm11nq0711sQRNW/8RONNm2F/HXD3HBE4I7bnDSHGdAa0a0hrUxsJaySsir9TOPxbumeiC1RUwbAtimoi3jLFwnVmzplKh3YfqViRE3unLu+84nh9gtWOYmM1t6wg5RiwG5s1u9q1wqJeX9GxgKCOCcV8M0kVXbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBXSPy6R; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7a130ae7126so732946a12.0;
        Thu, 08 Aug 2024 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723129195; x=1723733995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gh+JvkdvHNoI2rD3xS4hC7Rs6IiuVind2EuXNbZxt1o=;
        b=WBXSPy6R8j77T3hfPzxzWwM/oQgasLVbEFmCd2AfJVVQvEGNsEXYCHfWik3qB4AO9j
         CA7cIeM4v2vMYg5oT/1zGuTOk/f02C/zXgGJHrOOJ5pMeJGv9SDd0GEj3PDzDutmmdc2
         cXqUc49QzfQHfiNwSoWuRI3Qvv6PFr8n0ErYJ4GJAME2Ah9G2Qi6fDehs7ne+5+GoJDV
         2p6KrotgEDYWI2gqtjQgvIsx5UyijYjAK6cSdc294MnMXg/uwEaFDcjZqR/rM5u9u4Rr
         OjOUj8SrLVR4yuwOOoosxMy4rnOQ6C0R1v6d6o3FbHPSfrq5I7z2y3rKVT4XGfLITq/q
         y5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129195; x=1723733995;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh+JvkdvHNoI2rD3xS4hC7Rs6IiuVind2EuXNbZxt1o=;
        b=mVjpuhIqnn6fT1Lc0mp/fz9bnCwDDnUqDiuSm5TXygbD8GK1cVw98SBqm6vrUFZaNL
         AwiTdGskezommf+FCPqfqZaD5lZAhJJ/0nM3xKQ2w2NAve0fZB7/aPzHpwgNHkvKDUoX
         dETX/irwtxqoafiUGVoiy2yXIisUgG35zEBEZ0ts6E+mi1SMWy5UjdGh94/XDh8eM+h1
         ykElkPugjM8l7BdjsB1qdiAjKUaDuqtbFzzfxE7S8Wzqxpy71NWTofkWosSDm/oaU3/1
         dQg3G5aw8JvJEcsQXS0uKGnoQOZBbDtUGaGP2X1HKNH0Jg1LqR6TUoPIoSap5ZDlW7Se
         ntCA==
X-Forwarded-Encrypted: i=1; AJvYcCUKjDGy7jI8MHj5kIoUfVxcapqQ1OryzItGsw65t6LVKCA+J2UJH2y4bhPV+C2KYSzoSS13N8xmJIpgacvupQOt9Il6ygs7mqoCT72Q
X-Gm-Message-State: AOJu0YxIhfp7MRtavilSRO4ebZFhJhowEIZbrGZXvijVPcOlBFcxp3Q4
	LYcehOSohLjBnH36xXP4zuIaTJQpYJvmTwpj6CGxfgPfX6KnBsNq
X-Google-Smtp-Source: AGHT+IHPox+Jt1U8HZESTQB6s84+28+1zEFSBUEgm7SS88d68FTa0hgotmZP76stcdGTAAyeMODMag==
X-Received: by 2002:a17:90b:4d8c:b0:2cf:eaec:d756 with SMTP id 98e67ed59e1d1-2d1c339ee96mr2525158a91.12.1723129195380;
        Thu, 08 Aug 2024 07:59:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c5dbaesm1233034a91.10.2024.08.08.07.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 07:59:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cffe30ed-43a3-46ac-ad03-afb7633f17e5@roeck-us.net>
Date: Thu, 8 Aug 2024 07:59:53 -0700
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
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87plqjz6aa.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 02:57, Thomas Gleixner wrote:
> On Wed, Aug 07 2024 at 18:07, Guenter Roeck wrote:
>> On 8/6/24 16:24, Thomas Gleixner wrote:
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
> Careful vs. the pr_once(). It's not necessarily the first allocation

Yes. Thanks for pointing that out. Rookie mistake :-(.

> which trips up. I removed slab_err() in that condition and just printed
> the data:
> 
> [    0.000000] Order: 1 Size:  384 Nobj: 21 Maxobj: 16 21 Inuse: 14
> [    0.000000] Order: 0 Size:  168 Nobj: 24 Maxobj: 16 24 Inuse:  1
> [    0.000000] Order: 1 Size:  320 Nobj: 25 Maxobj: 16 25 Inuse: 18
> [    0.000000] Order: 1 Size:  320 Nobj: 25 Maxobj: 16 25 Inuse: 19
> [    0.000000] Order: 1 Size:  320 Nobj: 25 Maxobj: 16 25 Inuse: 20
> [    0.000000] Order: 0 Size:  160 Nobj: 25 Maxobj: 16 25 Inuse:  5
> [    0.000000] Order: 2 Size:  672 Nobj: 24 Maxobj: 16 24 Inuse:  1
> [    0.000000] Order: 3 Size: 1536 Nobj: 21 Maxobj: 16 21 Inuse:  1
> [    0.000000] Order: 3 Size: 1536 Nobj: 21 Maxobj: 16 21 Inuse:  2
> [    0.000000] Order: 3 Size: 1536 Nobj: 21 Maxobj: 16 21 Inuse: 10
> 
> The maxobj column shows the failed result and the result from the second
> invocation inside of the printk().
> 
> Let's wait for PARISC people to run it on actual hardware.
> 

Agreed. I suspect that there is a carry or upper 32 bit of a register not
handled properly, but I have no idea where that might be or why that would
only be seen if the div functions are located in a certain address range.

Thanks,
Guenter


