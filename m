Return-Path: <linux-kernel+bounces-187629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3A98CD58A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D471F21F85
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B714BF8D;
	Thu, 23 May 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggjOCQnj"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF68062B;
	Thu, 23 May 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474005; cv=none; b=g7u7aSCiy24nVNai49dv/7oSTFRODCfQRDrm07pn4ExJioPKoR+ijhAHhcqmgZa54jfV/TnnE7UzOY3LJuYZSJMvRJlMl6ZV9JFYLLO49/moQd3EtlbmvzhsW7K1AH4rBzEDiUMu9R4gVYVHsi0XhHU/NLE6YPPdEmf6P5me/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474005; c=relaxed/simple;
	bh=rPz+2+2odSGZZsR/UVJBHK4dWdAkJs05sWtk+mmDDV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2GXTBF1UJaMDcSMiyqWGa2ypl27A9z2yOy66RbjFBW4mCf3LPjNPYe3Z90nsjxZ8YLDiqAXTuIBcVDdQN87IIyQGoDL21pwEv/8ked5Ub/VCvMBY2u/VfFpNGJ9Qe5o2PkFZ24Ybu2jQVnOFE4FiYJ5fe88a+U/YARtGoxOaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggjOCQnj; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36c72dbed20so26250275ab.2;
        Thu, 23 May 2024 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716474002; x=1717078802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFQNNvCtUUkqzbWEAnyeT+knpErSedpV4MAfCK/icOs=;
        b=ggjOCQnjK9E30gOYyk4KOpTmi6YnQPJk23x4CRCkFbi5oFzpmeE57QaTnEGuhLN4E+
         5XUdfnGbsYFCeyBmfe0xncNsUe2MNmKGhFdcKS6pfqJNc+FgadU62RR4yjZcyrBjJCyU
         Izpdw1II8YjDxBIx/o4yEDJCnEcF2DIBHlYDiFcRwkt72NZ2YKRvrzqNnx20rCAWCKIp
         1P+h8vojtycjpVw65rtczi67viKt/qiAMAi0/wfDkEcciPilNledzLw1tZJKV885ULQE
         GKDIO+WaL/kGiQ+zFvP8JEC/qnVKBdNB/i+UGbFIK3zTfzb5HEZTh9JnT3+aIH4OpadF
         BoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716474002; x=1717078802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFQNNvCtUUkqzbWEAnyeT+knpErSedpV4MAfCK/icOs=;
        b=tPLekCsyXikLviwnv9XcRNbXk8zo880e1NXO1AqsdbWRQNN7/ewLfGzhcT7kkdqWqy
         IlNTRb+NuI37LSDuBndJUh4AfUpJspfqkSRqWARaWXnQ+yyTWYyzp/XRPOvLuc/xmq2g
         Hv4AAyZmdlORmK0XueIc5UQA6tJD+PxAkp9o7WhbpYBvZwuFLL2ZRmNcrfJk9WIP+/ud
         HOo9ZQUuwQOqoo+Bq6pcywaYwlbX0qETsj1r5DQRvWWs+EdP3tex08f88qEhQGw5sjoz
         FnEtfTpQeKUB/5hj7a89gDiCXMRVw8rrGwVyh7lPlhQgsa0EeIsktpSDno9KKueqJINy
         QAWg==
X-Forwarded-Encrypted: i=1; AJvYcCUAJKHifwXnIydIeYpPMekJKSPa9onfXhZPzB8MopkkYymvA0fA6aH+2nEnxh6qma1Y4CryKaAmPKcNPZuBND/yWyF2iLh0o6q73zQeT1p1HykU5dCMUaBz6mrMBehzHCt4QKRB1MZ1THr9vMvzA/4KnB/CDSiWBL2q2kAbrs105gMcTjc=
X-Gm-Message-State: AOJu0YxxQiRAUE2yCaayCQTkS82HCUPe7fB+cHC35qoPrfiK3swmwGmO
	fwxopP/qyr+GBUPthIKngjkU3DPpDoNl8BaXc9SkN/LwtG7pmzMS
X-Google-Smtp-Source: AGHT+IF3q4gP0ZMN+Px/RH+bvXi+q/5uAlLRWD99Iu6HqXvFKhniwBAinvoUcRqFeNCHz1HCOBqDwQ==
X-Received: by 2002:a05:6e02:1a8b:b0:36b:3799:a99 with SMTP id e9e14a558f8ab-371fc8d76c3mr58671495ab.28.1716474002301;
        Thu, 23 May 2024 07:20:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8ce4b2b6bsm153562b3a.180.2024.05.23.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:20:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 23 May 2024 07:19:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: hwmon: max31827: Add PEC support
Message-ID: <e52a86de-ead6-40d3-b652-461a90bd5942@roeck-us.net>
References: <20240523121057.5689-1-radu.sabau@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523121057.5689-1-radu.sabau@analog.com>

On Thu, May 23, 2024 at 03:10:56PM +0300, Radu Sabau wrote:
> Add support for PEC by attaching PEC attribute to the i2c device.
> Add pec_store and pec_show function for accesing the "pec" file.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---

Change log missing.

>  Documentation/hwmon/max31827.rst | 13 +++++--
>  drivers/hwmon/max31827.c         | 64 ++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> index 44ab9dc064cb..9c11a9518c67 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -131,7 +131,14 @@ The Fault Queue bits select how many consecutive temperature faults must occur
>  before overtemperature or undertemperature faults are indicated in the
>  corresponding status bits.
>  
> -Notes
> ------
> +PEC Support
> +-----------
> +
> +When reading a register value, the PEC byte is computed and sent by the chip.
> +
> +PEC on word data transaction respresents a signifcant increase in bandwitdh
> +usage (+33% for both write and reads) in normal conditions.
>  
> -PEC is not implemented.
> +Since this operation implies there will be an extra delay to each
> +transaction, PEC can be disabled or enabled through sysfs.
> +Just write 1  to the "pec" file for enabling PEC and 0 for disabling it.
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index f8a13b30f100..e86f8890ee72 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -24,6 +24,7 @@
>  
>  #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
>  #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
> +#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
>  #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
>  #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
>  #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
> @@ -475,6 +476,54 @@ static ssize_t temp1_resolution_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(temp1_resolution);
>  
> +static ssize_t pec_show(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
> +}
> +
> +static ssize_t pec_store(struct device *dev, struct device_attribute *devattr,
> +			 const char *buf, size_t count)
> +{
> +	struct max31827_state *st = dev_get_drvdata(dev);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned int val;
> +	int err;
> +
> +	err = kstrtouint(buf, 10, &val);
> +	if (err < 0)
> +		return err;
> +
> +	switch (val) {
> +	case 0:
> +		err = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +					 MAX31827_CONFIGURATION_PEC_EN_MASK,
> +					 val);

While correct, this is misleading. Should write 0.

> +		if (err)
> +			return err;
> +
> +		client->flags &= ~I2C_CLIENT_PEC;
> +		break;
> +	case 1:
> +		err = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +					 MAX31827_CONFIGURATION_PEC_EN_MASK,
> +					 val);

This is wrong. s/val/MAX31827_CONFIGURATION_PEC_EN_MASK/

Guenter

