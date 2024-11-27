Return-Path: <linux-kernel+bounces-424032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3D29DAFA5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B224AB22A55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D1D204086;
	Wed, 27 Nov 2024 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTaJ5E94"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88D2010E1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748542; cv=none; b=dNfMtTHNlhOR82c4FRP3cy8K5eRVXQaaFi7Blba0ralC4NPtdcNXcLFeyzCpBWo8xnX3eTQ0t53ihwlmxVzgfmkz1OQUJkWtZODXuGq0X6c4I88K7PkpAN0UFeg8MoxrabzRs12NnbmoMfIVxW6gnMxxzlabAqBNbZ221a52STA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748542; c=relaxed/simple;
	bh=8899YqmwboBCRm2RPOTIr4JsxEC4sUiJ1cym3AWghNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXt2pwuXPlupUC6Wqa0Cx3md+o4+d9zdGXev/cF4ZEWbD/plhf2T96v9ZsYDnt6a846+PnM6y2vPqAxzdMe2Buu+xq0yhdO2olkiEDpy3vgO3gZx58ulTJnImtzZqWzKXr5HseKzerAjJYs3fBao/gA6txR0sniGJNL0RlVLiRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTaJ5E94; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21210eaa803so1699455ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732748541; x=1733353341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WjXHlg0h7rLlmdqKDt/rT0yzIJh4zjPwDUUk4FHRd+8=;
        b=hTaJ5E94WqHReKuLNda3TPnBykrnsDeFofqgZkDO4L6iaKH77ERkaRwDLSA8g0CVFM
         /MlNueIQEt7vu/TWrRpzaCVOvKHFw9HLXhGUKqaiCZZXve2tpqgLBTCZb61hk1K0gghp
         9BejQ4CemvtLOGsCG2UqdcthF4kntPfo2b1MmhQ6fW4vxJDRO+m7dGpsDxZuQx8Ia+rm
         79k1KgGV/P0IkZIst7NZLwdcYv0ENZZi5BrfF7XU7uML73qyI/jizHRGfInZ7vpOF167
         PbPgVdub4vCVi7oy9lR54WSGtzsctydS3QeK2edZYsEBFT4mmBxSroh2TiMPMMIjnQ1C
         FMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732748541; x=1733353341;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjXHlg0h7rLlmdqKDt/rT0yzIJh4zjPwDUUk4FHRd+8=;
        b=LIIl/Zrz7/9SFCh288mAllZuWxUuLnLhrR770pb88Vhhcf0/nbx9gG3Cex+tBBlyLD
         99uUL18+0C2UkLig9gZekomo0TAPczvVbM+mc1r/ARHuuZY+HuYqOdkf8JOgUJn9xD8V
         3cZXGYLbHOdWhMVo4PKUg01iS7zz4UQTQjtfCHgoKpwFf2Mx3qr/kOnjFrHvPRa5kEhJ
         1fSj1sboZgKgA52bMqtNpZ86wku1SvljQTW1DZ4AI0fJ+kQw5KTR4jv+8qdrI9Y8ByBr
         XuR93HXMyqaoqbit8yY6Iz7HuKMDdpxoM8sEEtfi/NDcWuI7LcCDHnPPOgmBfjBIsklx
         Q95w==
X-Forwarded-Encrypted: i=1; AJvYcCXR4zqMClbjZs8UwKJ72Waf9Kn4mVEJfsymf756zF40moKtBh4DYRbGD6IJVIYZ4CWnYe3NM4p/FS6D2v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqdTWIVMVhcmozj8Q0+dG2mKEDHxWRk0xiTP+DVfAvOsuu3k8
	//oePzoEHTw/TblsKFkQ+75UySe6H0KBTWGyBjE1u/I6S6lrtxSb
X-Gm-Gg: ASbGncvAJb6Ek3XgVTYh5lZPimfLfyaLTpG7vZfL+42l/5O9lQvAZsRojA4iUK8GEDD
	VWkNmoIflAvH1yTR8KtZBptf8TGlLTfZIEq13GE2ncZ/a6Q8Nb1vqW8GcHUi8DFUIB7xEyKg6H6
	K6l6sOl92HKJIZuBzMcDVFxIuwg1IZjbU7/YZrADa9KSN/TVaykROPhfOq74tqf6EczKZ2z8xjm
	/P3MJvx+WOW7sd4TEcgg5X1LiziuA1+i9pJCt2YV9QTdgCLzjY+yX/tc7QeGjz/eGUVSNIleSpQ
	JLHHoOinnfjpLvvXH7i9zU4=
X-Google-Smtp-Source: AGHT+IEX+lpB3p/B6oVhbjWQfcMmUPju5uXSzPeZS+GPbKGC8rhAZNNq4QSwcwJ9Mp+m6tzIroAJ6w==
X-Received: by 2002:a17:902:f70f:b0:211:6b68:ae89 with SMTP id d9443c01a7336-21501e6800cmr71214965ad.54.1732748540655;
        Wed, 27 Nov 2024 15:02:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f455fsm913385ad.29.2024.11.27.15.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 15:02:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <65b412ef-fc57-4988-bf92-3c924a1c74a5@roeck-us.net>
Date: Wed, 27 Nov 2024 15:02:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 2/2] timekeeping: Always check for negative motion
To: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20241031115448.978498636@linutronix.de>
 <20241031120328.599430157@linutronix.de>
 <387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net>
 <CANDhNCo1RtcfqUJsuAQ+HdS7E29+gByfek5-4KYiAk3Njk4M3Q@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CANDhNCo1RtcfqUJsuAQ+HdS7E29+gByfek5-4KYiAk3Njk4M3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/27/24 14:08, John Stultz wrote:
> On Sun, Nov 24, 2024 at 4:48 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Thu, Oct 31, 2024 at 01:04:08PM +0100, Thomas Gleixner wrote:
>>> clocksource_delta() has two variants. One with a check for negative motion,
>>> which is only selected by x86. This is a historic leftover as this function
>>> was previously used in the time getter hot paths.
>>>
>>> Since 135225a363ae timekeeping_cycles_to_ns() has unconditional protection
>>> against this as a by-product of the protection against 64bit math overflow.
>>>
>>> clocksource_delta() is only used in the clocksource watchdog and in
>>> timekeeping_advance(). The extra conditional there is not hurting anyone.
>>>
>>> Remove the config option and unconditionally prevent negative motion of the
>>> readout.
>>>
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>
>> This patch causes the kuda-bmc qemu emulation to stall. Reverting it fixes
>> the problem.
>>
> 
> I'm not familiar with kuda-bmc and I'm not finding too many details
> searching on it.

Sorry, I keep misspelling it. kudo-bmc.

>>From other qemu bmc reults I'm guessing this is an arm32 architecture?
> 
Yes.

> Do you have any more details about where it's stalling?  Also dmesg
> details might help illuminate what clocksource was used, etc.
> I'm wondering if the clocksource mask value is incorrect for the
> clocksource being used here?
> 

An example log is at [1]. It says

clocksource: npcm7xx-timer1: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 597268854 ns
...
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
...
clocksource: Switched to clocksource npcm7xx-timer1

I don't know where exactly it stalls; sometime after handover to userspace.
I'll be happy to do some more debugging, but you'll nee to let me know what
to look for.

Thanks,
Guenter

---
[1] https://kerneltests.org/builders/qemu-arm-v7-master/builds/324/steps/qemubuildcommand/logs/stdio


