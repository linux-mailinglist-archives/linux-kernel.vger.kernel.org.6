Return-Path: <linux-kernel+bounces-189088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF15C8CEAD7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DD71C21094
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DF784D0B;
	Fri, 24 May 2024 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNnmfKn8"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D674420
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716582353; cv=none; b=YK4K5g+1vma08Ej+JbsUEMc+n64ez+9GsEDBV69I2hqXY4dz2V3ZnoyTu/iIdDoHjIXwnTyz+XRM6AEJbuV50rKFxNqAPiX4iR5L8ft89uH1OpQ28bJ6pQYunu7b58/znuBc0s7jD22lIHjuKeKBNSamyWpoiQgg6GgggOxOyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716582353; c=relaxed/simple;
	bh=RaY9hyFpOtYNxTIBYqwOINTifAgs22Scq79hnarJ7A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfkudR/6A4Nf79dFaUzhQ87DTiRlLfz+mN9wY6hORtW4BTYYiO3XsfFEgRgAxuAh0bgPKl/Kgt+KMwb/Yt8eiCuznCXagdg2uqD9LiiaO21REw04VSVZfj8ohxA18xZNrtu8jLHbEQlYJZYVSE5pj9G3Vmj28IsaqfTJwJXNlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oNnmfKn8; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso95253051fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716582350; x=1717187150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx3BprpNUSkVM0+eAZtkzOHyPIQhydfm1dAtCiLJcW0=;
        b=oNnmfKn8gqMocKUM/xSHq/bF6eK3xxhS/IhqtjLDvjaHBH+7+xPRYzvxaOcaPUqlYr
         51PrVqOhM5ZqMATO0PJeejR7aLiKp9oZrMcrq517dwaFJsbq4LsjPNQrKuGCPGSQFqHM
         Ya4XlKk140hDyBEofJr01zT/+tlyEShhRH8CG/GZfveMwKmzLzC4DIV6YSs111lRF4sc
         nrp4tmRoK0WIvyEcQomi2XeTCPbgmjdWW2bRSalpowqNpKld+10T40ADw3ygvhWEQo3P
         428CZHEWFHRxrgtdHLQAjpp8dR3pT/EBFC1WlAbWY8I7CnZylHoBpOR3Df8LagUyF0b3
         TQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716582350; x=1717187150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx3BprpNUSkVM0+eAZtkzOHyPIQhydfm1dAtCiLJcW0=;
        b=Oe+QfqAmjYHAXTBowdw2fhu3dLnpOqsSWLZfxPmVx2XD0RsGx5YwjlZD3bOQM6EiRW
         3jvFQs2i17fmMw1EZySRmymvf/KFGi+EY2yr074OV6fK3UHLj8gO9K+VDvqKzefd1XgA
         o3C9GjYXqtNon/IAujoYgujwSqpexD9ZkAatFOL4tOiIQZ+XbGEP9vVkSDVkHNpNBLr+
         h37iAajt2WJBAHoHi5OaRmI/08rBAJHs7DhdewBOvw4VxMiQIie1vNye/ODXU0QgTXNN
         6OSDmpwO+80zhY+BE+vvzWTCfszs6y5b+lbpmGwY5RkSb6VzEgE44TIpuD1U2E6N7uEZ
         76Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWvnxh/h8bsmNHdDuLvQ7DTRX7nsB2uxKq2Q8wrIItXz9d+XaREKoPgFQxhC3Mx23tGs6P8DhbtzbA8za4x5ittuwq8ZNK3iP3u8PWM
X-Gm-Message-State: AOJu0Yzx0KziMVcj7uJknrP9Ci4iweWal82yvbEdJMidl/hQDhTH7bYg
	7WRdkgP2YVbj8362W5GxHVjztFY3NDEd04Cpa3rEcDxosGhweMKMfr109OhJXc0=
X-Google-Smtp-Source: AGHT+IHc8QdXshz7wqYQ4pXl2zwktTW8YbFqc2ze8CN1ItkHWWwaXtP/kKIr0mhOWT08wbsu5SiRYQ==
X-Received: by 2002:a2e:9c0b:0:b0:2e7:3224:9f51 with SMTP id 38308e7fff4ca-2e95b09a966mr22545641fa.18.1716582349971;
        Fri, 24 May 2024 13:25:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc48bcsm3357461fa.1.2024.05.24.13.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:25:49 -0700 (PDT)
Date: Fri, 24 May 2024 23:25:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v1 2/2] usb: typec: mux: gpio-sbu: Make enable gpio
 optional
Message-ID: <hepsaenglmlupksq336b36p5ppkpdxg6ndkjgrpi6ea6zyple6@j5t5baspa2id>
References: <20240524071034.4441-1-francesco@dolcini.it>
 <20240524071034.4441-3-francesco@dolcini.it>
 <5of64nmgpotr7fu66urgko5gfvr4ffhmff4dgkagkdvwh2dywk@etlw6rsmhki6>
 <ZlB6ruZ8j2rVsIio@gaggiata.pivistrello.it>
 <3z3gi2s2dxlflmfpcirutvesnj6gsxyriijl2jrc2udaqucoyb@6scxw5hb2nv7>
 <ZlCNPg2iuvSTpVJs@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlCNPg2iuvSTpVJs@gaggiata.pivistrello.it>

On Fri, May 24, 2024 at 02:51:10PM +0200, Francesco Dolcini wrote:
> Hello Dmitry,
> 
> On Fri, May 24, 2024 at 02:42:04PM +0300, Dmitry Baryshkov wrote:
> > On Fri, May 24, 2024 at 01:31:58PM +0200, Francesco Dolcini wrote:
> > > On Fri, May 24, 2024 at 12:56:15PM +0300, Dmitry Baryshkov wrote:
> > > > On Fri, May 24, 2024 at 09:10:34AM +0200, Francesco Dolcini wrote:
> > > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > > 
> > > > > The enable gpio is not required when the SBU mux is used only for
> > > > > orientation, make it optional.
> > > > > 
> > > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > > ---
> > > > >  drivers/usb/typec/mux/gpio-sbu-mux.c | 11 ++++++++---
> > > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
> > > > > index 374168482d36..cf44259980a1 100644
> > > > > --- a/drivers/usb/typec/mux/gpio-sbu-mux.c
> > > > > +++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
> > > ...
> > > > > @@ -66,6 +66,9 @@ static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
> > > > >  {
> > > > >  	struct gpio_sbu_mux *sbu_mux = typec_mux_get_drvdata(mux);
> > > > >  
> > > > > +	if (!sbu_mux->enable_gpio)
> > > > > +		return -EOPNOTSUPP;
> > > > 
> > > > Can we skip registering the mux if there is no enable_gpio? This can
> > > > save users from the unexpected errors during runtime.
> > > 
> > > Yes, I considered this option.
> > > 
> > > The rationale for the current implementation is that if the device tree is
> > > correct (no mode-switch property, when enable-gpios is not present), nobody
> > > will call gpio_sbu_mux_set() so no runtime error is possible. If the
> > > configuration in the DT is not correct you get this runtime error.
> > > 
> > > With your proposal in case the DT configuration is not correct there will be no
> > > errors from the kernel, but the functionality will not work.
> > 
> > I'm slightly biased maybe, but I prefer an error from probe (or
> > dependent devices being deferred). On the other hand, current motto is
> > that 'the kernel should not duplicate dt-validate's work'.
> 
> I am in favor of "the kernel should not duplicate dt-validate's work".
> 
> Now the question is if you are ok with the current implementation or you want
> me to change the way you suggested.
> 
> Or maybe there is a third variant, not doing the return -EOPNOTSUPP and
> registering gpio_sbu_mux_set() even if the gpio get returns NULL. This is a
> one-line patch and everything will work just fine.

I'm fine either way.

-- 
With best wishes
Dmitry

