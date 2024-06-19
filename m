Return-Path: <linux-kernel+bounces-221250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C32B90F0DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AC71C24334
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBBF4D9E7;
	Wed, 19 Jun 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g1Xu44Qp"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FBE405FB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807868; cv=none; b=LWuZ48gYruuSQOjRCvH2X14mI3vvttTwXGqqaUfjXGSrNvgou6Wj7mwlXbZSFLJNhU/gUFl5DwA1e9BXs3IBQ/k7A7eTpJT2xR4pMjCXs5kOHiTMnb2EuIwbjqzBAfU277HMwrOsv1JHO9rWtRA+DvNtiwDrzryM5EjeAo00oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807868; c=relaxed/simple;
	bh=ZTmS+6pciRWg87tmgTzyQHASaF/mUEBOIG23LnnAXHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGy3+Yqf7KyWj641zwEeQBCuwslFAXwQljoi2xloHIltxckDNuHMLA29s7lKxf6I8qE8dVOhEJ7Z6hzitsZc1i1gi8mU/whGjmXvcrp/iRI+g9SQhUX69QBwf9e/bfITmiV5eycSNxxtJZ/8D+uOQgKYHJBWCkNhUpHCbRwrgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g1Xu44Qp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4434fd275aaso19142991cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807865; x=1719412665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxs6Ot1v7OOmYh1fi+h7d0RjfC3rXsdWHEMpoOwqcEg=;
        b=g1Xu44QpVupz12xG2hD5md7oC3bW8zsEbwl2ySIF/48EEmPNTTxPCJU7zdW5FRjR2l
         zau8rWA61IwosB0WYYiqDsA3AWemb+BSmZ82WFBKpDJDQ58TLo40RSUJ1BM1Ikrw8/UI
         J18hlrxXqxL1VwFSZPkfGX/akIwMX1a+J0N935eh+tTDg/ElCxa4mNKjNlynbl0vkDSP
         JcChMcCjqy5cmB1x1fwjARsUfAXu09wda5mv4eoJTB2tRNw3WzKNP2TLzJyMXgMYLWR6
         kH8l6HZKIrRhBLdH7R3PST7PETsOem72J0JE5b2YNKHAOVq3w0W/Kh7Qj5rY3UsAkgl0
         NEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807865; x=1719412665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxs6Ot1v7OOmYh1fi+h7d0RjfC3rXsdWHEMpoOwqcEg=;
        b=JT4fCYRlEVHQ21K5pM5DGfWgc23iOiFjv+78T8dNdlaoRFryTf0cjgxdZN2NYGJ2cm
         t/VwWZ23C5SSpzQsbuBGgnKFyMFrkDdxowpc7htHPg1pH+KMCnpz6m5uR6ZZ/9he2ENy
         rPd6CYoeosv0F87nL0qlcbiIC71kJNDncn5yET5EYnjJv2pX92fLY4qo2WN2R4mI96Qz
         jB3LZRhwgatftrZ314Vj05yB+3wHvfxy1U0fj1rTBWbqDWY/aP5QYt/vIWPibi82P2Ss
         Co6l8ARKiW7avoZKAOf2t1oxwY41n8aWV8olrlQrUp4+4uypQQ2dwB/UTVeFMjpkUfDM
         pYVg==
X-Forwarded-Encrypted: i=1; AJvYcCWpOmv5J3CI7EYok11NRdKekh+V5CCrFJE/6WFt9klXNRohAB97l1QYvESc3hkxzZKFV/Xwfpe3yRMBdNArSGLrvs7ZKOEBAG1WIkKF
X-Gm-Message-State: AOJu0Yxcd3a29zt6tIty/wG4nqLJmUJ4pmVLidXS5yo2zRtcuEr27Q41
	B8PHJlaiNHWoxpDP18lDlrbp3bgwl1FKOQUdKuP4pm+MWqN5gCmpQymF1WcBZcg=
X-Google-Smtp-Source: AGHT+IE1Mf08qWZZKoMXC3XLTPx+dWna8s01o0jSerjkNHzkfpY1WyFHeXhpxUdgnTBTf9fhG5DGtQ==
X-Received: by 2002:a05:622a:1985:b0:441:57b3:2d76 with SMTP id d75a77b69052e-444a79c1e37mr30313091cf.23.1718807864728;
        Wed, 19 Jun 2024 07:37:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fcc297sm65510081cf.63.2024.06.19.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:37:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwRT-004dJu-Li;
	Wed, 19 Jun 2024 11:37:43 -0300
Date: Wed, 19 Jun 2024 11:37:43 -0300
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
Subject: Re: [PATCH v3 00/21] iommu: Refactoring domain allocation interface
Message-ID: <20240619143743.GJ791043@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:34PM +0800, Lu Baolu wrote:
> Lu Baolu (20):
>   iommu: Add iommu_paging_domain_alloc() interface
>   iommufd: Use iommu_paging_domain_alloc()
>   vfio/type1: Use iommu_paging_domain_alloc()
>   drm/msm: Use iommu_paging_domain_alloc()
>   wifi: ath10k: Use iommu_paging_domain_alloc()
>   wifi: ath11k: Use iommu_paging_domain_alloc()
>   RDMA/usnic: Use iommu_paging_domain_alloc()

Joerg, can you pick at least the above patches for this cycle?
Hopefully more will get tags and can go as well.

If you want to try for more tags on the rest I suggest Lu can send
patches to the subsystem trees and hope the maintainers merge them. At
v6.11-rc5 we declare the remainder unmaintained and you take anything
that hasn't been merged so we can finish the iommu core work.

Thanks,
Jason

