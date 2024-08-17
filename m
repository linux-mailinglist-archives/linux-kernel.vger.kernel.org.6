Return-Path: <linux-kernel+bounces-290525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95091955540
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C991F23242
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 03:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DF477113;
	Sat, 17 Aug 2024 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffa7ra+t"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F327453;
	Sat, 17 Aug 2024 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723865685; cv=none; b=XbDzVnB7xUjPK/KV/EAjECg/rcj3zWMHcewMYcCOeXxgKDhenaQmasWANq8d/H9QH2/blmnehzfCcapFsbxWd1GNemhwu6MdlmE2ZSwFE72FEwUYf12Rcb2xCr62KQ+PHKxTEPxMupSiqpCmdQmUSip1nodMoig3hTMPAz1AtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723865685; c=relaxed/simple;
	bh=rH+vGccZOxE3ViU68RmvIkrc+o5g48WSyrGQ4Wtd/a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/MXf1Ysd6dPFOkOakZ4V6HkpvmWqL11bzksKpbmwSCcVnspsnKdGKdYNU84eYYi9DoJCFhm78Ni1K6uCfgMzxWILkcO9bHqx8HQz72OumWV7S34Ps2XCctuR9grd3WnQen9r6PuqNJ62JckFao07ETGSM2l3/sDcdiOC5rjM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ffa7ra+t; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-202089e57d8so7840225ad.0;
        Fri, 16 Aug 2024 20:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723865683; x=1724470483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7rLOe0f8iaGryjTw++WbOV8+bU3eLgQz8fTHjSJRoIk=;
        b=Ffa7ra+tvsc6Q1jd+0gOePO8d0vu6TFj4Ea/Bzd/q/jsgK7CHy7H5fJp++ZgvnXZcl
         RkN2mkE9zImWlmtIvWnr6f768KygQKkKkx1qgKDdaeMalTxPmBwQ2RxM/sUKYj8DisGv
         T14Cp54xzK2O2EvaVZSJ0xf3F2ODIQELPVzsTRIsvgg4D3t5AqHt6nwM2APpciZ7x8Fw
         EFWq5JOILCicWwrEhLqIymv4EfUQToLU2njXHXuoy7txjgzQUhFomtIr3gPow6krE7Qa
         SAZAPBGtLrjDpAqG+BUdS0uXO7iJvkqPjacAkrSVkEGmPoO6o124a7D98nPS7YKljRVG
         +k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723865683; x=1724470483;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rLOe0f8iaGryjTw++WbOV8+bU3eLgQz8fTHjSJRoIk=;
        b=WL579OdbtxFOdp1N8y83VYavYm2XwyDrCwdzNXSN3sFP+E1gMVnmy2SKpDFipZtfJ+
         64z1L7frwBLX0XFad5oqKh/D15hIMmM0SVoSZN8woTXSIxsCzr3kgOzH9MP+XTYxJVCP
         mKlnlXLcGNc0wuTz0Aw6kO2/p10xiCoTW1VvFuBhcnV53FxkgorOxdvqOZnQBPbarQI9
         xmB5TwyNrF3U9b+eXBYpuDMpr6Pi63PB04Zg9u8hN1zXDOHkot+1BwMIcjMx978awJAU
         lr9e5uOrf36Y5K9U4y5Vg3vIDqWmgF/31JstffiDOvuv75kijZh32Vbn2qrwHFRBl+sR
         JklA==
X-Forwarded-Encrypted: i=1; AJvYcCUxDCujqgqZyVJ4txNl+V8LQSnv6WrsibXdyJmp+rpZs3O92Z88EOUbsqKYGI0lYvxpStBjBHOy3MsIriRMOyJepvMysedpI9KUm+BXJbXm4Ffa3UiHjpKgj+Q0jIaS/49Zus4+pLoL4gYH304aTvU9KcoTDOpSk35mdcY2bk5d4tvsJpHj
X-Gm-Message-State: AOJu0Yz3qljc9aXh1v92mM/T+0+YxE317IQkEUw3M0XM442nuQvnzgpN
	gL9UKydeAg/s+lIV9i8MbHbNW31CUUGZpg9IjXXb8B94hkR/mc1U
X-Google-Smtp-Source: AGHT+IGtPw6FtTJSwCAUSUCEjgqQtsYbJHAs4AT6qjJzR9g/9V1wCcsa+wmXg10vaWbryY/Ay+zR7Q==
X-Received: by 2002:a17:902:e74e:b0:1fe:d72d:13e1 with SMTP id d9443c01a7336-202062c33d3mr77321155ad.30.1723865682456;
        Fri, 16 Aug 2024 20:34:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f039e06bsm31933955ad.241.2024.08.16.20.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 20:34:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <05f75fda-d61f-45c7-9b21-85cbbae754a3@roeck-us.net>
Date: Fri, 16 Aug 2024 20:34:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt to
 yaml
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev
References: <20240814181727.4030958-1-Frank.Li@nxp.com>
 <20240816215555.GA2302157-robh@kernel.org>
 <71d341e0-d988-41a9-bf61-c691537749fc@roeck-us.net>
 <ZsAEj1k9liVfZgjp@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZsAEj1k9liVfZgjp@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 19:01, Frank Li wrote:
> On Fri, Aug 16, 2024 at 05:03:16PM -0700, Guenter Roeck wrote:
>> On 8/16/24 14:55, Rob Herring wrote:
>>> On Wed, Aug 14, 2024 at 02:17:26PM -0400, Frank Li wrote:
>>>> Convert binding doc ltc2978.txt to yaml format.
>>>> Additional change:
>>>> - add i2c node.
>>>> - basic it is regulator according to example, move it under regulator.
>>>>
>>>> Fix below warning:
>>>> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
>>>> 	failed to match any schema with compatible: ['lltc,ltc3882']
>>>>
>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>> ---
>>>>    .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
>>>>    .../bindings/regulator/lltc,ltc2972.yaml      | 94 +++++++++++++++++++
>>>>    2 files changed, 94 insertions(+), 62 deletions(-)
>>>>    delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
>>>>    create mode 100644 Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
>>>
>>> I'm on the fence whether to move this...
>>>
>>
>> I don't really understand the rationale behind the move nor the rationale behind
>> the rename, but then I don't really care or mind as long as no one claims that
>> the _driver_ should be moved because the devicetree bindings moved.
> 
> Conor suggest use one of compatible string as file name.
> 
> I just help convert it. I am not familar with this chip at all.
> 
> According to original docuemnt, most talk about regular instead of hwmon.
> 
> If you want to keep it under hwmon, I am fine.
> 

Do whatever you want; I won't object. After all, it will be one less file
in the scope of my responsibilities.

I would kindly suggest, though, that it might not be the best idea to list
a hardware monitoring maintainer as maintainer of devicetree property
definitions associated with the regulator subsystem. You might at least
want to make sure that Jean is ok with being listed as maintainer of
this file.

Thanks,
Guenter


