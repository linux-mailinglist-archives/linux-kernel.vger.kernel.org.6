Return-Path: <linux-kernel+bounces-255945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0030B9346EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6E8280DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1FF3A267;
	Thu, 18 Jul 2024 03:49:16 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67729422
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274556; cv=none; b=qw9hBLiYFWFtpn0xQEkj8Ue6ZaupR23ErgA/CtUkdF9bWONK+1pFUSLC4Zk0bpGrkXkGJR+IZkjfeDt1Wy1kcfweTDt1Q620cQXPKYAPBELcSukePuWo077U++ojdepKQqZhmVNFgo8Ub5AIrw8HS8yP+6X/bcA4RvpdXRUWDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274556; c=relaxed/simple;
	bh=ckbfWJjz+54NYPngTBO5HEX2BPlYpiYBXK60K41e/z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEisUsboQYvzn0JGB54sGMMAQVVkwgp0vFWl2MCJHt3w4EkMBHYhj3GYCB6L8xVkwUTZcOyZWjbi7PE6j/r0HFoqPfaoOH/D2Wz/AMZ2ksdHffLeRJuIHVe8r7DMhRItfaBAivELXQF5HIZeR6c3Z2A/vP2GMyPr74+JNejVtlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EAC368AA6; Thu, 18 Jul 2024 05:49:10 +0200 (CEST)
Date: Thu, 18 Jul 2024 05:49:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/2] dma: call unconditionally to unmap_page and
 unmap_sg callbacks
Message-ID: <20240718034910.GB31912@lst.de>
References: <cover.1721219730.git.leon@kernel.org> <f9f0e270c077c5a3225f114bf9f7df18a6f9693a.1721219730.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f0e270c077c5a3225f114bf9f7df18a6f9693a.1721219730.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 17, 2024 at 03:37:10PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Almost all users of ->map_page()/map_sg() callbacks implement
> ->unmap_page()/unmap_sg() callbacks too. One user which doesn't do it,
> is dummy DMA ops interface, and the use of this interface is to fail
> the operation and in such case, there won't be any call to
> ->unmap_page()/unmap_sg().
> 
> This patch removes the existence checks of ->unmap_page()/unmap_sg()
> and calls to it directly to create symmetrical interface to
> ->map_page()/map_sg().

I don't think you even need this any more, do you?


