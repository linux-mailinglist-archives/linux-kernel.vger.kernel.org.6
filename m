Return-Path: <linux-kernel+bounces-310017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C74967322
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 21:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBE31F2235E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30A1531FD;
	Sat, 31 Aug 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COVPeyFC"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1D39FDD;
	Sat, 31 Aug 2024 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725132935; cv=none; b=Yy3lXfcljiWI3A7UXiA54bDDpntlZgj0DofrHf7o4Thq+z7lrBT4sdvi280B0nMhLs/BXrSZ5fDikfW3dMRHE1qIupsnBDXUWySyQ+5JOojuKAecEvmOqGnoUnZsUO4ZTK/KjBLAPBiYfkpoKzsDU6HVwvWvCc70yIUmrXW0ZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725132935; c=relaxed/simple;
	bh=88vBedgXwP97HYw2npqq3VYbx8iEQMale+RTN4exJRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAs7Kb8GwovHbiSVlOCaD3bam0wkOz+n6BY1lVrnWlmZeAnsQ77ZivDjI93MDQVyygtADjwOjmumhaaeZyQVCCDuOfbBHxce5V81TPL6nMkHNtwWmRzojCyN0qD3EdlZBq+oS4MfQ4rt1HTlCYFh9HRpqcy7KE/IB3IrkCsRTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COVPeyFC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-715cc93694fso2647225b3a.2;
        Sat, 31 Aug 2024 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725132933; x=1725737733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efDdo8Rf8FcDNhL/pTn7ObRZiGA/HSHYfyN56iTR4Ok=;
        b=COVPeyFC4QxfLVQRq1Sgp9SoU55PzeZE6SFR32nuKaTIH5tFHiO7/D7p7/i7X7VwSw
         Vm9SyNdtijMIVEn5faTghv2M0a4m0ea7tfWSecoiw2CGdrHJkAWrVZl5ViAD5cnNJZ0h
         06Lq04RxTHHnHaSjBnhhgFg3jOoRa3wCJV23W5yyF5fHKi7i4qQFNlSvU01R8iVcSOiZ
         hEsKVAzId6Y1PVBhZPQXr1eElrdQG2qkOaAte/JUY5lVZT7cFPAPz9810MBRfSSr1qOA
         jg2kq9CbrMk2fPcTvscXVG2mvSlXSEtBpUuKL9YzMlmX8vg79VeLHsHBmSBYpZpHrK+c
         pczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725132933; x=1725737733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efDdo8Rf8FcDNhL/pTn7ObRZiGA/HSHYfyN56iTR4Ok=;
        b=M4F0HtsmeWAp2DmJ6PHaIM016eBIUKlEahK3qKNsgfZLJFsIZj2e8dmOi/nvWmY5A1
         A81FuVwPX2z3bmiqKuIV9bbPvdgyABlCaNpe2/PjYt4mks8R6lsoCutrbLkc0JPBLjkw
         B+O02FUQ7nij2j9eO04QYZw7C69pqCk3mB4f77ypdbeTdrM6XltFYPvJF6UF2DSsHq0W
         JluGPXx44qXXnwfY4CYwZQnrvy+yPyb8pv7+PfQiyuupebo5NYMlYzmumVSJxawS6aow
         DCJTbvgznolBIYY4NPynzDWd/6SbIaW8i4Y6F6gAnNK0KJT+fOb+nHw/ATJ1ShKhtW0U
         yTdg==
X-Forwarded-Encrypted: i=1; AJvYcCWDZT+r8WdyI+xeHBfFa2SnKbohtB2zNu/NrJftY5BbJlpCjChmU5L0x8UXRSgeDv+nygDoWANDgIl+oQ==@vger.kernel.org, AJvYcCXuyYZGzs6XRpcQa4ZPXJD/3ntewTU5DPWhNNMLDPbik1y0Goftf26aW3ZLQ+hFp5sr+7cF0DAcXQIsX8nO@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQ2BDmkT5iFp/fvIidZGt3qFOhWPXMiMFtN2cp6MrUuVXVfqx
	R2AOYn7BtFi/m0Lrasd1DveGmxdQ9+vNq3M8Y0IBgu9esc4Sm1zj
X-Google-Smtp-Source: AGHT+IER2qtkqOh3s9y998ousnaj5IE1Uvj6aAunJLLbT566xMBH/BctBgffU5DEZeWxOix9vEVbdw==
X-Received: by 2002:a05:6a00:3a05:b0:710:5825:5ba0 with SMTP id d2e1a72fcca58-7173c1e0e87mr2616159b3a.3.1725132932715;
        Sat, 31 Aug 2024 12:35:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a94casm4544640b3a.70.2024.08.31.12.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 12:35:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 31 Aug 2024 12:35:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shen Lichuan <shenlichuan@vivo.com>, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] hwmon: (sht15) Simplify with dev_err_probe()
Message-ID: <8114389a-46f2-4149-8835-8b2d62e00bc0@roeck-us.net>
References: <20240830065443.31760-1-shenlichuan@vivo.com>
 <4792cf2f-1a53-428b-9760-9f8c506c34d7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4792cf2f-1a53-428b-9760-9f8c506c34d7@kernel.org>

On Sat, Aug 31, 2024 at 07:53:14AM +0200, Krzysztof Kozlowski wrote:
> On 30/08/2024 08:54, Shen Lichuan wrote:
> > Use dev_err_probe() to simplify the error path and unify a message
> > template.
> > 
> > Using this helper is totally fine even if err is known to never
> > be -EPROBE_DEFER.
> > 
> > The benefit compared to a normal dev_err() is the standardized format
> > of the error code, it being emitted symbolically and the fact that
> > the error code is returned which allows more compact error paths.
> > 
> > Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> > ---
> >  drivers/hwmon/sht15.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> > index 494f9655f44f..cc3a46a9c68e 100644
> > --- a/drivers/hwmon/sht15.c
> > +++ b/drivers/hwmon/sht15.c
> > @@ -942,11 +942,9 @@ static int sht15_probe(struct platform_device *pdev)
> >  			data->supply_uv = voltage;
> >  
> >  		ret = regulator_enable(data->reg);
> > -		if (ret != 0) {
> > -			dev_err(&pdev->dev,
> > -				"failed to enable regulator: %d\n", ret);
> > -			return ret;
> > -		}
> > +		if (ret != 0)
> > +			return dev_err_probe(&pdev->dev, ret,
> > +					     "failed to enable regulator\n");
> 
> This is ridiculous patch created by some low quality automation without
> any review and thoughts from vivo.com side.
> 
> You change something which cannot defer, while leaving out unchanged
> other places which actually can defer and could benefit.
> 
> Stop spamming with such low quality patches.
> 

Agreed. Not only would the driver benefit from using
devm_regulator_get_enable_optional(), the driver should be reworked to use
the with_info hardware monitoring API instead of the old deprecated API.
But that would have to be done by someone actually _using_ that chip.
If that isn't done, cosmeting driver changes like this really don't add
any value.

But then the whole driver, or rather its use or non-use of the supply
voltage, does not really make sense. If the regulator and with it the
voltage isn't available, the temperature sensor values don't make sense.
And if the temperature isn't valid, humidity values are also wrong.
That means using the optional regulator API doesn't make sense to start
with.  Really, that driver needs a complete overhaul if anyone is still
using it, not just cosmetic changes.

Guenter

