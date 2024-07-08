Return-Path: <linux-kernel+bounces-244850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B5B92AA4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E21B2202F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1524B2261D;
	Mon,  8 Jul 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="dAWt6+XE"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C01BDD0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469174; cv=none; b=YrdLoadSlhnQ2lPxR8/yw2J206r24gHHigbysK9Zk9+Q3k1Gn5cmiQaIi0jU2egpPb0U1fvgbnFdCibrXu1uOLMLjof16xCr/9XByUH5vk5/1k9FGwsL7gtzHFPNyDReVZ9xmUlB4Jg0RuKZhWFD2RoUsCZ7H11+wOhjAH+4uvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469174; c=relaxed/simple;
	bh=Rb8pK4bcgsh7Jcc62mQtYB7d7vvGePU09yswm0BW+JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB/YNv/4FamRHcvRt+yJk1eMPvRPDJW3iMpelCAzd8OjyoLoZ5Rh/jo+63MxF9CY88uqc1h1Isu8HK02aKkEKxQ7iUxju+rEgsBKFFEs6EMkPrzutXl4A+J6ZXyPO6YHDrX0whIuYFRI7gWAQVQXSGI7JrpqoG9GAg3bznYoA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=dAWt6+XE; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d928fa9586so1232230b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1720469171; x=1721073971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT3BoGht7MDiQ2sKnuW3oqH0kk6WkmSkEQOa9yN3mT4=;
        b=dAWt6+XEYtGY0YGLocdGGif+FdCeJTypU/AcLiser9mk5uwRkGspQDujKTcRVOgsPq
         VpVqEhQlnzS/li+UX2cf9P0/Y9OrZWVA02qVXKJ9SAD6itKmvqkBQdDWLHY4wWuUGCWL
         Y4liaF/OW71K94vDIIaZyzdngvE8e26yIld4epzBeuLrplhwsJkO6iEKnlFx58oEz4zW
         iUwX4RLUxCXf201x+YhOACRpbsgbs8Xg/I+Bq5A7KgHxtIk/txDJmwfiwObzC4cfwtCF
         meblQ1KzptZuYaowuWVnWJ+5xabx21YzSSjvrzW3Wo2SQbmqNksH0jfQ3OK5VV79MTI9
         hqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469171; x=1721073971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT3BoGht7MDiQ2sKnuW3oqH0kk6WkmSkEQOa9yN3mT4=;
        b=hn9chjHBaHyeOWRtvyjcroEDn4IfNLGhF1LQRTL7awt4c6hsM5Kg0/hNj6YHsEKZfb
         l7aDl11BVk+Dre87Y+ucyqIWc0T1EZGgjFK560eJRNsMPekzHEAX8XcAa8LiliUupH9R
         TcTq2CBSqM4lvHMss9uJ9gv5Y15T18cu9ASWI/bJQhcu5o/RVqLf9sVWygWdS5zPzwIL
         7Vb4uiKRFbKsHHhr8tM3X3gTTGBpUePwB7sGjolV7JZpPuWxQULNkIRbRd+B0Z1CgsMO
         iNLJ6hhO1yfujgxQTGpFcy+G+VMZqGYkpn7CS6315AbZIR12GJhHpsgkG4p6oqJ8WD1T
         BZrw==
X-Forwarded-Encrypted: i=1; AJvYcCUkgJX/m7rzIKoguVPe9fWwx/tcVrAlI6K0a/v4KCPyxUICZCq+mjLeYlftvlWiS3sx8znDfl7fzQP6S1kFAOWpUyZU79o75gUaLwy6
X-Gm-Message-State: AOJu0YzIr6Se801q5sOcQeY8FNzuGYgQta6XYV3yvoVWKAqmsr/0Zvyo
	Ehuy6lu/6BtxMzENtd9UeWekBc37FnOXUTB9OLbDqZZoNtoG4GPIJPHlwpdKe1c=
X-Google-Smtp-Source: AGHT+IE4oTv5nlTr+ZYjb3suPY2974lpOVzXcklRhNhSxddMJzpIkvMo3L4ZPRzyT17kor2vaVQLXA==
X-Received: by 2002:a05:6808:201b:b0:3d9:31d9:f447 with SMTP id 5614622812f47-3d93c046f04mr512139b6e.25.1720469169394;
        Mon, 08 Jul 2024 13:06:09 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:f295:d317:eb7e:d88e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff4d9sm115349b6e.5.2024.07.08.13.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 13:06:08 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:06:07 -0500
From: Corey Minyard <corey@minyard.net>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Corey Minyard <minyard@acm.org>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <ZoxGrySzTwCYnhFf@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20240708150914.18190-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708150914.18190-2-u.kleine-koenig@baylibre.com>

On Mon, Jul 08, 2024 at 05:09:12PM +0200, Uwe Kleine-König wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> While at it, also remove commas after the sentinel entries.

I've pulled this into my tree.

Thanks,

-corey

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 4 ++--
>  drivers/char/ipmi/ipmi_ipmb.c    | 4 ++--
>  drivers/char/ipmi/ipmi_ssif.c    | 2 +-
>  drivers/char/ipmi/ssif_bmc.c     | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> index 49100845fcb7..7296127181ec 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -350,8 +350,8 @@ static void ipmb_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id ipmb_id[] = {
> -	{ "ipmb-dev", 0 },
> -	{},
> +	{ "ipmb-dev" },
> +	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ipmb_id);
>  
> diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
> index 4e335832fc26..6a4f279c7c1f 100644
> --- a/drivers/char/ipmi/ipmi_ipmb.c
> +++ b/drivers/char/ipmi/ipmi_ipmb.c
> @@ -561,8 +561,8 @@ MODULE_DEVICE_TABLE(of, of_ipmi_ipmb_match);
>  #endif
>  
>  static const struct i2c_device_id ipmi_ipmb_id[] = {
> -	{ DEVICE_NAME, 0 },
> -	{},
> +	{ DEVICE_NAME },
> +	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ipmi_ipmb_id);
>  
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 3f509a22217b..96ad571d041a 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -2049,7 +2049,7 @@ static int dmi_ipmi_probe(struct platform_device *pdev)
>  #endif
>  
>  static const struct i2c_device_id ssif_id[] = {
> -	{ DEVICE_NAME, 0 },
> +	{ DEVICE_NAME },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ssif_id);
> diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
> index ab4e87a99f08..a14fafc583d4 100644
> --- a/drivers/char/ipmi/ssif_bmc.c
> +++ b/drivers/char/ipmi/ssif_bmc.c
> @@ -852,8 +852,8 @@ static const struct of_device_id ssif_bmc_match[] = {
>  MODULE_DEVICE_TABLE(of, ssif_bmc_match);
>  
>  static const struct i2c_device_id ssif_bmc_id[] = {
> -	{ DEVICE_NAME, 0 },
> -	{ },
> +	{ DEVICE_NAME },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ssif_bmc_id);
>  
> 
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> -- 
> 2.43.0
> 

