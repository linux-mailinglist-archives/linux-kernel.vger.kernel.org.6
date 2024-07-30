Return-Path: <linux-kernel+bounces-267966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A32941ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E251284B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781C5189913;
	Tue, 30 Jul 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dny4sCfx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AF1A76AD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360801; cv=none; b=EB+vJqJF9/MZ7GPaxBqut1eEK8tjqB2vsmVJwUA/xan/UfuIPp7QMRbgGgWHVmLkEy1Rxg2bdVHJOuhvkwMLFIDC/h0vp5cXaf/YkhUPi7pUxQfFbTSgdGoNdKE/wPSXUUSEnKsTWUqfhnV4Z8kioLv2rQ0ckEKonCSAIvisAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360801; c=relaxed/simple;
	bh=4KMuEZm5R4J/RzKmjWI6KHgNwuAYrDoI9sUkj0rxfew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCsOt3Mz9Ulk98BoYm69Sqwbe2VzcVFqWQZ90rp1e/ENyJiaoSAbi7NgLW+UuRxGn7DBqxhic9IQlTELBCqJhjPh+FH9SM+Dg+ksrE7lqOVXpX8pcVPZlpt+uFesjnJz3aRdmjxbrIDNHS+hBEB36CkQamU86c9l3ltkc7Lo6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dny4sCfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D5BC4AF0A;
	Tue, 30 Jul 2024 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722360801;
	bh=4KMuEZm5R4J/RzKmjWI6KHgNwuAYrDoI9sUkj0rxfew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dny4sCfxXZS+GgDPf7YE0V1Vhv4OT50CxYykBZt86KqVJjnB7cGUkybQkgsIQQoCn
	 b1DQk4BeYoKdUTugLfF3AQLJ+TmMKWdtYiAaHItqGjH3cBY3zFzhKiM1qmzLuxjZcY
	 z3tuHTlvVYXE1SBTWcfYjO48/gl/L3TOtzig1lkigx6xRdDFKwYrX3meqwCLe7mmeJ
	 8D+iK3W0xZDVv73FAtROahJSaQZsLVeOJP4NXtcPJyvwPW/6yYzu2/siFXLPAd4GKc
	 iB9OBxOnkwyKI84GY7TvkJxMuvkMMzr3bsvaUWeGIf8sprhjA0I13ttD0zJ4ePqJmE
	 e+jg4j2KvI+FA==
Date: Tue, 30 Jul 2024 11:33:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <Zqkj3hUnsjGgzBE4@kbusch-mbp>
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
 <ZqkeMJ5PPETMb5d3@kbusch-mbp>
 <20240730172111.GA32320@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730172111.GA32320@lst.de>

On Tue, Jul 30, 2024 at 07:21:11PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 30, 2024 at 11:09:04AM -0600, Keith Busch wrote:
> > > +	if (blk_rq_nr_phys_segments(req))
> > > +		nvme_unmap_data(dev, req);
> > 
> > This is already applied, but it is kind of strange. We get here only if
> > metadata mapping fails. Is there actually a command that has metadata
> > without data?
> 
> Well, passthrough can always set metadata to map without data even
> if there is no NVMe defined command that works that way, so we should
> handle the error.

That's what I initially thought too, but nvme passthrough maps metadata
only if there's also user data. It doesn't look like you can even build
a request to have metadata if it doesn't have user data: where does the
bio come from in that case?

And generic block stack maps it only for READ or WRITE commands, which
must have payloads too, so I didn't find a path to reach this condition.

Not a big deal, the patch is fine, but I was wondering if we need to
change something else to allow the conditions it proposes to fix.

