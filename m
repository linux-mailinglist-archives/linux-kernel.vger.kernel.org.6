Return-Path: <linux-kernel+bounces-540676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA19DA4B3A0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03381891AE1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569EE1EB199;
	Sun,  2 Mar 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWg+Jvgn"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2EF3398A;
	Sun,  2 Mar 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740934918; cv=none; b=Zn0pM7BL5LwbHmqC0esTjrjbt0cgBxDIHm6bzWaUdrs3Y2uGg8IFyY3KD0r+BJN+HcfpSo6hUxvs6i/G+claxXCGZaOfdiFUO1GPfo3qZfUUigYwx7ZmH27qHFYRShjO8I+q2Bwu0UGaHOLHXqqDZx8wQi0RQrQPaAc8gPXnzE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740934918; c=relaxed/simple;
	bh=YuQt2U/8QSb3sbWPURxzGthMIlRF+5nkqkiLbVHTEe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTIbymeGI+S/MS3P3NOf+HK1XCBpeaser7ahPhZ3+XFdfCKs14s3xvYya1Z6vT/+tUvB0BBKIEePXLtmVgyaTZ3prpL1B131KN5MTay3lcpye3rWEutPSfMatOWU1zbkDdySFCe+tqc2HiPleJx1E9/ecgfQnPrgHJtiI6gvbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWg+Jvgn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22113560c57so69922675ad.2;
        Sun, 02 Mar 2025 09:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740934916; x=1741539716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T0a7qhGwKEpW5bi2H1C+aMLGQoy8HE9wO8KfFD8wrf8=;
        b=EWg+JvgnBNdrrxrLPirlXt0692Wl8tvtxHWsUZmm868ZnJkOwNBE8S46Gj42knDXVh
         Du8pcNPOrf6x5MARR5MOOP7F8eUQfAPrHk5XoZ9W7zwihVHIrPobEXbvBGPDtCFBlTU1
         LrKiCObNpXpUrLvKxI2sJGPGO1NNAXyFHX5DTYQiV1Xq6ShSf2x5bzBdm7NRebYhTKg/
         a9fIYwYsN0pVyLUTvvyA0oAKe9p8IbkRZOBP9Jc15CQqOzsxX8tmpKgiIqSM/JF5JfPk
         3NUJEfQy3l9ZkQ2IoHYm3D3yY9x7TMxZGb01jzw2uqiGHH0zq7YZsU3F66Vxq4ab1thp
         oUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740934916; x=1741539716;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0a7qhGwKEpW5bi2H1C+aMLGQoy8HE9wO8KfFD8wrf8=;
        b=JcH5btBdi9eRaL10qTYJWtfYy7IYxQPcFTGfuWRe3QzkzywOKqqISY89FNOfQvtfjk
         hOuGaORIZ2bedep3aAyIA3/4TGrXXBHSDXytdMghAf/SMd396kxLDFNKN1hw7x8Fe1fe
         lncQjruPGdSEjUpRcWWESG68lAnLi1YwsE1cCgku7I54E9Qr47FJqtJgOiOn0Z/Fdsib
         M86S8Np+BgbG7PUhzUQFtecnfQavAaxuadOPOWVs4J/JEApObZ/pZXMicD2DRHFOfJnI
         6sguSgycDT6/9s7enFtpKlWzCpSyWHvJelOrAEgLvn05ItvtwaFWqrxVGUEXYoCB7JWm
         z8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCULcKYjtbCb4nI5hHtSGFxp20+dLHQMK1hhy5Gcn5o8nuWf0vTMSAChZCExqBeRm5rTZnEnckrZdxdS@vger.kernel.org, AJvYcCULwXuF224zj24azM27TnM8thlBHx/Te4Xqaknz2nEAoe9nYjkA+iSXIxz/OmMaNyXft9cr4Jat5eNRu1Ns@vger.kernel.org, AJvYcCV6LYwLAxKQQiXuuC9E9BQZoyKk6kSx1Sx6dXXma7nXBJzybXbXbir5dYaZyECEsa3IZmQJse5Is/Ohu5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzULxIDvSH5SDXdhMvK9XbJbBnMDzDht4SSdu6uC8QPqJP5r6es
	lF2hVHLOhdP4JEnZt3AXygSmd2dZ8noh5+zBRkrcXsSPexgbmWLy
X-Gm-Gg: ASbGncsw43jEKYjHdHy9NFhhHF9ycGR+qwWdfBtjsWpISRt7eGYjidkp4R7WmufcdJ0
	ugtvJ4NnExobwEEFvP6VOa1+AcWv+uS86OHct3x2acQYGmgMRuByidnXXpgL+CW78zBy6wfossU
	25/YjfLi3+sF9NNYRCVCrCRjB8w6cb59e3b6wCuNVn9oOynpJVtPfWpb2BJwCpzGyLibVVCSOQK
	Q8dZujYxTOU+HKHpTcuBmD+/Svucxj6zpV6Zcrq1BmtSxiLO8h97QTx5rt+550osKwf7inmIgHg
	1MZ0tDL3xa5Q6Xdd8XRbUOPbu06cgXrNCQsjgvg1i+krYYLSaWB2uKP6UQcVfo/3oTo40ft0zZo
	RfF9znMGfIpWfcPC7UQ==
X-Google-Smtp-Source: AGHT+IHgqlzA5i0nCrronM75XZWW2F87AKaN4vOdx1hjJ54U3yo7vLK7/agc3ospbHaT/h0nqv9wvg==
X-Received: by 2002:a17:903:2ca:b0:223:4998:a75e with SMTP id d9443c01a7336-22368f73c05mr158570295ad.3.1740934916518;
        Sun, 02 Mar 2025 09:01:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235051132asm62596885ad.221.2025.03.02.09.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 09:01:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b1133989-368a-4933-b326-43edbf179d5c@roeck-us.net>
Date: Sun, 2 Mar 2025 09:01:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hwmon: (gpio-fan) Add regulator support
To: Mark Brown <broonie@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250210145934.761280-1-alexander.stein@ew.tq-group.com>
 <20250210145934.761280-6-alexander.stein@ew.tq-group.com>
 <0c82f6dc-4f5b-4787-9e43-4990681ea6a2@sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <0c82f6dc-4f5b-4787-9e43-4990681ea6a2@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/10/25 07:26, Mark Brown wrote:
> On Mon, Feb 10, 2025 at 03:59:33PM +0100, Alexander Stein wrote:
> 
>> +	fan_data->supply = devm_regulator_get_optional(dev, "fan");
>> +	if (IS_ERR(fan_data->supply)) {
>> +		err = PTR_ERR(fan_data->supply);
> 
> Unless fans are expected to operate without power (which does seem
> unlikely) the supply should really be mandatory.

Agreed. devm_regulator_get() returns a dummy regulator of none is
configured in devicetree, so this should be fine. Worse,
regulator_get_optional() returns an error pointer if regulator
support is disabled, while devm_regulator_get() returns NULL.

Guenter


