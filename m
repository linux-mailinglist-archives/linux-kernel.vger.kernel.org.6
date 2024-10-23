Return-Path: <linux-kernel+bounces-377357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3939ABDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935571C22903
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8752D1422B8;
	Wed, 23 Oct 2024 05:24:09 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBCD13D897
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661049; cv=none; b=brgQvuYc8ZS9fTkYCFeAOoZhuWQoD81RgvjqgBCQbghAHVq5c+nIcpojyKU39tz2qpj0L3BSARgIQlcb36q7x5ezqxX4YV0g8W9JJShWvbrxPbPqMCuXLaWba5unfevay65m0XW//Bx4Fq71BKBLc3PSsOMh7IPqAiXEcCBuf4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661049; c=relaxed/simple;
	bh=hLgqD44ucz8vy++YxuDO9T2KBLcQHnfjFkNRgJVkLYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNs+KFxO0sGjZHAGRnvZJcAe7+Dc92PpdZ7AO8BThBs5n/MXslTb6ey+btW3sNpXkjJVZW1jf2qTS+8e3dXGscEhwwJymIVGaQjLErbII4dteektfTh+toA97be8pg3KxGf5tgCGrsB31+6lD8PbjZPbLYOJ5XV0ekFVlwBNZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CFAC8227A87; Wed, 23 Oct 2024 07:24:03 +0200 (CEST)
Date: Wed, 23 Oct 2024 07:24:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Prashant Malani <pmalani@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without
 requiring namespaces
Message-ID: <20241023052403.GC1341@lst.de>
References: <20241016213108.549000-1-abhishekbapat@google.com> <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com> <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com> <Zxe8e2zS5dA61Jou@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxe8e2zS5dA61Jou@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 22, 2024 at 08:53:47AM -0600, Keith Busch wrote:
> You'd may want to know max_sectors_kb, dma_alignment, nr_requests,
> virt_boundary_mask. Maybe some others.
> 
> The request_queue is owned by the block layer, so that seems like an
> okay place to export it, but attached to some other device's sysfs
> directory instead of a gendisk.
> 
> I'm just suggesting this because it doesn't sound like this is an nvme
> specific problem.

Well, it's a problem specific to passthrough without a gendisk, which is
the NVMe admin queue and the /dev/sg device.  So it's common-ish :)


Note that for the programs using passthrough sysfs isn't actually a very
good interface, as finding the right directory is pain, as is opening,
reading and parsing one ASCIII file per limit.

One thing I've been wanting to do also for mkfs tools and similar is a
generic extensible ioctl to dump all the queue limits.  That's a lot
easier and faster for the tools and would work very well here.

Note that we could still be adding new limits at any point of time
(although I have a hard time thinking what limit we don't have yet),
so we still can't guarantee that non-trivial I/O will always work.

