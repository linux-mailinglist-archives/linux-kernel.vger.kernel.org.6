Return-Path: <linux-kernel+bounces-245991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFB092BC70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B8B280FFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C519B5A9;
	Tue,  9 Jul 2024 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B80X2Y8n"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A243B154BF0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533851; cv=none; b=d0fgpHfgUbF+CoMBTwjO18LacnZALkWxdUe2VraBON7PckpSjoeIGEiNk1w7pCjOlSn0j57AM50y8OXEfJ/hd0yJvOjb3DxiQcMssFmGFEuK/4cVibWOC6LY3T2+dA7DlMXXBz/xAxFMn13r0w0BiBsE3SqliWXEFCVi8D01Q+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533851; c=relaxed/simple;
	bh=WehO05lTq9i4SfZ4w807g+0X7qjynyaN5S6EzynjTac=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hdck/Bj/n3T3y95pa1fO4buOkVPDWiIbyc6c/rY37HICur8mHw3nj/4PW2rAL6l3EXBh3qviEBZUAi2g3NtDlCRBh/MW1f+IsxymJ/wcFwYrFaEjmw0p/4F0INRVyV9NHyJLbysJ3f+xIlyjiyBhJL07q0hxYYHYoatRCmqyKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B80X2Y8n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so9532425e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720533847; x=1721138647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gr+BI9dX0y9cQgrNoEy2ntD0zgiBxsk0wbP5eVeu2Q4=;
        b=B80X2Y8ngFGYqfoM1qum3NEI3In10P7f2HJMDTwLTx82zuVMqfj/Z5WiWAcdBaG729
         UtVFNG1BcMRFAKLuzE8ASsFGmgEai5RdCZu8XHhyjW5T204r64mnFNakpts8haS5zWpw
         AvqexYM1sWhtY6TFtrgPvb7pLcZ3+v53UVtM27aDzHGa9g7l21wR9Vesjg8S1OKVwRTJ
         qDqrYHvDX1oNYHlKuYGUTMstG6h9RmeRPYf/sktNW/kDRYte5KccNFfYSReNSJX2MssK
         M9xDHWUvkGWugN0qZXykem6vfeDM/n8rihPE6Pv8SubCueRcPWreiO+cGIoxOHOO4Sha
         bR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533847; x=1721138647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gr+BI9dX0y9cQgrNoEy2ntD0zgiBxsk0wbP5eVeu2Q4=;
        b=AonpSwrt1uockgdA0YAniNfZQByQGmboJOqGAFxXQeRLPA36gJ7rISoa4Fo3PZxu09
         mGv0tvnZ8WFGecxaYbAp5SwB6sUnSzSaXVVzc2QpXiZzR/W28fYbQAY8YQZ0lt7FcabB
         ghB5xz9VcY/dKipySMCM/wixXa0wHboFTfC36bEfXO7Bs2We5LpKwuVYV1pRZX8YGs3A
         Od4JytBCIqRrEyR3aW+VHYvzJJI3RMkuRIgcWXDEypZvt71KYGikXxF6ukQlG6LI2xzg
         3Amo1Hk9sHeH2YGOzgst0uGHb9DYpl7YVAAWem870T5KQhwdanYjbLZSUX3epfefnkbx
         w0ew==
X-Forwarded-Encrypted: i=1; AJvYcCU4Tuv1P/CqVVKPnGOLPmv0RMl/c8r+QwhKIw/PUjZyplGvuOAylgOhaedPgs6Qg58zl3eLH5P0l2n5wOoG+HbbW1P2hzZzg647x8vy
X-Gm-Message-State: AOJu0YzGXEUjH0xQtkhqC7Ed0ZGkfsDSncooFFEOsc1u53DnJrH4Wpxv
	aOXlWmNVQ6Obwd7dhrcWOqYF04fSL1XQqj0vTt7Qqa+WSSO+ly8GvWmjG6grVZ5NQgn6tLzx/+C
	S
X-Google-Smtp-Source: AGHT+IFHJ+GV1aSDHAaZEX2KWlyDDtXutizUkD2W+8jfELexvVFXW2jZy8Aal+D/rXHu12mwyZdQMQ==
X-Received: by 2002:a05:600c:300a:b0:426:6b47:290b with SMTP id 5b1f17b1804b1-426708f1e2fmr16550985e9.28.1720533846920;
        Tue, 09 Jul 2024 07:04:06 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cf24:cce:17df:12ab? ([2a05:6e02:1041:c10:cf24:cce:17df:12ab])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266f6f07dasm42393815e9.12.2024.07.09.07.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 07:04:06 -0700 (PDT)
Message-ID: <56681478-399a-4fae-828c-ccf1b579c296@linaro.org>
Date: Tue, 9 Jul 2024 16:04:05 +0200
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

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


