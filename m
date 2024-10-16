Return-Path: <linux-kernel+bounces-367997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F03A9A0943
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA0F1F2506A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51297208209;
	Wed, 16 Oct 2024 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFK6vEzt"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB5207A2C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081411; cv=none; b=NO8CorINie/OhliV/8cOO5ASmRd29QtDrxqZp3TWDc0m72G5TZgUGQlJ3ZkfX/0oFkRB0OtP2flwFnUB7gnX9J2eXiGaOC3RdE+r6Cn+Hem4kC2lZ+eL9NPjFMfpJ3r91A3U6p2KBMwzl1RynWBYPmPnsdfJ+/QeFFUDi32ojAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081411; c=relaxed/simple;
	bh=g4hria2kjOvDk8IaoRQucbzkPgNagiSckrXHznek9H4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F1TJiEEFBkpxTma/DTQjb1Yqm9ccjL70dU/xUzPTr7Pid6rYZpOH6uNQeY+YCLrtr+07oiBzll+VNAUcQCetGKm3ceAoYL7DT9Cvn9zBzzvZPo2bVqUTX6+t1OWJV/QYR6UVCyxgNpVz3EQNbX1zKHT/No4m+bp74kxNL0eCoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFK6vEzt; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20cceb8d8b4so6169745ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729081409; x=1729686209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vBHY9FAs4NKP1GiY+95UW1AiDL4Xgv00XpHW2Wn26lc=;
        b=hFK6vEztYS2hKPdBujBg+pN8ZlWriRlfIkkJCVl2A+x1gZOtDyQeYMG8KlbciRsiLW
         mPeW/w6LeMpdHH6E0YHUOPO0MkK2FlVfNU5NI82sB+HiRs3vemm3h16nr5A6rq71yjAh
         1wb5oCKBQ6qsj8k2X5jjUVh/AISrMYYextWMPTWBBf/0U3T6lgfXa4dkIyaJswa74Pjo
         PiZnbjMK2U5kRJg6i/4Ed3zIxUvwovbM7nQ0GlDItuycCwqpzcj+F3ESUiotsPV+fGrp
         ZHSriopHEL8BzASuUmsddCZziBDbR1BNoUxPG0DztGB0sINBH3e/g3ECZEefsFxHlOxO
         nXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729081409; x=1729686209;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBHY9FAs4NKP1GiY+95UW1AiDL4Xgv00XpHW2Wn26lc=;
        b=h7vJuXVmpQ+NLNNq7UyksK3P5j9ul/lc1otOFGJQD5+xg+FMDNIUexy+UTKK1PoMbC
         JUCfM0lS0ypK3j6c46evVVYKT9ZkAe0fasEoV/TQ0WN50kWt3baCWBGw78gX5WIiVKNK
         6gN2pY6/3YWb7N81XxIIXqdXji0cJ2opspYemiCP0jI84vH825e4vPhK0Mz6w5Fn6QO2
         /2qanvhnFVLRJy7Wk2jGzi4udC8mulpevmmYKbugdkvWcCkGKQvCksw8CRIcg+ejvn5A
         AXTsmuJA0rDnJd2YswTHM/GZbi6Y7WA/Kxu8FVcIB/TxSRMRyVkFhBddZuXIv1h1QC/+
         2hpw==
X-Forwarded-Encrypted: i=1; AJvYcCUo79aJUf1UvaH1iUWHb03MX62nY6+zCf8ny6tIvaOMm6SOPP49/c5jUz7jLWh70elzIvqbipZUOXxcgdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95TJ5eT8RMHeXF1kv16Up7DCCWqGYMGMRnnYxgoKpAlG4asEs
	b8C3YhbE/gFjWJGChEAGjmTEF27LV8z5yAgl6cUUEhqUXI4ZLGUL
X-Google-Smtp-Source: AGHT+IEsjKep+XuZi/4hkoXyjUhcayMiOzuTHUGs9KI3P6LwYZQDTOdYKVJeidhCZGkdLA/RHzGGuw==
X-Received: by 2002:a17:902:da91:b0:20c:5ffe:3ef1 with SMTP id d9443c01a7336-20ca03a07damr279907725ad.17.1729081409337;
        Wed, 16 Oct 2024 05:23:29 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805b005sm27444905ad.240.2024.10.16.05.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 05:23:28 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <6b744fa3-5c1d-460d-bb09-5bc48379d598@gmail.com>
Date: Wed, 16 Oct 2024 20:23:22 +0800
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
Content-Language: en-GB-large
In-Reply-To: <6b2ff48a-ab43-4866-af5a-b8b7d3c23582@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-10-16 20:00, Alexandre Ghiti wrote:
> Hi Celeste,
> 
> Thank you for looking into this and really sorry about the late response.
> 
> On 17/09/2024 06:09, Celeste Liu wrote:
>> Before PTRACE_GET_SYSCALL_INFO was implemented in v5.3, the only way to
>> get syscall arguments was to get user_regs_struct via PTRACE_GETREGSET.
>> On some architectures where a register is used as both the first
>> argument and the return value and thus will be changed at some stage of
>> the syscall process, something like orig_a0 is provided to save the
>> original argument register value. But RISC-V doesn't export orig_a0 in
>> user_regs_struct (This ABI was designed at e2c0cdfba7f6 ("RISC-V:
>> User-facing API").) so userspace application like strace will get the
>> right or wrong result depends on the operation order in do_trap_ecall_u()
>> function.
>>
>> This requires we put the ENOSYS process after syscall_enter_from_user_mode()
>> or syscall_handler()[1]. Unfortunately, the generic entry API
>> syscall_enter_from_user_mode() requires we
>>
>> *  process ENOSYS before syscall_enter_from_user_mode()
> 
> 
> Where does this requirement come from?
> 
> 
>> *  or only set a0 to ENOSYS when the return value of
>>     syscall_enter_from_user_mode() != -1
>>
>> Again, if we choose the latter way to avoid conflict with the first
>> issue, we will meet the third problem: strace depends on that kernel
>> will return ENOSYS when syscall nr is -1 to implement their syscall
>> tampering feature[2].
> 
> 
> IIUC, seccomp and others in syscall_enter_from_user_mode() could return -1 and then we could not differentiate with the syscall number being -1.
> 
> But could we imagine, to distinguish between an error and the syscall number being -1, checking again the syscall number after we call syscall_enter_from_user_mode()? If the syscall number is -1, then we set ENOSYS otherwise we don't do anything (a bit like what you did in 52449c17bdd1 ("riscv: entry: set a0 = -ENOSYS only when syscall != -1")).
> 
> Let me know if I completely misunderstood here!

Yeah. I found this a bit later after I post this RFC. I include it in a update reply,
copy here as well:

> But from another angle, syscall number is in a7 register, so we can call the 
> get_syscall_nr() after calling the syscall_enter_from_user_mode() to bypass the 
> information lost of the return value of the syscall_enter_from_user_mode(). But 
> in this way, the syscall number in the syscall_enter_from_user_mode() return 
> value is useless, and we can remove it directly.

So if we get syscall number from a7 register again, the syscall number part of 
the return value of syscall_enter_from_user_mode() is useless completely. 
I think it's better to drop it so the later new architecture developer will not 
run into the same issue. (Actually, the syscall number returned by 
syscall_enter_from_user_mode() is also the result of get_syscall_nr() at the end 
of it.) But it will affect other architecture's code so I think there still need 
some discussions.

Or if you think it's better to post a patch and then discuss in patch thread 
directly, I'm glad to do this.

> 
> Thanks again for the thorough explanation,
> 
> Alex
> 
> 
>>
>> Actually, we tried the both ways in 52449c17bdd1 ("riscv: entry: set
>> a0 = -ENOSYS only when syscall != -1") and 61119394631f ("riscv: entry:
>> always initialize regs->a0 to -ENOSYS") before.
>>
>> Naturally, there is a solution:
>>
>> 1. Just add orig_a0 in user_regs_struct and let strace use it as
>>     loongarch does. So only two problems, which can be resolved without
>>     conflict, are left here.
>>
>> The conflicts are the direct result of the limitation of generic entry
>> API, so we have another two solutions:
>>
>> 2. Give up the generic entry API, and switch back to the
>>     architecture-specific standardalone implementation.
>> 3. Redesign the generic entry API: the problem was caused by
>>     syscall_enter_from_user_mode() using the value -1 (which is unused
>>     normally) of syscall nr to inform syscall was reject by seccomp/bpf.
>>
>> In theory, the Solution 1 is best:
>>
>> *  a0 was used for two purposes in ABI, so using two variables to store
>>     it is natural.
>> *  Userspace can implement features without depending on the internal
>>     behavior of the kernel.
>>
>> Unfortunately, it's difficult to implement based on the current code.
>> The RISC-V defined struct pt_regs as below:
>>
>>          struct pt_regs {
>>                  unsigned long epc;
>>          ...
>>                  unsigned long t6;
>>                  /* Supervisor/Machine CSRs */
>>                  unsigned long status;
>>                  unsigned long badaddr;
>>                  unsigned long cause;
>>                  /* a0 value before the syscall */
>>                  unsigned long orig_a0;
>>          };
>>
>> And user_regs_struct needs to be a prefix of struct pt_regs, so if we
>> want to include orig_a0 in user_regs_struct, we will need to include
>> Supervisor/Machine CSRs as well. It's not a big problem. Since
>> struct pt_regs is the internal ABI of the kernel, we can reorder it.
>> Unfortunately, struct user_regs_struct is defined as below:
>>
>>          struct user_regs_struct {
>>                  unsigned long pc;
>>          ...
>>                  unsigned long t6;
>>          };
>>
>> It doesn't contain something like reserved[] as padding to leave the
>> space to add more registers from struct pt_regs!
>> The loongarch do the right thing as below:
>>
>>          struct user_pt_regs {
>>                  /* Main processor registers. */
>>                  unsigned long regs[32];
>>          ...
>>                  unsigned long reserved[10];
>>          } __attribute__((aligned(8)));
>>
>> RISC-V can't include orig_a0 in user_regs_struct without breaking UABI.
>>
>> Need a discussion to decide to use which solution, or is there any
>> other better solution?
>>
>> [1]: https://github.com/strace/strace/issues/315
>> [2]: https://lore.kernel.org/linux-riscv/20240627071422.GA2626@altlinux.org/
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

