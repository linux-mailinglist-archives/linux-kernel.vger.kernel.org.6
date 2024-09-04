Return-Path: <linux-kernel+bounces-315613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B49C96C4F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB551C24F32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723601E0B8A;
	Wed,  4 Sep 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6zioKjW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C221773D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469946; cv=none; b=Penpuwbf1FMmSePq/4EXDGT7dgSnMHDzlpo82pqssDWGl08F+cWhvMB/gqYqOiX8+X184YY1LLBEboZwI6ZI/ebRrBJ/+vPZlzf4pjylmEdFRn1lG1IV54CUoyBvSkP7qL5D73FEgm354DFcilM6hgPK0aDo7j53b5ZCu6ts60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469946; c=relaxed/simple;
	bh=YyBVaju+LKEXVnoxVu5mj5D/dy3jhLXGBMTUYPRw3B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLNK/j0pw8yCeeLe2Gl0jOtywJfNiJXTC1RR2YTUXaiqvab758heaBg4rziQXmFx4djPFKfenqwdc8ucBef3WxEGSrNr2FISx0Hjmn10htkFwKo+FMZuo9MUoLGvS26yKi7hifnxA9J9tJagMEox8bWUE9c78UsWnIwuBpSBpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6zioKjW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c962e5adso584720f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725469943; x=1726074743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sufPgAffU6DtwuR+shMH9kjtLOalG94qLxuZDKPxPIQ=;
        b=a6zioKjWUFM+ED0+qytYY6s3kCjDWkS1370MUM6ncd+xfT/K+jE983r7L2nBmAEkXW
         0zTIy+SlSR3cJVRBCFvq0q6WJW6qLNo0VkJOeLkYEQ8iQk2adkRZi6Exz1A9/wDN4LiL
         I/72vE6ghb3uCOgZfSoxpJhfobUEQeaKlgJWfsM/n06YU6JPuptfERJWaacqWqL49utd
         jCj1VpRCbSDAxhRlQvb70mQCXIakhsmnyj4yJmANbbw83Z4LI6mdWtj3Gf9H+5b9kQCk
         qxmYZXeyBU3pKgVasuv3aMeuIx/ssic2eoueJM/YewSm6erCM6SrIEd2VZEc02bD/CkP
         wJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469943; x=1726074743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sufPgAffU6DtwuR+shMH9kjtLOalG94qLxuZDKPxPIQ=;
        b=IUuVyTSwVEWJWp8lDiCzaaQsWiz7GKHUdg82Sr+udcC0NvvJjVPuiVdSjIe1ExhyTL
         vUYbRZ++U02WvSMAC+q+D1a4m1DE31mNcF/IolNE+FjwAOB9olOLF0ZQLh3IIAxonstg
         dBo3I4DgjOyJ2BWhUiDRSz8fzGpj+HeBFQaXpl7XXC1TFOjk79B8SfbgJ6ndDF6o22gk
         7wdWGuGLSMZthc1WrWvLdAm0kuFjHNYMPna2ovMA8U0R4PtbNAh9AQCdcs3aRepB0ft6
         oiY4esg4aK52PP/Tm1VaWYo1fNwPKNdYvvKNtqi6O+DdtcH2jrHsYrYZyc8Sopq0XOi7
         O//A==
X-Forwarded-Encrypted: i=1; AJvYcCWmXt2d5ypRZICToOF40PUrBNcHFkHjkIsfbStwk4DSfhniaNtTEzfc05JeqL1nGhXToDNSgL+VU5ZIXmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyc2r3YynfcjBIHCeD/s9xf83u+cVvqFpnZzQsU0BXJAoqzsE5
	VL2kzYYKlTVBtWHsgOicaKidgRvkVA4BN9X6/AJlIDx0ABQhc3Th1PtsHN9qpVQ=
X-Google-Smtp-Source: AGHT+IEjxGfZuPbhih0bctt9v26csC/sSYjllMJ6b4BHDYxK12zL/eLDqbq8jYX/ApH+OrlHTg34fA==
X-Received: by 2002:adf:e882:0:b0:374:cc89:174b with SMTP id ffacd0b85a97d-377998aafc7mr2033054f8f.4.1725469943121;
        Wed, 04 Sep 2024 10:12:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c046685fsm12291083f8f.79.2024.09.04.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 10:12:22 -0700 (PDT)
Date: Wed, 4 Sep 2024 20:12:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v14 08/10] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <fcf44982-166a-4a25-acd0-02a142e205d7@stanley.mountain>
References: <cover.1724970714.git.nicolinc@nvidia.com>
 <dce50490b2c10b7254fb36aa73ed7ffd812b283a.1724970714.git.nicolinc@nvidia.com>
 <38b6ed33-886f-4ec7-9196-1728f1d8c1b3@stanley.mountain>
 <Zth59xLYZ4skc4yb@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zth59xLYZ4skc4yb@Asurada-Nvidia>

On Wed, Sep 04, 2024 at 08:17:11AM -0700, Nicolin Chen wrote:
> Hi Dan,
> 
> On Wed, Sep 04, 2024 at 10:29:26AM +0300, Dan Carpenter wrote:
>  
> > I was reviewing Smatch warnings:
> > 
> >     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:616 tegra241_cmdqv_init_vintf()
> >     error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?
> > 
> > The problem is that we're calling ida_alloc_max() where max is always zero.
> > 
> > > +static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
> > > +                                  struct tegra241_vintf *vintf)
> > > +{
> > > +
> > > +     u16 idx;
> > > +     int ret;
> > > +
> > > +     ret = ida_alloc_max(&cmdqv->vintf_ids, max_idx, GFP_KERNEL);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     idx = ret;
> > 
> > max_idx is always zero so idx is always zero.
> 
> There is a followup series adding support for max[1, max_vintf].
> And I guess that would make Smatch happy. I'd personally prefer
> keep this by ignoring the Smatch warning. But if you think the
> common practice is to drop it and add back, I'd be okay with it.
> 

I'm just reviewing static checker warnings so I don't know the back story...
How long are we going to have to wait for the follow on patchset?

Generally if someone had noticed this in review they would have asked that it
be dropped but now that it's in, you're probably in the clear.  No one else is
going to volunteer to refactor this code if you don't.  ;)

With regards, to ignoring static checker warnings.  These are one time emails.
There is always going to be a certain percent of false positives.  You're
*encouraged* to ignore static checker warnings unless it's a bug or it makes the
code cleaner.  The goal is never to silence the checker.

regards,
dan carpenter


