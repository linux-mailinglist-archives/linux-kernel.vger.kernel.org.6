Return-Path: <linux-kernel+bounces-195259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038AD8D499C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A021C22693
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CCA176AD8;
	Thu, 30 May 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uEdEt/U2"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F2176AAE
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064582; cv=none; b=c3k8tfpxMIUCuPOuulQdLgllAeUf2CZ9Q8EkHj4lqbrJJJV9BMhPsEWX/21C6pJzrE/yVCXtIvk9b+L7+Tbqx0NFZ65ESW8aFF8EcsaPdVgd7Zt5nyXB/ID761kMbowVSxaLU998+accikw6jYjkf/JtZsCXgC3G4RaiceudhTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064582; c=relaxed/simple;
	bh=02S8cUlxxujozYXRed2tZoDCZGK3q9IWs5B8P/qjfiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byICIbThiFUECyrUWgL5vXufZdarN2jZlDy0plHRI+a4FNnnA7t15J7c4G2rAmVrRIOgzPsaKeC+n4Kr3KBete6D84uqWFD8tSrC9xOYh5W5Y9pDfj/I1a87kLPlZagDOYdPPFzjltNWlSPGwHiETPSy41sJFiLbpw9IyPzS74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uEdEt/U2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57857e0f45eso815159a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717064579; x=1717669379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIqW3hgYo/0vLBwjJRGJLCE0T0iWQED1Vt2+zIPxV6U=;
        b=uEdEt/U2xJMwp5AAmiG9AbvQgLqwWEHE4jJoEA7+2gboBOe6jB5wEcGUAcCQXaXJhu
         f8bPzy3vQxnMl/HluaYs7iasKvKwjReVFwdG/QicTlQodvpTfrz3JmMPOUycsA9/X1tG
         QdeVAqW+pi/SZPdxfKNznwb2s7I2Dehs75EPreOYWollDAKf3oFyA+d/rm2T2os53O/t
         zV3YHJ6aR66HvyYEHTZpC9LJSaQHq7K3AwlczKnc3t9K8mtbSYc459bMbEpcjPp+O5QO
         8gHaxlWUnV+CJx8PIWrNBD74DY0MRF6obr3CDDCIwlYWJMfxSCRw3iGJQ8hY3TV9KGR3
         d2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717064579; x=1717669379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIqW3hgYo/0vLBwjJRGJLCE0T0iWQED1Vt2+zIPxV6U=;
        b=LHqXZQWh5psVkk1isnS+mYYvzPORdb0fv6MBglC7AviCmcaMTii9EW7AXbvsN2Rz5F
         h8Q+lykhVqtboazUs1sqZl0+gbkQgSnCVtuE9JyvGtyzzRlX81oE/tnLA+10kYvhDC8o
         C+Jalesu4dyWCc8tJSzHBvFX0mYCFBDWzz1TCC1n0Q9VskgDpR6+LVjT9M4jmpeHsNMD
         e5sGd8fLmXjRT/bBuu6Rfm3LMJi83/HWkHbQDPLjKkImzJKL1p0FaK1b+ofyr93JhvZi
         /avBfcf8plTzN5+thWaZvEHfQ+lAkipqORh8l/kepLMzjDew+oibRMVetaMUk0TAAG0n
         TjXg==
X-Forwarded-Encrypted: i=1; AJvYcCXMwO729YaPWlIWPRWFKHyVMAT5cc9X8UXDpQCWojlRM2v1tn/flSM/RPMH28MyquhyaEXZ1R8DYSnC+1UCceYVO352PMqPXb1ANd2R
X-Gm-Message-State: AOJu0Yzkzz04824Vl1i4oAKz/LClR8wN3CnYZyozYIhnZmABvYfwOw7H
	3hZ4WLHi67W7JZkNR0juyh+tVq3G4/6wq3z1ff6Z1h07CZ3yPuqPMkguZCTDhyE=
X-Google-Smtp-Source: AGHT+IF0zwT0Q8SsuY53Q0nPPrhnfo3gYFgLvDd/fyJ47/aa3KZAeZ4xUViaCS/iHQfECUQWwdffvg==
X-Received: by 2002:a50:c199:0:b0:572:9b21:e0c9 with SMTP id 4fb4d7f45d1cf-57a1781f962mr2137753a12.14.1717064578431;
        Thu, 30 May 2024 03:22:58 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d445bb57sm5323936a12.68.2024.05.30.03.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:22:57 -0700 (PDT)
Date: Thu, 30 May 2024 13:22:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com
Subject: Re: [PATCH 8/8] gpio: tqmx86: fix broken IRQ_TYPE_EDGE_BOTH
 interrupt type
Message-ID: <876eb824-2898-4ffe-9d0e-69dd0781729f@moroto.mountain>
References: <cover.1716967982.git.matthias.schiffer@ew.tq-group.com>
 <2c265b6bcfcde7d2327b94c4f6e3ad6d4f1e2de7.1716967982.git.matthias.schiffer@ew.tq-group.com>
 <8689fbcd-3fa3-410b-8fc9-7a699bf163b8@moroto.mountain>
 <0e971f0b885bd360e33ef472d96e3d9e0ab56405.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e971f0b885bd360e33ef472d96e3d9e0ab56405.camel@ew.tq-group.com>

On Thu, May 30, 2024 at 10:39:25AM +0200, Matthias Schiffer wrote:
> On Wed, 2024-05-29 at 17:38 +0300, Dan Carpenter wrote:
> > 
> > On Wed, May 29, 2024 at 09:45:20AM +0200, Matthias Schiffer wrote:
> > > diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
> > > index c957be3341774..400415676ad5d 100644
> > > --- a/drivers/gpio/gpio-tqmx86.c
> > > +++ b/drivers/gpio/gpio-tqmx86.c
> > > @@ -126,9 +126,15 @@ static void _tqmx86_gpio_irq_config(struct tqmx86_gpio_data *gpio, int hwirq)
> > >  	unsigned int offset = hwirq - TQMX86_NGPO;
> > >  	u8 type = TQMX86_INT_TRIG_NONE, mask, val;
> > >  
> > > -	if (gpio->irq_type[hwirq] & TQMX86_INT_UNMASKED)
> > > +	if (gpio->irq_type[hwirq] & TQMX86_INT_UNMASKED) {
> > >  		type = gpio->irq_type[hwirq] & TQMX86_INT_TRIG_MASK;
> > >  
> > > +		if (type == TQMX86_INT_TRIG_BOTH)
> > > +			type = tqmx86_gpio_get(&gpio->chip, hwirq)
> >                                                             ^^^^^
> > 
> > > +				? TQMX86_INT_TRIG_FALLING
> > > +				: TQMX86_INT_TRIG_RISING;
> > > +	}
> > > +
> > >  	mask = TQMX86_GPII_MASK(offset);
> >                                 ^^^^^^
> > >  	val = TQMX86_GPII_CONFIG(offset, type);
> >                                  ^^^^^^
> > >  	_tqmx86_gpio_update_bits(gpio, TQMX86_GPIIC, mask, val);
> > 
> > The offset stuff wasn't beautiful and I'm glad you are deleting it.  My
> > understanding is that a hwirq is 0-3 for output or 4-7 input.  An offset
> > is "hwirq % 4"?
> > 
> > There are a bunch of places which are still marked as taking an offset
> > but they all actually take a hwirq.  For example, tqmx86_gpio_get()
> > above.  The only things which still actually take an offset are the
> > TQMX86_GPII_MASK() and TQMX86_GPII_CONFIG() macros.
> > 
> > Could you:
> > 1) Modify TQMX86_GPII_MASK() and TQMX86_GPII_CONFIG() to take a hwirq?
> > 2) Rename all the "offset" variables to "hwirq"?
> 
> Unfortunately, the TQMx86 GPIO is a huge mess, and the mapping between GPIO numbers and IRQ numbers
> depends on the hardware generation/variant. I don't think it is possible to have GPIO numbers and
> hwirq numbers differ, is it?
> 
> Currently, the driver only supports COM Express modules, where IRQs 0-3 correspond to GPIOs 4-7,
> while GPIOs 0-3 don't have interrupt support.

I'm so confused.

So "offset" is the GPIO number and "hwirq" is the IRQ number?  If the
IRQ numbers are 0-3 then why do we subtract 4 to get the GPIO number in
_tqmx86_gpio_irq_config()?

	unsigned int offset = hwirq - TQMX86_NGPO;

And again, it's just weird to call:

		type = tqmx86_gpio_get(&gpio->chip, hwirq);

where we're passing "hwirq" when tqmx86_gpio_get() takes an "offset" as
an argument.

regards,
dan carpenter


