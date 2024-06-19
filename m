Return-Path: <linux-kernel+bounces-221210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5690F06A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88856B21EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5741CF8D;
	Wed, 19 Jun 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BW1IdlNi"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FE1CD2D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807266; cv=none; b=SCAn1B5Mm8FmASKdSGZRKwD2CgQ6/JXqt8lZVnnDVahT7vyPQ/qECmKxzcp/Zl7IrhkB5b82aA4hYBeTdzPpf1MM6MuwizjG1tjjyq75lfDYFHie0i3yw6SGQbP7wEacuVJvAsaDUZeGph7SDl/tbMYcFJSx5oVeo/c6KlWx1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807266; c=relaxed/simple;
	bh=ARGivhwyahyrBFKF7xVHfpn6+bz5Ma82X1RKuPLYRfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUJm4PVlApdPu8rphaQRP3eABKvte6pmQPmaHVl3X9IbCJkteNP2pnE7Wwpe/TUtmr4K8WnaKHh2wA7Eot0QsUjWStIdLpScA5jegtU7yIfMiiK0cG/MteQNKJaNImtEzY0pTOLQQrGvtj9si7u/vsSubptQj66y9SWWenWjMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BW1IdlNi; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7954f8b818fso431299085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807262; x=1719412062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIX8MgTBAh7QnNhNTPIeyUxRJPYUCCcH54QxTjKMhwQ=;
        b=BW1IdlNiPmn0EcJHn2ZetSEMe/bCEhA3kiw0Nbt0ruqJBuDNU9rFfBFVhdjEYeSZ5+
         ARtwG4klC5FFzZKkc41Wga4tTBpaIAWolhlmMdyBVSTiKCPIS3nVMCy9JTK8VYA4WaV8
         Dn30XVr8pUSnYxfVRMCIeYU+Q5VhqHSZyGVx4adPC3FmzDseCo8vYvrgefBrfGs5d/bh
         AFRdGjefP63Yt8vlY61gcpwMPP8pKAWHxlIW+Ax74vgtASMWTZwbYJJPCTA1B1+zVr/O
         i4iTwc7V8i8D5L2+9cxNUGZ/+NeQnotmCB53oSWgk+KDHVGUHkmfbkFtSWMybWAUP8Si
         yHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807262; x=1719412062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIX8MgTBAh7QnNhNTPIeyUxRJPYUCCcH54QxTjKMhwQ=;
        b=Ir4XnBXzztcKDNw9V6AgYm3aKHlXdtjwVHJ89qj6GD3n2/ccFW9OnmWwOsgy6uFAQE
         0oGKx3PjGyT+80kQHVsFnzNZY5D+shbfPtQ1km2EUCcqNSiIVc4tlMCAWGn7XsBdkAXr
         mEj6ptXCKidWSIvQZrR3s5o1hxsIevKBi1P8oDp112dHZI9CPM7bB0Qgg6OBm1lyzLCI
         zQRIAjpuQ1qD1tChPJgxa9Ny1YMQzXYXgDhwsfN6sPn+JbPHWnacf8m2O46VcMSmw+rX
         2XtrM4ANdvwbw2HR7Yu6OWokJuV9p2z0/f0v9hcNZVlOlEVNXiHSpysCBXSdMn4sYV/L
         6QOA==
X-Forwarded-Encrypted: i=1; AJvYcCXjnKi/MJaId4sZ5C2Eqp3mUr7JUisKq2MtsZGgMYt7RR1FJwrgHLmd4bM8NU13LfjcALDbuTm9iHcM4YywFIMLNkfqBOZGzXjb+PJc
X-Gm-Message-State: AOJu0Ywu7ZTlXd+5LnJqntzx4qAT1LLpVVuVkolFWL599m1aetJt3RkA
	IfUz63NTel45gN89N3IHWniNf2NuInc7PxpeSResodGx7DxtHlwe0EmuVax3HoI=
X-Google-Smtp-Source: AGHT+IEeEBRvNzwpSD8Fs1Imp5pVXlsQQfg/ZiA1zsRiN4FF/aYn4Gxlj7EWTGzB/0ufExiA5d7ZKQ==
X-Received: by 2002:a05:620a:4450:b0:795:507b:6dac with SMTP id af79cd13be357-79bb3ee2f81mr279621685a.75.1718807262304;
        Wed, 19 Jun 2024 07:27:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe279a8sm609903885a.106.2024.06.19.07.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:27:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwHk-004aSD-L0;
	Wed, 19 Jun 2024 11:27:40 -0300
Date: Wed, 19 Jun 2024 11:27:40 -0300
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
Subject: Re: [PATCH v3 04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
Message-ID: <20240619142740.GA1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-5-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:38PM +0800, Lu Baolu wrote:
> Replace iommu_domain_alloc() with iommu_paging_domain_alloc().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/vhost/vdpa.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

