Return-Path: <linux-kernel+bounces-302548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA37960016
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9065A1C21E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F2C225A2;
	Tue, 27 Aug 2024 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTcgRU4o"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2D11803D;
	Tue, 27 Aug 2024 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730978; cv=none; b=NkYNfKpswv9QBewBNibbjj0ICKk3kw8cx6qUrTHivemAzc1ziTCgXFdIJOQPfFZyiddpXImdN0SFlA0tRVaw0G3lN/Y/IdV3NU6LvjdKveSPC2DiW34kGyHFsBBaUJikB1GqwXYaZqlwjh4aotYxxyD640xK47pjhVG0u7jN+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730978; c=relaxed/simple;
	bh=6DEeCmkjXYSRDhXv0j6cx/jWXwYhbGUL2IfOUNuV/Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHou4s+pM6Dc7vAND4YMaHPAHdGv2rR8xzfvry206gMYl2svnfJkciS5f144vLuYyxOIWWvZFL4xGzdOdkDF011Bale/EuFF61+dDCve3V+TOrmII4NtyOPYfXmyYhME0uaFXGz0d26rP8ddQKQ8Ep/2Iluf89GA9uFuhJhfJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTcgRU4o; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so2204031a12.1;
        Mon, 26 Aug 2024 20:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724730975; x=1725335775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0kBnUF/rNu5L7bREwnC1KI/zQCygIz65RsnIZQb+vQ=;
        b=iTcgRU4o0dPgbJ8jwDBnq3m3yi16D7mYdwB+4a2yU159pQziXUUIA5Hu8px1NRBRv0
         NA4izkc5ToJ3XUfG2FckLW+Qv8cwRgTDZmDF+0A8nzC1j9MB6xcpuHcgrva9QveYWBPr
         xQgV8/Kzl6rV381RSrssmtGNhhlo3tozmyJzDNT0Xc+hNyT6G2bF9fVp1ntNlDwDNZW3
         q4aBFWvav/s7Xj4GN7qErT2kDe3jvRU94gpbOSRF4+Jh1jLPOVT5JNOk/zqRy0QCgCXE
         YdeDKs/6IFD7yT9llSmv6lAXVZHdanVEljg0jHHZH2/fCfc0dLqCpFtH6raH1KwxblC2
         9gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724730975; x=1725335775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0kBnUF/rNu5L7bREwnC1KI/zQCygIz65RsnIZQb+vQ=;
        b=LU09vsNgXDLY9QGcxAR+kclZyMHZ/lnZa5kX/3FSjwzyruwfjWzSfa4JKpuEujMx8f
         3iW6e+jlR/HIYrdWsXCGEwTnqXEwYW1cJCNzDKgD3DM7OPwXwqQhH74WQbX2nxmicCB+
         qM5wVZfgcXC2P2o4EVvAtDl15B9oz8IMbsMxoYs4JIKgxAW+OQjqgdBtkvh8Yyg1mrJ7
         QHbKOol3jTuPmMBhBXnXX6pZUfmzQaFT3kjI4284vfzlkA7kTVfnMPCAhmRhFDADe2ot
         btKYmfwY9aSUuK6cNRsPrxvf4JdOpdBrEr0Nhwg1aEG7+dWFhnkAQ98S3/NPcgoqsqf4
         +wJg==
X-Forwarded-Encrypted: i=1; AJvYcCVsKu2SaQKEMDm1NYkXpVyHlJ2c+pyrz/8+eYgELxUWPcbUmpLM9UqDYks40m4+R6Sn/paGLIN9hHJym6mf@vger.kernel.org, AJvYcCWzS5wgXeLuNbgPexRK5llQr/VqHFPFmU9jr6WTEDaV6BxUJpc/S5lupoN6fl7no/4qDb0UZZhV+UyLlXw=@vger.kernel.org, AJvYcCXGGgxbQrkXMEnPjmEMFLidSDAUO9MGfhqSwoJIq4AxKMgNXP1goUPtk63/n4DoaG2jfyH+OiTOH58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzasX5Fadd/Jtqg2FFxRoZkGJzJZn0fEIKJjaXCNbWg46zmAHVU
	ZODHui5+oBD7pu0RD5Y4pAKJn4nDiijw3teseCsuJd9zAhAjVfSQ
X-Google-Smtp-Source: AGHT+IHIoTYMbOfQoHKLVDcVUmP4M+JHVXN8CD2b3zJp/IBSDrMhI8JuiFGUblSX2P4KVHyi1A19HA==
X-Received: by 2002:a17:90b:1217:b0:2c9:63fb:d3ab with SMTP id 98e67ed59e1d1-2d824d11f20mr2544467a91.22.1724730974938;
        Mon, 26 Aug 2024 20:56:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d6124a9a16sm10680347a91.0.2024.08.26.20.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 20:56:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Aug 2024 20:56:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	=?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/1] Add support for multiple new devices.
Message-ID: <f57c0750-255f-461b-84f0-e958b074d404@roeck-us.net>
References: <20240822183525.27289-1-derekjohn.clark@gmail.com>
 <20240822183525.27289-2-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822183525.27289-2-derekjohn.clark@gmail.com>

On Thu, Aug 22, 2024 at 11:35:25AM -0700, Derek J. Clark wrote:
> Add support for the OrangePi NEO-01. It uses different registers for PWM
> manual mode, set PWM, and read fan speed than previous devices. Valid PWM
> input and duty cycle is 1-244, we scale this from 1-255 to maintain
> compatibility with the existing interface.
> 
> Add OneXPlayer 2 series, OneXFly, and X1 series models. The 2/X1 series use
> new registers for turbo button takeover and read fan speed. X1 has an Intel
> variant so change the CPU detection at init to only check for the affected
> devices. While at it, adjust formatting of some constants and reorder all
> cases alphabetically for consistency. Rename OXP_OLD constants to OXP_MINI
> for disambiguation. Update code comments for clarity.
> 
> Add support for AYANEO models 2S, AIR 1S, Flip series, GEEK 1S, and KUN.
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Tested-by: Kevin Greenberg <kdgreenberg234@protonmail.com>
> Tested-by: Joshua Tam <csinaction@pm.me>
> Tested-by: Parth Menon <parthasarathymenon@gmail.com>
> Tested-by: Philip Müller <philm@manjaro.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408160329.TLNbIwRC-lkp@intel.com/

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/oxp-sensors.rst |  54 +++--
>  drivers/hwmon/oxp-sensors.c         | 299 +++++++++++++++++++++++-----
>  2 files changed, 290 insertions(+), 63 deletions(-)
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 50618f064379..581c4dafbfa1 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -10,41 +10,59 @@ Authors:
>  Description:
>  ------------
>  
> -Handheld devices from One Netbook and Aya Neo provide fan readings and fan
> -control through their embedded controllers.
> +Handheld devices from OneNetbook, AOKZOE, AYANEO, And OrangePi provide fan
> +readings and fan control through their embedded controllers.
>  
> -Currently only supports AMD boards from One X Player, AOK ZOE, and some Aya
> -Neo devices. One X Player Intel boards could be supported if we could figure
> -out the EC registers and values to write to since the EC layout and model is
> -different. Aya Neo devices preceding the AIR may not be supportable as the EC
> -model is different and do not appear to have manual control capabilities.
> +Currently supports OneXPlayer devices, AOKZOE, AYANEO, and OrangePi
> +handheld devices. AYANEO devices preceding the AIR and OneXPlayer devices
> +preceding the Mini A07 are not supportable as the EC model is different
> +and do not have manual control capabilities.
>  
> -Some models have a toggle for changing the behaviour of the "Turbo/Silent"
> -button of the device. It will change the key event that it triggers with
> -a flip of the `tt_toggle` attribute. See below for boards that support this
> -function.
> +Some OneXPlayer and AOKZOE models have a toggle for changing the behaviour
> +of the "Turbo/Silent" button of the device. It will change the key event
> +that it triggers with a flip of the `tt_toggle` attribute. See below for
> +boards that support this function.
>  
>  Supported devices
>  -----------------
>  
>  Currently the driver supports the following handhelds:
>  
> - - AOK ZOE A1
> - - AOK ZOE A1 PRO
> - - Aya Neo 2
> - - Aya Neo AIR
> - - Aya Neo AIR Plus (Mendocino)
> - - Aya Neo AIR Pro
> - - Aya Neo Geek
> + - AOKZOE A1
> + - AOKZOE A1 PRO
> + - AYANEO 2
> + - AYANEO 2S
> + - AYANEO AIR
> + - AYANEO AIR 1S
> + - AYANEO AIR Plus (Mendocino)
> + - AYANEO AIR Pro
> + - AYANEO Flip DS
> + - AYANEO Flip KB
> + - AYANEO Geek
> + - AYANEO Geek 1S
> + - AYANEO KUN
> + - OneXPlayer 2
> + - OneXPlayer 2 Pro
>   - OneXPlayer AMD
>   - OneXPlayer mini AMD
>   - OneXPlayer mini AMD PRO
> + - OneXPlayer OneXFly
> + - OneXPlayer X1 A
> + - OneXPlayer X1 i
> + - OneXPlayer X1 mini
> + - OrangePi NEO-01
>  
>  "Turbo/Silent" button behaviour toggle is only supported on:
>   - AOK ZOE A1
>   - AOK ZOE A1 PRO
> + - OneXPlayer 2
> + - OneXPlayer 2 Pro
>   - OneXPlayer mini AMD (only with updated alpha BIOS)
>   - OneXPlayer mini AMD PRO
> + - OneXPlayer OneXFly
> + - OneXPlayer X1 A
> + - OneXPlayer X1 i
> + - OneXPlayer X1 mini
>  
>  Sysfs entries
>  -------------
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 8d3b0f86cc57..b6d06370469d 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -1,18 +1,21 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Platform driver for OneXPlayer, AOK ZOE, and Aya Neo Handhelds that expose
> - * fan reading and control via hwmon sysfs.
> + * Platform driver for OneXPlayer, AOKZOE, AYANEO, and OrangePi Handhelds
> + * that expose fan reading and control via hwmon sysfs.
>   *
>   * Old OXP boards have the same DMI strings and they are told apart by
> - * the boot cpu vendor (Intel/AMD). Currently only AMD boards are
> - * supported but the code is made to be simple to add other handheld
> - * boards in the future.
> + * the boot cpu vendor (Intel/AMD). Of these older models only AMD is
> + * supported.
> + *
>   * Fan control is provided via pwm interface in the range [0-255].
>   * Old AMD boards use [0-100] as range in the EC, the written value is
>   * scaled to accommodate for that. Newer boards like the mini PRO and
> - * AOK ZOE are not scaled but have the same EC layout.
> + * AOKZOE are not scaled but have the same EC layout. Newer models
> + * like the 2 and X1 are [0-184] and are scaled to 0-255. OrangePi
> + * are [1-244] and scaled to 0-255.
>   *
>   * Copyright (C) 2022 Joaquín I. Aramendía <samsagax@gmail.com>
> + * Copyright (C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>   */
>  
>  #include <linux/acpi.h>
> @@ -43,32 +46,48 @@ enum oxp_board {
>  	aok_zoe_a1 = 1,
>  	aya_neo_2,
>  	aya_neo_air,
> +	aya_neo_air_1s,
>  	aya_neo_air_plus_mendo,
>  	aya_neo_air_pro,
> +	aya_neo_flip,
>  	aya_neo_geek,
> +	aya_neo_kun,
> +	orange_pi_neo,
> +	oxp_2,
> +	oxp_fly,
>  	oxp_mini_amd,
>  	oxp_mini_amd_a07,
>  	oxp_mini_amd_pro,
> +	oxp_x1,
>  };
>  
>  static enum oxp_board board;
>  
>  /* Fan reading and PWM */
> -#define OXP_SENSOR_FAN_REG		0x76 /* Fan reading is 2 registers long */
> -#define OXP_SENSOR_PWM_ENABLE_REG	0x4A /* PWM enable is 1 register long */
> -#define OXP_SENSOR_PWM_REG		0x4B /* PWM reading is 1 register long */
> +#define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 registers long */
> +#define OXP_2_SENSOR_FAN_REG           0x58 /* Fan reading is 2 registers long */
> +#define OXP_SENSOR_PWM_ENABLE_REG      0x4A /* PWM enable is 1 register long */
> +#define OXP_SENSOR_PWM_REG             0x4B /* PWM reading is 1 register long */
> +#define PWM_MODE_AUTO                  0x00
> +#define PWM_MODE_MANUAL                0x01
> +
> +/* OrangePi fan reading and PWM */
> +#define ORANGEPI_SENSOR_FAN_REG        0x78 /* Fan reading is 2 registers long */
> +#define ORANGEPI_SENSOR_PWM_ENABLE_REG 0x40 /* PWM enable is 1 register long */
> +#define ORANGEPI_SENSOR_PWM_REG        0x38 /* PWM reading is 1 register long */
>  
>  /* Turbo button takeover function
> - * Older boards have different values and EC registers
> + * Different boards have different values and EC registers
>   * for the same function
>   */
> -#define OXP_OLD_TURBO_SWITCH_REG	0x1E
> -#define OXP_OLD_TURBO_TAKE_VAL		0x01
> -#define OXP_OLD_TURBO_RETURN_VAL	0x00
> +#define OXP_TURBO_SWITCH_REG           0xF1 /* Mini Pro, OneXFly, AOKZOE */
> +#define OXP_2_TURBO_SWITCH_REG         0xEB /* OXP2 and X1 */
> +#define OXP_MINI_TURBO_SWITCH_REG      0x1E /* Mini AO7 */
> +
> +#define OXP_MINI_TURBO_TAKE_VAL        0x01 /* Mini AO7 */
> +#define OXP_TURBO_TAKE_VAL             0x40 /* All other models */
>  
> -#define OXP_TURBO_SWITCH_REG		0xF1
> -#define OXP_TURBO_TAKE_VAL		0x40
> -#define OXP_TURBO_RETURN_VAL		0x00
> +#define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
>  
>  static const struct dmi_system_id dmi_table[] = {
>  	{
> @@ -88,7 +107,7 @@ static const struct dmi_system_id dmi_table[] = {
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
> +			DMI_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
>  		},
>  		.driver_data = (void *)aya_neo_2,
>  	},
> @@ -99,6 +118,13 @@ static const struct dmi_system_id dmi_table[] = {
>  		},
>  		.driver_data = (void *)aya_neo_air,
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
> +		},
> +		.driver_data = (void *)aya_neo_air_1s,
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> @@ -116,10 +142,31 @@ static const struct dmi_system_id dmi_table[] = {
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> -			DMI_EXACT_MATCH(DMI_BOARD_NAME, "GEEK"),
> +			DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
> +		},
> +		.driver_data = (void *)aya_neo_flip,
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "GEEK"),
>  		},
>  		.driver_data = (void *)aya_neo_geek,
>  	},
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
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> @@ -127,6 +174,20 @@ static const struct dmi_system_id dmi_table[] = {
>  		},
>  		.driver_data = (void *)oxp_mini_amd,
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +			DMI_MATCH(DMI_BOARD_NAME, "ONEXPLAYER 2"),
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
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> @@ -141,6 +202,13 @@ static const struct dmi_system_id dmi_table[] = {
>  		},
>  		.driver_data = (void *)oxp_mini_amd_pro,
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +			DMI_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1"),
> +		},
> +		.driver_data = (void *)oxp_x1,
> +	},
>  	{},
>  };
>  
> @@ -192,14 +260,20 @@ static int tt_toggle_enable(void)
>  
>  	switch (board) {
>  	case oxp_mini_amd_a07:
> -		reg = OXP_OLD_TURBO_SWITCH_REG;
> -		val = OXP_OLD_TURBO_TAKE_VAL;
> +		reg = OXP_MINI_TURBO_SWITCH_REG;
> +		val = OXP_MINI_TURBO_TAKE_VAL;
>  		break;
> -	case oxp_mini_amd_pro:
>  	case aok_zoe_a1:
> +	case oxp_fly:
> +	case oxp_mini_amd_pro:
>  		reg = OXP_TURBO_SWITCH_REG;
>  		val = OXP_TURBO_TAKE_VAL;
>  		break;
> +	case oxp_2:
> +	case oxp_x1:
> +		reg = OXP_2_TURBO_SWITCH_REG;
> +		val = OXP_TURBO_TAKE_VAL;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -213,14 +287,20 @@ static int tt_toggle_disable(void)
>  
>  	switch (board) {
>  	case oxp_mini_amd_a07:
> -		reg = OXP_OLD_TURBO_SWITCH_REG;
> -		val = OXP_OLD_TURBO_RETURN_VAL;
> +		reg = OXP_MINI_TURBO_SWITCH_REG;
> +		val = OXP_TURBO_RETURN_VAL;
>  		break;
> -	case oxp_mini_amd_pro:
>  	case aok_zoe_a1:
> +	case oxp_fly:
> +	case oxp_mini_amd_pro:
>  		reg = OXP_TURBO_SWITCH_REG;
>  		val = OXP_TURBO_RETURN_VAL;
>  		break;
> +	case oxp_2:
> +	case oxp_x1:
> +		reg = OXP_2_TURBO_SWITCH_REG;
> +		val = OXP_TURBO_RETURN_VAL;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -233,8 +313,11 @@ static umode_t tt_toggle_is_visible(struct kobject *kobj,
>  {
>  	switch (board) {
>  	case aok_zoe_a1:
> +	case oxp_2:
> +	case oxp_fly:
>  	case oxp_mini_amd_a07:
>  	case oxp_mini_amd_pro:
> +	case oxp_x1:
>  		return attr->mode;
>  	default:
>  		break;
> @@ -273,12 +356,17 @@ static ssize_t tt_toggle_show(struct device *dev,
>  
>  	switch (board) {
>  	case oxp_mini_amd_a07:
> -		reg = OXP_OLD_TURBO_SWITCH_REG;
> +		reg = OXP_MINI_TURBO_SWITCH_REG;
>  		break;
> -	case oxp_mini_amd_pro:
>  	case aok_zoe_a1:
> +	case oxp_fly:
> +	case oxp_mini_amd_pro:
>  		reg = OXP_TURBO_SWITCH_REG;
>  		break;
> +	case oxp_2:
> +	case oxp_x1:
> +		reg = OXP_2_TURBO_SWITCH_REG;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -295,12 +383,53 @@ static DEVICE_ATTR_RW(tt_toggle);
>  /* PWM enable/disable functions */
>  static int oxp_pwm_enable(void)
>  {
> -	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
> +	switch (board) {
> +	case orange_pi_neo:
> +		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL);
> +	case aok_zoe_a1:
> +	case aya_neo_2:
> +	case aya_neo_air:
> +	case aya_neo_air_plus_mendo:
> +	case aya_neo_air_pro:
> +	case aya_neo_flip:
> +	case aya_neo_geek:
> +	case aya_neo_kun:
> +	case oxp_2:
> +	case oxp_fly:
> +	case oxp_mini_amd:
> +	case oxp_mini_amd_a07:
> +	case oxp_mini_amd_pro:
> +	case oxp_x1:
> +		return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL);
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static int oxp_pwm_disable(void)
>  {
> -	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x00);
> +	switch (board) {
> +	case orange_pi_neo:
> +		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
> +	case aok_zoe_a1:
> +	case aya_neo_2:
> +	case aya_neo_air:
> +	case aya_neo_air_1s:
> +	case aya_neo_air_plus_mendo:
> +	case aya_neo_air_pro:
> +	case aya_neo_flip:
> +	case aya_neo_geek:
> +	case aya_neo_kun:
> +	case oxp_2:
> +	case oxp_fly:
> +	case oxp_mini_amd:
> +	case oxp_mini_amd_a07:
> +	case oxp_mini_amd_pro:
> +	case oxp_x1:
> +		return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  /* Callbacks for hwmon interface */
> @@ -326,7 +455,29 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  	case hwmon_fan:
>  		switch (attr) {
>  		case hwmon_fan_input:
> -			return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
> +			switch (board) {
> +			case orange_pi_neo:
> +				return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
> +			case oxp_2:
> +			case oxp_x1:
> +				return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
> +			case aok_zoe_a1:
> +			case aya_neo_2:
> +			case aya_neo_air:
> +			case aya_neo_air_1s:
> +			case aya_neo_air_plus_mendo:
> +			case aya_neo_air_pro:
> +			case aya_neo_flip:
> +			case aya_neo_geek:
> +			case aya_neo_kun:
> +			case oxp_fly:
> +			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
> +			case oxp_mini_amd_pro:
> +				return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
> +			default:
> +				break;
> +			}
>  		default:
>  			break;
>  		}
> @@ -334,31 +485,74 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  	case hwmon_pwm:
>  		switch (attr) {
>  		case hwmon_pwm_input:
> -			ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> -			if (ret)
> -				return ret;
>  			switch (board) {
> +			case orange_pi_neo:
> +				ret = read_from_ec(ORANGEPI_SENSOR_PWM_REG, 1, val);
> +				if (ret)
> +					return ret;
> +				/* scale from range [1-244] */
> +				*val = ((*val - 1) * 254 / 243) + 1;
> +				break;
> +			case oxp_2:
> +			case oxp_x1:
> +				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +				if (ret)
> +					return ret;
> +				/* scale from range [0-184] */
> +				*val = (*val * 255) / 184;
> +				break;
>  			case aya_neo_2:
>  			case aya_neo_air:
> +			case aya_neo_air_1s:
>  			case aya_neo_air_plus_mendo:
>  			case aya_neo_air_pro:
> +			case aya_neo_flip:
>  			case aya_neo_geek:
> +			case aya_neo_kun:
>  			case oxp_mini_amd:
>  			case oxp_mini_amd_a07:
> +				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +				if (ret)
> +					return ret;
> +				/* scale from range [0-100] */
>  				*val = (*val * 255) / 100;
>  				break;
> -			case oxp_mini_amd_pro:
>  			case aok_zoe_a1:
> +			case oxp_fly:
> +			case oxp_mini_amd_pro:
>  			default:
> +				ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +				if (ret)
> +					return ret;
>  				break;
>  			}
>  			return 0;
>  		case hwmon_pwm_enable:
> -			return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> +			switch (board) {
> +			case orange_pi_neo:
> +				return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
> +			case aok_zoe_a1:
> +			case aya_neo_2:
> +			case aya_neo_air:
> +			case aya_neo_air_1s:
> +			case aya_neo_air_plus_mendo:
> +			case aya_neo_air_pro:
> +			case aya_neo_flip:
> +			case aya_neo_geek:
> +			case aya_neo_kun:
> +			case oxp_2:
> +			case oxp_fly:
> +			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
> +			case oxp_mini_amd_pro:
> +			case oxp_x1:
> +				return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> +			default:
> +				break;
> +			}
>  		default:
>  			break;
>  		}
> -		break;
>  	default:
>  		break;
>  	}
> @@ -381,21 +575,35 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  			if (val < 0 || val > 255)
>  				return -EINVAL;
>  			switch (board) {
> +			case orange_pi_neo:
> +				/* scale to range [1-244] */
> +				val = ((val - 1) * 243 / 254) + 1;
> +				return write_to_ec(ORANGEPI_SENSOR_PWM_REG, val);
> +			case oxp_2:
> +			case oxp_x1:
> +				/* scale to range [0-184] */
> +				val = (val * 184) / 255;
> +				return write_to_ec(OXP_SENSOR_PWM_REG, val);
>  			case aya_neo_2:
>  			case aya_neo_air:
> +			case aya_neo_air_1s:
>  			case aya_neo_air_plus_mendo:
>  			case aya_neo_air_pro:
> +			case aya_neo_flip:
>  			case aya_neo_geek:
> +			case aya_neo_kun:
>  			case oxp_mini_amd:
>  			case oxp_mini_amd_a07:
> +				/* scale to range [0-100] */
>  				val = (val * 100) / 255;
> -				break;
> +				return write_to_ec(OXP_SENSOR_PWM_REG, val);
>  			case aok_zoe_a1:
> +			case oxp_fly:
>  			case oxp_mini_amd_pro:
> +				return write_to_ec(OXP_SENSOR_PWM_REG, val);
>  			default:
>  				break;
>  			}
> -			return write_to_ec(OXP_SENSOR_PWM_REG, val);
>  		default:
>  			break;
>  		}
> @@ -467,19 +675,20 @@ static int __init oxp_platform_init(void)
>  {
>  	const struct dmi_system_id *dmi_entry;
>  
> -	/*
> -	 * Have to check for AMD processor here because DMI strings are the
> -	 * same between Intel and AMD boards, the only way to tell them apart
> -	 * is the CPU.
> -	 * Intel boards seem to have different EC registers and values to
> -	 * read/write.
> -	 */
>  	dmi_entry = dmi_first_match(dmi_table);
> -	if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +	if (!dmi_entry)
>  		return -ENODEV;
>  
>  	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
>  
> +	/*
> +	 * Have to check for AMD processor here because DMI strings are the same
> +	 * between Intel and AMD boards on older OneXPlayer devices, the only way
> +	 * to tell them apart is the CPU. Old Intel boards have an unsupported EC.
> +	 */
> +	if (board == oxp_mini_amd && boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +		return -ENODEV;
> +
>  	oxp_platform_device =
>  		platform_create_bundle(&oxp_platform_driver,
>  				       oxp_platform_probe, NULL, 0, NULL, 0);

