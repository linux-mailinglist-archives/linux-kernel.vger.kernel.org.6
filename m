Return-Path: <linux-kernel+bounces-286153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3F195174D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0C71F22DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA4C143894;
	Wed, 14 Aug 2024 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nn/WfnZV"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0036134
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626385; cv=none; b=Md3IupkwSOHwmPjeRD4i1oXvaqBHhc7fHNo8u5Y56K0S5W8BuJQIeQ40RRwFd4jbJxExTq66jSw/lrodBriyLxts/9tnfvCGHK+y8eJblaBImVMz8c6UXFnHMVPDbVJUDBuckWsZTmzL0DPrDHESFJLUSfNuUAN2NOmPV/ivgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626385; c=relaxed/simple;
	bh=JUtgBu4yU1wRU6u7RGcuzLv2lbpPmBXamrXJzSFuxLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r28P59+arlnb/afloGfOEBh9HqiL+aT9qJL/q130TIDNKgKOKTpzJLGpAhTnXF36kyLwk2Bnr2WX6pCrxq87upz06Ud97biXz9obaFJrZutrrk/1TuqOidQQck4Bat6PZ/EeK85/OwW3FSFtIdF3RBsWkZ+qM2gkG2qK0i4IsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nn/WfnZV; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81fe38c7255so377950239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723626383; x=1724231183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6SQXbmHlAnUU8CoNxf84rYVf5mFcg+jyOBse78TzCg=;
        b=nn/WfnZVvxKBthnggwITUR9ZXyUFvLWI5gWowCMm/bLdKBR/MYblSBf9GlO8KKZPT0
         963EYsbZHHPIpgSQlQ7PL6vZnJfHl7a72yVJei34aoQdYWD7zP7ccU9Ke0CJokkKKcnZ
         O1pXtKr5tZQCx2p18GyG7q34fD4IOa2+06KWf3FYRgvfdudP1h39A6VsP71izpebBaU+
         BpqB/oWzyhjA80BlDZdzYPG6Mm0MwYuIdBHu47hNsrP8Sxx556tcmT17gajEJQbt6iIH
         9fm9GEn6+Y81j9EEKEsglMBzsyo7E3Tu/BI63txu0E4Up9K9K80XyquLA2emccWWDRj6
         LBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626383; x=1724231183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6SQXbmHlAnUU8CoNxf84rYVf5mFcg+jyOBse78TzCg=;
        b=KLho/NeDO1SPSllCWZnDqwcnlMhnPBjbsfcmY5PGxCYjyhnCKHIzh1pktEmFmMkrt4
         uDkxMCuHHcIiomeeEDZ7bfhW2UvIP8q5OHu81Sfohht4cSbHg0yfQ3gsiFfrtsmH2L4k
         iCEiMLqvtoe3ZQSYbz+UW/qq84NheWiXWR+dd/feRSojzJTi82AH2/5kGoE9K9ZQGIU1
         y4cSyQ58/zGM5XON6P1iLqQybmXpWcuGdN6BHv/SO94o7bRvAYfXFFG+QnCdFQtblKcq
         e1lYYFnIZraBNbrtIlAAkrU0zpFWYQ6UThkgw+b5jsFdw4OdHXjVcAYyy2Oy07cxUb6I
         ueNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNMnyewU/efkPRH/PT6v4XIkZyRAVHWidowqLDeiTTk5Kk8dO3ddXNjk54uISOkatRoHJUW8xGZKj0NieVYsPopsp+EFfew0j2ML6A
X-Gm-Message-State: AOJu0YzEiCG7kEWz4iT4U6ZxZ3ZxXOFiya6xxu4C6wlkJShU/CWqgOos
	wgfKfTPgl0UmgRTItmX9JwhAzS6EA5wRo3TyH11LuPsKMeSvPYTqkwRjh9ZNau8=
X-Google-Smtp-Source: AGHT+IEcuNT8XUtX1as+8eGOWzzUUZRDmIGV41Y9+N82sEFGMuSDBVxFjSYrjFZ72fjKLzTbwN40QA==
X-Received: by 2002:a05:6602:14c6:b0:806:560:92b5 with SMTP id ca18e2360f4ac-824dad7c853mr238518039f.11.1723626383064;
        Wed, 14 Aug 2024 02:06:23 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8226720d2a0sm324849939f.2.2024.08.14.02.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 02:06:22 -0700 (PDT)
Message-ID: <8694fc12-dcd0-45d6-acf7-ab44b9e310bc@sifive.com>
Date: Wed, 14 Aug 2024 04:06:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: Omit optimized string routines when using
 KASAN
To: Alexandre Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
References: <20240801033725.28816-1-samuel.holland@sifive.com>
 <20240801033725.28816-2-samuel.holland@sifive.com>
 <e935d5a3-1754-422c-aa92-08977ab9c929@ghiti.fr>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <e935d5a3-1754-422c-aa92-08977ab9c929@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 2024-08-01 5:26 AM, Alexandre Ghiti wrote:
> Hi Samuel,
> 
> On 01/08/2024 05:36, Samuel Holland wrote:
>> The optimized string routines are implemented in assembly, so they are
>> not instrumented for use with KASAN. Fall back to the C version of the
>> routines in order to improve KASAN coverage. This fixes the
>> kasan_strings() unit test.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>   arch/riscv/include/asm/string.h | 2 ++
>>   arch/riscv/kernel/riscv_ksyms.c | 3 ---
>>   arch/riscv/lib/Makefile         | 2 ++
>>   arch/riscv/lib/strcmp.S         | 1 +
>>   arch/riscv/lib/strlen.S         | 1 +
>>   arch/riscv/lib/strncmp.S        | 1 +
>>   arch/riscv/purgatory/Makefile   | 2 ++
>>   7 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
>> index a96b1fea24fe..5ba77f60bf0b 100644
>> --- a/arch/riscv/include/asm/string.h
>> +++ b/arch/riscv/include/asm/string.h
>> @@ -19,6 +19,7 @@ extern asmlinkage void *__memcpy(void *, const void *, size_t);
>>   extern asmlinkage void *memmove(void *, const void *, size_t);
>>   extern asmlinkage void *__memmove(void *, const void *, size_t);
>>   +#if !(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
> 
> 
> We do not support KASAN_SW_TAGS so there is no need for this #ifdef.

I just sent an RFC implementation of KASAN_SW_TAGS[1] (which you wouldn't have
known I was working on at the time :) ). Since these changes will be needed for
both modes, it made sense to me to go ahead and cover both at once.

Regards,
Samuel

[1]: https://lore.kernel.org/all/20240814085618.968833-1-samuel.holland@sifive.com/

>>   #define __HAVE_ARCH_STRCMP
>>   extern asmlinkage int strcmp(const char *cs, const char *ct);
>>   @@ -27,6 +28,7 @@ extern asmlinkage __kernel_size_t strlen(const char *);
>>     #define __HAVE_ARCH_STRNCMP
>>   extern asmlinkage int strncmp(const char *cs, const char *ct, size_t count);
>> +#endif
>>     /* For those files which don't want to check by kasan. */
>>   #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
>> diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
>> index a72879b4249a..5ab1c7e1a6ed 100644
>> --- a/arch/riscv/kernel/riscv_ksyms.c
>> +++ b/arch/riscv/kernel/riscv_ksyms.c
>> @@ -12,9 +12,6 @@
>>   EXPORT_SYMBOL(memset);
>>   EXPORT_SYMBOL(memcpy);
>>   EXPORT_SYMBOL(memmove);
>> -EXPORT_SYMBOL(strcmp);
>> -EXPORT_SYMBOL(strlen);
>> -EXPORT_SYMBOL(strncmp);
>>   EXPORT_SYMBOL(__memset);
>>   EXPORT_SYMBOL(__memcpy);
>>   EXPORT_SYMBOL(__memmove);
>> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
>> index 2b369f51b0a5..8eec6b69a875 100644
>> --- a/arch/riscv/lib/Makefile
>> +++ b/arch/riscv/lib/Makefile
>> @@ -3,9 +3,11 @@ lib-y            += delay.o
>>   lib-y            += memcpy.o
>>   lib-y            += memset.o
>>   lib-y            += memmove.o
>> +ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
>>   lib-y            += strcmp.o
>>   lib-y            += strlen.o
>>   lib-y            += strncmp.o
>> +endif
>>   lib-y            += csum.o
>>   ifeq ($(CONFIG_MMU), y)
>>   lib-$(CONFIG_RISCV_ISA_V)    += uaccess_vector.o
>> diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
>> index 687b2bea5c43..542301a67a2f 100644
>> --- a/arch/riscv/lib/strcmp.S
>> +++ b/arch/riscv/lib/strcmp.S
>> @@ -120,3 +120,4 @@ strcmp_zbb:
>>   .option pop
>>   #endif
>>   SYM_FUNC_END(strcmp)
>> +EXPORT_SYMBOL(strcmp)
>> diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
>> index 8ae3064e45ff..962983b73251 100644
>> --- a/arch/riscv/lib/strlen.S
>> +++ b/arch/riscv/lib/strlen.S
>> @@ -131,3 +131,4 @@ strlen_zbb:
>>   #endif
>>   SYM_FUNC_END(strlen)
>>   SYM_FUNC_ALIAS(__pi_strlen, strlen)
>> +EXPORT_SYMBOL(strlen)
>> diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
>> index aba5b3148621..0f359ea2f55b 100644
>> --- a/arch/riscv/lib/strncmp.S
>> +++ b/arch/riscv/lib/strncmp.S
>> @@ -136,3 +136,4 @@ strncmp_zbb:
>>   .option pop
>>   #endif
>>   SYM_FUNC_END(strncmp)
>> +EXPORT_SYMBOL(strncmp)
>> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
>> index f11945ee2490..fb9c917c9b45 100644
>> --- a/arch/riscv/purgatory/Makefile
>> +++ b/arch/riscv/purgatory/Makefile
>> @@ -1,7 +1,9 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>     purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o
>> memset.o
>> +ifeq ($(CONFIG_KASAN_GENERIC)$(CONFIG_KASAN_SW_TAGS),)
>>   purgatory-y += strcmp.o strlen.o strncmp.o
>> +endif
>>     targets += $(purgatory-y)
>>   PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
> 
> 
> With the removal of KASAN_SW_TAGS, you can add:
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> And since I have this testsuite in my CI, I gave it a try and it works so:
> 
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> Thanks,
> 
> Alex
> 
> 
> 


