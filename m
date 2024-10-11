Return-Path: <linux-kernel+bounces-361494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA3499A8EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2D21C231A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5841990C7;
	Fri, 11 Oct 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Av9Dy6VB"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2B199256
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664289; cv=none; b=FGAmWXK38zXCY/ZhHM+cBPuNtoSvZ//aSaMRg1k1EdK0L8/MQTtbf22+7C0T1l8M0Ai5P5Cu+ffU46um69UQGGmQ7b2EFVL2cW+bVHEFjaBPlzHxdmoeqUEk48wG2b8pbODxP4jODU5ouQjZP6/tRPqA10MxoEXAerctgwXamZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664289; c=relaxed/simple;
	bh=525ehD9jVRzxqbpKXu59TfkRlURdR2IlhfGKgW7tqZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzhDB9jlumEovdcbqU155nnCcUcZzC4szBD77naqHyoQASmqYUDvuuNGXjTizMpic1ZEwV37jJNoERRcaQ2ayt29cKlDK+M94MJDrptqqQwNxkv+1D2RKNZSXOtkvrSHENwZVx6CXhAyvpbaKfFsBsmQ7k2/Mx/6r/H5THNAV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Av9Dy6VB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46042895816so23201171cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664285; x=1729269085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATpam0YiZTzpjTWMzxJV5L02/OwsB3UVIOf2m/lEpH8=;
        b=Av9Dy6VB4b1skhAP+ZXYaWvCeZOBNrKxVj/g3tdgDCaApf5zer08hW+eQCtB8BG6Uk
         +ZY3WuiihlGQqe2t3WuLpoV1+IMVCJlif9PFw5N3FoEkz+gpEDTu62S3Lj1GYcjWqOA+
         6QP/gKqB0ZHRAKfxnwnF+dTjPeYaXOp/xEeGyRh44ZhGrObsPuG3Kc0Bg4hJ00ER2jUU
         n7aJVePapXYvmZUzc/uLc+Co1usQqj8xqkWyJ1S/809MlfTcKlRdYU7vjkiRdXh3rj07
         symaRWAsqITBa1fm+s6FoWC58CQ6OoNZc7C8Gv7wgn787gcNIOgpDJbIG/7jg72uqHRw
         ETSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664285; x=1729269085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATpam0YiZTzpjTWMzxJV5L02/OwsB3UVIOf2m/lEpH8=;
        b=ZYDYVQlDZ5/YDu9HE9LfWVC2Teg+vpkMbCDiUWOpYWpB665Wue8+LzGCmrlGa34ltN
         CJH7XLp1xTGkKk12NcWkm3/koqif67MyFoCrWre3dr2+TSoFt/e0KfrGwKaEWcSzhj8/
         ODqVqGb6QWBbKn6eavcCykyGxMvrxK/WcoXyeEIo0TcIKwXbZeQclLO/8OzNdlVeKW8k
         +kKTa8xlT28cQ1DgBkHfMXYHoPVO2LE1tFxX4taD4tW7EKv6RaFd58HF3FXkcTctwnkH
         9NK8+aarq9zq0ZJ+eOUvmhv8oSecW8SH5sBGtDY80Fqk94xo2oC9Vxz4ad7QC35QGgKV
         LfUA==
X-Forwarded-Encrypted: i=1; AJvYcCVDyf/4rN4+zLWgGRu+B7WpbsmjLGQqfHz9NCwc8TmzLA/xrTlnhkzHEjYOjR7q4/x81Ib51iFa76zinE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypYKiV+KMZoWvR3AmzUL0+cYE8FuIa8svrRy1AsvmPtq7ei3XS
	qbkHuJEOjVi/AhjKCekXRY0d/NdgUr/uwOC449OxhT2XJBCDI7OYGFR7zN7a4Ww=
X-Google-Smtp-Source: AGHT+IG75EhZG0d5M9MeHOGeqzGArKbIsd9k8HqJa104wmM37x2TGfXxpHNROC2Jk+MqDGWYtqA4YA==
X-Received: by 2002:ac8:7d13:0:b0:458:2fb7:5035 with SMTP id d75a77b69052e-460583e8b95mr2814621cf.3.1728664284832;
        Fri, 11 Oct 2024 09:31:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460428069c6sm16882951cf.49.2024.10.11.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:31:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIXz-007eJV-Qa;
	Fri, 11 Oct 2024 13:31:23 -0300
Date: Fri, 11 Oct 2024 13:31:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/vt-d: Refactor first_level_by_default()
Message-ID: <20241011163123.GO762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-7-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:21PM +0800, Lu Baolu wrote:
> The first stage page table is compatible across host and guest kernels.
> Therefore, this driver uses the first stage page table as the default for
> paging domains.
> 
> The helper first_level_by_default() determines the feasibility of using
> the first stage page table based on a global policy. This policy requires
> consistency in scalable mode and first stage translation capability among
> all iommu units. However, this is unnecessary as domain allocation,
> attachment, and removal operations are performed on a per-device basis.
> 
> The domain type (IOMMU_DOMAIN_DMA vs. IOMMU_DOMAIN_UNMANAGED) should not
> be a factor in determining the first stage page table usage. Both types
> are for paging domains, and there's no fundamental difference between them.
> The driver should not be aware of this distinction unless the core
> specifies allocation flags that require special handling.
> 
> Convert first_level_by_default() from global to per-iommu and remove the
> 'type' input.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

