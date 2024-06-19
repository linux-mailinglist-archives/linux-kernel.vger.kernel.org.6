Return-Path: <linux-kernel+bounces-221205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C99390F03E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040FC1C21534
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C20418633;
	Wed, 19 Jun 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F6ttT3/u"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F01CABA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806872; cv=none; b=bNprWyg0HnNWTG11lr2hMrAoG7f84TaLRSnUbVnV10+PyUYx5sPzShQs1mfyvBeC7X694nOfxB0eQYxYHcyPO/a11stQ53gUCG9SprR3lvZckpAg8BzxjXIenzPEZmKx8I/2YJ6fhMAj8sRA/ciXuc5jfeA8qipwP1spPMPDEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806872; c=relaxed/simple;
	bh=xPStD+LJiZiMxPNXI1L+xh95B7THSJin01heSvHDvvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmTryq83xyRcv+vsh6bnPuR8T/teLUv0AJz6Gyy4udEaPkY4kcGbQcxq7hXD8pBQ9T4fAY3gDRVmf6UQ+rNGoY2nnC6K33zT+rA0DkRJUiLuso/1tMVBGO/vIujZnuLalGm0Nx0NwEfMeN8AqCjH92davImVLKKXkglosx+G+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=F6ttT3/u; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4411fc45fbcso29159801cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718806869; x=1719411669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dnuarbriLv1gjZdB+/82zOEKoFtQbXR8yQCL4vTr0Qs=;
        b=F6ttT3/uB0Qax77/urmJ9MzGJpgN7PESMd9qB3Jn0afknFP5+Cd+oVc+3vNzm1/2xg
         hGo4JymxvL2QAekBong5uPHkuKzY35jL0w9KZ6f67UsUSWYnV9Fzev4pBVptJEL4dz++
         ye813B1O1oGnNLvj/Ny17eKB3JHZNIRqRd0ivCq9Cxpxqn+K5Hsv+hZeOrjVpixq6idW
         FgYUqet8+gG4lhm7Tjqg2fOsmi/vyNrOTZpd8oROOg4uYqKGYS20+SukJ2wfsoaoqtZx
         tGCAvoHkgR7OibmK+GdZHYPT3fQtc2eWH8QAWzT7sRdF08Rw+6SVWpsP7m0CHw0F7syh
         fZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806869; x=1719411669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnuarbriLv1gjZdB+/82zOEKoFtQbXR8yQCL4vTr0Qs=;
        b=j7UP/cSRvoXjsHnNh2SIXUDtM/hcBXBlzQLYMQSP2ml0jKr86iEsHggr8eCZIHKD9x
         CAYlFW76WS60lfoaVCIjYF5e8soHYstJUxOZn4sZJN5de4fvMd9YWCXO2sIPRn1bt6J4
         rPPKIB20Otho5j0AKoHwI77n0wMHsHgsetaB8/Ds8wAys97w0vUbX1Em+DX5h1JKLl2t
         gpbbXY10bugtVlNnVCK02GMk2VIMJipaZsC8ZTrdpsTr1NMi/k+R1Ybf4ZUb2lPqqFqx
         1rptbHcnYe+MWiUs+x1k486jYxWQEoRiMUvVocs3oIw0RHEzkcW2zFbhhOZ7EWCKImaL
         2Syg==
X-Forwarded-Encrypted: i=1; AJvYcCWOgODbrO7nWZX06rgyyP33gcP9sm6Ivim7NE/9VPKMLGEeIuXmh+Z0+2RjsooA3fuUmLR5jJLyKxdZl1looOBfdQHQC8UzvN1gC1fv
X-Gm-Message-State: AOJu0YxmH7L2sbYNxy8+DKpe4qNfQ0fGsPLgO1PPjbO9QhnnwmsxsMwn
	5p1OkRkxxXogBW4JhM6WEnaFcUKSFtlDWyfVWsRbYHsRzYVP948HVU6uE2LMqf4=
X-Google-Smtp-Source: AGHT+IFditz4+ndDJELnqBk6Tg5RVcppmA3k0NZASSXMhXG6oxi/4ZiVAiLFkBd54vQUHLyqIQAFrg==
X-Received: by 2002:a05:622a:11c1:b0:43a:ac99:4bb5 with SMTP id d75a77b69052e-444a7a4a90amr26916401cf.51.1718806869361;
        Wed, 19 Jun 2024 07:21:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444b1e112a7sm2007311cf.97.2024.06.19.07.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:21:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwBQ-004YYo-D3;
	Wed, 19 Jun 2024 11:21:08 -0300
Date: Wed, 19 Jun 2024 11:21:08 -0300
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
Subject: Re: [PATCH v3 02/21] iommufd: Use iommu_paging_domain_alloc()
Message-ID: <20240619142108.GH791043@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-3-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:36PM +0800, Lu Baolu wrote:
> If the iommu driver doesn't implement its domain_alloc_user callback,
> iommufd_hwpt_paging_alloc() rolls back to allocate an iommu paging domain.
> Replace iommu_domain_alloc() with iommu_user_domain_alloc() to pass the
> device pointer along the path.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

