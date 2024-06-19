Return-Path: <linux-kernel+bounces-221256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3736A90F0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD968B245C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2E41EB2F;
	Wed, 19 Jun 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NydbKapE"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87B1CAB1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807975; cv=none; b=nv/c76KwnJsjaRDVblyxHOl4tLyXQPdXpKZbPSy/xvHUbG0609jjutixniPhwtYRR+bdTFs+MfyeWbFAQhpEvQglLzH6MBQLjFWYEF5nlwCSx6LeqYClEZQ1u6Ry4b1oSn834Z+SJlUcMxvugv8E/Eh4VvRFqO5u4+zn1xJYf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807975; c=relaxed/simple;
	bh=R3guH+r22vxWZS45Xhn/5mcUPnpAYFt1nE1jSbf7vGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJlEjWPoZ1G0hZyqrd9qrIjRFRpPAF5DIvsofpw9W/4Iwn4dpWaT9a8GZWzVdsRQOBVpvlwDJ1FFWXWbdNe8AhRD7ADUJG/mUHcLt8ierLZftU2yRJNPZPO1mAEbfZrqSlai8lYpjJMePhkHIwvF3AMophM1Pj67h4MKrqM+yVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NydbKapE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44056295c8cso31680071cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807973; x=1719412773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cokph3+KYsFeNsm+0akdDgXIRf+sbN6W33vmdBN3BV8=;
        b=NydbKapEUNcvceJx8fdCnoVnbvfYMAEEGsQWdF9kl0K5NZ9gmlE7NmzYYCCCwZQarR
         PTTKGa0s2Tgb1fMVVCz2Yeyt6biQf9KqoSS/hI/NdgzzltfIC9B5bihinI0WS2qlerk5
         G3+AbAzoF3OHpLqwMdA5m27f0BhjuYWFebjxc3cEer17CrSAMjblF/uThOKZ4lxxXxoB
         ysuw4iWCgIGYoagdUssaLd6fc9hnlABiHfRsNhQxPEKqQ8tJHm6iS6pNlygK8ox45mPJ
         0tYTxoSm7Jk9pVJBhFo5zXit24DpG6OeXx24AhH6XwqXR48fPa4WMsf8BTS5y16q4VhL
         CPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807973; x=1719412773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cokph3+KYsFeNsm+0akdDgXIRf+sbN6W33vmdBN3BV8=;
        b=J/QW5nOsXpevh+zwaUFxeHOkH1iGbBoNiB+cbxKMtwEDzKH0RrIgym95DYIgyb3bL6
         Ef8pHe2tEDRn3iXOVTb5bpaAUR1UjmkcRl4szdU/cTeiqdNkwK4lm9tvSGXoxZM0jtlU
         45qafB6rVkOK9WG+Dyk0D2UIpwygbQYzBA51qjo7+ZJi/szGZXsOz5PW/iBYWt17grUc
         mnekpuPfwd2VXniYj/Q3tukfRWjR4lCRtYIAtAN1/c6FJ346syfFFmH7mN8Q91o45RYy
         qZFJeAjU/1S3pQ6oGniIpsj/vg69PfLQnXL3SQdX/47I6AYdDIJKOKXHi8vWYb6L1hn7
         Iyqw==
X-Forwarded-Encrypted: i=1; AJvYcCVdRLa4KTg4zTgxe01vthk0ugVjV3y/Sor2WHa63NRUkc/Nj9jaIl/nYvZt6Runq6b8VTBQpMZ66ZqKmoIBI5XaR893MO9s2Uxe6y3Z
X-Gm-Message-State: AOJu0YzNw1C3TwPMIS9/tOQ+R7Y46Fo95myqbQrXjLIM/OZ6mJmpY5TX
	IcXmadPz9tKutAjt6iLhdMEQv3OjVhcLin2fxdbNLrpmD0YspFRT1X1A7PKyWEM=
X-Google-Smtp-Source: AGHT+IG1XaOP45+fSUMkTGWH4nocXjjMBFeSWjsksr0Y1tefBQYZu2xLsBBhuOT4sOfHsJbLjtz4+A==
X-Received: by 2002:ac8:5ac4:0:b0:440:5b49:2d63 with SMTP id d75a77b69052e-444a7a76f5amr34714511cf.66.1718807973466;
        Wed, 19 Jun 2024 07:39:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2ffb37bsm65405151cf.90.2024.06.19.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:39:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwTE-004dqv-Em;
	Wed, 19 Jun 2024 11:39:32 -0300
Date: Wed, 19 Jun 2024 11:39:32 -0300
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
Subject: Re: [PATCH v3 13/21] soc/fsl/qbman: Use iommu_paging_domain_alloc()
Message-ID: <20240619143932.GH1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-14-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-14-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:47PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in portal_set_cpu() and is attached to
> pcfg->dev in the same function.
> 
> Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/soc/fsl/qbman/qman_portal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

