Return-Path: <linux-kernel+bounces-280262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A36594C7D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4623E285A74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6076748D;
	Fri,  9 Aug 2024 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFxpE4Pb"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0D3234;
	Fri,  9 Aug 2024 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165023; cv=none; b=Vsvwkuj2kHlo6Tk+yH1L+kxJwNkkoP91UcRlBFXdctdvzIHc2/B1r3UrKBYUi8aGRRkVMyK64FWBl6/AM4xl/o/Vy+3PQKqonowvrZk9LVniZE3BSE1zAeYcIeEcG19hBY35lRbB8B1eXNpMYZTmVF2ymlcVA7HQoz2+cmCqGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165023; c=relaxed/simple;
	bh=Ct+GAEbmVw8DHS8pkEG9e7/dPqGUNuVj6GVT8lA9arA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iF2xfoRHtVoBhoWpZ8cQCfdCJFEVbZciTG4qMYRcacq640BtXb4EqCUU7TdASJCCa9+4BpRe1evT/t7YPZLXYGKZkcnaMcDo6ulQsB/lgxp/tzWIoOIObR/nCDNVKGaMlDfS4YI0qoRckOKwRzE7uF7BLCnQaGWpYYvwXb18TLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFxpE4Pb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso1342296b3a.1;
        Thu, 08 Aug 2024 17:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723165022; x=1723769822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/MtvB8mjyzu2IoB2Ws5JzlodQoFeEGwt1Z17iJ76PG0=;
        b=XFxpE4Pb/zOBPmhXEBOXghNrA/y3amVsK86dC9S25aAOnN9MA9wpXwAMfSBjKiGa6M
         GaXUfPdiFt576xIVqn/OYGErckvKdDwpf9U3IP/fbIL0xhYIYT+zmvunypYAS1elz8Vj
         XMNOuelPD87JMj2yRXksa0WNrIemDWiqn9tTxSxqhIst3aAxJZxMIj6JwBRZAhHSeZLn
         o0898SCuh2ZlWIeHAnYL6iUOPK+RRf9wWSKcWfes6Ih0cbF1bBYuKnjuMS4keDtc/9jt
         2tY0O1Q0vlwk6S++/mrD4fKyMvcNb4YW/HI0ex1ptLML+8NUO0J1EZzryJUwm2Xx0qrp
         fRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723165022; x=1723769822;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MtvB8mjyzu2IoB2Ws5JzlodQoFeEGwt1Z17iJ76PG0=;
        b=qu4LxMtfBN0zmHfVxtNUeV1pWhReus2A5cjIt21HmbwCrSyoxw+XCHIkER4ypPdk8G
         ubKpygwsWfGsQsSpdZ6CgQSTFt8/ngOizWS0r++osg1VWhnILwPFrqaLLinf2t838KTw
         eT9gP3QV4iH8CuJiDu8A8tfsZM9CF269QAvq3c8mYLcUEm7i6Cy77A8+G0UPYa1u1tXl
         kPbHSKTztdnv3eGQOUJrwR2gReBGPlvldRrO26BIBi6UNid7J+haFtkgNniQYW52acDv
         UAmDK63dXBdJ/mBZ+zL8ti2eAugrz4IVSyanHb++Es+YRacf2vBOaGgmzl9qqtJITHSV
         /sVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFkmwb/fcM5s7+r5hSWiY3kWXYrL9sCZSfw/YipaFJHHKSlVlNwLU9s1Py5lMSSi0zroZJAD7gYYAb2W1vbnEqrabK7/8RXMe2YsEgQlJPXxVS/QJCW+0GuwPQs16UrfdWpxV1Ou8hWNks
X-Gm-Message-State: AOJu0YwlKWMuSKF2YXtttgXU6yEay4CLNkA8tRmocHqZQxhKMbbm3NGt
	AVH4K5wHuA2hV0Llrz3qqKlv4uGB6HuzcgNDv5ow8A6F5qblTbsB
X-Google-Smtp-Source: AGHT+IFa9dMA8ylmc3SMI3EP4zQBbdjANMaHmDwgkP4r781TOsixfKKB97oJTKnj1Z4UkHWEmiFgew==
X-Received: by 2002:a05:6a00:91e4:b0:70d:2ba1:2402 with SMTP id d2e1a72fcca58-710cae7a5bcmr4056210b3a.29.1723165021529;
        Thu, 08 Aug 2024 17:57:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb209fe9sm1686717b3a.42.2024.08.08.17.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 17:57:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <41080afd-86ab-4dc1-9c9f-eef4701692e0@roeck-us.net>
Date: Thu, 8 Aug 2024 17:56:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: John David Anglin <dave.anglin@bell.net>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
 <87a5hnyox6.ffs@tglx>
 <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
 <8734nezz0g.ffs@tglx>
 <CAHk-=wiZUidi6Gm_6XFArT621H7vAzhDA63zn2pSGJHdnjRCMA@mail.gmail.com>
 <eba27c56-dc36-4410-bb6b-cbe8769b8a6d@roeck-us.net>
 <ac7284f9-ba29-4068-ab00-82ddc839afaf@bell.net>
 <37f94771-4ebc-46d2-ad10-f145d139dd9d@bell.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <37f94771-4ebc-46d2-ad10-f145d139dd9d@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/24 15:29, John David Anglin wrote:
> On 2024-08-08 5:50 p.m., John David Anglin wrote:
>> The mode likely problem is the shladd instruction in the following macro in entry.S:
>>
>>         .macro          L2_ptep pmd,pte,index,va,fault
>> #if CONFIG_PGTABLE_LEVELS == 3
>>         extru_safe      \va,31-ASM_PMD_SHIFT,ASM_BITS_PER_PMD,\index
>> #else
>>         extru_safe \va,31-ASM_PGDIR_SHIFT,ASM_BITS_PER_PGD,\index
>> #endif
>>         dep             %r0,31,PAGE_SHIFT,\pmd  /* clear offset */
>> #if CONFIG_PGTABLE_LEVELS < 3
>>         copy            %r0,\pte
>> #endif
>>         ldw,s           \index(\pmd),\pmd
>>         bb,>=,n         \pmd,_PxD_PRESENT_BIT,\fault
>>         dep             %r0,31,PxD_FLAG_SHIFT,\pmd /* clear flags */
>>         SHLREG          \pmd,PxD_VALUE_SHIFT,\pmd
>>         extru_safe      \va,31-PAGE_SHIFT,ASM_BITS_PER_PTE,\index
>>         dep             %r0,31,PAGE_SHIFT,\pmd  /* clear offset */
>>         shladd          \index,BITS_PER_PTE_ENTRY,\pmd,\pmd /* pmd is now pte */
>>         .endm
>>
>> I believe the shladd instruction should be changed to shladd,l (shift left and add logical).
> diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
> index ab23e61a6f01..1ec60406f841 100644
> --- a/arch/parisc/kernel/entry.S
> +++ b/arch/parisc/kernel/entry.S
> @@ -399,7 +399,7 @@
>       SHLREG        \pmd,PxD_VALUE_SHIFT,\pmd
>       extru_safe    \va,31-PAGE_SHIFT,ASM_BITS_PER_PTE,\index
>       dep        %r0,31,PAGE_SHIFT,\pmd  /* clear offset */
> -    shladd        \index,BITS_PER_PTE_ENTRY,\pmd,\pmd /* pmd is now pte */
> +    shladd,l    \index,BITS_PER_PTE_ENTRY,\pmd,\pmd /* pmd is now pte */
>       .endm
> 
>       /* Look up PTE in a 3-Level scheme. */
> 
> Boots okay.  Fixing the addi instruction is harder and it would take some time to test.
> 

Odd, it doesn't help for me. Does it crash for you without the above change ?
Or, in other words, is divI at the objecting location ?

Guenter



