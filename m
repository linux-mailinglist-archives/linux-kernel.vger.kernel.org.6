Return-Path: <linux-kernel+bounces-577216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC1A71A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFFB188B1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A91F3BB6;
	Wed, 26 Mar 2025 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV6dsB9I"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5801F1905
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001821; cv=none; b=g6h9vNbMQB4h69mWcq8m9+I3Rm3v/mFUfC0CEfo6gagQ/mOjvKWUjvcGxBfbdcCH45VfdFE7uAjUz2wTwxbS0tJA/c/+7JdOwaEog8CmhalXZamr51MGr4rPg3L+wLnmzRLmzbCpHbmzbgQUlZeI38LCug1aDtbxtjpnrNJkFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001821; c=relaxed/simple;
	bh=HcPfpNlloMHtiCkZks0Msr+BkKYikuD+2TRrqShCPOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QBwzy24GyloGFF0rpuJLXWmO49WxDMXfvs1W+hy7KZJuu3T4jBALSBkWr6m7J1Jl5ezOpJAo4sz0bR+vhkPlyKySRccznRNNnHq+FGBrTt8GBrHko0yA+VHWtiIuV8aS9urqz35W6wGxuPwM0cIgCZGJG2zxH9QMM/G3qGQMjes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV6dsB9I; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a01bcd0143so8891843fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743001819; x=1743606619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7nsPJjvQpk51YxNNbivqm77VoNojg0kZvO2nM7R+ec=;
        b=mV6dsB9IvsQYXUiSZTK3JTAgEA/cnThqblAp4i694VMkZOF406Y3p4HB+jllBtqdpz
         +F08Tkd/uk4KkB7phsmeP/1hbzuqWFlgMp5DNguo/3+omyybgDx67D3UZHvKm70SzsGw
         DJk06ZVPtqtTXserq7v3YwrD4bYx/DHYjhrURZqx0j2hPRmSGdyWQRYfljQ1atyMyoBF
         8fUMg8RDBlvxKrU6VhGyTeQnCSbpSNDIAOkgrMaspgQ6m3ceWIkChNNnDhwtjojSkuU/
         pdME6REJCwS8CJLz5M6Y4UPnx1IgZxp6Sxx77AbO556F0sZu5Wg9JK6amC1ZUWonpndO
         MnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743001819; x=1743606619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7nsPJjvQpk51YxNNbivqm77VoNojg0kZvO2nM7R+ec=;
        b=fvTMJ2lWbBfXU27ikh79rEq32DFQmBakZ4lwad5rMvA2z0hVjhTOMbL/LI2w4Ylk59
         S8FjocR/+zip3PSnL1+cfOi36t5+0ZCl5pVNCdLxa2ePpzyHa0HU+QUJDmHdN7sB4dkF
         /TPulWnTtIt/owVkgFNPsYW1MHd8ZobM6SaxvqkasMqcHSjmEXVXjFtjr2+g3+B9w5sT
         xUSVrZpQLJfbaRsRAxlk8ra/7hqFGvVdoY3JBjOR1qB/HY1+oTL3CUbKQGCxwpwcuEqJ
         kAr9qefzegKK2r0c2wibDWpkplWqvuyxX+hXLEuTi/cPCjgx24zKM51nP98HIBmX4HM1
         UY9A==
X-Forwarded-Encrypted: i=1; AJvYcCXZb8K2Nm0v1bF/rwUCdE6inYroUK1w/tbb+D+/CppPp1ZYNSqjRz4srGN1i7QXrGu4BjE+ePTpbWXITuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yWy0Nx06uPK8TriDgwPZ0xyg5rWQAWPp7q4rAOy/dhcOBz2h
	mCL9cD1PGm6hWFJ0Gl/dpapDIfEW+Y/Ie3f4aM9bKLcKfJb+NCeo
X-Gm-Gg: ASbGncuUaOR+BsiF5o0Hr61avA+uk3V9KnYUAYA4CDvLkw4j3QlMVl3u4aqhno43hNC
	qQmOfUKWcmVHopzKBc8Y9kFDdoU2ke7ciSWb2eEl7QJ0zhLGawLH6sg8jzrDlLkRG6FbD2PP12v
	tZ5nBguLTk3di480d5JHv4Zb4mwXhkx68C7ae8kb9ufuKuPK9Vh7/6yxati+/pcsbGSxkNYZNGz
	4DsoDRn8qeB9AKv3cMHTP+zdhWGhPwod4OILldCHUTSYp9gChpbF0zQAQ5QJndtOfncvn2I/Jd6
	At0DXNjoN3nADaHL6g90Q+XPb355wqz2ej486dcKJsQyqxFDW+EEK8g8xdAONr63K1FEoj58cNZ
	IRrcU+lsFQUUYsdPaNtVbTWJFLbuZD0TU
X-Google-Smtp-Source: AGHT+IFyDIdW9c8VswcEIUw+315NWGOfmsnBzfXw1kzh3hm2kzhOmp+hfEL+UhjmBT1+s1xpy3Vmew==
X-Received: by 2002:a05:6870:6e87:b0:2c1:ade0:2699 with SMTP id 586e51a60fabf-2c77fe297a4mr12522555fac.0.1743001818859;
        Wed, 26 Mar 2025 08:10:18 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77ebc9e02sm3059333fac.7.2025.03.26.08.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 08:10:18 -0700 (PDT)
Message-ID: <ff14a8fc-a2f0-4bad-9687-86a88094151e@gmail.com>
Date: Wed, 26 Mar 2025 10:10:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] panic: reduce CPU consumption when finished handling panic
To: Thomas Gleixner <tglx@linutronix.de>, pmladek@suse.com,
 Andrew Morton <akpm@linux-foundation.org>, jani.nikula@intel.com,
 open list <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, takakura@valinux.co.jp,
 john.ogness@linutronix.de
References: <f2272f04-510e-4c92-be5e-fedcbb445eb0@gmail.com>
 <87wmci1a0j.ffs@tglx>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <87wmci1a0j.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 3/21/25 14:03, Thomas Gleixner wrote:
> On Mon, Mar 17 2025 at 17:01, Carlos Bilbao wrote:
>> After the kernel has finished handling a panic, it enters a busy-wait loop.
>> But, this unnecessarily consumes CPU power and electricity. Plus, in VMs,
>> this negatively impacts the throughput of other VM guests running on the
>> same hypervisor.
>>
>> I propose introducing a function cpu_halt_end_panic() to halt the CPU
>> during this state while still allowing interrupts to be processed. See my
>> commit below.
> That's not the way how change logs are written. You explain the problem
> and then briefly how it is addressed.
>
> No proposal, no 'see below'. Such wording does not make any sense in a
> git commit. See Documentation/process/
>
>> @@ -276,6 +276,21 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>>          crash_smp_send_stop();
> Your patch is malformed due to white space damage:
>
>   patch: **** malformed patch at line 31:          crash_smp_send_stop();
>
>> +static void cpu_halt_end_panic(void)
>> +{
>> +#ifdef CONFIG_X86
>> +    native_safe_halt();
>> +#elif defined(CONFIG_ARM)
>> +    cpu_do_idle();
>> +#else
>> +    /*
>> +     * Default to a simple busy-wait if no architecture-specific halt is
>> +     * defined above
>> +     */
>> +    mdelay(PANIC_TIMER_STEP);
>> +#endif
> Architecture specific #ifdefs in core code are not the right way to
> go. Split this into three patches:
>
> 1) Add a weak fallback function
>
> void __weak cpu_halt_after_panic(void)
> {
>         mdelay(PANIC_TIMER_STEP);
> }
>
> 2) Add non weak implementation in arch/x86
>
>     native_safe_halt() is wrong vs. paravirtualization.
>
>     safe_halt() is what you want.
>   
> 3) Add non weak implementation for arch/arm
>
>    Not my playground, so no comment


Sounds good, sending patch set now. Thanks for your time!


>
> Thanks,
>
>         tglx
>
>     


Thanks,

Carlos


