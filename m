Return-Path: <linux-kernel+bounces-334664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5999497DA35
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F5D2822D5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BDA18452C;
	Fri, 20 Sep 2024 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYGYvROI"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A04F881;
	Fri, 20 Sep 2024 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726866843; cv=none; b=aBwS1U+UzpjuQOWT86GiSjm7TyTYOp1eASlbRaH/xPLKpuBnp9Ns4N90BC5pTyj1F4rgh0vVnxhZa3sHMTI1cfAUUXRvzGksj2vlE/cY+RwVIeGOptABgP2s7OgoazeY/OYjtumoaVHmbrYBSNN9LRfZ0KZcBKx2zh5ZNOLcFvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726866843; c=relaxed/simple;
	bh=TiRRmhbEVAwHGNWExA83r8+B/uNLuBnFcXDrnZT46EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=II1z2BcKPLvqXgcfsDhH2+VgszdLGjUxc3pxAwDHNm27EJnS20LgOejyoq9p9S4lwLyn8Fpnwhze4yVvJxS6YgT2oHh3ZOptF2bP5+PaJOgeArXVL48x6T/Jash/9vZSPUXZRgSSTVYdaSEcObHFwbvElmh0OR5qJt8dzdziDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYGYvROI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2068acc8b98so24867515ad.3;
        Fri, 20 Sep 2024 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726866841; x=1727471641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8nUdy8MPKPIAxGyxzJ3XFXFoEECowDzKOLs8aoZBzUo=;
        b=SYGYvROIS8A6v5CPxOj0u1/yKF0k5QHhnJPwXG0Zn1mBNs3SwVX6+69kja8U6p6Wpe
         QfxsdTHZb6Cr4fdcekYnBs8y64HsvR2savhALSPXHfN9L1H136stco1Mi1Q7Xw+cyIGk
         rtpCTqoviHOgoLsQs/ypUoRR+0mrDVPCWLJQz0f6GVSng/KAMwmrKzm2bS15G77B9FAh
         7sdjpuj7xhEv4rkl7hRNbZMNtkaHkuCY26Iw8v61qkhFT0rbe6YKK4/bnsWFgEfnPA74
         hyJXGzOeibuDZT/MuJRPF2JLOSJc6vMbtmVzkYhd8Dqjh5zQUcHWbItbxywbtDEgf/1B
         jDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726866841; x=1727471641;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nUdy8MPKPIAxGyxzJ3XFXFoEECowDzKOLs8aoZBzUo=;
        b=qxNegyMtRXkW900HNCfPbFeiUz1vT1LWLlmjSGHc98pDvG/b/qVvxLwQ8oqVDUfJcK
         hY+M3UVlf0S2JK1gCRwq0OA+au6dp+yBr5kD8Ux3Dg2+70xE4HUkrNYvRWfOGOLlHUX2
         GAnaBp3uAq7Liw7DKV5jpjhPBwp/pbfEEFA2rv0I81J3lGYoLRcwqJcWzusfrgsZ5nbY
         Takkxq8WubDfKCP8MiQTdSFa++4tNR401+16TOLHjTWfv4Dppppyvsmxx9IQPIpGkxIP
         ekB7GV3T9bj4Jqgn7gQJlUPA2uc7lCPgHYnyaB+jNQ/VHtzm1bPh8FWsZGQKDgolmMHv
         RQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYNyezloFzjazgfh/ADHio2v/Mrwa07N61oqD/OzRWT3qu28nkY4n4PZLAQygXAN9yeGyKZpDRuXJfz9A=@vger.kernel.org, AJvYcCXIkBoow9OYY1R2PMURDa7/okl406NNcGbhK1/1sEx1hjhyxaCaumQ3gad6ONvs0h3vWdtm9VswN64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6TAylCUoLi6UuvQCQ99fjYOgCQLEgX70U9h3MWBygOtB3+tpS
	G9O/Z1+lzXEQGN2e7yf+qltrT7HKZQpclfnnPZMLTX9nAwRBA2Ky
X-Google-Smtp-Source: AGHT+IEY4hz33BjyToclZJtvWi5dKNRs3veH0ThYp9YRW9HNEdRhduGZGnE5VaMm5byvelr9sk89xQ==
X-Received: by 2002:a17:903:946:b0:207:20b0:1380 with SMTP id d9443c01a7336-208d84472c4mr47906575ad.44.1726866840880;
        Fri, 20 Sep 2024 14:14:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d27dasm99003585ad.172.2024.09.20.14.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 14:13:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4052294e-7b7f-4238-9b47-92727de4d516@roeck-us.net>
Date: Fri, 20 Sep 2024 14:13:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hwmon: (pmbus/core) improve handling of write
 protected regulators
To: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
 <20240920-pmbus-wp-v1-4-d679ef31c483@baylibre.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240920-pmbus-wp-v1-4-d679ef31c483@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 09:47, Jerome Brunet wrote:
> Writing PMBus protected registers does succeed from the smbus perspective,
> even if the write is ignored by the device and a communication fault is
> raised. This fault will silently be caught and cleared by pmbus irq if one
> has been registered.
> 
> This means that the regulator call may return succeed although the
> operation was ignored.
> 
> With this change, the operation which are not supported will be properly
> flagged as such and the regulator framework won't even try to execute them.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/hwmon/pmbus/pmbus.h      |  4 ++++
>   drivers/hwmon/pmbus/pmbus_core.c | 35 ++++++++++++++++++++++++++++++++++-
>   include/linux/pmbus.h            | 14 ++++++++++++++
>   3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 5d5dc774187b..76cff65f38d5 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -481,6 +481,8 @@ struct pmbus_driver_info {
>   /* Regulator ops */
>   
>   extern const struct regulator_ops pmbus_regulator_ops;
> +int pmbus_regulator_init_cb(struct regulator_dev *rdev,
> +			    struct regulator_config *config);
>   
>   /* Macros for filling in array of struct regulator_desc */
>   #define PMBUS_REGULATOR_STEP(_name, _id, _voltages, _step, _min_uV)  \
> @@ -495,6 +497,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
>   		.n_voltages = _voltages,			\
>   		.uV_step = _step,				\
>   		.min_uV = _min_uV,				\
> +		.init_cb = pmbus_regulator_init_cb,		\
>   	}
>   
>   #define PMBUS_REGULATOR(_name, _id)   PMBUS_REGULATOR_STEP(_name, _id, 0, 0, 0)
> @@ -510,6 +513,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
>   		.n_voltages = _voltages,			\
>   		.uV_step = _step,				\
>   		.min_uV = _min_uV,				\
> +		.init_cb = pmbus_regulator_init_cb,		\
>   	}
>   
>   #define PMBUS_REGULATOR_ONE(_name)   PMBUS_REGULATOR_STEP_ONE(_name, 0, 0, 0)
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 82522fc9090a..363def768888 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2714,8 +2714,21 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>   	if (!(data->flags & PMBUS_NO_WRITE_PROTECT)) {
>   		ret = _pmbus_read_byte_data(client, 0xff, PMBUS_WRITE_PROTECT);
>   
> -		if (ret > 0 && (ret & PB_WP_ANY))
> +		switch (ret) {
> +		case PB_WP_ALL:
> +			data->flags |= PMBUS_OP_PROTECTED;
> +			fallthrough;
> +		case PB_WP_OP:
> +			data->flags |= PMBUS_VOUT_PROTECTED;
> +			fallthrough;
> +		case PB_WP_VOUT:
>   			data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
> +			break;
> +
> +		default:
> +			/* Ignore manufacturer specific and invalid as well as errors */
> +			break;
> +		}
>   	}
>   
>   	if (data->info->pages)
> @@ -3172,8 +3185,12 @@ static int pmbus_regulator_list_voltage(struct regulator_dev *rdev,
>   {
>   	struct device *dev = rdev_get_dev(rdev);
>   	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
>   	int val, low, high;
>   
> +	if (data->flags & PMBUS_VOUT_PROTECTED)
> +		return 0;
> +
>   	if (selector >= rdev->desc->n_voltages ||
>   	    selector < rdev->desc->linear_min_sel)
>   		return -EINVAL;
> @@ -3208,6 +3225,22 @@ const struct regulator_ops pmbus_regulator_ops = {
>   };
>   EXPORT_SYMBOL_NS_GPL(pmbus_regulator_ops, PMBUS);
>   
> +int pmbus_regulator_init_cb(struct regulator_dev *rdev,
> +			    struct regulator_config *config)
> +{
> +	struct pmbus_data *data = config->driver_data;
> +	struct regulation_constraints *constraints = rdev->constraints;
> +
> +	if (data->flags & PMBUS_OP_PROTECTED)
> +		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_STATUS;
> +
> +	if (data->flags & PMBUS_VOUT_PROTECTED)
> +		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_VOLTAGE;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(pmbus_regulator_init_cb, PMBUS);
> +

I am a bit at loss trying to understand why the constraints can't be passed
with the regulator init_data when registering the regulator. Care to explain ?

Thanks,
Guenter


