Return-Path: <linux-kernel+bounces-418663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FFB9D6404
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE05161242
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAA01DF996;
	Fri, 22 Nov 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLBqbsxy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A81DF97F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299305; cv=none; b=At4nweO2MeX6m57Dx6jZbOC6SMH73WVtcCMiSHOq8GaB0Eqi0SXw8jH+gJKeOQ2LcmG7PxYWnFlkwgdbyRvmzta+3wRpRNbD0EGQ9gMGY7PubWvAwyp3CyIBRDgRy3sy8J1Aiqx461DF9K3GToDKiQS5bQ/QGacQCWk12meKZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299305; c=relaxed/simple;
	bh=K0CAlhnJ5SZfILytcXhLCNfvd1kiKa3mksTYctF5DE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRziDMqZrYPv0MY4TW7tO4oRLKKBW31/HpgAwTenaZu2PCMqi7ZFwro4JqYZmPPnXtJMYcKB2eoAP18edkWZCt1fVK6NcQBxbDkknwnaqB4HANGTHIqpQH+ZTTt4u/v4AcW+wjSH+Ydzmml7NssZ0cu6fgT9a746GDzX5yNFkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLBqbsxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC044C4CECE;
	Fri, 22 Nov 2024 18:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732299305;
	bh=K0CAlhnJ5SZfILytcXhLCNfvd1kiKa3mksTYctF5DE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLBqbsxyAsBozEY8O1PWN4ym/UHU8cK5JAxpV3v8Q4Hyap7GqsEViY36EVLCvDMwD
	 ah0/RZdPNMy86QYKRNQJOILfYwUEAF7CYJdiV8eOgPtqUcHITw2gerJ/5vOJARHu7G
	 rfF6K3RkqXomdfrvy++wrWkLIJCU8GTD4En2f0UGTYsJk08u7/S+kbwGIwL7PAjE2K
	 wrpxyIAOqkzIP+Fm2+5tRL7pvngd8RwNSGlzta2Uz/NQhnT51F0aL+ruxZLlk1i/Kj
	 rFrSNqsWJEO59tCX0+UE51tcGxY05tDND176fe2zBKiosYLDAsGX1jAD+He+aHv/Q0
	 51a1Tsc5abQQA==
Date: Fri, 22 Nov 2024 11:15:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Bryan Gurney <bgurney@redhat.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, axboe@kernel.dk, mpe@ellerman.id.au,
	naveen@kernel.org, maddy@linux.ibm.com, kernel@xen0n.name,
	bmarzins@redhat.com
Subject: Re: [PATCH 1/1] nvme: always enable multipath
Message-ID: <Z0DKJWjtrpuy8j_V@kbusch-mbp.dhcp.thefacebook.com>
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
 <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
 <a6902168-0a8e-43ff-afef-b100f75d266c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6902168-0a8e-43ff-afef-b100f75d266c@redhat.com>

On Fri, Nov 22, 2024 at 12:49:32PM -0500, John Meneghini wrote:
> On 11/22/24 10:39, Keith Busch wrote:
> > On Fri, Nov 22, 2024 at 01:09:25PM +0100, Christoph Hellwig wrote:
> So you're saying you want to keep CONFIG_NVME_MULTIPATH and simply remove
> the modparam nvme_core.multipath? (I know I said we were going to do that
> but that's before Bryan and I started testing his changes with blktests. I
> think we can fix that.)
> 
> The problem with this solution is: when you build a kernel with
> CONFIG_NVME_MULTIPATH=n you get exactly the same thing as
> CONFIG_NVME_MULTIPATH=y with nvme_core.multipath=n. You get a separate
> /dev/nvmeNN entry for every namespace/controller path, minus the multipath.c
> code.
> 
> So, I don't see the point. If you really want to stop supporting user space
> multi-path solutions like DMMP with nvme we need to stop creating multiple
> dev entries for multi-path controllers, no matter what.
> 
> Note that this multi-pathing stuff is a part of the confusion in UDEV, like
> I spoke about at ALPPS this year. One reason why the /dev/disk/by-path
> symlinks are so broken is because the kernel has at least three different
> ways to configure multi-pathing support for nvme devices.
> 
> We've been saying we're going to do this since since v5.18.
> 
> So how do we want to do this?
> 
> -
> -		if (!multipath) {
> -			dev_warn(ctrl->device,
> -				"Found shared namespace %d, but multipathing not supported.\n",
> -				info->nsid);
> -			dev_warn_once(ctrl->device,
> -				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
> -		}

If you want to change the driver to prevent exposing subsequent
namepsace path block devices when multipath is not enabled, that is
probably fine.

