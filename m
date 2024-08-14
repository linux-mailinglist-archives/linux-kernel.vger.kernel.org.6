Return-Path: <linux-kernel+bounces-285813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDF495130F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21B11F26977
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73F38DCD;
	Wed, 14 Aug 2024 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPe3xM9t"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12044393;
	Wed, 14 Aug 2024 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605738; cv=none; b=YuXoQaS6Dc5yQiTYvxkLAMoVsp+F8EmBY/PMMwS4OMC2VLtGyxQP4Vtm5UP7pXlbyAYuLIxcypbX/3rYXk0b/1myBtCim7GhncOeFwviOuV1ajzbfbCIbAGPC725a0SYEXCAwwADruY+rXJPPlxt6NElinO8KOvXzuOhDaX81Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605738; c=relaxed/simple;
	bh=Bq2rwoV3DJNXF5DuNTP6iQ3ziFHiCV0P+RusrqnBTGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1u1/rHehtGckYvt9ntgU4se9pB5ElOASYqcWI42FYL01S2w9yIWSXRLTBP13XJ4O0JtzQl0KwGT8fhAUr+tdAILuDoA6LwBJ1dkT5HhO1gBzUnGWsTAiHUsqozi/ndq+qb7CAF4orRCRnjrp4557aCSM6hyO6fVJAMCC3Iyd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPe3xM9t; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fed72d23a7so48054975ad.1;
        Tue, 13 Aug 2024 20:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723605735; x=1724210535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzlw7I4QEK/KUdzHWybZchWTO/3Svcx3FSYnmM5hd/0=;
        b=ZPe3xM9tLyzvfpLN5IvJN4APSU/Maqmwk++symmysoA4Or9T3j6gG63w1aPQYLBuex
         XRgj9fy1s+76GWYX7Cn9qztQCDunhME5t9FpidGRWqXO7293NUagbCV65NMyDstiMPqC
         9Efp26MjYHPLaou5HiUyovdLHUvUEJSJBcHVcQvQRqD8KqPlYi3eFm7+5NFPw/i2icDP
         xMpF2xfSMGUPFwg1/tXYxzsD1cxY32TOnZ8gFaGwqjoNt4eT/rscPxbd+Ec5xdRQh8CX
         yPp8z0yf+MDOgs8attNtyVat5JB/j3hml/8F2OPpt3pqv4YnuJj5QI3OS61kKTgKVIXw
         TTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723605735; x=1724210535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzlw7I4QEK/KUdzHWybZchWTO/3Svcx3FSYnmM5hd/0=;
        b=KXQC3YJXDLka28CkC3KXLEnMbmsTHNlFSk9RMwMJ7ucOrBrzerylU8qdmfzfw1a3zY
         eIN3lBlebxlva1tauqu6Lv+ByLqrIkZHC6QS8ABqTwFufOcmfTHp/cBAu/IcCbsUIqO9
         5zaaH4MFrfE6hc4/w2JRL5H+evJMn9plgzw5WtAeuOspPwUnQytOU4GypaNs1gmJyaOj
         4MfNbKSm85SND84xAVQfTTncv2Iygs7rqKg0DcWOmj4m1m5hZUks80XIVL+q+n0veazv
         h3/0yz0QEsiBOuehmnIkQS5UsrOyz5+YKUtOFPicMwVeS+gt+NjWpTTTuU8BiyEeVsXL
         9T2g==
X-Forwarded-Encrypted: i=1; AJvYcCUYfo39I+Vb9eC9dPriX6QjEbJEkZ7nEcPIZfnVdjevmqCUTWMm1v2Jf0q+YX6VkGtPtoPN+Q+WmqV1R3hQ8ZQbifiM515iJITmZejd
X-Gm-Message-State: AOJu0YxrHWchJIiqRR3p172VQlBjE+ChaMfhAjHL+vNmI8pWdglfMc+V
	TIFK3vVQbKddhYBeYs4d5eY2w1uZRYkxK/SKGhIvmGaKDOpccleb
X-Google-Smtp-Source: AGHT+IGchMjccUN4yjcn6lmsvWWGr2UaiDfscWHs7/cWfC3VFUZScjTL6i0Sl453aNEYPyrY/hYm+w==
X-Received: by 2002:a17:902:d0c2:b0:1fd:a980:5b77 with SMTP id d9443c01a7336-201d646b439mr13263285ad.36.1723605735035;
        Tue, 13 Aug 2024 20:22:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1e29e9sm20311325ad.305.2024.08.13.20.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:22:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 13 Aug 2024 20:22:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	tharvey@gateworks.com, jdelvare@suse.com
Subject: Re: [PATCH -next] hwmon: (gsc-hwmon) fix module autoloading
Message-ID: <0f0971ca-09dd-4c51-944a-1f05e0a72a32@roeck-us.net>
References: <20240814024555.3875387-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814024555.3875387-1-liaochen4@huawei.com>

On Wed, Aug 14, 2024 at 02:45:55AM +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/gsc-hwmon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> index cb2f01dc4326..4514f3ed90cc 100644
> --- a/drivers/hwmon/gsc-hwmon.c
> +++ b/drivers/hwmon/gsc-hwmon.c
> @@ -400,6 +400,7 @@ static const struct of_device_id gsc_hwmon_of_match[] = {
>  	{ .compatible = "gw,gsc-adc", },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, gsc_hwmon_of_match);
>  
>  static struct platform_driver gsc_hwmon_driver = {
>  	.driver = {

