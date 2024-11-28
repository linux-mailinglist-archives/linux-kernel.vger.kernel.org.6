Return-Path: <linux-kernel+bounces-424204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A10D9DB198
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCCB2B219F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58037404E;
	Thu, 28 Nov 2024 02:52:43 +0000 (UTC)
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04412E406;
	Thu, 28 Nov 2024 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732762363; cv=none; b=dmHrzL5q8QZLLyfV0PoMVrTpZi11upeQKOB55SjhMZqTyPg69vqI2VJ5BYbpyEwvym0MzBEEMk8ASHR/if3yru8ASrCszswLMja0KJOWoGf3WzzBf8Ou82jdUGh9Pqp5XJyq5RlZnZy2n5+aIMxcVEI2GtRx0OWQwgaDsH5z8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732762363; c=relaxed/simple;
	bh=SCA/ejFWinklGoM5zpkaUb12rYzzPHgjMWU0Kdg36pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjmpmG5UurV4sTB2ZGGfEVcaDi0wWwRad0fSnl1TfK/UNygz93FuTGoeNsmSHogPm+0BrfDMNZkVyZQqywzIAN5SLtwzclMhYDhtvm2mv+Wz3Q16TPCsHafsQXa6qJGmg+QPRpIT6KKNvZ7V8dTW+AVhDMoZ8GdRx1rAy4A3xOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.18.1/8.18.1) with ESMTPS id 4AS2dEBm011120
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 28 Nov 2024 13:09:16 +1030
Date: Thu, 28 Nov 2024 13:09:14 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Abdul Rahim <abdul.rahim@myyahoo.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fujitsu-laptop: replace strcpy -> strscpy
Message-ID: <Z0fX0hwv51LY2AZV@marvin.atrad.com.au>
References: <20241127203710.36425-1-abdul.rahim.ref@myyahoo.com>
 <20241127203710.36425-1-abdul.rahim@myyahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127203710.36425-1-abdul.rahim@myyahoo.com>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Thu, Nov 28, 2024 at 02:07:07AM +0530, Abdul Rahim wrote:
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors.[1]
> 
> [1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> 
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> ---
>  drivers/platform/x86/fujitsu-laptop.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index ae992ac1ab4a..a0eae24ca9e6 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -505,8 +505,8 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
>  		return -ENOMEM;
>  
>  	fujitsu_bl = priv;
> -	strcpy(acpi_device_name(device), ACPI_FUJITSU_BL_DEVICE_NAME);
> -	strcpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
> +	strscpy(acpi_device_name(device), ACPI_FUJITSU_BL_DEVICE_NAME);
> +	strscpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
>  	device->driver_data = priv;
>  
>  	pr_info("ACPI: %s [%s]\n",
> @@ -891,8 +891,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
>  	WARN_ONCE(fext, "More than one FUJ02E3 ACPI device was found.  Driver may not work as intended.");
>  	fext = device;
>  
> -	strcpy(acpi_device_name(device), ACPI_FUJITSU_LAPTOP_DEVICE_NAME);
> -	strcpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
> +	strscpy(acpi_device_name(device), ACPI_FUJITSU_LAPTOP_DEVICE_NAME);
> +	strscpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
>  	device->driver_data = priv;
>  
>  	/* kfifo */

This looks good to me and is a useful improvement.  Thanks!

Acked-by: Jonathan Woithe <jwoithe@just42.net>

