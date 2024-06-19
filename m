Return-Path: <linux-kernel+bounces-221225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E4890F0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A7E2863A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A76D2374E;
	Wed, 19 Jun 2024 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ld40j8Bm"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A511DA23
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807527; cv=none; b=uBi8Tg2aWqamtehmW/l2RmTVEgMpYnP6n2DG9tBczEVGeVRl1+pxug1h2gEx0lUF9B0dvAVWT5nDCl8AlZ9mwpMrRxPSDwSXjXOsyMmxoihE8gXShoS6HbRy7a1ZRIGOvmmpcKb17OEoQigJRuFk+n9bvgQlq7vTVCOUf5GdFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807527; c=relaxed/simple;
	bh=Nk3viGawuArziw5+sHP0ZhUL9Lqm72T1o8iA8Vi8L2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9+qCy0h1cCRe5Fy1z/Rbb0FyoPVqZ0q9Zv7L+MAZg6/PloBnI8SJkyj2ZXiPerlgaYaGfUzEocJDnO6s45yGGvWRAWkQMUBrrxaFldoGG68C5k2HltesVRTgZNPz6BHRddxZSxRWuRjgHZXiXn1mVt2QJDvV0DwAmmxN3EGVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ld40j8Bm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7955f3d4516so75535385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807525; x=1719412325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LZUM5jfj4JrQADb+518kXqO9JR2q1Dki1G0Ben/yk4=;
        b=Ld40j8BmC8sLo8Foz0CDEpcjpoLSvEYdeD5OMbFd7slVy57Xp8hYBuhOG8rTxtDMie
         xFBTslTcTqvbR6NtnbTPLvk06SBnXw8T5R8HJzAZtyuQcKe5zRUdZX5HXRl9VZKVBGPV
         XlK8P3EdcPu1WHlJ78w3p4Zr1jkWhm6nl80X+3DtpX8ZImcyxoQrx4JDNsGe0tWC29QS
         DjxhtkB4gdQZDVIMNU9kyJJxdQ3ztj/0a1Rzn0LvpHguilE04LMo5DxJ4gzWB4IU9zDH
         zFEx1xlDcbEItJP6CGN0wzsFOkdsrLUUD1UHGGwBJi2qSD2OEw6ueXE/dLr3Z/Sy5Zxz
         0ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807525; x=1719412325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LZUM5jfj4JrQADb+518kXqO9JR2q1Dki1G0Ben/yk4=;
        b=gcFOXxUg4KeCM2UrsHG1P+wBZxHjWstEmA6X6o5W/ycM4VYnbsfZq2p6g5ZvSblnMX
         u+0QH2Vrxd/GCIrcw22+U4Ur0rAO3E/likWNv4xXUIdPl3rhukJXMPIrgZoHYUGafFIi
         ynGFWGVaziifrdOUk4yhcW9oW+KwrA3w2I9mkt8ygsUfL3l8jjKWV8JDK+jnFvIRT0y2
         F11R04lc8wIRGzTTMqXNNrvUbga47vAGwu0JgS2zN9/zu0RPatcUplwz+5dHnifSM2tD
         hRY5cqDC4yAaQ729pWDLYG/8ftGBuNDuqJiRtXvXL7+7zHVGRE4j8Ec6f22LfIdrdX+f
         I3Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWPaiUDfLdid4HJYB2ACA4tOwl1AU/EYA9RKys5DSojMjgbXTY/xDzqeZ2qJpLZJkM7TqMhWdns7TAEUfkGcVY+KOnXnTfU6hDRkxCY
X-Gm-Message-State: AOJu0YxFcdP+ss8G+TpztCV4NzVjpy2i1CUDHeTLlYNgmNu6vHqGO6Bc
	mBcwV/WrpWRnTp/Fpp5Mo794YeCyeuYt6xmyeSLWmwoLz+xCPVhFYrj9mG+lAZo=
X-Google-Smtp-Source: AGHT+IGuQBogl5nnCa0xO+oPgBraH+EqrP6Ubhg3FSeuAcnXv1sZiKKYgQ7jm2DbFVYX9xP9hURczQ==
X-Received: by 2002:ad4:5f8b:0:b0:6b0:72ac:b306 with SMTP id 6a1803df08f44-6b2e22d60bdmr86925786d6.1.1718807525299;
        Wed, 19 Jun 2024 07:32:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb498bsm77913746d6.76.2024.06.19.07.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:32:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwM0-004bip-ET;
	Wed, 19 Jun 2024 11:32:04 -0300
Date: Wed, 19 Jun 2024 11:32:04 -0300
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
Subject: Re: [PATCH v3 09/21] media: venus: firmware: Use
 iommu_paging_domain_alloc()
Message-ID: <20240619143204.GD1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-10-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-10-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:43PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in venus_firmware_init() and is attached to
> core->fw.dev in the same function. Use iommu_paging_domain_alloc() to
> make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/media/platform/qcom/venus/firmware.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

