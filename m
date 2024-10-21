Return-Path: <linux-kernel+bounces-375118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558339A9123
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040A6283572
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B221FCF47;
	Mon, 21 Oct 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZO9Qy5Xr"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBAF1C8FDB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542393; cv=none; b=qRYutrQTzSyVGoJZ8BvARPuAe3LuVBh0u2JCwegDUmio+nHW2axJEPZ+h1l9MB0DhHGxw6vK5UM5bd4gGarHlDKaN0FaGoqW3jcV4D7EDSPfywmdTFssN4zu8VgbHeimaDNAXr9eyuDZAQA8Ph9gP8x8v80o33OmmEHjGXaodWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542393; c=relaxed/simple;
	bh=8WQiABvM7Dupn6mekVJ4xMF/Lyf4f7C0MNtxUSxO7Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CP1dzDsX5NXqq7e0gsHrvEIkNvlNDtd9UJ5cvKJBk8Y9clZdJX3EWY6VzpSx+80Zfttf7wC36VqCzlfOcxh2PmAy9/R+r6/YJ8zQ+rIHUEFNZ2eaHP1F6HENSSm9O7jHrh/OZOZdp6z+gI+BdQ5JSe5NEjEzIc9UvTVRjlKMeko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZO9Qy5Xr; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5e7e1320cabso2124244eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729542389; x=1730147189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+68g9n32g9C+8SvfHBjSGSr/gvAiFPiTke9yTa/MWY=;
        b=ZO9Qy5XrKwVG1Ny7YcyDndC6QZ+olZvaA1ptlvn1oYlDAalIppLNtplViiEg38z7TE
         pVKDjYBC+puavlF2EgLyyJQpfjJOHEx6bRIFEYJDVnVM7+Nx2VWLxEXIMe1ZR1jBTXrp
         FO9FyNR7EwJANFJMhCUsrPA04B0Y9O7kn98eh5+iQqky7H+b1v5H5QPKfzTJ6k41Lsbt
         QqDwHDzmpAqVf+yIdkpNC90a/oKj4okktGs1NNGS9p3qiX47d1wcn8LiBFQg9xf8U7So
         GfRJq79f5VE5u+rVomBv3vhrLsP01cw/YpOC8uhj+Qz6h0f0Hvnu86MV9F83YtnV/eZw
         vXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729542389; x=1730147189;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+68g9n32g9C+8SvfHBjSGSr/gvAiFPiTke9yTa/MWY=;
        b=q8UNMNVCCkfVQXb+FUwy7Ga8OuAxRqNjgtmlJ6KHlI2CgwrkDtsmE8c7YLN691piGp
         8pmVcDLVVuOLMClkQ7zTHrfupRTiEPJ6okkVDhEZbDA/AdREWcLOd7pwlYHMb/6PNWth
         qlhRwpCLBHTIOdBX9wF82gcMvRJKRcfFEHAoPbY7NHxK92QWiISkaW4Vj4Yg62b3n8H/
         1AWCzeMg9n52oFg8UlgzqvjK4mXjqgQJ2Tje2FEREeyOVwVvvaLx6zjDsJXsJZYZoHdv
         yKjK0RuGPrv4DBmzC7DFsU7dwvj87IVqXjKNsjrLT7NFuLUHlOjIOwxwNI/qHV3OZ092
         mazQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZtMehPJGE6QePgPJHPUwS1jGq5c//YrQH+JPfOSdV1IZhN4YDOwsBwOneMIX3I+wo4Pr2wIGxM0atjQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7/MUYrVEA+tLJiwGrT2Y5xo3znE1/t9SjdqMy2K3P80KE0LT
	wI8yT635dDu+hxjFkb6CuXwsmzGujsMAyCDhGeNl13Tyvu0Wk9f3oZvyrMhZZrI=
X-Google-Smtp-Source: AGHT+IGOkG0Lb+H7O3OcfeUyJ+pJwrVbDFZtemCKHksU9M8rEdOq9OgYu9KELQB6UrgkfNRTlu4jUQ==
X-Received: by 2002:a05:6871:1ce:b0:250:756b:b1ed with SMTP id 586e51a60fabf-2892c2abea0mr11300516fac.19.1729542387778;
        Mon, 21 Oct 2024 13:26:27 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-28c792b25fcsm1301917fac.32.2024.10.21.13.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 13:26:27 -0700 (PDT)
Message-ID: <5e6d9e76-f0f1-497c-ad49-5f705b188912@sifive.com>
Date: Mon, 21 Oct 2024 15:26:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] kasan: sw_tags: Use arithmetic shift for shadow
 computation
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Evgenii Stepanov <eugenis@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240814085618.968833-1-samuel.holland@sifive.com>
 <20240814085618.968833-2-samuel.holland@sifive.com>
 <CA+fCnZcd0jg5HqQqERfqTbVc-F2mYsq=w4aek8pQSCEPXyRG7w@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CA+fCnZcd0jg5HqQqERfqTbVc-F2mYsq=w4aek8pQSCEPXyRG7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrey,

Thanks for the review!

On 2024-08-14 11:03 AM, Andrey Konovalov wrote:
> On Wed, Aug 14, 2024 at 10:56 AM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> Currently, kasan_mem_to_shadow() uses a logical right shift, which turns
>> canonical kernel addresses into non-canonical addresses by clearing the
>> high KASAN_SHADOW_SCALE_SHIFT bits. The value of KASAN_SHADOW_OFFSET is
>> then chosen so that the addition results in a canonical address for the
>> shadow memory.
>>
>> For KASAN_GENERIC, this shift/add combination is ABI with the compiler,
>> because KASAN_SHADOW_OFFSET is used in compiler-generated inline tag
>> checks[1], which must only attempt to dereference canonical addresses.
>>
>> However, for KASAN_SW_TAGS we have some freedom to change the algorithm
>> without breaking the ABI. Because TBI is enabled for kernel addresses,
>> the top bits of shadow memory addresses computed during tag checks are
>> irrelevant, and so likewise are the top bits of KASAN_SHADOW_OFFSET.
>> This is demonstrated by the fact that LLVM uses a logical right shift
>> in the tag check fast path[2] but a sbfx (signed bitfield extract)
>> instruction in the slow path[3] without causing any issues.
>>
>> Using an arithmetic shift in kasan_mem_to_shadow() provides a number of
>> benefits:
>>
>> 1) The memory layout is easier to understand. KASAN_SHADOW_OFFSET
>> becomes a canonical memory address, and the shifted pointer becomes a
>> negative offset, so KASAN_SHADOW_OFFSET == KASAN_SHADOW_END regardless
>> of the shift amount or the size of the virtual address space.
>>
>> 2) KASAN_SHADOW_OFFSET becomes a simpler constant, requiring only one
>> instruction to load instead of two. Since it must be loaded in each
>> function with a tag check, this decreases kernel text size by 0.5%.
>>
>> 3) This shift and the sign extension from kasan_reset_tag() can be
>> combined into a single sbfx instruction. When this same algorithm change
>> is applied to the compiler, it removes an instruction from each inline
>> tag check, further reducing kernel text size by an additional 4.6%.
>>
>> These benefits extend to other architectures as well. On RISC-V, where
>> the baseline ISA does not shifted addition or have an equivalent to the
>> sbfx instruction, loading KASAN_SHADOW_OFFSET is reduced from 3 to 2
>> instructions, and kasan_mem_to_shadow(kasan_reset_tag(addr)) similarly
>> combines two consecutive right shifts.
> 
> Will this change cause any problems with the check against
> KASAN_SHADOW_OFFSET in kasan_non_canonical_hook()?

Yes, this check needs to be updated. Now kernel addresses map to a negative
displacement from KASAN_SHADOW_OFFSET, and user addresses map to a positive
displacement from KASAN_SHADOW_OFFSET. My understanding is that this check is
supposed to be a coarse-grained test for if the faulting address could be the
result of a shadow memory computation. I will update kasan_non_canonical_hook()
to use the appropriate check for KASAN_SW_TAGS in v2.

>> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Transforms/Instrumentation/AddressSanitizer.cpp#L1316 [1]
>> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Transforms/Instrumentation/HWAddressSanitizer.cpp#L895 [2]
>> Link: https://github.com/llvm/llvm-project/blob/llvmorg-20-init/llvm/lib/Target/AArch64/AArch64AsmPrinter.cpp#L669 [3]
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  arch/arm64/Kconfig              | 10 +++++-----
>>  arch/arm64/include/asm/memory.h |  8 ++++++++
>>  arch/arm64/mm/kasan_init.c      |  7 +++++--
>>  include/linux/kasan.h           | 10 ++++++++--
>>  scripts/gdb/linux/mm.py         |  5 +++--
>>  5 files changed, 29 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a2f8ff354ca6..7df218cca168 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -402,11 +402,11 @@ config KASAN_SHADOW_OFFSET
>>         default 0xdffffe0000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
>>         default 0xdfffffc000000000 if ARM64_VA_BITS_39 && !KASAN_SW_TAGS
>>         default 0xdffffff800000000 if ARM64_VA_BITS_36 && !KASAN_SW_TAGS
>> -       default 0xefff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS_52 && !ARM64_16K_PAGES)) && KASAN_SW_TAGS
>> -       default 0xefffc00000000000 if (ARM64_VA_BITS_47 || ARM64_VA_BITS_52) && ARM64_16K_PAGES && KASAN_SW_TAGS
>> -       default 0xeffffe0000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
>> -       default 0xefffffc000000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
>> -       default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>> +       default 0xffff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS_52 && !ARM64_16K_PAGES)) && KASAN_SW_TAGS
>> +       default 0xffffc00000000000 if (ARM64_VA_BITS_47 || ARM64_VA_BITS_52) && ARM64_16K_PAGES && KASAN_SW_TAGS
>> +       default 0xfffffe0000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
>> +       default 0xffffffc000000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
>> +       default 0xfffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
>>         default 0xffffffffffffffff
>>
>>  config UNWIND_TABLES
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 54fb014eba05..3af8d1e721af 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -82,6 +82,10 @@
>>   * the mapping. Note that KASAN_SHADOW_OFFSET does not point to the start of
>>   * the shadow memory region.
>>   *
>> + * For KASAN_GENERIC, addr is treated as unsigned. For KASAN_SW_TAGS, addr is
>> + * treated as signed, so in that case KASAN_SHADOW_OFFSET points to the end of
>> + * the shadow memory region.
> 
> Hm, it's not immediately obvious why using a signed addr leads to
> KASAN_SHADOW_OFFSET being == KASAN_SHADOW_END. Could you clarify this
> in the comment?
> 
> Let's also put this explanation into the KASAN_SHADOW_END paragraph
> instead, something like:
> 
> KASAN_SHADOW_END is defined first as the shadow address that
> corresponds to the upper bound of possible virtual kernel memory
> addresses UL(1) << 64 according to the mapping formula. For Generic
> KASAN, the address in the mapping formula is treated as unsigned (part
> of the compiler's ABI), so we do explicit calculations according to
> the formula. For Software Tag-Based KASAN, the address is treated as
> signed, and thus <EXPLANATION HERE>.

Here's what I plan to include in v2:

KASAN_SHADOW_END is defined first as the shadow address that corresponds to
the upper bound of possible virtual kernel memory addresses UL(1) << 64
according to the mapping formula. For Generic KASAN, the address in the
mapping formula is treated as unsigned (part of the compiler's ABI), so the
end of the shadow memory region is at a large positive offset from
KASAN_SHADOW_OFFSET. For Software Tag-Based KASAN, the address in the
formula is treated as signed. Since all kernel addresses are negative, they
map to shadow memory below KASAN_SHADOW_OFFSET, making KASAN_SHADOW_OFFSET
itself the end of the shadow memory region. (User pointers are positive and
would map to shadow memory above KASAN_SHADOW_OFFSET, but shadow memory is
not allocated for them.)

Regards,
Samuel

>> + *
>>   * Based on this mapping, we define two constants:
>>   *
>>   *     KASAN_SHADOW_START: the start of the shadow memory region;
>> @@ -100,7 +104,11 @@
>>   */
>>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>>  #define KASAN_SHADOW_OFFSET    _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>> +#ifdef CONFIG_KASAN_GENERIC
>>  #define KASAN_SHADOW_END       ((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) + KASAN_SHADOW_OFFSET)
>> +#else
>> +#define KASAN_SHADOW_END       KASAN_SHADOW_OFFSET
>> +#endif
>>  #define _KASAN_SHADOW_START(va)        (KASAN_SHADOW_END - (UL(1) << ((va) - KASAN_SHADOW_SCALE_SHIFT)))
>>  #define KASAN_SHADOW_START     _KASAN_SHADOW_START(vabits_actual)
>>  #define PAGE_END               KASAN_SHADOW_START
>> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
>> index b65a29440a0c..6836e571555c 100644
>> --- a/arch/arm64/mm/kasan_init.c
>> +++ b/arch/arm64/mm/kasan_init.c
>> @@ -198,8 +198,11 @@ static bool __init root_level_aligned(u64 addr)
>>  /* The early shadow maps everything to a single page of zeroes */
>>  asmlinkage void __init kasan_early_init(void)
>>  {
>> -       BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
>> -               KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
>> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>> +               BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
>> +                       KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
>> +       else
>> +               BUILD_BUG_ON(KASAN_SHADOW_OFFSET != KASAN_SHADOW_END);
>>         BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS), SHADOW_ALIGN));
>>         BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS_MIN), SHADOW_ALIGN));
>>         BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, SHADOW_ALIGN));
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index 70d6a8f6e25d..41f57e10ba03 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -58,8 +58,14 @@ int kasan_populate_early_shadow(const void *shadow_start,
>>  #ifndef kasan_mem_to_shadow
>>  static inline void *kasan_mem_to_shadow(const void *addr)
>>  {
>> -       return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
>> -               + KASAN_SHADOW_OFFSET;
>> +       void *scaled;
>> +
>> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>> +               scaled = (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT);
>> +       else
>> +               scaled = (void *)((long)addr >> KASAN_SHADOW_SCALE_SHIFT);
>> +
>> +       return KASAN_SHADOW_OFFSET + scaled;
>>  }
>>  #endif
>>
>> diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
>> index 7571aebbe650..2e63f3dedd53 100644
>> --- a/scripts/gdb/linux/mm.py
>> +++ b/scripts/gdb/linux/mm.py
>> @@ -110,12 +110,13 @@ class aarch64_page_ops():
>>          self.KERNEL_END = gdb.parse_and_eval("_end")
>>
>>          if constants.LX_CONFIG_KASAN_GENERIC or constants.LX_CONFIG_KASAN_SW_TAGS:
>> +            self.KASAN_SHADOW_OFFSET = constants.LX_CONFIG_KASAN_SHADOW_OFFSET
>>              if constants.LX_CONFIG_KASAN_GENERIC:
>>                  self.KASAN_SHADOW_SCALE_SHIFT = 3
>> +                self.KASAN_SHADOW_END = (1 << (64 - self.KASAN_SHADOW_SCALE_SHIFT)) + self.KASAN_SHADOW_OFFSET
>>              else:
>>                  self.KASAN_SHADOW_SCALE_SHIFT = 4
>> -            self.KASAN_SHADOW_OFFSET = constants.LX_CONFIG_KASAN_SHADOW_OFFSET
>> -            self.KASAN_SHADOW_END = (1 << (64 - self.KASAN_SHADOW_SCALE_SHIFT)) + self.KASAN_SHADOW_OFFSET
>> +                self.KASAN_SHADOW_END = self.KASAN_SHADOW_OFFSET
>>              self.PAGE_END = self.KASAN_SHADOW_END - (1 << (self.vabits_actual - self.KASAN_SHADOW_SCALE_SHIFT))
>>          else:
>>              self.PAGE_END = self._PAGE_END(self.VA_BITS_MIN)
>> --
>> 2.45.1
>>


