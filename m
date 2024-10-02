Return-Path: <linux-kernel+bounces-347538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D448998D404
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E881F2269B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E920D1D0408;
	Wed,  2 Oct 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnUYDdPf"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B301CF5EE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874540; cv=none; b=Mz02ldx3ZGTtOWF+4gKsDlhNOWI1BIchUF4t0glDKhbtj8/D1zaa1cmj/aXrtz++W/v8/RRhWeXmh00wh8Q+u/StM6kd996jB1KXhGqZ9MvicnhOeQrqFpeR1KS7+oAucd4+G0xH50LMaJfnlDunF0SAaAvZ4+ddio3r90diMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874540; c=relaxed/simple;
	bh=5JzLNnQQnrOmpQls1H8OZPPLSuyJxI4wo7X30H+T75o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVs1khCjqwLXzaJ1KC83bm27N1Rmj2mwAmixYJVh+JVW0MfHacXHy9NkIHsVL/lNeoGPlQdzn7Ve3ctyQUGJXeBKM4o/BNf2A25JM5yalm5xd0Z+/GxtzXEVP56r/VS3iPoE0enrmOkFYOj3tGsfm9nlmg6m1UBuYvmY+QWSePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnUYDdPf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e5e758093so54325645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727874537; x=1728479337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDzLb9HAzFTHgXYVz3PmjPQQXCozDoYo6tlRepDN6bo=;
        b=cnUYDdPf/4R2cE5iGFWyqn8Y2HQLnom5dTZ8wOLR+ZQ1lskqC1Ap6QQ/s+p7St4751
         LK7Qt6/iM5CTv5kaIUkC1AEio9QyNhCk/307EIqa0XJNPklwjDgGrrcDSL5qmCfpHrRP
         C1lYKxv4/C3dosAGBVRgM7TYqZGIVFWSHXT6r1XOnDSfk7Yuc1WOl8oPgv4MzFjCU/Mz
         sA1BF2MkPSyfxZAQukwkbeYqHw/aQnmlSvZwIVd0WweJJ3c+UewvGszn3QaRhxP1xm2q
         z2jcK199qJFsqupXWiFa/G54DTzPex5V084ItZS4Lil1HONs1xYDf5+Gl6Vf4Fd1Ib+1
         Vfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727874537; x=1728479337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDzLb9HAzFTHgXYVz3PmjPQQXCozDoYo6tlRepDN6bo=;
        b=MOmKc90bdsBoHUfnR60FeQg+TQ0N0CYYNqRyoZJCrAiGDIyW3eS4Z7EdPFVJjq9C87
         Ir8Fw9QSMVRjE2KGzYiyu1jXBpFVF988DU8jNh7LD6yeRQcSZZiuvb09xOcwuppCmj0T
         5f/9ceqAarPJ0iudSJ5YYuTiCu8HKznOU7o8QmB6fGoztBLJOGehqj5cePWUA3Qe4FqJ
         7KoM+VRTpNBbf++MtChFV8ysh4dPJro3u9KcO8HHueBOCGcqfH/c5G0oZdZ2bN2Jl6Qi
         UKKnH7c9mAD4TLc3IN2GyyPKwpw6seKpiFlXdlHkDo2lJZKRmcDu86as7wQ8Lvq0vbxE
         IFgA==
X-Forwarded-Encrypted: i=1; AJvYcCVjb+HiJsxU1t6YRB3292a1kExUE8mj+kk72bI+yX+5ySgv9VQSw2bHbH9i+Kd9qxHlZqx6CFU5ZHaTCWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwTIwhs861EKMYiDvtUgrHjnX0VHRdW1LdeN4kQT/ZrflHOS6
	PqMJ+63H4rw9EtNKGR9rb5FWw+1UPdHpjoMbfpjTZDyhFx4DssOb
X-Google-Smtp-Source: AGHT+IHR6RcwL9ReqzZogaagqjsddxTFMWs1j+r9XSbzqBMh60lKg0uPR+rCk40BiTv3g2mACBc/0A==
X-Received: by 2002:a05:600c:3b05:b0:42c:b750:19ce with SMTP id 5b1f17b1804b1-42f777b628fmr22785625e9.1.1727874536784;
        Wed, 02 Oct 2024 06:08:56 -0700 (PDT)
Received: from localhost (net-2-44-101-4.cust.vodafonedsl.it. [2.44.101.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ec066fsm18151785e9.13.2024.10.02.06.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:08:56 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:08:54 +0200
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, anupnewsmail@gmail.com
Subject: Re: [PATCH] iommu/dma: Potential uninitialized variable in
 iommu_dma_unmap_sg
Message-ID: <5qpb5dotpef5livw36yok7vnbe7ylj5hg34azlpow6t5ca2xoh@sppdu63wbx3o>
References: <20241002083131.18135-1-alessandro.zanni87@gmail.com>
 <472d2dcc-82ce-44f3-b991-6aba1e4d18f9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472d2dcc-82ce-44f3-b991-6aba1e4d18f9@arm.com>

Hi,

this fix has been raised by a static analysis tool and it's more a similar to
a warning than a error/bug, even if the tool labels it as error.

I checked the code but, honestly, is quite hard to me to find a combination 
that might lead to an issue because it's strictly dependent on how the driver
works and the causes may be multiple, as you said: sg_dma_is_bus_address() 
true for all; sg_dma_len() false on the first; zero segments for the loop.

I sent this patch because maybe can be useful to avoid a possibile, unlikely,
combination that may lead to an error.

Up to you to decide either it's useful or not.

Thanks,
Alessandro

On 24/10/02 10:45, Robin Murphy wrote:
> On 2024-10-02 9:31 am, Alessandro Zanni wrote:
> > This patch fix the possibility to have the variable 'start'
> > not initialized.
> 
> Why should it need initialising though? For "start" to never be set, then
> either sg_dma_is_bus_address() is true for the whole list, or the list is
> bogus and has sg_dma_len()==0 on the very first segment. Either way, the
> second loop will then do nothing, "if (end)" will remain false, and thus
> "start" will not be used. Where's the bug?
> 
> Thanks,
> Robin.
> 
> > Smatch tool raises the error:
> > drivers/iommu/dma-iommu.c:1510
> > iommu_dma_unmap_sg() error: uninitialized symbol 'start'.
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 2a9fa0c8cc00..5b2596f4b24f 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1496,7 +1496,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> >   void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> >   		enum dma_data_direction dir, unsigned long attrs)
> >   {
> > -	dma_addr_t end = 0, start;
> > +	dma_addr_t end = 0, start = 0;
> >   	struct scatterlist *tmp;
> >   	int i;

