Return-Path: <linux-kernel+bounces-190961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516998D04E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078ED1F21C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1828317084E;
	Mon, 27 May 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrTFd1KC"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C2161914
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819976; cv=none; b=QMlF+GCcmQFVf+08sFGTADir72E7cMm+nriWSuDXFXTq/L+yt4I3ughOpYaI/vYEdUHojFW7PZAWdM79KGLDbCvWGljHDbaDE6c80bh/7DC0mLgLwiNDrJxIDgoxq87HFV1NlElXofx46ZSWtSVgNeoZZqZMevAKepzoPnk1pjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819976; c=relaxed/simple;
	bh=mIexTCXVeUPx/vSiQvIkN6fMNuyrTcPp/6jeHHlIuU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSydpB1HySZAQ7yb0hC6lK4SmWrv4g/5Jw37TETFzvibXyQeWs8U7QcqQ69j2ckbMAc6qg0wzkhQMJFkAHpbedR73q/QIGQORpFBroeeRXZ7iSaWGnLyRrqfUeTk5Ug0mlaPC+L1UYbD54L5b1jxNjtrAmNNUz03K+eqn/RupbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nrTFd1KC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57822392a0dso8499128a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819971; x=1717424771; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v7c0ZrJPynvxMLH92Q3X2WTOon5tSRNZ2c7KU9q10EA=;
        b=nrTFd1KCvlLfA//4I+gCqd8ZcWdfnLCJ3ucTz510/Os2KxkVEy/PwsXga90ubfXQiS
         belfAJa7pFpPIqeygLzvUlwUdW2WNMOQ8lfAfJmPXVjRIA86bfTA0ilOc7YnsFuGgDWN
         LRAATof3mgk1AQ5AQuHKGxCpFx9t8LDjCMeBja5hVF1GZR6stDUd62+RZfK8K9MNcQJB
         VuiXxiZbZkawFldGGq667R7AdA6X7gsuhZCaIptDCeUJ8v5w4LLNuJ3Tjng1IqZ+MD5l
         GTCDzY4+w5YJzZ6eIhqM1CtveMyzWcA5AQxGHLWQWASQWZrWfIv14ZhuNm91OSu2KKvv
         7nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819971; x=1717424771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7c0ZrJPynvxMLH92Q3X2WTOon5tSRNZ2c7KU9q10EA=;
        b=IfqBBgNOJg8NDFhj5A8T2scjt0BSX6sBdkJLDLgpEMVOHDr6gpIBUqH7a9TY3DtnyQ
         VBOpTqoMKBCYaTaKRG7yO/OnPIbAdfUd2JNhXizKlTvDivGoTjbsBzi4pJ36mjeJbX2m
         uuH9F1ODNIuD9teosdqFf+4rQXHFODk4CIIldwtF1gSSdQWKLtyS7Jwmc9kWLqMxjHb+
         qNLph5OHI7osXRDlfWX41v1Nvq5Mp5r7Q32DF4LYRWaTMLMSPFeiWprkIhfLEZvECW/V
         exYeO+7DQGetzHAHip8pGKYaC1w2H1h5M51xIlhXK0nZPll+N81GXTnbwxQezaIeHcmo
         hTow==
X-Forwarded-Encrypted: i=1; AJvYcCXUbfP0MBm85YpeeTdhBoKYEa0FDAvuvRp1VHkyhGrrB4GnS/J5OgZLoZzkFWSsPawJRAB5YnygxHVAHi3jJRPHrAtmq1UZupg4moi9
X-Gm-Message-State: AOJu0YwedEVHsHW8BblE6nUleQBt4TC7z/sJTjdSiTAO0RYbvl9QHL5s
	31F4C5QoOPeyiS9XcPWq7J8ZH6AVzJdgPt4Bjhhh8OiSjbTwvZAtYPKVNGaLocM=
X-Google-Smtp-Source: AGHT+IGDy6lBIZRlSXWUHrbdvlDpDLY1u7lkMBWjrjOr4cWf2ElMKM1ipIguJpApXRrP72OijJSLjA==
X-Received: by 2002:a17:906:3614:b0:a62:8116:cb59 with SMTP id a640c23a62f3a-a628116cbf3mr535401266b.30.1716819970946;
        Mon, 27 May 2024 07:26:10 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6283119b12sm420845566b.192.2024.05.27.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:10 -0700 (PDT)
Date: Mon, 27 May 2024 17:26:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Baryshkov <dbaryshkov@gmail.com>, linux-gpio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: amd8111: Convert PCIBIOS_* return codes to
 errnos
Message-ID: <50e1c6a7-f583-4b5b-997b-2e505b3df0ec@moroto.mountain>
References: <20240527132345.13956-1-ilpo.jarvinen@linux.intel.com>
 <09f2f3ac-94a7-43d3-8c43-0d264a1d9c65@moroto.mountain>
 <7d475c6c-8bbf-86f4-b2d8-8bc11cb9043e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d475c6c-8bbf-86f4-b2d8-8bc11cb9043e@linux.intel.com>

On Mon, May 27, 2024 at 05:11:32PM +0300, Ilpo Järvinen wrote:
> On Mon, 27 May 2024, Dan Carpenter wrote:
> 
> > On Mon, May 27, 2024 at 04:23:44PM +0300, Ilpo Järvinen wrote:
> > > diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
> > > index 6f3ded619c8b..3377667a28de 100644
> > > --- a/drivers/gpio/gpio-amd8111.c
> > > +++ b/drivers/gpio/gpio-amd8111.c
> > > @@ -195,8 +195,10 @@ static int __init amd_gpio_init(void)
> > >  
> > >  found:
> > >  	err = pci_read_config_dword(pdev, 0x58, &gp.pmbase);
> > > -	if (err)
> > > +	if (err) {
> > > +		err = pcibios_err_to_errno(err);
> > 
> > The patch is correct, but is the CC to stable necessary?  Is this a real
> > concern?
> > 
> > Most callers don't check.  Linus Torvalds, once said something to the
> > effect that if your PCI bus starts failing, there isn't anything the
> > operating system can do, so checking is pointless.  The only fix is to
> > buy new hardware.  There was a hotpluggable PCI back in the day but I
> > don't think it exists any more.
> 
> I don't mind if the CC stable isn't there.

I don't mind either way.  I was hoping you were going to say it was for
some new hotswap hardware Intel was working on.

Smatch deletes all the failure paths from the pci_read_ functions
because otherwise you end up with a lot of warnings that no one cares
about.  Uninitialized variables mostly?

regards,
dan carpenter

