Return-Path: <linux-kernel+bounces-430932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F99E376C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42D9B2D10D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FDA1AE876;
	Wed,  4 Dec 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POl2Eeym"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B919D09F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307671; cv=none; b=PtlCh/6xZvtc5Ae4/t9Hql+tHN7PnYD8RSoLSXi5IQrNYGgPgdfgjwQTZhu0zwHkJfJ15bAhokSWxm5aMpbCUqlT3+S7ggEawT/t2W8aR9gyWmXAKZWa2ylFTl4OglLtbAiDlOMqVKVybx7AQYrS5lOOCC+fxZ6nNNxGIb5SwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307671; c=relaxed/simple;
	bh=8OglyKPuM+rLJ9GvllSkUBKAWUM5kMNHR+1UXlOULOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odmVGNxf5rVd92g/nMKQJj5jh+lkCMx8dVxOmq7lcq6heR201XMoEMnymYdlu4MG1+8dGEnNp5m4j6+gdvpm/bh85WgM6mjpiMCIxYoPu1JXOh+uX1IO61XlzJtzYb1SQdaeTLv7rOBYmA9wGlmu2iOxd1TYrbDODIwC/6IVywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POl2Eeym; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349c7b6b0dso36305e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733307667; x=1733912467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkYLTBgm995LkjvCxemjC6Jocdx1o/Bh1C0vkU2Fy7M=;
        b=POl2EeymqwY2jNpVyBb9Po64L0RG8uTGe4FG1ptdNwGnGxl53Mo56b4DlPF9adwOOP
         +LO0r9e6KoKi4QUAHXZ8yt1npYEq9E3wb8uW2x6Oqlbk7gZbyDljNNCfno0naKKKDwbl
         zUi5vZo49fS61vActY48wIw6XjZHbZzf1UqSqQ8lQ6o5U5fEyQ/DpA1IxgGZzRVdKdis
         9QvOkYiSXPjVRWAFdoDkwtHiTBum/KHq+UlCpDBazX5v87kX6CA47ktJBjX9eKRrPX7G
         XdMQ5jGtb7lVDfgzX7OSA/SrnmnYaDUswCfAqRxcWWUrVdDZzAk8dxfxzheKGyPpvlZK
         32Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733307667; x=1733912467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkYLTBgm995LkjvCxemjC6Jocdx1o/Bh1C0vkU2Fy7M=;
        b=Y5tPLkA+YN9fl2RTBHufTGnR03ABQkbTWL22hKGJfKJ28e5bX35YmHEQ7hyJlcdxGW
         utt6d/FxKkJB1xd8a9VdCx3yJMC8mrih9mSxHTSu60kh0TjpNGHfUF44Tm/8Pv9Bi8QP
         sm0jOW7eb+cAwNcT/ZHBhFtuYvH3Jane+l4NkprKIwHyK7CPXDfu4OBUBY3WNb/MUqAm
         44yLLcEwqZlTARjxPgBG6t/V2NcnKniwPednB8tjDTjgu/p1wNn6OBpnHIIWjeEhhATV
         GQ6Aub92yUQGnrJ7eTha0oqWS0oheyL/mAOPKyJeeqQrT/r22UrEegk74XBHqXmjfW51
         55bA==
X-Forwarded-Encrypted: i=1; AJvYcCUmNex9PNUKt/zfxO7GOxfnpaM1uqjAwjt1lJ+F9FzwPW3WVmrHfns4L9ICbX9ex8ikiNwAszCxN/M7Ydw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXPqtJArDFMRI2jl2ECWXf6SZPDsQJCnEtg1gghdHyKMEEeMb
	DE6CNPwukqvMx2K78pVvgSqBB03EpNl592ku+CruG4TL5eYWmH5XYy3xTBQSZsMZtk7IZi5ST/6
	IWQ==
X-Gm-Gg: ASbGncsYRnJJeR11TXfLYCxGJOwfCj5QNgo3f3NX4aw+D/J8JH5lJ5a6pm/Xz3s1pHm
	CDhdACrSK9XuK2Lnu7XX+dDxZmiQCNcn8iXerBU0AeJdeLCQK2hDRjVTvqRyu2TtxW4VovWbTzx
	1luSimDMFujSdFFIa+BUilHHz5Ud40bMmkECH9JBNoS388LtUWs1TC0YelY002v/yImqrCEXb+F
	bEp9fHnbbJ386HMgmK7hFZ+q1q3w+4b1dN2udzLWT9l9aehvqIa+7N9y9lGNmLr6pKeLXVNhf0A
	OF3BJj/Qm3aq
X-Google-Smtp-Source: AGHT+IE7T8d7TZw5PeKMBFpYLBTez7iD+72RMF2IGZ5bXAf6OdVX2raWOJrJNuhpXSW4NzSb1otqdQ==
X-Received: by 2002:a05:600c:5113:b0:431:43a1:4cac with SMTP id 5b1f17b1804b1-434d528f647mr784575e9.3.1733307666792;
        Wed, 04 Dec 2024 02:21:06 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cb6e1sm19021945e9.37.2024.12.04.02.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:21:06 -0800 (PST)
Date: Wed, 4 Dec 2024 10:21:02 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 3/4] iommu/io-pgtable-arm: Add way to debug pgtable
 walk
Message-ID: <Z1AtDgLD0SDUxDHl@google.com>
References: <20241028213146.238941-1-robdclark@gmail.com>
 <20241028213146.238941-4-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213146.238941-4-robdclark@gmail.com>

Hi Rob,

On Mon, Oct 28, 2024 at 02:31:39PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add an io-pgtable method to walk the pgtable returning the raw PTEs that
> would be traversed for a given iova access.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++++++++
>  include/linux/io-pgtable.h     | 15 +++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 88b128c77893..6739e1fa54ec 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -762,6 +762,30 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>  	return iopte_to_paddr(d.pte, data) | iova;
>  }
>  
> +static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
> +			      arm_lpae_iopte *ptep, size_t size)
> +{
> +	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
> +	data->ptes[data->level++] = *ptep;
> +	return 0;
> +}
> +
> +static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
> +				 void *wd)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct io_pgtable_walk_data walk_data = {
> +		.data = wd,
> +		.visit = visit_pgtable_walk,
> +		.addr = iova,
> +		.end = iova + 1,
> +	};
> +
> +	((struct arm_lpae_io_pgtable_walk_data *)wd)->level = 0;

I think this is a bit fragile, as it only works because the walk spans
one address, otherwise it breaks, the visitor will keep incrementing
the level. IMO, this should be removed, and the visitor already knows
the level as it's passed as an argument, so something like this:

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 6739e1fa54ec..bc73f9edae8a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -766,7 +766,8 @@ static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
 			      arm_lpae_iopte *ptep, size_t size)
 {
 	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
-	data->ptes[data->level++] = *ptep;
+	data->ptes[lvl] = *ptep;
+	data->level = lvl + 1;
 	return 0;
 }
 
@@ -781,8 +782,6 @@ static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
 		.end = iova + 1,
 	};
 
-	((struct arm_lpae_io_pgtable_walk_data *)wd)->level = 0;
-
 	return __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
 }
 
Thanks,
Mostafa
> +
> +	return __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
> +}
> +
>  static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
>  			    struct io_pgtable_walk_data *walk_data,
>  			    arm_lpae_iopte *ptep, int lvl)
> @@ -937,6 +961,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>  		.unmap_pages	= arm_lpae_unmap_pages,
>  		.iova_to_phys	= arm_lpae_iova_to_phys,
>  		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
> +		.pgtable_walk	= arm_lpae_pgtable_walk,
>  	};
>  
>  	return data;
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index b1ecfc3cd5bc..d7bfbf351975 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -178,12 +178,26 @@ struct io_pgtable_cfg {
>  	};
>  };
>  
> +/**
> + * struct arm_lpae_io_pgtable_walk_data - information from a pgtable walk
> + *
> + * @ptes:     The recorded PTE values from the walk
> + * @level:    The level of the last PTE
> + *
> + * @level also specifies the last valid index in @ptes
> + */
> +struct arm_lpae_io_pgtable_walk_data {
> +	u64 ptes[4];
> +	int level;
> +};
> +
>  /**
>   * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
>   *
>   * @map_pages:    Map a physically contiguous range of pages of the same size.
>   * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
>   * @iova_to_phys: Translate iova to physical address.
> + * @pgtable_walk: (optional) Perform a page table walk for a given iova.
>   *
>   * These functions map directly onto the iommu_ops member functions with
>   * the same names.
> @@ -197,6 +211,7 @@ struct io_pgtable_ops {
>  			      struct iommu_iotlb_gather *gather);
>  	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
>  				    unsigned long iova);
> +	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
>  	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
>  				    unsigned long iova, size_t size,
>  				    unsigned long flags,
> -- 
> 2.47.0
> 

