Return-Path: <linux-kernel+bounces-378120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3E09ACB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 883CDB238A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66031BBBDD;
	Wed, 23 Oct 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIXp0aqe"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98401B85CF;
	Wed, 23 Oct 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691391; cv=none; b=HrNTLW/BQ0QTIQNbH1lw6eHlsBBRpCOkClv3FT5YCDlgFhHIfiE0KULjtX32qL0SgCQDM+cmYX0r8T2mmghA+8wjgQcre9e/JZCq9vG61cWj/Sw7WjJRRpiDK8OHQbvfgpV6ZOvDMqkrS4J2fNMrs3QwSqgjdU34TkrM3PiL8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691391; c=relaxed/simple;
	bh=xKp0eaOiB2mHMTBJ2N0B7iUuiJVPbKGUPlJRuSVNO3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g84MKS2k+cRUKc3/TCJAfMV3gNPJGSQZbeFIoWW/ELXndLDtuUOVNEgpuJ89xb20OWMESzDS0ku3J1HWNgMwdMfnDzD04XcOLz2MI3a6u3ceI1SMqXPzcDb6iweMdevJhIui5UwxgklFfORJAJYOBy92cfWwC/Jov7iRY5bMKv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIXp0aqe; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso7459336d6.1;
        Wed, 23 Oct 2024 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729691388; x=1730296188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1E9hSMuxhJivqZkBd/5Upa72MwomOmtz47hUjemKq0U=;
        b=OIXp0aqelk/fnlxovteTAg+9F5BphcMMBkf2EbuDFggD/RQqrCHpMzVHlqjvnZWvdX
         R3rqQTXZJvn4l+ovwH987b/wlIS98wIBRmGnYT8gzS1E0jU0bjjGTW5B89m4OvbnkFPK
         U3pjl3s5bXLQALuguUAq6OvQhLpph8Fu5QuYdIl7X45o+WqxE3yhz6dTTVBHdgMw3orC
         5t3VS2g0NF/eVzbBpnZZ7pY/kWQ/nZvkuJJPOHQw+2rXh4f9XOiHNF/aAkM9liG3ORoS
         wbZ2+dxLF3kOFSLz89T9rlhoy3j2+bpa5bL5ONgSnO+KaTgFPSwkTNRn6WP3A2TcvDJE
         O8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729691388; x=1730296188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E9hSMuxhJivqZkBd/5Upa72MwomOmtz47hUjemKq0U=;
        b=dBxWQc3D0V2QhrGnf8a8r8OyqNxBF27LvYiN1oBW9Q+ZDVfsenhhbXCrn9K1PciCiB
         wefojicCqil9Y+VYN+o2KISlQQmi9P+IVQsUxUpWJLU4KX0rcGau72o3ZbUknxkCtqkn
         R9WsXWqTb4/fK1h41hInaIoDW8wMXPLKgEIrWwhahZ9MSV4g/UfNmqdUhcIYbyAD8RBO
         mwMU5FmMaav8HYtQrIn7YPkIBJmDCVo6HgSPn7IvO62T67FWA0F72aZKggZZ1cEsfOrg
         G7DwSKfiDt5igIJ9yYeUfozsVW8EVhPANY6o1Q7OsmuVE6BKOTQbMNlfM+mbav1k93dq
         hpDw==
X-Forwarded-Encrypted: i=1; AJvYcCV3A5MwGcWQIFziQsWvKsY1vGmRdgYR3aT3Vji4M+Q/iweX0liE2FEM10jdH5RcH/V4UpMCBF8fwpJ/t48F@vger.kernel.org, AJvYcCXXisooVpZsitBxYe7EcKG2F8kdpdf7+P12VFCtsi3HXt7wcVq1DbphTimmJx7v+QiBMCqHC9J7ulKiYRJVVHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhp13PP3Rrnr2KfdOMI1oNl5rNi0N6lyiKh3bkVdZPzTNNLGU
	8y8Abf4gU1Dyo29VCCcKvSHBEh5AVVkZvwvdS8BgE6Kg4l8+nsfs
X-Google-Smtp-Source: AGHT+IHwhJhDy3VRo4azo5fv6sWbQE1FDHxxvau6WVw6GJudrJZpRkuESW6AiLhrRy7U3PBV/WrnGA==
X-Received: by 2002:a05:6214:29e1:b0:6cb:fc3f:6cc7 with SMTP id 6a1803df08f44-6ce21a7fdcdmr119843906d6.15.1729691388619;
        Wed, 23 Oct 2024 06:49:48 -0700 (PDT)
Received: from yoga ([2600:1001:b14e:1ecb:a95c:b3fb:e1a8:befd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0091ad77sm39274006d6.67.2024.10.23.06.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:49:48 -0700 (PDT)
Date: Wed, 23 Oct 2024 09:49:44 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Mehdi Djait <mehdi.djait@bootlin.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/sharp-memory: Fix some checks in
 sharp_memory_probe()
Message-ID: <x6dadpm2zmuuih4ndnpff5ljt2hy5geikjeejwy6v33qzaspsa@grxia5jw6y2j>
References: <0d307349-c141-49ee-8b34-67caf5f8b638@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d307349-c141-49ee-8b34-67caf5f8b638@stanley.mountain>

On Wed, Oct 23, 2024 at 11:30:31AM +0300, Dan Carpenter wrote:
> The devm_drm_dev_alloc() function returns error pointers, it never
> returns NULL.  Change that check to IS_ERR().
> 
> The devm_gpiod_get_optional() function returns a mix of error pointers
> if there is an error, or NULL if there is no GPIO assigned.  Add a check
> for error pointers.
> 
> Fixes: b8f9f21716fe ("drm/tiny: Add driver for Sharp Memory LCD")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/tiny/sharp-memory.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
> index 2d2315bd6aef..1bcdd79166a4 100644
> --- a/drivers/gpu/drm/tiny/sharp-memory.c
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> @@ -543,8 +543,8 @@ static int sharp_memory_probe(struct spi_device *spi)
>  
>  	smd = devm_drm_dev_alloc(dev, &sharp_memory_drm_driver,
>  				 struct sharp_memory_device, drm);
> -	if (!smd)
> -		return -ENOMEM;
> +	if (IS_ERR(smd))
> +		return PTR_ERR(smd);
>  
>  	spi_set_drvdata(spi, smd);
>  
> @@ -555,6 +555,8 @@ static int sharp_memory_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, ret, "Failed to initialize drm config\n");
>  
>  	smd->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(smd->enable_gpio))
> +		return PTR_ERR(smd->enable_gpio);
>  	if (!smd->enable_gpio)
>  		dev_warn(dev, "Enable gpio not defined\n");
>  
> -- 
> 2.45.2
> 

Reviewed-by: Alex Lanzano <lanzano.alex@gmail.com>

