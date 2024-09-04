Return-Path: <linux-kernel+bounces-315138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1296BE72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC431F26108
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0EF1DB55F;
	Wed,  4 Sep 2024 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5TAk1mB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBF1DA630
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456368; cv=none; b=eAHdbsjCTVRgrh7QnujrCa2zMQa3S4cpaTYWq2vXCGiSMlusX3okxyAGF9WUzjhqfhtnf3NgimOUrCCZD9yFnC2pEKVJwFlyZ9tJ00yTexwapHa/dC/XFE6SBoqtj5cCdimf8X7KoZaNmUDVGH+1vQbg32Ee9KkRKs+34jePAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456368; c=relaxed/simple;
	bh=fV02eram5SAlbEuGwmDuQ+se3z089NuDaBoBuGLrODk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gULHKR+T3s8EjCxiTqO5NTKpfmzr2OXLu1kEwUjNMQ/pLofmkrjLbwQo87DCvniOUMGk9dzF5oLHeyzL2M1UzEffZAh4oz66KuQLy9DgNb78cpnnKPwmi/Rt4vb0vCXaHyjNw+1bkkyK7n8qzB8YxFnjGg7tjM8pMocbAyW766c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5TAk1mB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725456362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8SNhHCBduhr9H1n14OffkTff0HidGminGrYHFT9HiFw=;
	b=T5TAk1mBOW742wmvrFsNZDWXHT054DZ+mQwy3UZsNU7KHK6A7n5YYCMbj4+8gokS3ybbq+
	zTTg93KPLHWBBBfWti719iphQ0v/d8BHKFBkVs1qsBnFGKXuWWaNQDydO9QnTi3mvNENs+
	HfVhMhRJRuE+TK58r66ufWzYyS1+J68=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-OZXVNq5uOvmDfzFNmYLkLA-1; Wed, 04 Sep 2024 09:26:00 -0400
X-MC-Unique: OZXVNq5uOvmDfzFNmYLkLA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8685464a7dso481665566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456359; x=1726061159;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SNhHCBduhr9H1n14OffkTff0HidGminGrYHFT9HiFw=;
        b=Sk/g0kY6i8l2effFfuMDpcZ7yF8HSUpU11kRxKLNLNZW0yVimjxivLpjI8WrN0lHDZ
         DWhsCnNAeLlrlMVJ8nG3M/RtFlzqcMx0Vad36S7UtNTuB5TE33zaQDZcIWAnEXZS4DWR
         4Pc4s4tXOIs0AxVHiV8CQuWtn1SUzhPdF5dEj6SRZQzqprbjyWmVpyI8cr+HBT1msT7J
         IRHvSerlyBO3EHnrWkZXm3LncNL6p/zQyoCVoc5n8k2Vl+pvRVomnrO2OiHRH7kvTjbU
         53UX7I7PBSoOxgNBcuAphTbt58pHd4rL9q7jHc7T1wvg2Soo1CcdgP7PtVSngE2827AA
         ILiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqLGlXns6GT9Mifj4/Gv4Icl0op/9yPVUPSBOdaiiusFM7byF5GQ6Wk5uogO1qnVWK2q3GbVseytImUiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0AfjWndbTxl9OVe2Mq3HZrFRyMQceToeuIfkmNtcVZfwvlWa
	MeffEDXrYSqv6TLhdVI+TzK8aOE1xYMvHbpFeVBt8XpHPtZyQ+0Wi5y02RdRvSPoIQX9sdfzzWD
	eQzU0gAko5bL6CyM9U/Z2hdxQdjcIHMd75dVPBQBvMyqQ4JvTD84hS/Qbix5xdw==
X-Received: by 2002:a17:906:fd8b:b0:a86:968b:e9c1 with SMTP id a640c23a62f3a-a89a34e4375mr1246384166b.5.1725456359144;
        Wed, 04 Sep 2024 06:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc9RX7yalPWjcjlOP7ue8yMLn3BH4LZGW+kIo2ts8WjY3/Ym+juQ7azkErO7rt9xEW79nx+w==
X-Received: by 2002:a17:906:fd8b:b0:a86:968b:e9c1 with SMTP id a640c23a62f3a-a89a34e4375mr1246380666b.5.1725456358569;
        Wed, 04 Sep 2024 06:25:58 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a898908ebfasm813233866b.95.2024.09.04.06.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:25:58 -0700 (PDT)
Message-ID: <9b6ef0fa-99f5-4eac-b51a-aa0a3126c443@redhat.com>
Date: Wed, 4 Sep 2024 15:25:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] KVM: Remove HIGH_RES_TIMERS dependency
To: Suleiman Souhlal <ssouhlal@freebsd.org>,
 Sean Christopherson <seanjc@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Vineeth Pillai <vineeth@bitbyteword.org>, Borislav Petkov <bp@alien8.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 suleiman@google.com
References: <20240821095127.45d17b19@gandalf.local.home>
 <Zs97wp2-vIRjgk-e@google.com> <ZtgNqv1r7S738osp@freefall.freebsd.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZtgNqv1r7S738osp@freefall.freebsd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 09:35, Suleiman Souhlal wrote:
> On Wed, Aug 28, 2024 at 12:34:26PM -0700, Sean Christopherson wrote:
>> On Wed, Aug 21, 2024, Steven Rostedt wrote:
>>> From: Steven Rostedt <rostedt@goodmis.org>
>>>
>>> Commit 92b5265d38f6a ("KVM: Depend on HIGH_RES_TIMERS") added a dependency
>>> to high resolution timers with the comment:
>>>
>>>      KVM lapic timer and tsc deadline timer based on hrtimer,
>>>      setting a leftmost node to rb tree and then do hrtimer reprogram.
>>>      If hrtimer not configured as high resolution, hrtimer_enqueue_reprogram
>>>      do nothing and then make kvm lapic timer and tsc deadline timer fail.
>>>
>>> That was back in 2012, where hrtimer_start_range_ns() would do the
>>> reprogramming with hrtimer_enqueue_reprogram(). But as that was a nop with
>>> high resolution timers disabled, this did not work. But a lot has changed
>>> in the last 12 years.
>>>
>>> For example, commit 49a2a07514a3a ("hrtimer: Kick lowres dynticks targets on
>>> timer enqueue") modifies __hrtimer_start_range_ns() to work with low res
>>> timers. There's been lots of other changes that make low res work.
>>>
>>> I added this change to my main server that runs all my VMs (my mail
>>> server, my web server, my ssh server) and disabled HIGH_RES_TIMERS and the
>>> system has been running just fine for over a month.
>>>
>>> ChromeOS has tested this before as well, and it hasn't seen any issues with
>>> running KVM with high res timers disabled.
>>
>> Can you provide some background on why this is desirable, and what the effective
>> tradeoffs are?  Mostly so that future users have some chance of making an
>> informed decision.  Realistically, anyone running with HIGH_RES_TIMERS=n is likely
>> already aware of the tradeoffs, but it'd be nice to capture the info here.
> 
> We have found that disabling HR timers saves power without degrading
> the user experience too much.

This might have some issues on guests that do not support kvmclock, 
because they rely on precise delivery of periodic timers to keep their 
clock running.  This can be the APIC timer (provided by the kernel), the 
RTC (provided by userspace), or the i8254 (choice of kernel/userspace).

These guests are few and far between these days, and in the case of the 
APIC timer + Intel hosts we can use the preemption timer (which is 
TSC-based and has better latency _and_ accuracy).  Furthermore, only x86 
is requiring CONFIG_HIGH_RES_TIMERS, so it's probably just excessive 
care and we can even apply Steven's patch as is.

Alternatively, the "depends on HIGH_RES_TIMERS || EXPERT" could be added 
to virt/kvm.  Or a pr_warn could be added to kvm_init if HIGH_RES_TIMERS 
are not enabled.

But in general, it seems that Linux has a laissez-faire approach to 
disabling CONFIG_HIGH_RES_TIMERS - there must be other code in the 
kernel (maybe sound/?) that is relying on having high-enough HZ or 
hrtimers but that's not documented anywhere.  I don't have an objection 
to doing the same in KVM, honestly, since most systems are running 
CONFIG_HIGH_RES_TIMERS anyway.

Paolo


