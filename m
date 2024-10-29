Return-Path: <linux-kernel+bounces-386571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0CE9B453D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BF5281882
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC66204031;
	Tue, 29 Oct 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="OvqM/nJd"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27884201013
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192707; cv=none; b=EdIAcHOAjYWyQqfm1h0QHLJ7UUJ0bSwoUSOMeZtiYC/xGnV6Jd5C0HxSd/0XCQ7w3WqzHBZ8fD6XmoOOJI+FE562JwuAwtFkP3Qe6EKB+WhbEOwKw2Ja4k+2Q7+Ffr2PB3hASP6RlFBw/z6M2vMMSPgqVTeQDfIeBS2RlsbLpzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192707; c=relaxed/simple;
	bh=eH17U5iBFIa1Xemd4TTLtZPVFnYTiOpDfOaOdchseTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoUqiwkfroXuYQ2TIF8RVg1uW7YTGuxNw1A3Q442Z4YAwYcWMFxelcXN1TPVxrTwqVcykl5zVcIKqiZ4Cixrn6qRGE0xCf5DtuJzUAN5oknsajMZYQnZ2t876VUH02GBjxSXlzDymmGju/1/XH3aCCx6MNXC11zRrZvWiZ6BfCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=OvqM/nJd; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E03332A8D55;
	Tue, 29 Oct 2024 10:05:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730192704;
	bh=eH17U5iBFIa1Xemd4TTLtZPVFnYTiOpDfOaOdchseTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvqM/nJdIN4RIHkOZXT/boGA06HOCSNDia/ch0HOAtXn8Y2f0qs+VNfZmWe1TBAab
	 oVrw8Y12u2hz6G2pRm2+fbfog0Xyyw8Bwh1Ur9Q/DHk39e7+PsWkkikajdeualC/LF
	 YlYJmry+Mo9xqehf0SQQHPrxP2pLRtY8hkWLE+4uv+7E1l5c4EuthLdJm1XKEp9hWT
	 W6QbRKp1BqMhVYAcd2/keR64P1dhZT19hc12bvTV3FDumLJx9we3i4sa3/CHwYSOl/
	 UBhUMYyLDlh9RW377Plzn5H6dB5ydJMjC6+NtmRqxOqNEAtW489rnJhMFqXoq7beS+
	 Ps1bL2l7NNtMg==
Date: Tue, 29 Oct 2024 10:05:02 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	Lyude Paul <lyude@redhat.com>, Beleswar Padhi <b-padhi@ti.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] iommu: Refactoring domain allocation interface
Message-ID: <ZyClPkzekxXKqTFV@8bytes.org>
References: <20241009041147.28391-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009041147.28391-1-baolu.lu@linux.intel.com>

On Wed, Oct 09, 2024 at 12:11:43PM +0800, Lu Baolu wrote:
> Lu Baolu (4):
>   remoteproc: Use iommu_paging_domain_alloc()
>   media: nvidia: tegra: Use iommu_paging_domain_alloc()
>   drm/nouveau/tegra: Use iommu_paging_domain_alloc()
>   iommu: Remove iommu_domain_alloc()
> 
>  include/linux/iommu.h                         |  6 ----
>  .../drm/nouveau/nvkm/engine/device/tegra.c    |  4 +--
>  drivers/iommu/iommu.c                         | 36 -------------------
>  .../media/platform/nvidia/tegra-vde/iommu.c   |  7 ++--
>  drivers/remoteproc/remoteproc_core.c          |  6 ++--
>  5 files changed, 9 insertions(+), 50 deletions(-)

Applied, thanks.

