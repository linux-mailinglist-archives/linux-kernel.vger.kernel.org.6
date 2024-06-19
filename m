Return-Path: <linux-kernel+bounces-221253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EC890F0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7AA1F213F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C9A20DE8;
	Wed, 19 Jun 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hG8ZOFqY"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91B01DFFB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807884; cv=none; b=hOU0x8rXetBqQQn8MMvIC6XIvRoUrTmySB2edFD9bTHGMT7OM0iIdt+6rf56XNeuc123CHEKu7Ke2p47b3buTJ5ifHAO0zvEmswyR8n8sYadTw8NKmDmxJPu0uXhCzWFrziFqWaMmcOpUc/QnHwyFAliMWphbKu0+hJBueF42hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807884; c=relaxed/simple;
	bh=HgRd+PsG2Fckv+DtGDkxGSQtGswJ37qAbmLorPvU8rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH0ghab2J3KOZ4XCRYWXucGDVRGLNVderawSdepvAraH6x6wm622jG3Li3PYeusQtZKXmMbY2gz7JA+H3+59aSly0K6Ux4WX3iFJDqxhjhBy+dPfrYyKnYvseLm9qy71LeXcmSnjtwbMXHZl3qRSltnQFurZEXnAkJN2QWXA8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hG8ZOFqY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4405e343dd8so27439331cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807882; x=1719412682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6pJIKfjLvugpNiyWUPkn81xpwGb7zZV1Mhqp6qTkwpU=;
        b=hG8ZOFqYKsuD6uxQvkScqtq6JjKE6zeqlEHXHxrXP6FYCb5gni/cKPVzcaJavK/ThI
         6Y7PZxddNNSGMl2u6GUwBQZSyyp40G+A9LsWEJDRBBlrX05lmn+FYdiYXPk5oPXiLySX
         JunEr6sbxt6JQBIGAscHr+93uRJ0Nyme3un/4H5nv6nLR2vNs4zvx8L+v4QdyzXBk9zh
         pLCNUsQHGVC1VyHEHug3fhbC6PuCpUQF/c17jUiqZMYdS46KNDtpTxbCXJm7AOiqK8hD
         /gKCyZk6R1+AbjouwfLrjlSiTq/+oOT8vzg5IR51EM2FUU9tpUxmN+c8wJzHZOcpspiY
         ESNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807882; x=1719412682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pJIKfjLvugpNiyWUPkn81xpwGb7zZV1Mhqp6qTkwpU=;
        b=d71HjWJTnTOxGrKZ/1o6A4wnXXCYdpOkL67m7zYD+o0oCeOls66VNUeVMW0mhmEpe+
         bUmNBJjMJIgli886tZLPluKX9wo8naW3cpwUVU8G9AW1qWdMsp/9YXUJC1nGTvuGVrLM
         wpdducDfia7V6z+HhiJ2nzeCNsWKiEZq6rrwWqDYaJa5d82fxa9W5KwGtSElyf5TLSN/
         y0bQPY/J9IG2adetYSD4ffXDz3h9zBw2l370sU7ovOhWjzgEHNYTaSkxiQiAGoH3LmiO
         IkZORtrM0rVEx6mqD37sqHv+gKopizp4S7Us9tjK6odhuAOtIHlL987wDG1f6OqEERHk
         MGSg==
X-Forwarded-Encrypted: i=1; AJvYcCXu2nDMDWJcksJqGTjZdE9fTHOoegJgw0mPf68NPzIHvktANUFqko32Vnl3bazy0j1ZDygqkqYyP140RzAWP+UG9wrFVfML54YE6Aax
X-Gm-Message-State: AOJu0Yxe8r0p6EzWGEtjMpu/vLobxzF878SRLIexDtn5GhE6g7rhSRz9
	JK+tX0UxNBHVUx/uzBXt3rLyV0SQqKmC2AQRQUNeA/WoTRqmYWEug4XerwE+zAw=
X-Google-Smtp-Source: AGHT+IHTB/lZ0M/byP4dE3kOpURatwyTsEaDzd7ugkc+m0b4VPnnl9e+XLcLWm6PxgGLzUpaixUT/Q==
X-Received: by 2002:ac8:5896:0:b0:440:645a:a209 with SMTP id d75a77b69052e-444a7a49c90mr31210081cf.49.1718807881767;
        Wed, 19 Jun 2024 07:38:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef3d89c7sm65749961cf.20.2024.06.19.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:38:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwRk-004dPo-Se;
	Wed, 19 Jun 2024 11:38:00 -0300
Date: Wed, 19 Jun 2024 11:38:00 -0300
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
Subject: Re: [PATCH v3 11/21] wifi: ath11k: Use iommu_paging_domain_alloc()
Message-ID: <20240619143800.GF1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-12-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-12-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:45PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in ath11k_ahb_fw_resources_init() and is
> attached to ab_ahb->fw.dev in the same function.
> 
> Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

