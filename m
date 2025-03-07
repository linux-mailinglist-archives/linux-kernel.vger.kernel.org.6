Return-Path: <linux-kernel+bounces-550172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1E4A55C27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148A63AFFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D6D76035;
	Fri,  7 Mar 2025 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjMKw7Z9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335938385
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308409; cv=none; b=ggaZpwX7drdqsmzBIskLwb9b/6z+jCmtWxS/vEhRjvRcAzK69jNH1OqiD0ww7sP7WfO+rkbCSNpbHKHLigZYEun8eA3DxBQ7kj5yPaKFEr5cnnlIh4LyNDQgqcnIF66Qxp1rEsw2ljtcOjVeuZ3AnDBzZMeCOseI4giztIpxEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308409; c=relaxed/simple;
	bh=8pNhQWmAhUdyD5g7swxPHj4G3ZDU584ff49iiikDCS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVoHUnJBOwy7XeaDMZrB3nMTjprg+NdbPuZgtLaI1Ktyz8MKWmzNF+voOp57XuTSO+reMMnLiu4OI2QIDKsP3zKqjoseSxlQ2tnzH8tGJsMtgCxgsJPJ+/4Mrw1DK545S6OMqZTjTjbMC9Avv0kQSJnF/V1EnkhiBC24pGxHvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjMKw7Z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFD8C4CEE0;
	Fri,  7 Mar 2025 00:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741308409;
	bh=8pNhQWmAhUdyD5g7swxPHj4G3ZDU584ff49iiikDCS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjMKw7Z9r3X0zZFif14xXSNl+iQpRkd53GeL6jKpUG8smTb73GiABFRBLvmmHKDLD
	 h46BjJem0AXzyT5r4gVHP6EaMtU/7E9IXx2dV7xVFwJ1ZZbf6SbFZE9L1av4RdpSfn
	 tviWzhCdEpTOm5G5ldGaQX7riCoTHJ7sz1krTEZAK/EEGzqZstzUgft8OyyDkXY2OP
	 pbhwT8heupSxcWcUOOVxOv6blA60afT6EATUBnAzfbm/5+Z0b265/Jqy51LwrF5fkZ
	 Mq52c36vrNsZKS2txwmONqywHAAvCuiWGa6USHpPwH57uRlWbiMewD4fdd/r/qAoSF
	 LF3VHYyz2oLRQ==
Date: Thu, 6 Mar 2025 17:46:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8pB9jQALxMN6WaA@kbusch-mbp>
References: <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de>
 <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de>
 <Z8m4vzE36UHWjwep@kbusch-mbp>
 <20250306151654.GA22810@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306151654.GA22810@lst.de>

On Thu, Mar 06, 2025 at 04:16:54PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 06, 2025 at 08:01:19AM -0700, Keith Busch wrote:
> 
> > Or consider a true multiport PCIe where each port connects to a
> > different host. Each host sees a single port so they're not using
> > multipath capabilities, and the admin wants the MD behavior that removes
> > a disk on hot plug. Or even if one host sees both paths of a multiport
> > PCIe, they still might want that hot plug behavior. The module parameter
> > makes that possible, so some equivalent should be available before
> > removing it.
> 
> A module-wide parameter is absolutely the wrong way to configure it.
> You'd ad best want it per-controller or even per-namespace.  One
> tradeoff would be to disable the multipath code for private namespaces,
> although that would cause problems when rescanning changes the flag.

It's not really about private vs. shared namespaces, though. There
really is no programatic way for the driver to know what behavior the
admin needs out of their system without user input. If you don't want a
module parameter, then the driver will just have to default to
something, then the user will have to do something to change it later.
Not very pleasant compared to a simple one time boot parameter.

