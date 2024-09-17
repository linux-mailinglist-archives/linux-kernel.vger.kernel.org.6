Return-Path: <linux-kernel+bounces-331316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B39F97AB33
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA32B281606
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA34D8CC;
	Tue, 17 Sep 2024 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMnNjarw"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C688482EF
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726552771; cv=none; b=oarlZhLCLOfYRkjX7mAxkeuPgDStVjouEpdBvBPHA4bl6A2/liFGzqbsylscCtZ2vSjZr0yexg5Gm+uxXDWcVea9xiyLYebdWRQD8HuAd+bNnx1WgQ1aI+GfgVNCl+tmnJeuzF77gSZzk3AnWgvUvvf188Bzo48GbbezB7QIxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726552771; c=relaxed/simple;
	bh=5B9xLr3lbtOC3onQSOHYzEuMjBC0mttb9ksi3eJfCSU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qlsWt3q5TcgP0PQJPcXgV7fUuO05AovKIRowkFGeGa1/hTidPcp/bUpCfsBaZvT9otkfd4joxYQArHs0xkOT1j6+mo/bwODp/eUbc3U3YW+f8GDByayq7eqRvQ7NS0l6J2CfAqGerWkMVH+eKSqsjGyrhErwwOzOe6zuled9iEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMnNjarw; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2053a0bd0a6so54149995ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726552769; x=1727157569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Tc+i0jL+SgEcOjmMg2Bl4vsyUPl8jhbpSLkRrsREYU=;
        b=mMnNjarwtPThzIAtmEwJ5H6k4fF5jpXAGFrV8ZaLTe/dgNeQJDzBZJy6DbyWx8xpok
         23clrWNoo+v/b2Uj+jJy/KVmR+/IT+SFfvvCVVO5AvGwgpBmSlgSkU7+7OBiPr8apn0Y
         3Rc0MbqidE/wMXfHsp0zfPNso1TtP4VP/Qr9EWkT5k1rzmXQuO3u8sMcHIitRP6yAABE
         6cM12/iFT9JdWOvxppFbOwVGg3eEj4ApiDmSUrvB/yJ/Kx9+zrZhjY3K7fk9vQcifu3W
         iJcGceZ5FgyIIZc/VFbyDNIjgWAsXeZbWP/9o8L/I+ao/Z1FnQ2+CCzO4BaAtQD3ExaR
         29HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726552769; x=1727157569;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Tc+i0jL+SgEcOjmMg2Bl4vsyUPl8jhbpSLkRrsREYU=;
        b=Ff1Z1JSln5m9BIbUga+ThDhef9DnHNxBhUZpeSpPgNJIebsC3ELB2k8HR5i9vN1gKU
         cofDsCLhvGzDGrDk0RPoLEsTD6+2kQd97LUPnicBUp6VxnPyznjt3vVwyQLCiGB4iuUI
         335ZOPXbXImk91wy5rmPP6OLmCZnYVnaXF+d4qbxxRSidPAVHpMLvZzf5NPqhRJ64MAj
         i20G0Od2mbc/OTUWUQO8CIQ56cP82+sf3vbLh5EC55120ex/OUfAxPlBPsYK4HCkDbmc
         j+wNRyqkR7mqCdI5PIfq2OGQn6YEdYI0QH/g9cerLo//JHVMwIZCBeaLUGcXVSDzLlbu
         Z4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxAOVPq3oD7P8csw76xCoevi8xLMb/xFItc9T9V50nf7AP1RHbZpNuq+l8bVw7LIAOIEpah/Htbi+5CNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7iJGG8/j2nwKGL8WZvMBragRfAE3reVgC8cGM/Nhp8CXUlj1
	QZ4VqC2+JdKLKfuRsDUbwgXK9MvgLa2d7aJUFVPot0bCPc+BVdv3
X-Google-Smtp-Source: AGHT+IHmRxszv3e1lKEIxv9DUkSNGSmFzkYMMAf4vZ11XlTwpEwRIP+nuTl2ZfeEhAN7qZWn8UuwrA==
X-Received: by 2002:a17:902:fc4c:b0:207:4c7c:743b with SMTP id d9443c01a7336-2076d90a1aamr269812965ad.0.1726552769241;
        Mon, 16 Sep 2024 22:59:29 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794712f91sm44325315ad.229.2024.09.16.22.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 22:59:28 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <84ae492a-1995-4fa1-9d3c-78c5bbf9ff71@gmail.com>
Date: Tue, 17 Sep 2024 13:59:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] riscv/entry: issue about a0/orig_a0 register and ENOSYS
Content-Language: en-GB-large
To: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Oleg Nesterov <oleg@redhat.com>,
 "Dmitry V. Levin" <ldv@strace.io>
Cc: Andrea Bolognani <abologna@redhat.com>, WANG Xuerui <git@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Yangyu Chen <cyy@cyyself.name>,
 Han Gao <gaohan@iscas.ac.cn>, linux-kernel@vger.kernel.org,
 rsworktech@outlook.com
References: <59505464-c84a-403d-972f-d4b2055eeaac@gmail.com>
In-Reply-To: <59505464-c84a-403d-972f-d4b2055eeaac@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-09-17 12:09, Celeste Liu wrote:
> Before PTRACE_GET_SYSCALL_INFO was implemented in v5.3, the only way to
> get syscall arguments was to get user_regs_struct via PTRACE_GETREGSET.
> On some architectures where a register is used as both the first
> argument and the return value and thus will be changed at some stage of
> the syscall process, something like orig_a0 is provided to save the
> original argument register value. But RISC-V doesn't export orig_a0 in
> user_regs_struct (This ABI was designed at e2c0cdfba7f6 ("RISC-V:
> User-facing API").) so userspace application like strace will get the
> right or wrong result depends on the operation order in do_trap_ecall_u()
> function.
> 
> This requires we put the ENOSYS process after syscall_enter_from_user_mode()
> or syscall_handler()[1]. Unfortunately, the generic entry API
> syscall_enter_from_user_mode() requires we
> 
> *  process ENOSYS before syscall_enter_from_user_mode()
> *  or only set a0 to ENOSYS when the return value of
>    syscall_enter_from_user_mode() != -1
> 
> Again, if we choose the latter way to avoid conflict with the first
> issue, we will meet the third problem: strace depends on that kernel
> will return ENOSYS when syscall nr is -1 to implement their syscall
> tampering feature[2].
> 
> Actually, we tried the both ways in 52449c17bdd1 ("riscv: entry: set
> a0 = -ENOSYS only when syscall != -1") and 61119394631f ("riscv: entry:
> always initialize regs->a0 to -ENOSYS") before.

It's also impossible to save original syscall number before 
syscall_enter_from_user_mode() to use later because some API like ptrace() can 
change syscall number in syscall_enter_from_user_mode().

> 
> Naturally, there is a solution:
> 
> 1. Just add orig_a0 in user_regs_struct and let strace use it as
>    loongarch does. So only two problems, which can be resolved without
>    conflict, are left here.
> 
> The conflicts are the direct result of the limitation of generic entry
> API, so we have another two solutions:
> 
> 2. Give up the generic entry API, and switch back to the
>    architecture-specific standardalone implementation.
> 3. Redesign the generic entry API: the problem was caused by
>    syscall_enter_from_user_mode() using the value -1 (which is unused
>    normally) of syscall nr to inform syscall was reject by seccomp/bpf.

The issue of generic entry API is that -1 is invalid syscall number, but it 
still contains some information. It's similar to situation of Python's 
PyLong_As* API: all bits of return value are used to contains some information. 
Since there is no elegant way to implement sum type in C, we can split to into 
two value: the return value is just success or reject, and an argument to pass 
syscall out.

But from another angle, syscall number is in a7 register, so we can call the 
get_syscall_nr() after calling the syscall_enter_from_user_mode() to bypass the 
information lost of the return value of the syscall_enter_from_user_mode(). But 
in this way, the syscall number in the syscall_enter_from_user_mode() return 
value is useless, and we can remove it directly.

> 
> In theory, the Solution 1 is best:
> 
> *  a0 was used for two purposes in ABI, so using two variables to store
>    it is natural.
> *  Userspace can implement features without depending on the internal
>    behavior of the kernel.
> 
> Unfortunately, it's difficult to implement based on the current code.
> The RISC-V defined struct pt_regs as below:
> 
>         struct pt_regs {
>                 unsigned long epc;
>         ...
>                 unsigned long t6;
>                 /* Supervisor/Machine CSRs */
>                 unsigned long status;
>                 unsigned long badaddr;
>                 unsigned long cause;
>                 /* a0 value before the syscall */
>                 unsigned long orig_a0;
>         };
> 
> And user_regs_struct needs to be a prefix of struct pt_regs, so if we
> want to include orig_a0 in user_regs_struct, we will need to include
> Supervisor/Machine CSRs as well. It's not a big problem. Since
> struct pt_regs is the internal ABI of the kernel, we can reorder it.
> Unfortunately, struct user_regs_struct is defined as below:
> 
>         struct user_regs_struct {
>                 unsigned long pc;
>         ...
>                 unsigned long t6;
>         };
> 
> It doesn't contain something like reserved[] as padding to leave the
> space to add more registers from struct pt_regs!
> The loongarch do the right thing as below:
> 
>         struct user_pt_regs {
>                 /* Main processor registers. */
>                 unsigned long regs[32];
>         ...
>                 unsigned long reserved[10];
>         } __attribute__((aligned(8)));
> 
> RISC-V can't include orig_a0 in user_regs_struct without breaking UABI.
> 
> Need a discussion to decide to use which solution, or is there any
> other better solution?
> 
> [1]: https://github.com/strace/strace/issues/315
> [2]: https://lore.kernel.org/linux-riscv/20240627071422.GA2626@altlinux.org/
> 

