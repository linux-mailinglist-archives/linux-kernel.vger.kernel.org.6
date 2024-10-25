Return-Path: <linux-kernel+bounces-381146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17779AFB1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6299C283958
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4140C1B393A;
	Fri, 25 Oct 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEbNN5rz"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16122B64D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841452; cv=none; b=qyPgu8bP9W5GULmEDfz/DmJxOSkGwBwbv3QcTXWbuB0GVvdxDAyHGvF4cYi1Kdq+c9Tpb6eZXM+U3FoooziEJJoh/GztFNs8L1IoWdWknLl2uSAhGTMzKOQjKqxufrbd9VOH6j7Tg7tMDnFWx/76nQy5YzJiwCIXWCyrXeAivHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841452; c=relaxed/simple;
	bh=tgy99DmJT1rVp1LrmB6ojFA2kufaH3nzhaBGHtk9wW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4zgbPH2hb4644Hvsm6yCnbSgdXT9x/wnNuZs6CXS2//nXX9cyrzqevY1diAE3AcM56Wd5Oi3fu6rYEdVEVIDlOt3vzmlelmAEIENtIAI3wIv5oepMBarHBz3bFuIt3IzD9lcSE/5NSci9QaxAvAIrYaQHt+HRoXhdmQiIGCWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WEbNN5rz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so18075615e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729841449; x=1730446249; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WtHDy1uLFgkmsG/x5nxbwS/MMMaeDjb30sYbzTEX8Zw=;
        b=WEbNN5rzsIG7tseACo0OdLHx1ax16wU0n2Nv1J03790Q28o73lWzm7YCEpc0j3YtuR
         ykI0KDIevxGFrsn0KEYyKYCOd6gg+2O7VJlYktov06EAj1m2zYmvOjNsa5JUBdRT0b2e
         bevITz5ZhXJxakC96YOknw+le52Dk3+BxfQVZ/SVwj1WSud9KPolQjR10HUKWR6cWUYP
         vKSuRi7NBqA8eFQlZ3U/5tamluomclBXJQ3WPYxITLFMmMVK5Sj7RJUfy5Bw/q+5VfyO
         YRGJAOgSq0dOuwTZrsGGiSsFvohyF7mY8M/XX6WCT7V3+LnyNj5selT8xm/oT5yAGtJI
         xexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729841449; x=1730446249;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtHDy1uLFgkmsG/x5nxbwS/MMMaeDjb30sYbzTEX8Zw=;
        b=cZFHTaHZXehxmzQBwWJHa+SQRuehg0jo8BIKlIxEm0PdlRmGLol/QcfqGQFzZVOvVS
         F75ykirVSIn4sK5+PX2vicUCNWt1CjQ6or8HdPYTYt9EdYQiVf/K8+XhILtu9YGMg7u4
         9gX/ioO9pUkeDTA3n+SjpaulRHTSgCUaIDVTUeqXo1twYVtArDzdt2wk5H4VYMbHJrsD
         DZIshJkNBRaD8IZfVnzcMMaQWynFfMXzWB4GQxShS6U+mCLLFXYMEtxD+NgbA4uKyYBV
         xsYtAHrvTC0ru2lBQWIqomOndAb9YrfjHYS1z/zfeQ13L6ejBRw2xuG+F62dte4+7sMy
         amIw==
X-Forwarded-Encrypted: i=1; AJvYcCXPSua/sXm0HCyvqGVW8vtJDRjtwKOQS/TCBHLEvzOgusM6M4HK0F31GZaMubEY5ye/Ux6b7CTqtOHAZ0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWq4Es1AybC1LC8NBX1uWZCcUJmUooPGBD+ZAr1eh+DI5USWf
	meyij1L+Jsz4bV8Rn8KvpNI/dvrGMPufx2bczWvUvwM3bo0iwESviBnbnU9PyGU=
X-Google-Smtp-Source: AGHT+IHxF+XBAnXeDnDqIMGQCJ8rtAbnYKULA9dlRYGwuNkgYKpDnNMejLiqlKZPt83EjxSWFFNeTg==
X-Received: by 2002:a05:600c:1c01:b0:431:5a0e:fa2e with SMTP id 5b1f17b1804b1-4318c715cc0mr39763695e9.21.1729841448665;
        Fri, 25 Oct 2024 00:30:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b71479sm800087f8f.69.2024.10.25.00.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:30:48 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:30:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] drm/sharp-memory: Fix some checks in
 sharp_memory_probe()
Message-ID: <3c078224-071e-4dd9-bf8d-51dbd0f2a9b2@stanley.mountain>
References: <0d307349-c141-49ee-8b34-67caf5f8b638@stanley.mountain>
 <hojly7qagyszxbgonzqmuuxucdfqwovrjyiktdxpibku6yodum@n7algnce2tts>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hojly7qagyszxbgonzqmuuxucdfqwovrjyiktdxpibku6yodum@n7algnce2tts>

On Thu, Oct 24, 2024 at 11:08:05PM +0200, Uwe Kleine-König wrote:
> On Wed, Oct 23, 2024 at 11:30:31AM +0300, Dan Carpenter wrote:
> > The devm_drm_dev_alloc() function returns error pointers, it never
> > returns NULL.  Change that check to IS_ERR().
> > 
> > The devm_gpiod_get_optional() function returns a mix of error pointers
> > if there is an error, or NULL if there is no GPIO assigned.  Add a check
> > for error pointers.
> > 
> > Fixes: b8f9f21716fe ("drm/tiny: Add driver for Sharp Memory LCD")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/gpu/drm/tiny/sharp-memory.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
> > index 2d2315bd6aef..1bcdd79166a4 100644
> > --- a/drivers/gpu/drm/tiny/sharp-memory.c
> > +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> > @@ -543,8 +543,8 @@ static int sharp_memory_probe(struct spi_device *spi)
> >  
> >  	smd = devm_drm_dev_alloc(dev, &sharp_memory_drm_driver,
> >  				 struct sharp_memory_device, drm);
> > -	if (!smd)
> > -		return -ENOMEM;
> > +	if (IS_ERR(smd))
> > +		return PTR_ERR(smd);
> >  
> >  	spi_set_drvdata(spi, smd);
> >  
> > @@ -555,6 +555,8 @@ static int sharp_memory_probe(struct spi_device *spi)
> >  		return dev_err_probe(dev, ret, "Failed to initialize drm config\n");
> >  
> >  	smd->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(smd->enable_gpio))
> > +		return PTR_ERR(smd->enable_gpio);
> >  	if (!smd->enable_gpio)
> >  		dev_warn(dev, "Enable gpio not defined\n");
> 
> Use dev_err_probe() instead of plain returns?
> 

Sure.  Let me resend.

regards,
dan carpenter


