Return-Path: <linux-kernel+bounces-244750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A0A92A8E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35B31C2159A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B5B149C60;
	Mon,  8 Jul 2024 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo7s0/tN"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1079FD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462927; cv=none; b=p+Nal1o8G3KcBfwUlo24IsZF6GBUGab5U3UbjkUsGiMrMZ3fBLnIcpJ+mcx4nJDgGS9Ll6/UcevdXwxFzsgh86fOyWDvzy7n482nu9GKS7b7LCwgjhD86ecmbergLX8yYdBMbvNzdfmPxynOvSrMtrgH53yjZ3LjcZedyakHquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462927; c=relaxed/simple;
	bh=ASD8hN8TG36mmr00aa5uBglHySNG5BqaqEcibqD+BlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhoAX/7SflMGPlfsm2qJpoDqIiZY0YHXUxzqc+Iqa/Z27H16qHKRVSqgUMJCl29SmaWEhcrUIgENhaoR3RL1bC9kQdhoMvYhNiOLaPtif4UkZXBmwdgof0byXSihaQzWWp61kkXZFTLmoVM2gMg651/CNRDs52v7VYspcM16c5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo7s0/tN; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso6416016e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720462923; x=1721067723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjyjnJnEQpeHd1oehAYH/Wv1ipq+Dn9NqOSMH3MKAP4=;
        b=jo7s0/tNmu7LdUqGRUegNnCl/Ofc6rOG9W9OzH8vw7vdIo58tHbUX0ADyMwyytKOil
         FQx1XvgW46Kh0ZvJ89aDPrD0k475baq4YToAiAIuC7OQiYjwAkwq3di+QiIpVwEYdjby
         5N7FqdNHK6U/sI0G0QM0H7fJGORKK+BjvVhj8ZwxKfT8UT2Giar3HcVZhihUuGxdcFLa
         +M+kbXSoZfopJ2yicnt8PD07EC041orNK3BZiVMayKlAZ+rYtrjLCPx4ddXAAFILT0jg
         8QfMni8lIdZ/EXaq74CzG3S7XCjQvOpg7ZP50qtT3OdNHevhux+xr3LMO0X9hhiKn90X
         CjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462923; x=1721067723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjyjnJnEQpeHd1oehAYH/Wv1ipq+Dn9NqOSMH3MKAP4=;
        b=qtfq1ju4HP5aCRFxGvuMtC2plE77FpkO9iTF2amDqrkgFFkoidPeYN5F2nUYRkaqQc
         7xCET1ai88BgltxvGRjRmQPWAuJKKY05tjXY2kP8AMwgabsdBp2HjGbjs4r5dp00z+U4
         mDFGdUO25zBUPRc/W0BQ67aoDL25H9P0qd32DEmnFHOoqqQxnF3UnIWmm3rKzeNXlDZ3
         /9oIfbwk9/YPNhn2YR8EvamlP4f3oSQcBTaZEvN3NoZ8RrrWYrNoCEqrkCdQfLXmPz0l
         txsAr7f0VRKL5wukt8LAvkBgxTvbV6NAN8R79aUr9IGQdwMRgf5taRn95x/wYQH0AiTT
         Xy1A==
X-Gm-Message-State: AOJu0YxyFma7ENw02J1PFFDTm8zYycniLk+dknCm3VQdhlkSY4Vo0CT1
	VIP5L0jCqxJ/q8ry/WQvxaxfXieFgjmuqjlYSIj1JxCGijIXMufu
X-Google-Smtp-Source: AGHT+IGXgcPAilWge1ehIvUcr17pjhv6gaJcvBP5bvXp5jfR9kVUTPVdA2vlBxhWymjq7djoKVn3Tw==
X-Received: by 2002:a05:651c:a09:b0:2ec:4d8a:785a with SMTP id 38308e7fff4ca-2eeb30ba739mr5584751fa.4.1720462921061;
        Mon, 08 Jul 2024 11:22:01 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-28.xnet.hr. [88.207.40.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a86f620sm13753366b.209.2024.07.08.11.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 11:22:00 -0700 (PDT)
Message-ID: <6a0b3545-e401-4c06-a466-d60e6e7ef17a@gmail.com>
Date: Mon, 8 Jul 2024 20:21:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] ./arch/x86/include/asm/pgtable_32.h:59:5: error:
 "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
To: Borislav Petkov <bp@alien8.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Yuntao Wang <ytcoode@gmail.com>,
 Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>
References: <f79ee8f6-3fba-4c5f-9dc4-371906c529a8@gmail.com>
 <20240708094958.GAZou2Rq4bCMCVln1C@fat_crate.local>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <20240708094958.GAZou2Rq4bCMCVln1C@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Borislav,

On 7/8/24 11:49, Borislav Petkov wrote:
> On Fri, Jul 05, 2024 at 11:52:30PM +0200, Mirsad Todorovac wrote:
>> Hi, all!
>>
>> This is the result of testing randconfig with KCONFIG_SEED=0xEE7AB52F in next-20240703 vanilla tree on
>> Ubuntu 22.04 LTS. GCC used is gcc (Ubuntu 12.3.0-1ubuntu1~22.04) 12.3.0.
>>
>> The particular error is as follows:
>>
>> In file included from arch/x86/kernel/head_32.S:29:
>> ./arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
>>    59 | #if PTRS_PER_PMD > 1
>>       |     ^~~~~~~~~~~~
>> cc1: all warnings being treated as errors
> 
> I can't reproduce that with your config ontop of
> 
> commit 0b58e108042b0ed28a71cd7edf5175999955b233 (HEAD, tag: refs/tags/next-20240703, refs/remotes/linux-next/master)
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Wed Jul 3 16:14:20 2024 +1000
> 
>     Add linux-next specific files for 20240703
>     
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> $ make ARCH=i386 -j128 CC=gcc HOSTCC=gcc
> ...
> 
>   OBJCOPY arch/x86/boot/setup.bin
>   BUILD   arch/x86/boot/bzImage
> Kernel: arch/x86/boot/bzImage is ready  (#1)
> 
> Something's missing.
> 
> Did you do
> 
> $ git clean -dqfx
> 
> before building?
> 
> Note that that cmd will clear *everything* so you better check your local tree
> before you run it:
> 
> $ git status
> 
> and then
> 
> $ git clean -dqfx
> 
> after having saved the files which you still need.
> 
> HTH.


Well, I tried your procedure and I got again this:

In file included from arch/x86/kernel/head_32.S:29:
./arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
   59 | #if PTRS_PER_PMD > 1
      |     ^~~~~~~~~~~~

Maybe you should try 

 1019  2024-07-08 20:18:10  make clean
 1020  2024-07-08 20:18:17  make randconfig
 1021  2024-07-08 20:18:32  time nice make -k W=1 -j 36 bindeb-pkg |& tee ../err-next-20230705-04p.log; date

Thanks.

Best regards,
Mirsad Todorovac

