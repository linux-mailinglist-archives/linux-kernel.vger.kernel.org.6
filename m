Return-Path: <linux-kernel+bounces-393546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468659BA22F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 20:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C531F21AA8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031511AA7A9;
	Sat,  2 Nov 2024 19:48:22 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099114F12F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730576901; cv=none; b=aVal8sDO38TEUh1hzkJYNRqt8t0lTk54piu9XJ2P3Gufu/U7TATs+FRqe41U9hinQCBpa46E3l7BRqp9/spSVLAKnSkVZ6hTLaDapHArXVQuM/0Tf+uoWea1cX4jkQJVIIoFzprJ0cvzj7AgYJd5d4Iu5M7Q7U5tWhw4r95Y+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730576901; c=relaxed/simple;
	bh=L4xMV/8gYoMZk3Q3diI5SpjBN7teilAKah//V0XO1UI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3sNAnYDsLS3z2dIHvwwcobMH9cWcZhZHUyORs8fDMTa4bI0oudZGvC/+twZ0c7aFco81zSqic/olGFseW7z8hF6mDr0a+1OvKH8AmmfyVCwRZQ61OoJ4lgINDgaem2BjBCre0oO7XcqhqO7qP3OizWErtCqdcLjUZJ2YwIzalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6061fdeb-9953-11ef-8871-005056bdd08f;
	Sat, 02 Nov 2024 21:48:05 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 2 Nov 2024 21:48:04 +0200
To: victor.duicu@microchip.com
Cc: matteomartelli3@gmail.com, jic23@kernel.org, lars@metafoo.de,
	marius.cristea@microchip.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Message-ID: <ZyaB9G1baF10FzZD@surfacebook.localdomain>
References: <20241031065205.50154-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031065205.50154-1-victor.duicu@microchip.com>

Thu, Oct 31, 2024 at 08:52:05AM +0200, victor.duicu@microchip.com kirjoitti:
> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This patch implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and label from ACPI table.

This ID might be okay, but can we please have:
1) the list of the models (or a model) of the device on the market that has this;
2) ACPI DSDT excerpt of the respective Device object?

(I mean a laptop, tablet, phone or other device that has this sensor described
in the ACPI)

...

> +/*
> + * documentation related to the ACPI device definition

Documentation

> + * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
> + */

...

> +	if (ACPI_HANDLE(dev))

Hmm... Want this be really needed? You can try to call DSM. and if it fails try
DT (or actually other way around as we usually do).

> +		ret = pac1921_match_acpi_device(indio_dev);
> +	else
> +		ret = pac1921_parse_of_fw(indio_dev);

...

> +static const struct acpi_device_id pac1921_acpi_match[] = {
> +	{ "MCHP1921" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, pac1921_acpi_match);

Missing blank line here.

...

>  	.driver	 = {
>  		.name = "pac1921",
>  		.pm = pm_sleep_ptr(&pac1921_pm_ops),
>  		.of_match_table = pac1921_of_match,
> +		.acpi_match_table = pac1921_acpi_match


Missing trailing comma here.

>  	},

-- 
With Best Regards,
Andy Shevchenko



