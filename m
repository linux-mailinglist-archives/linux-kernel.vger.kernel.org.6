Return-Path: <linux-kernel+bounces-365889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE5599ED84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BD51C220EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619741FC7DE;
	Tue, 15 Oct 2024 13:29:36 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDF1FC7D6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998976; cv=none; b=bZCZI/xqnqyscy3H/fp25uLi+l7qYrj1oDz4mx0EPSzBng5KEim9dQI9xdOt0hGidLXiMctkNzvFvF+BRlJvrt6dDPFATmb6mGBTzdp8gtWIZm4bTJ60oF8X3zEboyaZlaQPbhmo6FrER9tWOV0ELgqgsYLDVvN8n7ap53RNblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998976; c=relaxed/simple;
	bh=7EX4d5MFq3GySGQgWkMHbcmsHKrfVUgSLTVuPf/ljoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgVeefN2PnHSt9dlT5+SkkTlkDc2IW4YS2cZ7yisxNyLrGtVom1Bka6S2096HuvPDgPZ02ljaQrKQxDBnyZSIyluzyHFA6BqZfKjh88Tmn/7GfS/exqw6cu5IuVOjSOLsO80AAzoDD0pn4M3OHzDowiioemnqEagKLPDMxyUhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 19400227AB7; Tue, 15 Oct 2024 15:29:29 +0200 (CEST)
Date: Tue, 15 Oct 2024 15:29:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	kbusch@kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
Message-ID: <20241015132928.GA3961@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com> <20241004101014.3716006-2-tero.kristo@linux.intel.com> <20241007061926.GA800@lst.de> <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com> <20241009080052.GA16711@lst.de> <accb9ceb501197b71259d8d3996c461dcef1e7d6.camel@linux.intel.com> <0feb16b0bc3515b0a77f33a3e18568f62236b691.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0feb16b0bc3515b0a77f33a3e18568f62236b691.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 15, 2024 at 12:25:37PM +0300, Tero Kristo wrote:
> I've been giving this some thought offline, but can't really think of
> how this could be done in the generic layers; the code needs to figure
> out the interrupt that gets fired by the activity, to prevent the CPU
> that is going to handle that interrupt to go into deep idle,
> potentially ruining the latency and throughput of the request. The
> knowledge of this interrupt mapping only resides in the driver level,
> in this case NVMe.
> 
> One thing that could be done is to prevent the whole feature to be used
> on setups where the number of cpus per irq is above some threshold;
> lets say 4 as an example.

As a disclaimer I don't really understand the PM QOS framework, just
the NVMe driver and block layer.

With that my gut feeling is that all this latency management should
be driven by the blk_mq_hctx structure, the block layer equivalent
to a queue.  And instead of having a per-cpu array of QOS requests
per device, there should one per cpu in the actual mask of the
hctx, so that you only have to iterate this local shared data
structure.

Preferably there would be one single active check per hctx and
not one per cpu, e.g. when the block layer submits commands
it has to do one single check instead of an iteration.  Similarly
the block layer code would time out the activity once per hctx,
and only then iterate the (usually few) CPUs per hctx.


