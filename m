Return-Path: <linux-kernel+bounces-236561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1E91E40A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367E51C21FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB8F16C86A;
	Mon,  1 Jul 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQXf8LLr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D053AC;
	Mon,  1 Jul 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847620; cv=none; b=c9mO+33bEJsJbBYvP9h1fCZOydKrvlr5hhl4qJ6qv3qrB109R3tPHvbRsQ53q3a22Ai+DH6itLQf7PM42hHLQGTcJi9yAtDm/0jwc5F+s54VpK57lOsA87mDeL4kAdLkHefknE8N8WfSlGWDsVEM5gJy1wslubkd+hcE421GCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847620; c=relaxed/simple;
	bh=KtXOPm/i2yuQzyiBo0fp7XdnvGDCkRLiwmErDik+X3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePe9zXfWCfqNcKt8ZUp7OQnTjeWkfRpXKBHrm8fkcI9xw62vBn8+r3GBC1+PLna872iiXU7j98Gwb3M+CeMb6YHtGgHyOMU+d6Jlj1uPeEiSZ4Xjlrdbnk7Fa01kpyWpeALEQNIbOBK6D/AQ6mTHmCggFUGTQQbT1/l8/bvGelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQXf8LLr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9aa039327so17145805ad.2;
        Mon, 01 Jul 2024 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847619; x=1720452419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv8mup9HOP0X5v8KDGkf/qgCExBcYwbzSTDh1mlcbGE=;
        b=AQXf8LLrT0S7RqZLQz6/z42nQA84ZOjAu1QduNR/Uhomw9gSWtZvKM9Ym6CbCcnGZI
         5rrVL9yQ+XxKCyj5TtFDqxJuZ7QsDu0MhZqKWjKCgQ30C9OLM87mABMruhwWnqeWXafp
         jvvo8LcXdkfNBaolV4pXG8lZSt3fZswgfRrX/fAazMVedYwitq2cfBNBs5sZwupHo3Xp
         qx/SzIe26FwpFBGI/luZ3zpG0uIqdupV/gY1dj9be4koT4V3hbuD7pkEDvP8H7agEvEt
         w1fp/WpMb/X3/o6gZvWzBf41mdsEKbBT2YulzL5rTPnTqDvt8MLRHMqXG6T2xVnDYOke
         PGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847619; x=1720452419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv8mup9HOP0X5v8KDGkf/qgCExBcYwbzSTDh1mlcbGE=;
        b=PQzMVGQKC4yKguLaTNWzbPLViZU6ZX24/UQY/NFynILdoe3ZwKYTk+XSGfgpTCmWuf
         hztz1LDGnrr8ec/PcPpVYmWpVwZPNKoJI6HX6ZFGBUuhzpcirhdVLHMmT6XBmJ0IpN72
         72EMQOhvJdGNrpvkpcxi+BE+BBkhwmh0u5aoh4awSD3GwYUTure5IUW9sETHSf3G+Dkq
         rPOKggrGSqy+5FmUdxaLSKn810lHk7N7ZQSjqI0gnsnKuh2LCEiF2eODB7ICd9L9fjZx
         giWK/TMcWppgvBXg111pygM2CTITW5b8VbRchz91pGts7VF5hiaiomsRAJApGj6tG/TS
         4Gsg==
X-Forwarded-Encrypted: i=1; AJvYcCXwrS+WUDdU7fBhWiAaSz5j7FSdO7HefzEyzbK8n9tXZgkz36CLza9DdLXgqdJEARSrFUigsRGia5I0yHoUugHcVqf/57owiW3JKNo=
X-Gm-Message-State: AOJu0YwjdlBD/htjJHzme8QegznoFYc57bxySmaCRRjwo77OL7w5EBgI
	GTAvDd9tGsAicQYQKptlTROXolR97ra5OMLjpVc9iU5huBdtk8hlGXCJgg==
X-Google-Smtp-Source: AGHT+IHIpW6yRSBP2MQ45Cf2y3ABpIAyCjShEl7BuZVTF3uM2EsCQ87kdPzMk8Fv4u7PFm9Zk24l1g==
X-Received: by 2002:a17:902:c94b:b0:1f9:cf2f:507c with SMTP id d9443c01a7336-1fadbcb4858mr36324725ad.41.1719847618636;
        Mon, 01 Jul 2024 08:26:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a87sm66511385ad.94.2024.07.01.08.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 08:26:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <31eb2d27-fd00-4284-93f8-23504e14b47f@roeck-us.net>
Date: Mon, 1 Jul 2024 08:26:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] hwmon: (amc6821) Add support for fan1_target and
 pwm1_enable mode 4
To: Quentin Schulz <quentin.schulz@cherry.de>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-5-linux@roeck-us.net>
 <e1933ae1-af38-4c17-b36e-33d43e90f057@cherry.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e1933ae1-af38-4c17-b36e-33d43e90f057@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Quentin,

On 7/1/24 04:23, Quentin Schulz wrote:
> Hi Guenter,
> 
> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>> After setting fan1_target and setting pwm1_enable to 4,
>> the fan controller tries to achieve the requested fan speed.
>>
> 
> There's something in the docs (section `Software-RPM Control Mode (Fan Speed Regulator`) that rubs me the wrong way though.
> 
> """
> When the TACH-MODE bit (bit 1 of
> 0x02) is cleared ('0'), the duty cycle of PWM-Out is forced to 30% when the calculated desired value of duty
> cycle is less than 30%. Therefore, the TACH setting must be not greater than the value corresponding to the
> RPM for 30% duty cycle.
> """
> 

It turns out that the tach-mode bit is in reality the DC vs. pwm selector,
and defaults to DC. For pwm fans (4-bit fans), the bit should be set to 1.
That means that pwm1_mode should be supported to set the mode. I'll add a patch
for that.

> TACH-MODE is never modified in the driver, so its default value prevails: 0.
> 
> I'm wondering if there isn't something we need to do to make sure we're not under those 30% for TACH-Low-Limit/TACH-High-Limit/TACH-SETTING? Forbid the user to write (or clamp instead) <30% duty cycle. Forbid the user to select mode 4 if current values are <30% duty cycle, or update them to be >=30%?
> 

It also says that the "the selected target speed must not be too low
to operate the fan", which makes sense. It also says that the requested
fan speed should not be below the speed translating to 30% duty cycle.
However, that is not a fixed value; it depends on the fan. Some fans may
operate at 500 rpm with a duty cycle of 30%, others at 3,000 rpm.
Looking at Figure 26, I don't think the value written into the pwm
register makes any difference in Software-RPM control mode.

With that in mind, the only thing we could do is to ensure that the
requested fan speed is within the configured low and high limits,
or in other words require the user to set the limits before writing
the target fan speed. That is a bit circular, though - the user
could still write the target speed and _then_ update the limits
to a value outside the requested limit. The best we could do would be
to sanitize settings when the mode is set to 4 and any of the limits
is changed, and return an error if an obviously wrong limit or target
speed is requested (target speed outside limit, or low limit >= high
limit). Do you think that would be worth the effort ?

Thanks,
Guenter


