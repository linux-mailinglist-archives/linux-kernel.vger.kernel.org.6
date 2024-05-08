Return-Path: <linux-kernel+bounces-173229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C6C8BFD5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E362D1C22D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AC95102F;
	Wed,  8 May 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/KysQiS"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7342062;
	Wed,  8 May 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172010; cv=none; b=q27iDZ9iTyJ7KR/RcWMM/4G0TKSOgNiC6t/WoddocrDXB6jFJFTUeIN+1MxswrxYi/Xw/FrCF4gqcIO+DIkySAwYTQjVy5H/yk56aPIuVQaHloXiiXZzj43rakJXIzPBoVb0A5tjqJJvN77cShBVFgKaM5tEcD4Br3trf8JSSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172010; c=relaxed/simple;
	bh=1vMA+1FxGPIUX0MsOYg2MBJxGNADp4fpRMmfQxXengs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvTTdd3yAJ1QHTNd8fTFmpzpk3clWoZc/sWVpiJtswH84M/WontwHhFVm+s19LumxPNbHyYz/gEyDO/+1pYNtxSOVcBfrH/ajXd0nb95kqJQ9GhZg8duP5RTZRR6O2aAc2Efji7o5CPVPxNNyRpYvVhcgXLyo4FqFsQkTAdWFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/KysQiS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f4a817f1e5so488690b3a.2;
        Wed, 08 May 2024 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715172007; x=1715776807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z67cu76Wcq7ICqFNBw/3kQYlwUX0or8mnSlZrvt4o5I=;
        b=P/KysQiSNUemZhOuWp3ZPTAxeGugZhWhVAuSXkcI8xuPti7dZn8f0aFHtckPTdj4UB
         rZsbq1G3AkOO+hGYnS2cfuYp03mpz0ZEBb7wRFOIfT3hijzKoCWPySP1oDjawJf1qEmo
         4GvTcOjZQkxL6sYb5e7bbQSb6VWYO00WTTR6xvHloeQoIrdNtyJA1PSlW4WBKnH1Znqa
         QtrgUitRRRh0rO0n+IbYWzrPrkP4ghACWKw6Ntjp73WVAgpiKfbcpbDrKMav4ltnKGkb
         xh+f9njZlyT5+81fLkJA6jjsIfIXnGHY8Vt2HMRjmT2Igmp7/i4EBYH0y87D27aKzG85
         wVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715172007; x=1715776807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z67cu76Wcq7ICqFNBw/3kQYlwUX0or8mnSlZrvt4o5I=;
        b=L4chNqgKafj6VMQJteZi5JCTeRYCP1La3U51WSFIaHPyqfzbhOCygyL/8aRcsqtT+C
         r9KdmHCiqC/TpzYEsbFEZcjwM302iDLnsKx1Mfr3jGz9qHwXePrkWUhWCJaN8O457X6l
         vMSRWKaKyZWKyVpqj2KcMbZ6iLoPiJV0D0EXAsyo3umHKXWLQG4B6aDRfOzsLszIObsz
         tMtAXp3mEnZwLbMMsJVF0u5YSGdezOlYdpgeX3Q2ERx5WeVsvlZG0Fze9+lmc9P3iCOT
         5QTaxpNsHkmJJl3MYiaSZ35osmk95qZUowgxPkjZrCogWPg1tsbCoqEfW6iUkdGA7dHt
         J+qw==
X-Forwarded-Encrypted: i=1; AJvYcCVAgjRSbKRhzrXX6FniOe0iGhAKS5/DK/QRpTHeMxJIyzIU99BGLJPfORjiR1FG9pm22enBMCYMWEjzrcKbnKIcDEMtEW5YmywalgkeQlPg9ShEe8xrormUFXU22nnQ2QxmPMCftZJnlO4=
X-Gm-Message-State: AOJu0YxbU/cwdZ02XG4924ES069z2WHgDHWYXmuhHsaqRn2+eUef5hdk
	QWAeWPdcig6eqOjpmwuOBMysdQRqL5CBsBOp/HKlmT4AIbhLUUTE
X-Google-Smtp-Source: AGHT+IFEGhOOBV1ZTJYRr4DLgBCZdFz1cpcM9DEyzw4fbZQHquBbRkpeUIM1eWZ812Z7PpQ5FKAM2g==
X-Received: by 2002:a05:6a20:9146:b0:1a9:d6e2:66e9 with SMTP id adf61e73a8af0-1afc8d8e5dbmr2724605637.28.1715172007480;
        Wed, 08 May 2024 05:40:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2-20020a056a0000c200b006eb3c2bde43sm11019014pfj.205.2024.05.08.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 05:40:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 May 2024 05:40:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrei Aldea <andrei1998@gmail.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HWMon: LM80: Add "support" for Texas Instruments AMC80
Message-ID: <0d71a8ec-2d14-4937-95f3-04332b7fbb78@roeck-us.net>
References: <20240508090244.18070-1-andrei1998@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508090244.18070-1-andrei1998@gmail.com>

On Wed, May 08, 2024 at 04:02:44AM -0500, Andrei Aldea wrote:
> Add support for AMC80 which is register compatible with LM96080 and a result of TI's acquisition of National Semiconductor
> 
Line length. Also, "and a result of TI's acquisition of National
Semiconductor" is irrelevant.

> https://www.ti.com/lit/ds/symlink/amc80.pdf

This should be added to the documentation, not to the patch
description.

The subject should start with "hwmon: (lm80)", and please drop the quotes
around "support".

> 
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
> ---
>  drivers/hwmon/Kconfig | 4 ++--
>  drivers/hwmon/lm80.c  | 6 ++++++

Chip description (Documentation/hwmon/lm80.rst) needs to be updated as
well.

>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 83945397b6eb..f901ece2ff43 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1446,11 +1446,11 @@ config SENSORS_LM78
>  	  will be called lm78.
>  
>  config SENSORS_LM80
> -	tristate "National Semiconductor LM80 and LM96080"
> +	tristate "National Semiconductor LM80, LM96080 and compatibles"

		"National Semiconductor LM80 and compatibles"

>  	depends on I2C
>  	help
>  	  If you say yes here you get support for National Semiconductor
> -	  LM80 and LM96080 sensor chips.
> +	  LM80, LM96080 and Texas Instruments AMC80 sensor chips.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called lm80.
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index 63c7831bd3e1..0355b9d849be 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -573,6 +573,11 @@ static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
>  			return -ENODEV;
>  
>  		name = "lm96080";
> +
> +	/* Check for  AMC80 version which is register compatible with lm96080 */
> +	} else if (man_id == 0x80 && dev_id == 0x08) {
> +		name = "amc80";
> +
>  	} else {
>  		/* Check 6-bit addressing */
>  		for (i = 0x2a; i <= 0x3d; i++) {
> @@ -624,6 +629,7 @@ static int lm80_probe(struct i2c_client *client)
>  static const struct i2c_device_id lm80_id[] = {
>  	{ "lm80", 0 },
>  	{ "lm96080", 1 },
> +	{ "amc80", 2},

The driver_data values are unused and therefore unnecessary.

However, I did not have time to check the chip datasheet to confirm that
chip specific code is indeed not needed.

Guenter

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lm80_id);
> -- 
> 2.39.3 (Apple Git-146)
> 
> 

