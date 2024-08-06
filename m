Return-Path: <linux-kernel+bounces-276716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D09D2949762
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB381F22A80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD7A757F8;
	Tue,  6 Aug 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsIvHt8r"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7627347C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968000; cv=none; b=PSIToPj0qLxv+TfvATafrzlBAAPPJf2n7YW1IopinBG8asdGcesPBEymi/BHqgGuH250ElzNFBMqwihQV9C7VUtPX0TtfdLiYkB/YS/nGzZVqE/Rr5jIfgZmc58yNn09nUdjjtykzNvpZAh04WAkdepj3/oHfwUFHiA20Gva000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968000; c=relaxed/simple;
	bh=SKA93kc7/6Vcrgb+uNK+1/D4JR7TOhxQkpd182f0/Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldRNa5pAHfCR0vn5fAe3KdmRDpQRu6LaGeBIYBgr1wqhiiAPSI5K1rPXXk/BDqZH4gdWN5h15YciSpCoFf5oqkzTYIlGZ0mZjFXndr8YbkH5SoFx4CA2J8ouVvFS62KH4dHVEWX/kjMgvqLwB0A45tpOziGTPswp4sHF9D/EEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsIvHt8r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc47abc040so7902345ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722967998; x=1723572798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cq0kclEXcZ4mwuoCTY3vV9LPwob25sqXzW6IIBvEd8=;
        b=ZsIvHt8rvaxQg+w6E24JWUs2edQpRrSTdLXpBc6DFBjykHtOxRpM9i5gMxClxoxWlM
         pYJ31eis8r/FmmdGFvj0rjgOCWomiMKkavyTNdTkUPXpPNV36cjQ4ZKrWT+zVpeIClnz
         4Or84rQJnOJw04nWu0auvSkpE6ezEWlhj32zWp346rvTkBEkOEXdmD2xMDr/1RG//p7L
         6u4QC2Tibndq4iLlMNJQzHqtxA60rY20hpFjDEruRvos9E7AHGOLtVfIZQTuTeiuWxlY
         5SK57avfB8spSaa5DwXPuQLMnrUMy0xcmASvdy7g3Rq7uw62vEiKXFYuquKe56qD+wev
         u2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967998; x=1723572798;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Cq0kclEXcZ4mwuoCTY3vV9LPwob25sqXzW6IIBvEd8=;
        b=bkXMTsWspsaaw8pPyr667984fSHz2v3YbhSvYdojlLSG69XzTgzioqEYe2i/5k412K
         7oCHh/K0LECkdtY1mm8lblYW5mtfMxKQSuFPr6JzygUhbA2Gs+d6StoT2gQHjOJomg1Q
         q08Z8ovBqbE0c5NopsNhcsFhiehlXUsXQaTuqZlaK89BQe/+Ac6UEOgIHho9dmEdB133
         B2lCMOXRRAKXI3oVAgqxeJfcmo73W/9yQOYQ2E8lQgHKoT6UArgJhqVnTSzrZwAVh3Qq
         DkmidGoX/29kaF+vWU8TK1+gw93a4KzFgo2H95DekNt6PUIVNX8PNSfbI4KIVg0q0w7Z
         Rz4g==
X-Forwarded-Encrypted: i=1; AJvYcCXZiJbs2M0qch91fKbtTzmh8M6rh3VJ9tQsKik6Ep8jmBj6XgFjRFTUShs1LJmn60EKA6COxJ2VaI4Iq8NfXub+ab5BxjkH2l26/wmO
X-Gm-Message-State: AOJu0YzoIxyZmKw8NikCHhG9z3mgn9vq4fy4349QhJ8zQXr3opoDTBPt
	wuDccOVln5LVeat+e5HALP+NKvaVsf7pLbI1b3f3sJHVV0FWMpPa
X-Google-Smtp-Source: AGHT+IH15byq0DnCQmOBuJml3Na4zuoA+2WeeR6+TMs3twaUnB7rNp8J/kn6DfWmND0lhYDALpCgLA==
X-Received: by 2002:a17:902:ecc2:b0:1fb:fc96:757e with SMTP id d9443c01a7336-1ff5730969emr158069805ad.37.1722967998322;
        Tue, 06 Aug 2024 11:13:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178bcdsm90357285ad.213.2024.08.06.11.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 11:13:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3a706169-9fce-48a0-b808-37f347a65a25@roeck-us.net>
Date: Tue, 6 Aug 2024 11:13:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>
 <f63c6789-b01a-4d76-b7c9-74c04867bc13@roeck-us.net>
 <CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com>
 <CAHk-=wiss_E41A1uH0-1MXF-GjxzW_Rbz+Xbs+fbr-vyQFpo4g@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHk-=wiss_E41A1uH0-1MXF-GjxzW_Rbz+Xbs+fbr-vyQFpo4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 10:49, Linus Torvalds wrote:
> [ Adding s390 people, this is strange ]
> 

Did I get lost somewhere ? I am seeing this with parisc (64 bit), not s390.

Thanks,
Guenter

> New people, see
> 
>    https://lore.kernel.org/all/CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com/
> 
> for context. There's a heisenbug that depends on random code layout
> issues on s390.
> 
> On Tue, 6 Aug 2024 at 10:34, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Hmm. Do we have some alignment confusion?
>>
>> The alignment rules for 192 are to align it to 64-byte boundaries
>> (because that's the largest power of two that divides it), and that
>> means it stays at 192, and that would give 21 objects per 4kB page.
>>
>> But if we use the "align up to next power of two", you get 256 bytes,
>> and 16 objects per page.
>>
>> And that 21-vs-16 confusion would seem to match this pretty well:
>>
>>    [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
>>
>> which makes me wonder...
> 
> I'd suspect commit ad59baa31695 ("slab, rust: extend kmalloc()
> alignment guarantees to remove Rust padding"), perhaps with some odd
> s390 code generation issue for 'ffs()'.
> 
> IOW, this new code in mm/slab_common.c
> 
>          if (flags & SLAB_KMALLOC)
>                  align = max(align, 1U << (ffs(size) - 1));
> 
> might not match some other alignment code.
> 
> Or maybe it's the s390 ffs().
> 
> It looks like
> 
>    static inline int ffs(int word)
>    {
>          unsigned long mask = 2 * BITS_PER_LONG - 1;
>          unsigned int val = (unsigned int)word;
> 
>          return (1 + (__flogr(-val & val) ^ (BITS_PER_LONG - 1))) & mask;
>    }
> 
> where s390 has this very odd "flogr" instruction ("find last one G
> register"?) for the non-constant case.
> 
> That uses a "union register_pair" but only ever uses the "even"
> register without ever using the full 128-bit part or the odd register.
> So the other register in the register pair is uninitialized.
> 
> Does that cause random compiler issues based on register allocation?
> 
> Just for fun, does something like this make any difference?
> 
>    --- a/arch/s390/include/asm/bitops.h
>    +++ b/arch/s390/include/asm/bitops.h
>    @@ -305,6 +305,7 @@ static inline unsigned char __flogr(unsigned long word)
>                  union register_pair rp;
> 
>                  rp.even = word;
>    +             rp.odd = 0;
>                  asm volatile(
>                          "       flogr   %[rp],%[rp]\n"
>                          : [rp] "+d" (rp.pair) : : "cc");
> 
> 
> Thomas notices that the special "div by constant" routines moved
> around, and I'm not seeing how *that* would matter, but it's all
> obviously very strange.
> 
>                Linus


