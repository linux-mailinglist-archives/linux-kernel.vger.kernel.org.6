Return-Path: <linux-kernel+bounces-234734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE391C9E6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3062E1C21621
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0EE134C4;
	Sat, 29 Jun 2024 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J20d2MKC"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC9B64C
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623512; cv=none; b=bEAAGTNQfKT+mFX0LBL1kCjpjVLXuUPrRM2UTZ21r5nOZGR23dQVKooq+t0QDH9y2FVS3xo+oQSRMv4nJPIoO5fbH73HB7mItYAcLt9YTRbX0xwaCQSrmb+z7FL0H5dADdUUAQzmI6G2n22cr9jHM8ABiAdHQc6TYEOJpmTqWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623512; c=relaxed/simple;
	bh=7nlIwZaLCYxUa9fHgv2z1TOWXwJyMJVnO79vebcTU3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah8YFdjEpe3qL7jqTa3e66NhRdoxBeJ+yxUlls7g8SQTe5DGqhsl2l44adkmU3kuxOEBs8NYAS4+jAgfRPlkh3C3MeKpuLqE5hARXh1O5izDHYFtp3DbM3PI920hKsJ+BJh+P1IdGsPiJaPHeiTHvB6VojN103/d59+jkcyneNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J20d2MKC; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9cc681ee0so626871b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623509; x=1720228309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DKTq9ZB/l+FyCxq74u0wbRTGw61SKT8yAOsLzmyXh8=;
        b=J20d2MKClZTu6IMl7BFciBd0FXVsTh7n4F1C9Q4CJ9pN+3ew4h8LRNOhoBQS+KGIPY
         VnARzMBqTTKzkJIrUZE484SSHSZ11Nez9tUEYaYDEkxLfQhLwebwsjlY1pUPqx7Y4qn9
         PNMMTwiVLQy6d/FZDcRkC/PLtYOOUKHYrjieY569cL25XZ3r3H+SAeZbgWgLbwoeU9fo
         W/5EfItaSMks+a6KQw1eh8RLDPUOyUQ/G1fwGnek9CuTphOoys2iHiRDzZ7kA0d+ODO/
         J5O/GJ9YnAzlgm1UL81KJZdZ3/vvagsGnpeICjmZ/1Slfo7SxNks1ZFWi/jobtsSQafD
         SmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623509; x=1720228309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DKTq9ZB/l+FyCxq74u0wbRTGw61SKT8yAOsLzmyXh8=;
        b=IGWDaIkidEWze+Hizz0iMzzYwrnNrEcWoqHDqIyHGXGej63jFRkLsl+MwE1vTfmlXD
         kgqq7y1xvPK/AklgDGPCsuIItgSgpRtF9wKEAW26jahGazk3fjxoKXrC8mvU3WX9NvsA
         ULDrAAQiYjSVbRK6wqacSZGEKdKldwhCdVe71Kt+CsSwbHKdBWzGsuZ6GOZBu1WRsMt9
         P5yF7yjvAknBehf54DcD9JGDMDyrX7QoXWFMb5AteuxUpvw0LbQL6g6sE5iI2tGFeLi0
         pFQQ6wGs/ZhDBmKG20Je2FHDSRWXc6MPALcxAIAItmHJAjkuLwWVx28MeEbHTrvVXUte
         mrlw==
X-Forwarded-Encrypted: i=1; AJvYcCV3XWhzzax3mxhTUmlp3suC/UXOVUprHcqQf7wDz+j7fOm0Z92nd1/qNWtY/8uh/9t2HUqAWtHdjcDDeKOAp40+2WGJ/Mfyycq7tyNQ
X-Gm-Message-State: AOJu0YzlzXXJP2d427o4NQQLdL0sgXPQQtirpZMGqtqSo3s07muXvaMG
	4wI9oVBPTefSipHxe8LgvxaEZd3jV95J22aJnhcjIgHhGKOkYcD52NjiUl/VFlQ=
X-Google-Smtp-Source: AGHT+IFOlesedZdEydbWFXLPLqGu9bC4AvxCTT6KmpZB2VDdZZsxo1EB4l2tZfq1zV6VCZyZuBGDNg==
X-Received: by 2002:a05:6808:21a9:b0:3d6:34d5:22c with SMTP id 5614622812f47-3d634d50632mr2347556b6e.39.1719623509555;
        Fri, 28 Jun 2024 18:11:49 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:48 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIUX-00049z-LI;
	Fri, 28 Jun 2024 17:46:45 -0300
Date: Fri, 28 Jun 2024 17:46:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/10] iommu: Introduce domain attachment handle
Message-ID: <Zn8hNQDOvAJsQ5Fg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-2-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:46PM +0800, Lu Baolu wrote:
> Currently, when attaching a domain to a device or its PASID, domain is
> stored within the iommu group. It could be retrieved for use during the
> window between attachment and detachment.
> 
> With new features introduced, there's a need to store more information
> than just a domain pointer. This information essentially represents the
> association between a domain and a device. For example, the SVA code
> already has a custom struct iommu_sva which represents a bond between
> sva domain and a PASID of a device. Looking forward, the IOMMUFD needs
> a place to store the iommufd_device pointer in the core, so that the
> device object ID could be quickly retrieved in the critical fault handling
> path.
> 
> Introduce domain attachment handle that explicitly represents the
> attachment relationship between a domain and a device or its PASID.
> 
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h     | 18 +++++++++++++++---
>  drivers/dma/idxd/init.c   |  2 +-
>  drivers/iommu/iommu-sva.c | 13 ++++++++-----
>  drivers/iommu/iommu.c     | 26 ++++++++++++++++----------
>  4 files changed, 40 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

