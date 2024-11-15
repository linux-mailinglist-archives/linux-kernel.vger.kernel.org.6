Return-Path: <linux-kernel+bounces-410491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C91D9CDC44
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A52B2394E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B861B2EEB;
	Fri, 15 Nov 2024 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="aVVLi6Ze"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DED1B3942
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665666; cv=none; b=vB9PIuTZBd2Z5k2iNJSp2pXsxpGbC3WPefArhmMw1cwjxLnrOH6d6iqKBmgs3u1fv61mv3q339zC0F5R5udkqg6Hr3hyBP+nd3+mmB9NnsJ7NzLfUGFOLcYOsE1RQvZisWZz18nBD+/Nw9kWOHBXvy6uC5htZlkpNniQAUNaHgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665666; c=relaxed/simple;
	bh=Uzj8bLLjfUByZGOfsq1doW90ZF0n5SIAgG4exCcviQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPKf7VD+pqMjpfip3NSn8oYHL2Gb3pHNxjR3xbk/fRCrVnZ3dWnc/eg6WU3BrObHU90kHjxquWm6W3mhiZAlx5L1LJyncLg1Xg86o7lf2agUZ5vFNchuI1WrS+xrqF+YfWQgVXnQsQgjOYTLaQxJexgJGRW2RERHz7yNuZkyX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=aVVLi6Ze; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso297545066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1731665661; x=1732270461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ve0NmavM8DPMsEXD2qB9kFT0i3DIq6G98xpXzz+PPyo=;
        b=aVVLi6ZedpwoqFFY14G+dsMZKh5nikMBTB5nSD49OpjPIthahzA7eLNHTR68eW59Ey
         PG32vMcVxhxXKYddDgR3AIAYc5F96R37Q6SfIEc1E/vLUDAkZcNnvLsY6XEy1LeiMG7m
         FXuSDe3T/7OISlzalt6ZnJ5CTjy4skKZ3KFh7pzJKdcW4iVAVAlJ6XRw9Y6YBv4JNPaE
         tluzEqOdDJQk+jOW+S9985oiSxPkPCo67ZBEkQvhYFXclX6z6xbXp9V8ZEUqkXW9q8Nf
         3IlzA25m/Z4QdqhxxUIGARG5p6yjKp1D2oC7q6uxnV5+yowkAVQ2BKorieFuybibiF6R
         z18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731665661; x=1732270461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve0NmavM8DPMsEXD2qB9kFT0i3DIq6G98xpXzz+PPyo=;
        b=tIhev+KXZhTSlqvMvlgClRTrVbnDFpBmW/EA+hiY/d7CQ4Pow7jBxFW8l4VqVVodYv
         8Ah7wrp0ydi1COhuYds/R2HCRxRwTr0RRL4BLLztbb9pUUcHqNqJA7YCLk879VWWL059
         Lvihm3QLpRBIRi4I1IyJhYKSWzpqSRNofimowFFHI8RIFmwmzrxP3atu6cEtzH3j5zj4
         nUz81RjJR8Gmk/JryeEqAme7lSFvVtKHMWwfI1e+NmS8PzbgtK3NGcmlLZJSFJsi3RRV
         8cAQ0oJ7Hw4whDVhrnx9ecEfCPLDl3YhkxAObPHJ6ZgFHRlSmZyJS/ErJq/4Ao++XH9n
         c/Iw==
X-Gm-Message-State: AOJu0YxzFPmOZpds4BUc9TnMKiKMZU/9nQ9csKIqHi50CsnIQvBM5Y4V
	jAnFDYDwN6cNPxogy/nqQxMFbRRJ+QT3+5HplUDQYzf4uUI2BqOuGZ3xXvno+v1AxteMZlnCP0n
	IHA==
X-Google-Smtp-Source: AGHT+IFnO2g+WCczvHRDgCZ6tEWevg3D4XXveWYituvsLukOi93BFqoWZyaNDbNUO1O5jztHLXakyg==
X-Received: by 2002:a17:906:fe41:b0:a9a:17f5:79a8 with SMTP id a640c23a62f3a-aa48342166emr171903966b.13.1731665661497;
        Fri, 15 Nov 2024 02:14:21 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df272c2sm163293966b.6.2024.11.15.02.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 02:14:21 -0800 (PST)
Message-ID: <59973987-b0cc-4cbe-906b-8e58ffd291de@monstr.eu>
Date: Fri, 15 Nov 2024 11:14:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] microblaze: use the common infrastructure to support
 built-in DTB
To: Masahiro Yamada <masahiroy@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org
References: <20240918045431.607826-1-masahiroy@kernel.org>
 <0c4dc285-f218-4c88-87f3-b7c7c786cdba@monstr.eu>
 <CAK7LNASKooM0_LuPhB0c6AfUsEB0b1Q_mo0TQvuCO2BZqYJBsQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <CAK7LNASKooM0_LuPhB0c6AfUsEB0b1Q_mo0TQvuCO2BZqYJBsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/8/24 18:27, Masahiro Yamada wrote:
> On Fri, Nov 8, 2024 at 8:54 PM Michal Simek <monstr@monstr.eu> wrote:
>>
>>
>>
>> On 9/18/24 06:52, Masahiro Yamada wrote:
>>> MicroBlaze is the only architecture that supports a built-in DTB in
>>> its own way.
>>>
>>> Other architectures (e.g., ARC, NIOS2, RISC-V, etc.) use the common
>>> infrastructure introduced by commit aab94339cd85 ("of: Add support for
>>> linking device tree blobs into vmlinux").
>>>
>>> This commit migrates MicroBlaze to this common infrastructure.
>>>
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>> ---
>>>
>>> I do not know why MicroBlaze still adopts its own way.
>>> Perhaps, because MicroBlaze supports the built-in DTB
>>> before aab94339cd85 and nobody attempted migration.
>>> Anyway, I only compile-tested this patch.
>>> I hope the maintainer can do boot-testing.
>>
>> I took a look at it and it is changing current behavior.
>> If you look at linux.bin and there is no DT inside. But when you patch is
>> applied linux.bin contains system.dtb inside which is regression.
>> Or is it intention of this patch?
> 
> 
> I do not understand your comment.
> 
> If you look at the code in arch/microblaze/Makefile,
> DTB is empty unless you build simpleImage.%
> 
> 
> My patch still keeps obj-y within the
> ifneq ($(DTB),) ... endif  block.
> 
> 
> ifneq ($(DTB),)
> obj-y += system.dtb.o
>    [ snip ]
> endif
> 
> 
> So, when you build linux.bin, system.dtb is not embedded in vmlinux,
> is it?
> 
> 
> 
>> I think there was any documentation about it's usage in past but never really
>> described in upstream kernel.
>> But idea was that linux.bin requires DT to be passed from bootloader via R7 reg
>> but simpleImage.X is linux.bin+DTB inside and can be used without bootloader.
> 
> With my patch applied, it should still work like this.

I have looked at it again and there is an issue in behavior.
drivers/of/empty_root.dts is default dts/dtb which is placed to .dtb.init.rodata 
section in linux.bin.
It means by default kernel has DT in this location all the time.

Anyway let's go back to the patch.

You are removing __fdt_blob location which has 64kB size all the time.
(. = _fdt_start + 0x10000;       /* Pad up to 64kbyte */)
When DT is passed via R7 the code below is executed.

/* r7 may point to an FDT, or there may be one linked in.
    if it's in r7, we've got to save it away ASAP.
    We ensure r7 points to a valid FDT, just in case the bootloader
    is broken or non-existent */
	beqi	r7, no_fdt_arg			/* NULL pointer?  don't copy */
/* Does r7 point to a valid FDT? Load HEADER magic number */
	/* Run time Big/Little endian platform */
	/* Save 1 as word and load byte - 0 - BIG, 1 - LITTLE */
	lbui	r11, r0, TOPHYS(endian_check)
	beqid	r11, big_endian /* DO NOT break delay stop dependency */
	lw	r11, r0, r7 /* Big endian load in delay slot */
	lwr	r11, r0, r7 /* Little endian load */
big_endian:
	rsubi	r11, r11, OF_DT_HEADER	/* Check FDT header */
	beqi	r11, _prepare_copy_fdt
	or	r7, r0, r0		/* clear R7 when not valid DTB */
	bnei	r11, no_fdt_arg			/* No - get out of here */
_prepare_copy_fdt:
	or	r11, r0, r0 /* incremment */
	ori	r4, r0, TOPHYS(_fdt_start)
	ori	r3, r0, (0x10000 - 4)
_copy_fdt:
	lw	r12, r7, r11 /* r12 = r7 + r11 */
	sw	r12, r4, r11 /* addr[r4 + r11] = r12 */
	addik	r11, r11, 4 /* increment counting */
	bgtid	r3, _copy_fdt /* loop for all entries */
	addik	r3, r3, -4 /* descrement loop */
no_fdt_arg:


It copies passed DTB to location prepared location inside the kernel with max 
value of 64kB.

When your patch is applied and fdt_blob location is replaced by dtb_start 
location there is no 64kB space because in linux.bin there is only empty_root.dtb.
It means when DT is passed kernel itself rewrite data behind allocated space. As 
is visible from System.map.

c08d5400 D __dtb_empty_root_begin
c08d5400 D __dtb_start
c08d5448 D __dtb_empty_root_end
c08d5460 D __dtb_end
c08d5460 D __irqchip_of_table
c08d5460 d __of_table_xilinx_intc_opb
c08d5524 d __of_table_xilinx_intc_xps

It means your patch works properly when kernel has dtb inside (simpleImage) but 
break cases where DTB is passed via kernel command line.

And .dtb.init.rodata has all the time DTB inside with 0xd00dfeed marker that's 
why early_init_dt_verify() pass fdt_check_header() because marker is there. And 
likely fails later anyway.
I don't think this is key issue here but code flow is a little bit different 
then was before too.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs


