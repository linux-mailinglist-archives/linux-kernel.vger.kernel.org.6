Return-Path: <linux-kernel+bounces-565206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB616A6632D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6CE3B130A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62713207663;
	Mon, 17 Mar 2025 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="bNE6HHtH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFC1E1E03
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255706; cv=none; b=F5DgCmAdG5Kp/G4/F/stnZo7odq0eslg7Viq+z4V97NfXibXM5sYZWSz1O/AC4vZQ+MwVo3flcjbRCnbOU07cG0WPjnHMrDWhzj0rdZW1AapJ530UppiJJK3ZaaEzz82nOOtJYG6fmQA/oV+3geZwQTy4lS9o76ZDbLzC6b7dL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255706; c=relaxed/simple;
	bh=Bb1xtCjgennkMrbNnKbCzke2aMsPLm65RxApeP/uuHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne5grjJ/6DUcUxb5OMLR0MKCJOQA7R2cmZsXctUuk2PofoknV19O5DCYCno4s8YLsH2PCjHFxKQNAMeRlvhh/x0/s2OqjKCgq6tHvH3jn1Te2V+WbLSenmJdt1Z+oQ5C2t7o57M8V/atvX3JIZKzbZExkMayieqHGUiSxATz7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=bNE6HHtH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso44682705ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742255704; x=1742860504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BaEesGZQPxAj4sEFCUyAgXUqotSKFJXiU7Y/LCyccU=;
        b=bNE6HHtHqTSe/mznDW1Fr6SqY7eN18D7KI/64k2IDubpvMeuE6O1i5l/nY6mpINQyW
         OR7KHDbWjjWw8H9V9aoHhl1joFfL3fv7Zf8fNpql/RlEUicY31zNTZt2O9xQmd2xJmlq
         Ihl8oe7eLRh+EQxzgpAj35DbGKpZ99k3XAs5U0X44gcp8tMrhQLNVG5yL4T3cldxr9sg
         BiHL7HtLYJdJ+y8o+bgnRLeBEzFm165VJoM9KyWH2X9fVjJEQxM+LNh+qQJsW+LO1XiA
         65cSCZiuENsBVimAO5Tz1Cb/Uj3AMnQE0tc+6fvcAWvNXiuERRgtcDV3uSDnhdnjmYw2
         Uyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742255704; x=1742860504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BaEesGZQPxAj4sEFCUyAgXUqotSKFJXiU7Y/LCyccU=;
        b=D2v5P7xnN+bV0fo7p7eP+wvrsGmeQNRbfwRY9LcC4InHOKqbeWLBYAPWNK99oPehAl
         aWmIqLY/zZ8wGKScRPteo9W7OCKtEwG+9ylkwCbLhcTIb2pq8a4LeoxKO8cr3KKF0EC8
         zha/0YOkUWUcrWzhlptEfHtbfiq6zE14Jb4IRLcgO/UO33eKiQ6LwPaxE4AhCesAZumh
         LaDtBBOUC0RkjD2VO/BksXEof/BxEGFJHArD2vz8mAc0VNAUW83fYD0EE+CMxpkoWQuH
         KkL+aq1sU9Es/HkpOQ/I846gW9Wd5IJzGo7hrXPZDGbokU8EJDI8a7rvow7zC994+6tV
         TFdg==
X-Forwarded-Encrypted: i=1; AJvYcCUGzNh82PVKB3YGfgUAiJTbYmH8AMhXFFaFluRAS9w5yU7r8WkP/tMtBVfWEqaBgqzahHG7UkjkGLFdXS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhPsstXdDMWc8zOo0R7B7e+o1LuhqUZY5NlFNEfYP7hOv+TZ+
	Y0zcbHiMV6sf4/pqPj0oL9Gxtl5Ozg7kiIKWwfZk+K4xuyBI9q7WAU4e+tad0A==
X-Gm-Gg: ASbGnctZwyTSYdtJC3y4DXFapcu/LbqSo73pRiZpTBcZSZq8B8xR0RZAG8XaPOMxm9Z
	qZS97n2lgmg3j97ZiWQSqI21B0IUZrJGC1NU4eFV+pW2UU0MdkHeJLLlSe/cOHfTUdb0Eg3wFgK
	Uxr9sHiKg1VapuoPRo9sHbKtK46mfSajhHuKbd2k/nk5Ko1582U5mm4Q6iK2PyA9mcuv8y0o26i
	cpURwOnjDnGvX5CJs3ETla39HqropKaaMMeBu2XoJsAoW55i74xKObzJo8Q8kyrPbEd4iXqG7lP
	kEC57Pc6Kse1qTpCN21sSkujFBOhL9IbhdCT+Xix7fZ+7d3edNa/X26jv4LAiTSkvw==
X-Google-Smtp-Source: AGHT+IEal8kGqBORazjLpmbhAyMjWbAph9OrXPa4QlNZhh/T7g7iTF+vSLL4w1ItmIz6KJ2LE1skXg==
X-Received: by 2002:a05:6a00:a01:b0:736:3c2b:c38e with SMTP id d2e1a72fcca58-73757246dfbmr1533920b3a.13.1742255703849;
        Mon, 17 Mar 2025 16:55:03 -0700 (PDT)
Received: from [192.168.50.200] ([202.172.96.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af594eb973dsm4686757a12.19.2025.03.17.16.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 16:55:03 -0700 (PDT)
Message-ID: <e0075d0c-45ae-437a-b873-e892e4e51dc3@tenstorrent.com>
Date: Tue, 18 Mar 2025 10:54:59 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v3 1/4] riscv: implement user_access_begin() and
 families
To: Alexandre Ghiti <alex@ghiti.fr>, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, paul.walmsley@sifive.com, charlie@rivosinc.com,
 jrtc27@jrtc27.com, ben.dooks@codethink.co.uk
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jszhang@kernel.org
References: <20250221000924.734006-1-cyrilbur@tenstorrent.com>
 <20250221000924.734006-2-cyrilbur@tenstorrent.com>
 <9a94c74f-4826-479f-aaa0-e87b3bfd30ff@ghiti.fr>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <9a94c74f-4826-479f-aaa0-e87b3bfd30ff@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/3/2025 12:28 am, Alexandre Ghiti wrote:
> Hi Cyril,
> 
> On 21/02/2025 01:09, Cyril Bur wrote:
>> From: Jisheng Zhang<jszhang@kernel.org>
>>
>> Currently, when a function like strncpy_from_user() is called,
>> the userspace access protection is disabled and enabled
>> for every word read.
>>
>> By implementing user_access_begin() and families, the protection
>> is disabled at the beginning of the copy and enabled at the end.
>>
>> The __inttype macro is borrowed from x86 implementation.
>>
>> Signed-off-by: Jisheng Zhang<jszhang@kernel.org>
>> Signed-off-by: Cyril Bur<cyrilbur@tenstorrent.com>
>> ---
>>   arch/riscv/include/asm/uaccess.h | 63 ++++++++++++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/ 
>> asm/uaccess.h
>> index fee56b0c8058..43db1d9c2f99 100644
>> --- a/arch/riscv/include/asm/uaccess.h
>> +++ b/arch/riscv/include/asm/uaccess.h
>> @@ -61,6 +61,19 @@ static inline unsigned long 
>> __untagged_addr_remote(struct mm_struct *mm, unsigne
>>   #define __disable_user_access()                            \
>>       __asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : 
>> "memory")
>> +/*
>> + * This is the smallest unsigned integer type that can fit a value
>> + * (up to 'long long')
>> + */
>> +#define __inttype(x) __typeof__(        \
>> +    __typefits(x,char,            \
>> +      __typefits(x,short,            \
>> +        __typefits(x,int,            \
>> +          __typefits(x,long,0ULL)))))
>> +
>> +#define __typefits(x,type,not) \
>> +    __builtin_choose_expr(sizeof(x)<=sizeof(type),(unsigned type)0,not)
>> +
>>   /*
>>    * The exception table consists of pairs of addresses: the first is the
>>    * address of an instruction that is allowed to fault, and the 
>> second is
>> @@ -368,6 +381,56 @@ do {                                    \
>>           goto err_label;                        \
>>   } while (0)
>> +static __must_check __always_inline bool user_access_begin(const void 
>> __user *ptr, size_t len)
>> +{
>> +    if (unlikely(!access_ok(ptr,len)))
>> +        return 0;
>> +    __enable_user_access();
>> +    return 1;
>> +}
>> +#define user_access_begin(a,b)    user_access_begin(a,b)
> 
> 
> Nit: no need for (a,b) here
> 
> 
>> +#define user_access_end()    __disable_user_access()
>> +
>> +static inline unsigned long user_access_save(void) { return 0UL; }
>> +static inline void user_access_restore(unsigned long enabled) { }
>> +
>> +/*
>> + * We want the unsafe accessors to always be inlined and use
>> + * the error labels - thus the macro games.
>> + */
>> +#define unsafe_put_user(x, ptr, label)    do {                \
>> +    long __err = 0;                            \
>> +    __put_user_nocheck(x, (ptr), __err);                \
>> +    if (__err) goto label;                        \
>> +} while (0)
>> +
>> +#define unsafe_get_user(x, ptr, label)    do {                \
>> +    long __err = 0;                            \
>> +    __inttype(*(ptr)) __gu_val;                    \
>> +    __get_user_nocheck(__gu_val, (ptr), __err);            \
>> +    (x) = (__force __typeof__(*(ptr)))__gu_val;            \
>> +    if (__err) goto label;                        \
>> +} while (0)
>> +
>> +#define unsafe_copy_loop(dst, src, len, type, label)                \
>> +    while (len >= sizeof(type)) {                        \
>> +        unsafe_put_user(*(type *)(src),(type __user *)(dst),label);    \
>> +        dst += sizeof(type);                        \
>> +        src += sizeof(type);                        \
>> +        len -= sizeof(type);                        \
>> +    }
>> +
>> +#define unsafe_copy_to_user(_dst,_src,_len,label)            \
>> +do {                                    \
>> +    char __user *__ucu_dst = (_dst);                \
>> +    const char *__ucu_src = (_src);                    \
>> +    size_t __ucu_len = (_len);                    \
>> +    unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);    \
>> +    unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);    \
>> +    unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);    \
>> +    unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);    \
>> +} while (0)
>> +
>>   #else /* CONFIG_MMU */
>>   #include <asm-generic/uaccess.h>
>>   #endif /* CONFIG_MMU */
> 
> There is a bunch of checkpatch errors to fix, see https:// 
> gist.github.com/linux-riscv-bot/98f23fd1b04d6da7c23c6cb18245a158
> 

Oops, yeah will fix.

> Why isn't there an implementation for unsafe_copy_from_user()? Let's 
> take the following example:
> 
> user_access_begin()
> unsafe_copy_from_user()
> unsafe_get_user() <==== This one will fail since unsafe_copy_from_user() 
> -> raw_copy_from_user() -> __asm_vector_usercopy() which enables and 
> disables the SUM bit.
> user_access_end()

I'll have to look into that - thanks for the feedback.

> 
> Another thing is that with this patch, we lose the vectorized user 
> access functions, can you fix that too?

I'll have a look at this also.

> 
> Thanks,
> 
> Alex
> 
> 
> 


