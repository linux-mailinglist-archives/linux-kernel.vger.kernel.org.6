Return-Path: <linux-kernel+bounces-232111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AF691A390
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4901C21B86
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC913C814;
	Thu, 27 Jun 2024 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY7ROG+w"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889E13C67E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483088; cv=none; b=HtFn+9Ds8pdBFBRongmh0fy1CpNty8ssThXNe4ZrBCRWBe3keSFRGMb7VNvi1p6uTy+gAlqRMlQNvAvBJCAp0Or3g1kf7LQlWutHxA4njFfdSFUxH/AsvIOcp7pETVgqUT3h9CWhbvm0QOVcWG5u2PvBjOQ27kerAHxujNpBpLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483088; c=relaxed/simple;
	bh=RGQHQzMvAJJ18phcQUWNK57PO0eaJhXWjGhWhoMgHaA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Owrslgy0H2leq5Lw7yVWdF5OoCxIfEW8gLx6XcD84O4BgW90FZd0MR7MlGQRMOzI4sgw7xO9EOREDHkjo2lAwE/03kwEnkDb+sZqSJ1JdCjKVV+hH65PHMOKaekSHyUolsVAi6x0vQIafwha4V1VqcP5BTf6q92VZd85oqV53oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY7ROG+w; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1f6a837e9a3so47667215ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719483086; x=1720087886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nhaug2EPx+qEgt62m3ojcCaUyh05yCww5PDEVq+nvig=;
        b=lY7ROG+w/9tNuLqYEyq25EG9KAM3PVXiCvYea8WoL91cqi9pU0XPfKpjh4jwAJe0SH
         BYETufNFBjQT5sV5PI67WBcV9JW4Pq9zRdNV9aDZPyxVENQPw9b+wnM60C/SSXT+VihW
         6bAV5086OcJqqyJQMpSzUToa/+zW1KhtpCGV+JKetnKzIlNLXUvGLrtmyNOCl18eg8HT
         XYfLhWO47hDDuN4xkI0QHbxBptj3/bqeaFPcrdjxOKawMfTeDcm+gHy4phaltzuhhSKD
         Gu7eGmr/Hcf/pxQAmiNTATPOrQodoNJjcaXRgkU7rtiAkaduX7BodtH7GcQIz9+hKEZ7
         onKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719483086; x=1720087886;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nhaug2EPx+qEgt62m3ojcCaUyh05yCww5PDEVq+nvig=;
        b=h7dfVG5d0gfA3OG4n1/yEj7hDNudJLXy0bNAv/XBz9JCwK0BpE7rFeHFDMdVqgMRAf
         8jYGfdJ3paOnbc2y07odL2RO9HUd35FPIINEXQBFscCzg9H8UqBNbGVmhApIk2cv1Qzy
         s1VXdMYlAbmDmSAM3FgM1F19+XpcasLx9RqV3GhlHKmqTNLALvcECJofAAbjtEVKPuKZ
         7ghzTtMfqwfLvoNkFNLpb5Uyv6O0TrTr9ryUFj9gblLI/mzCcWVQW0dOa13ch/MB8cYw
         Lhqes2cUb7nf0L/U4KwWjyKnm+bU/keGAmPJbWz/TIz2U7gPEU4mUCWdWSimkLeUmL5Q
         zTwA==
X-Forwarded-Encrypted: i=1; AJvYcCUdpWfS+hHF64aqL51rv+PWr+4+rfn18Vh8TQ+gHwsivlWWuIgrKvy9rcUtH1vvAICH7DOgCR+q4no+/7EDJzuhl8KiIvomrAVBjmuk
X-Gm-Message-State: AOJu0YxdplyulrpVfOfjJewiZxgOpgNiDdbgLi+aCswZqciyHQ0Fq9tl
	hrpecWeNVFfV7wrzIbyoL04RxcABksPDv28huxT5gQDj3uKECUX1
X-Google-Smtp-Source: AGHT+IFL/5dOdrZlFA7z1Hme4OgjQs+yGKzHZKmAuRfJKku11yeI6TkI4Fbw35ApU3NgfKrtdnA0IQ==
X-Received: by 2002:a17:902:6bc3:b0:1f8:68b8:3736 with SMTP id d9443c01a7336-1fa23f89653mr94251095ad.35.1719483086201;
        Thu, 27 Jun 2024 03:11:26 -0700 (PDT)
Received: from [127.0.0.1] ([212.107.28.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac8e194asm9744445ad.11.2024.06.27.03.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 03:11:25 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <ccf089fd-613d-475c-aeb1-8abc92873a90@gmail.com>
Date: Thu, 27 Jun 2024 18:11:20 +0800
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

Oh. I just want to describe what change we need, not to say actual 'git revert'.

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

This is also what I think.

> Celeste, do you want to cook that fix properly?

Yeah. I will sent patch to mail list soon.

> 
> 
> Björn


