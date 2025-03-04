Return-Path: <linux-kernel+bounces-544572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56B3A4E2B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A2B885856
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B36427FE69;
	Tue,  4 Mar 2025 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoSkIJf9"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37F27F4EE;
	Tue,  4 Mar 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100649; cv=none; b=rh3mJ4XpozVxDJQWa1jl7D2k0IyTU43qUYyznXAdL7nE8BAb98GMJaUV+sdDz9TdOK+IdPZgBPdaD39XOFdHFlfe41H8UpTj37Dv3UjMm2BGBZABX1T/S1qcrDJdtiD3WOj1PpqE8/fOqjtVE0tDtGeu0lTW/fqZOrfGqwrK0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100649; c=relaxed/simple;
	bh=smWbqg8U2xiB2fxpwWIjWqn8gf/WlfjfAXbWI6g3TUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hx7ESQp/2o7OFh4a7skD2sGmB8RAg/Pb/2fJa1ZoK+MyFvm8fK8EKH96VmPZMkXFu9edXdpo/JroC1yNIo3ecpXu8i/yZPiGYqZh5wq15q9JunQJVmvEo6nAuNVforknUX18RvGcmq6YRJaT7H6SoRXi48nS91XWod+CjVngY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoSkIJf9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso3500665a91.1;
        Tue, 04 Mar 2025 07:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741100647; x=1741705447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RGSgPOjUdjWVUkak51gMxwQnYY3XKB5C5+M6wHBRJPU=;
        b=BoSkIJf9U4k3Do4jWrsF/vC2J/wmyxkxPw6V4HJnhdjThdXhX5/uEmaFbvIPGLHRlV
         W+W+9auwOSB4Ettuxlf5V9gWTSjZD+qEKjjBrsDU3At0VVFg5xb3kIX8HafiYNGw0317
         xALIMSOv/ESfcsUuPGLsp7CkNyOJGcQA4ZiSVbHok5TyhQ2psZE54TiCggaMo4zZ5QMV
         fl6o3d6DDH8VEevzVG95tqTGbmCsONM11hgD+321S11HEs6loFST8CgMZc6jPqS+YhL0
         G0E5CxQbUrsiaQF1Py5uMmegkEvgEWEj1nyLlVIteHQDiyvnxZM4kRRXYzJPJ4lbUPWY
         AsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100647; x=1741705447;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGSgPOjUdjWVUkak51gMxwQnYY3XKB5C5+M6wHBRJPU=;
        b=q2DASSc3uFf7jAFqP4pnAy0FMNwJoLc6hPAttYqp51BuJwqwZT488ugw9lkkCQM0LT
         4QHC9rsHz1V18JCmCb3DWMEn57p/BSpaJdd/8Pe1DrDIW9hDd120Fze3WnwU6fouY8Vo
         D16s1BZPfPfTJgBGLIDlewVHZTMxC8xfh+zy5WykkPVfQb34KS9CoKHdtmEq5QJScl3A
         r7Y4PjZvB3k0ZcG2E8gGTEa6bwost+rgjiCIX9F5dDHD6+x8bV/jfFzuslA2aXuVCeRQ
         Z+32EPGVUHtlQMp7A9ZxPzEjWeZVopYKJKXk2/NoD8iCi0rXObubDKC5/aXRr5uf/wM6
         nALQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwOAIIXuNN+5QcW6xPW3shAhqsomsO8PvhOtkGjp1XUqCC5dcdyTwqnmkLdthdIpTVMdxArXQDE9mKHpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+QUeWZvgH5PCMrG3rDB2b+s2Fo7O/QhNQShzoO5yTlo3pxSj
	58p55fXRa9J7Wm3D+eAfaph85Xss0dhgtJCfFD6rI0j0Tj+eRZmr
X-Gm-Gg: ASbGncv+sa3/aH9SEI+LTRjMpnxjlEBI0u2EeJDhorK1JScSijVue3uMXch/jSrdxGS
	s1to+QzJ3y6mPKiRhASwNoCEfJ9Y4Vo5XC6SqNyM+k8XQvgYktKJ0Q3Ykp7uh/qcHuznJcZza+O
	hdoaRePZTwTPM3AYVzHWfawRAgLze/BeGpkSXlil3d5VVbaYfmMegN66IwNkFzNkQ6YgMB1leZZ
	tjdoZlSs3kD2fNFFbnL3yP7FYmYje2N1vDiCt2TVm5LZYJ2uhwmVOFKQ9nOYXGzN4IYkqtNSFBI
	8Y4Su2QBb/RXNFRW3r8J5qp2NB8MyizWc8rzNK+hAh6xP+t7RY2i2C4y4sWSB9Y8dyipQ1aPbPn
	vYIkJuOCEbIAgvVwrHg==
X-Google-Smtp-Source: AGHT+IG4rIwcHAcKZzAUK5cNqSizVekBWhDBKwebpTqf6cSVHgCb+yGGn88fNTd45L3fL5f9M2gg0w==
X-Received: by 2002:a17:90b:4c51:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2ff33bd5cc8mr5840171a91.14.1741100646828;
        Tue, 04 Mar 2025 07:04:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff35966689sm963341a91.0.2025.03.04.07.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:04:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <184d5217-149f-4f6a-b4a6-f897a8391873@roeck-us.net>
Date: Tue, 4 Mar 2025 07:04:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (ntc_thermistor) return error instead of clipping
 on OOB
To: maudspierings@gocontroll.com, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304-ntc_oob-v1-1-600d8992478d@gocontroll.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250304-ntc_oob-v1-1-600d8992478d@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 06:10, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> When the ntc is reading Out Of Bounds instead of clipping to the nearest
> limit (min/max) return -ENODATA. This prevents malfunctioning sensors
> from sending a device into a shutdown loop due to a critical trip.
> 
> This implementation will only work for ntc type thermistors if a ptc
> type is to be implemented the min/max ohm calculation must be adjusted
> to take that into account.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
> This patch is a continuation of another discussion [1]. I felt like it
> should be a new patch, not a v2 as this is a very different change.
> 
> I have left the clamping of n to INT_MAX in the code with a comment, but
> it may be possible to find a better solution to it. One I thought of is
> to make the ohm field of the ntc_compensation struct a signed int as
> well. It would get rid of this weird edge case, but it doesn't make
> sense to allow for negative resistances to be entered into the sensor
> table.
> 
> Currently the only feedback this provides to the user is when they
> manually try to read the temperature and it returns the error. I have
> added a simple printk to these error points to see how spammy it gets
> and this is the result:
> 
> dmesg | grep hwmon
> [    4.982682] hwmon: sensor out of bounds
> [    5.249758] hwmon: sensor out of bounds
> [    5.633729] hwmon: sensor out of bounds
> [    6.215285] hwmon: sensor out of bounds
> [    7.073882] hwmon: sensor out of bounds
> [    7.486620] hwmon: sensor out of bounds
> [    8.833765] hwmon: sensor out of bounds
> [   10.785969] hwmon: sensor out of bounds
> [   13.793722] hwmon: sensor out of bounds
> [   16.761124] hwmon: sensor out of bounds
> [   17.889706] hwmon: sensor out of bounds
> [   25.057715] hwmon: sensor out of bounds
> [   35.041725] hwmon: sensor out of bounds
> [   50.110346] hwmon: sensor out of bounds
> [   72.945283] hwmon: sensor out of bounds
> [  105.712619] hwmon: sensor out of bounds
> [  154.863976] hwmon: sensor out of bounds
> [  164.937104] hwmon: sensor out of bounds
> [  228.590909] hwmon: sensor out of bounds
> [  315.365777] hwmon: sensor out of bounds
> [  464.718403] hwmon: sensor out of bounds
> [  615.079123] hwmon: sensor out of bounds
> [  764.496780] hwmon: sensor out of bounds
> 
> This is with polling-delay set to 1000, it seems to rate-limit itself?
> But I feel there should be a better way to communicate the potential
> sensor failure to the user, but I can't think of anything.
> 

Hmm ... we could add "fault" attributes and report a sensor fault
if uv == 0 or uv >= puv, together with the -ENODATA temperature reading.
That could distinguish the fault from the "resistor value out of range" case.

> [1]: https://lore.kernel.org/all/20250304-ntc_min_max-v1-1-b08e70e56459@gocontroll.com/

Most of the above should be after "---" since it is irrelevant for the commit log.

> ---
>   drivers/hwmon/ntc_thermistor.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 0d29c8f97ba7c2f264588b6309b91ca494012ad6..311a60498d409ea068a18590415b2d5b43e73eb1 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -387,12 +387,9 @@ static int get_ohm_of_thermistor(struct ntc_data *data, unsigned int uv)
>   	puo = data->pullup_ohm;
>   	pdo = data->pulldown_ohm;
>   
> -	if (uv == 0)
> -		return (data->connect == NTC_CONNECTED_POSITIVE) ?
> -			INT_MAX : 0;
> -	if (uv >= puv)
> -		return (data->connect == NTC_CONNECTED_POSITIVE) ?
> -			0 : INT_MAX;
> +	/* faulty adc value */
> +	if (uv == 0 || uv >= puv)
> +		return -ENODATA;
>   
>   	if (data->connect == NTC_CONNECTED_POSITIVE && puo == 0)
>   		n = div_u64(pdo * (puv - uv), uv);
> @@ -404,6 +401,16 @@ static int get_ohm_of_thermistor(struct ntc_data *data, unsigned int uv)
>   	else
>   		n = div64_u64_safe(pdo * puo * uv, pdo * (puv - uv) - puo * uv);
>   
> +	/* sensor out of bounds */
> +	if (n > data->comp[0].ohm || n < data->comp[data->n_comp-1].ohm)
> +		return -ENODATA;
> +
> +	/*
> +	 * theoretically data->comp[0].ohm can be greater than INT_MAX as it is an
> +	 * unsigned integer, but it doesn't make any sense for it to be so as the
> +	 * maximum return value of this function is INT_MAX, so it will never be
> +	 * able to properly calculate that temperature.
> +	 */
>   	if (n > INT_MAX)
>   		n = INT_MAX;

I am not a friend of theoretic code or comments like this. Please drop.
The original code was intended to catch out-of-bounds values which would
otherwise have been reported as error, not to catch unrealistic resistor
values in the compensation tables.

Thanks,
Guenter


