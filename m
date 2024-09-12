Return-Path: <linux-kernel+bounces-326683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0893F976BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA74280ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C1F1B12FD;
	Thu, 12 Sep 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPJUFIvm"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B781A76D7;
	Thu, 12 Sep 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150413; cv=none; b=KWJDyKeP8mH+1YrU7AuQPqBFMaFFECvGuNl1GVgIKp8r+5UslA19umEbL+jEH7VznZbqFeanIczFQbkbjR91P7u5ahacwUW95aQCN8UMTbRNBqRsv0X3uFRyJ0/PfD0pOdr7tpvEBh9p8odoiRhpg6PeojTW96GFh6bz0cqInnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150413; c=relaxed/simple;
	bh=4SqxcGSzdnWcE4S2mgiOYAtKFZdvuiNaQ9T5E9LP75k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0ii3shTV5OqwZUsaJuyu8jm0oD02KaoVl5A9TnsL7Z9WNqfCQtK6Pbqeph+bjIRoYZqd5qcEgugBNcsco0IfEKkLF0xElWLvPWf7qIPknIQbjxjVPeNZX7bujqt3fwac+iK0vBHkyEPp+VPVOccfi6nHajy6fLNahu70c3k+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPJUFIvm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-717849c0dcaso930766b3a.3;
        Thu, 12 Sep 2024 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726150409; x=1726755209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CxBKTJ9/cIY1+huLCzegdRDe34N9u1qaLoUB/wMdADA=;
        b=JPJUFIvmRsawNvbD6QF0tDBFMZmPHq9WNs4bJu1PSHSmGW6NpFN9s3BDgdOnYRQDBD
         SPc/KikKvQqHQp7DArQvR0S2W9ZnyjrECDL6T3DWBgtKGUnFqyNgXC6RXXGCKrFogxrg
         i61Qj5npf1owcVeizYJ9R5hN6T3I5IWSxuAwNNsCW9aBqIxygcTEPf9zlqx3mQ2nUuKz
         CBJCDcWN6a1TuSYu63P9DVlozO9g8dUP7cl8hcagusxcXsK4TN5+E85Tg9zW0RZE6OwU
         M5W3qI97Xle5Mhz809ZbOtmEJz9rwWv5Yn4O5wtW2KsxVECxoic0n9XJGsv1KcW4P5eK
         +MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726150409; x=1726755209;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxBKTJ9/cIY1+huLCzegdRDe34N9u1qaLoUB/wMdADA=;
        b=NJjckl7gw4B+YJdRtnfwB7mLqi8xBUSSN3gjaPPxDeY6ljHc1XLHGTZHuReYN2XQTh
         aOg36fBk4rkyWREMO8TrC1cvnfdWLZLxBpKTTSUisQWxDmrccVR/Uh2iQ/SQuWH+IlFM
         u1tNZF2oCxh3MQ+ZX2rwFLhe/UO9Unn8n9VDKEkIVkotVPzGw8MA6IwKcHOX4pFkjlCt
         YRA7mS0SPIvhWGpfBsALTUStFLCejcQxeOkE4Q0slVr+x96VatpdJZceHRMAKKD9Tds0
         kWNpkX1/Q/65g2YZEAMs0SiHlOeEKSa0VXIYUinXRIQcOMFN44+GMhleBtryTmci3eV+
         8EzA==
X-Forwarded-Encrypted: i=1; AJvYcCVb+QWUe9Q/yw01y5cbhE9qb2j8SDzZ47aGzTbmg1dL1LP/6u9GJWmncbJ7llRnLWPHoeckxC5PF7569Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEB6mMQf4okZVSNdt/vZFUk3tsEPjoQ4zfREM7wekEbWeCgzDU
	C4KV393TIvZTiV2T0G7Zd86nR3/789t50p+dzhJqsvTvMmQqQxOD
X-Google-Smtp-Source: AGHT+IFq9Ef1rNrCClGrz72yKhtvw5cxw7wMg2z017GAr7EkFqWtz4NjocHcZT93UhAffjiWv32dmA==
X-Received: by 2002:a05:6a00:1a93:b0:718:d519:20de with SMTP id d2e1a72fcca58-7192608f698mr3895953b3a.13.1726150408899;
        Thu, 12 Sep 2024 07:13:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090926e6sm4623735b3a.126.2024.09.12.07.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 07:13:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ca09333e-902e-4b2c-8c8c-eb7f0d2d4922@roeck-us.net>
Date: Thu, 12 Sep 2024 07:13:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: Fix WARN_ON() always called from
 devm_hwmon_device_unregister()
To: Matthew Sanders <m@ttsande.rs>, jdelvare@suse.com,
 linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ppwaskie@kernel.org
References: <20240912091401.4101-1-m@ttsande.rs>
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
In-Reply-To: <20240912091401.4101-1-m@ttsande.rs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 02:14, Matthew Sanders wrote:
> devm_hwmon_device_unregister() only takes parent of a devres-managed
> hwmon device as an argument. This always fails, as devres can't find
> the hwmon device it needs to unregister with the parent device alone.
> Without this patch, the WARN_ON() in devm_hwmon_device_unregister() will
> always be displayed unconditionally:
> 
> [    7.969746] WARNING: CPU: 1 PID: 224 at drivers/hwmon/hwmon.c:1205 devm_hwmon_device_unregister+0x28/0x30
> 
> This patch adds an extra argument to devm_hwmon_device_unregister(), a
> pointer to a hwmon device which was previously registered to the
> parent using devres.
> 
> There aren't any drivers which currently make use of this function, so
> any existing users of devm_hwmon_* shouldn't require any changes as a
> result of this patch.

If there are no users, there is no need to keep the function. We should drop
it instead.

Also, your patch is not signed and therefore can not be applied.

Guenter

> ---
>   drivers/hwmon/hwmon.c | 6 ++++--
>   include/linux/hwmon.h | 2 +-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index a362080d41fa..84945a276320 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -1199,10 +1199,12 @@ static int devm_hwmon_match(struct device *dev, void *res, void *data)
>    * devm_hwmon_device_unregister - removes a previously registered hwmon device
>    *
>    * @dev: the parent device of the device to unregister
> + * @hwdev: the hwmon device to unregister
>    */
> -void devm_hwmon_device_unregister(struct device *dev)
> +void devm_hwmon_device_unregister(struct device *dev, struct device *hwdev)
>   {
> -	WARN_ON(devres_release(dev, devm_hwmon_release, devm_hwmon_match, dev));
> +	WARN_ON(devres_release(dev, devm_hwmon_release, devm_hwmon_match,
> +			       hwdev));
>   }
>   EXPORT_SYMBOL_GPL(devm_hwmon_device_unregister);
>   
> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
> index e94314760aab..2434c6fc17a7 100644
> --- a/include/linux/hwmon.h
> +++ b/include/linux/hwmon.h
> @@ -481,7 +481,7 @@ devm_hwmon_device_register_with_info(struct device *dev,
>   				const struct attribute_group **extra_groups);
>   
>   void hwmon_device_unregister(struct device *dev);
> -void devm_hwmon_device_unregister(struct device *dev);
> +void devm_hwmon_device_unregister(struct device *dev, struct device *hwdev);
>   
>   int hwmon_notify_event(struct device *dev, enum hwmon_sensor_types type,
>   		       u32 attr, int channel);


