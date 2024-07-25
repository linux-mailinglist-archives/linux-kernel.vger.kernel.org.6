Return-Path: <linux-kernel+bounces-261714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648A93BB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0627A1C218C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABC518029;
	Thu, 25 Jul 2024 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arYavAvZ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6854533C5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721878269; cv=none; b=g9httnV1g4h99wwfgtasEpcW66L80kmV71rNos+T1aLR1aHrVODZi6De1MolZeL/nZsxBe/bjIWkjOONhO640dyALe12YcH9hUL/lmNDrJP59TfBryWICMctI1FUVamlIdGxWSMT5fmsl8aPxUeja+HwcOHV6dfc00K5dML6MMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721878269; c=relaxed/simple;
	bh=d4Md/pmd9aAH6BP2SJNyitKaq4lM6GrSPXh+qAunH6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xf4Lw37/h2XE1We2kaEFPzFgIqZRLKoc0g7GvBT2wazBSfztTweMTvZUvw2GQ+QbuK+bBjVTPP/Pw3PtpHR1kCOvqZiYPddJ6/ONJ3V1jOhbFvUUx9shBlXCVwSbNWWbksCENawkB0NhvusIYZ/xehruhJWxeuMFL+t3f7hvcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=arYavAvZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so521691e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721878262; x=1722483062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhbT1eQ9YPVhIQslZbZZbHdi4UGZ5NhIA5kAWua5Lkg=;
        b=arYavAvZnL/vVCTWS9TvqTL7SyHo2HJYo6xsUwOy57I7cahOBK9sH0XNh3ugN74ufY
         ucz3wjoaOlUEnAlmcA6ykMKwzBoIVG/YKHCAz6hNmIG4qMrnQp4Eu8W5gyCDOVVlCbd9
         CH55OYeC/2A05N8akgPn/PvANCrx4O1aT7q1YiZT/l/2CsO/tWeVYoEe3FLC3d7Gpupb
         obW4Z+USMDXZT6SLnWf9Qhtq/YSWpaHZHuhBBewJovTwZv5arHA5JUwzx19BA7gvMA/G
         4I9qj12ekLW+8nbf2CY028lAzMyaTJt0+ebt6Fqt8MZ5Br90WZxEs/z+TjSfzi2LgV+p
         +kIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721878262; x=1722483062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhbT1eQ9YPVhIQslZbZZbHdi4UGZ5NhIA5kAWua5Lkg=;
        b=fPuroyVMXTXHH39RK39mHmj5vOqzDUpEpodx+iXWjxU8h15rjR6Kr6TJc6QO1REtN5
         AD5KLU0gEcv2AhI3kvlZh4ys2o2ZPQhrgiwSwsqp0dGnqHLfrcYYyWEWYGPZJnWmGR/7
         QTW1SVR1s3d7f685cFUpFizCE1HI8PRtd9/bcU3JtzeOnAq9ycRJFKtSuq9mTF7o3EwY
         1/YZdw9vZdmYz4gHyq93Zahgka/BayvR/9QZ+s2lN6Lu2GuoFt6Fx1Rhy3WUITlzrHPz
         ma0CQqmKjHAa7R0Dm0us1gzNKxG9KYHz2EGfIuMsrCHZRl7roFKI2xmAum4Frt39MFYR
         9nOw==
X-Forwarded-Encrypted: i=1; AJvYcCXeW+zR3Y2BIs0X+NnurYQgr7WIJ5ngq6NA9CI1nNw5dMGNYCKbDqWTw5Ipii6+kQ8yZKtRaLeR0aFK2F+4qeqyYaijgv8Ka1A1M2lP
X-Gm-Message-State: AOJu0YyILcck5l3PEY5bmFadqSbraegIEHw7/yE01C8jlxAp3BYS8pnU
	WlCADYXVAVtgDWpsApKlktGrm3rngmf3Pc4xD3XlfTKYHifeScf6sZtezae8Z/k=
X-Google-Smtp-Source: AGHT+IFjMhfs1uKv8o8eDUmQrRbd/e1o4QszP3+4qeKeaqccHoFSZFfQnx4HsVLlt3eN+89oHv6Bbg==
X-Received: by 2002:a19:f70d:0:b0:52c:e0fb:92c0 with SMTP id 2adb3069b0e04-52fd60439a8mr261657e87.34.1721878262339;
        Wed, 24 Jul 2024 20:31:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08248sm63127e87.125.2024.07.24.20.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 20:31:01 -0700 (PDT)
Date: Thu, 25 Jul 2024 06:31:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jameson Thies <jthies@google.com>, Sebastian Reichel <sre@kernel.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	bleung@google.com, abhishekpandit@chromium.org, andersson@kernel.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Add status to UCSI power supply
 driver
Message-ID: <tzljywuym6jsh5q5iuc7rrtq564d3ffl3e4ltuii7xzkd6cf7d@2nmj5qkusbkt>
References: <20240724201116.2094059-1-jthies@google.com>
 <20240724201116.2094059-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724201116.2094059-2-jthies@google.com>

On Wed, Jul 24, 2024 at 08:11:13PM GMT, Jameson Thies wrote:
> Add status to UCSI power supply driver properties based on the port's
> connection and power direction states.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Please CC Power Supply maintainers for this patchset (added to cc).

At least per the Documentation/ABI/testing/sysfs-class-power, the status
property applies to batteries, while UCSI psy device is a charger. This
is logical, as there might be multiple reasons why the battery is not
being charging even when the supply is online.

> ---
> Changes in V2:
> - None.
> 
>  drivers/usb/typec/ucsi/psy.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index e623d80e177c..d0b52cee41d2 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -29,6 +29,7 @@ static enum power_supply_property ucsi_psy_props[] = {
>  	POWER_SUPPLY_PROP_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_SCOPE,
> +	POWER_SUPPLY_PROP_STATUS,
>  };
>  
>  static int ucsi_psy_get_scope(struct ucsi_connector *con,
> @@ -51,6 +52,20 @@ static int ucsi_psy_get_scope(struct ucsi_connector *con,
>  	return 0;
>  }
>  
> +static int ucsi_psy_get_status(struct ucsi_connector *con,
> +			       union power_supply_propval *val)
> +{
> +	val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +	if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
> +		if ((con->status.flags & UCSI_CONSTAT_PWR_DIR) == TYPEC_SINK)
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ucsi_psy_get_online(struct ucsi_connector *con,
>  			       union power_supply_propval *val)
>  {
> @@ -249,6 +264,8 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
>  		return ucsi_psy_get_current_now(con, val);
>  	case POWER_SUPPLY_PROP_SCOPE:
>  		return ucsi_psy_get_scope(con, val);
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return ucsi_psy_get_status(con, val);
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.45.2.1089.g2a221341d9-goog
> 

-- 
With best wishes
Dmitry

