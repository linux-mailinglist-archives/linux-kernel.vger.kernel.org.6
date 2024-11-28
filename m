Return-Path: <linux-kernel+bounces-424871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD37A9DBA82
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561E416411A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88821BBBD3;
	Thu, 28 Nov 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQysirC4"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108A96F06A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807829; cv=none; b=G2EnO5ra1oCyhOtR987ocDRixBkN9amXeUqTthzP2Q7PhOpV72g6l1jd2Orb+SZHnEEwA6JYBF8lsRP61wr2jMIYsKfL4oc5Nehb4FX3X7yIbBylCvTz6XMQUf3eP+byxjofWoUmAQ3M5F3sAcQA2ZkFPUvTaPe+HhlN0/SIqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807829; c=relaxed/simple;
	bh=UJTe6PBOBJghNsnzmaDR5XHZdvhqa8tTW4YbDznWTVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6mZGustf35H9CcDQKBT1+bl0kng1Llo14JQO1DMnYB52+BOLn5L7WrTg7MlJM6oA8hyfSGfesrG7+DFWg5yjmnihWex952vkdknhRoBnnRMPJtpLF+Y+xnq4TCXHtxgfKGkEpUnHXHneCax5uX0SptaptbmOypG2bRDsx6sEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQysirC4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee173d0480so684139a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732807825; x=1733412625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xfhnrk/fjHimCnpi3KlVhqg+6hm8B9fRk3wgYRkMvjo=;
        b=AQysirC49X7REmTYbFgJeqnMR3NFGhAsvqQHpMeZ+b5dRxktM9TmHQ3+l+ufLdwWZf
         1X0ZtjnNRVS6a/vjKWMCRe3cGbHu5Y4RRbYxgNtsrPA0tsfNGBaRLgmqamwatyFQPpx1
         OH3/rk3UzUdj+TsQDHHath6gPtQ8akfM0Ro7YoMn/WnpTobrebAb+lGZldlixtj70oay
         MkoJJjZ7lgqab6V3pITKxyWbGnBNZF7mOwhMbHUOJOVTTsTBEPuR7sWz/hjtkzOosZC7
         vDLZ4qt9/A0BZgl7QbhU1t6nxNelVuVXjorT4MQo+cXyv8KojeAZ3OB3EWUBU7JiFV9y
         jjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807825; x=1733412625;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfhnrk/fjHimCnpi3KlVhqg+6hm8B9fRk3wgYRkMvjo=;
        b=lT/a+hRdV7qB4vv70NJFea0PODks9fR5mz1qQm7U6xutNe1NfWBzhwPPh+2d52Vl0C
         AJrzzeKITSGy5Q/GKlj2mlkGcnsaWgak5R/7VZd3uMqN4HAYzEQq0MBWs8QQan+tA4u/
         ekurmHCKx3oxnjXIOTb9x/6CBlmxv667M+hWPuYR2PDH2VAA3dEsC14gRC+KJmB86f7p
         TrpOsnx3fRQOyvFP4wnzkRvekA9xbLbyRUGR34kyyzL2WrwKI5/OlgQWv4inpcoVe4X0
         tHOpxt/3/k2PDWk76J4QBjOXUVUsujtM9fUzpeLwabqoU2nSUodTM3v9dK+FeER5tkRc
         kVkQ==
X-Gm-Message-State: AOJu0YwWMlrfU+t4BvkqVm7GBvV+BH5d+Nmzu/vXnVL7D3QDU3gMgEFl
	HclCd/CsNx3o9Lxc23p8v1noutQjddLlkR4ONBjnYmu3397INUzTIAXJoQ==
X-Gm-Gg: ASbGncu80wABnnXZFJHPWvpaV9O9E7bYasO6DvCpvWu77ja6/FoTyXuXrOpxuLXZC+K
	K3einAlqqr30NfpV/sSB5aD+pO7Fpo+EbU3wrLGjLQEiyJDzc4gklOd6LLThLKW55o4YUnaUzVt
	rM5LqQ0MK+50IL1JgY6A1q7TKLabSrWoX7HixxxZ5fE0jFIsmFigza5lyAJqb7WxchC5ahOLSV6
	dgk2CBtDKNiAqkmgmyzYEhchlnSkzleELU521w89p8iENzgcUejIVmNxFPGUlcmoaE08obGF/at
	GiHgDDtNuLjHtdlEZoXjgLg=
X-Google-Smtp-Source: AGHT+IGXZlXsWT04uOtFYcxh5DXtcLTW+b6IDvHRLknppvlNvMKpvoSkzN4b1Xvn+uKcPMbp7ZrpYg==
X-Received: by 2002:a17:90b:1d01:b0:2ea:61de:38fa with SMTP id 98e67ed59e1d1-2ee097c5a0amr10107166a91.27.1732807825112;
        Thu, 28 Nov 2024 07:30:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d6022sm1457080a12.1.2024.11.28.07.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 07:30:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2cb25f89-50b9-4e72-9b18-bee78e09c57c@roeck-us.net>
Date: Thu, 28 Nov 2024 07:30:22 -0800
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87cyifxvgj.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/24 06:51, Thomas Gleixner wrote:
> On Wed, Nov 27 2024 at 15:02, Guenter Roeck wrote:
>> On 11/27/24 14:08, John Stultz wrote:
>> An example log is at [1]. It says
>>
>> clocksource: npcm7xx-timer1: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 597268854 ns
> 
> That's a 24bit counter. So negative motion happens when the readouts are
> more than (1 << 23) apart. AFAICT the counter runs with about 14MHz, but
> I'd like to have that confirmed.
> 
>> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
>> ...
>> clocksource: Switched to clocksource npcm7xx-timer1
>>
>> I don't know where exactly it stalls; sometime after handover to userspace.
>> I'll be happy to do some more debugging, but you'll nee to let me know what
>> to look for.
> 
> On that platform max_idle_ns should correspond to 50% of the counter
> width. So if both CPUs go deep idle for max_idle_ns, then the next timer
> interrupt doing the timeeeping advancement sees a delta of > (1 << 23)
> and timekeeping stalls.
> 
> If my ssumption is correct, then the below should fix it.
> 
Unfortunately not, it just makes things worse and stalls earlier.

[    2.080000] Fusion MPT SAS Host driver 3.04.20
[    2.080000] npcm7xx-ehci f0806000.usb: EHCI Host Controller
[    2.080000] npcm7xx-ehci f0806000.usb: new USB bus registered, assigned bus number 1
[    2.080000] npcm7xx-ehci f0806000.usb: irq 39, io mem 0xf0806000
qemu-system-arm: terminating on signal 15 from pid 17184 (/bin/bash)

There is something else going on. I reverted the offending patch and
added

+       pr_warn("###### now: %llx last: %llx mask: %llx return: %llx", now, last, mask, (now - last) & mask);

into clocksource_delta(). Here is what I get:

...
[    3.310000] ###### now: f8c502 last: f6c964 mask: ffffff return: 1fb9e
[    3.320000] ###### now: fbc513 last: f8b1ac mask: ffffff return: 31367
[    3.330000] ###### now: fd368d last: fa99f4 mask: ffffff return: 29c99
[    3.340000] ###### now: ffe8b3 last: fc823c mask: ffffff return: 36677
[    3.350000] ###### now: 6c4f last: fe6a84 mask: ffffff return: 201cb      <---
[    3.360000] ###### now: 40427 last: 10052cc mask: ffffff return: 3b15b    <---
[    3.370000] ###### now: 43bfe last: 1023b14 mask: ffffff return: 200ea
[    3.380000] ###### now: 6f438 last: 104235c mask: ffffff return: 2d0dc
[    3.390000] ###### now: 8e9a3 last: 1060ba4 mask: ffffff return: 2ddff
[    3.400000] ###### now: ac9d3 last: 107f3ec mask: ffffff return: 2d5e7
[    3.410000] ###### now: cb9b4 last: 109dc34 mask: ffffff return: 2dd80
[    3.420000] ###### now: e9ba2 last: 10bc47c mask: ffffff return: 2d726
[    3.430000] ###### now: 108994 last: 10dacc4 mask: ffffff return: 2dcd0
[    3.440000] ###### now: 1200a0 last: 10f950c mask: ffffff return: 26b94
[    3.450000] ###### now: 14c55f last: 1117d54 mask: ffffff return: 3480b
[    3.460000] ###### now: 15d43a last: 113659c mask: ffffff return: 26e9e
...
[   18.100000] ###### now: f8c39f last: ceea990 mask: ffffff return: a1a0f
[   18.290000] ###### now: 1d01af last: cf832f8 mask: ffffff return: 24ceb7
[   18.500000] ###### now: 45b0a2 last: d1c7050 mask: ffffff return: 294052
[   19.090000] ###### now: b5ac62 last: d447e38 mask: ffffff return: 712e2a
[   19.110000] ###### now: b9ebc3 last: db506d0 mask: ffffff return: 4e4f3
[   19.120000] ###### now: bb842f last: db8d760 mask: ffffff return: 2accf
[   19.160000] ###### now: c43f2e last: dbabfa8 mask: ffffff return: 97f86

'last' advances beyond 'mask', and after that the result is always bad. The call to
clocksource_delta() is from timekeeping_advance().

Guenter


