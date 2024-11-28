Return-Path: <linux-kernel+bounces-424949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFA49DBBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF211643BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87581C07DC;
	Thu, 28 Nov 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwMe/Gi5"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679921BFE0D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814000; cv=none; b=YViDxCqfbipRjRkpm1y4+/0aWSXcJ0Gu1WoFi4aJRSCX60ha4YXOJ2D99Gr/PyX+eiJ+e4FxjApa2OosMrsRZyMfj1TIOPYA2lpt7YHlN7oSjPQWb5NcMlj3VBRoEAVjEl78reS4M+ZaRHvNdumcuyKiJAznNq7BnojfnyKr5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814000; c=relaxed/simple;
	bh=F3cwToy4jnUS3ZVHEzCLC5dMITCZdez633bK+VPmAf8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IJNAanJeI6Nonp7O/XPjLZ4FkJgoRfM1Q0yNhA34yq6V5yIQ49bu7jV8MaUJCnYZ8B2K2AHrEmZZopIr55ZWPPtTvLJ6N7OWvSTUwmjuO9WGm5PDQMQ24QpinjSYXzf9CG8DYyAG1ZhK6MtPIU51/jMQvnHxw4o/Ld38oSQSR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwMe/Gi5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7252b7326f4so944393b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732813998; x=1733418798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MU7TQaTn03FJIwgAvcjeZbnB6BnczAu0SEBxJeIa8QA=;
        b=OwMe/Gi5JXf/tUOqGxTNgWe51ADQIWvneA8H652uC6FpvlYHsMr771zU/M+MCsv/1f
         G6PsQHahfxiPK/VFERmqcDqZlReGxFZoCgVa35hp0BJWYftMDId26jZaeA7DImDeJXw/
         jibAcIG1KhJiebv6CN0ikxeCOk0y/6QRx7KrQSQuoIp9mPn5XPlZL7f2WnwHeD6zcqV+
         LKbowh642toZrZ0SB4uF5DiEg+c8WfrLf9kcXf7On+qilVGaqAGvDq/gMQHrrYHV35YQ
         6RfTrLCDFT8Sq7MN5I1WfoshKHPtcszDq5jje6ntDeO5oeew/z6RTaxVeCavoZ78Bvke
         YWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732813998; x=1733418798;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MU7TQaTn03FJIwgAvcjeZbnB6BnczAu0SEBxJeIa8QA=;
        b=KZbH0MGZkcoAk5nMxiEmACDcbh2c//BSefeFx0U2hLEAEazxB4Bqj04lra7leXiUPl
         thFaZuzqOE/Ijy3XT5ixqUQsoj8wli8XetzqVE3kQOW8VLBqmp7c9jrgBm5b15iC9zqZ
         TevO3+OP3uULv1VuLNf6kU5m9nHf8/E/SD9lVVgkrLxaY8SKpVAYNTRclB4YBLKvQcoP
         1UuT/2MFaijnCLu43D+mSfumv2et4RNI1Rv6BWHaAsxQUJAVMeOwB2+6D+Pr47NzsaUP
         zB5EGNY6hOYeXUiKtP8uARZfO4NgJ1tx7tUOzsOhDKpXx7e408CTNBySHg8drvOywMuJ
         Bk3Q==
X-Gm-Message-State: AOJu0YxXf8KPu9FOIPlx2PFWxcd0VtyjU8ub8u6OcUurBf3oCYwbe44x
	/mR8a96E4mQSDvlhcpIwEHZXyPc1r32bHV6AiCb/Ir/hhvSdTjxH
X-Gm-Gg: ASbGnctd7s+6ZSgvUlq2UJRvqC7voK5DLc2D/mubt1TyRkdFetLylHajkl/g/0pO9Ty
	QyG1yIKT8N0HMaoO2UtCW28P2cUtnqc12BYQcFg80evtX5ZN8tfaC0yEIt+dkGzMpDEsryM3+H1
	8Jd0Thd0qckdCHe+2Y18jA1d10NGsXkburkcMGvJrUANTlZFs216X/dvNCvyMfZryW7Ak9YP86t
	o/V3sqoKQKsbARplLNGa3QtGRnUKVepxdJDbUagxeB5F6KlX7F71LfapHDcIGLweuLAxH+/r/DA
	lv0U6C5b8R+FLGYwZmANHO0=
X-Google-Smtp-Source: AGHT+IHtZfqV3Baxer6Za/qj6yysrLHt90o0m0JDlzw8WcCehmoysdlcHu70loPUIHTq/+hNHQiI3g==
X-Received: by 2002:a05:6a00:181b:b0:71e:16b3:e5dc with SMTP id d2e1a72fcca58-7253013e5aemr9739994b3a.19.1732813997697;
        Thu, 28 Nov 2024 09:13:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f627sm1839292b3a.64.2024.11.28.09.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 09:13:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a469d956-71f8-420d-8522-a2833b395c51@roeck-us.net>
Date: Thu, 28 Nov 2024 09:13:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 2/2] timekeeping: Always check for negative motion
From: Guenter Roeck <linux@roeck-us.net>
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
 <5510007a-98a4-4286-bf8a-7a6c5a494009@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <5510007a-98a4-4286-bf8a-7a6c5a494009@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/28/24 07:57, Guenter Roeck wrote:
> On 11/28/24 06:51, Thomas Gleixner wrote:
>> On Wed, Nov 27 2024 at 15:02, Guenter Roeck wrote:
>>> On 11/27/24 14:08, John Stultz wrote:
>>> An example log is at [1]. It says
>>>
>>> clocksource: npcm7xx-timer1: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 597268854 ns
>>
>> That's a 24bit counter. So negative motion happens when the readouts are
>> more than (1 << 23) apart. AFAICT the counter runs with about 14MHz, but
>> I'd like to have that confirmed.
>>
>>> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
>>> ...
>>> clocksource: Switched to clocksource npcm7xx-timer1
>>>
>>> I don't know where exactly it stalls; sometime after handover to userspace.
>>> I'll be happy to do some more debugging, but you'll nee to let me know what
>>> to look for.
>>
>> On that platform max_idle_ns should correspond to 50% of the counter
>> width. So if both CPUs go deep idle for max_idle_ns, then the next timer
>> interrupt doing the timeeeping advancement sees a delta of > (1 << 23)
>> and timekeeping stalls.
>>
>> If my ssumption is correct, then the below should fix it.
>>
> 
> While that didn't work, the following code does.
> 
> Guenter
> 
> ---
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 0ca85ff4fbb4..bd88c04ae357 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2190,7 +2190,7 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
>          /* Accumulate one shifted interval */
>          offset -= interval;
>          tk->tkr_mono.cycle_last += interval;
> -       tk->tkr_raw.cycle_last  += interval;
> +       tk->tkr_raw.cycle_last  = (tk->tkr_raw.cycle_last + interval) & tk->tkr_mono.mask;
                                          ^^^^^^^                              ^^^^^^^^

No idea what I was testing earlier, but that obviously doesn't work either, and masking
both tkr_raw.cycle_last and tk->tkr_mono.cycle_last also doesn't work. Sorry for the noise.

Guenter


