Return-Path: <linux-kernel+bounces-178788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC28C57AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569301F234ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541C6145324;
	Tue, 14 May 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uEA0aqYI"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC1144D02
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695605; cv=none; b=G5v618M4YBiw8eh4VTmFr8F2ryTdESXnIaVwOk+KOKw8v0oTDJwW2hXlzOoKN3HTprtog180hLKwxjh2P1wW72izxb0glD2wKtwmJEDCEG8sKEsNoYcflzEzHGLjI4BRME3cVH24MUiS1yCY1rIW73SSMEbz715BjPOPxhBeFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695605; c=relaxed/simple;
	bh=ipgBCoIZ4VHKNdttClEwK2tJlFePH+T2J5hrqU9VRPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv8rnuSG/F7oDxMc5NL8DRh8f4Tdhl1HShjwCboCkNj8LoGKaScTQWoHk1NQqWKxTQOH8bn/I+mQOxu8c2raE4GUzkKa8Kcb67o1S0GtW9wWqAMWanpHRO84furEaOCBvWWiX66cRrTne7Mf4qbPZ/lvo9r1GTYsScb1YgZXCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uEA0aqYI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34e0d8b737eso3920220f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715695602; x=1716300402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MGdJzkhuCxnkLBMNdqLMl/fKj8tcfr0PaXQonc/7x3M=;
        b=uEA0aqYIH+51tviYPb126rJyno0ZsFEXuc2YtRlPC59KNWsC0OFlFRFt5BZrGtmDN3
         7NAWUDp2wvpXeukK/HGKTIs7xgatnXSFUkCGGyB5gpvAE7ugkGCe92atnsWM4jOCgQD4
         oqe/yuuMzGBewwwYDy/SE1Vbu70hkfBuMIF0nhVh6Q771/gG0PtnhjesQie80/fA1x0v
         3DcD6ONxRwvFkYilQxflVZkZA1DFNGSuLr474dkm7noT3ndz811bYVrNBPx2WAPFfoR1
         jKACFdvjDzqcx6L2mk4Y445Yom4kRklpFevjd7xwLZGXPhoi+C5YKsjqTdgnBH6yO03n
         34kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715695602; x=1716300402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGdJzkhuCxnkLBMNdqLMl/fKj8tcfr0PaXQonc/7x3M=;
        b=V84XkAMrBwk8v8nl7Ug8UDrfPedVnLqWDUTf7MITcZqrjExG5UP/A9CHZYNNq9fElj
         ehTkfvY0Ni/CyL2MlTv5dVvxaluVOUQcROwTFNJuTsGU/EMQJrCgSvatOJIwC2bNyvQT
         w6T2HLJ6pg7ElBK0Xiaew1eJdmyBYOFkJ00cLAkf0yglLHpvIjmZtFBcCyszs2bqz9no
         LPuuHquVkKwMsMmPoTME3Ow2sMn+wq5N7rek5oiNueffC0Qb88E77oOEVgLvy0WldKzO
         2+AYnQKIqzlJPpbkOgEwfaOXEbaKrWcTEfj1Y/Z26+ZUZccxSOGk0Iy/29VKgTD9lm4E
         UJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpLKlqPN2cMAW/nlDVrFJAULJCDXhTInZKuql0YgGSpovMf8J8i7TFn3NhQy0ELTqPHklPJWrPR/ywlwi1dWPFAAhqwYZo9hQ48i0U
X-Gm-Message-State: AOJu0Yxn2+M6yqjzAlH+ymD9ptmSwSXQ74cfOIYUpb9YqH7XTNwJvEDk
	8nO9lpdb5zmec4HssygtR6oK3ogtMsSZoS4FPzMQ6gaQc3O4TfBMNu9dCfsnpV8=
X-Google-Smtp-Source: AGHT+IFdM+bIIzdQSAfqavfhkAiU6DzqxmhjbqKW6BG0kor875tzdpAVmwACrmN8wRYC/fihwO1zgw==
X-Received: by 2002:adf:e6c3:0:b0:34d:9478:7d35 with SMTP id ffacd0b85a97d-35018293049mr13764831f8f.21.1715695602040;
        Tue, 14 May 2024 07:06:42 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fe1ab43casm97730945e9.1.2024.05.14.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 07:06:41 -0700 (PDT)
Date: Tue, 14 May 2024 16:06:39 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Scally <dan.scally@ideasonboard.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] media: ipu-bridge: fix error code in ipu_bridge_init()
Message-ID: <f2d48c85-9cfe-41af-ac43-d61bb1be4dc3@suswa.mountain>
References: <f468c4ac-0629-41b5-b5d1-e26f70e44800@moroto.mountain>
 <Zj5DZ4ORVfeCZSsV@smile.fi.intel.com>
 <3ba30852-cb50-497e-8968-a29d0b9a1986@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ba30852-cb50-497e-8968-a29d0b9a1986@ideasonboard.com>

On Tue, May 14, 2024 at 11:14:18AM +0100, Dan Scally wrote:
> Hello
> 
> On 10/05/2024 16:55, Andy Shevchenko wrote:
> > On Fri, May 10, 2024 at 06:43:31PM +0300, Dan Carpenter wrote:
> > > Return -EINVAL if "bridge->n_sensors == 0".  Don't return success.
> > LGTM, but I leave the main Q "Is it really the error case?" to the maintainers.
> > I would imagine the use case where either from the following may happen:
> > 1) the sensors are all new and not listed as supported;
> > 2) there no sensors connected for real.
> > 
> > In both cases I don't see this as a critical error that we can't enumerate
> > the bridge itself.
> > 
> I have no strong feelings on this really. The CIO2 driver, before the bridge
> was a thing, didn't treat a lack of connected endpoints as an error case and
> still completed probe if the cio2_parse_firmware() function doesn't find any
> connected endpoints...but perhaps it should have behaved this way all along.
> Is there value in having the cio2 device probed, but useless? I can't think
> of any at the moment.
> 
> 
> The patch contents themselves look good to me.

Let's just leave it as-is if everyone is happy with the current
behavior.  When someone complains, we'll fix it.

regards,
dan carpenter

