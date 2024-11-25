Return-Path: <linux-kernel+bounces-421354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC39D8A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4468166083
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A3F1B4148;
	Mon, 25 Nov 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPKb4ut8"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C21B4136;
	Mon, 25 Nov 2024 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551201; cv=none; b=VU1g+9j7D5e9F0zMrkyQTVI3+puBFZ/fJy//xIA5clZ/CpB0iPyNrorIzdsMSzXKEGzMoBzF13PjG7EFBVTHLfczOfci3F+GLeogr6TcUT3kYOlX7G9AznWNtJMficesUcTNg/S9XlyT4t6z7xdRFUUNI9/chglp5ABQRc5+J0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551201; c=relaxed/simple;
	bh=RtG/gOn6MPjTIDicfx0CuZjHw14DfuYhQnK9bNPOVQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcuTawbUziVUuPK1LkG2TKQcMTEAEmlEOaasqe93ZosvShNMtPlag0JCIu+R63RkEEXKZbPmLwRFxdIBolWMgWdRQGDrzIY5WZaIE+Hsafb+PxTpI2+LcFeFe/cquYE79rXUyThq5wdPdQUTXZpZKVwXainDwVRVovNuDqflPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPKb4ut8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fc1f1748a3so1346411a12.1;
        Mon, 25 Nov 2024 08:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732551199; x=1733155999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=r3FR3d5ILuvQwVafGOMqBhBgqAdgY2ts6TkOzxc8ZO0=;
        b=cPKb4ut8eZODe+F2IpvxOwciOiBlYDujNckVq3u06R+DsB6XrpDaSZsm5Nc3lcXbDK
         QahFKUz9oOfk1bfI+RZNYRzcmTg2wtVOWigeScO/n7/nyaeyX3Dk9oAO1ByKy70tS/r7
         6qXkqQKxCVLXA1BzDLmdUHNrghbUAdbnbpdJZL2chohSOPSkf7DybhoT2xzfUtwQNHAF
         0xUbfjxryXFsQqGtV/aKKbbqlbvxtJM/wQBatiJZds7EaXhCIuECvnNaIgYhwxvnxuOw
         lGwU1pkHTMaAbQ2APq9YeB4VwlrclcfrRZ2aAfTXPw5EaGWgihVt9KOdd/I56NmtXHIJ
         iwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732551199; x=1733155999;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3FR3d5ILuvQwVafGOMqBhBgqAdgY2ts6TkOzxc8ZO0=;
        b=jG8H/oplBL7bgTxjIaQ2kZfMUdUSyz35rN2u3fThebotW24py+ykg7c06Pkg1kGiNJ
         b5FFQgIQo1g2FyPoGx+dqJZTpfhXo0rY+aOcOa/7izG3gME14KETYrH1ouZN5G4M62Ef
         nIDsTTNFMl21zQl74HlUcOD0h4fKRXVYnioyMj7URczLVlIH5H2R/aA6dAhQSiGX1pv3
         Ij7n7BlbONnvWyhPj7ojWXbyMLKYPu/8Al5ulOHCXgLuq5DSAezEVfodlY1yXSevRhaN
         mL2if5HhVf7pVuAyIOluyeOU80jG4AbVkVkRIHVnHahMV56MbM819VTQnUmF6hFP5dBR
         VjXA==
X-Forwarded-Encrypted: i=1; AJvYcCV4lTUV7KeNAQtqjPiO55hAaPHadCYuqW/YgueLankEkKa4QfkOffyN4W7xxMbTRLsFhmwTE0TR3wN73w==@vger.kernel.org, AJvYcCXKLeDFhT5O2cZ3OGBYfBG0aPN5bpYbXgZ65MOPwx6lyGC5s36cq3fObhsSsAcT55mIHHTVQsJBCcjM7b8i@vger.kernel.org
X-Gm-Message-State: AOJu0YwQmaFxjNobtReVAfM00XOfV0A2taeo2xZy3635sLpK1BYqzzfh
	lNcSF7Mh2phrNmL1aKLuIbCTpBKCVNnOFZ68KPMlhskUJAGM0cgY
X-Gm-Gg: ASbGncv6OiirxExdoTuB5fuTkYi0irWMQdPJHxozaIivKO1yT37lc6chbyVUqcRht2Q
	APtCSt6od5SR3Mujqy6C/bF7Yccvan4CmOzydxIzv6cTGGoPC9C4PLWXTWYWtxaUccOLGiT+l4t
	F5740kfiAz+h6tWVmuL/xHRBuZlM4GV7S2OKoxvdJLcx9Y2Ye0TpShVcs+EX9Fzi1giWTcduMmo
	RKJUSg0tUCzaxIdg1vlyleaFchutFP304D2IeKsMY3eRxuHa/fE9lDhQwS5eamHgrCFkcfIvTv8
	ee0ANiON/oICiqzcRaqqbfo=
X-Google-Smtp-Source: AGHT+IGWowUripRU8V2mWSHOlLFWRNc7ArnZjOb/sXCeclglLDyNWP15s+uXaVCwWirEyK6gKHTCmg==
X-Received: by 2002:a05:6a20:7492:b0:1db:f823:109f with SMTP id adf61e73a8af0-1e09e588d0dmr21414261637.31.1732551198694;
        Mon, 25 Nov 2024 08:13:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de456444sm6814088b3a.28.2024.11.25.08.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 08:13:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f7274b8d-cb91-4975-be94-69f041e9c4ee@roeck-us.net>
Date: Mon, 25 Nov 2024 08:13:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] hwmon: (acpi_power_meter) Add the print of no
 notification that hardware limit is enforced
To: Huisong Li <lihuisong@huawei.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, liuyonglong@huawei.com, zhanjie9@hisilicon.com,
 zhenglifeng1@huawei.com
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-5-lihuisong@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241125093415.21719-5-lihuisong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/24 01:34, Huisong Li wrote:
> As ACPI spec said, the bit3 of the supported capabilities in _PMC indicates
> that the power meter supports notifications when the hardware limit is
> enforced. If one platform doesn't report this bit, but support hardware
> forced limit through some out-of-band mechanism. Driver wouldn't receive
> the related notifications to notify the OSPM to re-read the hardware limit.
> So add the print of no notifcation that hardware limit is enforced.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/hwmon/acpi_power_meter.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 3500859ff0bf..d3f144986fae 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -712,6 +712,10 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
>   			goto skip_unsafe_cap;
>   		}
>   
> +		if (resource->caps.flags & POWER_METER_CAN_NOTIFY == 0)

== has higher precedence than &, so this expression will never be true.

And, indeed:

drivers/hwmon/acpi_power_meter.c: In function ‘setup_attrs’:
drivers/hwmon/acpi_power_meter.c:701:42: error: suggest parentheses around comparison in operand of ‘&’

> +			dev_info(&resource->acpi_dev->dev,
> +				 "no notifcation when the hardware limit is enforced.\n");
> +
>   		if (resource->caps.configurable_cap)
>   			res = register_attrs(resource, rw_cap_attrs);
>   		else

On top of that, I don't see the value in this patch.

Overall, really, this driver could benefit from a complete overhaul.
Its use of the deprecated hwmon_device_register() should tell it all.
There is lots of questionable code, such as the unprotected calls to
remove_attrs() followed by setup_attrs() in the notification handler.
Any updates should be limited to bug fixes and not try to make minor
improvements for little if any gain.

Guenter


