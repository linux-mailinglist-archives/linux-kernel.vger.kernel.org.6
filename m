Return-Path: <linux-kernel+bounces-519950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D5A3A3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECE11885577
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFA26FA40;
	Tue, 18 Feb 2025 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3kEZTp0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0818C907
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898953; cv=none; b=WrTu2aaSs90V4Nevs75AdumqdOl9e7oT/Quo+vzgvaROKGQeNSkuxZBJIetmo+idKL9WqNs+IczyxYgIzL+3h5Nx1l4meqmaGlJCce9goFJtezf8TTG9WXXluoQRXymhEKP7+xi1RMQnbP5EPS/p8IfGSs+HuWi+n43RRUIzanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898953; c=relaxed/simple;
	bh=3eIlP34WlArqtRnTtHJu9+tJUSkFehNJh8dOsjgkprA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DROLA99JQMPUy4kYUh68Rzn4Kpxv3RxTx05EqvKSRybBfWyhDHA2mPmk7uEAXc1fOYNmsbhtSUgTDiaDi868s/Fd4ic/J5L6vL9qKNBrRqcnpBPHpWu8bgxjpbpp+3xjSvrsnCDwWfnyQR0ymmGOy1QROD3CafeJzy32aKbRL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3kEZTp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D962C4CEE4;
	Tue, 18 Feb 2025 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898952;
	bh=3eIlP34WlArqtRnTtHJu9+tJUSkFehNJh8dOsjgkprA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3kEZTp0Q0acAP9W4x+FC77xKmIL6vEnhmPYSEWhPZp5SLaP1w5j8tyK7bM8pH8h1
	 LxCsCB5Cb8lS8iy7OI/y0wJ+JW0Smuz9fEejIWv/EGqY6JVnElNra8s81f4PB8eMVf
	 ixqf+UvWEtTpGSLDfVVfiZSt69IACSOr3f6qsyFnbZG3KOjGHZJ9qya0YxK7gsac2s
	 DQxzGXE3tuJDKsRo1ayRGsKuWyqFKvMp1Pfl6yEEMZF5snhKOX44OWajed8Bd+yGyd
	 GdDZnCB40Wk7XH9QvL6mlTzW+/YYT2ixsi5QHsrYUPEF44GCCnl4rvGoTwUnzvJiAu
	 z7Di/Y0Jd9HPw==
Date: Tue, 18 Feb 2025 10:15:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z7TARX-tFY3mnuU7@kbusch-mbp>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>

On Tue, Feb 18, 2025 at 11:31:58AM -0500, John Meneghini wrote:
> On 2/18/25 10:06 AM, Keith Busch wrote:
> > On Thu, Feb 13, 2025 at 03:37:28PM -0500, John Meneghini wrote:
> > > Keith, Christoph and Sagi,
> > > 
> > > This patch has been fully tested and analyzed by Red Hat's QA group and no
> > > unexpected side effects or regressions have been found. Both NVMe/FC and NVMe/TCP
> > > have been tested. Our QE engineer has asked me to report this upstream.
> > 
> > What's the harm in leaving the parameter? *I* use it so I can test both
> > ways without needing to compile multiple kernels.
> 
> LOL.  We've been talking about this since 2017. The goal has always been to remove support for DMMP with NVMe.

I understand that disabling nvme native mp it is required for device
mapper, and I get you want to prevent the possibility of anyone using
dm-mp with nvme, but that isn't the only user that wants to see all
namespace paths.
 
> We want to remove this parameter because it is causing confusion with users and customers who keep trying to use
> DMMP with their multipath NVMe devices.
> 
> We want to remove this parameter because:
> 
> 1) the upstream kernel does not support multipath nvme devices without CONFIG_NVME_MULTIPATH enabled

What do you mean by "support"? I assume you mean no one upstream will
help you debug your problems if you've set yourself up that way, and
that's probably true. The kernel currently doesn't stop you from doing
this though, so it's supported in that sense. Some people are fine doing
this on their own, they're not seeking upstream help. Changing this
would break userspace because it makes the driver fail to create device
nodes that used to show up.

> 2) the upstream kernel does not support multipath nvme devices when core.nvme_multipath is set to N
> 3) Non-multipath nvme devies are supported just fine with core.nvme_multipath is set to Y
> 
> You don't need set core.nvme_multipath to N to test your devices both ways w/o recompiling the kernel.
> All of the code paths involved here are controlled by NVME_CTRL_CMIC_MULTI_CTRL and setting core.nvme_multipath
> to N doesn't do anything to help your single path NVMe devices. It doesn't remove multipath.c, reduce the code
> path length or do anything else to optimize your non-NVME_CTRL_CMIC_MULTI_CTRL devices.  All it does is provide
> an escape hatch to disable the incore multipath scheduler start creating multiple /dev/nvme%d/n%d entries so
> that DMMP can be used with multipath capable NVMe devices.
> 
> Personally, I'd like to remove CONFIG_NVME_MULTIPATH as well. It's just another source of confusion. Most users
> are running Linux with the the default settings for NVME_MULTIPATH. This is what Red Hat customers use and that's
> what's used upstream.  So what's the point?

There are devices that report CMIC and NMIC despite being single path,
perhaps as some vestigial sr-iov feature. That adds an unnecessary layer
for all IO to go through. Having the param makes it easy to test both
possible driver paths. In production though, I'd expect to just disable
the CONFIG option if that's the behavior someoone wants, so I think the
config option ought to stay.

