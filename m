Return-Path: <linux-kernel+bounces-370946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D51A9A3412
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3063285054
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E09176AAF;
	Fri, 18 Oct 2024 05:14:16 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA815FA92
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228456; cv=none; b=Mz494SMZtRq9YzsGhBi3LdlNFkUFXCb2yPa3JQA1z3XGuRcrKKjXdeRIAL4y7hVIxSDAy6ZraH7nD13dorX2ELGyZdp2tp72zKQNwkamD1QG8iFEVi1pBONhuMQOJCfYomjnsaKmm3dxM+dzniJb5mKsDDMJ1eTS8ZqQ8doSIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228456; c=relaxed/simple;
	bh=P6M0wIg8EjdHtchMqIJ2RNdafqEjoOwuwX0BYWnbz88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozBdVhbWzpvKSS0QCXVEy03THapvk4cyBtmYzMWxS81lhoMO1eqWWE/0HRt+1mM8dwp0bLFTmHeB5TzOmpZBG8q67jH9zTSHiC9BU8UHy4KfuG9D0iTd8y19u949T1jEQxJ6FQ+DOTF2+Y2y9dCTtXRFfBR7wBC+PR7163eY65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5FF1227A8E; Fri, 18 Oct 2024 07:14:10 +0200 (CEST)
Date: Fri, 18 Oct 2024 07:14:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Prashant Malani <pmalani@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without
 requiring namespaces
Message-ID: <20241018051410.GE19831@lst.de>
References: <20241016213108.549000-1-abhishekbapat@google.com> <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 17, 2024 at 10:40:36AM -0600, Keith Busch wrote:
> On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
> > max_hw_sectors based on DMA optimized limitation") introduced a
> > limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
> > (MDTS = 5). This restricion was implemented to mitigate lockups
> > encountered in high-core count AMD servers.
> 
> There are other limits that can constrain transfer sizes below the
> device's MDTS. For example, the driver can only preallocate so much
> space for DMA and SGL descriptors, so 8MB is the current max transfer
> sizes the driver can support, and a device's MDTS can be much bigger
> than that.

Yes.  Plus the virt boundary for PRPs, and for non-PCIe tranfers
there's also plenty of other hardware limits due to e.g. the FC HBA
and the RDMA HCA limit.  There's also been some talk of a new PCIe
SGL variant with hard limits.

So I agree that exposting limits on I/O would be very useful, but it's
also kinda non-trivial.

> Anyway, yeah, I guess having a controller generic way to export this
> sounds like a good idea, but I wonder if the nvme driver is the right
> place to do it. The request_queue has all the limits you need to know
> about, but these are only exported if a gendisk is attached to it.
> Maybe we can create a queue subdirectory to the char dev too. 

If we want it controller wide to e.g. include the admin queue the
gendisk won't really help unfortunately.

