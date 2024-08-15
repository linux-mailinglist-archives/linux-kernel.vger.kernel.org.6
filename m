Return-Path: <linux-kernel+bounces-288729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E22953E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6EA28623A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F0D156F36;
	Thu, 15 Aug 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+hcbsPl"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800717DA72;
	Thu, 15 Aug 2024 23:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765595; cv=none; b=UlVFbOOJZb8bTEyiYZDipUC+ZotZXUoxXk6u0NtQ2RYZfh20ZHf94LOa1yuhmqA8XH2ELqdgHz1Mt7siCA+I5QweRc4Zs/yVy1dKcut6zzJ8xayNSxR7gdm08NPn/UgXmPUPby3sbLScjrdOX8y/xgK7SKprx5edrzecU1gnDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765595; c=relaxed/simple;
	bh=UypffM/ataDg7Y8j0/0ZmFHKwpR6WulK5JnNM4dWpiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ecefk1NCEDpK6Lk2Lm4+ONpuh7pcSwT2b3NvySA45lmIYevMPtUofxva+HcL8no2QCjAJfvg9xF6fM/mh0yCEQD3Id4xGfSJIJOB4wGSc48EsZcZwUHCdUJrStcuUG/llXDplu0YaSkrXlawG8iHK6GrhhqNVe06ENkR/l7OjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+hcbsPl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-710dc3015bfso1017855b3a.0;
        Thu, 15 Aug 2024 16:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723765592; x=1724370392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VSqTcJqmeywUgvtkABy91Der4TUsn/N0bQq+9rc+yEc=;
        b=d+hcbsPlI8z/uCVLAOfDXBR52v3W9YHeF9C6l1mnYrvH/lco97NrfypRrTzh1iAaNQ
         CVIwmW2TOGSnUqVupl1CzXY1vV2140iuyVmU8yNleJe3cq/8F5LVpqDNoWWfb1EbrTKG
         CYX8UoMBG9hVcdvH3ZzCxsInUtX4hDtnQtCrVzA4NpDhQ1DJjsyp80YWWWIyS5AIhR4v
         TgbAOs1vCTj8VhWROmK2HaOMwA07/ltLWzcFT1rQ2xLKT5bWfuw1AY8G4J7I9mvsMJLH
         FpcFSGcCV15iu9AlqI3z91Q0Xm6xerJ3NGOHOYYBCL0SuTXu2/1gWj2MMnQKwXMltCLa
         2qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723765592; x=1724370392;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSqTcJqmeywUgvtkABy91Der4TUsn/N0bQq+9rc+yEc=;
        b=Mw6Q6xQPdSI8ExfuKQqyIGX+8SzKX+hRA37tz7JO+xSBumIzqLfd2WGizTsepD8F80
         N4ZwVAgK9AfEfKQF/k5G2LrU4dGxmb8S1Qdt+I0aFSid67jBP3PW9kJ/IcRzc1FslbJf
         AN9faN0Xn3wV9YHq1/DpRHttT7JO/RyQ3YIG3xGgqKX1DqlV1+ZI364bbtnBZOwHs5AQ
         qijQ/aXbVIwB3taVrV3a5AQ6WHfjHdJuaxbePl4TOCw1qzcOcIrtvF4fgODei6y4pQeh
         iT38zDxbr7oNUadGgzkT856TstDcf/e9fba8ZxtjBecAI5t4UyRPRqoVYcAj0obYoEi/
         /ECg==
X-Forwarded-Encrypted: i=1; AJvYcCXXgdoV3DRWDSMksmL6KLe1P0yXG9LY1MVnU+6aHF/jM9jk6Eig3eW3N4la7k5A7k2270nEm3x0K+DD1QDpnU6WfzrDlVHnn+HHA5OD4GpLVA13MbGQeQIyFtiKs+I1rIK9W9Gc1R3HAyvIa8eCz2cyyqeV5GekVwU3mny8GOiSwlTLQts=
X-Gm-Message-State: AOJu0Yxngd4HGNxK0+HXT1lwpz85/fbrsdKSx9XFdfN2Z08WEDSudF0F
	kTLeYgq0GQLexMjax+PZx+PPlN2SiupkpLNqenIvV2bx1XWUNY0Y
X-Google-Smtp-Source: AGHT+IHB3+OT5r6Bbcdg/uwz8g2F9mizusqd31IzuPqQeuXpoEL8V5EWen10sdYeYOGoZYTKAu6Etw==
X-Received: by 2002:a05:6a00:992:b0:712:7512:add9 with SMTP id d2e1a72fcca58-713c66e4e34mr1328755b3a.13.1723765591467;
        Thu, 15 Aug 2024 16:46:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef6eeesm1542708b3a.118.2024.08.15.16.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 16:46:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7f71ae23-80b0-42b2-a74a-d8bd9372783a@roeck-us.net>
Date: Thu, 15 Aug 2024 16:46:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hwmon: (oxp-sensors) Add support for multiple new
 devices.
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240815031358.21027-1-derekjohn.clark@gmail.com>
 <20240815031358.21027-2-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240815031358.21027-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 20:12, Derek J. Clark wrote:
> Add support for the OrangePi NEO-01. It uses different registers for PWM
> manual mode, set PWM, and read fan speed than previous devices. Valid PWM
> input and duty cycle is 1-244, we scale this from 1-255 to maintain
> compatibility with the existing interface.
> 
> Add OneXPlayer 2 series and OneXFly models. The 2 series uses a new
> register for turbo button takeover. While at it, adjust formatting of some
> constants and reorders all cases alphabetically for consistency. Rename
> OXP_OLD constants to OXP_MINI for disambiguation.
> 
> Adds support for AYANEO models 2S, AIR 1S, Flip DS, Flip KB, GEEK 1S, and
> KUN.
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   Documentation/hwmon/oxp-sensors.rst |  33 ++--
>   drivers/hwmon/oxp-sensors.c         | 273 +++++++++++++++++++++++++---
>   2 files changed, 267 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 50618f064379..7b2a2b5d6e80 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -10,14 +10,12 @@ Authors:
>   Description:
>   ------------
>   
> -Handheld devices from One Netbook and Aya Neo provide fan readings and fan
> +Handheld devices from OneNetbook and AYANEO provide fan readings and fan
>   control through their embedded controllers.
>   
> -Currently only supports AMD boards from One X Player, AOK ZOE, and some Aya
> -Neo devices. One X Player Intel boards could be supported if we could figure
> -out the EC registers and values to write to since the EC layout and model is
> -different. Aya Neo devices preceding the AIR may not be supportable as the EC
> -model is different and do not appear to have manual control capabilities.
> +Currently supports OneXPlayer AMD devices, AOKZOE, AYANEO, and OrangePi
> +handheld devices. AYANEO devices preceding the AIR are not be supportable
> +as the EC model is different and do not have manual control capabilities.
>   
>   Some models have a toggle for changing the behaviour of the "Turbo/Silent"
>   button of the device. It will change the key event that it triggers with
> @@ -31,20 +29,33 @@ Currently the driver supports the following handhelds:
>   
>    - AOK ZOE A1
>    - AOK ZOE A1 PRO
> - - Aya Neo 2
> - - Aya Neo AIR
> - - Aya Neo AIR Plus (Mendocino)
> - - Aya Neo AIR Pro
> - - Aya Neo Geek
> + - AYANEO 2
> + - AYANEO 2S
> + - AYANEO AIR
> + - AYANEO AIR 1S
> + - AYANEO AIR Plus (Mendocino)
> + - AYANEO AIR Pro
> + - AYANEO KUN
> + - AYANEO Geek
> + - AYANEO Geek 1S
> + - AYANEO Flip DS
> + - AYANEO Flip KB
> + - OneXPlayer 2
> + - OneXPlayer 2 Pro
>    - OneXPlayer AMD
>    - OneXPlayer mini AMD
>    - OneXPlayer mini AMD PRO
> + - OneXPlayer OneXFly
> + - OrangePi NEO-01
>   
>   "Turbo/Silent" button behaviour toggle is only supported on:
>    - AOK ZOE A1
>    - AOK ZOE A1 PRO
> + - OneXPlayer 2
> + - OneXPlayer 2 Pro
>    - OneXPlayer mini AMD (only with updated alpha BIOS)
>    - OneXPlayer mini AMD PRO
> + - OneXPlayer OneXFly
>   
>   Sysfs entries
>   -------------
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 8d3b0f86cc57..701d46fde943 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -42,10 +42,18 @@ static bool unlock_global_acpi_lock(void)
>   enum oxp_board {
>   	aok_zoe_a1 = 1,
>   	aya_neo_2,
> +	aya_neo_2s,
>   	aya_neo_air,
> +	aya_neo_air_1s,
>   	aya_neo_air_plus_mendo,
>   	aya_neo_air_pro,
> +	aya_neo_flip,
>   	aya_neo_geek,
> +	aya_neo_geek_1s,
> +	aya_neo_kun,
> +	orange_pi_neo,
> +	oxp_2,
> +	oxp_fly,
>   	oxp_mini_amd,
>   	oxp_mini_amd_a07,
>   	oxp_mini_amd_pro,
> @@ -54,21 +62,29 @@ enum oxp_board {
>   static enum oxp_board board;
>   
>   /* Fan reading and PWM */
> -#define OXP_SENSOR_FAN_REG		0x76 /* Fan reading is 2 registers long */
> -#define OXP_SENSOR_PWM_ENABLE_REG	0x4A /* PWM enable is 1 register long */
> -#define OXP_SENSOR_PWM_REG		0x4B /* PWM reading is 1 register long */
> +#define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 registers long */
> +#define OXP_SENSOR_PWM_ENABLE_REG      0x4A /* PWM enable is 1 register long */
> +#define OXP_SENSOR_PWM_REG             0x4B /* PWM reading is 1 register long */
> +#define PWM_MODE_AUTO                  0x00
> +#define PWM_MODE_MANUAL                0x01
> +
> +/* OrangePi fan eding and PWM */
> +#define ORANGEPI_SENSOR_FAN_REG        0x78 /* Fan reading is 2 registers long */
> +#define ORANGEPI_SENSOR_PWM_ENABLE_REG 0x40 /* PWM enable is 1 register long */
> +#define ORANGEPI_SENSOR_PWM_REG        0x38 /* PWM reading is 1 register long */
>   
>   /* Turbo button takeover function
> - * Older boards have different values and EC registers
> + * Different boards have different values and EC registers
>    * for the same function
>    */
> -#define OXP_OLD_TURBO_SWITCH_REG	0x1E
> -#define OXP_OLD_TURBO_TAKE_VAL		0x01
> -#define OXP_OLD_TURBO_RETURN_VAL	0x00
> +#define OXP_TURBO_SWITCH_REG           0xF1
> +#define OXP_2_TURBO_SWITCH_REG         0xEB /* OXP2 and OXP2 Pro */
> +#define OXP_MINI_TURBO_SWITCH_REG      0x1E /* Mini AO7 */
> +
> +#define OXP_TURBO_TAKE_VAL             0x40
> +#define OXP_MINI_TURBO_TAKE_VAL        0x01
>   
> -#define OXP_TURBO_SWITCH_REG		0xF1
> -#define OXP_TURBO_TAKE_VAL		0x40
> -#define OXP_TURBO_RETURN_VAL		0x00
> +#define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
>   
>   static const struct dmi_system_id dmi_table[] = {
>   	{
> @@ -92,6 +108,13 @@ static const struct dmi_system_id dmi_table[] = {
>   		},
>   		.driver_data = (void *)aya_neo_2,
>   	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 2S"),
> +		},
> +		.driver_data = (void *)aya_neo_2s,
> +	},
>   	{
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> @@ -99,6 +122,13 @@ static const struct dmi_system_id dmi_table[] = {
>   		},
>   		.driver_data = (void *)aya_neo_air,
>   	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
> +		},
> +		.driver_data = (void *)aya_neo_air_1s,
> +	},
>   	{
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> @@ -113,6 +143,13 @@ static const struct dmi_system_id dmi_table[] = {
>   		},
>   		.driver_data = (void *)aya_neo_air_pro,
>   	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
> +		},
> +		.driver_data = (void *)aya_neo_flip,
> +	},
>   	{
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> @@ -120,6 +157,27 @@ static const struct dmi_system_id dmi_table[] = {
>   		},
>   		.driver_data = (void *)aya_neo_geek,
>   	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GEEK 1S"),
> +		},
> +		.driver_data = (void *)aya_neo_geek_1s,
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "KUN"),
> +		},
> +		.driver_data = (void *)aya_neo_kun,
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "OrangePi"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "NEO-01"),
> +		},
> +		.driver_data = (void *)orange_pi_neo,
> +	},
>   	{
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> @@ -127,6 +185,34 @@ static const struct dmi_system_id dmi_table[] = {
>   		},
>   		.driver_data = (void *)oxp_mini_amd,
>   	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER 2 ARP23"),
> +		},
> +		.driver_data = (void *)oxp_2,
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER 2 PRO ARP23P"),
> +		},
> +		.driver_data = (void *)oxp_2,
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER 2 PRO ARP23P EVA-01"),
> +		},
> +		.driver_data = (void *)oxp_2,
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1"),
> +		},
> +		.driver_data = (void *)oxp_fly,
> +	},
>   	{
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> @@ -192,14 +278,19 @@ static int tt_toggle_enable(void)
>   
>   	switch (board) {
>   	case oxp_mini_amd_a07:
> -		reg = OXP_OLD_TURBO_SWITCH_REG;
> -		val = OXP_OLD_TURBO_TAKE_VAL;
> +		reg = OXP_MINI_TURBO_SWITCH_REG;
> +		val = OXP_MINI_TURBO_TAKE_VAL;
>   		break;
> -	case oxp_mini_amd_pro:
>   	case aok_zoe_a1:
> +	case oxp_fly:
> +	case oxp_mini_amd_pro:
>   		reg = OXP_TURBO_SWITCH_REG;
>   		val = OXP_TURBO_TAKE_VAL;
>   		break;
> +	case oxp_2:
> +		reg = OXP_2_TURBO_SWITCH_REG;
> +		val = OXP_TURBO_TAKE_VAL;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -213,14 +304,19 @@ static int tt_toggle_disable(void)
>   
>   	switch (board) {
>   	case oxp_mini_amd_a07:
> -		reg = OXP_OLD_TURBO_SWITCH_REG;
> -		val = OXP_OLD_TURBO_RETURN_VAL;
> +		reg = OXP_MINI_TURBO_SWITCH_REG;
> +		val = OXP_TURBO_RETURN_VAL;
>   		break;
> -	case oxp_mini_amd_pro:
>   	case aok_zoe_a1:
> +	case oxp_fly:
> +	case oxp_mini_amd_pro:
>   		reg = OXP_TURBO_SWITCH_REG;
>   		val = OXP_TURBO_RETURN_VAL;
>   		break;
> +	case oxp_2:
> +		reg = OXP_2_TURBO_SWITCH_REG;
> +		val = OXP_TURBO_RETURN_VAL;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -233,6 +329,8 @@ static umode_t tt_toggle_is_visible(struct kobject *kobj,
>   {
>   	switch (board) {
>   	case aok_zoe_a1:
> +	case oxp_2:
> +	case oxp_fly:
>   	case oxp_mini_amd_a07:
>   	case oxp_mini_amd_pro:
>   		return attr->mode;
> @@ -273,12 +371,16 @@ static ssize_t tt_toggle_show(struct device *dev,
>   
>   	switch (board) {
>   	case oxp_mini_amd_a07:
> -		reg = OXP_OLD_TURBO_SWITCH_REG;
> +		reg = OXP_MINI_TURBO_SWITCH_REG;
>   		break;
> -	case oxp_mini_amd_pro:
>   	case aok_zoe_a1:
> +	case oxp_fly:
> +	case oxp_mini_amd_pro:
>   		reg = OXP_TURBO_SWITCH_REG;
>   		break;
> +	case oxp_2:
> +		reg = OXP_2_TURBO_SWITCH_REG;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -295,12 +397,55 @@ static DEVICE_ATTR_RW(tt_toggle);
>   /* PWM enable/disable functions */
>   static int oxp_pwm_enable(void)
>   {
> -	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
> +	switch (board) {
> +	case orange_pi_neo:
> +		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL);
> +	case aok_zoe_a1:
> +	case aya_neo_2:
> +	case aya_neo_2s:
> +	case aya_neo_air:
> +	case aya_neo_air_plus_mendo:
> +	case aya_neo_air_pro:
> +	case aya_neo_flip:
> +	case aya_neo_geek:
> +	case aya_neo_geek_1s:
> +	case aya_neo_kun:
> +	case oxp_mini_amd:
> +	case oxp_mini_amd_a07:
> +	case oxp_2:
> +	case oxp_fly:
> +	case oxp_mini_amd_pro:
> +		return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL);
> +	default:
> +		return -EINVAL;
> +	}
>   }
>   
>   static int oxp_pwm_disable(void)
>   {
> -	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x00);
> +	switch (board) {
> +	case orange_pi_neo:
> +		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
> +	case aok_zoe_a1:
> +	case aya_neo_2:
> +	case aya_neo_2s:
> +	case aya_neo_air:
> +	case aya_neo_air_1s:
> +	case aya_neo_air_plus_mendo:
> +	case aya_neo_air_pro:
> +	case aya_neo_flip:
> +	case aya_neo_geek:
> +	case aya_neo_geek_1s:
> +	case aya_neo_kun:
> +	case oxp_mini_amd:
> +	case oxp_mini_amd_a07:
> +	case oxp_2:
> +	case oxp_fly:
> +	case oxp_mini_amd_pro:
> +		return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
> +	default:
> +		return -EINVAL;
> +	}
>   }
>   
>   /* Callbacks for hwmon interface */
> @@ -326,7 +471,29 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>   	case hwmon_fan:
>   		switch (attr) {
>   		case hwmon_fan_input:
> -			return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
> +			switch (board) {
> +			case orange_pi_neo:
> +				return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
> +			case aok_zoe_a1:
> +			case aya_neo_2:
> +			case aya_neo_2s:
> +			case aya_neo_air:
> +			case aya_neo_air_1s:
> +			case aya_neo_air_plus_mendo:
> +			case aya_neo_air_pro:
> +			case aya_neo_flip:
> +			case aya_neo_geek:
> +			case aya_neo_geek_1s:
> +			case aya_neo_kun:
> +			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
> +			case oxp_2:
> +			case oxp_fly:
> +			case oxp_mini_amd_pro:
> +				return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
> +			default:
> +				break;
> +			}
>   		default:
>   			break;
>   		}
> @@ -334,27 +501,66 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>   	case hwmon_pwm:
>   		switch (attr) {
>   		case hwmon_pwm_input:
> -			ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> -			if (ret)
> -				return ret;
>   			switch (board) {
> +			case orange_pi_neo:
> +				ret = read_from_ec(ORANGEPI_SENSOR_PWM_REG, 1, val);
> +				if (ret)
> +					return ret;
> +				/* scale from range [1-244] */
> +				*val = ((*val - 1) * 254 / 243) + 1;
> +				break;
>   			case aya_neo_2:
> +			case aya_neo_2s:
>   			case aya_neo_air:
> +			case aya_neo_air_1s:
>   			case aya_neo_air_plus_mendo:
>   			case aya_neo_air_pro:
> +			case aya_neo_flip:
>   			case aya_neo_geek:
> +			case aya_neo_geek_1s:
> +			case aya_neo_kun:
>   			case oxp_mini_amd:
>   			case oxp_mini_amd_a07:
> +				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +				if (ret)
> +					return ret;
>   				*val = (*val * 255) / 100;
>   				break;
> -			case oxp_mini_amd_pro:
>   			case aok_zoe_a1:
> +			case oxp_2:
> +			case oxp_fly:
> +			case oxp_mini_amd_pro:
>   			default:
> +				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +				if (ret)
> +					return ret;
>   				break;
>   			}
>   			return 0;
>   		case hwmon_pwm_enable:
> -			return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> +			switch (board) {
> +			case orange_pi_neo:
> +				return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
> +			case aok_zoe_a1:
> +			case aya_neo_2:
> +			case aya_neo_2s:
> +			case aya_neo_air:
> +			case aya_neo_air_1s:
> +			case aya_neo_air_plus_mendo:
> +			case aya_neo_air_pro:
> +			case aya_neo_flip:
> +			case aya_neo_geek:
> +			case aya_neo_geek_1s:
> +			case aya_neo_kun:
> +			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
> +			case oxp_2:
> +			case oxp_fly:
> +			case oxp_mini_amd_pro:
> +				return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> +			default:
> +				break;
> +			}

Subtle, but as 0-day reported there are some missing break;
statements. Please watch out for warnings seen when building
the driver.

Thanks,
Guenter


