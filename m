Return-Path: <linux-kernel+bounces-221222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C329290F094
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C991F236B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3A1D52B;
	Wed, 19 Jun 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q3EyKZqK"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787FA39AEC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807478; cv=none; b=UdYNv2pC9k/P5y/BGmPnbDKokLZa7xtNTBjQ7cqtV6rnyLn0tdtY82kEpeqP94EUDofPhBfsA5IlWBkq9ab1lq0vdMAOBuZdQ851t9eSuUUKwdDFw2y2xnWivm8hNM6jSyoi4pTaVkOnmiljqxqF5TWbE3o/8egUlTWj3uRTcos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807478; c=relaxed/simple;
	bh=770+EPGxwLYW0ig1HvdUIyfXv5v4k+2z74/pTuATEmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N20BVTMiVLl8nCX5zFPLXqecbuaezVQjuXPMTcHy0jbhVF0EYzJI0ZfGTAGqzhN6S4JvTcEwfw4/AyavcuzlD1OQQMhkBYplN6LSs1SBunh/fjWSdRXD3j0i0f07Dz1EE0iUGy3oXTaP2E+vmXCn64FLs8qDH/78xRo6y0qpeE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q3EyKZqK; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-24cbb884377so3730743fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807476; x=1719412276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BsT9hgFyZbBGkde271aluLYZILHDBPNQg1gpCGW3N38=;
        b=Q3EyKZqK/3h3s3d29ui+ztUfZ6pTG90lJMgvTEnzr45C3srlQGHFH37Ax3EFfq0kMF
         o0XLv6cb9RrzxDZ2F0poV1asyaaaby8Mg66nXxvZcMPfSH7Ll+iiqC8Yxc3PmzC5DWlP
         WZlxYLK9qlHOzS8E79mGlzo9h6ByGGWUx2zWJwBR2WpEBuu2W2kuVE1ZxYdaMC9yLfRA
         sjR7TaM2kBwunSka7xSQoilgQjggziEJ30yKxE9/aLE2Bok6Bo77RPIy9txpMuWEBCvE
         MRvVLBv/Aa4ZVPu5sLVs+XamnffdUu7amIPojnJNMV0RO2lR8WhB5kpvmq5AsNSrIk+n
         sMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807476; x=1719412276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsT9hgFyZbBGkde271aluLYZILHDBPNQg1gpCGW3N38=;
        b=thgEM/yU1WvB5siNMmV3rt7ocHHHmOvW6ImQWnAeeEEraOmyGd0Cf0jNRBuvYySZDB
         Y2r8N81JCRn5HfV6AmiJlwJymYdpdWOa6vRQ6vMiS+o3JF47Nb8hAgcgC79LpNsiyhld
         aGIlqsg8f7JQMc5xu1Vl8eZbV/f6tohD6bmC2zrehtVGBTQ6J4vB1MZvIJT2F+ydLE0W
         O+yQoByrq3kwp8VH7qLzKm5RTrHJnR7Iqr5IULOQkVtnuGu9jXWY94UK8csnwtE/w3+u
         oZAWaEyrZ4dxpDvPm/cwI+2s9FPgEYjFtbI1Sz5vF6BEIlo2AJDw/L3dlVKMzJtHS0Ud
         TEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/+mrqy5Q65ueCnib3aC8539pP4kb8hdIvBGVOk6/CB6CdJp9qjj6siQj1+Add/yRLMtGP3PSt0fMa87dpvHJM5J6bCUQTUGy5ALvV
X-Gm-Message-State: AOJu0YzGrCbLr/xn3TG4YhOr/Woj6WjF/bOhvHhyudxc62kogLYhVrmH
	y+wcowo3s8G3+96X5fgLwPeW3gZVTjiQuR0qEGX2WDSjXZfskku7A4iF7DR3cAo=
X-Google-Smtp-Source: AGHT+IHZayxzfwc1KZvF4t1SmwGVNV6P/gZQ5Mo6uiPN1/R0ej17zeeigaD/qQOHMYxQZ4opihlAhw==
X-Received: by 2002:a05:6871:592:b0:24f:ef6b:353e with SMTP id 586e51a60fabf-25c94d106f7mr3066372fac.36.1718807476505;
        Wed, 19 Jun 2024 07:31:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf23f6sm78142956d6.8.2024.06.19.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:31:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwLD-004bUT-Gm;
	Wed, 19 Jun 2024 11:31:15 -0300
Date: Wed, 19 Jun 2024 11:31:15 -0300
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
Subject: Re: [PATCH v3 08/21] media: nvidia: tegra: Use
 iommu_paging_domain_alloc()
Message-ID: <20240619143115.GC1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-9-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-9-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:42PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in tegra_vde_iommu_init() and is attached to
> vde->dev. Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/media/platform/nvidia/tegra-vde/iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

