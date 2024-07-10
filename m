Return-Path: <linux-kernel+bounces-248218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A1592D9FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA881C21901
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423FE18C161;
	Wed, 10 Jul 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="KW2wrhct"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313F82C7E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643351; cv=none; b=Y3zxQTLb1gdirKQAXhsrMnFc8TnPR8WCFzkRk+mrtkIqeaSIdxV9WaHTVTsLMI12dOC1fZ9BPEOwG600KhDvUmptGDuPiMHsZlkprC6Pg615Fov/wAyBFDZLjmQV24RyZ0qlQLuUBTEvxqN342IQ3kGNVCsw4OC9vrrcMw+1x9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643351; c=relaxed/simple;
	bh=aviiTDRY0bsEOCBPae67oVEUlf7gNlc4dFQFO1G6pCM=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=E1e3ry1EB8fdGLP/byySDkBIXX76jjVZYANmNXl2yjpVs5Zd/1MJ6HfVMrAneuqBN20m4TyaYaQFE1r2oPNjYQCvBoSCWz3P6tYMCsJFYtpIxoc0bmDs2+grivmTlNjgV2ILYDzF/zmjj8uPuIMkNCB1E3OW60Ni+iQRHJPrQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=KW2wrhct; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so753465ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1720643348; x=1721248148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9Jh61oaEKliaSwIZFgGg8qqA5jeNy5zpxj6UTvdMkA=;
        b=KW2wrhctXcauvFTPzT7Eji+8yADPnesQARvcW6hWUwrXM+EPDD9lMz7+PIC2JT09ZH
         haYUy+vCXaZUO7qrkLWi59TUMb50ewv/rFKhY232yjQyV+e17mLVwttwyJbWs1eQBixL
         T9PRCQ6t9Eu7jh2MJPg7NL2j+rsqvTijwV8ht3FEAHUM0wy/dNxsIF4l1aZaFf9MLcSw
         yWDmXDuSyJy64ykfKwvmGpf5uywIx1wMphxBpr78PH4YgNxRRyjdPZdRkdfJciPZTmRI
         FbNvrdc3HTilRbRtJzA7ClknM7zUScsesXiSlzE5sS3ETF+0eSLiROIUm3yKin4q/AyI
         TPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720643348; x=1721248148;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Jh61oaEKliaSwIZFgGg8qqA5jeNy5zpxj6UTvdMkA=;
        b=Zp7nKq/UDAOXFmQJX5rhGaK+kViPnjGvwr9O3HmP16P9M/w94ULPlRs6sBnGkVXDxJ
         K0boY5wcAeJ22v1H914t/dE+I+TfxmKZZUwXSSpwiwfOj5gF/LnQIs7OS/5/aJV/NkIc
         Zt1DSeQODuY6u+U8AzZ1uRsqjysz2wZyuJJ+vILA05QAvTE9akXcJNN0ii9c9YerH8Cb
         v37AAzPVK09BOTUdBZCIXIS1SumaMf0ZWUHYq/h9Zrwg3xYWdBZpgdjRaApmK5nWjfWq
         4Mq1Zu8rBQEy7PEEOoU8umxbKNXvxl9xBWGATBJ1TV11JX5z699ax/yqzqTjzop19EAd
         Xlaw==
X-Forwarded-Encrypted: i=1; AJvYcCXS6LZoU2QS6RY2kLeUB96tJEaXR4pKrBr0uKN4khISsThSYTwEaT/9Pyd81KdFMn4VcKJhz4Hj/iiwbvXXHW3/ULa34qLnqhtNGaeE
X-Gm-Message-State: AOJu0Yzx1B+bm1LDuDnLvwL2W69sc5P1Vg5Acs5zKb4yOK6/HIFphTU/
	0CnVb597Pq+wmIyXd4as2IhLXFMQT5ndOQWyZW9AXn8D7XrBCVlcvl5HCOULaGk=
X-Google-Smtp-Source: AGHT+IHkN3wezxBsIV0zHctf199qNKvRrwDmVBtSLnKr6600ZgO/7nwox3pBjf5wITinUw8jnsF1Uw==
X-Received: by 2002:a17:903:41ca:b0:1fb:3b89:b11d with SMTP id d9443c01a7336-1fbb6d25286mr60172855ad.4.1720643348129;
        Wed, 10 Jul 2024 13:29:08 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7d90sm37639435ad.172.2024.07.10.13.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 13:29:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:29:07 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Jul 2024 13:29:05 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: Add tracepoints for SBI calls and returns
In-Reply-To: <49976c4d-b171-4c08-b05f-94b9a897151b@sifive.com>
CC: alexghiti@rivosinc.com, linux-riscv@lists.infradead.org, ajones@ventanamicro.com,
  aou@eecs.berkeley.edu, apatel@ventanamicro.com, Marc Zyngier <maz@kernel.org>,
  Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: samuel.holland@sifive.com
Message-ID: <mhng-0586882e-4507-4992-831e-4ed5e5c9a922@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 20:39:27 PDT (-0700), samuel.holland@sifive.com wrote:
> Hi Alex,
>
> On 2024-03-22 4:27 AM, Alexandre Ghiti wrote:
>> On Fri, Mar 22, 2024 at 12:01 AM Samuel Holland
>> <samuel.holland@sifive.com> wrote:
>>>
>>> These are useful for measuring the latency of SBI calls. The SBI HSM
>>> extension is excluded because those functions are called from contexts
>>> such as cpuidle where instrumentation is not allowed.
>>>
>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>>
>>> Changes in v2:
>>>  - Remove some blank lines
>>>
>>>  arch/riscv/include/asm/trace.h | 54 ++++++++++++++++++++++++++++++++++
>>>  arch/riscv/kernel/sbi.c        |  7 +++++
>>>  2 files changed, 61 insertions(+)
>>>  create mode 100644 arch/riscv/include/asm/trace.h
>>>
>>> diff --git a/arch/riscv/include/asm/trace.h b/arch/riscv/include/asm/trace.h
>>> new file mode 100644
>>> index 000000000000..6151cee5450c
>>> --- /dev/null
>>> +++ b/arch/riscv/include/asm/trace.h
>>> @@ -0,0 +1,54 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#undef TRACE_SYSTEM
>>> +#define TRACE_SYSTEM riscv
>>> +
>>> +#if !defined(_TRACE_RISCV_H) || defined(TRACE_HEADER_MULTI_READ)
>>> +#define _TRACE_RISCV_H
>>> +
>>> +#include <linux/tracepoint.h>
>>> +
>>> +TRACE_EVENT_CONDITION(sbi_call,
>>> +       TP_PROTO(int ext, int fid),
>>> +       TP_ARGS(ext, fid),
>>> +       TP_CONDITION(ext != SBI_EXT_HSM),
>>> +
>>> +       TP_STRUCT__entry(
>>> +               __field(int, ext)
>>> +               __field(int, fid)
>>> +       ),
>>> +
>>> +       TP_fast_assign(
>>> +               __entry->ext = ext;
>>> +               __entry->fid = fid;
>>> +       ),
>>> +
>>> +       TP_printk("ext=0x%x fid=%d", __entry->ext, __entry->fid)
>>> +);
>>> +
>>> +TRACE_EVENT_CONDITION(sbi_return,
>>> +       TP_PROTO(int ext, long error, long value),
>>> +       TP_ARGS(ext, error, value),
>>> +       TP_CONDITION(ext != SBI_EXT_HSM),
>>> +
>>> +       TP_STRUCT__entry(
>>> +               __field(long, error)
>>> +               __field(long, value)
>>> +       ),
>>> +
>>> +       TP_fast_assign(
>>> +               __entry->error = error;
>>> +               __entry->value = value;
>>> +       ),
>>> +
>>> +       TP_printk("error=%ld value=0x%lx", __entry->error, __entry->value)
>>> +);
>>> +
>>> +#endif /* _TRACE_RISCV_H */
>>> +
>>> +#undef TRACE_INCLUDE_PATH
>>> +#undef TRACE_INCLUDE_FILE
>>> +
>>> +#define TRACE_INCLUDE_PATH asm
>>> +#define TRACE_INCLUDE_FILE trace
>>> +
>>> +#include <trace/define_trace.h>
>>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>>> index e66e0999a800..a1d21d8f5293 100644
>>> --- a/arch/riscv/kernel/sbi.c
>>> +++ b/arch/riscv/kernel/sbi.c
>>> @@ -14,6 +14,9 @@
>>>  #include <asm/smp.h>
>>>  #include <asm/tlbflush.h>
>>>
>>> +#define CREATE_TRACE_POINTS
>>> +#include <asm/trace.h>
>>> +
>>>  /* default SBI version is 0.1 */
>>>  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
>>>  EXPORT_SYMBOL(sbi_spec_version);
>>> @@ -31,6 +34,8 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>>>  {
>>>         struct sbiret ret;
>>>
>>> +       trace_sbi_call(ext, fid);
>>> +
>>>         register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
>>>         register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
>>>         register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
>>> @@ -46,6 +51,8 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>>>         ret.error = a0;
>>>         ret.value = a1;
>>>
>>> +       trace_sbi_return(ext, ret.error, ret.value);
>>> +
>>>         return ret;
>>>  }
>>>  EXPORT_SYMBOL(sbi_ecall);
>>> --
>>> 2.43.1
>>>
>>
>> sbi_ecall() is used by flush_icache_all() so I was a bit scared we
>> would need to patch 2 instructions using a tracepoint and then to use
>> flush_icache_all() which could bug if only one of the patched
>> instruction was seen. But I took a look at the disassembled code, and
>> tracepoints happen to only need to patch 1 nop into an unconditional
>> jump, which is not a problem then.
>
> Right, tracepoints use the static branch infrastructure, which uses a single
> instruction.
>
>> But then when disassembling, I noticed that the addition of the
>> tracepoint comes with "quite" some overhead:
>>
>> Before:
>>
>> Dump of assembler code for function sbi_ecall:
>>    0xffffffff800085e0 <+0>: add sp,sp,-32
>>    0xffffffff800085e2 <+2>: sd s0,24(sp)
>>    0xffffffff800085e4 <+4>: mv t1,a0
>>    0xffffffff800085e6 <+6>: add s0,sp,32
>>    0xffffffff800085e8 <+8>: mv t3,a1
>>    0xffffffff800085ea <+10>: mv a0,a2
>>    0xffffffff800085ec <+12>: mv a1,a3
>>    0xffffffff800085ee <+14>: mv a2,a4
>>    0xffffffff800085f0 <+16>: mv a3,a5
>>    0xffffffff800085f2 <+18>: mv a4,a6
>>    0xffffffff800085f4 <+20>: mv a5,a7
>>    0xffffffff800085f6 <+22>: mv a6,t3
>>    0xffffffff800085f8 <+24>: mv a7,t1
>>    0xffffffff800085fa <+26>: ecall
>>    0xffffffff800085fe <+30>: ld s0,24(sp)
>>    0xffffffff80008600 <+32>: add sp,sp,32
>>    0xffffffff80008602 <+34>: ret
>>
>> After:
>>
>> Dump of assembler code for function sbi_ecall:
>>    0xffffffff8000bbf2 <+0>: add sp,sp,-112
>>    0xffffffff8000bbf4 <+2>: sd s0,96(sp)
>>    0xffffffff8000bbf6 <+4>: sd s1,88(sp)
>>    0xffffffff8000bbf8 <+6>: sd s3,72(sp)
>>    0xffffffff8000bbfa <+8>: sd s4,64(sp)
>>    0xffffffff8000bbfc <+10>: sd s5,56(sp)
>>    0xffffffff8000bbfe <+12>: sd s6,48(sp)
>>    0xffffffff8000bc00 <+14>: sd s7,40(sp)
>>    0xffffffff8000bc02 <+16>: sd s8,32(sp)
>>    0xffffffff8000bc04 <+18>: sd s9,24(sp)
>>    0xffffffff8000bc06 <+20>: sd ra,104(sp)
>>    0xffffffff8000bc08 <+22>: sd s2,80(sp)
>>    0xffffffff8000bc0a <+24>: add s0,sp,112
>>    0xffffffff8000bc0c <+26>: mv s1,a0
>>    0xffffffff8000bc0e <+28>: mv s3,a1
>>    0xffffffff8000bc10 <+30>: mv s9,a2
>>    0xffffffff8000bc12 <+32>: mv s8,a3
>>    0xffffffff8000bc14 <+34>: mv s7,a4
>>    0xffffffff8000bc16 <+36>: mv s6,a5
>>    0xffffffff8000bc18 <+38>: mv s5,a6
>>    0xffffffff8000bc1a <+40>: mv s4,a7
>>    0xffffffff8000bc1c <+42>: nop
>>    0xffffffff8000bc20 <+46>: mv a0,s9
>>    0xffffffff8000bc22 <+48>: mv a1,s8
>>    0xffffffff8000bc24 <+50>: mv a2,s7
>>    0xffffffff8000bc26 <+52>: mv a3,s6
>>    0xffffffff8000bc28 <+54>: mv a4,s5
>>    0xffffffff8000bc2a <+56>: mv a5,s4
>>    0xffffffff8000bc2c <+58>: mv a6,s3
>>    0xffffffff8000bc2e <+60>: mv a7,s1
>>    0xffffffff8000bc30 <+62>: ecall
>>    0xffffffff8000bc34 <+66>: mv s4,a0
>>    0xffffffff8000bc36 <+68>: mv s3,a1
>>    0xffffffff8000bc38 <+70>: nop
>>    0xffffffff8000bc3c <+74>: ld ra,104(sp)
>>    0xffffffff8000bc3e <+76>: ld s0,96(sp)
>>    0xffffffff8000bc40 <+78>: ld s1,88(sp)
>>    0xffffffff8000bc42 <+80>: ld s2,80(sp)
>>    0xffffffff8000bc44 <+82>: ld s5,56(sp)
>>    0xffffffff8000bc46 <+84>: ld s6,48(sp)
>>    0xffffffff8000bc48 <+86>: ld s7,40(sp)
>>    0xffffffff8000bc4a <+88>: ld s8,32(sp)
>>    0xffffffff8000bc4c <+90>: ld s9,24(sp)
>>    0xffffffff8000bc4e <+92>: mv a0,s4
>>    0xffffffff8000bc50 <+94>: mv a1,s3
>>    0xffffffff8000bc52 <+96>: ld s4,64(sp)
>>    0xffffffff8000bc54 <+98>: ld s3,72(sp)
>>    0xffffffff8000bc56 <+100>: add sp,sp,112
>>    0xffffffff8000bc58 <+102>: ret
>>
>> Not sure this is really problematic though, let me know what you think.
>
> The overhead is only incurred when tracepoints are enabled. But when they are
> enabled, I do not think it is avoidable, unless we were to hide this tracepoint
> behind some Kconfig option. I don't think the overhead enough to be a problem,
> but I suppose it's up to maintainer judgement.

IIUC it's actually just the printk() inside the tracepoint that's adding 
the overhead, not the tracepoints themselves?  We're shimming every SBI 
call through sbi_ecall(), which fills out every argument, so we end up 
saving/restoring them all around the printk().  We could convert these 
over to sbi_ecall_N like we do for syscalls in glibc, then we'd only 
need to save/restore the arguments that have something useful.

I'm going to pick this one up, though, as it's not directly a problem 
with the patch in question.  It's staged and should show up on for-next 
eventually, stuff might be a bit chaotic until we figure out all the 
poop...

>
> Regards,
> Samuel

