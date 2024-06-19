Return-Path: <linux-kernel+bounces-221326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690F90F1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321DD1F21BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DEB14A615;
	Wed, 19 Jun 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ldHP/b8T"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008A143865
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810089; cv=none; b=OeiH1J0DtT0+X+rikW/gIJCFf+jMNrpsWFTanLPXUyBtIsyfBBV6RETyOD3VNnTthR4IJVWd8YVegACdK/izSWXLidmQrk5omz52I5UhHyXDRmiNYJjvB2cSdxFy0GanYseabXimDF5iNDDn74rCKD6Z4cxassMJLRC/EcjKDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810089; c=relaxed/simple;
	bh=6nQ24Ttf46Vn0Bnc0Pn3bfSXY+6J/UIhB3AFIysMkuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUnLHBpSZu2aJwjAkQ5VQ+u4zCe74KRkhZNUUSF+IouKczuYOTAgZspENE9COPtnvucFD01DYCugaZDcY1kWfgJqIs2zcJY92DdLzXV2nVnaEHNmp04fYoWTWAXyyu/hKVcSFKy2MqVAHBSSaeUTGQUHZQ06XfY167T2Dwhh7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ldHP/b8T; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b9a35a0901so2229077eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718810087; x=1719414887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOCumefnCWAh/IoBUZ2rq796M41BHPnroxPN1L782is=;
        b=ldHP/b8TGApOTP4IhYnAHiNc3qKKkLCCffVP95mATbPGQpgD16Tm4NPx8yvQ5oOG7g
         bl3lVYLGPM4hfJIkPC6L0+4kD9yeYuQc6OQExO5WvrcCIixHWxDA/0bg+redzNQ65KL4
         ds5iPdv78FaMZkuV5wWthF9WdnkK41xmb1ZUSAxhXvUoJd+M0OsruEXYlSr1pq1Sg/yv
         HGsxDBCx4ojKYBRy8E5cwHKOtFs5EsmcOeZHVUZvThqr3il6KvgjyTFQEcl0F4lYxmZu
         BIfoKgXpYBtZw5wLY+yPcpjxbNnlDfm6/xNDOtln022PuBhfWfhhJ0AeMTtuaLUYciim
         tdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810087; x=1719414887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOCumefnCWAh/IoBUZ2rq796M41BHPnroxPN1L782is=;
        b=EWk92t/WKU9siNIMmb7y1CTl70Y1iRsrtegFUGbrDzpA5a0nzNH51sK60qmSEfpOAQ
         usnXjIo+vjJBLHlYNYB9dMMFsspDehvvGvIIxl8gTMs20/yHprF6sFUuKY35WcPDtfgp
         7awIiLUWrFuqMRF2T1F9ZQE9FHkzMbNMSJIWbCILSTjfbkoVGvhndlShNxqnt5EG5PcX
         Pm5vBF92ZuXkCaYmCJKihHLrLoaurlflB4iP1u3nKEmR4qWAEEM0B72FSwAdlRoS+o2D
         mTBhH2TB7B81WLyNTYRiSsxRIG8FaBZd6DbWEutKM6jEaIYLHDQlkYZc+dEFkpo38zWR
         L3jA==
X-Forwarded-Encrypted: i=1; AJvYcCWppGUJPnUNv90ftroYYafEvcOjNcQPOniaAoltB208paH2+cpu7EFxbzYTFpNvGDrmCc5513MaNCO8bsDaUhv7oeIe4dEBXvS7acxj
X-Gm-Message-State: AOJu0Yx76BmzA8PAFw9ALpwd31LuQWAp1ve76EeH4S/jIESwl7UDSaOo
	QsrTmXN4ZpOgeehH+LegSyqC0ZsBuygn6CrKSSu2ShAe7mNTRK0eq6yzhOaQQyE=
X-Google-Smtp-Source: AGHT+IFVFHsVlQMiH0Fbhd4tc40tCEx10K+gMkRqXAjqGDO2L2x5wkknywHxXN6ff9bLZXfNrK0Jmg==
X-Received: by 2002:a05:6358:9886:b0:19f:1644:d45e with SMTP id e5c5f4694b2df-1a1fd470d73mr300419055d.8.1718810086999;
        Wed, 19 Jun 2024 08:14:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe47ce5sm614900285a.103.2024.06.19.08.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:14:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJx1I-004nmY-NX;
	Wed, 19 Jun 2024 12:14:44 -0300
Date: Wed, 19 Jun 2024 12:14:44 -0300
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
Subject: Re: [PATCH v3 21/21] iommu: Remove iommu_domain_alloc()
Message-ID: <20240619151444.GM1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-22-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-22-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:55PM +0800, Lu Baolu wrote:
> The iommu_domain_alloc() interface is no longer used in the tree anymore.
> Remove it to avoid dead code.
> 
> There is increasing demand for supporting multiple IOMMU drivers, and this
> is the last bus-based thing standing in the way of that.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  6 ------
>  drivers/iommu/iommu.c | 36 ------------------------------------
>  2 files changed, 42 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

