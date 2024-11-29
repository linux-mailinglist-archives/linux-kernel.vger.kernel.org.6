Return-Path: <linux-kernel+bounces-425751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6469DEA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF45163A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43704149E17;
	Fri, 29 Nov 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlEPQxqC"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD5168DA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732896562; cv=none; b=C4loTBUFYuXucjv1mdgzBFO2TencS8gLVismka5wMDD5MGWdV7CLDUTvhk73mleYGuAi9nwSZ1QOwTB6iSZld1vYyhBeYagLCEsXs+3VOJ2vNoMB9tf45AEcAl6/8BFtulUhOHYZwOWMx5jQSOqsHdQmSeX/U3la9yhJvuEuYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732896562; c=relaxed/simple;
	bh=+lz2RLJ7yU2XgbvJvawq8qTOxK3UKhAuVeJ+X3/13dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJvf7muXoh96HcosJB3/EtE6UVLfVB+vXIOPiLUhTlX/Lp+7D9z8lBl+V3oqxop+k3tnTb2I7yGud6qdgGBYviVg8bicYsdl29NfAEeuBcsIvvcUdHlpLpso5kFw0cnId11VK6s83Ilf7EQ319KlENym7GOlUFmYqkGwf3j/QkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlEPQxqC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-212348d391cso16597035ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732896560; x=1733501360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn9XUc2kXDHGr6lXt2ctrx4SG9UECOY3Hpaa849mHwM=;
        b=jlEPQxqC03hKCEk5osXmot2BLZ+Jpp7ARrB8v8cSP4ergDHSULfu5Wd/h5s4t/5yZa
         Kx8ew+X4w/ke2PlCC+Kd5yAgmjhZIrJr2ftwqCy1GeFRAUIGQk8xkCINkFJWx22t2MbI
         03vnw/YBoV9TQm4k2aMxosM/eL2U2s25jKLNkHaqEton65TuK2jxyKjJHPyd86MRvgNr
         E69+lL2ou4Kt5wi7siNLs86NaxKYWkaypYbcO+5dRlh25WHBBjHYYx9YdR/+hj7/kdy/
         ws7GBST9mGBd7BaV3jHo4wQX/EAzxhrfvZuKOBze6TVcQ4njEQA9YzOmEURa1Q6Nb3WS
         GvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732896560; x=1733501360;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rn9XUc2kXDHGr6lXt2ctrx4SG9UECOY3Hpaa849mHwM=;
        b=oaGW2Rd/VPaK7PnUtLXsaCZOcIjIkuuiWVeOwFGyj4jHWd7MdzKpdqZtBe102Qd3Bq
         RNxoAWsKznkWBG434qbiJaNcjbEFzk4J/yJBNqRmZyOtj7JvdHyTNvmb+C64a1IP2fsO
         OlpaFbjM9fRE2w0a7IRPGK+Z0GKlr/cP19FpQLa4VNvOPuOtyZIgobTfbwOTfzATYW0y
         6cxAI36ZBrc6QS1kglyJz7RRVpZIeMZFlvlbsg8S6ZzfwIjt0nqk0rcrZkMNNJzVHsRY
         E18cVGYcD9hsqQ++szAWn4DGGn+FwwUqo34HgUlhPFAM4xVhIWJjwZEIinyxh7nTblz7
         H25w==
X-Gm-Message-State: AOJu0YzaOa7M/5Jj6siK2WOCUVywn52jpB/Qp6zD/nZAo3BOnrlMDxpD
	r3x6qi/vO81g7+Oes4GkjtEU2SCmR0yD8lZM6OieN4TEbmop2kyQ
X-Gm-Gg: ASbGnctIA9QHkhVwH05HVixRStpIxyGMmU1H3A/0Q+cgw6H5zMIv6SV6+wHBItCCzap
	fmqKjeDr464rf5NB2Oh/Ihw6oUZgldX8LugxJVhMywed8QARo9WoYX6tuRPYBvpZRDrMlM85iVh
	7ZjdxIbmTl0lXFdxIOhZkTI1I0oJSR+6Sp6gS9nbPCZ+IrCmxc8Rj4GtKOdcx51Mw8M16mQ5FxS
	/iubvAFNUxP8iohlY3ebku4ug1+xI1a/wklYD07IlmpQ5yGbjnkwokgGta5I1jSC+g6J6nb7pYe
	seJpDq2YP0GskVCWO5oNEMc=
X-Google-Smtp-Source: AGHT+IGWM7WHdBC+C/onQT989hm/cREVcG9Jv/66Vp5pzINfer/t08fj11AWjhruzzh1+tHsNb/FeQ==
X-Received: by 2002:a17:902:cf0c:b0:212:63db:bb14 with SMTP id d9443c01a7336-21501d6451cmr143594545ad.44.1732896559566;
        Fri, 29 Nov 2024 08:09:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219ac8f3sm32293895ad.240.2024.11.29.08.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 08:09:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2b732d25-63e7-40f7-8d66-b1e6dc0b701d@roeck-us.net>
Date: Fri, 29 Nov 2024 08:09:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 2/2] timekeeping: Always check for negative motion
To: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <20241031115448.978498636@linutronix.de>
 <20241031120328.599430157@linutronix.de>
 <387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net>
 <CANDhNCo1RtcfqUJsuAQ+HdS7E29+gByfek5-4KYiAk3Njk4M3Q@mail.gmail.com>
 <65b412ef-fc57-4988-bf92-3c924a1c74a5@roeck-us.net> <87cyifxvgj.ffs@tglx>
 <2cb25f89-50b9-4e72-9b18-bee78e09c57c@roeck-us.net> <874j3qxmk7.ffs@tglx>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <874j3qxmk7.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/29/24 04:16, Thomas Gleixner wrote:
> On Thu, Nov 28 2024 at 07:30, Guenter Roeck wrote:
>> On 11/28/24 06:51, Thomas Gleixner wrote:
>> [   19.090000] ###### now: b5ac62 last: d447e38 mask: ffffff return: 712e2a
>> [   19.110000] ###### now: b9ebc3 last: db506d0 mask: ffffff return: 4e4f3
>> [   19.120000] ###### now: bb842f last: db8d760 mask: ffffff return: 2accf
>> [   19.160000] ###### now: c43f2e last: dbabfa8 mask: ffffff return: 97f86
>>
>> 'last' advances beyond 'mask', and after that the result is always bad. The call to
>> clocksource_delta() is from timekeeping_advance().
> 
> This does not make any sense. The bits above the mask in cycle_last are
> irrelevant:
> 
>          delta = (now - last) & mask;
> 
>> [    3.350000] ###### now:  6c4f last:  fe6a84 mask: ffffff return: 201cb    <---
>> [    3.360000] ###### now: 40427 last: 10052cc mask: ffffff return: 3b15b    <---
> 
>         0x40427 - 0x10052cc = 0xffffffffff03b15b
>         0xffffffffff03b15b & 0xffffff = 0x3b15b
> 
> That's not any different than before. The only difference is that the
> return value is checked:
> 
>         return delta & ~(mask >> 1) ? 0 : delta;
> 
> But clearly none of the resulting deltas (after masking) has bit 23
> set. So the function can't return 0, right?
> 
> Coming back to my earlier assumption vs. the max idle time. Here is a
> long idle sleep:
> 
>> [   18.500000] ###### now: 45b0a2 last: d1c7050 mask: ffffff return: 294052
>> [   19.090000] ###### now: b5ac62 last: d447e38 mask: ffffff return: 712e2a
> 
> The cycle interval is 125000 clock cycles per tick. That's a HZ=100
> kernel, so the nominal clock frequency is 12.5 MHz.
> 
>    0x712e2a/12.5e6 = 0.593391s
> 
> which is close to the 597268854ns max_idle_ns value.
> 
> That's about 0.0776978s away from the point where the delta becomes >
> mask/2. So there is a valid concern vs. these long idle sleeps on
> machines with a small counter width.
> 
> But none of this explains the problems you are observing.
> 
> Can you instrument clocksource_delta() to print the values only when the
> negative motion detection triggers?
> 

With added WARN_ONCE() after the problem is seen for the first time:

[   13.860000] ##### now=0xd60127 last=0x85170f4 mask=0xffffff ret=0x849033
[   13.860000] ------------[ cut here ]------------
[   13.860000] WARNING: CPU: 0 PID: 0 at kernel/time/timekeeping_internal.h:44 timekeeping_advance+0x844/0x9d0
[   13.860000] clocksource_delta() time going backward: now=0xd60127 last=0x85170f4 mask=0xffffff ret=0x849033
[   13.860000] Modules linked in:
[   13.860000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-10689-g7af08b57bcb9-dirty #1
[   13.860000] Hardware name: Generic DT based system
[   13.860000] Call trace:
[   13.860000]  unwind_backtrace from show_stack+0x10/0x14
[   13.860000]  show_stack from dump_stack_lvl+0x64/0x88
[   13.860000]  dump_stack_lvl from __warn+0x7c/0x1ac
[   13.860000]  __warn from warn_slowpath_fmt+0x130/0x1a4
[   13.860000]  warn_slowpath_fmt from timekeeping_advance+0x844/0x9d0
[   13.860000]  timekeeping_advance from update_wall_time+0xc/0x1c
[   13.860000]  update_wall_time from tick_irq_enter+0x6c/0xb0
[   13.860000]  tick_irq_enter from generic_handle_arch_irq+0xc/0x44
[   13.860000]  generic_handle_arch_irq from __irq_svc+0x88/0xb0
[   13.860000] Exception stack(0xc2201f28 to 0xc2201f70)
[   13.860000] 1f20:                   00000001 2d639000 c220da80 00000001 c220da80 c2208f14
[   13.860000] 1f40: c24af000 c2208f54 00000000 00000000 00000097 00000000 c2208f14 c2201f78
[   13.860000] 1f60: c1568504 c1568488 20000013 ffffffff
[   13.860000]  __irq_svc from default_idle_call+0x1c/0x1bc
[   13.860000]  default_idle_call from do_idle+0x200/0x288
[   13.860000]  do_idle from cpu_startup_entry+0x28/0x2c
[   13.860000]  cpu_startup_entry from kernel_init+0x0/0x12c
[   13.860000]  kernel_init from start_kernel+0x6a8/0x6c4
[   13.860000] ---[ end trace 0000000000000000 ]---
[   13.870000] ##### now=0xd747fa last=0x85170f4 mask=0xffffff ret=0x85d706
[   13.880000] ##### now=0xda5bf3 last=0x85170f4 mask=0xffffff ret=0x88eaff
[   13.890000] ##### now=0xdb1868 last=0x85170f4 mask=0xffffff ret=0x89a774
[   13.940000] ##### now=0xe541ba last=0x85170f4 mask=0xffffff ret=0x93d0c6
[   13.950000] ##### now=0xe63e66 last=0x85170f4 mask=0xffffff ret=0x94cd72
[   13.950000] platform iio-hwmon: deferred probe pending: iio_hwmon: Failed to get channels
[   13.960000] ##### now=0xe863a8 last=0x85170f4 mask=0xffffff ret=0x96f2b4
[   13.970000] ##### now=0xeba3a3 last=0x85170f4 mask=0xffffff ret=0x9a32af
[   13.980000] ##### now=0xec1406 last=0x85170f4 mask=0xffffff ret=0x9aa312
[   13.990000] ##### now=0xef85a4 last=0x85170f4 mask=0xffffff ret=0x9e14b0
[   14.000000] ##### now=0xf0f07b last=0x85170f4 mask=0xffffff ret=0x9f7f87
[   14.010000] ##### now=0xf1bff6 last=0x85170f4 mask=0xffffff ret=0xa04f02
[   14.150000] ##### now=0xc609c last=0x85170f4 mask=0xffffff ret=0xbaefa8
[   14.360000] ##### now=0x357f2d last=0x85170f4 mask=0xffffff ret=0xe40e39
[   14.410000] ##### now=0x3e0a3a last=0x85170f4 mask=0xffffff ret=0xec9946
[   14.420000] ##### now=0x3fed36 last=0x85170f4 mask=0xffffff ret=0xee7c42
[   14.430000] ##### now=0x42b58a last=0x85170f4 mask=0xffffff ret=0xf14496
[   14.440000] ##### now=0x44ba17 last=0x85170f4 mask=0xffffff ret=0xf34923
[   14.450000] ##### now=0x46635e last=0x85170f4 mask=0xffffff ret=0xf4f26a
[   14.480000] ##### now=0x4bd58e last=0x85170f4 mask=0xffffff ret=0xfa649a
[   14.490000] ##### now=0x4d3b0c last=0x85170f4 mask=0xffffff ret=0xfbca18
[   14.510000] ##### now=0x510ef4 last=0x85170f4 mask=0xffffff ret=0xff9e00

With more context (printing for each call to clocksource_delta() as well as the
actual return value):

[   14.020000] ##### now=0x165aa2 last=0x913b49f mask=0xffffff ret=0x2a603 -> 0x2a603
[   14.030000] ##### now=0x18aa49 last=0x9159ce7 mask=0xffffff ret=0x30d62 -> 0x30d62
[   14.040000] ##### now=0x1a2971 last=0x917852f mask=0xffffff ret=0x2a442 -> 0x2a442
[   14.050000] ##### now=0x1c78d5 last=0x9196d77 mask=0xffffff ret=0x30b5e -> 0x30b5e
[   14.060000] ##### now=0x1dfe88 last=0x91b55bf mask=0xffffff ret=0x2a8c9 -> 0x2a8c9
[   14.090000] ##### now=0x236d57 last=0x91d3e07 mask=0xffffff ret=0x62f50 -> 0x62f50
[   14.180000] ##### now=0x34aaa3 last=0x922f6df mask=0xffffff ret=0x11b3c4 -> 0x11b3c4
[   14.890000] ##### now=0xbd0aad last=0x9342167 mask=0xffffff ret=0x88e946 -> 0x0
[   14.890000] ------------[ cut here ]------------
[   14.890000] WARNING: CPU: 0 PID: 0 at kernel/time/timekeeping_internal.h:44 clocksource_delta+0x108/0x118
[   14.890000] clocksource_delta() time going backward: now=0xbd0aad last=0x9342167 mask=0xffffff ret=0x88e946
[   14.890000] Modules linked in:
[   14.890000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-10689-g7af08b57bcb9-dirty #1
[   14.890000] Hardware name: Generic DT based system
[   14.890000] Call trace:
[   14.890000]  unwind_backtrace from show_stack+0x10/0x14
[   14.890000]  show_stack from dump_stack_lvl+0x64/0x88
[   14.890000]  dump_stack_lvl from __warn+0x7c/0x1ac
[   14.890000]  __warn from warn_slowpath_fmt+0x130/0x1a4
[   14.890000]  warn_slowpath_fmt from clocksource_delta+0x108/0x118
[   14.890000]  clocksource_delta from timekeeping_advance+0x6c/0x8e4
[   14.890000]  timekeeping_advance from update_wall_time+0xc/0x1c
[   14.890000]  update_wall_time from tick_irq_enter+0x6c/0xb0
[   14.890000]  tick_irq_enter from generic_handle_arch_irq+0xc/0x44
[   14.890000]  generic_handle_arch_irq from __irq_svc+0x88/0xb0
[   14.890000] Exception stack(0xc2201f28 to 0xc2201f70)
[   14.890000] 1f20:                   00000001 2d639000 c220da80 00000001 c220da80 c2208f14
[   14.890000] 1f40: c24af000 c2208f54 00000000 00000000 00000091 00000000 c2208f14 c2201f78
[   14.890000] 1f60: c15684c4 c1568448 20000013 ffffffff
[   14.890000]  __irq_svc from default_idle_call+0x1c/0x1bc
[   14.890000]  default_idle_call from do_idle+0x200/0x288
[   14.890000]  do_idle from cpu_startup_entry+0x28/0x2c
[   14.890000]  cpu_startup_entry from kernel_init+0x0/0x12c
[   14.890000]  kernel_init from start_kernel+0x6a8/0x6c4
[   14.890000] ---[ end trace 0000000000000000 ]---
[   14.900000] ##### now=0xbdfc5c last=0x9342167 mask=0xffffff ret=0x89daf5 -> 0x0
[   14.950000] ##### now=0xc8827a last=0x9342167 mask=0xffffff ret=0x946113 -> 0x0
[   15.060000] ##### now=0xdc3907 last=0x9342167 mask=0xffffff ret=0xa817a0 -> 0x0
[   15.110000] ##### now=0xe6b484 last=0x9342167 mask=0xffffff ret=0xb2931d -> 0x0
Sent SIGKILL to all processes
Requesting system reboot
[   15.120000] ##### now=0xe7fd9a last=0x9342167 mask=0xffffff ret=0xb3dc33 -> 0x0
[   15.170000] ##### now=0xf277d5 last=0x9342167 mask=0xffffff ret=0xbe566e -> 0x0
[   15.260000] ##### now=0x26c10 last=0x9342167 mask=0xffffff ret=0xce4aa9 -> 0x0
[   15.310000] ##### now=0xce799 last=0x9342167 mask=0xffffff ret=0xd8c632 -> 0x0

So, yes, it looks like the problem is seen after a large delta, and persists from there.

Guenter


