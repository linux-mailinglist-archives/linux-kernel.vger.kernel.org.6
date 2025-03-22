Return-Path: <linux-kernel+bounces-572553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A4A6CB5D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 17:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424D417EA5F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497022F392;
	Sat, 22 Mar 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCaG7S53"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0FB137923;
	Sat, 22 Mar 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742659576; cv=none; b=t1hsqmOGNZ2Pv5Tzed2+0Q6cYsL/QfN7rLvRORqBZURANSWXsL1UXXY8Lm4uoxJdyi6djAQyzdfQaGASh/t4SmjXcKIYr+//rIr8ZmWC/Qo+TlGlB9Wesh611/vxi+oOGPKqYXp0Yrc1RxFHufrT38jZNW2Pfv1koJxuGqm2ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742659576; c=relaxed/simple;
	bh=dbdQwyvphXuExkL/c1dTdWHb6ZTyIyn2zmq2K0XguOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebUY3lbwa3reQPgJCA/g7k7LzBTlbufz6Hr+YfyRU3LiWtsKyhL1jwQ5oEH8SPGFHCIG5VAqdb9Xtgqrnz+lWAqCrgPGJPfchBkK0OY5QI+e4lz22iHHavMuMKp/+7qz1aicYJIgz1ml1a4YPTFb0Qm3lmBXHI/+Qh+ODr0x6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCaG7S53; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fb0f619dso62112575ad.1;
        Sat, 22 Mar 2025 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742659574; x=1743264374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NwqWoBDMZJvpzZ7us8+VfOO19kDyN06FFsnMhV0YC6A=;
        b=jCaG7S5337CRETXSE76ehbkfsgKbi5B7NtKpYQ4uOcACcYtf+omNI+uWg3cC65hKYr
         zcnDGmd+zMLXdvQGhjmPJZqWDny+CGtJ/YPLavmOhUfpnwYF73RGl0dFakxmibmSDTpm
         oosC3q1ujLPVXEMf1g5DPbXpOlVN/jU8WzaOOTnmEU7zdbUD96/N9mgUvIAzPJGAuhdv
         +rI0o80n4uuenMvHvIrg86X0SIQJsWQOnInU3j1jkkGEAigb35khnRov5h5+qQrnq/43
         ++c4TxNm+U6AudPACIOYJGw3CLAmPrihazZSfku2fQJXQfXLjn+D/Xj00/LajYR2nZh+
         jnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742659574; x=1743264374;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwqWoBDMZJvpzZ7us8+VfOO19kDyN06FFsnMhV0YC6A=;
        b=IP5nNuTkImEEzwT6WwJPU3ZhNi+Y0q5mH9FpF9RQOhosFRcwizzryQc8b27PIWIssP
         ltNKcMWNPvbwZvf+p+piGPRoaCiAJnNjSDdVzfII8skFid4x4nftXSYSJ50JyiWUrpay
         FBWqSahXrLFsfOaFy+NJZWOdCNHv4Xf5U5TxdoySJHdKwa9n5bGlNA2+dqYfyj5hn/a7
         oZZBft4AGMsLP0E1bDXIW+BVGfCsOkIJm1GCjkVsYKDDt04RHuX/qQl9jGnIJTeS2fP7
         sDgUgIdlowjxi3im2ni+cJLiKFaf9K5KfAO7QTcVVaahwzx+/IsudMw+ON/SNvwZOQ5M
         xJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGbgVXuled4OQz71kBM6z8MzmViG2LzMyXxUIXWPfCZGleksQ0d5YT5EHhpAS8yQN8d3rGGfBAwus/WQ==@vger.kernel.org, AJvYcCXyFmOuIvEAmMRPqCOhjRgljaibjmu/DxbvH0so+z0IyBE9JwpPfCYHmfctIfe+FlREkBDQ9LrURIGA3cpk@vger.kernel.org
X-Gm-Message-State: AOJu0YyHk1hcoBoABy1monyPGvtpZbjHhe2hlo0RIMM/opWyLz5PZ7lL
	WcXRKb0QL8Mz6R/Trn/aJIlAioxZkAkQxsFq39MDPAuOcYelvy8C0qvaXA==
X-Gm-Gg: ASbGncuOjF6rXq2bg/Ric3CLwekQalORPjC+or9IJOE3PGdRZoSD8vV48WzYD59ch07
	EsdMk4f3GqJxFz2A7GEh7tWF0dMN0rw+cwVyCNfgCWrONczJAmKJ1yVM1+GnUkYHSoyCbG6xxuc
	wcb8UHOtLKN3rcAYU1jcOLUohqGFJ1KUOS30hxJwz3rrmRghKTKC41sIqfeHN57LElO2W3Byb82
	lQw5thANcmzyWsp1G6t4yRy82K3kAL98a9CDJEK/93Cb+M18YCgzJJ6IiZvku2rote2UNj6xwH4
	gYxNKJBpaqJWJsFpC9pKH2vbBpRknMIYCAebV+k++cE+wKc49ORDi0grhe8qsf7PMIOS/CE8rBX
	IF+mRqrLpnZAFjbyq4Q==
X-Google-Smtp-Source: AGHT+IFXugbBXBczmWRmGl4feG49YIQJiZ7AHHntNMJ2oMLxtpYdoKHM1YK2Dd8hyVCjdXq0YRE5nQ==
X-Received: by 2002:a05:6a21:b92:b0:1f3:4427:74ae with SMTP id adf61e73a8af0-1fe42f58575mr12241760637.25.1742659573391;
        Sat, 22 Mar 2025 09:06:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73906186433sm4183301b3a.159.2025.03.22.09.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 09:06:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6465be6e-432f-4b58-8dd0-508369bb7f7a@roeck-us.net>
Date: Sat, 22 Mar 2025 09:06:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (cros_ec) Add set and get target fan RPM
 function
To: Sung-Chi Li <lschyi@chromium.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>,
 Jean Delvare <jdelvare@suse.com>, Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250318-extend_ec_hwmon_fan-v3-1-4c886385861f@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/25 00:45, Sung-Chi Li wrote:
> The ChromeOS embedded controller (EC) supports closed loop fan speed
> control, so add the fan target attribute under hwmon framework, such
> that kernel can expose reading and specifying the desired fan RPM for
> fans connected to the EC.
> 
> When probing the cros_ec hwmon module, we also check the supported
> command version of setting target fan RPM. This commit implements the
> version 0 of getting the target fan RPM, which can only read the target
> RPM of the first fan. This commit also implements the version 1 of
> setting the target fan RPM to each fan respectively.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> ---
> ChromeOS embedded controller (EC) supports closed-loop fan control. We
> anticipate to have the fan related control from the kernel side, so this
> series register the HWMON_F_TARGET attribute, and implement the read and
> write function for setting/reading the target fan RPM from the EC side.
> ---
> Changes in v3:
> - Drop support of v0 setting target fan RPM, thus also simplify
>    implementations.
> - Align coding style to existing code, including using if-else rather
>    than switch-case, and ensure little endian conversion from read data.
> - Only log warning for failed probing get fan target command version
>    instead of fail the whole driver.
> - Link to v2: https://lore.kernel.org/r/20250317-extend_ec_hwmon_fan-v2-1-13670557afe5@chromium.org
> 
> Changes in v2:
> - Squash the read, write, and register of fan target attribute to 1
>    commit, as they are the same topic.
> - Probe the supported command version from EC for setting the target fan
>    RPM, and perform the set fan target RPM based on the supported
>    version.
> - Update the used variable type to kernel types (i.e., u32).
> - Link to v1: https://lore.kernel.org/r/20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org
> ---
>   drivers/hwmon/cros_ec_hwmon.c | 90 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 85 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> index 9991c3fa020ac859cbbff29dfb669e53248df885..d54fd85ccb4350fc297bde62a2d98f386ce1a8de 100644
> --- a/drivers/hwmon/cros_ec_hwmon.c
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -21,6 +21,7 @@ struct cros_ec_hwmon_priv {
>   	struct cros_ec_device *cros_ec;
>   	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
>   	u8 usable_fans;
> +	int set_fan_target_rpm_version;
>   };
>   
>   static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> @@ -36,6 +37,21 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
>   	return 0;
>   }
>   
> +static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec,
> +					 u32 *speed)
> +{
> +	struct ec_response_pwm_get_fan_rpm r;
> +	int ret;
> +
> +	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM, NULL, 0,
> +			  &r, sizeof(r));
> +	if (ret < 0)
> +		return ret;
> +
> +	*speed = le32_to_cpu((__force __le32)r.rpm);
> +	return 0;
> +}
> +
>   static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
>   {
>   	unsigned int offset;
> @@ -52,6 +68,31 @@ static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8
>   	return 0;
>   }
>   
> +static int cros_ec_hwmon_set_fan_rpm(struct cros_ec_device *cros_ec, u8 index,
> +				     u16 val)
> +{
> +	struct ec_params_pwm_set_fan_target_rpm_v1 req = {
> +		.rpm = val,
> +		.fan_idx = index,
> +	};
> +	int ret;
> +
> +	ret = cros_ec_cmd(cros_ec, 1, EC_CMD_PWM_SET_FAN_TARGET_RPM, &req,
> +			  sizeof(req), NULL, 0);
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}
> +
> +static int cros_ec_hwmon_write_fan(struct cros_ec_hwmon_priv *priv, u32 attr,
> +				   int channel, long rpm)
> +{
> +	if (attr == hwmon_fan_target)
> +		return cros_ec_hwmon_set_fan_rpm(priv->cros_ec, channel, rpm);
> +	else

Static analyzers will report lots of "else after return is unnecessary"
with this code, and they do have a point.

Guenter


