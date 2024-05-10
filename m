Return-Path: <linux-kernel+bounces-175971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6B38C280A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0355A28265B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5267171E45;
	Fri, 10 May 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QE2cuNad"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B318171657
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355775; cv=none; b=G8t9sVFeDyqfBSPA3ZkXcmFgV1MQ1uVo+x3zsIJgKUa3tAgj/owXjxA/VGsgp+21fJNXdjqte2Ots+0ol8c23nm43w3OblMxndSnOiRwSAxsaN/7Cs18uPl7pzMo19ENcCl+KGOSWOgWgsoEzR+9iyq7aB24yA7nVAkGWOMT/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355775; c=relaxed/simple;
	bh=h2tc+97CygyL1h403nfPfEVVm9uKiWnPtJxLm2rKHPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G12YJOvBy5eXbMFABgPYQCkLTK90KLSYbHP9dr01pxiTdyOpU2nI/4pu3PnQotsdYpga2b3YWONCBOrpTjTs5411XcCrjTBKidhPSk3YGkVBPL6e4i57WfAJ5HHBBfD6HL2E6sPwthDxcdkYbtWfMLPbtRqKRN8WA/svRPbwICs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QE2cuNad; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a609dd3fso383077366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715355772; x=1715960572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2SvsmHCpODoy89CrS+vfoFWJWpXjhvL02T0hTQzQxWk=;
        b=QE2cuNadznm9ufxvbQe5b8sAulpvexyuEijQbXuC7bqFXEu+t5BzVurh1GpJbtYiRa
         TZuB3dgwbDigaehqcF6Lt8s9VPAgtQJ0XsyeGta7gVnDq3RrUGibV48LSYE1pcaaAxDl
         82OFkQbmDF5dusEskK1PkDm9XmEfrsrGYhn7kaVhahXVda9KhtVleJOFRrjKB1a7m12F
         ePrAEGg4RK49mYnZdTUqAUmIkVUlXWvOQVs+vzlmC3ackChekbW0BKe/Y2Kg8q8LAq/V
         AUYCSF3QW0OsORCs7OOhf2fvqOKiBYNyA2OeQqB+b81IiQwD3NMtpAsaQRpGzT+zgALJ
         xv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715355772; x=1715960572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SvsmHCpODoy89CrS+vfoFWJWpXjhvL02T0hTQzQxWk=;
        b=gydt+qqNkZMfcIrqkVcsnIeHvUQq3c64Zw8a6Nk+kaHNa2DJ9BLIK4Cx5lIbheGtjN
         HjDKU2QViCR0b+hiCeI8gTxZ5qskk+eh4e2E4E2syy8Od8+c1ipuBsvGAG0Lsh3mBFkf
         fDQwsBMzPtZsUqzBKSTM8Q2pX0DhiGyNv2nvJEyfxlaXs0PFRzI9vrs8K3Xh1S3ExljN
         F6HXkIqRob/XShGVxG8Rkqf2VC1fSXCK9NtBsclod709G1W2BgibTZ0gkyYzsyOFIBd9
         Fu2gDal4R1cEy5a+Y7irYyKxdT6duhQ6L9E3SVI0QiaVeE5Desj15dpnyKKOUq6y4Lnw
         A9YA==
X-Forwarded-Encrypted: i=1; AJvYcCWJYSPFWKXJyvIcGy2qi50E2MJScALj/kVHHkjbchrT8gADGevOQGp/jydam1GfKiXM22Or51o5xSeVZYnAI3dyQOn/BKrC4kpie8uh
X-Gm-Message-State: AOJu0YyoRPsno4g7y5lNHfAqovp5wvHNthYjnywwowunMUoDnmwMcWQX
	JrgaCnXw9Wf7SJRMYOID68GU/yayB94qG6TJf2a7sMELRytk3czMS4xNWQ/+j1Y=
X-Google-Smtp-Source: AGHT+IE128sGWCua5PnlKWT8gkfSLSSJatboGn/jLfCHVOewATdtBObDqFW8BKzYL80nUP5q9JSC3g==
X-Received: by 2002:a17:906:6890:b0:a59:c8e4:e195 with SMTP id a640c23a62f3a-a5a115f3dddmr483170766b.14.1715355771630;
        Fri, 10 May 2024 08:42:51 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17a06sm193619766b.219.2024.05.10.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:42:51 -0700 (PDT)
Date: Fri, 10 May 2024 18:42:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bingbu Cao <bingbu.cao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: ipu-bridge: fix error code in ipu_bridge_init()
Message-ID: <57a0dfae-cf1b-4c98-bc54-e70e722adf99@moroto.mountain>
References: <71dad56e-0e2f-48ba-90bc-75096112a1ba@moroto.mountain>
 <Zj46vpwTbfde4YX2@smile.fi.intel.com>
 <4ade89f8-cbd3-4dbf-81fb-0e9a4269dc0f@moroto.mountain>
 <Zj4_BBsUYuAeiOpr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj4_BBsUYuAeiOpr@smile.fi.intel.com>

On Fri, May 10, 2024 at 06:36:36PM +0300, Andy Shevchenko wrote:
> On Fri, May 10, 2024 at 06:27:30PM +0300, Dan Carpenter wrote:
> > On Fri, May 10, 2024 at 06:18:22PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 10, 2024 at 06:10:37PM +0300, Dan Carpenter wrote:
> > > > Return -EINVAL if "bridge->n_sensors == 0".  Don't return success.
> 
> ...
> 
> > > >  	ret = ipu_bridge_connect_sensors(bridge);
> > > > -	if (ret || bridge->n_sensors == 0)
> > > > +	if (ret || bridge->n_sensors == 0) {
> > > > +		ret = ret ?: -EINVAL;
> > > >  		goto err_unregister_ipu;
> > > > +	}
> > > 
> > > I would split:
> > > 
> > > 	ret = ipu_bridge_connect_sensors(bridge);
> > > 	if (ret)
> > > 		goto err_unregister_ipu;
> > > 
> > > 	if (bridge->n_sensors == 0) {
> > > 		ret = -EINVAL;
> > > 		goto err_unregister_ipu;
> > > 	}
> > 
> > It's always hard to know which way to go on these...  I wrote it that
> > way in my first draft.  It's my prefered way as well but not everyone
> > agrees.  I'll resend.
> 
> Is the generated assembly the same?

Yeah, it does.

regards,
dan carpenter



