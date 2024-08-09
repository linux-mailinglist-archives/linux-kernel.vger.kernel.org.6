Return-Path: <linux-kernel+bounces-280259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F794C7C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041A21F23AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 00:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C77523A;
	Fri,  9 Aug 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGBtPYe9"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C0E38C;
	Fri,  9 Aug 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164638; cv=none; b=VOvtBS+tnz/jwc0QCtzojj9ehbZHgwwKvw5vwvFYdZU61gAGUSaAZN+BYFCSUIDqGLJe09N34zrcl1sJ5RWaGEOVjYL4Ma9NJdiMf9o9MpB3o1z4fqcxQDSx5g5nqkO+834aO8n32NeW76RbY4SbG94nB0zvC8ucBeY4mBJKsbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164638; c=relaxed/simple;
	bh=7r3kXadAWRrHvNlRq9eymn+F9m1ycAj5DGd1WGHHwng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sO9vUSKT1p6TRvWujIgTd7Bratdca5Y/mMQxvqejODwHnAeIWfr1FkbGHZ4zCpdkLLmUjmPgwgwyrLCJzsCGv3H9e9LFxa2juffkJtVt1lC57vtkkhI2+fOuIcRL/yMTqaU3toh+sdlLwF9B5T/h1PsJxQitmqjNHfLeEra+ghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGBtPYe9; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1000246a12.0;
        Thu, 08 Aug 2024 17:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723164636; x=1723769436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XRmm2092B9I+czSGQLTLNg6rXkyYZ0X8PsIRu9Zj0hk=;
        b=OGBtPYe9VAWuRJ01EP0VshxbGei7q8xhytNXZs7D1EhslJK/NuqJHRic+lGN36jyn2
         4TLk94VhxTlB9/4l5l8AA3d+/bVUTog9Q0Y+WVwsyvYAcdmp6zzrkcx+Eirpw/q+QUQ9
         AecgEfRd1d421o53SLvEOGjpxRE9HeKwuMVOl0rlTS8vc2dKPU8WjqydjI1xCISF3HwF
         sJffLJV7cpmwtLVSRZHN+73YakIR0LBmch5F8JesMZR+nCc1Kaeyby/VnJ76RQjP979X
         Ms0xZl1aSCQHlv94ZYe5k3qUXsU+bSPMQp8t6zaGkubQw+ddSZli0hF8xu4jQIhFkbUf
         smtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164636; x=1723769436;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRmm2092B9I+czSGQLTLNg6rXkyYZ0X8PsIRu9Zj0hk=;
        b=qkqxwi/hZPLyP6+ElfPh+xk260azQInO1af/RyKZA9Rbu4x1FDBdwvrTDlBrysx4Re
         Dre+u1e/+vGoGz9j8KNMb+Q0dfAdIxX9N5ItOfA821xeEzySP2wenUYyEpe4KpLQMtSF
         cNesxNfogkPh9QaaYSK4j/eizWFSh7PprK4CpoK0PC93SdC55fwRCm0HTj+yi4Z0qY1+
         oKgpij4R7FjsQX6ixM0rga5BJg/j3amtnH9dVk448B8gzInF6y8iqi5Vy3zpNgVN66ab
         xA5rHqWu2yZYXJ71mwGwFu2pMgoXV2dPYvu+6cx5i7vZhJk7ESr+KF2+XA+V7NbFTmJ/
         70qw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Tx3vo9wVP/XNJtkOGp8Z24LIeb8uRCy51cpRXKZwe+osKpKgAMfY/Us8gS0ZZu1WIAMe2o+Qf8/E29Q6eRhtUbTqLn/H8Owfb+8vWLLzk409a9eQWawlTEcKyKPjMQsG9c94eB6fp98y
X-Gm-Message-State: AOJu0YxXXSwDtnu9gJCZ6SHiEyD9if36zxO68rf0ua0ZBH9Dyb9ig/C7
	hk5EdSo5r/Kaead/rTPKurskFbrafUYgIwDNy0MVfQfL7m010awl
X-Google-Smtp-Source: AGHT+IEWSyKVWUAv3lBEOIVOVeGZXhieT11SQEcNJhGufwvPMX8HuPyit9dqb1eDxDVkJMuTlkUOMA==
X-Received: by 2002:a17:90b:390c:b0:2ca:8684:401a with SMTP id 98e67ed59e1d1-2d1c3461395mr4140870a91.32.1723164635674;
        Thu, 08 Aug 2024 17:50:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c7ad06sm1775981a91.14.2024.08.08.17.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 17:50:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <314821a5-43e1-4c96-ad8d-188bca8ae0a1@roeck-us.net>
Date: Thu, 8 Aug 2024 17:50:32 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ac7284f9-ba29-4068-ab00-82ddc839afaf@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/24 14:50, John David Anglin wrote:
> On 2024-08-08 4:52 p.m., Guenter Roeck wrote:
>> On 8/8/24 11:19, Linus Torvalds wrote:
>>> On Thu, 8 Aug 2024 at 10:48, Thomas Gleixner <tglx@linutronix.de> wrote:
>>>>
>>>> Here is the disassembly from my latest crashing debug kernel which
>>>> shifts it up a couple of pages. Add 0x10 or sub 0x20 to make it work.
>>>
>>> Looks like I was off by an instruction, it's the 28th divide-step (not
>>> 29) that does the page crosser:
>>>
>>>>      4121dffc:   0b 21 04 41     ds r1,r25,r1
>>>>      4121e000:   0b bd 07 1d     add,c ret1,ret1,ret1
> I think this macro might clobber the C/B bits on a ITLB missing:
> 
>          /* This is for ILP32 PA2.0 only.  The TLB insertion needs
>           * to extend into I/O space if the address is 0xfXXXXXXX
>           * so we extend the f's into the top word of the pte in
>           * this case */
>          .macro          f_extend        pte,tmp
>          extrd,s         \pte,42,4,\tmp
>          addi,<>         1,\tmp,%r0
>          extrd,s         \pte,63,25,\pte
>          .endm
> 
> The addi instruction affects the C/B bits.  However, it is only used for 32-bit PA 2.0 kernels.
> A second tmp register would be needed to change the addi to an add logical.
> 
> The mode likely problem is the shladd instruction in the following macro in entry.S:
> 
>          .macro          L2_ptep pmd,pte,index,va,fault
> #if CONFIG_PGTABLE_LEVELS == 3
>          extru_safe      \va,31-ASM_PMD_SHIFT,ASM_BITS_PER_PMD,\index
> #else
>          extru_safe \va,31-ASM_PGDIR_SHIFT,ASM_BITS_PER_PGD,\index
> #endif
>          dep             %r0,31,PAGE_SHIFT,\pmd  /* clear offset */
> #if CONFIG_PGTABLE_LEVELS < 3
>          copy            %r0,\pte
> #endif
>          ldw,s           \index(\pmd),\pmd
>          bb,>=,n         \pmd,_PxD_PRESENT_BIT,\fault
>          dep             %r0,31,PxD_FLAG_SHIFT,\pmd /* clear flags */
>          SHLREG          \pmd,PxD_VALUE_SHIFT,\pmd
>          extru_safe      \va,31-PAGE_SHIFT,ASM_BITS_PER_PTE,\index
>          dep             %r0,31,PAGE_SHIFT,\pmd  /* clear offset */
>          shladd          \index,BITS_PER_PTE_ENTRY,\pmd,\pmd /* pmd is now pte */
>          .endm
> 
> I believe the shladd instruction should be changed to shladd,l (shift left and add logical).
> 

That doesn't help, at least not in qemu.

Guenter


