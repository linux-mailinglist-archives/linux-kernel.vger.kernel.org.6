Return-Path: <linux-kernel+bounces-194284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E768D397C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6781C224CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D3C159901;
	Wed, 29 May 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPVZsj8k"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E575158201
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993521; cv=none; b=TWAfQTMvDQXSc8zBTdIxZHEjqqSeUyVbZOlQqXUt0XXigmW8mVgnjfaTkhNfzjo6SgUE3ImE2l/Na4Cf2OSn/kWDjBlvCiQas3cZywDLv6Yoh2ox0UsDzbtOQSemI5xYgpSChCWt8CaIQFcS9+64TSJyVI7AgcllVDPgyXqm1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993521; c=relaxed/simple;
	bh=qtx7heFq23Ik7RP0+IKkj4MhAFl1SLLrhfCCxu4Y/iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTHN5BHQzGOOA3PVbqdYodcwKpvaesO9A0lja6pjWWcnMNl6THe2XBftBQlKYx7Az+PqEBXoxuYSU85+YzfT5lQMIZ/ETc0k9jzb8UnB8QO8ZzpjEX/76T2CTGmFXCGqadKxEnMEAqUWDHzv+Ht6M+KKRfSitAqYsdSMboWzG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KPVZsj8k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42011507a54so128345e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716993517; x=1717598317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXlxBJgQstiSb1iHCBoySUt4Dr8xVwSho9/4h77j9/Y=;
        b=KPVZsj8kfvrlqGxbyhrgjG3IDqnkkY39IVuhBMIuXI/rqVNwir2Gd1dRiYCTpLb0GM
         IRDzbSgYs00UqAJ9L/CpJIuonpFKvjUjwsWBv7K6egTLd+EJkGuGNQQQomsNipW22dZ9
         9bs1Z7YbIlwQIaiAslEtb/NQd7XXmBrrOmppCeJ4M5sJeLkAtvkZZWMdOM8hQ1G9LB2s
         z06vIg6p3Ip0BBe5zGvs02AFcmoUIaD4LwpyDa4NpRI4ZFSMErGgFC1xQtS17PYzaXf4
         6g5k6ek3FUHM4D5ZTH03zvygR1cBnTJLXNOvbZu08v4dIvBbtEFuueA9AnG0XX1J9dVx
         WvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993517; x=1717598317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXlxBJgQstiSb1iHCBoySUt4Dr8xVwSho9/4h77j9/Y=;
        b=Wdf5ecgA2fLK8+WmSdWe7xcWFGcOmxuB87fRm3gHd+WEimcvvI6ixs3a0gi0FVYBM3
         ikyayXZt/TRJNQykPY60Szw4h3T8OdUQz+DYNuF2BdpZNN2encj3fzK73/GwBqU4hMWK
         yqOntgdzLRhlVrdQMd9Zjv7p5NthU80KxjUktFec0vFc/xPiG7+CBwQZETfQRiQynXKz
         pqJTPl/EAnnU4e3uW4Z73F9b9EFhlmCEwxYQ4GDcTXLz0sOjaFZOfYe4W6sKfwfxthUl
         rpuvSzmDq0xT9w6E8o/nbS9TSSAyZ1ILxPqQd1hzNqpslw5KfkayptiVes8wrQdc+0hW
         O9/g==
X-Forwarded-Encrypted: i=1; AJvYcCVZsgE4Gsh4a1Y62Y6T91FBFdDIctsEyDIMknd07Kv5gUKKxtB8PJs1p4bvY1zLtrm1cq+sw769J/HrhexgFvGtLLFKqG6GilBRqTbY
X-Gm-Message-State: AOJu0YxiRotm26bYJRIRyGVNVs+g/IKAyMdZaqebIE1V8ZQpfZf39r6C
	rx1uLZ7eXpJ2m0MfFodNDkVtAtIRRCvn+j1hl6xy/Z8JPtpisTE+UhweVIuLukU=
X-Google-Smtp-Source: AGHT+IH716sSlQ0shXbTlDViazn4mQcqRoOCpRWv8t8XYiQ1HLYo/wxnu2ygHpUNyh3b8AdjgrqGIg==
X-Received: by 2002:a05:600c:4450:b0:41c:73d:63b3 with SMTP id 5b1f17b1804b1-42122adb00amr20059995e9.3.1716993516434;
        Wed, 29 May 2024 07:38:36 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089cc4e2sm183157625e9.39.2024.05.29.07.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:38:35 -0700 (PDT)
Date: Wed, 29 May 2024 17:38:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com
Subject: Re: [PATCH 8/8] gpio: tqmx86: fix broken IRQ_TYPE_EDGE_BOTH
 interrupt type
Message-ID: <8689fbcd-3fa3-410b-8fc9-7a699bf163b8@moroto.mountain>
References: <cover.1716967982.git.matthias.schiffer@ew.tq-group.com>
 <2c265b6bcfcde7d2327b94c4f6e3ad6d4f1e2de7.1716967982.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c265b6bcfcde7d2327b94c4f6e3ad6d4f1e2de7.1716967982.git.matthias.schiffer@ew.tq-group.com>

On Wed, May 29, 2024 at 09:45:20AM +0200, Matthias Schiffer wrote:
> diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
> index c957be3341774..400415676ad5d 100644
> --- a/drivers/gpio/gpio-tqmx86.c
> +++ b/drivers/gpio/gpio-tqmx86.c
> @@ -126,9 +126,15 @@ static void _tqmx86_gpio_irq_config(struct tqmx86_gpio_data *gpio, int hwirq)
>  	unsigned int offset = hwirq - TQMX86_NGPO;
>  	u8 type = TQMX86_INT_TRIG_NONE, mask, val;
>  
> -	if (gpio->irq_type[hwirq] & TQMX86_INT_UNMASKED)
> +	if (gpio->irq_type[hwirq] & TQMX86_INT_UNMASKED) {
>  		type = gpio->irq_type[hwirq] & TQMX86_INT_TRIG_MASK;
>  
> +		if (type == TQMX86_INT_TRIG_BOTH)
> +			type = tqmx86_gpio_get(&gpio->chip, hwirq)
                                                            ^^^^^

> +				? TQMX86_INT_TRIG_FALLING
> +				: TQMX86_INT_TRIG_RISING;
> +	}
> +
>  	mask = TQMX86_GPII_MASK(offset);
                                ^^^^^^
>  	val = TQMX86_GPII_CONFIG(offset, type);
                                 ^^^^^^
>  	_tqmx86_gpio_update_bits(gpio, TQMX86_GPIIC, mask, val);

The offset stuff wasn't beautiful and I'm glad you are deleting it.  My
understanding is that a hwirq is 0-3 for output or 4-7 input.  An offset
is "hwirq % 4"?

There are a bunch of places which are still marked as taking an offset
but they all actually take a hwirq.  For example, tqmx86_gpio_get()
above.  The only things which still actually take an offset are the
TQMX86_GPII_MASK() and TQMX86_GPII_CONFIG() macros.

Could you:
1) Modify TQMX86_GPII_MASK() and TQMX86_GPII_CONFIG() to take a hwirq?
2) Rename all the "offset" variables to "hwirq"?

regards,
dan carpenter


