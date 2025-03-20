Return-Path: <linux-kernel+bounces-569158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6364AA69F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60C64258D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F99718DB24;
	Thu, 20 Mar 2025 05:31:56 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFD54F8C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448715; cv=none; b=KcKiMmMe1a+xLkhJlgQQlHIGY9+HhkRI7YOuar2Dk0hvkgIbgZjYtTclr0NPfuUipdBL3t2ABLDFc7ecTa5Y7VuPWkvGey8POmqjhfTF83o7/G+vt84yX2SCOtA7egUUOPwvAvLDsW2Sm2doU4kItp0A7F2eeajv2gbJUDEDWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448715; c=relaxed/simple;
	bh=WzRz+8E4lJ5mSY3nXf7WDj2T7Vxh/B5E9SaA0rJo96E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFyxdjgmo2Gi56OtCP2NIlb6xjbhvJ/YPcV+0vFsZShpSeDWRRkpguJjQTkfyiN48/AnIv+4+VENhYmnvDv0ZZpAFvVbREGh3sl5mt5HNm4/rjXyTCv2RE1EiLYdWeuzA19HXIfWM0BhbiIF9rodoqnOsloRtLaQWO8Tjrp1BB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E972B68AA6; Thu, 20 Mar 2025 06:31:47 +0100 (CET)
Date: Thu, 20 Mar 2025 06:31:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
	bingbu.cao@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	opensource.kernel@vivo.com, rppt@kernel.org, ryan.roberts@arm.com,
	urezki@gmail.com, ziy@nvidia.com, vivek.kasireddy@intel.com,
	Huan Yang <link@vivo.com>
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Message-ID: <20250320053147.GB12560@lst.de>
References: <20250317055304.GB26662@lst.de> <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com> <20250318064805.GA16121@lst.de> <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com> <20250318083330.GB18902@lst.de> <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com> <20250318084453.GB19274@lst.de> <64a43d16-606c-4255-8a8b-96d6e4e44729@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a43d16-606c-4255-8a8b-96d6e4e44729@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 19, 2025 at 05:09:06PM +0800, Gao Xiang wrote:
> The minimum map unit is page size instead of variable-size folio.
>
> For many cases, vmap (to combine many partial folios) is useful
> (instead of split all folios to order-0 folios in advance) but
> I agree page array may be inefficient.
>
> So I don't think another folio vmap() version is better overall
> anyway.

Then just reject the mappings for now.  vmap/vm_map_ram isn't really
intended for mapping totally arbitrary scattered memory anyway.
As mentioned before udmabuf also has a grave bug in the dma mapping
part, so just marking it broken would be another very sensible
option.


