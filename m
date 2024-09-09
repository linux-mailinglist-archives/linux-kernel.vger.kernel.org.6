Return-Path: <linux-kernel+bounces-321937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3C97217C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA451F2467A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F00117DFE1;
	Mon,  9 Sep 2024 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHR1B9/L"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C2917D358;
	Mon,  9 Sep 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904788; cv=none; b=ounBucNj1pRRhvW19jZkkSFIv9rChUeUsKy8qGapg6y0s6P/ZmIs+w/5kZTrA8dtbQ098hkR8Q/oB0m02AiirOfbhwa4s7Efkn2lT5bsbF8HKSHludcE4BMZsd7PpPYlLIgf9ndKWv8uWE9BiozR0H93qZZIh/MfqrX/XxE5wuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904788; c=relaxed/simple;
	bh=Spblu/b7fbaafHMLazWInCo3KPyMeqFEOsS6kWcRrBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9yJFrdnvZ0ZHtuVnIAwTQtRH0YumcSsipSDsNCNrdS8GeioVCeLsf5ap4inBMgL4P4vazgy+wagJysBmnGiTMuwjVyiHYYAI74ZuTUBdwjV9li1ZoX7IaYilA76hqxXgm6iWz/sCQTPe5ecJO7Kov3AbZJsCWhNFk+E5Ui0wtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHR1B9/L; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e3c98b5aso1737592b3a.0;
        Mon, 09 Sep 2024 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725904786; x=1726509586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=an4WbXnZCshYsj7wuuFqHvHpa6KknkRHt97svu08IWw=;
        b=lHR1B9/LZH7rrF3ohhv1akBsUq+Y/oYZ071HYNKWOmRXLd2nAFMXJETJ+x9bxNl6kJ
         vFDGVIRWX15Gv+rCjRWHeH2CzJk/MTfexWB0kw9P4ugTAX5zGx1RRXmM3feaO7CfKH+1
         xgFYGiMiEAT+lNFiTfP14Wj/a7F9wvXMMw8B2s0JRI5R6BtOtidI4y2FKLClNS96tYEO
         CVaSjIgg7mAx7wLXuGLP/oe7wJqCHnRplzTvTec8kn9yz53qhNqHUV8g+vCeiMw1We5h
         QBkh8T1ffIQZhvoTayMiLebJyEDk+Ev4HgAto/oMfyzqJwLTOxiKnMCS+IKC3B8oaLwg
         pkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725904786; x=1726509586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an4WbXnZCshYsj7wuuFqHvHpa6KknkRHt97svu08IWw=;
        b=VjaOp/WlXn4SaLXTHKHs7pTWI0SSGEr+38ro7dQVSIefUSeRw3BtqctlOUmnaNSBR1
         HK8HQhzuwyCQjwytgrgMcc9saxOSiZNGvucZoaGUWjQ0RY8+k8GPf/rNfb5z6f0cYbZr
         /v7DNU8pd/k+TTgyziYgI8DrGu+34OGEyvG5+/srAEpHpKohd3VrMpG4zuWzcY7KIEPy
         L0gLWHdwpAgXytmZKWaZZizJU60s4hJKWITBGxHYaOGmrH03byDCQj4H5oh7zLKUFGjt
         KW4Z53LZZkudzwbEj0dxxiYOMYe4fA0+TIdoMD5qYnhAADsBxK3zgquGcmpHbB01380b
         kLdA==
X-Forwarded-Encrypted: i=1; AJvYcCU4XK9Trmoo14z/BnnfldlVOl55S8nzzbWfqAxIQAuXTbyDa00bHT5U/0a6zP1E7jHZ+jSsCf+aEd/DrA==@vger.kernel.org, AJvYcCXIOX1u22rZwBsdqcL2lFvqDFt6UZiMqviKnrnhrGWbU4eVvfwfKnIl2NRpbJPMgyk3YXh7SToqBypSduV6@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNBnCUSOnbPzftJszpK9s6cq4107VeJxlFe1OjolEZnUD6bYJ
	B2AEdSEDSipW6qMCkGjESu5nKjS+OPkKH/+SrTDxDJUpZa1NClkKXDLpLg==
X-Google-Smtp-Source: AGHT+IHcTIRmFzmyRlXB4SPcA/ReMZ1aFsulFSa2bDFxCLVbLByAYew953IUlnQMGH9PsDGJb86TcQ==
X-Received: by 2002:a05:6a21:648b:b0:1cf:3ec5:e779 with SMTP id adf61e73a8af0-1cf3ec5e866mr3382575637.5.1725904786172;
        Mon, 09 Sep 2024 10:59:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8255dc23fsm4313971a12.58.2024.09.09.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 10:59:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 9 Sep 2024 10:59:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Conditionally clear individual status bits for
 pmbus rev >= 1.2
Message-ID: <9f6fd5f4-ded1-456e-b4ee-264eed09b867@roeck-us.net>
References: <20240909-pmbus-status-reg-clearing-v1-1-f1c0d68c6408@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909-pmbus-status-reg-clearing-v1-1-f1c0d68c6408@gmail.com>

On Mon, Sep 09, 2024 at 11:30:28AM +0200, Patryk Biel wrote:
> This change adds fetching PMBus revision and using it to conditionally
> clear individual status bits while calling pmbus_show_boolean, only if
> the device is compliant with PMBus specs >= 1.2.
> 
> Signed-off-by: Patryk Biel <pbiel7@gmail.com>
> ---
> Current implementation of pmbus_show_boolean assumes that all devices
> support write-back operation of status register so as to clear pending
> warning or faults. Since clearing individual bits in the status registers
> was introduced in PMBus specification 1.2, this operation may not be 
> supported by some older devices, thus resulting in error while reading 
> boolean attributes like e.g. temp1_max_alarm. 
> 
> This change adds fetching PMBus revision supported by device and
> modifies pmbus_show_boolean so that it only tries to clear individual
> status bits if the device is compilant with PMBus specs >= 1.2.
> 
> Tested on: LTC2971, LTC2971-1, LTC2974, LTC2977.
> ---
>  drivers/hwmon/pmbus/pmbus.h      |  6 ++++++
>  drivers/hwmon/pmbus/pmbus_core.c | 12 +++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> 
> ---
> base-commit: c763c43396883456ef57e5e78b64d3c259c4babc
> change-id: 20240905-pmbus-status-reg-clearing-abc9c0184c3b
> 
> Best regards,
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index fb442fae7b3e..0bea603994e7 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -418,6 +418,12 @@ enum pmbus_sensor_classes {
>  enum pmbus_data_format { linear = 0, ieee754, direct, vid };
>  enum vrm_version { vr11 = 0, vr12, vr13, imvp9, amd625mv };
>  
> +/* PMBus revision identifiers */
> +#define PMBUS_REV_10 0x00	/* PMBus revision 1.0 */
> +#define PMBUS_REV_11 0x11	/* PMBus revision 1.1 */
> +#define PMBUS_REV_12 0x22	/* PMBus revision 1.2 */
> +#define PMBUS_REV_13 0x33	/* PMBus revision 1.3 */
> +
>  struct pmbus_driver_info {
>  	int pages;		/* Total number of pages */
>  	u8 phases[PMBUS_PAGES];	/* Number of phases per page */
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index cb4c65a7f288..50ba093a38e8 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -108,6 +108,8 @@ struct pmbus_data {
>  
>  	int vout_low[PMBUS_PAGES];	/* voltage low margin */
>  	int vout_high[PMBUS_PAGES];	/* voltage high margin */
> +
> +	u8 revision;	/* The PMBus revision the device is compliant with */
>  };
>  
>  struct pmbus_debugfs_entry {
> @@ -1095,7 +1097,11 @@ static int pmbus_get_boolean(struct i2c_client *client, struct pmbus_boolean *b,
>  
>  	regval = status & mask;
>  	if (regval) {
> -		ret = _pmbus_write_byte_data(client, page, reg, regval);
> +		if (data->revision >= PMBUS_REV_12)
> +			ret = _pmbus_write_byte_data(client, page, reg, regval);
> +		else
> +			pmbus_clear_fault_page(client, page);
> +
>  		if (ret)
>  			goto unlock;

That check needs to be part of the if() statement above. Never mind, though,
I fixed that up.

Guenter

