Return-Path: <linux-kernel+bounces-376435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5E29AB180
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB901C22231
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04781A255D;
	Tue, 22 Oct 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNcJQEts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCDC1A00D6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608830; cv=none; b=lftS4pSrz99wkRCgOhHwstbMgHFyq/2AjK/xtwAz9D+viBL09JNIONK8gktDZG0P00oagrFwAAzALF470ERxe7fbkLJggGzVi+uUoBUihHXgkRqnRzeV8Dtb4hp/HpbL1bquH3tHa9p1fqWsXDEyAQvIRTlXe7i31nY29MNkK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608830; c=relaxed/simple;
	bh=/fr7UordcSe/gxJRYh0FMvmJu2u/efKDwI+Z2bK9ygk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZMUbAjhOwPJAMvCpgzHPeHSYe9MntlIQtA/Mp0nuG7RSrnKk+jc/xWOvLfRHa0I6V0+2wpHZ+ECyOrU0EjKNFbVzkjEpKUtsTlocYO+lMmB6dqZU7kDoD40ExRCcZFyzodlS2Nv2m02yBJn5qkLn/3GVAKTw/Ji4RdDNEUJ5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNcJQEts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42110C4CEC3;
	Tue, 22 Oct 2024 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729608829;
	bh=/fr7UordcSe/gxJRYh0FMvmJu2u/efKDwI+Z2bK9ygk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNcJQEtsSNhY0sp0U44sxaQuFSqfIpPObekJALMS5CqzQ20sDFsqFGlaXflUR8U79
	 Rgmho8X+kddIdi13fgIA5PVWoMYiO2VR+qgITj7KjORpGLYF5rv+V/zTjZjHVo6yQF
	 /4tTxF3xiXH50YW9KRUyej2iK2O/IKwDVkty7rfOkWW/twbAyvB+ERDgfVCUg7sKyT
	 DxnwG/R2izP++D5OCIwooNtUn5uP/cT/hm6qe5DQ3E95fu16Bxthrjl4y3F2sGwmj9
	 QqEtKuYRKg85Cru2ofYbHBWi1OlieMNvS+jQsEreSwTeQc8/chZe1NUPZpAoj8fnLY
	 8tTVe4EQdppjw==
Date: Tue, 22 Oct 2024 08:53:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Abhishek Bapat <abhishekbapat@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Prashant Malani <pmalani@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
Message-ID: <Zxe8e2zS5dA61Jou@kbusch-mbp>
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>

On Thu, Oct 17, 2024 at 02:32:18PM -0700, Abhishek Bapat wrote:
> On Thu, Oct 17, 2024 at 9:40 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
> > > max_hw_sectors based on DMA optimized limitation") introduced a
> > > limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
> > > (MDTS = 5). This restricion was implemented to mitigate lockups
> > > encountered in high-core count AMD servers.
> >
> > There are other limits that can constrain transfer sizes below the
> > device's MDTS. For example, the driver can only preallocate so much
> > space for DMA and SGL descriptors, so 8MB is the current max transfer
> > sizes the driver can support, and a device's MDTS can be much bigger
> > than that.
> >
> > Anyway, yeah, I guess having a controller generic way to export this
> > sounds like a good idea, but I wonder if the nvme driver is the right
> > place to do it. The request_queue has all the limits you need to know
> > about, but these are only exported if a gendisk is attached to it.
> > Maybe we can create a queue subdirectory to the char dev too.
> 
> Are you suggesting that all the files from the queue subdirectory should
> be included in the char dev (/sys/class/nvme/nvmeX/queue/)? Or that
> just the max_hw_sectors_kb value should be shared within the queue
> subdirectory? And if not the nvme driver, where else can this be done
> from?

You'd may want to know max_sectors_kb, dma_alignment, nr_requests,
virt_boundary_mask. Maybe some others.

The request_queue is owned by the block layer, so that seems like an
okay place to export it, but attached to some other device's sysfs
directory instead of a gendisk.

I'm just suggesting this because it doesn't sound like this is an nvme
specific problem.

