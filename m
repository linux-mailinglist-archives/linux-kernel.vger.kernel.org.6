Return-Path: <linux-kernel+bounces-244649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C492A763
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CB41C20433
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3712145FED;
	Mon,  8 Jul 2024 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AVaPchjN"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC8713E8AE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456451; cv=none; b=O3djftIJ+cTdjgKg3zV4heN2f8DP89gK9XcvioG8vhMNKUkrzn0Or+OaM72jAeVv70lP0pnumpPyAm+krHfe9tkwp6HWjTaGp566jeoLFGePVQy2kAlPAu2NBDknOIM4hqpoLCscUmj0ovacLAukIkmktpZOrOMao6e9cPuuOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456451; c=relaxed/simple;
	bh=ToqemI+ldYTTw6gsG148j31AJrUX3qaN+RZnDX0lyq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB0aycS9CRdh0zcaGGdVpXbTBZFeeg3TRi6RfYg7168BqydQ4QjdpyHaxx7Fd8X9+WJXuZNK77xUErHmZpTvErdZ8EcpI4LjdsuQGAy+yrIhYak/gcDKw/zZK3445g7H2GmHg03WkrJ3WyQ2vPrQ0+NtFFwf2Sw+zJUwAwFyqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AVaPchjN; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-703631c4930so1121983a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720456449; x=1721061249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFoxv2StTkAy81FUVFoM8zRGh/jhofwCwoDeHKUmFcQ=;
        b=AVaPchjNHr8vqkEJmBRNL2cwdZPSP71CaqelcMN4+nKigJ2X90CVOhQsGRjS9P+bZO
         iX3J72wix9BqN37SBIcVgddk9LFsz+y+ABbEEpWjz929j8IXoUNUdkIbNl1f9/PVw0ni
         lnRNdPwo7MqVOb2eU4PmrN0XuefQzic+J6O/iybJAk1xO34MGf7Dreey74LRjLUzHhyg
         P88MzWKquLQnO0/ovKTY8L1TZmsYm25tdnMh55JFvuZM8Dqrf2/1WfpY85EYsF/W3P1v
         MliO2kC9zyz9YsxmIqLmfD4sFZ1qimLtiq2czCqjUGdvUUm29baS9+AakIH1EYUe5QWQ
         M1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456449; x=1721061249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFoxv2StTkAy81FUVFoM8zRGh/jhofwCwoDeHKUmFcQ=;
        b=bn1BrtIRLEfP1h8kVuRM0Ewe3eqJ037UKyBU3qwFIvEu0dFSQocGuPi40cMSx5rOM6
         GJBgIshBKTRLb9Gb7TPq7A35y6h/rtXa6Ur1dfyTH6hG1t3QNTHYaTSWZUdWqwS1dpHI
         kwEsb6vu8DalAbRZLb/rE9unhhqBBRzvKb48WlxNmo5HKFYcf4mPZW6z5fzG7hQOPBoT
         wa1A4B2X1n6R7q9dMpBkJp8XEVFlHHLSujtjiwbcyJ2DN0oGVGgSOoyds7beeCiisdc5
         fBe/A0LPFfYcPNOLCk9ekEbowM0JJjq1fTOEMIbagKNAa8aALV+54I3t9MzZbKNAXujI
         44mA==
X-Forwarded-Encrypted: i=1; AJvYcCXYwcDA6Ywu8gwogf/7kCIA3+l91gEONV/a22SCrfeuXTMjxowXCkXJ2McbtGylBfkyBXtL6g8+zTkK9ak7DdA7LnnLj8JyMUtwDdsw
X-Gm-Message-State: AOJu0Yyb4EG3R06xAhATveH0HqSyPu/+l6W8TfmoO7SfSGB51AvEpq8X
	H/J2VvQjZn9oTeZsA+N1MHhhIxF/v7fL3a87ANEoXk3JlG/fpUTVOvKBA8MxpUI=
X-Google-Smtp-Source: AGHT+IH+SY7z9YUcEZHvm3NIhA2HWB3anmidOCwHHCYQdqIO1Nns+4jOSBLNnwnl/BLk4XULUJpMlg==
X-Received: by 2002:a9d:7996:0:b0:703:60b7:5de6 with SMTP id 46e09a7af769-70360b761b0mr6939936a34.27.1720456448709;
        Mon, 08 Jul 2024 09:34:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1900f2bcsm7175785a.32.2024.07.08.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:34:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQrJX-000TAF-N5;
	Mon, 08 Jul 2024 13:34:07 -0300
Date: Mon, 8 Jul 2024 13:34:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, catalin.marinas@arm.com,
	kernel-team@android.com, Yi Liu <yi.l.liu@intel.com>,
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
Subject: Re: [PATCH v3 00/21] iommu: Refactoring domain allocation interface
Message-ID: <20240708163407.GC14050@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <172009858593.2049787.5200500337719932334.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172009858593.2049787.5200500337719932334.b4-ty@kernel.org>

On Thu, Jul 04, 2024 at 03:18:56PM +0100, Will Deacon wrote:
> On Mon, 10 Jun 2024 16:55:34 +0800, Lu Baolu wrote:
> > The IOMMU subsystem has undergone some changes, including the removal
> > of iommu_ops from the bus structure. Consequently, the existing domain
> > allocation interface, which relies on a bus type argument, is no longer
> > relevant:
> >
> >     struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
> >
> > [...]
> 
> Applied a few of these to iommu (iommufd/paging-domain-alloc), thanks!
> 
> [01/21] iommu: Add iommu_paging_domain_alloc() interface
>         https://git.kernel.org/iommu/c/a27bf2743cb8
> [02/21] iommufd: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/26a581606fab
> [03/21] vfio/type1: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/60ffc4501722
> [04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/9c159f6de1ae
> [05/21] drm/msm: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/45acf35af200
> 
> [10/21] wifi: ath10k: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/d5b7485588df
> [11/21] wifi: ath11k: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/ef50d41fbf1c
> 
> [14/21] RDMA/usnic: Use iommu_paging_domain_alloc()
>         https://git.kernel.org/iommu/c/3b10f25704be
> [15/21] iommu/vt-d: Add helper to allocate paging domain
>         https://git.kernel.org/iommu/c/9e9ba576c259

Great, Lu can you please split the remaining by subsystem and try to
get them to go through subsystem trees? Joerg can take the leftovers
at rc6/7 or something like that so we can finish this.

I think this is enough that Intel and AMD could now assert that dev is
non-null?

Jason

