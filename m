Return-Path: <linux-kernel+bounces-221324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6B190F1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DE12869F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE6E14A615;
	Wed, 19 Jun 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TfqgfIEg"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A93FB8B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810061; cv=none; b=McR2ujO/Qh25/MSi/kC634IiMG9MVcJq7gG7S9wzhomXeMQ+QdM6E+ht9xUq9osoVHb4JYu/Soc7Usqi2x9A2qx19KXdKvDn8JgsgJw/t9A02RBB/9MgnCMYkWw77iYMv81jGV2PazhS6kSqXtim0tlw+wRn4uHtguxRnMr8UkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810061; c=relaxed/simple;
	bh=muFmkQLJvQ15Yt/BaKNlq7hz+YLGZlMYkp08ZhiNpUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usuLSaPEwiEif5CbLq7aQ/UsMNee9Qx1R2xAbOQxoixGz3p76qyXkpZx7/CkbDm9VWyvqC3W96c3U7maGpnQ7VY+gNHX8pJ0CUm8Uv3khUmhu9dwZsvLMkdvgIWT2aZaHWNjdUaFZVWlynpjCCSIfFzvNma8CEbE2rGrgd1LAIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TfqgfIEg; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b50018e054so6523026d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718810059; x=1719414859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq78ltb5crvWyLzXIfnPlOkoWYmn1e4oCmMdRELkiuo=;
        b=TfqgfIEgwc4c5k4qUxSf3a20g3XtF8iiSEDHJgPKq4+XCVJQ5vowSVu7qoFtCIdemv
         oI3HiK7ji7gsg8xvk+ExH/fk8DZMSuDvDnxtsUkJYUIm8mS3Qf4D4wikFRSJdjYqGsGS
         h/Ho8Cr79XnxUX9GwXzHd6/x88TyDb0ermcrXIdAByn8PSnnhy/Ra6OVf6RboDa9ZGs4
         7vo4Xt8bmhludLTB1saBYRWSvsb7h3DP99UIKoGBlvbIZGtZOjeQe7a3zBmnG9IGRpvC
         a2KFLp4X64aHgM7JIcE+dWMOJKwMyxt4Mi5EH0fzL8X3gQjyyq2iLCroRSIlKlE/qZ1b
         DhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810059; x=1719414859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq78ltb5crvWyLzXIfnPlOkoWYmn1e4oCmMdRELkiuo=;
        b=Xbom7KlFw5mHXCw3SiMKo5OIlrtJyEynaQ00lN1zzn0TUsUZjyPW4uNJxqna+52YTY
         55UtE+PrfEZpSpGleo7Lo1N5p8DLvhlhlV5iAvp9LQvEoTgLOTIsEU9/vWgjEyJYqOio
         WuBQIyyv5pBGIie+a5syLGfk/prwAHSnKedhTjWmauHPhihagf5bsZnqySGNddUkmx43
         qhc8msEoXYUyD3wxHu3zHEehonFklaRTFPDX5j+RziuzAvTdZ4e+0pl/wq6/XWT2KyTs
         NPL3mEeJ+fyJMWaqb9JvlX3rITmJAus4jb25+Hu7ub2ZVXV0pAP/qWAQlB2CA2re6z0W
         6Sgw==
X-Forwarded-Encrypted: i=1; AJvYcCW6XqENNFtKCD12kPbIbya4uKExok38cxraxW6fUF3BXKAFa/mwjBBX4FUhywjW9j5f0dc8zk/RGyAspwp/8i8rA8NLY7WUyVqZB/kS
X-Gm-Message-State: AOJu0YzvHBLcsub9vJwuU7KCrUXY2X5ePQF52sbVmRuAz9QzzU54RYCN
	4U8v9/ckyaCHgc1hq7PioA4XJ5+F0LUYbMiHFm5kjBBHLSRjCqdgvFPn3dGTVWc=
X-Google-Smtp-Source: AGHT+IEOeuPwNQG30sVHkXguHikBPl0Zz6A9LkZtMX2PCT+BlXopyE8xiWNkdljzVxC2GPEBoe42EQ==
X-Received: by 2002:ad4:4bb0:0:b0:6b4:ee84:905e with SMTP id 6a1803df08f44-6b501ea4245mr25964686d6.43.1718810058700;
        Wed, 19 Jun 2024 08:14:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c113b3sm78372256d6.34.2024.06.19.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:14:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJx0r-004ne0-3e;
	Wed, 19 Jun 2024 12:14:17 -0300
Date: Wed, 19 Jun 2024 12:14:17 -0300
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
Subject: Re: [PATCH v3 18/21] drm/rockchip: Use iommu_paging_domain_alloc()
Message-ID: <20240619151417.GK1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-19-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-19-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:52PM +0800, Lu Baolu wrote:
> Commit <421be3ee36a4> ("drm/rockchip: Refactor IOMMU initialisation") has
> refactored rockchip_drm_init_iommu() to pass a device that the domain is
> allocated for. Replace iommu_domain_alloc() with
> iommu_paging_domain_alloc() to retire the former.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

