Return-Path: <linux-kernel+bounces-421255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45E9D88B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42C1B45857
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6C21B3920;
	Mon, 25 Nov 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDYJEQns"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31714287;
	Mon, 25 Nov 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547000; cv=none; b=ihp2YsU7uOuX5zD4ibAgSr1jp76M0W64vGc8XA2CCx4EqftUWzbkzc4tARjpeoCDCavIhx7qs7BYTLZEGfKcTxPRW2QWwayZXfYYxqqBDQtPCrNK5XziXxmMjU9xbNflooo6HwRiWtGv207CfuOKJXdAd6qwCOPYTeWFHIOaDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547000; c=relaxed/simple;
	bh=nzjB10c5MFrIbMQ5fSsvjDa9SRCVALQn1pK8pn1stnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zzbyp5qfzfCCbJ7NRgo58rmJMVs3LMCxGhXwtRPBB3A/A4biEK6U3XcZ4dya8ekQVn+xn233silh6bH0C7pLwuTiNFu0B7iBIDrDLRgjabgkMEtzDsAzh3R58DNI6ZYQqJbbTyQQX0Vw9mlJg8oL70vCNJnubg+m5eJuglIcmK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDYJEQns; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7250906bc63so918969b3a.1;
        Mon, 25 Nov 2024 07:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732546998; x=1733151798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yfg/DccKnxi61QfwM43XV0/+/kR1JqIwdzMjek81aDI=;
        b=HDYJEQns1f0UePAOK5OuKTZivCM8UUbGwo6rEoC8V8arMTi1id1/ouaCTiXNj5w/mX
         EadrfYhdBaOHPo7wT+dd1g1Ij4Tb4qlS1DZ3s4icoCxAfJ7eImFzBAoOumQP1r2Ij1ek
         0wyGdf6eExfDHjnprbwU7vUdYx+S4bCB/XZdZLTbhJlJ7rBaS90rMagVsEiNtuvtAKs+
         VqV3oZafCd/pHKo22fYNn4AXUiiKCDBkRO8sjCgWxEDTkct/T4SHcxE5nczrCvrGffTt
         yXZJzaruERzRwTOhjUucvlzE/hADws6pcRZVk5nJU6b2LL4FVhfguCdfOTyzlgivFOpT
         mMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546998; x=1733151798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yfg/DccKnxi61QfwM43XV0/+/kR1JqIwdzMjek81aDI=;
        b=cDmtOWm2lKq+GXJNqN0wbS+EmS7+AQb/aJ94pIYlEdxRlmUwlpAQfhhIN2pX4OsKM3
         Wkhwt86lgbrsKR0gypY3G/yhsViecB0rkRdW/lCnCHpZYMlQ822NMQnlFre1X+UJMlUS
         R4P0slafGhy6OPPwX3e1ComBxhqnk6AYFKWZPbIAW7kTnDV963YyKX/awghk24vGdD9b
         +wn5DS3CVP3EErK2U5DskUh1WBPM8svbah9YfHQG5AAlR00s0I+QSRMDqiyzIfkgcGUd
         tMuUDXKWm7s0YVj+59j0DWUZ9ROStiJJN/cpqJHgPc4TSqFO0G2SlkbEXNfDJQCyLNPq
         RdVA==
X-Forwarded-Encrypted: i=1; AJvYcCWHNwPPwJwHVvm5RmNlTmB75ej1zKEapnXdF8equQblMRvQKxGDki3TfhcQH5HjdnLMKB7CXKxKaFwephIU@vger.kernel.org, AJvYcCX3ZZpElE20Pg+SuC8Dk/MxMcctaa/XsFSnK8+FZK0MCnR5MhW0cY/ljk8p+YAmHb8D0epWaFeJHwKM@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTuCeo1Ny2WFEeZbX6IF4FI96bP971EZaVutZGfla/A2ZyohE
	r+K9iX9UJSmsghy6gep2+KzNLGqTcY8QdUzbqpki0O2euhdu4GPW
X-Gm-Gg: ASbGncvL1siTNYHAq1ygOrEuTQOEwz0uqi9VtoUTgWZIZlIFmg6LdKR8DdGh6QF95rH
	9GVDbWIMxYXNHqNNsqIMLCpxAlHZKEHUFKvpcTH7UwGo97zjijtTjvSidJ2UH3w9qqhf0LWpqmW
	QaUpZ5uS8BXDqq6KDv4BnPjQ7VoxvKSBlZx62CgW7cGzn9ug1puUWcwD0pMuxh9Rv6V4kDFGHGL
	T+wRpM5FmfriYysZCzqZAB4ovmlb/Zpkj7hOSPwuJLBJKBvtYrMPVCT7pENXT5ESeay
X-Google-Smtp-Source: AGHT+IHjE12H/V8uAi6iwwQjPB/2bgurIjFDNLyLcSpLqK6GVZz5bJq2Vpx8P1om4SM6YiL6JRFESg==
X-Received: by 2002:a05:6a00:b45:b0:724:db17:f975 with SMTP id d2e1a72fcca58-724de984d1bmr23000668b3a.12.1732546997897;
        Mon, 25 Nov 2024 07:03:17 -0800 (PST)
Received: from [192.168.0.115] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454aacsm6498521b3a.11.2024.11.25.07.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:03:17 -0800 (PST)
Message-ID: <3a6fb7fd-eb3d-428b-a37c-f04d81e7fbd0@gmail.com>
Date: Mon, 25 Nov 2024 23:03:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] gpu: drm: adp: Add a backlight driver for the Summit
 LCD
To: Krzysztof Kozlowski <krzk@kernel.org>, fnkl.kernel@gmail.com,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-3-3191d8e6e49a@gmail.com>
 <f2181c71-db23-4d94-9afb-cb8f2fc46bea@kernel.org>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <f2181c71-db23-4d94-9afb-cb8f2fc46bea@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Krzysztof Kozlowski 於 2024/11/25 晚上10:49 寫道:
> On 24/11/2024 23:29, Sasha Finkelstein via B4 Relay wrote:
>> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>>
>> This is the display panel used for the touchbar on laptops that have it.
> 
> 
> ...
> 
> 
>> +static int summit_probe(struct mipi_dsi_device *dsi)
>> +{
>> +	struct backlight_properties props = { 0 };
>> +	struct device *dev = &dsi->dev;
>> +	struct summit_data *panel;
>> +
>> +	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
>> +	if (!panel)
>> +		return -ENOMEM;
>> +
>> +	mipi_dsi_set_drvdata(dsi, panel);
>> +	panel->dsi = dsi;
>> +
>> +	int ret = device_property_read_u32(dev, "max-brightness", &props.max_brightness);
> That's an undocumented property, which suggests you did not test your DTS.

Actually, testing the DTS would not have caught this issue. For more
context,
all summit panels found in touch bar have a max brightness of 255, but the
summit panel in Apple A11 devices like the iPhone X is latter found to have
a max brightness of 2047.

However, A11 cannot be properly supported right now due to not having a
driver
for the DART IOMMU.

In the meantime, max-brightness could documented and be made required,
and the
default 255 brightness could be removed.

> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> 
> Best regards,
> Krzysztof

Nick Chan

