Return-Path: <linux-kernel+bounces-421348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2F59D89E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2045162B96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75E1B4130;
	Mon, 25 Nov 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPw3n7CV"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803102500D2;
	Mon, 25 Nov 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550635; cv=none; b=QJpeuoiELrfy27aPGWS3OiKpxFf7v0YUfeW4Ywe/JM3B6+T7pIt7StRbhrxwPPaqfuMY8cO5PG38naH1/rfGsvCK1DTFJ0IAyEZL51EP77bF8DpNyM9V4RDpPUYtKeSnhwKUjxC4EgEsYt4pdunSz8iKPOGWhYbK6HtpYMcfTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550635; c=relaxed/simple;
	bh=JVXBK3ERxck06dJhXYlrGQ7pXqtyYDTznRZmJGZYn2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGxL/aeOYefxLNb5GFYHTe5i61hNloWwUFNdbQcE34JIv7HI2qDRgO2zjkpOMy1hf1O/QBRPlEj+Lq5g0ZtV+kGyS49r5aq6Bz4VQ5z8/v1Wp9ELBEMx6XI1rFafzfAf1evLIpfAy5i9LfOKiDYxji/dRLf1oQJ+ApBJk6DNEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPw3n7CV; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso3198837a12.3;
        Mon, 25 Nov 2024 08:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732550633; x=1733155433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=elxA+QAbEFAffsAeNupzq/iG+gMISth7fVEgLGnkeWE=;
        b=WPw3n7CVe+UlNnY1snJaEun699X7zElUtAkIoIewrQGnURfu5ynSKXEt+iSwlCj3Ja
         7wQNSOJt1B7susr3kouc8a+xWsMZCtkxGCdpXpd74Afzw6wBIc34nQ3gIhpGdMOvg6YI
         uzBLeVfv2FNqz/YI2YAucn083qUQilS5sBYsufYyCLKoEZA91ateA8SYvrQDAe2rG7hd
         ia7GyWQUsQp+eLQqU8+b0pk661EHKaXfTuXYDYA/5UTHeiXkb9mRzKYav9yDEHNMB48Z
         6FIT1NK4fqOjzwsfY1QGu2/OdCSDbRHvSfokOog3QFPXMSg/3lNLj8FUPwOikqc11x/B
         7dXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732550633; x=1733155433;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elxA+QAbEFAffsAeNupzq/iG+gMISth7fVEgLGnkeWE=;
        b=mRVoVCBA3EUHRqI4elBpUYscnmPewVX6MiGj3Ns1VAhLWe1J2COgO7xMUT1wp730nj
         V/kkLeZXw5EBF8xKXXays/WKPQT57oHCivgy+Ko3i5YjyFmawy6pGNfZCuDcYmihQczy
         g2sBcXrCovBOjZTnY5ifO+QQjDid5nDBoaonpNYq7Tez4mbt2oYLrTLrBkn/mZzrfaQN
         TdEKeeRxM92hhiRHjx0Kv+5Bw5ETB49BnHIA9zwghDEqDK6AvaPqmTT2Byc1G8GGCFhJ
         d9TO0ia8yxIM866ATS2Gus5hcjRbYSfn2ZaUww65NRt6OqN3So2CgfK0m+nGCOceppHx
         +XLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/7s/aaW1u5+yEMvSZ/JsYLRn0qmX9jQ6zeQL/6OU2eNpg7fbUNMG9moOPOtFFeJt65KJIsXbmrvmQmg==@vger.kernel.org, AJvYcCWjGQE9xtMgdxyirwgUXJXem9Q0Lm2z2hIcTWSARPUISMMavIiJZzS4ms4atdoB1W1dqYY4dURgHDAGtgjj@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHwt4XIi/YRn6p+FXg1VClhuEH+qpo5AHTilwgG32jVVY0XT8
	uBh7LqWTZFEOrCGCgHaZUE3JZjvDN5W0zGkvDH2m1V/QIJRJa/wS
X-Gm-Gg: ASbGncuuYfdln4XfZcWSnbjJe/WTxgT9b6SjTXQ5tXW5iuhF/b2HduuErWA97tKQSBX
	9ppBMJvsyF8p/qtFMVYfnabOE9MUGBC1cvzcIBLfixpCIsuKlvItiDA4OTfcSsMPDkdA/aMbLrd
	xVM7+TtgVKCwJ/Nr8PPnTK8E2YbnWnjkC2UX6R6ACGknLF5Z+++H/lBJEkf8O+2LYAs5Uom/hGL
	2rrMNM9R9s6Lbni9gtchpYIx31wD8dvK+VDv5C805S39aG7e/FXVTWEBrnLEXME+spa5m4/Eb25
	m1Cj8DiWM3zxnheWnIDnv/w=
X-Google-Smtp-Source: AGHT+IFiHeksOOn2dQw+NCO2y2yE31fa/Zhla1Dv2vwD+MZoKSifgz+oHD3/ZfkK/3GCZlvb4j/9Sw==
X-Received: by 2002:a05:6a20:3d8d:b0:1db:a33e:2c6 with SMTP id adf61e73a8af0-1e09e420a72mr20284082637.18.1732550632721;
        Mon, 25 Nov 2024 08:03:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc0501sm5795172a12.1.2024.11.25.08.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 08:03:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aa6e1c02-b8bf-4d25-ad21-2018af72e16f@roeck-us.net>
Date: Mon, 25 Nov 2024 08:03:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] hwmon: (acpi_power_meter) Fix using uninitialized
 variables
To: Huisong Li <lihuisong@huawei.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, liuyonglong@huawei.com, zhanjie9@hisilicon.com,
 zhenglifeng1@huawei.com
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-2-lihuisong@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241125093415.21719-2-lihuisong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 01:34, Huisong Li wrote:
> The 'power1_alarm' attribute uses the 'power' and 'cap' in the
> acpi_power_meter_resource structure. However, these two fields are just
> updated when user query 'power' and 'cap' attribute, or hardware enforced
> limit. If user directly query the 'power1_alarm' attribute without queryng
> above two attributes, driver will use the uninitialized variables to judge.
> In addition, the 'power1_alarm' attribute needs to update power and cap to
> show the real state.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/hwmon/acpi_power_meter.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 2f1c9d97ad21..4c3314e35d30 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -396,6 +396,9 @@ static ssize_t show_val(struct device *dev,
>   	struct acpi_device *acpi_dev = to_acpi_device(dev);
>   	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
>   	u64 val = 0;
> +	int ret;
> +
> +	guard(mutex)(&resource->lock);
>   
>   	switch (attr->index) {
>   	case 0:
> @@ -423,6 +426,13 @@ static ssize_t show_val(struct device *dev,
>   			val = 0;
>   		break;
>   	case 6:
> +		ret = update_meter(resource);
> +		if (ret)
> +			return ret;
> +		ret = update_cap(resource);
> +		if (ret)
> +			return ret;
> +
>   		if (resource->power > resource->cap)
>   			val = 1;
>   		else


While technically correct, the implementation of this attribute defeats its
purpose. It is supposed to reflect the current status as reported by the
hardware. A real fix would be to use the associated notification to set or
reset a status flag, and to report the current value of that flag as reported
by the hardware.

If there is no notification support, the attribute should not even exist,
unless there is a means to retrieve its value from ACPI (the status itself,
not by comparing temperature values).

Guenter


