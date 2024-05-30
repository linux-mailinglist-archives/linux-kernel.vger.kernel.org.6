Return-Path: <linux-kernel+bounces-195738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6938D511A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9A41F22E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E049E47796;
	Thu, 30 May 2024 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B78bPN2E"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244218757F;
	Thu, 30 May 2024 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090608; cv=none; b=J0WkiycIlc2L6DdB4/XKOXWwx+ktqS6OMTU9NdT1Y0WtT348mQefiR0uhgHc6LaqI1hgyNDjodXIczpSpvae/WPZlYaty4taU1fV5b3IkjqOh9JXOJm+pzw3dwS3sH1UZawocnHyd30KZNsYYs3svYD2IHrb0RfmGPkJ/bXNpMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090608; c=relaxed/simple;
	bh=CuX/2pe9cApqXm2bXTN+MVTVzW69PBsZLZPGpMZ03mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diqUjvsFimKf+Zz/vA+5dBzT11DN4ftHSMpUCCS5EwwK5PqHm6mzcsUn8LtXf5co9fGwd8DlJPLHhdw8+Ppx2qw6CBbO5lP4eBzc0O6ta/tpRSLji7QGDJJyZjkpmxPe7IQ4ABipw7B+zFIWR6z6EO7j6nDZROCUGbLzMV4IHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B78bPN2E; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bfff08fc29so942204a91.1;
        Thu, 30 May 2024 10:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717090606; x=1717695406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+/FMefgpt3TfnKLLfewARfo5DV/oEmmnytLZ55pc/RM=;
        b=B78bPN2EpJxVfu9mqfoHiH72oyRIBQj9xaribZ+ONRishNCupTld/CHtH6pbbJBD2w
         rfao1BomEI1No/tzr9RyOxdNfBBl79ufVfsj9IYcQZDb6qTI9d8Ad0lIue/uVdkWOXSy
         8rse7YfZHNrUeGkraGb6JIv4QviX/KYU0VgZeX1TY6FR8r6bE7OVJ0B9FouC2pZMQlK5
         lv2oPHblh7l+95cUgi+ykQw+Z/u1L5NzXM8/tHfaYzwyC4Gt7xEqb/u7fQvnqN5FRsOa
         gwHdplLsyPvEv+UtoZK/XeTsxztaZKYM6ZozP/o/JahXemwUKxQSSXCgAQWRZvwOQPVs
         +tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717090606; x=1717695406;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/FMefgpt3TfnKLLfewARfo5DV/oEmmnytLZ55pc/RM=;
        b=Q824la1UMJEeD6cx3U5e52WCWrZHFx5Nax2wdgyQnu9yCRiO/soF5EVjRPW1/C507D
         y4gHFeXCWuHi/ldeXFynGFZJNSAef8E0Tektj0sr/iOBzTeJ2mP2nNUkIRM75Satpryh
         mFLzYFXN2VJ3DUTUX0utqgmvuLIchzrunhpgMISQpFiziwboAXpFKPQX93Z4fCwU4rOZ
         39jO6anolTUQdb804CQoR2k0MibKOImL6sdHm11oDtEzwbpmRV3hDNpkCyIm82o2X9LJ
         MlBkvmgP9YLaSkAlfniuQrXSc+dxNTJypWzRk6HwF10EM+AujUWhOnCc7kfzJ2AyTrdz
         QuDg==
X-Forwarded-Encrypted: i=1; AJvYcCWfs3KAW28h/edrJzU6BSwS/jH+fH41F29UAIjVACtnLK17AeQXu9O2NjBHbB2XlukFDrGtIxbuy3GmlkrLlA4VlkdJk1F8n91KcGejGZ7NJBvvi6WwIGImy8v1OVTW4M2t1UEbP7q04N9KBbAN6JrSwrOYfPNhyZa+iZuphjeNJjcT4Ru5
X-Gm-Message-State: AOJu0Ywvd6HtSPggkC8Kvo1oqLCrfenIQ8ImlBH4NxD8lkWRRpeA6avC
	uSPhQMe4Wq3Yl/0OKBNMh/oGMeAUy18WcEw1e1px0umOugYf1VVX
X-Google-Smtp-Source: AGHT+IEcXZTirNtSqz6/4ItK2+CQVcicOieBc01XxfrGxwvX5ArAu7zFmCdxD5LyIhVavsW8h/ElBw==
X-Received: by 2002:a17:90a:ad6:b0:2bf:dcba:a3c1 with SMTP id 98e67ed59e1d1-2c1abc3e316mr3493160a91.34.1717090605862;
        Thu, 30 May 2024 10:36:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a777f7d8sm1788193a91.31.2024.05.30.10.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 10:36:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <be9a987d-9fca-4ef9-be58-58d7b4d8f26d@roeck-us.net>
Date: Thu, 30 May 2024 10:36:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactcode.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <6f1ffb83-a64f-469d-b981-f0da0d2f02ac@gmx.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <6f1ffb83-a64f-469d-b981-f0da0d2f02ac@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 10:03, Armin Wolf wrote:
[ ... ]
>> +
>> +
>> +PEC configuration
>> +-----------------
>> +
>> +If the I2C/SMBus controller supports PEC, it can be enabled or disabled using
>> +the 'pec' sysfs attribute attached to the i2c device.
>> +
> 
> Hi,
> 
> the spd5118 only supports PEC when in i3c basic mode, so afaik we cannot use PEC here.
> 

Thanks for noticing. I misread the spec and associated the note with PAR_DIS,
not PEC_EN. I'll drop this and the PEC patch. Good that I kept it separate.

Thanks,
Guenter


