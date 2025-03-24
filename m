Return-Path: <linux-kernel+bounces-574589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927CA6E734
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A0C1896A08
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C598C1F0E4B;
	Mon, 24 Mar 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssktxv4g"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B692158520;
	Mon, 24 Mar 2025 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742859015; cv=none; b=Lyrv5cnZ5W1yp1njbgv0AqSwh4kSgepo78dcYyU0oJZbX0Zhalp2SrtPNoiEqhy6Q6R8qbBv7BOewjHY+WyerarBgkx6JvWfxWAh2ygSCzEMIMV3VypyzfLyr1RFV5rRWeJrHeUZdkJOcFOXOy1kPrqQho8iMR3wSqK87Oh9QTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742859015; c=relaxed/simple;
	bh=+kLBC+wmvekOOmmTmNGYPQzFrvLZ2IpA9qqzGcEeRwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B7SAdmvFKrdtgqgQTT9Xlnrnt3Av1vnc9L4tV/cFXW7ZWZ2tIKBOGR0lJigH4uuTOzD55oNoY2ANDj8OY9Th07443bVVFxBalbGyMQMeMqNv25Na/xzb3/2wPj3afbTuspLIeN8lvFw3FlbESWtVmyfVNkICou7hE/xO9qS1FSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ssktxv4g; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224100e9a5cso95432385ad.2;
        Mon, 24 Mar 2025 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742859012; x=1743463812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w4zyhDCI+RSWHWMT7O9EjitnltLIZNNRzd7kP21NB3M=;
        b=Ssktxv4g1F+x33DllrDi8RLYEpnvUM741H2gq0t3e2zGIA1GOPQupkNLElpVDtn2SW
         1S3w/QIbuYe5a6zm0ShVJgz1krYFdhxq+/E8wRaAgmrswWT6faB5Ic6ne47lQDPqSr+f
         7rQ/swEW657I4Rn9CSPC41OnWp1MAFKAcQyQ8LU2h5Bcg3ydQWUHMvVom0NKQBkactF3
         NiWtULqKdQXu1oDK8f/AgGQ1Y+pbc9+VRiNlFZG3azrmv9TEmHOW6tY3JPh0qb4PzlSQ
         8qIILGmT+fBDLi4XLyxOVlGyClk4XYxG/fAU+sGDgXQRgXmo3P+fyryqX8VaEjrw4hXF
         bpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742859012; x=1743463812;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4zyhDCI+RSWHWMT7O9EjitnltLIZNNRzd7kP21NB3M=;
        b=bIt5H4MbjFLr8SuA3PB1gr/lONimI1LhCVEMYw6DRPDVyTNbbXHjsKQoJt92tM1s2q
         fSHNXUH2E8nURC4JyqiMvszh7BYQzXE20oG/d1Gpu9tSKMLcA6sg/voGhOLl8KFIj7+9
         BgJGGN1aLYtjGdErfOGdY0Ep5if2xOZi29g2x1HR37f8PRpd1qGliKWCoyYfRIrQO9xa
         +YC4DTY55FDbK0d8w55zlLj42fNdGJB/CeWibSxjUHAHpzf8dWa6yYGEQnadUlY+DDeB
         zz5ZRyBasUcoI5zkpCn2fNW/ukwzEq6y+NMLNUS3NZms6tCFrHyA5Pyxw8SP81u6xGH7
         FTRg==
X-Forwarded-Encrypted: i=1; AJvYcCWIfNbXw9VbkJnkgfNq5fW6efMBbMsQWRyVL0Jd53AvWx1G+xlbKn3EE3ckH8IBmEcaNhy+0/9o8R2x0nLE@vger.kernel.org, AJvYcCXTVfTRNmsJc6fXxvYJEy1GuNohN0tKmZHyIqSQehWuFcwn3ohoYVBhh6BhhP5liim76ixmvlQU5vBfmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFDet1WGQjgPn7d8G1CyIX6Y9QaIJxQSW42gG8J1A8UZ+DPVn3
	6BFmclCJ+1pgyfOREzybh/vAUrTTlLx74Bbbt3UnM2Lxet5h6rs9
X-Gm-Gg: ASbGncs0YDzeIsvF7Fz14ZgrGvNSQMs33KMvNbeN2sg1hJkIsGTakv66KOhjMIxxf9x
	DfXT8M54WUlmfDdrlKQm9o9nQOetccj6gTcjgz1VrcTWeOS4Ck4+2xsg0LdDoTqHL+EDc9zcT4P
	mCs6mmLFbP+yePHrltnFPyA6TF+Y8UkkrqRP+2GBiHO6Ka8dxiZtseoXQe+Xmd25XcF+yYipjiW
	xo+VA4SPC95yVg5heQDLB+QYufrcBT2FaJEGFqi9hvEiG7wqs7tcLziQyboRsas09OIxZiaQeer
	xKCj9DSsaH5Ncq+FW4o0w03+I/C3uItGvOeF/G1RfbuOxkb67ZlBZRl5GYBlB2MbE+Syd9brhvo
	J+szq/0Ame9MzwTsv1g==
X-Google-Smtp-Source: AGHT+IGImJZ01Eo8oudwyEyftaOAvzFVNH/RHv8Y24Yce8uuACSetVInASti6ncuefSfE3mTnu8sxA==
X-Received: by 2002:a17:902:dad2:b0:223:2361:e855 with SMTP id d9443c01a7336-22780e17b3amr236687535ad.39.1742859012173;
        Mon, 24 Mar 2025 16:30:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227bf257682sm29529015ad.195.2025.03.24.16.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 16:30:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b6668968-897f-4864-913c-d4d557f1d7cc@roeck-us.net>
Date: Mon, 24 Mar 2025 16:30:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (max6639) : Allow setting target RPM
To: Your Name <naresh.solanki@9elements.com>, Jean Delvare
 <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250324185744.2421462-1-you@example.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250324185744.2421462-1-you@example.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/25 11:57, Your Name wrote:
> From: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Currently, during startup, the fan is set to its maximum RPM by default,
> which may not be suitable for all use cases.
> This patch introduces support for specifying a target RPM via the Device
> Tree property "target-rpm".
> 
> Changes:
> - Added `target_rpm` field to `max6639_data` structure to store the
>    target RPM for each fan channel.
> - Modified `max6639_probe_child_from_dt()` to read the `"target-rpm"`
>    property from the Device Tree and set `target_rpm` accordingly.
> - Updated `max6639_init_client()` to use `target_rpm` to compute the
>    initial PWM duty cycle instead of defaulting to full speed (120/120).
> 
> Behavior:
> - If `"target-rpm"` is specified, the fan speed is set accordingly.
> - If `"target-rpm"` is not specified, the previous behavior (full speed
>    at startup) is retained.
> 

Unless I am missing something, that is not really correct. See below.

> This allows better control over fan speed during system initialization.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>   drivers/hwmon/max6639.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 32b4d54b2076..ca8a8f58d133 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -80,6 +80,7 @@ struct max6639_data {
>   	/* Register values initialized only once */
>   	u8 ppr[MAX6639_NUM_CHANNELS];	/* Pulses per rotation 0..3 for 1..4 ppr */
>   	u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
> +	u32 target_rpm[MAX6639_NUM_CHANNELS];
>   
>   	/* Optional regulator for FAN supply */
>   	struct regulator *reg;
> @@ -560,8 +561,14 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
>   	}
>   

target_rpm[] is 0 here.

>   	err = of_property_read_u32(child, "max-rpm", &val);
> -	if (!err)
> +	if (!err) {
>   		data->rpm_range[i] = rpm_range_to_reg(val);
> +		data->target_rpm[i] = val;
> +	}

If there is no max-rpm property, or if there is no devicetree support,
target_rpm[i] is still 0.

> +
> +	err = of_property_read_u32(child, "target-rpm", &val);
> +	if (!err)
> +		data->target_rpm[i] = val;

If there is neither max-rpm nor target-rpm, target_rpm[i] is still 0.

>   
>   	return 0;
>   }
> @@ -573,6 +580,7 @@ static int max6639_init_client(struct i2c_client *client,
>   	const struct device_node *np = dev->of_node;
>   	struct device_node *child;
>   	int i, err;
> +	u8 target_duty;
>   
>   	/* Reset chip to default values, see below for GCONFIG setup */
>   	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
> @@ -639,8 +647,9 @@ static int max6639_init_client(struct i2c_client *client,
>   		if (err)
>   			return err;
>   
> -		/* PWM 120/120 (i.e. 100%) */
> -		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
> +		/* Set PWM based on target RPM if specified */
> +		target_duty = 120 * data->target_rpm[i] / rpm_ranges[data->rpm_range[i]];

If there is no devicetree support, or if neither max-rpm nor target-rpm are
provided, target_duty will be 0, and the fans will stop.

Maybe my interpretation is wrong, but I think both target_rpm[] and rpm_range[]
will need to be initialized. Also, it seems to me that there will need to be an
upper bound for target_rpm[]; without it, it is possible that target_duty > 120,
which would probably not be a good idea.

Guenter

> +		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), target_duty);
>   		if (err)
>   			return err;
>   	}
> 
> base-commit: 2115cbeec8a3ccc69e3b7ecdf97b4472b0829cfc


