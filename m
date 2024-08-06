Return-Path: <linux-kernel+bounces-276638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9094294966D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCF51C2028E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758880045;
	Tue,  6 Aug 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C38C75MX"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D14D8A7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964017; cv=none; b=catIQacATJvSnnYsIqq2RM01iD4Tj1h/5zK/ggerLcmefmuo+G8wybcfqsLlXuk7+CYnuu4C866zqsflTmkuw9URCcxQOX6mJv3Pd7qSpTSaR8BoI6r934GGFcgPeQBWP1gjs3P5qKj+RrBnx0LwhqXrVSRibSZ1JcmcKslpH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964017; c=relaxed/simple;
	bh=pYXWVAixb0TGzW0+4z41mcpkWJcYtHb79k2+mXUZ5kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMJsjBieRmcYMaHJ9++ICBvna9dCpVR9WxhaRdpOvo/DOhEFHijd0RM29eJU/n5EVA9eHbSYg/SpiqnZTh83tfzTsIfS/qIpy7YkneVmjtePFcMb1gOBJZrRkHsuXidrdCAb0CMXi0vfgU/W6rkcM9o1Ib5S1qG7IOjTl6b6dlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C38C75MX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b78c980981so4720026d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722964014; x=1723568814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZupS7pfQdW0meLSGlAB6m+Zc0i+CePa5pRy6YLAKXQ4=;
        b=C38C75MXurYAonROhGYfsBV+/cZSWXU8MPT8iAvKnn+ehptgkbcmUv36YJ4z7zxDuW
         +PvfwUjadNY6E6Gt7OQFhqWbZ+nBbX8dRneiRjOXAHJuRxfpNjLodV3q8YjhDUmJKcPL
         QDRmSGRhZZAccaLP9bDv5wjxKP58MiRUxV3xb3DdhuPAAkRPoAzKkpCmboPbX7PSFol0
         lobTmA8NNm0iUv9veTyuNst96d8fWMnaVg9rgY+hvBi4RwdErn+nrgG5ne41PvSCZD8c
         WD/SywLq1hNlQQyGlZOTycoYpH3MrDj1eVG/s+c8yuIb2I+k1hDGIApH4JCQZWkYTRvn
         qLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964014; x=1723568814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZupS7pfQdW0meLSGlAB6m+Zc0i+CePa5pRy6YLAKXQ4=;
        b=R42R/yodN9TCE81XGP/YACIe1NVUCZ5croP2JBFWz22GLrtUNjWumv39wwrfmNvvLK
         eITEeWqFRLS83Lxn00Rhcl6nq2UIH4xMrXPEOjlPyPZSjB/eZ7TxUUb9ILmCKFkv09bk
         MGxxruVeyIZ6igR/qqNPO2tkM1nc/ENaxCaoBrFo9bZcBQ6dxvFP4ao/pNjszqaQrFbO
         dH66mjC6K72QqaoKwmSFWn6SfhMy77lWZzXhhgAmronigNBjA4SptCFDYOFfvMHJ1JQm
         oW3p/L3GD2d+ROxYwEc1UIlQpB4pMBIPtdWwHT92QHhz0uWHy3MGu1zqqo6dTNb03bFT
         XU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHNQo9zDK3aPWgGeskfmRHXjHfh7yNznwVw4XMG2xgFK7bunlckAb8tgt/BZCsJ6WRSWV9lgv1CU1WhHBRWvi/lM78yLz4aSus44pR
X-Gm-Message-State: AOJu0YzybTvYhsmLAX0MJG/TeCaxSRyE/gDufXkb2EZwBi8ToAfv014y
	WXw/sJErRZp4IudfeVSwPy5mBewboKiSe2ZinSGFshCrH+CBx24sR6ev6eSDCSA=
X-Google-Smtp-Source: AGHT+IFmWGNv3wd4KVGiX2u4W4ZqwihouWJ7Lf6SWUySvG5saWPfrszb6atjhcfd6w1r+BLQVZDajA==
X-Received: by 2002:a05:6214:4985:b0:6b5:e1fb:68ee with SMTP id 6a1803df08f44-6bb983b8d74mr214316966d6.25.1722964014192;
        Tue, 06 Aug 2024 10:06:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c76f8ccsm48546856d6.4.2024.08.06.10.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:06:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNe9-00FTrp-6p;
	Tue, 06 Aug 2024 14:06:53 -0300
Date: Tue, 6 Aug 2024 14:06:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/vt-d: Always reserve a domain ID for
 identity setup
Message-ID: <20240806170653.GL676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-4-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:37AM +0800, Lu Baolu wrote:
> We will use a global static identity domain. Reserve a static domain ID
> for it.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 723ea9f3f501..c019fb3b3e78 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>  	 * entry for first-level or pass-through translation modes should
>  	 * be programmed with a domain id different from those used for
>  	 * second-level or nested translation. We reserve a domain id for
> -	 * this purpose.
> +	 * this purpose. This domain id is also used for identity domain
> +	 * in legacy mode.
>  	 */
> -	if (sm_supported(iommu))
> -		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> +	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);

That should probablyturn into an IDA someday, it would likely be more
memory efficient than bitmap_zalloc()

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

