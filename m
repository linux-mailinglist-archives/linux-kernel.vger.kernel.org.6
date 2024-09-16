Return-Path: <linux-kernel+bounces-330878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF5497A59F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C57B22DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A0315AAB1;
	Mon, 16 Sep 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkqd7Mao"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B015A876
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502422; cv=none; b=QAlKZDqTuIxGW2vxBKz6s8q67PsOg8YyXAO7KsuY/s0KH3MYdobY7jwVh2LD9b5DSl5AQdUwUjzLVKhM9UHc59F5NZZcreklzZV3MN5sLHBnVYYlLA7VzHrDOMHMpV0pYC9SaYCzhaTjoJCqVt9TLy8/2fYjEEjokmp+2jxAvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502422; c=relaxed/simple;
	bh=9NtX4Akc6P2gDDZtOLnCEw3gaI01Mq2PLcNOJQNeNek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvzqCxvqx+6QrAqUYOFQ+SQWo/bAamiLtnD0oPhVk/yzRWBQBxEvdVPrHk2+5vxQFsD6EE+AWpdGZAvUzVdavb8YeL5TW5mbA0/DcrtkrN/YBPZWd/EB3+6+K+ZLRITijAZJ0H2+G2H9xhHukqd8nwKvgX8fGL/LlN1n4Gs49s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkqd7Mao; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3dd16257b7bso1650260b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726502418; x=1727107218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNGAscY89spos90KeV3lVrKQOCpirqeeQdiGtvmiPzE=;
        b=nkqd7Mao07aloSUiyDTYSdQkZsDA6UHXB6Hz/sSyBhshI0Y/UXTPLCPV+kcmAjnxFK
         xw/nbHR8uIZzZbRY587ASfuvDS01oZXpkcmkhNsTmnDWjMewjUe8/YWF6zs+x63e+MZ0
         etwgBJTEojLEu8tk8JoRdORT36/Dh/d7U/Ha2qanrDKvJkmog+ugbkBfEW6g9C0NVOn2
         g6lMhpWWbE/6YLsaPHM45Tk5R+mv0UiIXGr7m1FNmNyDiMAZbSwsS1J0VijworKSf/fG
         J81jhlD1ovH/DBqXsCe/K3YCsH+2/WSi6lFxv67Ma/2O7S3EGPQWZoNgIwO44uT5bMAG
         LCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726502418; x=1727107218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNGAscY89spos90KeV3lVrKQOCpirqeeQdiGtvmiPzE=;
        b=GUm5QxarNvWcvwwD+f3FBfs3pfg7Im3A6tXusDfxyojOQgC22iXgV1YA0OSqtUqg8d
         P8Jg916GE2JA7/yasDRxqhKWbj6QuEq8VkPbWnkH69cg1UrMZtN3N8cRt7MKLmMZ4oVR
         2PcuVYHqEV+y+JD+N/J5SK50GvkjqkkDqkxtnmaQDvJnrJuQjmu1R+EJB5PieIo+cs5A
         pokGWmREEyz1IAHQavQqRKGNasFFIhNkIVTmU9sPiFOvcZWyYjAs+fKzzWmmIUD+4lcL
         treKLV9NvFmrT+8gdaScBQD4Huw554d35t4ATZYrerGgaeeSFLnsi181KOGqiqF9bj2o
         IXqw==
X-Forwarded-Encrypted: i=1; AJvYcCUIy5ab3JPMlNMEGWX5r4QPydx2hRbJW9wy76rSpcfXVPHn7YYo0kSFvsA7vkniPV94j6h+cNK40oJOj+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WOXIECkcCLX4cbj34dfOxxa3I8x6FUTb7zCvMw0h9AaqfyIR
	Jq/Y1RlQ/aSCiPb617nPRnOprtlqfZlHoBB7d+7CDdXG6hhvAtS7
X-Google-Smtp-Source: AGHT+IEGKIXuDbJQCCB5TuWpGJZvTObpH6f7clkm5fgDiOimQFedACIetFrXdE6vcQkAOCKT02LUSQ==
X-Received: by 2002:a05:6871:3a06:b0:260:fb01:5651 with SMTP id 586e51a60fabf-27c3f253ae6mr10872804fac.12.1726502418233;
        Mon, 16 Sep 2024 09:00:18 -0700 (PDT)
Received: from [192.168.0.101] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b97581sm3875919b3a.151.2024.09.16.09.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 09:00:17 -0700 (PDT)
Message-ID: <110df06f-a598-4ffc-97c9-372a0fb858dc@gmail.com>
Date: Tue, 17 Sep 2024 00:00:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: cpufeature: Pretend that Apple A10 family
 does not support 32-bit EL0
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 Marc Zyngier <maz@kernel.org>
References: <20240909091425.16258-1-towinchenmi@gmail.com>
 <20240909091425.16258-3-towinchenmi@gmail.com>
 <f908c9ca-8063-44f4-b534-ddfc067b98c2@gmail.com> <ZuhPIdnx36yXJhHi@arm.com>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <ZuhPIdnx36yXJhHi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Catalin Marinas 於 2024/9/16 晚上11:30 寫道:
> On Mon, Sep 16, 2024 at 09:41:12PM +0800, Nick Chan wrote:
>> On 9/9/2024 17:10, Nick Chan wrote:
>>> The Apple A10 family consists of physical performance and efficiency
>>> cores, and only one of them can be active at a given time depending on
>>> the current p-state. However, only the performance cores can execute
>>> 32-bit EL0. This results in logical cores that can only execute 32-bit
>>> EL0 in high p-states.
>>
>> Further research shows that the MPIDR_EL1 values between the two core
>> types are different. And whether the two core type have any extra
>> differences is anyone's guess right now. So far, nothing seems to break
>> horribly without special workarounds for the MPIDR value (with cpufreq
>> enabled downstream) as:
>> 1. There are no KVM, GIC, ACPI, PSCI or cpuidle
>> 2. All CPUs switch P-mode and E-mode together
>>
>> However, all of this is broken enough that this piece of code should go
>> into arch/arm64/kernel/cpu_errata.c, and also generate a
>> TAINT_CPU_OUT_OF_SPEC for these cursed CPUs.
> 
> I wouldn't carry any additional logic in the kernel for such
> configuration (long time ago Arm had something similar, the big.LITTLE
> switcher, but the CPUs were fairly similar from a feature perspective).
This is fine from a functionality perspective, currently nothing that
accesses MPIDR after boot is used on A10(X). However, it does not sound
right either to not note that the kernel is running on a cursed CPU.

> 
>>> Trying to support 32-bit EL0 on a CPU that can only execute it in certain
>>> states is a bad idea. The A10 family only supports 16KB page size anyway
>>> so many AArch32 executables won't run anyways. Pretend that it does not
>>> support 32-bit EL0 at all.
> 
> CONFIG_COMPAT depends on ARM64_4K_PAGES || EXPERT. Do we really need
> these patches in case one enables EXPERT and tries to run 32-bit
> binaries that never ran on 16K pages before?
The worst thing that can happen is the 32-bit process crashes with illegal
instruction, the kernel will still be fine.

> 

Nick Chan


