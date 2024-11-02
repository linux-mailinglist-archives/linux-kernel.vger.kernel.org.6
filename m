Return-Path: <linux-kernel+bounces-393560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CF49BA25B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BAB1C21EBD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E21AB6DD;
	Sat,  2 Nov 2024 20:02:10 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A513BAF1
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577730; cv=none; b=UveD+EWkY2iq3r+zgllaWB78C5Sl+UV7HeBs10WXFKcC1yQ/tb3jrfSGaz4/xm7feHQYCBzfVvKaS66+wYk6fNaoeSeLi1r4tqFPljrb6a+Vp/1OMlEp3wPLZK4Vf6XxWD60Wl37mISMLN0z/2m8FJhTf3zeMqDL0//xJo7Blwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577730; c=relaxed/simple;
	bh=DtP5FSIkG2PIybT2p8GApK3yMLeLjIu4VMFq5eFVZPw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxAVJFmEozKmYGnVe/ar89Lj5ARCM3hgKo2gvRDYG1HMbPJmW2OJzyAGispJ9iUpAwBuFmxlTk1VzGqBRkrPfwiR+jUWjgzrpa44PyHVv2/o0Jsi49z1NfcaCBzmrp2n613yNmjqsOFbxRuy3etgtIB9izUCyra9D1wcecYkm3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 516c248d-9955-11ef-968f-005056bdf889;
	Sat, 02 Nov 2024 22:01:59 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 2 Nov 2024 22:01:58 +0200
To: victor.duicu@microchip.com
Cc: matteomartelli3@gmail.com, jic23@kernel.org, lars@metafoo.de,
	marius.cristea@microchip.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Message-ID: <ZyaFNsuWOOK1HHg0@surfacebook.localdomain>
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

More comments below.

...

> +#define PAC1921_ACPI_GET_UOHMS_VALS             0

uOHM ?

#define PAC1921_ACPI_GET_uOHM_VALS             0

...

> +/* The maximum accepted value of shunt_resistor in UOHMS <= INT_MAX */
> +#define PAC1921_MAX_SHUNT_VALUE_OHMS		2147

Instead of the comment do it like this:

#define PAC1921_MAX_SHUNT_VALUE_OHM		(INT_MAX / MICRO)

Need to include limits.h and units.h.

...

> +static inline bool pac1921_shunt_is_invalid(u32 shunt_val)

is_invalid is confusing name, make it rather is_valid

> +{
> +	return shunt_val == 0 || shunt_val > INT_MAX;
> +}

...

> +	/* This check is to ensure val * MICRO won't overflow */
> +	if (val < 0 || val > PAC1921_MAX_SHUNT_VALUE_OHMS)
> +		return -EINVAL;
> +
>  	rshunt_uohm = val * MICRO + val_fract;
> -	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
> +	if (pac1921_shunt_is_invalid(rshunt_uohm))
>  		return -EINVAL;

With the above check how this can't be a dead code?

...

> +	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1921_ACPI_GET_UOHMS_VALS, NULL);
> +	if (!rez)

Use status instead of rez for the variable name. This is kinda standard to keep
the return of ACPI APIs.

> +		return dev_err_probe(dev, -EINVAL,
> +				     "Could not read shunt from ACPI table\n");

...

> +	label = devm_kstrdup(dev, rez->package.elements->string.pointer, GFP_KERNEL);
> +	if (!label)
> +		return dev_err_probe(dev, -EINVAL, "Label is NULL\n");

We do not print an error for -ENOMEM, which should be here as the error code
(Jonathan already pointed out on this).

So, just

		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



