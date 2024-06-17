Return-Path: <linux-kernel+bounces-218429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A987290BFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AD11C20C27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394C5199248;
	Mon, 17 Jun 2024 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK6UbVK3"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193A18F2EF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718666138; cv=none; b=jov7EkII6x5i8D8AxpqBMi/nNkxAL4DyQlrf1W8vxo4+sP4KwIIIUQBzaLPr6JzET3jkhoys1jxjE6ICo1+fh9V80IRhygensDfuVRtwQhAdYFPUKD6WJizKKEp0nRjzAl0GxFTYhhiOsWe35sKgM0POhJX9zaDrvpjqzoR4Nc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718666138; c=relaxed/simple;
	bh=mrGr+jfPgxylV03HLSIrXjXxXgwjYyM4ZcbNZomXQJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9xx6J0KiMcx21/yZgOrkgbEypjhalVhQyoS+X87/NVsKlePFA35DCnCEepqAEclP6msx+RF/9NAFYojVSFNYEc/aKtzuSyr1ZxZQRTxqG+H0ncYE3LEdsDWcWojTtaLUaFMyrpNDrT9ihTVdXK0C/Vp/IVR+OYCsLx4OhPoxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK6UbVK3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f992388bbbso1531545ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718666136; x=1719270936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=k4AtK2TaCd2yS/HExYpuzuNz6kVGHHqcRp/1PNeJkUo=;
        b=XK6UbVK3BpEBS8vRZ7N6XvsMp9XlnUPo9/3AQlx0erIifzFmxXjdOfvi1WkrSsXBWM
         h1/ptSMv4fwOjI4YcxDvrcJvhStCZ44jDL6Ww+fRly7Az6Ijd6mIAEZb5OtfxafK9PuJ
         5qHrbal3e0o/TfcBGmT8Lz4PixZRFbOsWX49QYk0Dl0Mi+xlWxnU+rZtfoXvsJEsLbk0
         GCP5ydsk4SIj7hCRZhunA2/Cx7g9YoMulkAxB/IoZrC+g0jWrJ0THw7ZCJ4TwIPJSFPJ
         Pn0JAr7o64oj54FXE9WMxjdjoKo+zbA6kESIOgAQLu6SYjAGT0KBm/AWddAumEhNbf+d
         Rd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718666136; x=1719270936;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4AtK2TaCd2yS/HExYpuzuNz6kVGHHqcRp/1PNeJkUo=;
        b=F+Ww7s/wzD415YQ5DAf1nvA8UgBX0fvgeNFntGMFu+trqO4296kNqbsLC02UXQRPP5
         rcBAb3lP8BtFyorKmqXN5N3mKvOxBO5c1H7xoraY56tYpjez2QNUsDjFaVwiZuA/ExNx
         Y5uGLEstgUO/NfVZSXqfyvuotXsZi+qF6O3fzeTyh2448oOGSuNZPvWA56zgxVPhPtgj
         XNx04h000GZgQNDYg7nJyUTWjEZMAVvDqUU79CHohk8U7nccu9JfLMeigg5bqydmxmiL
         g4eC/WrB9jNpoxaK7zs4qbN17kzqDmr3hQR6uUxwjaAJ1MxcMurFPeihRu1qiks7q3TL
         h9Og==
X-Forwarded-Encrypted: i=1; AJvYcCXk+P5NV94GZyfGI3eHGffHUZCx/h6MC5Yr3/+vBZ5hvccCX08w/WU6hIOsaS0LpZd8EPi+B98Re+QrGP06iFlWy6Q0tN9Ayi5VmzmN
X-Gm-Message-State: AOJu0Yw1Ql2HtSbGBcSPUN0c8JZ/U/NK8mS8jmBn8rsIHFRRXbljNwsT
	FmD1nK2vgNTMJcSBZWPxAy5V3vrvIsdcn+db1HSE7bW61ml1M3S7
X-Google-Smtp-Source: AGHT+IEEw6+nFjPNOmnXUwAqn8UsG6ecJSNvNMmEAcUqCdeLzsLy/zQ7wumgzJgRKkwyU57TVvYhZQ==
X-Received: by 2002:a17:902:ced1:b0:1f6:f047:d37d with SMTP id d9443c01a7336-1f8627d6520mr134842775ad.36.1718666135856;
        Mon, 17 Jun 2024 16:15:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f40947sm84028825ad.276.2024.06.17.16.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 16:15:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e6733f56-014e-4ea0-aaf8-059334f2b27f@roeck-us.net>
Date: Mon, 17 Jun 2024 16:15:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Page select register restrictions in regmap core
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
References: <e3e11724-794d-423e-9326-ffe8eed5119c@roeck-us.net>
 <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
 <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
 <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 15:47, Mark Brown wrote:
> On Mon, Jun 17, 2024 at 02:55:09PM -0700, Guenter Roeck wrote:
>> On 6/17/24 10:22, Mark Brown wrote:
> 
>>> The range is *entirely* defined within the driver, it is 100% a software
>>> construct, the hardware only influences our choice of range in that we
>>> can't place it on top of hardware registers.
> 
>> I _think_ what you are saying is that I'd have to model all registers
>> which are to be addressed through regmap as virtual registers with an offset
>> outside the range of real registers. Something like adding 0x100 to the
> 
> No, only registers that are accessed through a window need to be
> mapped into a range.  Any other registers can just be accessed.
> 
See below.

>> each register address and then accessing, say, the revision register
>> not as register 0x02 but as register 0x102. I would then define the matching
>> range from 0x100 .. 0x17f and the window from 0x00..0x7f.
> 
> That would make the range exactly the same size as the window so there'd
> be no paging going on and the registers could be accessed directly?  I
> guess that's another check that should be added...
> 

I tried to explain this before. The registers in address range 00..0x7f
are physical, but they are only accessible from page 0 with the exception
of the page select register. So, sure, the registers are not actually paged,
but page 0 must be selected to access them. That is the one and only reason
for specifying that first range and window. It ensures that page 0 is
selected when accessing the registers. If that wasn't the case, I could
define a single range for the actually paged addresses in the 0x80..0xff
window and be done with it.

>> Hmm, yes, I see that this should work. I don't think it is worth doing though
>> since I need to be able to access some registers outside regmap, and I'd have
>> to define two sets of addresses for all those registers. That would simplify
>> the code a bit but one would have to remember that register addresses through
>> regmap are different than register addresses when calling smbus functions
>> directly. I think we'll just stick with the current code and keep the paging
>> implementation in the driver.
> 
> Mixing regmap and non-regmap access to the same registers seems like a
> bad idea in general, you will have locking issues (especially around the
> paging).

The non-regmap access all happens in the probe function before regmap is
initialized. It is needed for basic chip identification, to prevent someone
from instantiating the driver on a random nvram/eeprom and messing it up
with attempts to write the page select register. I would not want to be
held responsible for someone with, say, DDR4 DIMMs force-instantiating
the spd5118 driver and then complaining about bricked DIMMs.

Thanks,
Guenter


