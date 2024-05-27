Return-Path: <linux-kernel+bounces-190796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9E8D0398
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85EB1B2EA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7C51607BB;
	Mon, 27 May 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uo6lMTJS"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1115F3EB
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818541; cv=none; b=IzGEJRME1C4zrqbKlRThG8Fh95gkRYYHO2tz5Sq9lOa9X2FHB/g3mFWI3FuimUEhpvjbYME/mdq+h9BVguiMD1ao4jU7VWrq9K2YQOki9EI7NAwVTGMwR6HjPZUapZ1qPxsAyMmCDOaJfApqya8XG9nyNZ22Kh4XQvPn1CDSCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818541; c=relaxed/simple;
	bh=H9YtbJAz0lWtxxI5dSAjzObouxRSql1cjuogk2/HE04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJEKk3bkDZPHGrNMK3Ais5ALRS0UoSoOZtR8YnqCOKFxCzjprbIB6lfAZZVJ2tY3qnKXwqKhrlIG1zcTK40JEYyc0Z90rRthJZ7yuFXfBJl5asx3SoB7a5Q4i5E9613l6YCSj8YZcHR9m6m3XVjet5qaog0USMGeu43tY8BU+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uo6lMTJS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a89787ea4so1366670266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716818538; x=1717423338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V3ZJSdg732IEDAg/X5ZtP8XP6njMmewxtfTRqhu30AQ=;
        b=Uo6lMTJSDVogY+69w9Q8XgJW5fh2hvX9So8n+GV1ffW9WlQB4t9rAhcTCvK/NWThAi
         aNb7tI51PGvJdlWrcDFdHmCulc0WlFw0J1Khqrm4klug38pcVBpE3iSwQnFhGti17Ob1
         toVh2BPVZdRPT1Ltu0FeTvzFUFR4RcxhTThTisDnEWb2/3BwTt34JLAneKpvsi/6sHEJ
         UrkPTsjYQb4a+FQkab+XT5ydscP8fqAxOlatVUvN3yoCb4BMZnPYHy18HUwHl0SZ5gtZ
         zn8Bhmnt9vMdpc5EifYiUU11gXyqRpDmEubiTPK/cqj51kHacDj7kvlqSIb2tVL62Lpr
         cAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716818538; x=1717423338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3ZJSdg732IEDAg/X5ZtP8XP6njMmewxtfTRqhu30AQ=;
        b=tB1pxJGr4blV+AXQ3RhOlPuY47YdReYdMlGMiWHu8WxznTWNcKBdaFzkc5UsLc3CNy
         cAQ72hh6WzWbITlbJ8fFN8ecLlkA579ePnR9oyoDF7T96LLwWm8b+a5z/oXgzGC2UV93
         KoedYkFO3cMd5QtZqVWtONcWmuVjgN0mj3kfBobQ+2YkenIOm6b3Yb8iQbPX3GX2Yl+H
         s8u4Kgs0o+IJJBLuWJJTAdF1d48qv3ENqmKLQlynRGYs5xSMoi+S/bfn271k1l5ph+Jv
         VQTYin03SuLcxOKU9WOEiIwZjG2vtFEEzmo8DKHaxdHeowDCZbmHb/aG2IMFUBb0r9WP
         sZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUssMkEIGDjE9mm/qzsVXlvTdbTOJg7VmW6oUhojH2FSHxywYb/V02XW3j8lKOcQYZ0+hMSZ3KM4WXK2A+S7gFQNN+LupcJzB8ouJ5g
X-Gm-Message-State: AOJu0Yyfoz+5T28iEntbTMjJmnRFQr2cHrtbYDIfMT+pA9MDql+2gpFX
	iUla2/xrPK48FeaMdyVdLEskYGPoW3qauNbCK1oOZmRVQynFmDQ7eFj6+jyRz6M=
X-Google-Smtp-Source: AGHT+IFgM+OP38ZRP3oP7w5ejOGXdOAIbIo0Pp+7im1U3FuKtyvAU2zaGVMcsTGgZFKwQBd5rZsEXQ==
X-Received: by 2002:a17:906:abd0:b0:a5a:896f:9be0 with SMTP id a640c23a62f3a-a62642eb70bmr725672266b.27.1716818537450;
        Mon, 27 May 2024 07:02:17 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62dbdfca11sm204613166b.145.2024.05.27.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:02:17 -0700 (PDT)
Date: Mon, 27 May 2024 17:02:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Baryshkov <dbaryshkov@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: amd8111: Convert PCIBIOS_* return codes to
 errnos
Message-ID: <09f2f3ac-94a7-43d3-8c43-0d264a1d9c65@moroto.mountain>
References: <20240527132345.13956-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527132345.13956-1-ilpo.jarvinen@linux.intel.com>

On Mon, May 27, 2024 at 04:23:44PM +0300, Ilpo Järvinen wrote:
> diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
> index 6f3ded619c8b..3377667a28de 100644
> --- a/drivers/gpio/gpio-amd8111.c
> +++ b/drivers/gpio/gpio-amd8111.c
> @@ -195,8 +195,10 @@ static int __init amd_gpio_init(void)
>  
>  found:
>  	err = pci_read_config_dword(pdev, 0x58, &gp.pmbase);
> -	if (err)
> +	if (err) {
> +		err = pcibios_err_to_errno(err);

The patch is correct, but is the CC to stable necessary?  Is this a real
concern?

Most callers don't check.  Linus Torvalds, once said something to the
effect that if your PCI bus starts failing, there isn't anything the
operating system can do, so checking is pointless.  The only fix is to
buy new hardware.  There was a hotpluggable PCI back in the day but I
don't think it exists any more.

regards,
dan carpenter


