Return-Path: <linux-kernel+bounces-418420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1B59D616E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292C0282345
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB2E13C80C;
	Fri, 22 Nov 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxHjoSCp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1CD5D477
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289994; cv=none; b=U98gfpfU3ToDd+VLOxIalKafejYXeBJjpqOgY++IsYHGQy7gCXt1LW7B2XgmnMdl20ebCQurtkoxQhSKxFMGTmp1MLQ6V6McF23dynJPvWkkV0dX9ix3GApzAXI1vwAkUXucM1N6kjyJ9cg4AZmNEqPDjms8k+XUGMnfPe4ZvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289994; c=relaxed/simple;
	bh=e2AdF9OTfkivQ6vfutepTSoVuE4EmbAUxopve11xF+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huqkCUucIh2s6BKYZ4pUxoipTM3YuqZH+MBQfDOl/4jzocO6HAWq2ctCa52pOzp6wCbiqYqsyEKhKjTnsfQg6LGSOv8lUQBbPGgjZGq1SUr3Y9+Ruy9xXgYFj7mEmV4omM7AWOwBqUJx/sKqC9TzdpS2l+g9DvlXtlvwA4RfqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxHjoSCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDD8C4CED0;
	Fri, 22 Nov 2024 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732289993;
	bh=e2AdF9OTfkivQ6vfutepTSoVuE4EmbAUxopve11xF+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxHjoSCp7QvBBh67fZIA3E+mM6vIexZ05u9R0Tp6Rr3cT6ULn5LCEEUGk/pH54qXr
	 l4AN7VLuFItHZSHeQ/IRj4r8a3ZxfNU3D0EvyRbkltEsWTb1NKk80uJ2kEPTCnJP6G
	 ljUKUMCdA9jqaERgxxcNGqNMxOY8JpUXy0W7SNk6GczJzeyP22SoLzAoxkywiMhLte
	 vpIIYfL3ovZHbmVzQKKppUtyTh5zKXV96Uny/7ZEVaRmTPAh3ruTKOvdwU/qx47kkw
	 oAaZpiMY8Px/85XqPfydiLzBOg9F42VsncEcwHERRmdQOrCwkdO1GeXi66nXhMpajN
	 A28qtjVxvNxqw==
Date: Fri, 22 Nov 2024 08:39:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
	mpe@ellerman.id.au, naveen@kernel.org, maddy@linux.ibm.com,
	kernel@xen0n.name, jmeneghi@redhat.com, bmarzins@redhat.com
Subject: Re: [PATCH 1/1] nvme: always enable multipath
Message-ID: <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122120925.GA25817@lst.de>

On Fri, Nov 22, 2024 at 01:09:25PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 21, 2024 at 05:03:21PM -0500, Bryan Gurney wrote:
> > Since device-mapper multipath will no longer be operating on NVMe
> > devices, there is no longer a need to set CONFIG_NVME_MULTIPATH=n.
> > 
> > Always enable NVMe multipath, remove CONFIG_NVME_MULTIPATH, and use
> > the code paths that would be used if CONFIG_NVME_MULTIPATH=y.
> 
> As mentioned last round not having to build the not tiny multipath
> code for embedded systems and other small builds that never require
> multipathing still seems like a sensible idea.

It's not just embedded either. I have plenty of single port datacenter
PCIe NVMe's that claim multi-controller capabilities. I think it's some
artifact of SRIOV that some versions of the firmware can bring.

Anyway, we only use the one physical function, so they're certainly not
multipath devices here. We disable the CONFIG option because while the
nvme multipath IO overhead is low, it's not zero.

