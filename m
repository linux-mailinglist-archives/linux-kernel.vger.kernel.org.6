Return-Path: <linux-kernel+bounces-211581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC93C9053F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60370286C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082217C221;
	Wed, 12 Jun 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GXa2xF50"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718391E504
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199684; cv=none; b=Fdp+6Kv0hhkaINUU1AL3v51zyTCu0jbo/sJSQ8ro+9nTXdmrVLwdGvtrRw4FP8eXLP74Jvp6+iYKAm/b08C/Y8eWNgBusr6vd4yRt8OWph4nWb8eLoW8hJvAq+xYk/JTdQ6RgeGKQU6HqeobTv6AWMdMJ1vTwYJCKJ3lAL+Rn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199684; c=relaxed/simple;
	bh=uBT7vUYzRxnNkNdZfK9+gVAa0bI6bEGIF3WRyxtN3+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvludsgjAt073C5SdEa9XY9Gx4d3Hp7CUzipGFuRRBy94bxKRELHMCYXXPwxXATUbkD0E/MDXfA3DFpUOCT2sX0okRKFdYrS/l9FIMNT/Bi4HM5liwO1SYkTCQxxccqOGu4jS5xDqUKXtey3rS7gpw7OFutx6WQBAKLvz9pD0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GXa2xF50; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6adc63c2ee0so11004436d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718199682; x=1718804482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r+ZhQSvNAOb5p0/jqmLJRKx9ZqGMPzys9Xujkbr5NR0=;
        b=GXa2xF50YauOYPHY9kXO+/fsQ1NDWdBNWH2ZqNTsxW9nu0lrcCk/wXeUmITAXD+XLy
         EGZMjSic7N2oYecg3DTVu5jJ35BeMBFGAnwTCsiiD6t8xthsaA8FdTdzUe6ULZKL0A0z
         39xSLwOvn1QwG7wiT4Ka8eTKV1QWl3EDVtAlwBdfsIFz+VrPEjGPTcCz5jnLy3RwEqCv
         uYGoQzUgkvwlld20dqFUxjaTa8jA3MrMwpDzm6445C05YZY2tWLeQL/7TR3kfcErxqnW
         4hjY6qUTV8wt93bbgTs6p5zVnrRS/O4dVZX6tuBY/5ekLaBS7tOmTi4u5e+leMOM9qtg
         N+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199682; x=1718804482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+ZhQSvNAOb5p0/jqmLJRKx9ZqGMPzys9Xujkbr5NR0=;
        b=FtKpW79MJ2CvFDKiJLM9TbO12HvMVnE9yhSa97m/lHQ/vwRO2xgGq2vUYTNqBPJFm+
         pvW3mi5s72Hkv/1xi7K7cWYdj6tC2J7ofON8IKtvgMyXBjAKG+kpUb3ZYVXy/cWyCqx5
         8z1UAAW3KKOu7YOT4Q2ksdVTXQQal6S4ezWD3LqqVaEbM0VH1Q5/voq+2g8jBBnuyHJa
         /HxXWkJxWg43MUxwferviWp8wjTQlq5cx0ctpLxKSd2I/jcf7zFV33flLLnSRSu+51pe
         suYK98sbN9LsSq+f7C6trrFaCkvFTj47E2nn5cE7vjBqZ7qUNnKazDGuffN/40feI0Uq
         BQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3T5a8OMdPpFCGww7qglPcv1YuM7O+Ss6ApLG/ivx+MjRIJzBXRZNz272lqHwUTeohmtRH/euhgwhaXrEFNuhkV2C9LkaY+0xj6uX0
X-Gm-Message-State: AOJu0YxFdJvkcIrgAmE73cfC23CabPAjWxa5m/E752gXOnCRXZmQlafL
	5Yt3C/LFeQktuhGZCCLdqHbRMeOJRGw8sXVCL2u6MiV5KwkgYuvZLdZX7D3IN6A=
X-Google-Smtp-Source: AGHT+IGj3bA+oXPOoBvMCn6FAi2vMePmynyM2+Wxv1k8TreF0ZOFdKJAdWV4ii1y8EtkVeqRq9O4sQ==
X-Received: by 2002:a05:6214:5d11:b0:6b0:7270:104d with SMTP id 6a1803df08f44-6b19fb9fc09mr13439486d6.29.1718199682399;
        Wed, 12 Jun 2024 06:41:22 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b091d55c30sm11975046d6.87.2024.06.12.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:41:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOE4-008y6B-6Z;
	Wed, 12 Jun 2024 10:41:20 -0300
Date: Wed, 12 Jun 2024 10:41:20 -0300
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
Subject: Re: [PATCH v6 04/10] iommu: Extend domain attach group with handle
 support
Message-ID: <20240612134120.GX791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527040517.38561-5-baolu.lu@linux.intel.com>

On Mon, May 27, 2024 at 12:05:11PM +0800, Lu Baolu wrote:
> Unlike the SVA case where each PASID of a device has an SVA domain
> attached to it, the I/O page faults are handled by the fault handler
> of the SVA domain. The I/O page faults for a user page table might
> be handled by the domain attached to RID or the domain attached to
> the PASID, depending on whether the PASID table is managed by user
> space or kernel. As a result, there is a need for the domain attach
> group interfaces to have attach handle support. The attach handle
> will be forwarded to the fault handler of the user domain.
> 
> Add some variants of the domain attaching group interfaces so that they
> could support the attach handle and export them for use in IOMMUFD.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu-priv.h |  8 +++
>  drivers/iommu/iommu.c      | 99 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)

I don't have an objection to it like this, but I wonder if we could be
smaller to teach iommu_attach_device_pasid to use IOMMU_NO_PASID to
attach the handle to the rid?

It would have an if there to call the  __iommu_attach_group() instead
of the pasid attach ?

Jason

