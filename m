Return-Path: <linux-kernel+bounces-424896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B199DBAED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE7F9B21452
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A82C1BD9FD;
	Thu, 28 Nov 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv6hqFex"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3771BD9C8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809441; cv=none; b=SeZY3jaKyDZDmB26FsM2V+mip3B2CIrLvDmzUD31LwnSuFvg24L/sANhffJVIw5E+ZIqY4ZMAS8+Q/RVt8arwXwrjgficWejNuflL8zxpE3ERymmtaBI80x+Fhgs4ItXTzUw792G+1Web0gWYFG6qPUxn14vgb7h55MdPJOZBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809441; c=relaxed/simple;
	bh=LXvW+j2+xwmZdZ04gCfTbpArKTx1q/9qLJD7PeRtxDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twj3MHpRZwmVT2rMZrOQOhEW/8vxRIa/QB+dGZV3J6JhMWCo4qvb/QCbzGIzY+5v5w6eFVAt+bQbNYcYJsyLLBHlomKzBCCVUxS/SVgEe1SAPb7MaBiZzk9AHpLN38/15KydKX03QSs8GsGPoZwac8imzNLNzGXV7/CSGljmBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv6hqFex; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fbd76941ccso643453a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732809439; x=1733414239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5a++J4/+cuTplvK+W+U01nIyJSzbPbEsv+SUmogD60Q=;
        b=Fv6hqFexPRpaKxiBoSrVSLbYwHZF0ELDGYohVbmTVGyKB77cvFnoKFepmCr/R/59tb
         LsNpx3Cu0WJhWR8C86wbisKqkfw46mmpszF5Z6JQ2cbM9gPGh69/i1wdCN6CcUpWXz2+
         0WeDRmylT5AA2r14daoOVFngRQgFu7gaky/q2SRgLWokTx0ah8HQs67fR3N69dKDkKP4
         rtdaqaSpsLmVzEqZemFj3PQNUBC0g33VO2r08K/JegOkcRBXDj8YkWBc4rgp3GGqsl+C
         V4rlokEIOcCB6F+MMDL59Tws05yQyty3P+vs7wqIY5NL8URp/WUpFexgi8mTNqh85Mzi
         1ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732809439; x=1733414239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5a++J4/+cuTplvK+W+U01nIyJSzbPbEsv+SUmogD60Q=;
        b=KSWbAMQM+oOp1FgNH+bK/P4pzqAXRiFzROKSV2KyaNIw1JtK8lNY3NVU2ZCxQuUSQ5
         1u2LUa4pk4K49GFyjQKwHSIKUZ2C7c2IOQN5F20y6L3rz47BMweeZKw4Up97pVJPTMhC
         qR0/OFm8S7y4zglue+YQU1mhQXo9GSLhI1h1KcU0SnDbAjZetHhmnHvmybnvYmwrp4Bb
         AKbJxEtsdUuCiRcG8Ldk4rNlFq3kS+sVn942dnrJtZm6C/DMOV9BY8R1E5usOSgkL0KA
         KIMc4y0gWEhF4M/Po8nwQGpzRLnKviqb0iSRv0cE9uW9FDsShkxrJwgjae0KSk/rED3G
         xxDg==
X-Gm-Message-State: AOJu0YwZZ4IRVU2s4G2JggsPRK+xWx8kFZIqi1W8TgczzrTrjNBX4Gpd
	+ibjpa5EAjU+IVsIb3lnflRp3Su0UpnkqVxd/Q34eqTeJG4eP9QE
X-Gm-Gg: ASbGnctHQpP5kEfU2tfYB8EiBUTPUhCKTYElp/bdC5YUuI1Vi0JQcbkXIr4cfWNXqUD
	IazW8DY9XpW/sWE/M/dNYjtZBIYkIoi8mpfD8ethXIfqQweM4fBJv9u9sXwkSgfe7eU0B53j2uy
	ag+avwQ1CG8lNwudXfIipQrH0kQnTv55AmK9ToLCc9JjpeLLPD1fXJIuOAuft8UxMpaxX7iOaB0
	O3uphbO7+qoVkBEW6WEvfjrwWZtEEESA1d60oI686j/E42bKWyXRJAHoA3GkEtUBbh/Gn9OF0tx
	4rJFHQV0UZ7hJW7ZVJFpaWM=
X-Google-Smtp-Source: AGHT+IE+Hp41g45dVUaq3YvMJKEyVqFlR95Q9Ek5L9JeeZBde0O9/3N+c9bfFz9c57TCnRbhr5MQRA==
X-Received: by 2002:a05:6a21:789a:b0:1e0:d867:c880 with SMTP id adf61e73a8af0-1e0e0bae6bamr12578512637.42.1732809438054;
        Thu, 28 Nov 2024 07:57:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541813af5sm1691514b3a.137.2024.11.28.07.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 07:57:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5510007a-98a4-4286-bf8a-7a6c5a494009@roeck-us.net>
Date: Thu, 28 Nov 2024 07:57:15 -0800
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

While that didn't work, the following code does.

Guenter

---
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0ca85ff4fbb4..bd88c04ae357 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2190,7 +2190,7 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
         /* Accumulate one shifted interval */
         offset -= interval;
         tk->tkr_mono.cycle_last += interval;
-       tk->tkr_raw.cycle_last  += interval;
+       tk->tkr_raw.cycle_last  = (tk->tkr_raw.cycle_last + interval) & tk->tkr_mono.mask;

         tk->tkr_mono.xtime_nsec += tk->xtime_interval << shift;
         *clock_set |= accumulate_nsecs_to_secs(tk);


