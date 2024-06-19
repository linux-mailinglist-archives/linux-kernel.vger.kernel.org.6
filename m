Return-Path: <linux-kernel+bounces-221217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD89F90F086
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F471F21957
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D801D545;
	Wed, 19 Jun 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C+HSgPEd"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F3D26A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807419; cv=none; b=kALH0JAzB2i6xT4pEEIVTgm7b8WxsQkj4UPxpiJXHtU2DQRRGoeaVmkjL0FauYjOc1EW45R3pooe0OttQM/1fPzVFQ1mwboLOrgcsC9syouVfJzE+CJYQhcIQqhrhQaErruq/DvAq3Vo7UzM+AfTuHDNnTUrQin0pVIzgt9wdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807419; c=relaxed/simple;
	bh=TjKbxUpEnUKyFS7Yuulo+6m9UXLUpDXtWXUFSK0+KOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us+TLj7Pa3fjK84MbJ/AcGTXDgjyB5So8rrFO+YYMrAXHnqbKvy172sCG6nclJF6bkgNXykvRjm+7oVuhQJKc6ootH0CUmI2mJj7i/ncBoJqzDjNeLG5bX+VqI0PD+gGqwif2zGqHRJ8kFIbjUIYXB+L1N1/Ln4aos23tsczSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C+HSgPEd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-797f2d8b408so454760685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807417; x=1719412217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KkVwYQV/6jkEu0gAJvlVuepnjhHRXhEpVh+YOuYu3ZA=;
        b=C+HSgPEddK0X6uXWQWqoRZINXftIGapHIhrw3h+jwG7ZzauGEMRyntht2+mDN6zXjr
         jxuhgxScYDVYpM9J82ERI/prp/jJxbtXvXiyoVoh8i6rYZYvzJO4EFxbfo2YBWqCNUB5
         EoyByjqvQqkBtQVqrPdVMzUFEBY4oeLpDiHq0AyEvGCoEojqGshL5DW0FCUkpavNhDyE
         o83hMfIat2ZIVpMsRsf/p6WiQmAbby/xPRXx69s2vfThAArp3axpiVi6NM/8JIncWRrk
         0C/WT/JJBVhXfIh9252fmnMmPd2V3dmNRktr/q5w6uUfEsy3UtOOMp6FMEp3ruikGVqj
         70/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807417; x=1719412217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkVwYQV/6jkEu0gAJvlVuepnjhHRXhEpVh+YOuYu3ZA=;
        b=Vgq0EkzWPFEsp/cQ0hOoM95PUAhQyVaAALR2k2lnPQ6M8XXrIkd9FWyZ+yYLXZIksG
         nH62dld/kr7UvEzx0HUNeJWSgKES+ZErz7HwboTpMRCjnbQUIzNIgNXQHaHSsEO3kTR3
         1If2eLa22JMs6k5m1wVHBM+jYVVRlXk6p9GA6b+Na9xJlmS7ZQX6DAGZxYxK4qEueQBA
         +57AWAnWy0mnjyeMiIwevDcGoIf4H2uTYRMgexACvHuMDbaTmkZujLxvujoKh8EyTWgc
         TdLpi7ysumSr5VQK55hGTmQFRox8930nKKTgVP9STX0VxbfwCX04RTEqUvkZ5FQL1GGX
         9tig==
X-Forwarded-Encrypted: i=1; AJvYcCUF5ME4ajoWmoR4MZA7nc+hz01X9S1vllW6GiezlXV6i+W3SryfT5s0cEwIyoIr+wsUMsCf09n0K+eQkUhrvJ7IHKgfd5+97t+Xjg/E
X-Gm-Message-State: AOJu0YwykVSWdh39KE5TBmdIgSSExTWuEYLxAR6gsIIjQbXoQMovg9U9
	tZYJ5qAQsg8/HjTNvt7TmlA5LDSCwo6Xv+OeNH/IxoXURBIi4+uct75o5vBnP4U=
X-Google-Smtp-Source: AGHT+IEtPhZvg8s2LGCIdwsd0X9DzLfBviQVD0T9AfPrmuxMxUw2V/bv52uCre/jcfSESaPOk4IESg==
X-Received: by 2002:a05:620a:4721:b0:795:4fee:81aa with SMTP id af79cd13be357-79bb3e55a93mr284092385a.33.1718807416680;
        Wed, 19 Jun 2024 07:30:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bc1352ab4sm16883085a.70.2024.06.19.07.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:30:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwKF-004bBv-Kr;
	Wed, 19 Jun 2024 11:30:15 -0300
Date: Wed, 19 Jun 2024 11:30:15 -0300
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
Subject: Re: [PATCH v3 07/21] gpu: host1x: Use iommu_paging_domain_alloc()
Message-ID: <20240619143015.GB1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-8-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:41PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in host1x_iommu_attach() and is attached to
> host->dev. Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/host1x/dev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

