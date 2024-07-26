Return-Path: <linux-kernel+bounces-262765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4A93CC70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD00A282CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1979C8;
	Fri, 26 Jul 2024 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4TqJlNr"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FE6FB6;
	Fri, 26 Jul 2024 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721957129; cv=none; b=PoeT+Ew/kOxzZ8/ckCp0A3dj6EwVjKeRi9se8W4cXPb70u3qbMQgysYzxeT/X1SbvJ3UwcL9gAw6wpvENn00xnVMJ6UQkMQWZL81bPq2iwM60nWeAroSsIF5Dp/hKdXmOzLdqRJBs1c6Cv/xheRPD1/zUKWzW2wnupBGtjveAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721957129; c=relaxed/simple;
	bh=qs6CGBdWzgsKSgHVYe7pFucS6qBI0bJSg6gBrEfAc5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX/Dntdysd3X6SdChbyxPPtcU2VbJIKMn5IXphzqFn/l/TDuHx8sXkr88V4zeW6pcl/Jj5ZTtecaNdBzta2Hd8BmRqkftQwm8lzsh1YMM0Zo7L0mAsjXaeF01aT8jhtxEJIuLL2slmCOgCUFKIKiBsmh+nwtzqD1iADx9D7MCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4TqJlNr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d42da3f7so10855485a.2;
        Thu, 25 Jul 2024 18:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721957127; x=1722561927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcsiN3AG493yzq0rgBlB09MibvytHV+9kiz8MZRlZLg=;
        b=a4TqJlNrDXB/S3uA6I3sn3KLul8JIVPYmHfhZn96SPL2oO5oX2iWgxNpXTFcpMURxQ
         O7RE9ZzXnbana3DFqb59b414hTS2K2OiVVpJX4+0hs+0Uqz6ZePHcptqo6rtCw4klCjt
         3be5bJzU42TEFlrZu8s2l5pKmZoP4nmbFUzUVLBqdECOtaPle5D5drY0m04XMU4S/x3s
         LaknB25XRembMtfJ0X+myNCmS5/mAxVYZvGKFw2RzkYnXY+taolTlQ8Ur0Swk1erSEbF
         RxGbiCpGZKDK9JGPtyxLn4SD1JPo38zzgRyrObM9K+b5PfgDXSF7YImyqzrUtwALrtWV
         Qvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721957127; x=1722561927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcsiN3AG493yzq0rgBlB09MibvytHV+9kiz8MZRlZLg=;
        b=IZJgoFI2PgPXukH/isDxY1bx/IBQAzH4GPSwjzkiRNcp6eTAoTCLReC7V1Op+grsVe
         /Maw9dsBnKSXNIdEGPoNWb+JZ+FnElzET95ONL67S77qIt9nXjuFHLT87MYNzc77gqaO
         3T11JRE89OSGwkGPul538DnHxNT2kdkJm1AwbT18IzDNrkb7LyMlihoB1pmwrffSUa3Y
         /UmCKGsUUKY/6nYV8+pYRcqJ+qrfewo/95e+b/lul6F0lt635jL0T9tg55Z4Jg67rMF4
         eBUaN1rlfZlSpAtNOaUhDbULWSDIHwivhC0uAbenT516ftCrxzR/6XdXx4h+R9uPoMKi
         D0KA==
X-Forwarded-Encrypted: i=1; AJvYcCV0O4KXqEWFgfh4T89Z2eOYVCArBhsrFC0GaBmGUCc6Gpg3ezRFDlRshZT/u5xMjnW0z/KvK5dyTuxk4ZaVsqESzDZ1LzOCtTgCpRMuyBkUgDjvDU/hJC0neWwkV+fwI7TrfgFH7lgh7w==
X-Gm-Message-State: AOJu0YyqGsTfug/zPOzke2l2rTBG13RDl6UG3/1L6kb28IeBbh0bs2Ey
	USh5p+Iln+7Px0d1g70FJEMT5RULQZkj3oYdd5bM82JQwIJD/7oL
X-Google-Smtp-Source: AGHT+IEbX1qyvuNhBgiKknHBt9L3xXVKiF4PnTrA2aIRaf7R6KzZWcObfO6At+M5nm+Oef0b88VtJw==
X-Received: by 2002:a05:620a:40cd:b0:79f:84f:80a8 with SMTP id af79cd13be357-7a1d7e13d23mr495676885a.13.1721957126727;
        Thu, 25 Jul 2024 18:25:26 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7398234sm132921785a.17.2024.07.25.18.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 18:25:26 -0700 (PDT)
Date: Thu, 25 Jul 2024 21:25:23 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mehdi.djait@bootlin.com, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <j5laj5fy4lamyhlyelaq5vfu5vfxj4ybrssrbvrbyndbnvmsyh@6voevw6f3xf7>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240725004734.644986-3-lanzano.alex@gmail.com>
 <0f98db88-71d4-43a6-85f7-a9661c50a382@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f98db88-71d4-43a6-85f7-a9661c50a382@kernel.org>

On Thu, Jul 25, 2024 at 08:08:57AM GMT, Krzysztof Kozlowski wrote:
> On 25/07/2024 02:47, Alex Lanzano wrote:
> > +static const struct spi_device_id sharp_memory_ids[] = {
> > +	{"ls010b7dh04", LS010B7DH04},
> > +	{"ls011b7dh03", LS011B7DH03},
> > +	{"ls012b7dd01", LS012B7DD01},
> > +	{"ls013b7dh03", LS013B7DH03},
> > +	{"ls013b7dh05", LS013B7DH05},
> > +	{"ls018b7dh02", LS018B7DH02},
> > +	{"ls027b7dh01", LS027B7DH01},
> > +	{"ls027b7dh01a", LS027B7DH01A},
> > +	{"ls032b7dd02", LS032B7DD02},
> > +	{"ls044q7dh01", LS044Q7DH01},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(spi, sharp_memory_ids);
> > +
> > +static const struct of_device_id sharp_memory_of_match[] = {
> > +	{.compatible = "sharp,ls010b7dh04"},
> 
> Both ID tables should be in sync. See not-so-recent IIO discussions and
> commits.
> 
> > +	{.compatible = "sharp,ls011b7dh03"},
> > +	{.compatible = "sharp,ls012b7dd01"},
> > +	{.compatible = "sharp,ls013b7dh03"},
> > +	{.compatible = "sharp,ls013b7dh05"},
> > +	{.compatible = "sharp,ls018b7dh02"},
> > +	{.compatible = "sharp,ls027b7dh01"},
> > +	{.compatible = "sharp,ls027b7dh01a"},
> > +	{.compatible = "sharp,ls032b7dd02"},
> > +	{.compatible = "sharp,ls044q7dh01"},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, sharp_memory_of_match);

I'm having some trouble finding the discussions and commits you're referring to.
When you say the tables should be in sync are you referring to the ordering of
entries in the tables? Like at index x of both tables should define model y?

Best regards,
Alex

