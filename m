Return-Path: <linux-kernel+bounces-202453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321998FCCC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B4A283A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D805719643F;
	Wed,  5 Jun 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CBaKGffO"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CE196428
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588948; cv=none; b=nBYAoZh6WFm6bDrT+aXZ9BmDr2ow952Aw9kEUaTeD9AWpFbCwdwbkgPsPs+4LlkK7lBx/dGjCIY4w6Z57S3GbbiUOxZhpnLclOIkudUmovoeK4TFKTdHaZobuxqe00VJDvJY8PiPVeY5R62uv4Jj1o9rW6YH/lSuANsLAYDlcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588948; c=relaxed/simple;
	bh=nw27Ww+rQ2umB0SaLCjNt4fTaXvBnAkTAq1QSdPry8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcEJnM8v+jO7Uji+sF9zYHw7DlKiZcewfvSywh026sTltL4RMzwg34HaKhmAFPkRtShLwLurQnafIuJOyYj7rnddDjndR93WIsqUgR9dZCytJGJMCIGMQgHgTo2D4qZ75SRLAD58csjoluHh9gw3Gvo02X9pGSwD3iiyG7PL27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CBaKGffO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70260814b2dso743587b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717588946; x=1718193746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBzQyRtg9eqUOlOjbmDo1iz6ws2MaRBxmM5VGftOF3Y=;
        b=CBaKGffONGAIVNMWsdiFn0tAunX+mOJCd90KusjnY5yMaErk3leu3hC4FowufR+W4D
         Z2VnPWifEJxt4PLtcxTioj3rL2PW2ffJVmDEH2nj7nhpX1F/RRG/Mr0udjOxPP6uDZj1
         tr6fFsgXvWLNFn/NqRp4ZmWHBrm84F0J3K+4oZM3l00qcrcyPuneOwngjlpKp3LL9SMU
         sXsrRV4p+L4ihX670+nUvxFP/i9OaOa94TnzsQCRHUpIwuULrKYq5lflUZymN//9bdLV
         At3MN74/ZOj9XWDKvMWf8J89cejCJ7zKEFfIzhDKyVU4FCKWTetb55tTe0T+SSSMstWa
         YL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717588946; x=1718193746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBzQyRtg9eqUOlOjbmDo1iz6ws2MaRBxmM5VGftOF3Y=;
        b=iRcGTKIb1k9yMgxshe8xOA9fzVo350It3lO+JFj9H9oapU3RSPslPyKLo6tOyfAoRo
         Qp6TMisb7to6Us/ij/Mtcxc+k70bIpi2N4186eoFvrxYvgY2KI7M8V2Z7YByGzAyJW/Z
         7hRkNR7fPUhzlFLVye6oAYDye4f1o7DHm7stfhZrze90owDjTNO1nQWAa7M0U0p9PDSy
         D25i4PH4YWNTdmB4BQEmsDk11mTXZ0ZvEiL82tglBkPrb3KiZ8CeuVPFeF+uUOvQ265k
         yPiPAiwFavizKHfsrSfbd5JMwZ9ZEAKOGrAcozAicVeImnVu9AQ+z8bY5zCpjcw561dx
         HxBg==
X-Forwarded-Encrypted: i=1; AJvYcCXQYr3m2+QMHDrCft37bWAH8OtdsHW0FlgJSlzVJs3twnIVb+7SukxWLEXIXplo0Aa9YvUAtOVJ27f7aJEBSsZznMhQLUG61Tm0C/oF
X-Gm-Message-State: AOJu0YyRo8GD4MRfIKK+76YDHtSiiMJDFzjG7PxTV1xlP7mcWSSa7CkG
	iQXMPegpWq/u0xQ8Tr27ijX5dRzAU0RQPEVrDqy0htK00rEQYx/lvut8E9z4P+k=
X-Google-Smtp-Source: AGHT+IEFWklTwr0BdToe8q8Dyd2LsVYpzcq9B49hIrgHsM+qLI6lea7XfCdpTPFEyRoPcTJhgDV8SQ==
X-Received: by 2002:a05:6a00:2393:b0:702:683c:4aea with SMTP id d2e1a72fcca58-7027fbe118emr8967854b3a.5.1717588945595;
        Wed, 05 Jun 2024 05:02:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70264ec3d8csm5443733b3a.176.2024.06.05.05.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:02:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sEpLT-006aZU-Qp;
	Wed, 05 Jun 2024 09:02:23 -0300
Date: Wed, 5 Jun 2024 09:02:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/22] iommufd: Use iommu_user_domain_alloc()
Message-ID: <20240605120223.GD791043@ziepe.ca>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-3-baolu.lu@linux.intel.com>
 <20240604165145.GD21513@ziepe.ca>
 <02e88f89-a277-433d-9ccc-af4318a8e80f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e88f89-a277-433d-9ccc-af4318a8e80f@linux.intel.com>

On Wed, Jun 05, 2024 at 10:17:07AM +0800, Baolu Lu wrote:
> On 6/5/24 12:51 AM, Jason Gunthorpe wrote:
> > On Tue, Jun 04, 2024 at 09:51:14AM +0800, Lu Baolu wrote:
> > > Replace iommu_domain_alloc() with iommu_user_domain_alloc().
> > > 
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/iommufd/hw_pagetable.c | 20 +++++---------------
> > >   1 file changed, 5 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> > > index 33d142f8057d..ada05fccb36a 100644
> > > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > > @@ -127,21 +127,11 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
> > >   	hwpt_paging->ioas = ioas;
> > >   	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
> > > -	if (ops->domain_alloc_user) {
> > > -		hwpt->domain = ops->domain_alloc_user(idev->dev, flags, NULL,
> > > -						      user_data);
> >                                                       ^^^^^^^^^^^^
> > 
> > > -		if (IS_ERR(hwpt->domain)) {
> > > -			rc = PTR_ERR(hwpt->domain);
> > > -			hwpt->domain = NULL;
> > > -			goto out_abort;
> > > -		}
> > > -		hwpt->domain->owner = ops;
> > > -	} else {
> > > -		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
> > > -		if (!hwpt->domain) {
> > > -			rc = -ENOMEM;
> > > -			goto out_abort;
> > > -		}
> > > +	hwpt->domain = iommu_user_domain_alloc(idev->dev, flags);
> > > +	if (IS_ERR(hwpt->domain)) {
> > 
> > Where did the user_data go???
> 
> The user_data is not used in allocating a paging user domain, so I
> skipped it.

That's not true.. We have no driver using it right now, but it is
definately part of the uAPI and a driver could start using it. That is
why it was hooked up in the first place.

> In my first try, I simply replaced iommu_domain_alloc() with a new
> paging domain allocation interface. On second thought, it occurred to me
> why not use separate interfaces for different purposes? Even though from
> an iommu perspective, they both use paging domains.

If we want to do that then it needs to forward all the args

> The @flags and @user_data are defined in uapi/linux/iommufd.h, which is
> specific to iommufd. Wrapping them in a common interface for broader use
> seems awkward.

Right, you'd have to forward declare the struct and just let it
be. Really nothing but iommufd could call this API.
 
> So, perhaps we could return to my original idea? Let's just expose one
> interface, iommu_paging_domain_alloc(), and replace iommu_domain_alloc()
> with it everywhere?

That's OK too, this above doesn't really need to be changed, some of
the concept here was that iommufd-only ops would just be directly
called by iommufd itself, to discourage future abuse.

Jason

