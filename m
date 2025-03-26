Return-Path: <linux-kernel+bounces-577161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D4DA7195A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C60717CB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B81F3BB2;
	Wed, 26 Mar 2025 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9msC/zI"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685C1F1913
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000298; cv=none; b=YglYRg2ruQP4VG7L6PWoOU4ChvG/HNkowkp5rr6a0pfqC/EYnGowvLMCvF0WtspZc6kk8g6gbIq0aFIxMws935dP/OA7pe0O7CTV2D48zMbtAZDkGdIXqFMR+Ggyvb/SrgcsKpV7HrKSbeoPzjcZW035NSLsCB/lSxw35CoBY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000298; c=relaxed/simple;
	bh=Ghh84CGkR/FCVSnBNgUctPE3F7pU59Z+NKgjxNQtNFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I++PO3fd6UoGEE2jheY6QtrBqtHh6GKrH9jAOYDAOaLyYV7cwI4WAK6BSdpFpJZYubIO/0ApMRZj6pleqWO81CShCNwWQ6z+hGvRjc6R/AuL9RlJrXS0+AD4U2+kXTxG2Tms+emWfGUCgZA+ssKp5M+nMwSjgVQr1jPY2PVuej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U9msC/zI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso36604915e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743000295; x=1743605095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REtKXp4hi6sgBm+AS7b2V8Aev3l8C+kzOBfn08oN45c=;
        b=U9msC/zIskuQNMsHcYGTDYInxitcUJA9R4/QZKz/+ihpsfVh+GEYzj6KnQkz5gbqqs
         6hwVdlAGgNnhprSdTSVHz6LxhYeNk+6I2zU1a14/NVmVB+1JHS0U0+rULSfl/HcMwgcx
         cF93zqKJYZwW9WwHH/j36G0Pq90OyCpYRJmq5nwnBU6QpgccaihPpzieCr8vZ2D/GH/k
         /QICkcCKDYkzKi7gnujGksr+w366pTqDkXUold4VWJiAmwxfdmcnNf3fmxVAG200P67W
         oEePc7huY88cDS/Sr8zv89/9cK9HzDUP7asAktnp3+fAvOSlvwL//6nfOGznua+Br/Ow
         GEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743000295; x=1743605095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REtKXp4hi6sgBm+AS7b2V8Aev3l8C+kzOBfn08oN45c=;
        b=wB0UYMdHCVkrBp0LUe6HUII98a7QGUwBxNjiTu82hHcgKRVbL8DduZZVxtFuvyHHrj
         6cZOEeUGo7T5RR9BoCy9cV5ks4mwZUKvmFUVLqmTGK/2/XxKeyPo6cPKFqOf1+TfCQVv
         k6fGQpjUccjJiMJCNfHX9VFPJ/4PGKIdeHXWlA2BZgzisqytUWFypj6trfEUsUN7dLGy
         MwrGfQY9X5wEqdDJUiesgOR0LCWR7zX/HAh9lLLlzGoWl3d7zEluWGh2R3QPcJE19ODv
         nNz0HYiBkYFsbbpIkUqx0A2gt3pREGYjn1yQj9n4tEP9Xo2agcXuBt7gDUEJsIdUg5HA
         FpLg==
X-Forwarded-Encrypted: i=1; AJvYcCXdTD0vSnEEX8rEQuPJz3sYii4Jy22t1w7PhZlq4esGpt7ZVg3QXM1q9BzH5JuoN5q0dlF3LKiliy86vww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV0tzYstdLZy0SwTWBPBN7EstOQAk21/6TpuZ80qqyUhJ5eM6S
	U+yT3dfPrb8ws6dEeeGkP/0A+aSO0zLM2P0Yf2pm5ySPSOLb7kXjJLBHhCUwiro=
X-Gm-Gg: ASbGncskmUeyonD61wjUmqAUKnPkNlg9iib2FU0UiWOGLQ2lz1R3OGs0ur3LEInETgQ
	3hrE1f0q8hDvDYDPjwUy7GHbvgNSwiYjJLW4YIPHFHIcRcWNBlbzHnxFb+9BV+rtLx41V1kB42b
	NvIQd11/ifH2QpD1uNB+SrPoqinXJY/KXMJjeDrZydTscNv8TxeEC08pYjPZjvuBjFY+1JJ1iNQ
	Engfb+164uY1IuFMpLw6RSGOcFYL1RqC8kPWjsvu2CkObFqU3pxjAMVJ9NXsrmLDR44h0qvcmsB
	mhjdog1Ydw8xsOIP2pVe+L57hKA6PRwTRMarWRd14wp869Y/25WKtJVwzodvsCN8fw==
X-Google-Smtp-Source: AGHT+IHDOuf6KYAidi0f/+wH2oPjsGxXXLqRAgkCOSMQfLCi0UZThvqs+OxaqR5hMnEF4EQhlhmaOQ==
X-Received: by 2002:a05:600c:45cf:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-43d508715e4mr191868365e9.0.1743000294919;
        Wed, 26 Mar 2025 07:44:54 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dedd03sm4190975e9.3.2025.03.26.07.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 07:44:54 -0700 (PDT)
Message-ID: <be8e5758-8f85-4476-b6c0-4400c8151cbe@linaro.org>
Date: Wed, 26 Mar 2025 14:44:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mtd: spi-nor: use rdid-dummy-ncycles DT property
To: Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Takahiro Kuwano <tkuw584924@gmail.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bacem Daassi <Bacem.Daassi@infineon.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Mark Brown <broonie@kernel.org>
References: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
 <20250319-snor-rdid-dummy-ncycles-v1-2-fbf64e4c226a@infineon.com>
 <20250319233024.GA2625856-robh@kernel.org>
 <a3818477-5a67-43ad-8961-88fa02916968@linaro.org>
 <CAL_JsqKtz5+R1kjEzjo6bVicOX2c=UauC0_STAF0T02rSDqO+w@mail.gmail.com>
 <50de19f7-2021-433e-b8f8-d928ed7d5d57@linaro.org>
 <D8LSAUU0358V.2H1D7QXB9WBOF@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <D8LSAUU0358V.2H1D7QXB9WBOF@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Michael,

Sorry, I somehow missed your replies.

On 3/21/25 8:00 AM, Michael Walle wrote:

cut

>>>> The
>>>> problem that I see with that is that we no longer bind against the
>>>> generic jedec,spi-nor compatible, so people need to update their DT in
>>>> case they use/plug-in a different flash on their board.
>>>
>>> This chip is clearly *not* compatible with a generic chip.
>>
>> I think it is compatible. The chip defines the SFDP (serial flash
>> discoverable parameters) tables. At probe time we parse those tables and
>> initialize the flash based on them.
> 
> I disagree. It's not compatible with "jedec,spi-nor", which is
> defined as
> 

cut

> 
> See my first reply, on how to possibly fix this mess (new
> compatible if accepted, just use RDSFDP sequence which is backed by
> the standard and do some fingerprinting).
>

this won't work unless there's a unique parameter or ID in the sfdp or
vendors tables, which I doubt. Takahiro to confirm.

> FWIW, a new (or rather different) compatible is needed because we
> cannot distinguish between random data returned during the dummy
> cycles and a proper manufacturer id. So there is no way we could fix
> this in the core itself.

Yes, I agree, new compatible it is then.

cut

>> I think the property vs compatible decision resumes at whether we
>> consider that the dummy cycles requirement for Read ID is/will be
>> generic or not.
> 
> It is not generic. Because it will break autodetection. And that is
> the whole purpose of this. Adding that property means, we can just
> autodetect flashes within this 'group'. And personally, I think this
> is a bad precedent.
> 

yes, I agree.

>> I noticed that with higher frequencies or protocol modes (e.g, octal
>> DTR), flashes tend to require more dummy cycles. I think with time,
>> we'll have more flashes with such requirement. Takahiro can jump in and
>> tell if it's already the case with IFX.
> 
> But hopefully not with RDID. Again this doesn't play nice with other
> flashes (or all flashes for now). Instead of adding random delay
> cycles one should rather define a max clock speed for this opcode.

This could work, yes. But not for this flash. Or maybe encourage vendors
to either contribute and enlarge the SFDP database or define their own
vendor tables for all the flash properties that are not covered yet.
It's strange how Block Protection is not yet covered by SFDP after all
these years.

Thanks,
ta

