Return-Path: <linux-kernel+bounces-404380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7074D9C430C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AE0284080
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91DA1A3028;
	Mon, 11 Nov 2024 16:55:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB781A2643
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344108; cv=none; b=OPctLvdcHeq82/Vk0hMq81HTpkFXfUctWJJVtZ1xWRRqEPfJOkdLFef3iBMCFvFyslxwj1yZogUfhA0igZZktg8sB4uxpgTSgPuHTdqck8aB63xB0htt+wgRD8eu29pSNNv+dLfWhUDEzKZMxrwJrsrpiE/TLwxoJM02pAmoU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344108; c=relaxed/simple;
	bh=cqAXmbWQCVuQ0DRV0fslJMxWqh1upgfqE87vbMsb/5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2+Tt/FbumCpWW2PztgGl8BjyufgbppCiohTYlXqioz9Pvkc7A4lj22YoHqyNDodya6ZtxoBytBgz6z9TluSwEixYpsc4366eLWdK9OrX8F+IVRmOMnb9mTjm8Kw2tgu7/qX7Yd7cvbuI4Axsy8QNC+0foSW0D+qTDhvcd1BsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A471480;
	Mon, 11 Nov 2024 08:55:35 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131923F66E;
	Mon, 11 Nov 2024 08:55:03 -0800 (PST)
Message-ID: <d1be99d6-0ce5-473f-9416-d33d61effee8@arm.com>
Date: Mon, 11 Nov 2024 16:55:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] tick-sched: Keep tick on if hrtimer is due imminently
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-3-joel@joelfernandes.org>
 <a491e879-364c-4b57-aa69-28608d8af4f0@arm.com>
 <CAEXW_YTxgpEzA4Vo5+pX=iNYG=xioN=J+bh9YLdSFEc4bEXhLA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAEXW_YTxgpEzA4Vo5+pX=iNYG=xioN=J+bh9YLdSFEc4bEXhLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/24 15:56, Joel Fernandes wrote:
> On Mon, Nov 11, 2024 at 7:38 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 11/8/24 17:48, Joel Fernandes (Google) wrote:
>>> In highres mode, the kernel only considers timer wheel events when
>>> considering whether to keep the tick on (via get_next_interrupt()).
>>>
>>> This seems odd because it consider several other reasons to keep the
>>> tick on. Further, turning off the tick does not help because once idle
>>> exit happens due to that imminent hrtimer interrupt, the tick hrtimer
>>> interrupt is requeued. That means more hrtimer rbtree operations for not
>>> much benefit.
>>>
>>> Ideally we should not have to do anything because the cpuidle governor
>>> should not try to the stop the tick because it knows about this
>>> situation, but apparently it still does try to stop the tick.
>>
>> Any details on this? Which governor?
> 
> I noticed this in Qemu (virtualized hardware). Actually I need to
> update the commit message. I think it is not because of the governor
> but because of lack of guest cpuidle support.

Ah indeed, then it makes sense.
FYI Anna-Maria proposed something like below a year ago:
https://lore.kernel.org/lkml/20231215130501.24542-1-anna-maria@linutronix.de/
I have no strong opinion on it either way.

Regards,
Christian

> 
> static void cpuidle_idle_call(void)
> {
> ....
>   if (cpuidle_not_available(drv, dev)) {
>     tick_nohz_idle_stop_tick();
>     default_idle_call();
>     goto exit_idle;
>   }
> ...
> Over here dev and drv are NULL for me. I will also test on real hardware.
> 
> Also maybe the " if (cpuidle_not_available(drv, dev))" condition
> should do some more work to determine if tick_nohz_idle_stop_tick()
> should be called instead of unconditionally calling it?
> 
> Pasting relevant parts of my .config:
> 
> # grep IDLE .config
> CONFIG_NO_HZ_IDLE=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> # CPU Idle
> CONFIG_CPU_IDLE=y
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> CONFIG_CPU_IDLE_GOV_HALTPOLL=y
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> CONFIG_INTEL_IDLE=y
> 
> thanks,
> 
>  - Joel


