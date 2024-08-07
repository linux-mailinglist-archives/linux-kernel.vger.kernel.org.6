Return-Path: <linux-kernel+bounces-277870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C988C94A783
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810C9282644
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54E1E4F01;
	Wed,  7 Aug 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bW83SjQB"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37F1E213B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032559; cv=none; b=g0XCtAkoFYR3qMNTyHqWQ5KDvhsml+vsFllGL05GHfTt5n01DRs//04eJGZD7uBO4j5bGZ7Y9axAqL5+RoTmzVitBYNefQK/SbByEa11CliRGRCcoZgdwdlSQ0zVnKXfw+ZPCiT7qblZgohaSFbHauh7Q+1vSAZpF6TIZMmdA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032559; c=relaxed/simple;
	bh=+Y6GWnP1+MQe2MB/QuUAk+X+C6Y7NQwVJjcdav32LgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gcx6h9ZHDpquTJNtfVe71kPi8OJIqO341Cku/SZfozGvXPKaHf2pZfHcSRub2qmj5exooRe6ens3jw4WuXbriOFSPIKxPGMK43V3kmy+m2bqm1wA1Pq44ulpoUWhuCZtn7GmkAA6Jr/sMDANEoKFr/9EwuI0c7fXD6hlFaodmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bW83SjQB; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44fea2d40adso7970351cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723032555; x=1723637355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snW/PV7nq5nRVPwlSUYRJgZXzOG2u4xZdipMsckI06g=;
        b=bW83SjQB3xJmbQ1zQXKa2IjWmWpdBvwf7LTqt9udPYx/pDMF7oCGQzp99cG4UOnUDT
         NPnBkq5FWtBRsBUQWg7LpX30MtTq6oPuDL0pDF950Gblh+mBCa/urng3XOZYI+hBgI9K
         Hp5xRukgutYszKUpc29lOBgZ9DWnYO1DAnwVRT9j7OPXtyfsOarAcEhwIHtWPpLKvauQ
         7wpeIMO7Wp+3gbYiVTn74kY9Y2FsVJIiI5x5SI/Q/xYYwPft2zeHhgxcoFl9OUVVLEAB
         GvZXKdHIv7L5BqGneLM21Vfy5Ij+L5K7Fn37yQ3znVXa4Z9YJwBMReBGGOwG7novFIMO
         d++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723032555; x=1723637355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snW/PV7nq5nRVPwlSUYRJgZXzOG2u4xZdipMsckI06g=;
        b=fhGnqKRYLLeC/nazgX0a+PhfBwPuSt+4m4Nm5Xsodpz5kbe5N5yQphFuOZQC/1lwnY
         yJ39ovg4tosEW8hcgdSdx/9fzqUGUhGaOZhmgJeSFXDwfEfPscSQ2VJsm2TPB6pllTtY
         jFG/5fiMaZSUvmEQEOTQtRulhwcL0uJQynEjfKeAjX8bWzgPNorv1FdLy33gET9WAj7/
         6QNh0zUGvn6TN6p23Yk/qlMCDdXU/ZrCQ2Sviau2JcVi7OkpVhZgSrmAqxkWm10deiSI
         CnSfaFLVWEPKf1l0eWflZzV/n2zmriYgGj1ZcZ8RvK0ohOP10cjv7wlgosBgsuRzaR0S
         qXEA==
X-Forwarded-Encrypted: i=1; AJvYcCUcm2M1xB5QFSluju1qZ9kRvMt7mDrFNSxXEnfnn152HI9Bui8CeYIkwXww6lsixBESGd/1WvmWEiwUh2a97xF808RYhFbJbEict1ow
X-Gm-Message-State: AOJu0YzaYaCtCwXoBcjAa1l1nrAxRZd+bzKUA3CmgQgrmpbF11NbOK0J
	u8D3jdM3nq8s9l1nmRbPR4wvLKCg8hHvbCtRQH8RdI4AWGtAZoai0/w7b4XosCo=
X-Google-Smtp-Source: AGHT+IH1iHA7GJrKiIQAdJfVn30gcsWwU242oRypvDRPgmnje4xxxq6RqcW9n9NLu0ZivAAsHLBieQ==
X-Received: by 2002:a05:622a:1788:b0:447:ea35:95ed with SMTP id d75a77b69052e-451892708cfmr219851361cf.6.1723032555501;
        Wed, 07 Aug 2024 05:09:15 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87314b3sm4325031cf.42.2024.08.07.05.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:09:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbfTd-001jVl-L5;
	Wed, 07 Aug 2024 09:09:13 -0300
Date: Wed, 7 Aug 2024 09:09:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/vt-d: Always reserve a domain ID for
 identity setup
Message-ID: <20240807120913.GC8473@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-4-baolu.lu@linux.intel.com>
 <20240806170653.GL676757@ziepe.ca>
 <59eb2544-1c85-4fde-87be-4d97e1f0a246@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59eb2544-1c85-4fde-87be-4d97e1f0a246@linux.intel.com>

On Wed, Aug 07, 2024 at 02:19:57PM +0800, Baolu Lu wrote:
> On 2024/8/7 1:06, Jason Gunthorpe wrote:
> > On Tue, Aug 06, 2024 at 10:39:37AM +0800, Lu Baolu wrote:
> > > We will use a global static identity domain. Reserve a static domain ID
> > > for it.
> > > 
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/intel/iommu.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > index 723ea9f3f501..c019fb3b3e78 100644
> > > --- a/drivers/iommu/intel/iommu.c
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
> > >   	 * entry for first-level or pass-through translation modes should
> > >   	 * be programmed with a domain id different from those used for
> > >   	 * second-level or nested translation. We reserve a domain id for
> > > -	 * this purpose.
> > > +	 * this purpose. This domain id is also used for identity domain
> > > +	 * in legacy mode.
> > >   	 */
> > > -	if (sm_supported(iommu))
> > > -		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> > > +	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> > That should probablyturn into an IDA someday, it would likely be more
> > memory efficient than bitmap_zalloc()
> 
> I have tried to. But I failed to find a suitable ida interface to
> calculate the count of allocated domain IDs to replace bitmap_weight()
> in below code.

For something debugging like that just use 
  idr_for_each_entry()
     count++;

It is a weird thing to put in sysfs in the first place...

Jason

