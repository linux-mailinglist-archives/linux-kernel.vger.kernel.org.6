Return-Path: <linux-kernel+bounces-305401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A969962E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7181C21DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789191A4F39;
	Wed, 28 Aug 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeS5Prpk"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37E1A0B1B;
	Wed, 28 Aug 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864791; cv=none; b=Ak9OMaSfF93+NnZADzOTqQ11QezkfRt4HQBk1o0kJtQajm/HGP/vA8vu15C/4k+nN5uolZLtFcrCsaFnX2JXxYmszIFJ/lYkoECnqcZf9+AuMJmpzrVd/pgvc+sa23YGV7TSPmy0YXFsjJ3Z91MVVrN/L+xYdol5X5WXVEKQrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864791; c=relaxed/simple;
	bh=jURjNKStXWs2mHKbeWUwd2VF8RrqZ1h4iMwdaIyEwhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/tb+VZ5+E+AROktNwLyWBsFrORgGiFZZgd4wjgkTqD7TvNqleZ8LSOAXbTbd6Dh2HKLfroH7ZizaK+Y4tJ63rqs0leSpeHEP4jizCp/+E8s73Oj3i+nOXU29U8C3RQe9zfB61TNx2A9YHkveExDrc8tI3R6cMkIbAuNwhs9Iro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeS5Prpk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7141d7b270dso5356611b3a.2;
        Wed, 28 Aug 2024 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724864788; x=1725469588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mWwXKQv4RLPvt5ylzj8HbeQu7Eevm+FTVYxl5BPQnXY=;
        b=PeS5PrpkmPKSN9S23VieIWnvrgyL5L8ZtqpR7pTivLPIrXdAMuEgiqv8yIbOp0Txmc
         A4XJiBbJJ2oc/GhwjlMCx/SNcpT9/qbotrF/8YQNF8/8QKL4I27x+jmSu8JeSq1Jcfv6
         z/f0Aw3HlB7fRfeImuz34rMxocLVZ9GbglNhGLGcjGDfPfjf/N+apAUm6kFkglX77zp0
         wSfb1/CDV3vhNRhVTpc+T+3tRxT38wp+exvvEK6KwIqPqqFCrjk3bvZ103CO9GXTQYX3
         3BQDlhD6XYiKhMm4GHgZ3ID9EL3bicp9JH8036qkWXaOMq42pQf+roysO4t8PpPVNu4m
         0p+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724864788; x=1725469588;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWwXKQv4RLPvt5ylzj8HbeQu7Eevm+FTVYxl5BPQnXY=;
        b=C2FazcIH1J7VQU9XHJ9LWdaB2bGRQYd5Q4TB6/3fP3xIH9/R0A2eFDPjTcgzl2pAg8
         tIfjj9/BfJYiOf8QeS6jTeaJZEjJwfiA5OQTwS+sOvbfLHqJtVy9dWeq5Tvxymz1f3C6
         a2sZwIz7yKQ41R27tVizs3Ciiu4L8DbZsNC8Idq9zsGdl208VDr1pw86MONU2yZ2qEhK
         5jI8Gg2UAjjfz+A+3JI53EnJackVe+pjURvPLh30xMYUKoCTR4oBb/K2UP7NPpnOv452
         2ve7JsJsPbcIvR0tH1jncHa2uUnHc5YVhR0IlHywWFcnXYH6/w7dPQ5SuXap28n6Dn19
         Smcg==
X-Forwarded-Encrypted: i=1; AJvYcCUyPy8RDZPTeGDGidHbakjWVsGNzeivOuNddcjdeJuQEGnwbRdbrfSZaxjmcVxvpvuGVniE7kKJdCqX8Wo=@vger.kernel.org, AJvYcCW5cfGi+yFnNGtOOsEVMNhT/AtxcoFkBIo3p82vMWBWT/Du7ZEOWlKJypWM/lXs2kVnm2EPR+Ou+w/We1/G@vger.kernel.org, AJvYcCXVrYcdP/05eTuq+hxJ5pF3Maq60AbLmYipxDTueksO5n+8/afNyx7i3lVlsxYoEecep7P06BKLSBKZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHg9D0Uq4tVNcghOsKm9iaJPYZwpowsXpJ2hI2bT4jWv89dudo
	uLMM7JbUhYJLWz+S2DEpkZ84tdpyBA0rZ3l7lHepv2l6rtEvDTn8
X-Google-Smtp-Source: AGHT+IH0eUbABNLY8tlUI6E4avQTIqdldUFwa4EDeKM1jMHG6UKRY3WhLuumv8C/EVewh/BqI6adRg==
X-Received: by 2002:a05:6a00:84f:b0:706:284f:6a68 with SMTP id d2e1a72fcca58-715dfca51bbmr131208b3a.23.1724864788315;
        Wed, 28 Aug 2024 10:06:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0dfbsm10355017b3a.114.2024.08.28.10.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 10:06:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <54243e7d-2b54-4934-a530-173ac06180ef@roeck-us.net>
Date: Wed, 28 Aug 2024 10:06:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] dt-bindings: hwmon: Convert ltc2978.txt to yaml
To: Frank Li <Frank.Li@nxp.com>, robh@kernel.org
Cc: broonie@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, jdelvare@suse.com, krzk+dt@kernel.org,
 lgirdwood@gmail.com, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240828164133.1131959-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240828164133.1131959-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 09:41, Frank Li wrote:
> Convert binding doc ltc2978.txt to yaml format.
> Additional change:
> - add i2c node.
> - basic it is regulator according to example, move it under regulator.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
> 	failed to match any schema with compatible: ['lltc,ltc3882']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - keep under hwmon directory.
> Change from v2 to v3
> - put my name into maintainers.
> change from v1 to v2
> - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
> - update title to (from ltc2978 data sheet).
> octal, digital power-supply monitor, supervisor, sequencer, and margin controller.
> ---
>   .../bindings/hwmon/lltc,ltc2972.yaml          | 94 +++++++++++++++++++
>   .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------

I still fail to understand the rationale for renaming the file from ltc2978
to ltc2972. I can see that 2972 is currently the alphabetically first supported
chip, but that is, in my opinion, irrelevant, and it will change.

If/when support for LTC2971 is added to the file and to the driver, do you plan
to rename the file again ?

Thanks,
Guenter


