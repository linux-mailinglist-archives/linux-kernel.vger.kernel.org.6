Return-Path: <linux-kernel+bounces-288121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB199535DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A82C1F21202
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8611B29B7;
	Thu, 15 Aug 2024 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mzH7OhJe"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC431B14F8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732919; cv=none; b=Y/ulkGzzeibM48OiOv79Pnt+zj34E5RLahC6mKxutJe0JI6Uni93hVX5DWBCnJbtRSEE/pfN9L3bUW2zm1itUXPGSiAwT81NQhP3N0MiwrhvIngS9C8fis1cp6s1st/5JBhwYe6gfp8dY1G49+0aunC2wa5183sHBH4Zfq1vPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732919; c=relaxed/simple;
	bh=0MQuPzQnMKhxGxjiKQymr0yiA6BAuDfJdRXUAXOTSco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEr4037fe9aPadA0Mm4R8ugKWhA6Ma/JbebPaF3S6Ty6L0uIX4AGme/JKhkjegO4AFyNYAOWKky/Ab/mvth0E2F0MuLcDPVbZCoRp6DguEd7OpXvKJ8Gh3o9SR07EOpJngYasslgqUrdEWBfuDfZhBB3Y4o0APthek0dAXCSEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mzH7OhJe; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81fb419f77bso51194439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723732916; x=1724337716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++BmiiXwQt/QcOt/zK+OovAUukWbAy9mATU+M+pnlPs=;
        b=mzH7OhJeDa2HeZljpSVIqfmUsa1Sti7VjKhdLpK81NaWdzrToma7oei/cjcCJ2DPFX
         KQvxOtPFhDWBM4iQ5WK5U5OdYvoAj7Id62A4FkiUkbaTkiFjANd4sfua75lsU7zbcZc4
         mxgXpSbr5dt2qSJaYq8qEHEX+ip5QoxqizX5F/2ZgkTPGTuQJg1AaZnR9djhoNOpDnWx
         IZwSV68CsQskgtcED6xmM3eta2anzCGeUiDtWTxnXRQufkO4hyn05v5NqWaOld/J77tf
         xBY5AoC4VRs6NglNdtSJkXaiWUSSPh+mgQHhsmsd1gADAVPAWMM+B41fQmzdVm+jiuoY
         Ej4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723732916; x=1724337716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++BmiiXwQt/QcOt/zK+OovAUukWbAy9mATU+M+pnlPs=;
        b=tsB/T75cwylfXt3XNYTqtBlYQi3siDiPTW5jEI0RBw4Y5/2yMKZpxKBZZqqWor8uQZ
         weBNSm4a9bh0yWX7QeOmoEvncdFhPFqdQ5KA0TUK3chih3Vmpv09MsnU9b6Zx3dENS1h
         KhbBnVcCyk19D8vMv2HfHJ1XTYin3qbxQCooT1NA+NEPJIcLUF/IWylFyTzDjo9rum97
         0W4R3dqxuHE/Huu5zfmGQgI8JeN1M3WthhWmv3Jdw3rc3J9kBiuYlhxVTsWg5OdAiAbm
         H8U6GxRL0xS17zP7fwKVCvqQM7DI5wrmMcCqgKo7AGHWPKxFOF0YFazNYtdEk7zpeMOn
         hptQ==
X-Gm-Message-State: AOJu0YxDjOM/4JhmD3wSLbcBewR+HtriYg1Pe/iRulG0v+/GM3OW0G4A
	W+K576hZNbdIdiHE2BGyPsYU1NsBRIUZqI0gRb3I8d4c+9tv3qUWAmOACMCFU+mWw5fd0ZeS/Vg
	2
X-Google-Smtp-Source: AGHT+IFCvvrFd5l9ENiraMAdbfas6RG05Z/jvtVxTncOjYZjJetsW4L7fIkPh9zI4/+Aa1OKJOROLw==
X-Received: by 2002:a05:6e02:1d8e:b0:39a:e984:1caa with SMTP id e9e14a558f8ab-39d26d4f540mr178135ab.21.1723732916543;
        Thu, 15 Aug 2024 07:41:56 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6f3db32sm525449173.116.2024.08.15.07.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 07:41:56 -0700 (PDT)
Message-ID: <be1db8f5-af55-48a4-be7a-5e8a1a5e25c4@sifive.com>
Date: Thu, 15 Aug 2024 09:41:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner
 <tglx@linutronix.de>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx>
 <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx>
 <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
 <87plqalyd4.ffs@tglx> <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
 <87h6blnaf1.ffs@tglx>
 <CAK9=C2V7oL023=u6nodJs76k_0yHZ8PTJs=n1QFqDWCcCnG9kw@mail.gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAK9=C2V7oL023=u6nodJs76k_0yHZ8PTJs=n1QFqDWCcCnG9kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-08-15 9:16 AM, Anup Patel wrote:
> On Thu, Aug 15, 2024 at 7:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Thu, Aug 15 2024 at 08:32, Samuel Holland wrote:
>>> On 2024-08-15 8:16 AM, Thomas Gleixner wrote:
>>>> Yes. So the riscv timer is not working on this thing or it stops
>>>> somehow.
>>>
>>> That's correct. With the (firmware) devicetree that Emil is using, the OpenSBI
>>> firmware does not have a timer device, so it does not expose the (optional[1])
>>> SBI time extension, and sbi_set_timer() does nothing.
>>
>> Sigh. Does RISCV really have to repeat all mistakes which have been made
>> by x86, ARM and others before? It's known for decades that the kernel
>> relies on a working timer...
> 
> My apologies for the delay in finding a fix for this issue.
> 
> Almost all RISC-V platforms (except this one) have SBI Timer always
> available and Linux uses a better timer or Sstc extension whenever
> it is available.

So this is the immediate solution: add the CLINT to the firmware devicetree so
that the SBI time extension works, and Linux will boot without any code changes,
albeit with a higher-overhead clockevent device.

Additionally merging the sun4i timer patch[1] will allow the system to switch to
the better MMIO clocksource later in the boot process.

The reason the CLINT was not added to the devicetree already is that the T-HEAD
version of the CLINT includes an extension to drive SSIP/STIP from a second
S-mode visible set of registers. So it should really have twice as many entries
in its interrupts-extended property as the existing CLINT, and I never got
around to validating that this would work.

The long-term solution would be adding driver support for the T-HEAD CLINT
extensions, which provide an even better clockevent than the sun4i timer.

[1]: https://lore.kernel.org/all/20240312192519.1602493-1-samuel.holland@sifive.com/

> When Emil first reported this issue, I did try to help him root cause
> the issue but unfortunately I don't have this particular platform and
> PLIC on all other RISC-V platforms works fine.
> 
> I am also surprised that none of the Allwinner folks tried helping.

Allwinner D1 support was upstreamed by unpaid hobbyists with very little
first-party assistance.

>>> I wrote a patch (not submitted) to skip registering riscv_clock_event when the
>>> SBI time extension is unavailable, but this doesn't fully solve the issue
>>> either, because then we have no clockevent at all when
>>> check_unaligned_access_all_cpus() is called.
>>
>> check_unaligned_access_all_cpus() is irrelevant.
>>
>>> How early in the boot process are we "required" to have a functional clockevent?
>>> Do we need to refactor check_unaligned_access_all_cpus() so it works on systems
>>> where the only clockevent is provided by a platform device?
>>
>> Right after init/main::late_time_init() everything can depend on a
>> working timer and on jiffies increasing.
>>
>> I'm actually surprised that the boot process gets that far. That's just
>> by pure luck, really.

Thanks for clearing this up!

Regards,
Samuel


