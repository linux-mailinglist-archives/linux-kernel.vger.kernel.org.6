Return-Path: <linux-kernel+bounces-543989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD209A4DC2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB735175F6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0D1FF61B;
	Tue,  4 Mar 2025 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpgfxWG4"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983E1FF1A6;
	Tue,  4 Mar 2025 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086742; cv=none; b=Q859Xvp/dtVLDES1NAiLEaY9fpB1j+B8UkuwXRzEtwGyXDuTfrE8OFhgvugI211egipINwTISBhl/mAe73LWvSteyhPkqWyjrmQleJ8CXYmIz15dNwyAS9UlBoUaoj0NJ351nZ4AJftoNmu96F3QkKqK7ArHGR1/lZHYiHC0tY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086742; c=relaxed/simple;
	bh=Wn35wzbe+Q8L/bYrvTjn8zseKL0WI1HoDtVSnphOdbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yw7M79Yw6PxCHnbHHjhIAbVIMOWnSeC2grIMJ4tnTRFpUufJHZ3UORlZDKqkcn+MiANBZbYWIT3b1m1j4fXw93bFeUh4vrXdjUVJSNYG49xedt1N5TnvrVHv3NWx8JktGOzuuF3R/Yz3n5KDzglXYF6/bVNw+mdE3MiIdROHVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpgfxWG4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2235908a30aso88087765ad.3;
        Tue, 04 Mar 2025 03:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741086740; x=1741691540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EhErTMLxBPvnHRj81OpDYTVq6CDG6bl2cvW4ml+lGiA=;
        b=kpgfxWG4tn71XeCz0cr7CH4wg5ZIRrmGo2spBJkpnF2ah31FucSMQgXpN1mQdDMCPo
         AY65WCss8CVjdSKTrYdfYoDS3iYKL0CQGqKoAcSZmY8YF/h/eebgkPJksV3uWFqqiIgg
         Og8H/mGleIIB8IJuXXG8mNtQ6q91NgYHK6dA17e0hNJUi5SQcmcZ7ozI4yI+wbwCHk5x
         ETJc5N4CJXzFkk68vTfk/1mB44LilZtq1XIjEwulJZycS8gJns6IZuea2ouQNPYSz8RJ
         Je7vfNO9xTLnA/L28RiF//duELEC5iLSzHhwsWRUlZVCrOlglx1D+GOvNZpBR0qx2XDQ
         Mh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086740; x=1741691540;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhErTMLxBPvnHRj81OpDYTVq6CDG6bl2cvW4ml+lGiA=;
        b=gNaU/BRJc8hx7z/3VFfn3MzxC4CzTQZxWl5glI1WCRa1EGlMdwD9vFU8LTBtA3CCOB
         WEqmNHhwOyyXYZqHDScEhLT1m0tBHtDdUVgUGRjq6gWctgNEJhvXhpPoAYa19g7AP/fO
         tM/677GJBYtFyyNsNnH0aM2Hw+0b8WJDi/CDQQ/nbzn9U5t1Ncn1A+Xyt0WFMh+kEIX3
         PnID1GTxAGet2+BO91WpCMkxBGFLf+EH7g/CFm5CGovfqAiT4Le+zGxTLFzXfy4oJH3z
         ToOvEUyF0KNA5n0WPXA++c1wyVui7QTJM1Et411P6Q2ziDD4ClcemyRQUtJciVjWyedk
         zTow==
X-Forwarded-Encrypted: i=1; AJvYcCV7FBCVLpQ7uev4bZhwz9en/FjW8QuCv06CrM97p3FQa/9XR7yutmceMRYE/4nYiWJ4D0Ozek0HIkAKshw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+UGDmr5bGvZW3H5uFKaN384KfU7b5f1AHzgMzzJ3oc8mlKnV2
	gk762vRXQfgcnNFnXZrDYg50cewIwCdS5OMu4Z0VMFhh9qpsXbIb2kzpIw==
X-Gm-Gg: ASbGnctgRDSDRM71zQYUg5e0gEnjyCLxmQEQfUjooak6yvGt45MaBn+TQmjp9bI0doJ
	nXQEcmQFO30cRmeHnnFYBLR4ObO5W3sGuvwCjSstVt76ZqmoCu/5Uuj1ASTPav67ogfoRPzkm1r
	s6DvQ9R9R4H2qoabEz1G0XaYjBWEmfcktP/FBp9JAPdUJttEd5H/znMBMz6nU8qLbJGk/eH7Eq4
	+Qg2XLJmnjzIsGIZQl9lC/buZ0/J8Q6NO/C9fhH9scC7T/LkTywo+Bg16bVlPn9XzNUfvXbMbbY
	6RsOPuAa2hY7gYaOIZ+xjGCLID/nMgw7BYdtPjX3OPZP9akCzyvF2d1ZnraJwhX9YeJwdeNScWt
	uzwMYjACRfXc7KVuXKg==
X-Google-Smtp-Source: AGHT+IE/WXC+DbgbFY+ZnCk3Y1Hqqhj9R3wVELVwS5SWO6zNnX+O3KWSMeXmQUNuvgVqs+bx0IymSA==
X-Received: by 2002:a05:6a00:4f8d:b0:736:3d6c:aa64 with SMTP id d2e1a72fcca58-7363d6caab1mr14990357b3a.21.1741086739979;
        Tue, 04 Mar 2025 03:12:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73655ce7b15sm3654876b3a.163.2025.03.04.03.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 03:12:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f2b58aab-6664-4968-86d9-1e761a41b065@roeck-us.net>
Date: Tue, 4 Mar 2025 03:12:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (ntc_thermistor) Add min and max temperature
 attributes
To: maudspierings@gocontroll.com, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304-ntc_min_max-v1-1-b08e70e56459@gocontroll.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250304-ntc_min_max-v1-1-b08e70e56459@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 00:24, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> Add the min and max temperature attributes as it is trivial for this
> driver.
> 
> This can help with detecting implausible readings and indicates to users
> which range they can actually measure, so they will not set a trip point
> at a temperature higher than max or lower than min.
> 
Unless I misunderstand the driver code, readings outside the table values
are never reported. Also, min/max are supposed to be alarm temperatures.
The reported values for min/max would be between -55 and +155 degrees C,
which does not make sense and has zero value for trip point usage.

NACK.

Guenter

> This implementation only works for ntcs, if a ptc gets added this will
> have to be changed, but I'm not sure if that is ever the intention.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
>   drivers/hwmon/ntc_thermistor.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 0d29c8f97ba7c2f264588b6309b91ca494012ad6..fecee177be5daf304c0521a74f2733f6e42567e0 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -522,6 +522,12 @@ static int ntc_read(struct device *dev, enum hwmon_sensor_types type,
>   		case hwmon_temp_type:
>   			*val = 4;
>   			return 0;
> +		case hwmon_temp_min:
> +			*val = data->comp[0].temp_c*1000;
> +			return 0;
> +		case hwmon_temp_max:
> +			*val = data->comp[data->n_comp-1].temp_c*1000;
> +			return 0;
>   		default:
>   			break;
>   		}
> @@ -539,6 +545,8 @@ static umode_t ntc_is_visible(const void *data, enum hwmon_sensor_types type,
>   		switch (attr) {
>   		case hwmon_temp_input:
>   		case hwmon_temp_type:
> +		case hwmon_temp_min:
> +		case hwmon_temp_max:
>   			return 0444;
>   		default:
>   			break;
> @@ -549,7 +557,8 @@ static umode_t ntc_is_visible(const void *data, enum hwmon_sensor_types type,
>   
>   static const struct hwmon_channel_info * const ntc_info[] = {
>   	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> -	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_TYPE),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_TYPE | HWMON_T_MIN |
> +					 HWMON_T_MAX),
>   	NULL
>   };
>   
> 
> ---
> base-commit: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
> change-id: 20250304-ntc_min_max-a925e87d0da7
> 
> Best regards,


