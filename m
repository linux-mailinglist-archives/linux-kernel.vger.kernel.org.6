Return-Path: <linux-kernel+bounces-426397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F289DF28D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 19:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DE52810EA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4D41A9B45;
	Sat, 30 Nov 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoTAI2k7"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231E1DFF7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732990913; cv=none; b=cVss/YygLuxg1uxt2JMumJrfQ26NVgTRv7lIFhvgS+4HGsJM+Y1GFrsoBpE51KgJPgwnxyD3MTPVI7OoYlAAKTeW/ml94nEkMzy/tDA52DucDips29E2HiwdwPd/GCrvrrg9DfgbObGnBS1XCJV4ynv0eCW7BbfsXE0K0Z31WDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732990913; c=relaxed/simple;
	bh=BnHBHttQOxBVrouKsXdazF3acHI54f+yAOwGXHoDLgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ef5gKFAZWbxK6+LIfjQfXgoqUnPkTIiKzaxJ6plhvmcTcf/aPAzu7QtLIP5bRLjSoXf+EI1+wv0s3vysIv4w29OOt6H1C3GtZnVX/96BSip/7OjnRhhwoL2v948b82ZDwBFIYltF50nckaJUNmYgD4/FvK/I/LNvHj91ZorOpfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoTAI2k7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2155312884fso11403025ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732990911; x=1733595711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=14TM4KBLvDqVnsIATgpmagR/Uy1b+yigpC0FNNPJiJU=;
        b=OoTAI2k7Io4/X5PzG0yhIr8LTN3RxfCaslytCZcYm6w6m3RtXRrRwwALjr8Nrl2Ax1
         Zns2TxzjxpbMlMOasXYBGbuXC4JAgk+ArJB7ot4RGXN4dmoe+uDxn1naEu+OzZahyNSR
         wlANX8yRmq3FRYw22wJ0wcErXjWIYkmyRdVMIDYImLJpRtCYB8JgjHg6N6a3dYs3NLOX
         kIStAWge7kVLcwTDuBp2to5kpVc1IWu8Jt8rF39hREFxi8n3+OQu741W3c4UprKzGecv
         3EHor3LgqUKRAq3vvZ474xKD/XpDXNcuxm0vzBU0dxRQkhk5/D5q2QSKxWExhAkayzQY
         qbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732990911; x=1733595711;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14TM4KBLvDqVnsIATgpmagR/Uy1b+yigpC0FNNPJiJU=;
        b=xB6ZDGKUxLXxxfpuWUdRqfwA94SQvzkacCn1HHVTfIVJWa3gi+y9cZrMhQht2Lzt7j
         upMUynbon6ODkXZ/P4LxYIKx77jJo0Rfp6qJ1fqmHcWAZD7QC38lR/BeGQPg1XMk8LKm
         op4uVLPwTmVMVETPgkMF2xb3bRNX8aZdt5tJOjvSSoo7ek32Bd+Qhd6bHd96vajXyAPz
         n13BzIF0nWUvCeUWgasZf2aPvg5a/zUuPwUETBVjCLLBZsLhGL8v35zRSTH/HAAb4wPQ
         uzxfynqC3sJkHtYYtlzW/NmjbNvENy3uLfjsnsizuTbiRn2XGKfm6Y4qS+J/BeLjx+cC
         awqQ==
X-Gm-Message-State: AOJu0YxMH8wt3Uoa0Hftpmzv9+u6hvgXSEiRA9e/hQd6WuzUDNVXa0lY
	aCQWKhJaT8i7kvsm91v3L1zTMPjWfsRfK+oS93+stMUETJlvNAUD
X-Gm-Gg: ASbGncuuyIfeBHpKvtRXvkO4g8vxWL3MfS1YK+dQkNB/gCf2hhpbAHuKoaKVo1TECmJ
	jmUUXYlGIYllSfsgADTi30KVoqoqExWfQBLew71CT57ztthqadBcPjJgElwLMtv/CQuqBzCydib
	mJvEgR5TYWxiO8JQ3xzFZ4iGMT2c95AcCzINMT2Cs3VFJFQBsa647rqwfx1itEbmmKIutSzrgqG
	COCwglGYDQ/Kyd/8f22WvRCta9sINVzbjbXeN5YkOG8aNUzdcvOCf5KoK+FhRBpnNmpkD5uB1h5
	H98OECh2uEZzIC+7CaVx73s=
X-Google-Smtp-Source: AGHT+IEeUPQgq6ZltJZ/xK8qiteG+sF+q/DUByeZXyq08G9YU9FfO6xY1zNYu7PrHyrZ/jtcyFOxEg==
X-Received: by 2002:a17:902:f682:b0:212:55c0:7e80 with SMTP id d9443c01a7336-21501099c69mr192829575ad.20.1732990911251;
        Sat, 30 Nov 2024 10:21:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905fe6sm49301605ad.96.2024.11.30.10.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 10:21:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a79b27d5-ae85-4b7c-bd08-ac7b345f3a20@roeck-us.net>
Date: Sat, 30 Nov 2024 10:21:49 -0800
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
 <2b732d25-63e7-40f7-8d66-b1e6dc0b701d@roeck-us.net> <87r06tvuzd.ffs@tglx>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87r06tvuzd.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/24 03:09, Thomas Gleixner wrote:
> On Fri, Nov 29 2024 at 08:09, Guenter Roeck wrote:
>> On 11/29/24 04:16, Thomas Gleixner wrote:
>> [   13.860000] WARNING: CPU: 0 PID: 0 at kernel/time/timekeeping_internal.h:44 timekeeping_advance+0x844/0x9d0
>> [   13.860000] clocksource_delta() time going backward: now=0xd60127 last=0x85170f4 mask=0xffffff ret=0x849033
> 
> So this is a idle sleep which took longer than max_idle_ns. The rest is
> the consequence of this as timekeeping does not advance and the timers
> are rearmed on the stale time.
> 
> Can you try the patch below?
> 

That one works. I booted kudo-bmc 60 times without failure. I also tested the
patch twice with all my qemu emulations, for a total of 1000+ boots with
different machines/configurations, and did not see a single failure.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> Thanks,
> 
>          tglx
> ---
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -49,6 +49,7 @@ struct module;
>    * @archdata:		Optional arch-specific data
>    * @max_cycles:		Maximum safe cycle value which won't overflow on
>    *			multiplication
> + * @max_raw_delta:	Maximum safe delta value for negative motion detection
>    * @name:		Pointer to clocksource name
>    * @list:		List head for registration (internal)
>    * @freq_khz:		Clocksource frequency in khz.
> @@ -109,6 +110,7 @@ struct clocksource {
>   	struct arch_clocksource_data archdata;
>   #endif
>   	u64			max_cycles;
> +	u64			max_raw_delta;
>   	const char		*name;
>   	struct list_head	list;
>   	u32			freq_khz;
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -24,7 +24,7 @@ static void clocksource_enqueue(struct c
>   
>   static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u64 end)
>   {
> -	u64 delta = clocksource_delta(end, start, cs->mask);
> +	u64 delta = clocksource_delta(end, start, cs->mask, cs->max_raw_delta);
>   
>   	if (likely(delta < cs->max_cycles))
>   		return clocksource_cyc2ns(delta, cs->mult, cs->shift);
> @@ -993,6 +993,15 @@ static inline void clocksource_update_ma
>   	cs->max_idle_ns = clocks_calc_max_nsecs(cs->mult, cs->shift,
>   						cs->maxadj, cs->mask,
>   						&cs->max_cycles);
> +
> +	/*
> +	 * Threshold for detecting negative motion in clocksource_delta().
> +	 *
> +	 * Allow for 0.875 of the mask value so that overly long idle
> +	 * sleeps which go slightly over mask/2 do not trigger the negative
> +	 * motion detection.
> +	 */
> +	cs->max_raw_delta = (cs->mask >> 1) + (cs->mask >> 2) + (cs->mask >> 3);
>   }
>   
>   static struct clocksource *clocksource_find_best(bool oneshot, bool skipcur)
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -755,7 +755,8 @@ static void timekeeping_forward_now(stru
>   	u64 cycle_now, delta;
>   
>   	cycle_now = tk_clock_read(&tk->tkr_mono);
> -	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
> +	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
> +				  tk->tkr_mono.clock->max_raw_delta);
>   	tk->tkr_mono.cycle_last = cycle_now;
>   	tk->tkr_raw.cycle_last  = cycle_now;
>   
> @@ -2230,7 +2231,8 @@ static bool timekeeping_advance(enum tim
>   		return false;
>   
>   	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
> -				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
> +				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
> +				   tk->tkr_mono.clock->max_raw_delta);
>   
>   	/* Check if there's really nothing to do */
>   	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
> --- a/kernel/time/timekeeping_internal.h
> +++ b/kernel/time/timekeeping_internal.h
> @@ -30,15 +30,15 @@ static inline void timekeeping_inc_mg_fl
>   
>   #endif
>   
> -static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
> +static inline u64 clocksource_delta(u64 now, u64 last, u64 mask, u64 max_delta)
>   {
>   	u64 ret = (now - last) & mask;
>   
>   	/*
> -	 * Prevent time going backwards by checking the MSB of mask in
> -	 * the result. If set, return 0.
> +	 * Prevent time going backwards by checking against the result
> +	 * against @max_delta. If greater, return 0.
>   	 */
> -	return ret & ~(mask >> 1) ? 0 : ret;
> +	return ret > max_delta ? 0 : ret;
>   }
>   
>   /* Semi public for serialization of non timekeeper VDSO updates. */
> 
> 


