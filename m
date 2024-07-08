Return-Path: <linux-kernel+bounces-244672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CD792A7AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A86B210FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9962146D7F;
	Mon,  8 Jul 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/8gox0M"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D914532B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457777; cv=none; b=Fu46dh7+ZgCElQcO+x4jKMmBfFFPd3G9gzhZUJxCyFZXalbpdCD+dztiMXxHs0Llc/7DeLKRIt3fBUTObAdz7urQXr7lOTS9AY95arKsBQezpjs7b71GiOddpWpybGnONbDast3n3Q1muKNkIfQvMM4aBtt+dNltz49xPqMGZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457777; c=relaxed/simple;
	bh=C49tfT6Wgt5Ck261hQAy7mqF+kocGPwYPx6Hpdry0JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aFPMYGsN1hSs1sZuBDxTzRUbKtg7N+VBRFxMZTnximBDxTFX11VXSqLPtZzyB1KtwPn8VSi5oflUq6kEsFpeLar8isyApn+sGjZHmtXsnATuXWgz7ekxwOVneWdSyomiW9VieQbNrWs6WIcQ4cTK69/8cQyuZiyLXFzaHeBnt3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m/8gox0M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so25522535e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720457773; x=1721062573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+qnhD2hx9xrENWu0QP60bAxducN4cTQgp2xM1mPbvI=;
        b=m/8gox0MTf+NjrIvFPNAU226j7NG6CyymNo9EeMJVqj6ACWrSQ/v+Sv4qtCZ3x2Sj+
         7TP/bdhHg+9sOTb3PgbRMGk/b8pB4tCVFr0HDiWPECpsW55S4FEzt3QrmMz2D1x8W+lY
         PJEPZA7MQNxTokO1pLQXoyXhh99R/2ohYofY1kZM8gPZtx32p8xlVdeG64CiSkEXQBPC
         hJs4ld5QlMcmvN7IP4A/9uJx3o0NoiGIH/ahkG+XNhBnfKUIjiAeQBs1uG5fnWWxxail
         Y3dsssHkKAkEYT3cddmnOb6HVuAe9SNvbpbAG39IJy71PehTZGOVB3xETmGOwQ0HYXcz
         4IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457773; x=1721062573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+qnhD2hx9xrENWu0QP60bAxducN4cTQgp2xM1mPbvI=;
        b=Vc7gTU17OWG7fhfEawMEWegA7tZWejGLvqPFHAYc3SZSir6CRxRrYX18/YQzdKVi8W
         6P/86iphnCXWwbS+iNaUE6DSMm5itP+za903HxuJ4feU3vflADM3+0vTByAqnliZ6Ktx
         qvy+LmPuMnJpCnWOQyGSosm2mxcXieyxp2aORmYyvaLvDg8mHg4LezYKs73CVAjIlgAl
         t/s6/tjX/1Yz9u0Xba2WjG3p+57aZcQcTgKkcI7E3ytQNR85bjNAa0d7Mn30tmJX1ldK
         1eNN0SZIBRPkxZmaNSsnOKnlIatsRaS2F0n2JJ6m5QokDXe6xWW0BnENEHnNjUe8m4ap
         HyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl6EKGZyoZOvKyhnM29vl1Dq37WtKOfceoKDKwAmn4kgAuG7Mb7xBXeVNu8axaosQATwNwY44LOdVCvrIhQbQ6OmnrpgSCeSu53yKD
X-Gm-Message-State: AOJu0YzKf5niEovfgON8Dwto9kb2g8+Kd91+3t9w1K8XcC2LwAOLf4PQ
	PvyK17xgZ0I6b8KyQcUBiLEk1gYI0y5+FcVOJlm/AZVgYBAaXXY85xePdmPBapk=
X-Google-Smtp-Source: AGHT+IE2oQep7Ey6Ar/9JAg1Ao7dM6HGDWBtWiUxfm3nMI4/309WpySEbis5SAYg3/+9ERZd988WYQ==
X-Received: by 2002:a7b:ce88:0:b0:426:6981:1bd with SMTP id 5b1f17b1804b1-426698103bbmr32048115e9.5.1720457773455;
        Mon, 08 Jul 2024 09:56:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cf24:cce:17df:12ab? ([2a05:6e02:1041:c10:cf24:cce:17df:12ab])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42650b26c48sm138476945e9.17.2024.07.08.09.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 09:56:12 -0700 (PDT)
Message-ID: <598da6e0-4d7e-4800-a47a-3914070669d0@linaro.org>
Date: Mon, 8 Jul 2024 18:56:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/sh_cmt: Address race condition for
 clock events
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20240702190230.3825292-1-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240702190230.3825292-1-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/07/2024 21:02, Niklas Söderlund wrote:
> There is a race condition in the CMT interrupt handler. In the interrupt
> handler the driver sets a driver private flag, FLAG_IRQCONTEXT. This
> flag is used to indicate any call to set_next_event() should not be
> directly propagated to the device, but instead cached. This is done as
> the interrupt handler itself reprograms the device when needed before it
> completes and this avoids this operation to take place twice.
> 
> It is unclear why this design was chosen, my suspicion is to allow the
> struct clock_event_device.event_handler callback, which is called while
> the FLAG_IRQCONTEXT is set, can update the next event without having to
> write to the device twice.
> 
> Unfortunately there is a race between when the FLAG_IRQCONTEXT flag is
> set and later cleared where the interrupt handler have already started to
> write the next event to the device. If set_next_event() is called in
> this window the value is only cached in the driver but not written. This
> leads to the board to misbehave, or worse lockup and produce a splat.
> 
>     rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>     rcu:     0-...!: (0 ticks this GP) idle=f5e0/0/0x0 softirq=519/519 fqs=0 (false positive?)
>     rcu:     (detected by 1, t=6502 jiffies, g=-595, q=77 ncpus=2)
>     Sending NMI from CPU 1 to CPUs 0:
>     NMI backtrace for cpu 0
>     CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0-rc5-arm64-renesas-00019-g74a6f86eaf1c-dirty #20
>     Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
>     pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     pc : tick_check_broadcast_expired+0xc/0x40
>     lr : cpu_idle_poll.isra.0+0x8c/0x168
>     sp : ffff800081c63d70
>     x29: ffff800081c63d70 x28: 00000000580000c8 x27: 00000000bfee5610
>     x26: 0000000000000027 x25: 0000000000000000 x24: 0000000000000000
>     x23: ffff00007fbb9100 x22: ffff8000818f1008 x21: ffff8000800ef07c
>     x20: ffff800081c79ec0 x19: ffff800081c70c28 x18: 0000000000000000
>     x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc2c717d8
>     x14: 0000000000000000 x13: ffff000009c18080 x12: ffff8000825f7fc0
>     x11: 0000000000000000 x10: ffff8000818f3cd4 x9 : 0000000000000028
>     x8 : ffff800081c79ec0 x7 : ffff800081c73000 x6 : 0000000000000000
>     x5 : 0000000000000000 x4 : ffff7ffffe286000 x3 : 0000000000000000
>     x2 : ffff7ffffe286000 x1 : ffff800082972900 x0 : ffff8000818f1008
>     Call trace:
>      tick_check_broadcast_expired+0xc/0x40
>      do_idle+0x9c/0x280
>      cpu_startup_entry+0x34/0x40
>      kernel_init+0x0/0x11c
>      do_one_initcall+0x0/0x260
>      __primary_switched+0x80/0x88
>     rcu: rcu_preempt kthread timer wakeup didn't happen for 6501 jiffies! g-595 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
>     rcu:     Possible timer handling issue on cpu=0 timer-softirq=262
>     rcu: rcu_preempt kthread starved for 6502 jiffies! g-595 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
>     rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
>     rcu: RCU grace-period kthread stack dump:
>     task:rcu_preempt     state:I stack:0     pid:15    tgid:15    ppid:2      flags:0x00000008
>     Call trace:
>      __switch_to+0xbc/0x100
>      __schedule+0x358/0xbe0
>      schedule+0x48/0x148
>      schedule_timeout+0xc4/0x138
>      rcu_gp_fqs_loop+0x12c/0x764
>      rcu_gp_kthread+0x208/0x298
>      kthread+0x10c/0x110
>      ret_from_fork+0x10/0x20
> 
> The design have been part of the driver since it was first merged in
> early 2009. It becomes increasingly harder to trigger the issue the
> older kernel version one tries. It only takes a few boots on v6.10-rc5,
> while hundreds of boots are needed to trigger it on v5.10.
> 
> Close the race condition by using the CMT channel lock for the two
> competing sections. The channel lock was added to the driver after its
> initial design.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
> Hello,
> 
> I only have access to R-Car based SoCs and that is what I have tested
> this change on. I have not been able to test on any SH platforms which
> also uses this driver.
> ---

Mmh, it seems to fix the race conditions but the testing coverage is 
incomplete. I'll pick it but keep an eye on it in case it breaks other 
platforms. If someone can give a try to test on the sh platforms that 
would be nice.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


