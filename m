Return-Path: <linux-kernel+bounces-199523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF008D8819
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C221F1C22485
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141113777A;
	Mon,  3 Jun 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEo76nAt"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEE228382
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436297; cv=none; b=UL/HwYBCSzumVISe9pLeGtYVBmbBsrscmqzZlP6ipE2nn3fsXcC3d8Jkhvz23GLos5o05xVkyiQj2QGe3FrIPp5hdnddWfUaxewlr6k5cFLO18Ylb+iqXy/0ZDkdEnYz4MYEQD8YjKkooSHihL7IBLCKsuL2xp2MmWB7sKRLSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436297; c=relaxed/simple;
	bh=8BJP6wyu7cJHhBMItSuv8X5MkjRC9zlid4p22cNJBkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ea2aw+hKLu1vxmGQG4fJhfcFdwUXCQQsL9d0e7cBfW8AYOHvjMPYWllw9zI9aCwnI9IwwdS3j0T/iEdSAGPKovLMpJHGdWr2e42sUvBV6JjuyvZH1uu80HVaCU9fdz0mNNlev8eP8cOez4pF5Y0TYx8armVhrZB2izpVrf67svM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEo76nAt; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b950aa47bso207725e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717436294; x=1718041094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBEfjR86TdnBxjS+moPVKdo+T1wx7C3/3jA0BVhEBVE=;
        b=kEo76nAtvuiJUGSCeXMlanvr+LOTe+CizXniKnzgzNbaoNeLehLYm5lljWczz76HSx
         O3t7he5siFThWYct2cym7bhdCVhR4iQRZ+e+CbyHvIJFNvTF9EnHFjBPW8138kBkjmg7
         Xu9taedHEEOsVJPcwE0U4mqj1A7Kt2eFR3HNxHyFkNwqlpb88iBfZiXiJ0QFnLO8HYak
         FDQ8p+KwdX97LtKV5mAzAOpbimsy8lHjDUEZPpjLnwErR5mR0gTki08dsXqYuLDWXMzZ
         a/cQvUOlA+FlQwYuzQMluuGT40UtnWIA2hoyFRm1pu4+NlMM0tlTq2cwTUg5mU6FuI3H
         u8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717436294; x=1718041094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBEfjR86TdnBxjS+moPVKdo+T1wx7C3/3jA0BVhEBVE=;
        b=qjcQUqN1vI11b2/KG3N2z89aYmnCSYq2Ov5rJDrADK9H+bVLutMwETTDRS1In7RBt6
         b1VpOvQZK3rrSz3y3/im/Rr04F6MpIfA6jESBE00MwHZHe+rxUR0pRILx0H2K0Cvonq7
         Xq8ccqjgKuxUsfXX4SZ2m73V90bAtaN0v9RhPwkfnWSTQ5kdIhkmOMok7drCNZanwyD4
         xyCNPO4+TK/TQ2cmu5b98FskccYgsYLhiWaRWhDPDJ9YBoEosyKEvHc1Bxwy2bD+YIhS
         ucD5WXr1uOfoxBtk1ubp0n5zeuiRfZSYwZ2LdnG3EAsJmYpwdRG90d4LJkKt6XUnsLRx
         lPUw==
X-Forwarded-Encrypted: i=1; AJvYcCXNiOI1TxA2dYKF/H4fiyQ6lKMSyHAKcWnhotf0RBQNQh3vxEIDELzVp/I3bk2ofEtCyMqDtNnaECWZVP0aoU3X1/JJssrW40jVHzqq
X-Gm-Message-State: AOJu0YxhbnGgCcnTR/rdTPDfR95glzllVU418O9tYsl+mPtjlYFx2LEp
	70B0wTo5u5bcir6N+6QQi7SZd4lv7pufsCwUn93OpL7ZTqYg8Ur8
X-Google-Smtp-Source: AGHT+IHflMR4WsmcobCtsczFB9jSB/1xgG+XHleDw6/vuglXZegD+m8KVNpbCLClR7h35sOgZyzy3A==
X-Received: by 2002:ac2:43a3:0:b0:52b:8419:db27 with SMTP id 2adb3069b0e04-52b896bdd52mr5080909e87.35.1717436293542;
        Mon, 03 Jun 2024 10:38:13 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d75d96sm1270910e87.120.2024.06.03.10.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 10:38:13 -0700 (PDT)
Message-ID: <aea82422-fb54-4d6e-be5c-ba0a0fa7e23c@gmail.com>
Date: Mon, 3 Jun 2024 20:38:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] irqdomain: Allow giving name suffix for domain
To: Thomas Gleixner <tglx@linutronix.de>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1716533790.git.mazziesaccount@gmail.com>
 <2ea1749587d9e5a74a80a8eee7caf58c3e954a6e.1716533790.git.mazziesaccount@gmail.com>
 <87h6ea72f9.ffs@tglx> <77c64d75-43fa-47bf-bb3a-e0e49d51189d@gmail.com>
 <8734pu6ky8.ffs@tglx>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <8734pu6ky8.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 19:38, Thomas Gleixner wrote:
> Matti!
> 
> On Mon, Jun 03 2024 at 15:19, Matti Vaittinen wrote:
>> On 6/3/24 13:20, Thomas Gleixner wrote:
>>> On Fri, May 24 2024 at 11:18, Matti Vaittinen wrote:
>>> Now you start talking about parent interrupts. Can you please make your
>>> mind up and concisely explain what this is about?
>>
>> I hope I can explain what I am after here. I am also very happy when
>> incorrect terminology is pointed out! So, it'd be great to know if I
>> should use 'parent' or 'physical IRQ' here after I explain this further.
>>
>> What I am dealing with is an I2C device (PMIC) which provides two GPIO
>> IRQ lines for SOC. This is what I meant by "physical IRQs".
>>
>> ----------------	INTB IRQ	-----------------
>> |		|-----------------------|		|
>> |	PMIC	|			|    SOC	|
>> |		|-----------------------|		|
>> -----------------	ERRB IRQ	-----------------
>>
>>
>> Both the INTB and ERRB can report various events, and correct event can
>> be further read from the PMIC registers when IRQ line is asserted. I
>> think this is business as usual.
>>
>> I'd like to use the regmap_irq for representing these events as separate
>> 'IRQs' (which can be handled using handlers registered with
>> request_threaded_irq() as usual).
>>
>> Here, when talking about 'parent IRQ', I was referring to ERRB or INTB
>> as 'parent IRQ'. My thinking was that, the regmap IRQ instance uses INTB
>> or ERRB as it's parent IRQ, which it splits (demuxes) to separate "child
>> IRQs" for the rest of the PMIC drivers to use. I'd be grateful if better
>> terms were suggested so that readers can stay on same page with me.
>>
>> After talking with Mark:
>>
>> we both thought it'd be cleaner to have separate regmap IRQ instances
>> for the ERRB and INTB lines. This makes sense (to me) because a lot of
>> (almost all of?) the regmap IRQ internal data describe the IRQ line
>> related things like registers related to the IRQ line, IRQ line polarity
>> etc. Hence, making single regmap-IRQ instance to support more than one
>> <please, add what is the correct term for INTB / ERRB like line> would
>> require duplicating a plenty of the regmap data. This would make
>> registering an regmap-IRQ entity much more complex and additionally it'd
>> also complicate the internals of the regmap-IRQ. It'd be a bit like
>> trying to fill and drink a six-pack of lemonade at once, instead of
>> going a bottle by bottle :)
> 
> This makes a lot more sense now. So what I read out of this in change
> log style is:
> 
>    Devices can have subfunctions where each has its own interrupt
>    line. Each interrupt line acts as demultiplex interrupt for
>    subfunction specific interrupts and has its distinct set of registers.
> 
>    regmap can support such a setup, but the interrupt domain code ends up
>    to assign the same device name when creating the underlying per
>    subfunction interrupt domains. This causes name space collision in the
>    debugfs code and also leads to confusion in other places, e.g.
>    /proc/interrupts would show two distinct interrupts with the same
>    domain name and hardware interrupt number.
> 
>    Instead of working around this in the driver or the regmap code, allow
>    to provide a name suffix for the domain name when creating the
>    interrupt domains.
> 
>    Add the infrastructure to __irq_domain_add() and expose it via
>    irq_domain_create_linear_named() which is the only function required
>    by the regmap code to support such setups.
> 
> Did I get it halfways right?

I think you got it perfectly right. :) And, I really appreciate the 
extra mile you went when spelling it out in this way. I will send a new 
version where the legacy domain function is dropped, and the commit 
message will use what you wrote here  :)

Thanks a ton!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


