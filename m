Return-Path: <linux-kernel+bounces-561635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB58A61465
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292BB1B62265
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779B200119;
	Fri, 14 Mar 2025 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA7htbUY"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219B3B7A8;
	Fri, 14 Mar 2025 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964476; cv=none; b=SIznYn4QB8dddAiD2dE9PDnmdJLdJyjFH/B+gad5KGp+8H6pvUhKLDMgD4Jpi+lTBjrBJ+YMeZ/iBNTPfSdKx21JhT/Ca9ODH7IuVIgPQtiyR2Gm8XX1R/68IVK5tx68tYUaol0L6LxqBpBQBy8XrZy8VFjrNiOWUe9nvRaSpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964476; c=relaxed/simple;
	bh=GaRu5ERVoPZsrgYIAIhEjraG/SaBYRHYbSm2zGpJ9qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWdQIS/mLax9IOF2Y0DAPm6Im2dFcFtnujWoJoQakNWAJiYFIoYQbn9JtTy16jhkTUj9b6n9+PKHyQhmtOuGlUuc7lUfOmh+MX97ef7+yP97jidx3H3AS1dFUEn8jVB7IuaMUoriwtCNi5unLwHFNFWopWZdmYExoxZdi+W1YJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA7htbUY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235189adaeso39858955ad.0;
        Fri, 14 Mar 2025 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741964473; x=1742569273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dkqIt0dAm4flood+lEBFlTOVHHH/M15qiTxF9ROPp+o=;
        b=OA7htbUYVwuoblnYieeAnJtXiq9LwQA1lfb+J4dklY4odkzi8BV8OVvKQLtkCTD9oz
         LwVK3tP6PkoIpQLDjRgvJ93O4g24TgQGzJSHV11n88DOh93LWOw09eGW5SJZT5uwuTle
         lS62mFWIq1RzZh8sl5duM54jsXxw5u5mN0SoE4jHf4/SVf9SJ+o+tkCTREh/iiq7QnbZ
         X6WERgReG2svBMYD6ijHXDkAkf5cEElyb3oquh3KinbtokKZfHZ+LV2r/NDL8i4wRrGY
         B5PgAtovoUAuXKvEBHJrwXLV3AJdK77HSwrphqukpG632z2qk3UZBriJTVU6M5Qzc8x8
         TKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964473; x=1742569273;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkqIt0dAm4flood+lEBFlTOVHHH/M15qiTxF9ROPp+o=;
        b=FUc5SAZ9QCq1cabrNDBeocjTCDjaAexJeP22NV+0z8mHUtEvM9DGdsgE4bykVkINgh
         DvroKAF6yU4Z//QGCqVjTmik85ilElQuNiWWjpEhBjJUx3gtmXKaWfH14gOwfypm4ilW
         Goo2X5Zab9RbqakR1Ovc035IyS2nXm0WZP4PWgukp/2nUpjWyryGP56gMzYaNkZu8s4i
         Hma7aD2dwPF1yWNbTk9csS79rBedNvi1DWK0p1Qa3HLSTRjTeh8qcYURpowiK2LJF1tf
         nEBvqpKSsSJxp3D3uMFdFxDY7mPzR13bB/kONB1Nz4AbCzo/yP/Qwppv9pBtjl6SRt3L
         jNXg==
X-Forwarded-Encrypted: i=1; AJvYcCUdEHc6uMnH+zP/Bu76n95LZvxK9p+iozrL+C2ESCW/ZVLn4gMtlOSladh/THAyKTxZY8iWciHoK54jlQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwubHT8EDvcEpa0hmsVZsEqom891WxFNGssdEzW6MoeR/4Ufkws
	kCifkMOYnDq5dv2IpDXmt6j7g7CcT1A1pU4jscxvKOQUVFGNt+ur
X-Gm-Gg: ASbGnctSrCZBNbuTe7AY2XqvyWPVxXBugFDJuBRivZb7PHkeq3saJB0Qqh1wwHu2dt/
	UO+eD5ly5R+9OufbXq3Vt1CdoZ0mz1qG3tIsLdH2CFHcTamvIDSTAQIUm6DINOtYgE6m4YkaWu0
	vq9/Yylw+252gZWoyUTQ0Bre6dGJWSdTXT/QWFFVQP20koidIaztDmbvfEnalOAe3six4V27015
	U8I5qMKGUN+rBkZw/6l5vZKE8ZpVpa6lsl0lq5HzS8tIwV2oIvH5bs+bNQIdzd10sG3tQ7X4RAx
	h5l28Jn8o7gsWYXWJxv92Z2uO1e7g7XOWUgfO6p+q0GRUDG643sLqEOQjzua/ZV/H95IY466QFm
	Buo7+hZkTxAzjKBfWLw==
X-Google-Smtp-Source: AGHT+IHiTPxk83WFDew56WptLQbTVNUkpAFnbJkjARem9rmckTJEQH7ZKDnJfEiI9D/tmOSaAnxRlw==
X-Received: by 2002:a17:902:cec4:b0:223:4d5e:7592 with SMTP id d9443c01a7336-225c66cbf5emr89034945ad.21.1741964471781;
        Fri, 14 Mar 2025 08:01:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888653sm29611615ad.22.2025.03.14.08.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 08:01:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <899edff7-eba1-49fb-9626-576798452f30@roeck-us.net>
Date: Fri, 14 Mar 2025 08:01:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (acpi_power_meter) Replace the deprecated
 hwmon_device_register
To: Huisong Li <lihuisong@huawei.com>, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, liuyonglong@huawei.com
References: <20250314081834.3243243-1-lihuisong@huawei.com>
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
In-Reply-To: <20250314081834.3243243-1-lihuisong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/25 01:18, Huisong Li wrote:
> When load this mode, we can see the following log:
> "power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please
>   convert the driver to use hwmon_device_register_with_info()."
> 
> So replace hwmon_device_register with hwmon_device_register_with_info.
> 
> These attributes, 'power_accuracy', 'power_cap_hyst', 'power_average_min'
> and 'power_average_max', should have been placed in hwmon_chip_info as
> power data type. But these attributes are displayed as string format on
> the following case:
> a) power1_accuracy  --> display like '90.0%'
> b) power1_cap_hyst  --> display 'unknown' when its value is 0xFFFFFFFF
> c) power1_average_min/max --> display 'unknown' when its value is
> 			      negative.
> To avoid any changes in the display of these sysfs interfaces, we can't
> modifiy the type of these attributes in hwmon core and have to put them
> to extra_groups.
> 
> Please note that the path of these sysfs interfaces are modified
> accordingly if use hwmon_device_register_with_info():
> old: all sysfs interfaces are under acpi device, namely,
>       /sys/class/hwmon/hwmonX/device/
> now: all sysfs interfaces are under hwmon device, namely,
>       /sys/class/hwmon/hwmonX/
> The new ABI does not guarantee that the underlying path remains the same.
> But we have to accept this change so as to replace the deprecated API.
> Fortunately, some userspace application, like libsensors, would scan
> the two path and handles this automatically. So to drop the deprecated
> message, we can accept this change.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/hwmon/acpi_power_meter.c | 861 +++++++++++++++----------------
>   1 file changed, 427 insertions(+), 434 deletions(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index f05986e4f379..46e8a0b6b210 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
...
> +
> +// depend on POWER_METER_CAN_TRIP

Please di not intermix C++ comments with a driver using C comments.

> +static DEVICE_ATTR_RW(power1_average_max);
> +static DEVICE_ATTR_RW(power1_average_min);
> +
> +// depend on POWER_METER_CAN_CAP
> +static DEVICE_ATTR_RO(power1_cap_hyst);
> +
> +// depend on POWER_METER_CAN_MEASURE
> +static DEVICE_ATTR_RO(power1_accuracy);
> +static DEVICE_ATTR_RO(power1_is_battery);
> +
> +static DEVICE_ATTR_RO(power1_model_number);
> +static DEVICE_ATTR_RO(power1_oem_info);
> +static DEVICE_ATTR_RO(power1_serial_number);
> +
> +#define EXTRA_FIRST_DYNAMIC_ATTR_ID	3
> +#define EXTRA_ATTR_MAX	10
> +
> +static struct attribute *power_extra_attrs[EXTRA_ATTR_MAX] = {
> +	&dev_attr_power1_model_number.attr,
> +	&dev_attr_power1_oem_info.attr,
> +	&dev_attr_power1_serial_number.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(power_extra);
> +
> +static void fill_extra_dynamic_attr(struct attribute *attr)
> +{
> +	int idx = EXTRA_FIRST_DYNAMIC_ATTR_ID;
> +
> +	for (idx = EXTRA_FIRST_DYNAMIC_ATTR_ID; idx < EXTRA_ATTR_MAX; idx++) {
> +		if (!power_extra_attrs[idx])
> +			break;
> +	}
> +
> +	power_extra_attrs[idx] = attr;
> +}
> +

Please use the .is_visible() callback in attribute_group to determine
attribute visibility.

That means you'll have to code attribute_group manually, but that is
still better than re-implementing the is_visible() callback.
Something like

static const struct attribute_group power_extra_group = {
	.attrs = power_extra_attrs,
	.is_visible = power_extra_is_visible;
};

__ATTRIBUTE_GROUPS(power_extra);

should do.

Thanks,
Guenter


