Return-Path: <linux-kernel+bounces-429362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B895D9E1B18
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763B328B438
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6941E410E;
	Tue,  3 Dec 2024 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5sk3Llo"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774A1E3772;
	Tue,  3 Dec 2024 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225701; cv=none; b=ImFfYWVZaU5FIfCCh9uR2wcr7fRZxXSTXl4FrGj7LS1jN0lYbCVDtWwXf3M1kTLsErwxruCTbgU+jc+l5zmSWLq4l0Ubo3BZFA2Wgbq4x4gf02Fl0b1c0SBlzduPgIeEtUqH9vcvP2Og4dtZpqD/LrIwqVTz8kAwHgoQTT6PUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225701; c=relaxed/simple;
	bh=x7dLi7wAGruYlnkWF7Di04Y7mXBk+HfGj4As5QQnFLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9i7kQK4mn6oQYJt6xuk9jSnUdjs0iXiY0Na8VVeZLU0zoa8YMlao5aelDOBO7jvGl0SzwKPWUMVBqPHgwK68Vpikji8f7FfmiysUUpNwgjBVk4AHB74y8ZOxAeirsqxZ2Rfs95PDzNuxJ0WhMe+Sng7y87yNNls/tKpCQd/C+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5sk3Llo; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so3716373a12.1;
        Tue, 03 Dec 2024 03:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733225699; x=1733830499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRTMjpBU2FZrkasI1vglpiZRnbuKwshDQaObui5oB2I=;
        b=k5sk3LloHDV3vj1UHofOkYahkliD3++deodRfyVwVmB+Q/CbK7LTqHAKla4Au5TVFK
         tEqD/XKO4n8XcBIhv2/2lYVRz48vUQtefHarBfFFTEqrZhrZWqV4qaqtu2jXlp5x9pVo
         Ta1y/9TXpgxzpStc7A+KkNlR9T6VaBVhZjN6AfnwAm8mzPwYs+CMNc9Ml2Q5sVyl6H3K
         ZV8r5utp6k4qptG4xbUrDOqyRGt+7Q+z/UaXJmRD4K3AFX8v1LZbYcDm09EmQXHvF+hT
         wqKft81Z1p9wnTyXXWCpjF7PDRFrnzjiuH7LbY9NxVVUCKiSpM4En6UD2VWT2vni/Q+0
         cU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733225699; x=1733830499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRTMjpBU2FZrkasI1vglpiZRnbuKwshDQaObui5oB2I=;
        b=FbypOD4fPkz++xzS3x4L1TLdHAhb0jfdHi48l5S2ep646spUNRRUgNDxkn6jRCpTvI
         0haWx2EIc6L3ooonSyfqNlv6BmnSWZIDU9LV7BFhknxwniXk6sv7e9CU0E2S35ICz+VB
         zWVu2rqXjgw945CTzTU1vI9m0N569SN8sYejXSdkDjdXCTyvxnacqBiehWrXONgRP/2S
         ZO+n5mRO+hKI+Pdu7m3ZQgdYzG4G74re8FYAKQijM1Qh5SwgN/tyxZE/E4AuHE5Ror4O
         GzR2fcA2kiV3Mh5agDAVIZ8NSFrEmt2Db2NBOTfbwTNvNExvWfHWEbRIHKVovnTBEYpp
         +QxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWCPif1EO5l82ytIKDPY9IckEBmiV7rLw4Vwg4dQkFp3f2GWee7zdCFn3crTrrjzjQZhUb2Rx4NAQ=@vger.kernel.org, AJvYcCUb6d8Sk57tVgeKJlRqu5axuclYJj9aL4EVPS9oyQ00G85snLVx3iZyUbtD4RXfKjHTUGUyaEtS0o1sbmk=@vger.kernel.org, AJvYcCXqIv7/mJoR5o+PsW6V1tr7j11YClPK9f0t7Zp2CXUwpY/8hqPO7w+pFGGSypwnTCdhwwTVfHgTKlanKgLw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7o2MjnixtBmjN800H9rV23ARSW5LUTWIMGlZ61m7Jx86Zng0
	P8ei2zMIjHeeoSqGaTPO5Q+7R94bNElDej8Q9TTIj0SGc7EeMCFcUtsaRxMu
X-Gm-Gg: ASbGncs4UI2UKLZwNLn/wU1NRb/8G0a6zqOOntQfl+D+oLc4M/kMAUCpdyD0kSO7YTL
	ImZ5hWn4XapnhFNiWKWsm6YOk6cRXQ1c/zZeqH3zxwtiIPWEsNin+QCtFSr8XLtiNUp0GwZNnRM
	2ohCqZOQ1LEO+Uy4Q4A+hM9HelNBX3lvgVbVPMlJZ2vd2FylaPBOeY/fjNIJ1xlmw90wuo8tSAa
	FuB7v3UJ2tW6k230PrXd1MDxcSw
X-Google-Smtp-Source: AGHT+IEgl7vHhlCDL4Gwe4it1dd5SMY6cGnkCBgQo5plDhb1eivLpmfTOrsdMgmKo3BAvvYzv1rVXQ==
X-Received: by 2002:a05:6a20:6a1b:b0:1db:f00e:2dfe with SMTP id adf61e73a8af0-1e165412f88mr3221903637.39.1733225699535;
        Tue, 03 Dec 2024 03:34:59 -0800 (PST)
Received: from gmail.com ([2a12:f8c1:50:4::4fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849c28sm10180513b3a.196.2024.12.03.03.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:34:58 -0800 (PST)
Date: Tue, 3 Dec 2024 19:34:54 +0800
From: Li XingYang <yanhuoguifan@gmail.com>
To: eugene.shalygin@gmail.com
Cc: jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
Message-ID: <Z07s3rKyv32uUGrG@gmail.com>
References: <20241201034803.584482-1-yanhuoguifan@gmail.com>
 <20241201034803.584482-3-yanhuoguifan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201034803.584482-3-yanhuoguifan@gmail.com>

On Sun, Dec 01, 2024 at 11:47:45AM +0800, Li XingYang wrote:

Hi Eugene:

Could you review the new verson patch in free time?

thanks,
XingYang
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
>  	.family = family_amd_500_series,
>  };
>  
> +static const struct ec_board_info board_info_tuf_gaming_x670e_plus = {
> +	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
> +		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
> +		SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT |
> +		SENSOR_FAN_CPU_OPT,
> +	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
> +	.family = family_amd_600_series,
> +};
> +
>  #define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, board_info)                      \
>  	{                                                                      \
>  		.matches = {                                                   \
> @@ -540,6 +549,8 @@ static const struct dmi_system_id dmi_table[] = {
>  					&board_info_zenith_ii_extreme),
>  	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME ALPHA",
>  					&board_info_zenith_ii_extreme),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("TUF GAMING X670E-PLUS",
> +					&board_info_tuf_gaming_x670e_plus),
>  	{},
>  };
>  
> -- 
> 2.47.1
> 

