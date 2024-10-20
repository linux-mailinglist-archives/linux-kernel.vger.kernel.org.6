Return-Path: <linux-kernel+bounces-373088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFBB9A5214
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604471F22098
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 03:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B746BA;
	Sun, 20 Oct 2024 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H4FA+O8U"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74A322E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729394670; cv=none; b=Jx8/ykz7NU4GotqYsNaNt3whAQ6n6M/inUy0Kg26hk9z7efGr5NjfGNwWvYIBM9ntGfe2XZ0ajkCuO/itGpM9koi5gAnYAArA98DknJOt44krXQODG37Vo3eyTS8Vu8Xwy1cptuIWeF63ulXroF8XnaeMXhGVzHF1Z30iCKm0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729394670; c=relaxed/simple;
	bh=UmHXvjGsQJfT6nKZ2eAFDDs4DgbACPJ2CxbdthknAPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fruM8tuxqu7l0P9arFwqbAwceGKsXTrg1j4tLRBqP9ku9iEmOzn8m7rEAp3MDPwRMlWNtlseN5T+rvXlqzUBol88OiFxcQVIdsli+9uqG3Itqzm+jpX49O8TFfMc2t33FT+FqObM7qm/3uIkbK01vcAt7c2M3mQDxBvUy7easTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H4FA+O8U; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2300080a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 20:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729394666; x=1729999466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbc1A1lbWoXEL3ZrMG1PbnMccM33RUZTMomnfxj4fAM=;
        b=H4FA+O8U6IA3aYL+rNb4RcsuQHfwnZFJ5CrBb07sZULeBLyyxQtaoXnBCR6nFLfHh7
         V+Uy4AWoZcr3sF1nEzx7fouC2ycquXkBbnDKdsLkggBSpqI9lvF9PwVDQ6R2MAQAfy/B
         iy82BLQu+1LW20n+A5ai0JxiTFMKaEHato/Njfg07OtQW9azcfnWNI59NwVF6PuGPl/r
         dq1+6YA9pF6VDnzkkvJuR/yGbywxqdwbV8Tpk0oN6cmKc0UojGcdABn0yA7aDyYXfEAB
         Cgmy5MZfYdL1xQfQFbDHz6Ge2r66EwD9ehumAVGPWc/c/XoL/5b9/2I2JdbVZGmrfXZW
         xebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729394666; x=1729999466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbc1A1lbWoXEL3ZrMG1PbnMccM33RUZTMomnfxj4fAM=;
        b=hmR1ydwpyalLeukWuUDb6Hbf9LUcszp8EeJo4z9KBY6Xm3UXlnH0S81qvW91hoHuFO
         Ad49XSvFSnaWFtN6QbgNpmfnYr82IQt44PNv9mgdeK8Ph8Eg4WzX4R6wiGRRqd8Ls6nQ
         x89fXrV83yD4bB2o1tMwENEShu/vBW3hAWzntkXdkVFBT7xWbBt+JpGWaMczp213dPEP
         Zu72tkAB2YYhrMiAs2/2c/Kn1RqPosMpdMXZIckegv8pNdPLBQJNvIoBmcybAqdH34Hd
         rlGFIXdsYBz1XuyuVyjKpoTgiOOD1PRlh+2SOJe/muB7WH84fdp4aDTXgs5lNw7j261A
         GKIg==
X-Forwarded-Encrypted: i=1; AJvYcCU18Dll3NSoqTUq8a2yfW10wwif6jVo9dcI2ALeXRMqNMk+6C5X4XQmNwWArY5TnMWCQE0tB0FzswFnSk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyRjNX8VuiosQiE39G8uL1sewyiOC2zsyPRDb7DzQk6pFuHP/Q
	H7wnCNau/R2bJ4wz0Evung/OOGFWGJL7RWE6Zk4oOp5cGwE7J2C7BkWB4cH0TKN0sT+3PWg5qTf
	2
X-Google-Smtp-Source: AGHT+IH6J721g2QJQocqVUUwYxVeHLZEcBex4rYv7sCLJ8t2EBzEOwn8xTF8xIrJgSX+YMiGvolILA==
X-Received: by 2002:a05:6a21:a4c1:b0:1d9:16db:902e with SMTP id adf61e73a8af0-1d92c4babebmr10547404637.9.1729394665853;
        Sat, 19 Oct 2024 20:24:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1335591sm449076b3a.66.2024.10.19.20.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 20:24:25 -0700 (PDT)
Message-ID: <b2fd70bb-9414-49e0-bdb8-5c538f247dea@kernel.dk>
Date: Sat, 19 Oct 2024 21:24:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
 <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>
 <20241018175606.GJZxKhNmW9nCLwNS6Z@fat_crate.local>
 <016ecb00-2331-472c-88e4-66b1dbecfc99@kernel.dk>
 <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>
 <20241019093748.GAZxN97LS_dJ3DNrpd@fat_crate.local>
 <436b4fc7-6369-40d9-8e88-556cbf5a5687@kernel.dk>
 <20241019232138.GDZxQ_AtkqA9iAR2td@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241019232138.GDZxQ_AtkqA9iAR2td@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/24 5:21 PM, Borislav Petkov wrote:
> On Sat, Oct 19, 2024 at 07:54:07AM -0600, Jens Axboe wrote:
>> Added that, and here's the full boot output until it crashes. Sent you
>> the full thing as there's some microcode debug prints initially, and
>> then some later on. Didn't want to miss any.
> 
> Thanks, I think I see it. It is that weird node-per-L3 setting which
> apparently doesn't set up the ACPI tables properly or the loader runs too
> early but load_microcode_amd() sees a very funky node maps. Node 0's first CPU
> in the map is CPU 0, which is correct but then cpu_data(0) is a funky pointer
> which causes the splat.

This was my initial thought when I saw where it crashed, is this being
run before node masks are initialized?

> All the other "nodes" up to 31 have the first CPU in the mask as 512 which is
> WTF?!
> 
> So the below is the same conglomerate patch but with code to dump those node
> ids in load_microcode_amd() so that I can see what your system says.
> 
> It should boot ok now - fingers crossed - but let's see what it really does on
> your machine. Just replace it with the previous one, pls, and send me full
> dmesg again.

That's a lot of output... Took about 1 minute on the serial console just
for that. Here's some of it, let me know if you need all, because it's a
LOT. Looks like it takes long enough that it actually fails to bring up
some CPUs.

microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #487
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215

.... node  #29, CPUs:   #488
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #489
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #490
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #491
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #492
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #493
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #494
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #495
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215

.... node  #30, CPUs:   #496
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #497
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #498
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #499
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #500
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #501
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #502
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #503
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215

.... node  #31, CPUs:   #504
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #505
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #506
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #507
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #508
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #509
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #510
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
 #511
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: cache_find_patch: using 0xaa00215
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
CPU257 failed to report alive state
call_irq_handler: 498.55 No irq handler for vector
smp: Brought up 32 nodes, 510 CPUs

then a bunch of the usual kernel messages, then it ends with:

microcode: Current revision: 0x0aa00215
microcode: Updated early from: 0x0aa00215
BUG: unable to handle page fault for address: 000000000aa0021d
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP
CPU: 225 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc2+ #145
Hardware name: Dell Inc. PowerEdge R7625/06444F, BIOS 1.8.3 04/02/2024
RIP: 0010:internal_create_group+0x1d0/0x430
Code: 8b 0c 24 81 e2 b4 11 00 00 4c 89 ef e8 39 f2 ff ff 85 c0 0f 85 55 01 00 00 49 8b 47 08 49 83 c7 08 41 83 c6 01 48 85 c0 74 22 <0f> b7 48 08 85 ed 74 96 48 8b 30 31 d2 4c 89 ef 89 4c 24 08 e8 07
RSP: 0018:ffffb4a3000e7de8 EFLAGS: 00010246
RAX: 000000000aa00215 RBX: ffffffffbaa1a0c0 RCX: ffff9c6da7a374d0
RDX: 0000000080000001 RSI: ffff9c3da7a36598 RDI: ffff9c7fcc4e5188
RBP: 0000000000000000 R08: 0000000000000228 R09: ffff9bd8403a4f10
R10: ffff9c91c2381dd0 R11: 0000000000000000 R12: ffff9be3a7a3cc00
R13: ffff9c7fcc4e5188 R14: 0000000000000000 R15: ffffffffbb7e3928
FS:  0000000000000000(0000) GS:ffff9c85a7a40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000aa0021d CR3: 000000bd9bc28001 CR4: 0000000000370ef0
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x2b
 ? page_fault_oops+0x90/0x210
 ? idr_alloc_cyclic+0x49/0x90
 ? exc_page_fault+0x6c/0x130
 ? asm_exc_page_fault+0x22/0x30
 ? internal_create_group+0x1d0/0x430
 ? internal_create_group+0x141/0x430
 microcode_init+0x121/0x190
 ? mtrr_trim_uncached_memory+0x2d0/0x2d0
 do_one_initcall+0x2e/0x190
 ? __kmalloc_noprof+0x1d0/0x2c0
 kernel_init_freeable+0x1d0/0x210
 ? rest_init+0xc0/0xc0
 kernel_init+0x16/0x120
 ret_from_fork+0x2d/0x50
 ? rest_init+0xc0/0xc0
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in:
CR2: 000000000aa0021d
---[ end trace 0000000000000000 ]---
RIP: 0010:internal_create_group+0x1d0/0x430
Code: 8b 0c 24 81 e2 b4 11 00 00 4c 89 ef e8 39 f2 ff ff 85 c0 0f 85 55 01 00 00 49 8b 47 08 49 83 c7 08 41 83 c6 01 48 85 c0 74 22 <0f> b7 48 08 85 ed 74 96 48 8b 30 31 d2 4c 89 ef 89 4c 24 08 e8 07
RSP: 0018:ffffb4a3000e7de8 EFLAGS: 00010246
RAX: 000000000aa00215 RBX: ffffffffbaa1a0c0 RCX: ffff9c6da7a374d0
RDX: 0000000080000001 RSI: ffff9c3da7a36598 RDI: ffff9c7fcc4e5188
RBP: 0000000000000000 R08: 0000000000000228 R09: ffff9bd8403a4f10
R10: ffff9c91c2381dd0 R11: 0000000000000000 R12: ffff9be3a7a3cc00
R13: ffff9c7fcc4e5188 R14: 0000000000000000 R15: ffffffffbb7e3928
FS:  0000000000000000(0000) GS:ffff9c85a7a40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000aa0021d CR3: 000000bd9bc28001 CR4: 0000000000370ef0
note: swapper/0[1] exited with irqs disabled
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
Kernel Offset: 0x38e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

-- 
Jens Axboe

