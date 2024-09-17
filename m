Return-Path: <linux-kernel+bounces-331803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC697B15F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD41F221CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F517A5BC;
	Tue, 17 Sep 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="uc5woxIp"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A117A59D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726582816; cv=none; b=roG+oxcX7h070Mqe8I4Gr0zBQ9u3EDXDG/DOjI1QsiShP7yDj55WlPGcU3v5H+rsSy2WC9yqC303y8+hzIQj0nF2oyGz9f8c4/SVCQIt3rI1FS/yNLPmjNPTzCrmuKRhBGozDAO5+wwzjZMAX2zoolWb/WlAH0menCJVgbk3Q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726582816; c=relaxed/simple;
	bh=gzsBCmCZ+sHII4BpfYv77Upd19HAMifJg0hgQugfsjU=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=d3wd+XyXzb6YDkqh8nXimZXzIiB9LlgbExcc1MWVk6t6fg9F9+Q9g6Ns3haycbIsu2N267CeauM+Uik5NLotDMp5druoH1t83jdSg58RIiouzP4S1TEy7yWEPCuGXbO89ohbPL8pI8qhj1yK872AiDaGXGhriUM6FQrYw15NmlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=uc5woxIp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2059112f0a7so39913205ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726582813; x=1727187613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdL61Vzu3BTEr7CEGvY+puN3FxvC19az+tAQQi++Frk=;
        b=uc5woxIph4luBkpvl+lukdptxuF40kAaL+sDM0KCx8kqp4+tmraItVx2lEoel5JcAs
         zauH+EakJ6fk0rkLksaa1d2V+Dq4FhLGn2BpYhdbgOa4YzhwIYrC1LU+RpeHQb6Ne+a7
         Vy/Cgo/kYF4mOuWIEbqtxJHkNKqRgQ4vTacFvQatQXhAoNQi6mb2nZwKvz3MeLqQMh86
         qhNoEwLZsHQMaeQy8tk/GqMBnsrqaQqL2UnNH08Ztiygn4htq3ZEzVQrwcjp9HB1lGe/
         Gk0ooPd82h/hI7066IrEKTw3iy6WapQ2NA0m/8E5AnGtyLTqxR2BkUV1dl3tXodWPvca
         +VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726582813; x=1727187613;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdL61Vzu3BTEr7CEGvY+puN3FxvC19az+tAQQi++Frk=;
        b=ohUWaLLMTEuCbZCRhidYnOwT0WUR21CEKdGqS/BirhHhgGgItBFuBlfCaXGOqiRaBt
         XeFiSDEqzEePWacoKZnvQIg8x6OhjPrtpL4b0f1WZ0uJlU03pet4wCru2v4boAefYHl7
         5zy4mEPAwpZKFgcgVQVsy11uzScx8QvQ90Cqg2u0c8tsU/8/6EOYA92mOVTDPBKcZQbt
         g9u3MMgEkzpzVTCfXahIR//7bH2xCVHXiolcmfETyOP94HE2evi541Jmh63QfaFvK44r
         jBTu8J2WOVRvwzK2nJOt7BxPIFm+afbLQB7xf358+Jwy2kUFY4Mr3Rg9KMDegv3+Ddg6
         SDow==
X-Forwarded-Encrypted: i=1; AJvYcCUsOrZ9j8NpTr2vvc/LNxFR4I9+/hAgyv0XqlvwK18tXeCpr5KV9lqoyz3UPrJLYsyVnGRao5LlflgacAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymgRaN0vz38UFLBfG/17ORWClTJ1cWKKrsvz1/oypbzdRRy0QK
	ORSwwujafHslIkXwVPIrfByb78fYsprMFbhzX1wRijcbxJXIxZZiPXHhaX213GE=
X-Google-Smtp-Source: AGHT+IHcJryk5a+VAtov1wClUHp+fEgnt1Hgjfaz8PxNFxvM7TUlxlfrBoOQZzFS3qOep8llbVD7UA==
X-Received: by 2002:a17:90a:6883:b0:2d3:bb9b:ce64 with SMTP id 98e67ed59e1d1-2dbb9ee099cmr19582656a91.30.1726582812870;
        Tue, 17 Sep 2024 07:20:12 -0700 (PDT)
Received: from localhost ([213.208.157.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd256eesm7302622a91.27.2024.09.17.07.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 07:20:12 -0700 (PDT)
Date: Tue, 17 Sep 2024 07:20:12 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Sep 2024 07:20:03 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Dynamically allocate cpumasks and further increase range and default value of NR_CPUS
In-Reply-To: <850f42c7-f7e6-4a35-bcf3-b3d1142f2fc8@huawei.com>
CC: ajones@ventanamicro.com, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
From: Palmer Dabbelt <palmer@dabbelt.com>
To: liuyuntao12@huawei.com
Message-ID: <mhng-20071cf1-848b-4ab7-9089-090eb99a6e68@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 05 Aug 2024 01:58:54 PDT (-0700), liuyuntao12@huawei.com wrote:
> Gentle ping

I think we just need to see some results for real hardware, as QEMU 
isn't meaningful for benchmarks like this.  My guess is we're not going 
to have an answer for a while, RISC-V really isn't anywhere close to 
having systems of this complexity yet.  So for now I think we should 
just leave the defaults alone, if hardware shows up where it makes sense 
to star changing things then we can take a look again.

>
> On 2024/6/26 20:41, liuyuntao (F) wrote:
>>
>>
>> On 2024/6/25 19:44, liuyuntao (F) wrote:
>>>
>>>
>>> On 2024/6/25 19:11, Andrew Jones wrote:
>>>> On Fri, Jun 14, 2024 at 07:53:06AM GMT, Yuntao Liu wrote:
>>>>> Currently default NR_CPUS is 64 for riscv64, since the latest QEMU virt
>>>>> machine supports up to 512 CPUS, so set default NR_CPUS 512 for
>>>>> riscv64.
>>>>>
>>>>> Under the promotion of RISC-V International and related chip
>>>>> manufacturers, RISC-V has also begun to enter the server market, which
>>>>> demands higher performance. Other major architectures (such as ARM64,
>>>>> x86_64, MIPS, etc) already have a higher range, so further increase
>>>>> this range up to 4096 for riscv64.
>>>>>
>>>>> Due to the fact that increasing NR_CPUS enlarges the size of cpumasks,
>>>>> there is a concern that this could significantly impact stack usage,
>>>>> especially for code that allocates cpumasks on the stack. To address
>>>>> this, we have the option to enable CPUMASK_OFFSTACK, which prevents
>>>>> cpumasks from being allocated on the stack. we choose to enable this
>>>>> feature only when NR_CPUS is greater than 512, why 512, since then
>>>>> the kernel size with offstack is smaller.
>>>>
>>>> This isn't the reason why Arm decided to start at 512, afaict. The
>>>> reason
>>>> for Arm was because hackbench did better with onstack for 256. What are
>>>> the hackbench results for riscv?
>>>
>>> Okay, I will add the test results of hacktest soon.
>>
>> Benchmark results using hackbench average over 5 runs of
>> ./hackbench -s 512 -l 20 -g 10 -f 50 -P
>> on Qemu.
>>
>> NR_CPUS     64      128     256     512     1024    2048
>> onstack/s   6.9992  6.6112  6.7834  6.6578  6.6646  6.8692
>> offstack/s  6.5616  6.95    6.5698  6.91    6.663   6.8202
>> difference  -6.25%  +5.12%  -3.15%  +3.79%  -0.02%  -0.71%
>>
>> When there are more cores, the fluctuation is minimal, leading to the
>> speculation that the performance gap would be smaller with a higher
>> number of NR_CPUS.
>> Since I don't have a RISCV single-board computer, these are the results
>> I obtained from testing in QEMU, which may differ from the actual
>> situation. Perhaps someone could help with the testing.
>>
>> Thanks,
>> Yuntao
>>
>>>
>>>>
>>>>>
>>>>> vmlinux size comparison(difference to vmlinux_onstack_NR_CPUS
>>>>> baseline):
>>>>>
>>>>> NR_CPUS     256         512         1024        2048        4096
>>>>> onstack     19814536    19840760    19880584    19969672    20141704
>>>>> offstack    19819144    19840936    19880480    19968544    20135456
>>>>> difference  +0.023%     +0.001%     -0.001%     -0.001      -0.031%
>>>>> is_smaller  n           n           y           y           y
>>>>
>>>> Since the savings are almost nothing we must not have too many global
>>>> cpumasks. But I'm in favor of ensuring stack depths stay under control,
>>>> so turning on CPUMASK_OFFSTACK sounds good to me in general.
>>>>
>>>>>
>>>>> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
>>>>> ---
>>>>>   arch/riscv/Kconfig | 5 +++--
>>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>>> index 0525ee2d63c7..5960713b3bf9 100644
>>>>> --- a/arch/riscv/Kconfig
>>>>> +++ b/arch/riscv/Kconfig
>>>>> @@ -77,6 +77,7 @@ config RISCV
>>>>>       select CLINT_TIMER if RISCV_M_MODE
>>>>>       select CLONE_BACKWARDS
>>>>>       select COMMON_CLK
>>>>> +    select CPUMASK_OFFSTACK if NR_CPUS > 512
>>>>>       select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
>>>>>       select EDAC_SUPPORT
>>>>>       select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER &&
>>>>> !DYNAMIC_FTRACE)
>>>>> @@ -428,11 +429,11 @@ config SCHED_MC
>>>>>   config NR_CPUS
>>>>>       int "Maximum number of CPUs (2-512)"
>>>>>       depends on SMP
>>>>> -    range 2 512 if !RISCV_SBI_V01
>>>>> +    range 2 4096 if !RISCV_SBI_V01
>>>>>       range 2 32 if RISCV_SBI_V01 && 32BIT
>>>>>       range 2 64 if RISCV_SBI_V01 && 64BIT
>>>>>       default "32" if 32BIT
>>>>> -    default "64" if 64BIT
>>>>> +    default "512" if 64BIT
>>>>
>>>> This is somewhat reasonable, even if nothing is going to use this for
>>>> quite a while, since it'll help avoid bugs popping up when NR_CPUS gets
>>>> bumped later, but it feels excessive right now for riscv, so I'm a bit
>>>> on the fence about it. Maybe if hackbench doesn't show any issues we
>>>> could turn CPUMASK_OFFSTACK on for a smaller NR_CPUS and also select
>>>> a smaller default?
>>>>
>>
>> It seems that when NR_CPUS is larger, hackbench performs better, and
>> which NR_CPUS do you have a preference for?
>>
>>>> Thanks,
>>>> drew
>>>>
>>>>>   config HOTPLUG_CPU
>>>>>       bool "Support for hot-pluggable CPUs"
>>>>> --
>>>>> 2.34.1
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-riscv mailing list
>>>>> linux-riscv@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv

