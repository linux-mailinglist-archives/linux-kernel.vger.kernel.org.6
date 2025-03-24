Return-Path: <linux-kernel+bounces-573831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC8FA6DCF6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF30D3B7B33
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE5261375;
	Mon, 24 Mar 2025 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eqhd3ejs"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA125FA31;
	Mon, 24 Mar 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826218; cv=none; b=tsLGPR+6KUeqArQC1MKrMlcZ2c3ZvhKdEPBI7dOcG1dG8JmfjhzLGXo8dn7LbQ/QRnFD0Y4R/84VFcQJBNVN+KIFGzkFSSsfIzVvHsRUn7V5vIgCyPhXIjO3Q4mIE2mgdI3m1JgzMZXMe0upB2JG236/f/PFWMcJK39j3nuIOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826218; c=relaxed/simple;
	bh=T9O+OjyuYsEWsaV/u/I8OgmvvRYdBzOmioIB3KGGE5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOfMIKiTY8dWG3kbkQDAawfAMb4z4kHQVQnS7Z9GNRXPIZpe/np35UEcSAfNKjSwLQF02BvBikPzSvuUF4x54hlt1V7QWa24cmk4+lUntn4BSoZejQOEymAGFMT5YqucNUnEBouKyVjI5+lyZp1vJ92CujEbkfvr2K2ORKD+HZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eqhd3ejs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so9284725a91.0;
        Mon, 24 Mar 2025 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742826216; x=1743431016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JOoT+rzf7f9RJXhKC/sBumAdpW8J/gLTaNzVv677dTg=;
        b=Eqhd3ejs0RvS9VNEUlYoEAq2dav4rwenCaHI5S9dD3qdb1U/SPyzI4Dqk1eYluzqJU
         eB7EQYEgrcS/y5tr9e107uFE8glnZD7/ypqJnm00lOun9S0CD7RxyhWeT5h2/jsMX4YR
         Kb5tITe6yEYj7QWlSrd8KCZFunLynmFaBYEcBu45XmqYHSv+KDTQqNkoS02eJfV1l0SW
         rgv7t5m5cJNFi5O4W4rWuss9E0foAv8+tR3jM+zeFRIw5JwvBZ++36XxTaCCMbB9ZmDF
         ZNTbImi9iyNrDIUxqXVIk+sl8WhjCwm+OSu1nvupXyqeNcF747a5d8hlkFiVjjBzmWWa
         ziXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826216; x=1743431016;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOoT+rzf7f9RJXhKC/sBumAdpW8J/gLTaNzVv677dTg=;
        b=FqmNmM5X0yvcAcb3uOuJz4wCLk1X+V1eEPjCtZoYMvYs79fFeqwWVLDyV4HuKR8G9j
         PVRgrv7ZNoDu7hksQUE6K386bfed2CI+fFOPSBy9/ztB6KYCCzKDuyQuduTeT3CzcP4j
         jKDCwqw/yn1FC5XG0es/+ayRzb7nya+nv7ow0nIYCWCc0DkjuS/eQlDGAUq+Li/1wV3K
         i0UoLMWrXx0olpEm6ULsLq8B41FqUAW4IecyldZ63ue6GP6n7lnBGKYEY7UB9Baj6QBG
         auCBwiEO3KkSGc0fenj//GNT5hkE8TS8/jUcktKW7jMf73QBZN0DIUK9XsOm3xGWGR+x
         HrOA==
X-Forwarded-Encrypted: i=1; AJvYcCVWJ++bYWiSv5I0V4w9wnZasEJ++OaF9+E9k7YTkqhdGEke17F1P09iXA/exDG6AagiI6zld0LpeaQ2t6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5xrR5vURb3HZfxYnJ/H5CL45HqfbKR8MNT76y51MkkPiP4ir
	wra5MfH/MnmgB2A4KBU6rLRmbrh0k8OUFFqzdLyu6aXNLtBrroQTjLrQow==
X-Gm-Gg: ASbGncuQG3o47goYlZPMa+f9N2ZqigN3/nSymDScooH6JXmbUZwzzf1iknfe0q/La1W
	/hg2J5zd2AyWpcVZ82DEp25CEItVbKBkG7J3jJnK3cOVmg6+at8dj2jY1SeRWSsN0xGHcmmbS32
	Q2oN71Uzlz1g0fwrvbCBiVLcydKSHSaObamDg+oAjvrlBVIzAwShMtr2xdd/zqOWxGexC6yNzpf
	e++8veLzo4L/xM3UrIG1N4tSzmkFjCsEz7LTK/N2Z+8NNa+REb/9OMy/piXnqjX3YAtetxKdhZe
	3uMJv6vekyn0bWw8pFzVXMAJp0sxcLEy35FAmAKD/JPFaFMD35wY4vhfjqQ3hNRzFKKNZw8P7Jf
	absIkzxw1ig5lHvbOEA==
X-Google-Smtp-Source: AGHT+IH/zqC9VCVyDaxAL4MjsnixAiUijI43atRLNJuXpRjOdgn8/agjo02Ivk9OcXcrbW7oy7LwMA==
X-Received: by 2002:a17:90b:48ca:b0:2ee:db1a:2e3c with SMTP id 98e67ed59e1d1-3030fe6e1dfmr19934733a91.1.1742826215354;
        Mon, 24 Mar 2025 07:23:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf5a1d80sm12256019a91.26.2025.03.24.07.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 07:23:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <851fe398-28da-4ca7-8b0d-b8111811779c@roeck-us.net>
Date: Mon, 24 Mar 2025 07:23:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hwmon: (gpio-fan) Add regulator support
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324124550.989292-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250324124550.989292-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/25 05:45, Alexander Stein wrote:
> FANs might be supplied by a regulator which needs to be enabled as well.
> This is implemented using runtime PM. Every time speed_index changes from
> 0 to non-zero and vise versa RPM is resumed or suspended.
> Intitial RPM state is determined by initial value of speed_index.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Patch 1 & 2 from v1 [1] have already been applied, although number 2 [2] is not
> yet showing in next-20250305. Patches 3 & 4 (just removing comments) from v1
> have been dropped, so only this patch remains.
> 
> Changes in v3:
> * Remove noisy dev_err calls related to runtime pm
> * Properly propagate return codes from set_fan_speed
> 
> Changes in v2:
> * Make regulator non-optional
> 
> [1] https://lore.kernel.org/all/20250210145934.761280-1-alexander.stein@ew.tq-group.com/
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/commit/?h=hwmon-next&id=9fee7d19bab635f89223cc40dfd2c8797fdc4988
> ---
>   drivers/hwmon/gpio-fan.c | 104 +++++++++++++++++++++++++++++++++------
>   1 file changed, 90 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index cee3fa146d69a..4c736b7eb5473 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -20,6 +20,9 @@
>   #include <linux/gpio/consumer.h>
>   #include <linux/of.h>
>   #include <linux/of_platform.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>   #include <linux/thermal.h>
>   
>   struct gpio_fan_speed {
> @@ -42,6 +45,7 @@ struct gpio_fan_data {
>   	bool			pwm_enable;
>   	struct gpio_desc	*alarm_gpio;
>   	struct work_struct	alarm_work;
> +	struct regulator	*supply;
>   };
>   
>   /*
> @@ -125,13 +129,32 @@ static int __get_fan_ctrl(struct gpio_fan_data *fan_data)
>   }
>   
>   /* Must be called with fan_data->lock held, except during initialization. */
> -static void set_fan_speed(struct gpio_fan_data *fan_data, int speed_index)
> +static int set_fan_speed(struct gpio_fan_data *fan_data, int speed_index)
>   {
>   	if (fan_data->speed_index == speed_index)
> -		return;
> +		return 0;
> +
> +	if (fan_data->speed_index == 0 && speed_index > 0) {
> +		int ret;
> +
> +		ret = pm_runtime_resume_and_get(fan_data->dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>   
>   	__set_fan_ctrl(fan_data, fan_data->speed[speed_index].ctrl_val);
> +
> +	if (fan_data->speed_index > 0 && speed_index == 0) {
> +		int ret;
> +
> +		ret = pm_runtime_put_sync(fan_data->dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	fan_data->speed_index = speed_index;
> +
> +	return 0;
>   }
>   
>   static int get_fan_speed_index(struct gpio_fan_data *fan_data)
> @@ -189,7 +212,9 @@ static ssize_t pwm1_store(struct device *dev, struct device_attribute *attr,
>   	}
>   
>   	speed_index = DIV_ROUND_UP(pwm * (fan_data->num_speed - 1), 255);
> -	set_fan_speed(fan_data, speed_index);
> +	ret = set_fan_speed(fan_data, speed_index);

That means pre-initializing ret is no longer necessary.

> +	if (!ret)
> +		ret = count;
>   

This is confusing. Please use the same error handling everywhere.
I would suggest
	return ret ? : count;
or
	return ret ? ret : count;

>   exit_unlock:
>   	mutex_unlock(&fan_data->lock);
> @@ -211,6 +236,7 @@ static ssize_t pwm1_enable_store(struct device *dev,
>   {
>   	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
>   	unsigned long val;
> +	int ret;
>   
>   	if (kstrtoul(buf, 10, &val) || val > 1)
>   		return -EINVAL;
> @@ -224,11 +250,14 @@ static ssize_t pwm1_enable_store(struct device *dev,
>   
>   	/* Disable manual control mode: set fan at full speed. */
>   	if (val == 0)
> -		set_fan_speed(fan_data, fan_data->num_speed - 1);
> +		ret = set_fan_speed(fan_data, fan_data->num_speed - 1);
>   
>   	mutex_unlock(&fan_data->lock);
>   
> -	return count;
> +	if (ret)
> +		return ret;
> +	else
> +		return count;

Static analyzers will rightfully complain that else after return is pointless.
Try
	return ret ? : count;
or at least
	return ret ? ret : count;

Thanks,
Guenter


