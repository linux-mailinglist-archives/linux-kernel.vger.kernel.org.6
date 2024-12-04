Return-Path: <linux-kernel+bounces-431092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8569E38D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9EB1612C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F971B21B7;
	Wed,  4 Dec 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehhZkHbj"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAA1AF0BA;
	Wed,  4 Dec 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311879; cv=none; b=LHKgh6RqNqmFNaPyNJw/UROij1TkpsIkI0//9EabzCLQpZUyrCXKnyZHaf7baKNaByPFayaA/Qw+7HcqDDpBkoW+G6KXj8jD4MfgvfHJCtBE2jxlsfOMZd4oVELEA84RQsrmFVMF3V27Acdv8nO2OjHtBTNmFdFkuapa6uO3yJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311879; c=relaxed/simple;
	bh=+kvhfpHS0ogdmT/S4fJdm/f29KFkzvvP+nIzHvj0z5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP+MFuBJxTRBLzB0EJUWPm56xEsa3P/5mssZRxGqOuKmBeYp0ohnS7+GvVcL5cwX+rO5K9mmS1koFXaMZnWrJSillWqSfYh+aRGwBoZtZGDPTa9YUeMbKRJ90Wdz1Tat+7TqV25voD8tssabBgalbotGEON7i5E42S1I+0seUjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehhZkHbj; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a777c67c45so2652445ab.1;
        Wed, 04 Dec 2024 03:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733311877; x=1733916677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R4NJV4SbpTmQDT3HCb6/b4uwxgPS2Q5x/fnMky0MNuI=;
        b=ehhZkHbjfFo5cBwc7yrUTa0e1vdKV4Uatf/tUe1ipohiDobO+mePwl7yh2phQPOBEP
         WOzj317i4Cozr0N8fTqxV64tXhJzKCxmneh2syVQDrFestWqFnEZwwb86iJ9xgTAjW4I
         TkcOpikAV3a4GuU5Biwc0ZKBXvbOcui4d/B1s3ic7or7v/qE0v7DoADs/9fea25D0kiD
         7nVq2bC0E16GbjdQg7HBuaSFXiIVtsMDmXbFjbPV1El3OzVhydKsPQJiBPp17OEaGBQZ
         z/4yikTNP4qTFQc+5gWeQ5cnt3m8/Oqs3q9ugL5VUD/NIvza/YFo/0zI397AHnjBv7j/
         XZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733311877; x=1733916677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4NJV4SbpTmQDT3HCb6/b4uwxgPS2Q5x/fnMky0MNuI=;
        b=wxJctWmoq4u/Yd10xHcKeheZcxrsnYUmUOtfAlZQQJQMXLS3mnWwm/ZlLkzz+xSpzp
         9tRwXoDDlMIVQDQry4Gst5KKVy5aze5RICwZQ2gH5JWX2BOoVCTgr2FwtpAtGHONvtmL
         Xr3xz5bSHvmKbHXcf6oyVWXCv26eROaRTp7ft0JOwzUrgkgGuSRQZHOFhHm0eWx2ps01
         2FcWfOeKhBVarbRYfybplB3Xg62WOHB7tsdNCBXGLTuTBkORNEn1zz/IsMHlxRudRkea
         osx0b52pOZnYOF1IWfc4kWgwk264RgAP9mU7k3q9o6E6rBwziZeEzzfO1qHwzcwuldsl
         oZww==
X-Forwarded-Encrypted: i=1; AJvYcCU5Tl9uwJRwUWwBo/hDjJLhGc4Ieiw6CP10JYlTTro6/NN8pm5I4GD50UuvkBYB003PP6vS3jNDSmbylTQ=@vger.kernel.org, AJvYcCVp1ky8C5mkpbb8iwGD1oHvh3b9bqKrn4SnOIj45OKK7d4CzJn7uJB2mVAJNLcsF90Kd0rv5c8Oc/o=@vger.kernel.org, AJvYcCX6IaC1o7dyWIxnuUkzL5eLMMwX9XmMmWw/x91jf+2K8D+SXddGhhIFVIiVHZlKBlX9hhT0M5VwAxa62znG@vger.kernel.org
X-Gm-Message-State: AOJu0YzU93FSAFyfGaotlNAgdZqbOZcxRVq8u2yhoOD/rpUUhTh29Mjy
	1j86TwhO1iorXBg/RR4HsWQBySz4qGTj/HACrqZGXnaAW8jBVHvlQphRJhXCQkJGl6mWBLdcqcn
	0p2OQm5dThqSxjigFHuQJZf9Zqdk=
X-Gm-Gg: ASbGncv/UJvZDqhXaLrfxlJn/A2O3ez7b7NSZfetqa5Q9PVCeOdkDTiWKWl59GV6G1A
	vYxl5et0Z97QcI8dkgOJKvLT6oN8=
X-Google-Smtp-Source: AGHT+IEe2aKnZo/L3IQJvQG5qtIOaJeeY0k/JN9NvLny8A3yd7muerH3TRiyJJDBBl0Avs9FT2MJ31n4DCKXBy/0g0Y=
X-Received: by 2002:a05:6e02:348a:b0:3a7:ceae:462e with SMTP id
 e9e14a558f8ab-3a7ceae59cbmr252865025ab.4.1733311876687; Wed, 04 Dec 2024
 03:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201034803.584482-1-yanhuoguifan@gmail.com> <20241201034803.584482-3-yanhuoguifan@gmail.com>
In-Reply-To: <20241201034803.584482-3-yanhuoguifan@gmail.com>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Wed, 4 Dec 2024 12:31:05 +0100
Message-ID: <CAB95QAQ5CS3Xg2xfPgvOP1LjaXxKtUrjCuo4gv2x=h=-40cBwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
To: Li XingYang <yanhuoguifan@gmail.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry for the late reply. This patch is OK with me.

Best regards,
Eugene

On Sun, 1 Dec 2024 at 04:48, Li XingYang <yanhuoguifan@gmail.com> wrote:
>
> add asus-ec-sensors support on the mainboard TUF GAMING X670E PLUS
>
> Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>
> ---
>  Documentation/hwmon/asus_ec_sensors.rst |  1 +
>  drivers/hwmon/asus-ec-sensors.c         | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index ca38922f4ec5..739636cf7994 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -29,6 +29,7 @@ Supported boards:
>   * ROG STRIX Z690-A GAMING WIFI D4
>   * ROG ZENITH II EXTREME
>   * ROG ZENITH II EXTREME ALPHA
> + * TUF GAMING X670E PLUS
>
>  Authors:
>      - Eugene Shalygin <eugene.shalygin@gmail.com>
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 381bf117104f..43e54dc513da 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -479,6 +479,15 @@ static const struct ec_board_info board_info_zenith_ii_extreme = {
>         .family = family_amd_500_series,
>  };
>
> +static const struct ec_board_info board_info_tuf_gaming_x670e_plus = {
> +       .sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
> +               SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
> +               SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT |
> +               SENSOR_FAN_CPU_OPT,
> +       .mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
> +       .family = family_amd_600_series,
> +};
> +
>  #define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, board_info)                      \
>         {                                                                      \
>                 .matches = {                                                   \
> @@ -540,6 +549,8 @@ static const struct dmi_system_id dmi_table[] = {
>                                         &board_info_zenith_ii_extreme),
>         DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",
>                                         &board_info_zenith_ii_extreme),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X670E-PLUS",
> +                                       &board_info_tuf_gaming_x670e_plus),
>         {},
>  };
>
> --
> 2.47.1
>

