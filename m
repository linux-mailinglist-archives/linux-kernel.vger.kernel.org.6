Return-Path: <linux-kernel+bounces-426280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7A39DF12D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1917B21218
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC619B3C5;
	Sat, 30 Nov 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWYekSDT"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9C22066;
	Sat, 30 Nov 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732977249; cv=none; b=clHrO6EPqsS3QHPhZZZ88K5QtZYrO/n1N6yJjnklcjidCzbrI02kqjLyc/BvsauBwEukeW9yVrbzUtl0NIPPth0SgnhGhrOYSskoCAuBpxlE94tjOeYVyRWtT4OBlP43c+sX2f/FZ2VmHSgm3LuA/jwh52+yNw7SChw5jTNSsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732977249; c=relaxed/simple;
	bh=RSTZ6nctnLWo45fxQw2FAvzU84YJrisC7sQGN40y940=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FULlQ6GpfZaggIJCxcxYqsPi85XREJbMxKuI1Am5t6T6gQ7VueBer/yO1gOocUEsKeNK2sp3yrO37C54zqthPtHdj0wGSixpied3aefzciZmHeFmlrnBb+BGl0+QgJYi5b6IbFkzVpFbMXmKc7u7hDckyJKtw2+aSHpeHmXPfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWYekSDT; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-843671e1426so90092839f.0;
        Sat, 30 Nov 2024 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732977247; x=1733582047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NAtEtpdjL4UutGVvucQ61fz2pHgRYK/Xzyo6kc7iY0k=;
        b=CWYekSDTp7MJ8DlbrhgdxMq1t0M0CAnPWrxXLrDrBEsJTgxd6NMD6Y+KYVeyQo1mJk
         BihDgqBkM1VmH1QaB/qPLZo717ESUCsy328knAio8OLunYoSGjT+WRFr9kaLBb8uY8hI
         iblI95IdRo45sWJmkRgMyVZ89hijafaBCmsUEqQQbyyukNQyWm1xLMB8ARulnw+KPGHh
         F54LjLjX9dxcvygIEDejXZs0GPRrlwQtBNXfDR1c0+6ssp9vFARtTTBnx9Rdy4BQBa3t
         KPoLFwvp0+BjYkMv53kUjMRKXKCETuFlnAjeRSnBn0pyglCx+VIrCVm1xdLc7HeKO7UA
         5r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732977247; x=1733582047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAtEtpdjL4UutGVvucQ61fz2pHgRYK/Xzyo6kc7iY0k=;
        b=vYjukClGzSNvBQjP5F88wzLBzCos1yg1CF0DLu09l9h23sYxdrL6h/nRTCRPU+oKV/
         jzrCut3um6m/aqN79f0MH9Yil/Ww6NJm8SIYo89+bCTx4HmsoLjcC5dO+E3AlOdzo8vJ
         B9GgMpPmPQLXY9UPCSv6D1RQa3LGTjflVrtqllYvF8YUD7YKROGO8Bllr7UoaegeE/ZL
         DUD7a5koz3SkwxWbJBodE9AZjBiUA+2eiF9qd1SxlmoMB3BDNQGf4nNmGKVtOSB/HPrj
         cgvhQ4elYCEOUjqXGLqbYDF+f3PhrmBWRe8gKkkrCbohoNqJP7ZFVujsszF8pY8qvShh
         5+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU2+xQ6AEhusHBYaZtQ9RV3luG2Bcd7nVVIRHadfDJT4XxT/v3BeajUqR3zAbGyjw5JJp2WIXTArQ8=@vger.kernel.org, AJvYcCUg4hONgaSyAhY2FgRGEkQM/nI8+5yWO8DP9wXNI6kZW2iRTcpmbXWraSV2iShslMFGFDaNE9xq6j+J4/vh@vger.kernel.org, AJvYcCX3Bhq1ddZo74SvLDbFSqf4vHDoWcRvItyO3ZDQTcTAlfsweXFfeV8deUykLS3fKxBbp4yRdPwmHZGAZ0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjebE6NdlkGCiRwsNqTxaBqkjqL+eyNq5Y24JtmsSGFbdtjiaI
	r5LYNE6baEAz1rlFnQIKBP2/NLHFBHgswQNGcQIwCmhTVtEm+XlsB39PcWjY+S50L6F9wrCgwvp
	/tUaYimGmAF/IDEs4SPjbqG8hrCw=
X-Gm-Gg: ASbGncsqIuoh1OsAMeqFqD/VOgj+ZIF756eRcSL1W68QNAQvQMGGtNpiCPo1bG6yexd
	jxn3XO6acAhYOaq70ehDcZ8u5tWOGkMx/OqU3g4fKiRMJ+DLPvsaeWl3//0RToX8=
X-Google-Smtp-Source: AGHT+IE42r/pQKVy4l5RzHo6gkKID7duV/WCIPg2V/HILGOIJrjigZsNJkpUi4KzStelCGJ/1Nbve0Yjv/rm1s3ZAXc=
X-Received: by 2002:a05:6602:6420:b0:835:45f9:c2ee with SMTP id
 ca18e2360f4ac-843ecfcd4acmr1740067039f.4.1732977246609; Sat, 30 Nov 2024
 06:34:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130133837.24454-1-yanhuoguifan@gmail.com> <20241130133837.24454-2-yanhuoguifan@gmail.com>
In-Reply-To: <20241130133837.24454-2-yanhuoguifan@gmail.com>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Sat, 30 Nov 2024 15:33:55 +0100
Message-ID: <CAB95QAROXwFPZB8gSkz0-thPtuzWkhAHmbqEy2QBg4fMmx7NKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
To: Li XingYang <yanhuoguifan@gmail.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Thank you for the patch! One little request, please, is to keep the
definitions list sorted, that is, could you, please, put the new board
definition in the source file after ROG CROSSHAIR X670E GENE?
Otherwise LGTM.

Kind regards,
Eugene

On Sat, 30 Nov 2024 at 14:38, Li XingYang <yanhuoguifan@gmail.com> wrote:
>
> add asus-ec-sensors on the mainboard TUF GAMING X670E PLUS
> support these sensors:
> SENSOR_TEMP_CPU, SENSOR_TEMP_CPU_PACKAGE, SENSOR_TEMP_MB
> SENSOR_TEMP_VRM, SENSOR_TEMP_WATER_IN, SENSOR_TEMP_WATER_OUT
> and SENSOR_FAN_CPU_OPT
>
> Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>
> ---
>  Documentation/hwmon/asus_ec_sensors.rst |  1 +
>  drivers/hwmon/asus-ec-sensors.c         | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index ca38922f4ec5..d049a62719b0 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -17,6 +17,7 @@ Supported boards:
>   * ROG CROSSHAIR VIII IMPACT
>   * ROG CROSSHAIR X670E HERO
>   * ROG CROSSHAIR X670E GENE
> + * TUF GAMING X670E PLUS
>   * ROG MAXIMUS XI HERO
>   * ROG MAXIMUS XI HERO (WI-FI)
>   * ROG STRIX B550-E GAMING
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 9555366aeaf0..d9b4074080bd 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -250,6 +250,8 @@ static const struct ec_sensor_info sensors_family_amd_600[] = {
>                 EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
>         [ec_sensor_temp_water_out] =
>                 EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
> +       [ec_sensor_fan_cpu_opt] =
> +               EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
>  };
>
>  static const struct ec_sensor_info sensors_family_intel_300[] = {
> @@ -354,6 +356,15 @@ static const struct ec_board_info board_info_crosshair_x670e_hero = {
>         .family = family_amd_600_series,
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
>  static const struct ec_board_info board_info_crosshair_x670e_gene = {
>         .sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
>                 SENSOR_TEMP_T_SENSOR |
> @@ -512,6 +523,8 @@ static const struct dmi_system_id dmi_table[] = {
>                                         &board_info_crosshair_x670e_hero),
>         DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR X670E GENE",
>                                         &board_info_crosshair_x670e_gene),
> +       DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X670E-PLUS",
> +                                       &board_info_tuf_gaming_x670e_plus),
>         DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO",
>                                         &board_info_maximus_xi_hero),
>         DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO (WI-FI)",
> --
> 2.47.1
>

