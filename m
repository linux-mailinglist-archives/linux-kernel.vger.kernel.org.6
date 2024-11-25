Return-Path: <linux-kernel+bounces-421313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D89D897F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20ED2859EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235131B395F;
	Mon, 25 Nov 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG/QFD08"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E34B1B4122;
	Mon, 25 Nov 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549133; cv=none; b=hlN+dLNxE3Bj7Wvavg2ZSTe0tgTIo9t66nfOTs99TFGzxFo8NlmCId79+sVvGkcvZO/cx4gVyCKg/k6l5bT2+o1st4gTxnU69/YgSGLzIml5lhnegDnoLf9y7nZVheVIDI2+9yBWfRoK/Rz3GPtx79HulWAyiOpplmmg50vCNWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549133; c=relaxed/simple;
	bh=Sme9ditUgQHkaJXoxj2JfK2GPTydrcxm+3DpKcOeTG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkjAVBCN3ocEUfXT74dIg7LeoR9cXFanr7NvcKBqxYB/fkrNP71ytTpEwvkSN1Z0Bk2DM0TsjlWFGXb2zLyvrcN5F2PzA+HGiEX9mZouHOxRTWUIUSX7DNgujgemUpFS6um6pXHE4sNFaeMa604qpdd//qeBTHOhZyv0rJ5ZyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG/QFD08; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso3190124a12.1;
        Mon, 25 Nov 2024 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732549131; x=1733153931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7HMd93l2XhUd6boAHs8/96tfHEGlnZQLIbe3woCtHLI=;
        b=KG/QFD08wxFS67QSKwx/1Myz8hiEYIiPxnPHZkJLrm23dneOhby9LLVC/hiCtd+DOs
         9X98dt/O/CTePujlABvzao4cDkgoVYwHzUBPu3YqjunNOM1gfFuWiVqmqJklz9Fb5g/R
         SC6L5OpWVfkwd64rH3Eynq033VM232uLLJ0q8p0saHYBrU20ZglMSQtmQtLuBHAYhwsZ
         BgQ+A+vyY7aGVOeJYKGzhL3WAMUvNx5vXXdwpe5pJ5GmmrMboNcHAdVOG9ckWziQUljV
         RsTAwIs2E64ZCj3lKxepA6NLXlviyEE2x6EGCxu1HF2GBOps/TcMzZt5TKxrUK3FjJ8k
         c8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732549131; x=1733153931;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HMd93l2XhUd6boAHs8/96tfHEGlnZQLIbe3woCtHLI=;
        b=b1RtcP8X/2MuEhWZ9b2fdh5hX8w27IwS7CjPt+lXSToSADA5HtHsczslfyMwaM5Q1n
         mvRRnUkPJBEfm7ngr5Stbm6Z3lzwsUlE2hLChd7vLNhOcGpkaSyLf7vOBmXXt9BwlGGy
         cFvCueC1KMurS6RAbK4bzC+shVbbzrn+U/gbQ+Cvw30pKlaqSC1QwRL4R7gsEVxAWFY0
         gyNcl+8xTJf5cQC338/OUljz4qKKpdPoVUEWnZUxaTr99w7ATuRExtCAnGMxbvYCY3CF
         TwAlqsJBUSWmhPNcW4G9OM2FSx5BI1kFVjRlPjnVbNwg02La7nU3lQ6WF8HPgLpuwM74
         xHBg==
X-Forwarded-Encrypted: i=1; AJvYcCVrQq12PSfsjGTwstxxTHt4o5jH/CQ541cgAGZui1HXFRfNkmu1JhqV+yajxoxK+sk1RlpIyKqeFI1kq3I4@vger.kernel.org, AJvYcCWdl+gs/Aq5BEB96Nlk+QGyeTo+tLU1KEwe30YFj2lZ2ijGnD2jAzsxCb3rMniGIpLYD8NEYYfgc7aoqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1djwvyfOgDzcqWAIfLK5fLn+AwsSmPK0ryyFnU9UYvl/jENa
	bQd5pEcloY4FU+LCZJzIVk1kmPqTPtxZxK2S38arIuFhYyNn01jk
X-Gm-Gg: ASbGncuNZJX/n8CLOAX01oy/EhI137wF991TAn5YafMjXkF8P2f6eIN3BQEE0dxr+Gt
	StFxOHJ24puNruyEuNKbaafToo1bMe90k70PiHdVfnKfGLnBjF5fz6POHrmrg6/FXHGxrJp+g5E
	JScE8DzU5TyLfqH+aYDQuL4t4kUscEt/vTUfP3dNx/S4rtPnslJHU7xX8vVAnovf8v9jTm6373i
	SLd/+5Lic7PgF/TXowO6v+sdSUpUdzcmgAhYHD92651R07jjq3g5aX5kdAXpMPZcJDGrKKhwH/F
	1aom9lvWW41iNxU8dnmBCfw=
X-Google-Smtp-Source: AGHT+IH16T9jkJyFrSeZ/PuvFVS+40nU9LO1WInhBICnYXlB4w+IbMoUSn3QOAMMeWDTwVfDWF20fA==
X-Received: by 2002:a17:903:41c2:b0:20c:5d5a:af6f with SMTP id d9443c01a7336-2129fe288bcmr186057005ad.10.1732549130782;
        Mon, 25 Nov 2024 07:38:50 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba14fbsm66566835ad.81.2024.11.25.07.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:38:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <370185ed-4418-4c84-a7dc-3faa56edade2@roeck-us.net>
Date: Mon, 25 Nov 2024 07:38:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] hwmon: (acpi_power_meter) Remove redundant
 'sensors_valid' variable
To: Huisong Li <lihuisong@huawei.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, liuyonglong@huawei.com, zhanjie9@hisilicon.com,
 zhenglifeng1@huawei.com
References: <20241125093415.21719-1-lihuisong@huawei.com>
 <20241125093415.21719-4-lihuisong@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241125093415.21719-4-lihuisong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 01:34, Huisong Li wrote:
> The 'sensors_valid' in acpi_power_meter_resource structure is always one
> after querying power once. The default value of this variable is zero which
> just ensure user can query power successfully without any time requirement
> at first time. We can get power and fill the 'sensors_last_updated' field
> at probing phase to make sure that a valid value is returned to user at
> first query within the sampling interval. Then this redundant variable can
> be safely removed.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/hwmon/acpi_power_meter.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 95da73858a0b..3500859ff0bf 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -84,7 +84,6 @@ struct acpi_power_meter_resource {
>   	u64		power;
>   	u64		cap;
>   	u64		avg_interval;
> -	int			sensors_valid;
>   	unsigned long		sensors_last_updated;
>   	struct sensor_device_attribute	sensors[NUM_SENSORS];
>   	int			num_sensors;
> @@ -316,15 +315,14 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
>   }
>   
>   /* Power meter */
> -static int update_meter(struct acpi_power_meter_resource *resource)
> +static int update_meter(struct acpi_power_meter_resource *resource, bool check)
>   {
>   	unsigned long long data;
>   	acpi_status status;
>   	unsigned long local_jiffies = jiffies;
>   
> -	if (time_before(local_jiffies, resource->sensors_last_updated +
> -			msecs_to_jiffies(resource->caps.sampling_time)) &&
> -			resource->sensors_valid)
> +	if (check && time_before(local_jiffies, resource->sensors_last_updated +
> +			msecs_to_jiffies(resource->caps.sampling_time)))
>   		return 0;
>   
>   	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PMM",
> @@ -336,7 +334,6 @@ static int update_meter(struct acpi_power_meter_resource *resource)
>   	}
>   
>   	resource->power = data;
> -	resource->sensors_valid = 1;
>   	resource->sensors_last_updated = jiffies;
>   	return 0;
>   }
> @@ -349,7 +346,7 @@ static ssize_t show_power(struct device *dev,
>   	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
>   
>   	mutex_lock(&resource->lock);
> -	update_meter(resource);
> +	update_meter(resource, true);
>   	mutex_unlock(&resource->lock);
>   
>   	if (resource->power == UNKNOWN_POWER)
> @@ -429,7 +426,7 @@ static ssize_t show_val(struct device *dev,
>   			val = 0;
>   		break;
>   	case 6:
> -		ret = update_meter(resource);
> +		ret = update_meter(resource, true);
>   		if (ret)
>   			return ret;
>   		ret = update_cap(resource);
> @@ -699,6 +696,10 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
>   		return res;
>   
>   	if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
> +		res = update_meter(resource, false);
> +		if (res)
> +			goto error;
> +

This forces an update of the meter attribute even if no one reads it
subsequently for a long period of time. Avoiding that is the whole point
of the flag. Otherwise every driver using the flag could just read its
entire set of attributes to avoid it. I don't see the value of this patch,
sorry. You'd have to explain why it is better to do the unnecessary read
to avoid the flag.

Guenter


