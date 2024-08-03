Return-Path: <linux-kernel+bounces-273548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E2946A71
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69326B21287
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD71547D3;
	Sat,  3 Aug 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ra/17V55"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023DD14F9F3
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722700106; cv=none; b=C7Eht7+EJVYtXBcJD9i609gtSJHiT0HT13OdIwamdBsaqBpELDYBtQRIShRZuNB0xpfFciPkGW2bwPWQTlOSjndtqU4QfQ/Y/aUOlqPmR4CBsuiyfoYDPRcT8iY/GZodDir+flC80qpieu8ZriitkDkS95oXmxn3ni+tIbdZ4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722700106; c=relaxed/simple;
	bh=fIgR+HLJfTmDAaWxU6LJmI5nlywv/z9jP0Ucwc+N0Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFzJXeKHmcxNTmyPefkuD7JJ3n4/LwLQgvOexCeI0mJjT80l31AqHh/pNKt1P7XrSc+XImSjEqH+z7JzxVl5x0F7K0sjlHhiIEwHRFAvRU8DdCsO0ZIMb16I7Dgo+AA/GdTpUQqXV9x4+4mnVVjg/G0Dc6h4oDrniOolN1b6Hus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ra/17V55; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722700103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l31j21mLxNy3zew5HKBy+ii9WMR6iWk+7TgHezIdgjE=;
	b=Ra/17V55yacFynmlhuMJQSqhWJpPxgnA9V1HSKpvl9D7yg4SEUEVGuxQ/1mVdXvBasETec
	atjwOMlXkV4IN60nCVmIbMftVrmmqhKfPVNEC0ak/NZb9D8eCPbG+AR0BRJ3TBgmKl8GA2
	Zr9FDtgzitQhRLrgrvm6X5+FmxKZXwA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-TdCnoMJmPnixpv_PH6ikCw-1; Sat, 03 Aug 2024 11:48:21 -0400
X-MC-Unique: TdCnoMJmPnixpv_PH6ikCw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7d63fbf4afso705753466b.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 08:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722700100; x=1723304900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l31j21mLxNy3zew5HKBy+ii9WMR6iWk+7TgHezIdgjE=;
        b=YtvV7uTzHM8ChQz6fIHGER6Cqt6Wn2UyYy682IjslzdLAP8dCl78MY3qUezEJsvBWm
         Yw6qWZJFHo+zmiMQ3Le6SqVS6Ck4EvJ2CJiGJI3IfQkS1WBnIFN7JfAa8XlK0LCYH3Qd
         V+vYs4hGu8Fzg38n4ZWsLACYMawNwDAq1yBHtRCMR9B9l2PzdxWZCR/SfjhIppz6Q0qc
         8E9ztybTk0+rCcBUFddddKla+tdyjqpjAx1gQi7XUlFBYqBB+94FwgL28kBq1jqZSygS
         jgEiPaeLqIBJIy1moFke7jFHhk4xAxrKHjqhev/jNLguECC30RrDpg1x8zSeWvIV7jYb
         2fog==
X-Forwarded-Encrypted: i=1; AJvYcCWold2Vc6DC2usPkSyWBES9LheRd1GT+1BUTKUZOcjzRyUIG1+h1SPYm4rgBgmDODUZW64MIaLmPm6n4G/lODYMbrgVLNWvB6V/ETns
X-Gm-Message-State: AOJu0YxR1Qe7aqhUrK8p6WugvxQTi+rJgKBAwjv4i2Wmce1rR61sJ9H6
	HpVtmCk5CxNJVDoeOhIiy4XFrjXdgxYO5Gpu1+IGz0d+dRNUuqwsOjGa6C8eahamxl4LZxxS0zQ
	vZZLj6nOhUk6Otj/wF1F2I1z9KJnapjooZ9aezD/N7DgNi253irqdGkhp+zapig==
X-Received: by 2002:a17:907:c291:b0:a7d:e5b1:bf65 with SMTP id a640c23a62f3a-a7de5b1c431mr65340566b.21.1722700100109;
        Sat, 03 Aug 2024 08:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgKX5w8FE5x/yWsgpmLhRPClUTzoxmhjH21zbqMY6OyWTdQgVnoHeQBRQi7az8kIYmM+iegA==
X-Received: by 2002:a17:907:c291:b0:a7d:e5b1:bf65 with SMTP id a640c23a62f3a-a7de5b1c431mr65339266b.21.1722700099587;
        Sat, 03 Aug 2024 08:48:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8860sm226968366b.209.2024.08.03.08.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 08:48:19 -0700 (PDT)
Message-ID: <2dd6b8e1-6f06-4ab8-b610-c0bd95a397e8@redhat.com>
Date: Sat, 3 Aug 2024 17:48:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.11/regression/bisected - The commit c1385c1f0ba3 caused a new
 possible recursive locking detected warning at computer boot.
To: Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, linuxarm@huawei.com
Cc: rafael.j.wysocki@intel.com, guohanjun@huawei.com, gshan@redhat.com,
 miguel.luis@oracle.com, catalin.marinas@arm.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Bowman, Terry" <Terry.bowman@amd.com>
References: <CABXGCsPvqBfL5hQDOARwfqasLRJ_eNPBbCngZ257HOe=xbWDkA@mail.gmail.com>
 <20240723112456.000053b3@Huawei.com> <20240723181728.000026b3@huawei.com>
 <20240725181354.000040bf@huawei.com> <87le1ounl2.ffs@tglx>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87le1ounl2.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/26/24 6:26 PM, Thomas Gleixner wrote:
> On Thu, Jul 25 2024 at 18:13, Jonathan Cameron wrote:
>> On Tue, 23 Jul 2024 18:20:06 +0100
>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>>
>>>> This is an interesting corner and perhaps reflects a flawed
>>>> assumption we were making that for this path anything that can happen for an
>>>> initially present CPU can also happen for a hotplugged one. On the hotplugged
>>>> path the lock was always held and hence the static_key_enable() would
>>>> have failed.
> 
> No. The original code invoked this without cpus read locked via:
> 
> acpi_processor_driver.probe()
>    __acpi_processor_start()
>        ....
> 
> and the cpu hotplug callback finds it already set up, so it won't reach
> the static_key_enable() anymore.
> 
>> One bit I need to check out tomorrow is to make sure this doesn't race with the
>> workfn that is used to tear down the same static key on error.
> 
> There is a simpler solution for that. See the uncompiled below.

I was seeing the same lockdep issue as the original reporter on my
AMD Ryzen 9 5950X machine and I can confirm that the suggested patch
(below) fixes this:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index b3fa61d45352..0b69bfbf345d 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -306,7 +306,7 @@ static void freq_invariance_enable(void)
>  		WARN_ON_ONCE(1);
>  		return;
>  	}
> -	static_branch_enable(&arch_scale_freq_key);
> +	static_branch_enable_cpuslocked(&arch_scale_freq_key);
>  	register_freq_invariance_syscore_ops();
>  	pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
>  }
> @@ -323,8 +323,10 @@ static void __init bp_init_freq_invariance(void)
>  	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
>  		return;
>  
> -	if (intel_set_max_freq_ratio())
> +	if (intel_set_max_freq_ratio()) {
> +		guard(cpus_read_lock)();
>  		freq_invariance_enable();
> +	}
>  }
>  
>  static void disable_freq_invariance_workfn(struct work_struct *work)
> 
> 
> 


