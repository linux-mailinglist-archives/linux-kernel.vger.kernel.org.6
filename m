Return-Path: <linux-kernel+bounces-552162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3156A57663
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02FD178D22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1517B213E64;
	Fri,  7 Mar 2025 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdhZ+Plf"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEFE1537A7;
	Fri,  7 Mar 2025 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741391982; cv=none; b=BchzTgyTPGe9xdzrA+EbhF4FIMRev3bJJLydzwjRPNb+Tvmmk8YMKjarCv+dFE69Zxq/UHXNrpjpd3JQ0W+UpZPk1TjwK5Lb496VJGYrblZS73sxJ2etf9L3GfnQ3T9xLn+P/M/xpRyvDlSTbWy3O/TxtllmXoWp90sIRSbZDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741391982; c=relaxed/simple;
	bh=xEo9IjeY8zFNSParsf9ryYWh4+0RzNxgCcY58sTajEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqRDjij+9m0mSets8thb3ZtuoqwAho0mRFIymvsatZRGhO2zZGuleVjEL9wz4jo4pIyTZg+b/Cng1/726cKxIqN4u9EoV4KO4H2S+7s5QKSd7/YgYZhajf03M8C6Wz3dR76Axh8iwOictPX1ZSbTjrt4ODvlOVC1ysX5K3aifY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdhZ+Plf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22435603572so14435575ad.1;
        Fri, 07 Mar 2025 15:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741391980; x=1741996780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=m9H4sW6q11XuIRSEwaFMoNh2btthFL2UxzBBdgCXbbE=;
        b=bdhZ+PlfEGEWEAwrScoXJM5VKVA374fcc0KU4gf+ftxoEjuyM5dwPX2ZF9tTXmSTpy
         gGVyfhDGrWX3Jc/yBdr0KTFXM/A1HAlZgc9kqh0Zd1WFIXzlsqtWRRGN9Ktl81/DDN8W
         6DYt8ZKOd/rdr+4b0iGGnNLyMRzwrLgG/O8yQlVYafc9XbuLtgGuyBCGA+6IgbRdCHmk
         Z5+Yk+3KrXKXmI+rymM1WmKYz1OFniWZpKGOYwQx9mvz4c2F8cRdSO8wM1gCAXel1Pay
         rwr4pHKYbnb6gtlPGaLJlkcOvp1w2naunF3rnhxOxZzHJWn7e0/MXpiS8DSRPRgsGloU
         INeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741391980; x=1741996780;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9H4sW6q11XuIRSEwaFMoNh2btthFL2UxzBBdgCXbbE=;
        b=pyoFCnRphOcwDudo9l8p2IrGM1RGWyUcJ1UJuPgRVAih+Yt9Sye/Q/4NytqKzWnc4m
         2jP4/i61Q2mEEmfGr8OfuvvjMerlMnxD3AAvmA7RvI7IvItjZcLE0AXi+nPGBFzmJ9/h
         W37BCQJn3144QAXTgQJvENxyBGF39wF84r9rzisfsxxyGxYn/azZE9UN2w8jnzKJGYG8
         +09tl0j1mmxZnrcem1SMeNdgo7vhm/mogekjgpaaMfaBWlIbinMwuGeNJYbV7s+Bp/j2
         hE3KBhCk5+OVRNWKidT/tJJ48fDo2WUlYw/HxIA3akCToO1MXtanlHMbUs/mgp8MuXtB
         fT3w==
X-Forwarded-Encrypted: i=1; AJvYcCUId4jrG2od/lyjon/dMKMEa8jfvhXs+bQFUsKLyM+P40it47oz/qkqIaAco9seEegoh/+2WQV//LKh4duG@vger.kernel.org, AJvYcCUaR6/Lb+gBtX4UPcTaL/cMYNCsAnACWrEw3MGxWQf8hGykiBPpvHe4PyQUfcFSSXL24Wufg/Fq9aS6DA==@vger.kernel.org, AJvYcCUyTfhkjYCayaBA+5r8eM8jN3k9e6pMbaXcy6oO2SA/UmgUtT/WHHZxuaKVLnnLB1ZGWEmbA9lwSTmfVl37EBTZqRG8JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBFLjqXeki1m0Qn0SGLV8+Af+dBByxvjmYzpUDKyoGg3jeF7nN
	Scsad38d3WwbwMxdJoDps6uECsnazlfjN/Z0yCKNuV4U9EmojnSKyuBx7w==
X-Gm-Gg: ASbGncvdDfogUlfqlKo+pKhFz6/5RAHhB3s/o65Y0b6TWPb/y688Yz9CXURfgAPviAC
	uQDZ0F3FUu1dQcPj19yL0NjtqU1nELNzmCT5Jc5q9beMvg+zeOR7NPDCqjqSVEFAAVI71Phcm3C
	HqRbV0j9rImCz2gfo2RkCPiXonXvnQE/Rt/1ng6w2W+axUYioxufmYgBCYjKDtH8yoAt75ufQUs
	Bp7nv6UG8/gCeiuL522uI5uDQgA9cyxwC4bY9t31clGNrWiE8+9A+VZwEKoW+dAqxIBNZt67JN9
	hghtohkaJXGDlKC/+uJJe9K6mjsTiv+USu2CY72lMnFLOSixsCEmLPkmUWwE2JUC6jTRL1NqErd
	uBcfBXS0+mv8+4nxBzQ==
X-Google-Smtp-Source: AGHT+IE7g3VclGxqlW6zki6/rzwN2qrjsCULrK/EgLR0sf/EETDYJ5wuH9ueHxzhnjyRAapK7qjQRg==
X-Received: by 2002:a17:902:e745:b0:223:fabd:4f99 with SMTP id d9443c01a7336-22428886adcmr93125465ad.5.1741391979756;
        Fri, 07 Mar 2025 15:59:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410ab9b7fsm36240775ad.253.2025.03.07.15.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 15:59:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7c850374-8caa-430d-b114-1aaa944bbc89@roeck-us.net>
Date: Fri, 7 Mar 2025 15:59:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] platform/x86: alienware-wmi-wmax: Add HWMON
 support
To: Armin Wolf <W_Armin@gmx.de>, Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
 <20250305-hwm-v3-7-395e7a1407e2@gmail.com>
 <a375d474-5349-4662-8ce8-4f8f55349901@gmx.de>
 <D89M2ZQJEH45.1HKFFX5ESXRSJ@gmail.com>
 <7fbf0553-e6b3-4964-9210-8cd720ae9c9e@gmx.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7fbf0553-e6b3-4964-9210-8cd720ae9c9e@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/7/25 13:09, Armin Wolf wrote:
> Am 07.03.25 um 01:35 schrieb Kurt Borja:
...
>>>> +static const struct hwmon_ops awcc_hwmon_ops = {
>>>> +    .is_visible = awcc_hwmon_is_visible,
>>>> +    .read = awcc_hwmon_read,
>>>> +    .read_string = awcc_hwmon_read_string,
>>>> +};
>>>> +
>>>> +static const struct hwmon_channel_info * const awcc_hwmon_info[] = {
>>>> +    HWMON_CHANNEL_INFO(temp,
>>>> +               HWMON_T_LABEL | HWMON_T_INPUT,
>>>> +               HWMON_T_LABEL | HWMON_T_INPUT,
>>>> +               HWMON_T_LABEL | HWMON_T_INPUT,
>>>> +               HWMON_T_LABEL | HWMON_T_INPUT,
>>>> +               HWMON_T_LABEL | HWMON_T_INPUT,
>>>> +               HWMON_T_LABEL | HWMON_T_INPUT
>>>> +               ),
>>>> +    HWMON_CHANNEL_INFO(fan,
>>>> +               HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>>> +               HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>>> +               HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>>> +               HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>>> +               HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
>>>> +               HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
>>>> +               ),
>>>> +    HWMON_CHANNEL_INFO(pwm,
>>>> +               HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>> +               HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>> +               HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>> +               HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>> +               HWMON_PWM_AUTO_CHANNELS_TEMP,
>>>> +               HWMON_PWM_AUTO_CHANNELS_TEMP
>>>> +               ),
>>> Since the number of fans and temperature sensors is only known at runtime creating awcc_hwmon_info
>>> would make sense.
>> IIRC Guenter asked another dev to add more CHANNEL_INFO entries instead
>> of doing that? I might be wrong tho.
>>
>> I'm fine either way.
>>
> If Guenter is fine with your current approach then you can keep it.
> 

In drivers/hwmon, I prefer static descriptions such as the above and using
the is_visible() function to determine if sensor attributes should actually
be created. However, as I have mentioned several times, I do not comment on style
questions like this (or, for that matter, non-standard sysfs attributes) outside
drivers/hwmon, so you can do or request whatever you like.

Guenter


