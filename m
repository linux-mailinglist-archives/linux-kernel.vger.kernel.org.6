Return-Path: <linux-kernel+bounces-276647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104BE94968E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406951C236FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF7E5339D;
	Tue,  6 Aug 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ct4gK2zs"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FFE4AEE0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964739; cv=none; b=ZfxDwjojfdyu/4RsU+izRK8lyE/Z5sKKin6u9NEIvTGFgI7ff88V32g7/R7iVrf4bhS0C06cpaG7/HEejNjZQj9VNBKhg79QpSZwtYnRYWwHqeir9Wij9IbvWjiPwECuN99xdrr60Rdt7EANGomVMB2M/RbQhaCWv+veDi3knd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964739; c=relaxed/simple;
	bh=IBADP/w6lT+GloFq+zVIBopi0AnD74uQ+eJRhROk9wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDQxDb0E/Dp6loguqc0+Hve25CB51ptafCGXdAq+i5CKP5qIvWp5wva14QPCBF6EgPdzbALRW+DPBI1m8ViYg56pTW8CD4vTBgmfg5oThayNRf5U0fPF325k84RftgRIS862xzwG8pcpdi65yz/t0YC+nNLSs4bDDkVn/oADrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ct4gK2zs; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db22c02a42so568258b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722964735; x=1723569535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VoUl8zSxENKiuQEX79i4MjQfIL5VeaQAVPLC67ffTWE=;
        b=Ct4gK2zs+c+l4afjYvKCOvIHVbsMmnvCa88Urt8LaYUvz6F0J7CN/3CIItvhiVLXbD
         BYcE9Xr9MWXDUSJo/IpiQxLg2P+F2Hox2/GwUQwqHKMl16IjfDoNONKxVQpKaNflhTZj
         wHd1BkO/Lpu0fwy8a1jzXuR/DrzieRB9Y6V4Ql/BI8Q5QVWRDhXXkoyTxs7Mb4GP/vot
         MNoWouqSLp7FEG59EC0oydnZmjw/AVZC4/F9sgnLAyjZkEwo9Fd0faXmqNlugut2iRUK
         eh7+cbrHNespsC12xr432/RwyCRRGhCM2c2dlTptbBnukmgK4wCJTjb6C/HXhx0fqLIf
         CvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964735; x=1723569535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoUl8zSxENKiuQEX79i4MjQfIL5VeaQAVPLC67ffTWE=;
        b=O5NSX8uhdGCliQxiKkkugvr+yYzmddaW90d8L91IXLVAvamYEFfPowfzuGdM6YXllu
         PJ6rWGWJqivcnwNa03DWwKxtyu7am4cvgIgw9rd7He6HQyF02CnZ1qiYksi0UECdALW5
         qgVYZ29Q0gtzhrAuFFcq+kpk4nDdpIZvUYQ3VueOoYCvkZ6IRJ+8aCWJxwTuS571pAQ9
         iDTAz1eXVOIvOA8KhWUzYC7O4xAuy9osIAeicL8BAFYRv14tiTKS+XoY5DANFCczU/nI
         d8Lrr+w6px72ml2l8GUzN3TWECdTKcPEXeAGqSrufTwwnruDWoJ+woxlucOxLzmAbVrf
         OpBg==
X-Forwarded-Encrypted: i=1; AJvYcCV0g0RSpN2aAINWTI9ohFLOxWeIZgJrXnMdyteZ0gnDLj3FesoVlczxQLzFxPmvJk6NRIkb37mBn3+ISpkKkfALHrYSi65jalVKGvIS
X-Gm-Message-State: AOJu0YwfR/jMlXSehCEye7X217ItUwyCa1H0LYSK4+aPAeEB8cdjs9qH
	rcd8JljOiWDET1Iq5VrOIGVyjp5bUBL+z4VAwdF5oFYm3ukBNi9naiiMs1l/imIPq+s2cDpYA42
	x
X-Google-Smtp-Source: AGHT+IHztlUJk3Ij/7lCfrlgZF1fI3NBsUaBeFjNzvqSEvtAyOgYO2NOyIsV7Js7a5m4fRUGZL0AaQ==
X-Received: by 2002:a05:6808:2110:b0:3db:42b2:ee28 with SMTP id 5614622812f47-3db5584dbc0mr17609250b6e.51.1722964735222;
        Tue, 06 Aug 2024 10:18:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6eaadfsm39713191cf.51.2024.08.06.10.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:18:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNpm-00FX5G-A6;
	Tue, 06 Aug 2024 14:18:54 -0300
Date: Tue, 6 Aug 2024 14:18:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iommu/vt-d: Add support for static identity domain
Message-ID: <20240806171854.GO676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-7-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:40AM +0800, Lu Baolu wrote:
> Software determines VT-d hardware support for passthrough translation by
> inspecting the capability register. If passthrough translation is not
> supported, the device is instructed to use DMA domain for its default
> domain.
> 
> Add a global static identity domain with guaranteed attach semantics for
> IOMMUs that support passthrough translation mode.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 102 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static int identity_domain_attach_dev(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +	int ret;
> +
> +	device_block_translation(dev);

Though it would be nice if this wasn't hitfull like this, someday..

Jason

