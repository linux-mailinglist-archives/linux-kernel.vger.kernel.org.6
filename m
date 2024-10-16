Return-Path: <linux-kernel+bounces-368543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083079A110F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C68C1C22721
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2C212EF5;
	Wed, 16 Oct 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnBcS6QU"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD61206E86
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101421; cv=none; b=cGwrHTjQXxreuEA7zcPplycxInZXxAaHNnvDQ14y5Uuj1cS5hm0rr41IJ9bBi9M7i+jC0JlulphNdHE6B2uimclGvIh06yZA243L/IU9JO7Sz5W0Ow+P4TL90UaiYeTNIHdZctuz8kF0rjflcQA9HGrG9wvlLfUEkA5uEHxvHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101421; c=relaxed/simple;
	bh=8s1K9wD2HCH8gINSBjr1R6uuwclx6M20VrhR5QVFBAI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kFtqZR3FvT4aisJLbIfL6UTjMoI6uFpqx6mAkYeG7C0OYzL/usMa9mywGmYefA/UcClq24n0wMZD/3wNVU5Fk/8yce+1yMcDjeKUUC8YCbd6WBB3qkjU/5Fv5I7a1gXRN8DRety/XK78iz0rIkGYKKtgUirkG/FFZVIGyrXdizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnBcS6QU; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20cb47387ceso853395ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729101420; x=1729706220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZWGjvGxfX8EEAliHKilZCZ2TS/WFRhd2LTCSNsE6xI=;
        b=VnBcS6QUYRczr1SONE/Ic1dWn54Ruqclu4RKgHCXnBR0a3ZZvIQYq4dfCZyUrZAayA
         Um5oYU7de+zz2lGDgU4vcHWsygNlktubl/dL9Qrw0usyDgZj2RmafFgCtpTjhJOumUzb
         jlxzA3ngOopt2wof2h4IHJOOIFbR0GHF/9MMukWPpCrJR6qKx2kjChcNIA8LrzYLxHeT
         AE0t3mc3csj/sHKoBq3nFkBMvYuSS6gcuYxjoFiK8BPtfh10WXVRg4rtMEUXcuRKjaq0
         ScQD71qV0yvaKSPiViXlwXG2LO+A2C3t+/2qZPKaek1lpj0bWuSTD9H0GOOv+bR+h50o
         z3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101420; x=1729706220;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZWGjvGxfX8EEAliHKilZCZ2TS/WFRhd2LTCSNsE6xI=;
        b=gbWLaBWxykgrn5UBwJuIKPENTFYDEohzLJvscDtRHYuYIzzp3LQph0lUNPjAFbmK+2
         kNZuEzYFFPgyJ9uEWrzr1j/OzdwuO4g5mocHVo/TMPq5g8jz6k5qA+rYe8Det3vgPKHn
         xuOssr7wVPy/3ZGL3E7iIwVFFJlgKyVTlqrNWAjD2TR49Bf2sGNpe0kMp36E2zfWkpTM
         CrLnLtc+fOyXwYLe+zCNtEX8kyhwmQoVbKxlJIxiC/JCGrf1mTFrWkfplvAoS2+KSRfZ
         Jbce3yuzXmaQv+XfdyQoYCA8KxXjkB219JQhFDCwMTg7EtT0eidHArrOe8WBV8jjScX5
         bs2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwQm3brhxm2e3KfL91Ak2rcB2lBJfX10N9ZgDRkbn09WPskUHWQWi9jS4n/WIwVuzfaIQT8xtbjpwgr8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Lpr0nM69BazpNUt9Cr8eW97s9iI5tXbfZ6QOTSphW6WM3OKn
	dDytI51vA3FthRJFbQXA30edgzGJF79r3E1TgAYT6JlWCqrM2UrG
X-Google-Smtp-Source: AGHT+IFNGTY1Y7m+BkDSa9oA7wwuSFo3SqxArhkrrEGWefeZEweHFiqP/GUnA1YN3djsQQrFlYqoag==
X-Received: by 2002:a17:903:124b:b0:20c:e1f5:48c7 with SMTP id d9443c01a7336-20d27f2faf7mr57971925ad.55.1729101419457;
        Wed, 16 Oct 2024 10:56:59 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f994c5sm31660585ad.71.2024.10.16.10.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 10:56:58 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <1a481785-a874-4b13-8f1d-f7a1f233da50@gmail.com>
Date: Thu, 17 Oct 2024 01:56:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] riscv/entry: issue about a0/orig_a0 register and ENOSYS
Content-Language: en-GB-large
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
 <707db338-4429-49a6-bcab-39ab44c4f770@gmail.com>
In-Reply-To: <707db338-4429-49a6-bcab-39ab44c4f770@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-10-16 21:07, Celeste Liu wrote:

> 
> On 2024-10-16 20:56, Alexandre Ghiti wrote:
>> On 16/10/2024 14:23, Celeste Liu wrote:
>>> On 2024-10-16 20:00, Alexandre Ghiti wrote:
>>>> Hi Celeste,
>>>>
>>>> Thank you for looking into this and really sorry about the late response.
>>>>
>>>> On 17/09/2024 06:09, Celeste Liu wrote:
>>>>> Before PTRACE_GET_SYSCALL_INFO was implemented in v5.3, the only way to
>>>>> get syscall arguments was to get user_regs_struct via PTRACE_GETREGSET.
>>>>> On some architectures where a register is used as both the first
>>>>> argument and the return value and thus will be changed at some stage of
>>>>> the syscall process, something like orig_a0 is provided to save the
>>>>> original argument register value. But RISC-V doesn't export orig_a0 in
>>>>> user_regs_struct (This ABI was designed at e2c0cdfba7f6 ("RISC-V:
>>>>> User-facing API").) so userspace application like strace will get the
>>>>> right or wrong result depends on the operation order in do_trap_ecall_u()
>>>>> function.
>>>>>
>>>>> This requires we put the ENOSYS process after syscall_enter_from_user_mode()
>>>>> or syscall_handler()[1]. Unfortunately, the generic entry API
>>>>> syscall_enter_from_user_mode() requires we
>>>>>
>>>>> *  process ENOSYS before syscall_enter_from_user_mode()
>>>>
>>>> Where does this requirement come from?
>>>>
>>>>
>>>>> *  or only set a0 to ENOSYS when the return value of
>>>>>      syscall_enter_from_user_mode() != -1
>>>>>
>>>>> Again, if we choose the latter way to avoid conflict with the first
>>>>> issue, we will meet the third problem: strace depends on that kernel
>>>>> will return ENOSYS when syscall nr is -1 to implement their syscall
>>>>> tampering feature[2].
>>>>
>>>> IIUC, seccomp and others in syscall_enter_from_user_mode() could return -1 and then we could not differentiate with the syscall number being -1.
>>>>
>>>> But could we imagine, to distinguish between an error and the syscall number being -1, checking again the syscall number after we call syscall_enter_from_user_mode()? If the syscall number is -1, then we set ENOSYS otherwise we don't do anything (a bit like what you did in 52449c17bdd1 ("riscv: entry: set a0 = -ENOSYS only when syscall != -1")).
>>>>
>>>> Let me know if I completely misunderstood here!
>>> Yeah. I found this a bit later after I post this RFC. I include it in a update reply,
>>> copy here as well:
>>>
>>>> But from another angle, syscall number is in a7 register, so we can call the
>>>> get_syscall_nr() after calling the syscall_enter_from_user_mode() to bypass the
>>>> information lost of the return value of the syscall_enter_from_user_mode(). But
>>>> in this way, the syscall number in the syscall_enter_from_user_mode() return
>>>> value is useless, and we can remove it directly.
>>> So if we get syscall number from a7 register again, the syscall number part of
>>> the return value of syscall_enter_from_user_mode() is useless completely.
>>> I think it's better to drop it so the later new architecture developer will not
>>> run into the same issue. (Actually, the syscall number returned by
>>> syscall_enter_from_user_mode() is also the result of get_syscall_nr() at the end
>>> of it.) But it will affect other architecture's code so I think there still need
>>> some discussions.
>>>
>>> Or if you think it's better to post a patch and then discuss in patch thread
>>> directly, I'm glad to do this.
>>
>>
>> Great that we have a solution that does not need to change the ABI :)
>>
>> I think we should start by implementing a fix for riscv only that implements the get_syscall_nr() after syscall_enter_from_user_mode() so that we can merge that in 6.12-rcX.
>>
>> And after that, you could come with the nicer solution you propose.
>>
>> Do you think you can send a patch for the quick fix soon? In the meantime, I'm adding the strace testsuite to my CI to make sure it works and we don't break it again :)
> 
> Ok. I will send patch soon.

Patch has been sent. See https://lore.kernel.org/all/20241017-fix-riscv-syscall-nr-v1-1-4edb4ca07f07@gmail.com/T/

> 
>>
>> Thanks!
>>
>> Alex
>>
>>
>>>
>>>> Thanks again for the thorough explanation,
>>>>
>>>> Alex
>>>>
>>>>
>>>>> Actually, we tried the both ways in 52449c17bdd1 ("riscv: entry: set
>>>>> a0 = -ENOSYS only when syscall != -1") and 61119394631f ("riscv: entry:
>>>>> always initialize regs->a0 to -ENOSYS") before.
>>>>>
>>>>> Naturally, there is a solution:
>>>>>
>>>>> 1. Just add orig_a0 in user_regs_struct and let strace use it as
>>>>>      loongarch does. So only two problems, which can be resolved without
>>>>>      conflict, are left here.
>>>>>
>>>>> The conflicts are the direct result of the limitation of generic entry
>>>>> API, so we have another two solutions:
>>>>>
>>>>> 2. Give up the generic entry API, and switch back to the
>>>>>      architecture-specific standardalone implementation.
>>>>> 3. Redesign the generic entry API: the problem was caused by
>>>>>      syscall_enter_from_user_mode() using the value -1 (which is unused
>>>>>      normally) of syscall nr to inform syscall was reject by seccomp/bpf.
>>>>>
>>>>> In theory, the Solution 1 is best:
>>>>>
>>>>> *  a0 was used for two purposes in ABI, so using two variables to store
>>>>>      it is natural.
>>>>> *  Userspace can implement features without depending on the internal
>>>>>      behavior of the kernel.
>>>>>
>>>>> Unfortunately, it's difficult to implement based on the current code.
>>>>> The RISC-V defined struct pt_regs as below:
>>>>>
>>>>>           struct pt_regs {
>>>>>                   unsigned long epc;
>>>>>           ...
>>>>>                   unsigned long t6;
>>>>>                   /* Supervisor/Machine CSRs */
>>>>>                   unsigned long status;
>>>>>                   unsigned long badaddr;
>>>>>                   unsigned long cause;
>>>>>                   /* a0 value before the syscall */
>>>>>                   unsigned long orig_a0;
>>>>>           };
>>>>>
>>>>> And user_regs_struct needs to be a prefix of struct pt_regs, so if we
>>>>> want to include orig_a0 in user_regs_struct, we will need to include
>>>>> Supervisor/Machine CSRs as well. It's not a big problem. Since
>>>>> struct pt_regs is the internal ABI of the kernel, we can reorder it.
>>>>> Unfortunately, struct user_regs_struct is defined as below:
>>>>>
>>>>>           struct user_regs_struct {
>>>>>                   unsigned long pc;
>>>>>           ...
>>>>>                   unsigned long t6;
>>>>>           };
>>>>>
>>>>> It doesn't contain something like reserved[] as padding to leave the
>>>>> space to add more registers from struct pt_regs!
>>>>> The loongarch do the right thing as below:
>>>>>
>>>>>           struct user_pt_regs {
>>>>>                   /* Main processor registers. */
>>>>>                   unsigned long regs[32];
>>>>>           ...
>>>>>                   unsigned long reserved[10];
>>>>>           } __attribute__((aligned(8)));
>>>>>
>>>>> RISC-V can't include orig_a0 in user_regs_struct without breaking UABI.
>>>>>
>>>>> Need a discussion to decide to use which solution, or is there any
>>>>> other better solution?
>>>>>
>>>>> [1]: https://github.com/strace/strace/issues/315
>>>>> [2]: https://lore.kernel.org/linux-riscv/20240627071422.GA2626@altlinux.org/
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-riscv mailing list
>>>>> linux-riscv@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


