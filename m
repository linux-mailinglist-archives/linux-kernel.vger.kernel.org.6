Return-Path: <linux-kernel+bounces-221203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9099990F03B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DE51C20950
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00540179A3;
	Wed, 19 Jun 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="i+o9QDVl"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE418029
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806856; cv=none; b=XYNU3wcgnJFgF4MzYxLO01/Ylvj33sHuTsuoh+RYRjh4R9LTggQObJDsjTlA+ouzdPodrX27CcbOM4maKkHvr4qBl+c8kbRsej+xksW2mFMSjra+1dvFtCCSW0CzBjIJ3FUv78f3bGI3AXWKjj8nBiwgnWzkJWe2c5Y3oigTRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806856; c=relaxed/simple;
	bh=1IT57w3XTjZ596JZPrdRq3lBMOojlNcmKzYqXjsyH+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2/gDVsOmvyRO1qsrOffBFBfTPPfI1BYaKFUl/aPnVgEVKMgm4A7Jpwupj653zTSZswTinxeWzpkVi64MZHAUDTqvIDAUCfcK52Va6MKolaQpXciEsyFN66LbnvozPh52gCjVqmyX7nNYVLBJ0jKiU3Oo0vayzmkVxBqV62vUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=i+o9QDVl; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ae093e8007so12041976d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718806852; x=1719411652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yoE1PBMeOt8AWWOCfirQIQiAXfywLWQ1wTXnwAB5no=;
        b=i+o9QDVlBLe3CayIaSkF3KbsnznLDFEzZGc9cehQxlvvdbjcHO4MuB/4jupM15WmXH
         SyS9b/NqzgkuZGtYHLvgDucUKP35H5ufcfQLgzal+4Uo90dZWXtNns7Nn+KzAN0IJPWV
         HW9WvAKqOtT2rRfiKZLUOMccIHJWJX96R7v1wQw18HxGfz9qmhcxKhJ1dAOw8gylcMi+
         74jYp5A24sqalKNWajVQ25cSU6loWAeO3iJtkBcuNBroyoT9InWWps9iRzvPalabkRfc
         skhhknFLe3u5oBGhtlempQO4S9OJfszxFKuXnXe+yyQliJVrDvboZymz6Xa5/J6E1xXe
         Fv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806852; x=1719411652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yoE1PBMeOt8AWWOCfirQIQiAXfywLWQ1wTXnwAB5no=;
        b=mJxsIrwSgk6FD1gb55+TJNoYSAPbKUyv0FRLRqy+pDppdzWvPId+7/jHGqJvBk1t6/
         JtW27KV6zxe2UgbzjWA0qXryhXNUA6dq6CeLg7uDE4fIM7Kuv55Tj0s33yLG9LlIOXfp
         6ohzlYAnZoM3LwIUIeKfUl9nkmz/BFRGrFoZjcSOUzbpOinWtOKvIu7ksUu3qqsDB+OY
         xa6Pv0B07KLnyBAwepcuyq97fLIrS8NIMUt4E0dImYWKYCpLz3q7cQ/azj8cfk/b+TFP
         t4YUcyKXXgq4+wA3DW+xs/wyC0g7p2ztHFUCt3r6FAztOmGNFaJam81tb238+CluFVy3
         WeTg==
X-Forwarded-Encrypted: i=1; AJvYcCVcokeoKAR00SytRQ+fqVBanCRvuPYH2CMcZraxXFbQe2wcmz9c0RrzEwQdszbJcyMTvFs3iyDHezJ38d04gKALO2u/pECxBysf8LPT
X-Gm-Message-State: AOJu0YwUcCkRy27Ea3RdUSmd4cBBEphZuthsClooNvHSNPJiBtSCReHw
	+f7moFlK7j6IZJmSntAY747E1jXECTtSfU3+72aCplbMn4eJOTH3zLpT/PsPFY8=
X-Google-Smtp-Source: AGHT+IHRnNfM3kpcWftEa4vzfduj3t2OxKbu1f062TE8ncSp4oMlwh+It4VOxlc2xlXVn+nW/690wQ==
X-Received: by 2002:a0c:f093:0:b0:6b5:a5:f5f2 with SMTP id 6a1803df08f44-6b501eabd0emr29525536d6.55.1718806852061;
        Wed, 19 Jun 2024 07:20:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b503445091sm9427136d6.101.2024.06.19.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:20:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwB8-004YTZ-Pt;
	Wed, 19 Jun 2024 11:20:50 -0300
Date: Wed, 19 Jun 2024 11:20:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
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
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/21] iommu: Add iommu_paging_domain_alloc() interface
Message-ID: <20240619142050.GG791043@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-2-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:35PM +0800, Lu Baolu wrote:
> Commit <17de3f5fdd35> ("iommu: Retire bus ops") removes iommu ops from
> bus. The iommu subsystem no longer relies on bus for operations. So the
> bus parameter in iommu_domain_alloc() is no longer relevant.
> 
> Add a new interface named iommu_paging_domain_alloc(), which explicitly
> indicates the allocation of a paging domain for DMA managed by a kernel
> driver. The new interface takes a device pointer as its parameter, that
> better aligns with the current iommu subsystem.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  6 ++++++
>  drivers/iommu/iommu.c | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

