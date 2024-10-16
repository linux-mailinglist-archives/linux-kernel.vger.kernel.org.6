Return-Path: <linux-kernel+bounces-368087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D79A0B02
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB71F266AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FBA208D85;
	Wed, 16 Oct 2024 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6dcAa2f"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245DB206E66
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084049; cv=none; b=CM3sGBdg1/dovyuRHVD7vLMc7LqM9Go6VHXovLwJnE2vvs9PigfDZy06qsp1TIgE8ZgR+ZnL/bLc2Z9KKcEpT1K6WAgKQSAVoVEUh6UKK29d/IIeh+Sd1I1Nmx8iINULM0CTLFp2RhR0hj9LBp6TWb181zHXzpoTu5OkDwdYLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084049; c=relaxed/simple;
	bh=QDwgPxraq6OF9McOSF4KZNzUhXrtzGXxTd2zAQIVLu4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gqJu+KCO1Xo6qvLdLRZ79Df6o3GezFuM8U9yBZTHjNuJgVedIkkeraSCxUpxuJxGFXvD3mjs3XU8PKR2fz3vE5JOLjErYLiG12yu+TvR/QhTIGlor5QbZrmCc4XB24UNf8yIrKEvF4la+I16xvfAHZqPmExP7vf5t5YnM9DVwsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6dcAa2f; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso5271381a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729084046; x=1729688846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cFk1lUCHytr2MFg4RaLCLc+fDoPzOPhkEAx4vVa1V8U=;
        b=S6dcAa2f9wMLD12+mjdCMH1jx0UEztWAhOWpCye6iMKOFe6iRLBcATI9fTrLUtQir0
         hknf9tkiL4+VXkR9r2JLkypAHNqCqIKmihlvM3yEQ/7KiTxzqLtEcaqMllCnsl1Dt+05
         Iuj6xtlfmfnjYSBn+tOrl0NYdo16685pbAf7Fro4vZkbXO+a3V1b+0wDp+v5hmr2B5Yl
         +2Lzluyn0l+Bj1E+tB+o5LSMpErY6Yri/sJOE9hC1eclk3dBn86IO3kgLz539HsPp/cC
         +huBHwCtnAN6WU5IBxKQLplQNjhEIs5OeUoTn+ZyOCtfDPDEJ6EX8Vp6e3sJIeBCr/QM
         J5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084046; x=1729688846;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFk1lUCHytr2MFg4RaLCLc+fDoPzOPhkEAx4vVa1V8U=;
        b=iIVmMa0YJ5Dzv2ZnTrFjcB80ky9LvI8RSrYTHCyI9GviXD+kckFZKHNQywqNFz3AJ7
         SNWt8+EGS/sAbiVsiaW/r+URGYdm2Fni8ww8HPUOXYBmd6dkcRkbvrnS7qekm8L1B4gc
         NSxbiUUyAgIkwQ3gOqrZxe2xuc5aS2MMj0W3usleVLfih9MEzEoieh2UC66kv1rmsXQO
         +x1hW9BxHwvNOsrTMywzCAErkMOfLWtIqncjwW3kzYYs9GmfQM9vnZDkSZ/WkvTPemPU
         QbQpgzmp3r9yneAd1NdIMUvuDISXl4FJoIRbZgdmOqnqwfrLz3b2iTvLJI+jCK7mr3nQ
         D3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXEZl7mtKiGozUIgApEHExg2zMmmcB/xM9YvSbG2WeLboOhCNRaH4wdAdvCdH/EjzNhygJwdfTW63Ytg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzND8kB+Irx26Mylu0SyUHBEwH9zJ9bfkkdQvY4M7iYGQZ3stml
	jt7t/PATVJPDSvD+0HbZkKaTa3sXd2dnL7I+4MH8AvEA2nJ7vD/B
X-Google-Smtp-Source: AGHT+IH6DsqAV/G6JOd7t25bsHF4r0vsplz+CSOJmcBB4kbw4clSXC01918WRw/8rMJzyrnikGyRcw==
X-Received: by 2002:a17:90a:ad81:b0:2e2:d61d:60e6 with SMTP id 98e67ed59e1d1-2e3ab8245e9mr4283458a91.17.1729084045986;
        Wed, 16 Oct 2024 06:07:25 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f753b4sm4059650a91.49.2024.10.16.06.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 06:07:25 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <707db338-4429-49a6-bcab-39ab44c4f770@gmail.com>
Date: Wed, 16 Oct 2024 21:07:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] riscv/entry: issue about a0/orig_a0 register and ENOSYS
To: Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Oleg Nesterov <oleg@redhat.com>, "Dmitry V. Levin" <ldv@strace.io>
Cc: Andrea Bolognani <abologna@redhat.com>, WANG Xuerui <git@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Yangyu Chen <cyy@cyyself.name>,
 Han Gao <gaohan@iscas.ac.cn>, linux-kernel@vger.kernel.org,
 rsworktech@outlook.com
References: <59505464-c84a-403d-972f-d4b2055eeaac@gmail.com>
 <6b2ff48a-ab43-4866-af5a-b8b7d3c23582@ghiti.fr>
 <6b744fa3-5c1d-460d-bb09-5bc48379d598@gmail.com>
 <7375212b-2e40-4f39-a1ca-291c0975b529@ghiti.fr>
Content-Language: en-GB-large
In-Reply-To: <7375212b-2e40-4f39-a1ca-291c0975b529@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2024-10-16 20:56, Alexandre Ghiti wrote:
> On 16/10/2024 14:23, Celeste Liu wrote:
>> On 2024-10-16 20:00, Alexandre Ghiti wrote:
>>> Hi Celeste,
>>>
>>> Thank you for looking into this and really sorry about the late response.
>>>
>>> On 17/09/2024 06:09, Celeste Liu wrote:
>>>> Before PTRACE_GET_SYSCALL_INFO was implemented in v5.3, the only way to
>>>> get syscall arguments was to get user_regs_struct via PTRACE_GETREGSET.
>>>> On some architectures where a register is used as both the first
>>>> argument and the return value and thus will be changed at some stage of
>>>> the syscall process, something like orig_a0 is provided to save the
>>>> original argument register value. But RISC-V doesn't export orig_a0 in
>>>> user_regs_struct (This ABI was designed at e2c0cdfba7f6 ("RISC-V:
>>>> User-facing API").) so userspace application like strace will get the
>>>> right or wrong result depends on the operation order in do_trap_ecall_u()
>>>> function.
>>>>
>>>> This requires we put the ENOSYS process after syscall_enter_from_user_mode()
>>>> or syscall_handler()[1]. Unfortunately, the generic entry API
>>>> syscall_enter_from_user_mode() requires we
>>>>
>>>> *  process ENOSYS before syscall_enter_from_user_mode()
>>>
>>> Where does this requirement come from?
>>>
>>>
>>>> *  or only set a0 to ENOSYS when the return value of
>>>>      syscall_enter_from_user_mode() != -1
>>>>
>>>> Again, if we choose the latter way to avoid conflict with the first
>>>> issue, we will meet the third problem: strace depends on that kernel
>>>> will return ENOSYS when syscall nr is -1 to implement their syscall
>>>> tampering feature[2].
>>>
>>> IIUC, seccomp and others in syscall_enter_from_user_mode() could return -1 and then we could not differentiate with the syscall number being -1.
>>>
>>> But could we imagine, to distinguish between an error and the syscall number being -1, checking again the syscall number after we call syscall_enter_from_user_mode()? If the syscall number is -1, then we set ENOSYS otherwise we don't do anything (a bit like what you did in 52449c17bdd1 ("riscv: entry: set a0 = -ENOSYS only when syscall != -1")).
>>>
>>> Let me know if I completely misunderstood here!
>> Yeah. I found this a bit later after I post this RFC. I include it in a update reply,
>> copy here as well:
>>
>>> But from another angle, syscall number is in a7 register, so we can call the
>>> get_syscall_nr() after calling the syscall_enter_from_user_mode() to bypass the
>>> information lost of the return value of the syscall_enter_from_user_mode(). But
>>> in this way, the syscall number in the syscall_enter_from_user_mode() return
>>> value is useless, and we can remove it directly.
>> So if we get syscall number from a7 register again, the syscall number part of
>> the return value of syscall_enter_from_user_mode() is useless completely.
>> I think it's better to drop it so the later new architecture developer will not
>> run into the same issue. (Actually, the syscall number returned by
>> syscall_enter_from_user_mode() is also the result of get_syscall_nr() at the end
>> of it.) But it will affect other architecture's code so I think there still need
>> some discussions.
>>
>> Or if you think it's better to post a patch and then discuss in patch thread
>> directly, I'm glad to do this.
> 
> 
> Great that we have a solution that does not need to change the ABI :)
> 
> I think we should start by implementing a fix for riscv only that implements the get_syscall_nr() after syscall_enter_from_user_mode() so that we can merge that in 6.12-rcX.
> 
> And after that, you could come with the nicer solution you propose.
> 
> Do you think you can send a patch for the quick fix soon? In the meantime, I'm adding the strace testsuite to my CI to make sure it works and we don't break it again :)

Ok. I will send patch soon.

> 
> Thanks!
> 
> Alex
> 
> 
>>
>>> Thanks again for the thorough explanation,
>>>
>>> Alex
>>>
>>>
>>>> Actually, we tried the both ways in 52449c17bdd1 ("riscv: entry: set
>>>> a0 = -ENOSYS only when syscall != -1") and 61119394631f ("riscv: entry:
>>>> always initialize regs->a0 to -ENOSYS") before.
>>>>
>>>> Naturally, there is a solution:
>>>>
>>>> 1. Just add orig_a0 in user_regs_struct and let strace use it as
>>>>      loongarch does. So only two problems, which can be resolved without
>>>>      conflict, are left here.
>>>>
>>>> The conflicts are the direct result of the limitation of generic entry
>>>> API, so we have another two solutions:
>>>>
>>>> 2. Give up the generic entry API, and switch back to the
>>>>      architecture-specific standardalone implementation.
>>>> 3. Redesign the generic entry API: the problem was caused by
>>>>      syscall_enter_from_user_mode() using the value -1 (which is unused
>>>>      normally) of syscall nr to inform syscall was reject by seccomp/bpf.
>>>>
>>>> In theory, the Solution 1 is best:
>>>>
>>>> *  a0 was used for two purposes in ABI, so using two variables to store
>>>>      it is natural.
>>>> *  Userspace can implement features without depending on the internal
>>>>      behavior of the kernel.
>>>>
>>>> Unfortunately, it's difficult to implement based on the current code.
>>>> The RISC-V defined struct pt_regs as below:
>>>>
>>>>           struct pt_regs {
>>>>                   unsigned long epc;
>>>>           ...
>>>>                   unsigned long t6;
>>>>                   /* Supervisor/Machine CSRs */
>>>>                   unsigned long status;
>>>>                   unsigned long badaddr;
>>>>                   unsigned long cause;
>>>>                   /* a0 value before the syscall */
>>>>                   unsigned long orig_a0;
>>>>           };
>>>>
>>>> And user_regs_struct needs to be a prefix of struct pt_regs, so if we
>>>> want to include orig_a0 in user_regs_struct, we will need to include
>>>> Supervisor/Machine CSRs as well. It's not a big problem. Since
>>>> struct pt_regs is the internal ABI of the kernel, we can reorder it.
>>>> Unfortunately, struct user_regs_struct is defined as below:
>>>>
>>>>           struct user_regs_struct {
>>>>                   unsigned long pc;
>>>>           ...
>>>>                   unsigned long t6;
>>>>           };
>>>>
>>>> It doesn't contain something like reserved[] as padding to leave the
>>>> space to add more registers from struct pt_regs!
>>>> The loongarch do the right thing as below:
>>>>
>>>>           struct user_pt_regs {
>>>>                   /* Main processor registers. */
>>>>                   unsigned long regs[32];
>>>>           ...
>>>>                   unsigned long reserved[10];
>>>>           } __attribute__((aligned(8)));
>>>>
>>>> RISC-V can't include orig_a0 in user_regs_struct without breaking UABI.
>>>>
>>>> Need a discussion to decide to use which solution, or is there any
>>>> other better solution?
>>>>
>>>> [1]: https://github.com/strace/strace/issues/315
>>>> [2]: https://lore.kernel.org/linux-riscv/20240627071422.GA2626@altlinux.org/
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv


