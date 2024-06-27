Return-Path: <linux-kernel+bounces-232143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F1C91A408
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAB2283F03
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0855A13E032;
	Thu, 27 Jun 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck1/EMKk"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F9145B13
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484690; cv=none; b=HMd4IA1N1C9AyeaIATru7D6aqVK7U8X3Lh5LFuBoEiMWrKrW/BJ9MCH/ZED2+UFXfE8lU9SyjYOX/wHJs1AaQbUkpfvuYGdtF515J+/ZUo5uFqFlpyDo96TelGESnjBCZ7Fwdm6bHIVKrpFsocR5UsXIjCKDpv0zgks9NpdGC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484690; c=relaxed/simple;
	bh=YQLZi64znaS7CI8bs0dup11FBoCRlGtT69JGRlvL4jo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LBwO7LGTojPdK7ox7DiVTgeykybPGdaQXFqFbkakGRroPgszL5+pOyBc6Y4Zp7Ovr4FjJRZsBgC2vMAbgEHM03/E9wAKVgl4DZvTfteHgNid0lA4YZarL7nxNBfN0X+3Fg67TkdwaeIAr9n546vXih1ZQJN7ksWc8370AAJXArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck1/EMKk; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-718b714d362so4116246a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719484688; x=1720089488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VP116iJGPVlyOU9i7r1chrOZ2teOoateaPGqU1Fh3fA=;
        b=Ck1/EMKkCB5OyYDT53KWpq1UgXQefK0VKYSnR0TwGvxHkP9cfX49ZOn1B5pJK/+Bdd
         DIqy3O2N4zqeoKfVuDAHu0F2JiGfwl4QXadb3BNuR8BuermP5wbTKtdN9YsR6TmLa0Dj
         WfyGG6anwyHzJzHQVy+miZMoq+9O73caPqnihv6bsUwjjw2MB+8Eb4U+0CQ0LTCkhbEs
         7ZCqN5IG+153zNIPI5l6q8IIbc6ogo04RATdJKTIA0yYYZ+cX2qPxrdgypfYaTmOzimG
         TubEDhMVsBzowRbTRo//n7kcFRLS1ikzsgDrkq2czargX3p+icHj7F5Ny7NKYC2dnZ0Y
         CMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484688; x=1720089488;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VP116iJGPVlyOU9i7r1chrOZ2teOoateaPGqU1Fh3fA=;
        b=NfZ4ziJK24YHS8aqNlZ0ME69XSRTaMo0jyAjLoH68bBeLm5Ix0nLKjraGHbI5KVcRs
         U+R5FBMSc0UGdPars4L63t/zMz4hnuTTuBO0iiZnk0lD8Q1nyD862YUhpC+G9KsGH4jm
         6KYi4zya4myzMUtSlAX64lb3+tfDxL92VwaaFUtSevDfqCi9+64kEjZtnkZoNq1j5pry
         n67mWs9WO5Z3iP4ANU94gWOEEYwBFphIGyS1783iw8Ngdr+6L7zuy2DfU+CI/p4p7Erk
         xkYjG0J0s8koUhkJt6Kdu1WW29Z2hlRhlF/UhXzQw+YG/56b9urtobw1eCIpReXya3Lp
         u/qA==
X-Forwarded-Encrypted: i=1; AJvYcCUA7eKCmRli0IV/CZG9ei+zZB7H+6FlrVJOpbQeb6RCCgRacNvnY02VqSkeqZSsrkKABytQag5jt1RfCLjBC9GCwtwjQcdzT2WGKYKq
X-Gm-Message-State: AOJu0YxhgCQXw8rfrSbG9SWCzYNF5aA9hB78DEQAGy3ABxvIwNdxEW6c
	U1+0AQoM83nGyBorkHylfnxwJnbyvqYLqGQhOk6PTtbcNflydhcL
X-Google-Smtp-Source: AGHT+IFk0Amdhpf4cK0iUI4x3T9hkQpae0MzhAzCcaQlXIdwTZ4OZp2YM86yegLigF9y+e3nhCl4WA==
X-Received: by 2002:a05:6a21:19b:b0:1b5:44eb:2eda with SMTP id adf61e73a8af0-1bcf7e6a28amr14131000637.5.1719484687761;
        Thu, 27 Jun 2024 03:38:07 -0700 (PDT)
Received: from [127.0.0.1] ([212.107.28.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac8fcd45sm10248005ad.116.2024.06.27.03.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 03:38:07 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <d16afaac-2eeb-4b43-b2bb-4d2282b9f97f@gmail.com>
Date: Thu, 27 Jun 2024 18:38:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
Content-Language: en-GB-large
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andreas Schwab <schwab@suse.de>, David Laight <David.Laight@aculab.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 "Ivan A. Melnikov" <iv@altlinux.org>
References: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
 <20240627071422.GA2626@altlinux.org>
 <9c102328-6bb3-46b6-bc2f-d011a284d5b0@gmail.com>
 <CA+FstbVf7TJx==WsY5fBoFrdeY8php5ETn8kMq5s6YScy-2O=A@mail.gmail.com>
In-Reply-To: <CA+FstbVf7TJx==WsY5fBoFrdeY8php5ETn8kMq5s6YScy-2O=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-06-27 17:43, Björn Töpel wrote:

> On Thu, Jun 27, 2024 at 9:47 AM Celeste Liu <coelacanthushex@gmail.com> wrote:
>>
>> On 2024-06-27 15:14, Dmitry V. Levin wrote:
>>
>>> Hi,
>>>
>>> On Tue, Aug 01, 2023 at 10:15:16PM +0800, Celeste Liu wrote:
>>>> When we test seccomp with 6.4 kernel, we found errno has wrong value.
>>>> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
>>>> get ENOSYS instead. We got same result with commit 9c2598d43510 ("riscv:
>>>> entry: Save a0 prior syscall_enter_from_user_mode()").
>>>>
>>>> After analysing code, we think that regs->a0 = -ENOSYS should only be
>>>> executed when syscall != -1. In __seccomp_filter, when seccomp rejected
>>>> this syscall with specified errno, they will set a0 to return number as
>>>> syscall ABI, and then return -1. This return number is finally pass as
>>>> return number of syscall_enter_from_user_mode, and then is compared with
>>>> NR_syscalls after converted to ulong (so it will be ULONG_MAX). The
>>>> condition syscall < NR_syscalls will always be false, so regs->a0 = -ENOSYS
>>>> is always executed. It covered a0 set by seccomp, so we always get
>>>> ENOSYS when match seccomp RET_ERRNO rule.
>>>>
>>>> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
>>>> Reported-by: Felix Yan <felixonmars@archlinux.org>
>>>> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
>>>> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
>>>> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
>>>> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
>>>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>>>> Tested-by: Felix Yan <felixonmars@archlinux.org>
>>>> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>>> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>>>> Reviewed-by: Guo Ren <guoren@kernel.org>
>>>> ---
>>>>
>>>> v4 -> v5: add Tested-by Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>>> v3 -> v4: use long instead of ulong to reduce type cast and avoid
>>>>           implementation-defined behavior, and make the judgment of syscall
>>>>           invalid more explicit
>>>> v2 -> v3: use if-statement instead of set default value,
>>>>           clarify the type of syscall
>>>> v1 -> v2: added explanation on why always got ENOSYS
>>>>
>>>>  arch/riscv/kernel/traps.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>>> index f910dfccbf5d2..729f79c97e2bf 100644
>>>> --- a/arch/riscv/kernel/traps.c
>>>> +++ b/arch/riscv/kernel/traps.c
>>>> @@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>>>>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>>>  {
>>>>      if (user_mode(regs)) {
>>>> -            ulong syscall = regs->a7;
>>>> +            long syscall = regs->a7;
>>>>
>>>>              regs->epc += 4;
>>>>              regs->orig_a0 = regs->a0;
>>>> @@ -306,9 +306,9 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>>>
>>>>              syscall = syscall_enter_from_user_mode(regs, syscall);
>>>>
>>>> -            if (syscall < NR_syscalls)
>>>> +            if (syscall >= 0 && syscall < NR_syscalls)
>>>>                      syscall_handler(regs, syscall);
>>>> -            else
>>>> +            else if (syscall != -1)
>>>>                      regs->a0 = -ENOSYS;
>>>>
>>>>              syscall_exit_to_user_mode(regs);
>>>
>>> Unfortunately, this change introduced a regression: it broke strace
>>> syscall tampering on riscv.  When the tracer changes syscall number to -1,
>>> the kernel fails to initialize a0 with -ENOSYS and subsequently fails to
>>> return the error code of the failed syscall to userspace.
>>
>> In the patch v2, we actually do the right thing. But as Björn Töpel's
>> suggestion and we found cast long to ulong is implementation-defined
>> behavior in C, so we change it to current form. So revert this patch and
>> apply patch v2 should fix this issue. Patch v2 uses ths same way with
>> other architectures.
>>
>> [1]: https://lore.kernel.org/all/20230718162940.226118-1-CoelacanthusHex@gmail.com/
> 
> Not reverting, but a fix to make sure that a0 is initialized to -ENOSYS, e.g.:
> 
> --8<--
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 05a16b1f0aee..51ebfd23e007 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -319,6 +319,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
> 
>   regs->epc += 4;
>   regs->orig_a0 = regs->a0;
> + regs->a0 = -ENOSYS;
> 
>   riscv_v_vstate_discard(regs);
> 
> @@ -328,8 +329,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
> 
>   if (syscall >= 0 && syscall < NR_syscalls)
>   syscall_handler(regs, syscall);
> - else if (syscall != -1)
> - regs->a0 = -ENOSYS;
> +
>   /*
>   * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
>   * so the maximum stack offset is 1k bytes (10 bits).
> --8<--
> 
> Celeste, do you want to cook that fix properly?

Patch has been sent.

https://lore.kernel.org/all/20240627103205.27914-2-CoelacanthusHex@gmail.com/

And linux-riscv mail list problably has some issue: there are two copies
of patch, orginal one and another one with linux-riscv foot.

> 
> 
> Björn


