Return-Path: <linux-kernel+bounces-267957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B24CF941DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED041B24A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA91494C9;
	Tue, 30 Jul 2024 17:21:18 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE81A76AF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360078; cv=none; b=G6mhR7sJeUHmnu/Xa8rNYdpEHgfvp9FHwB9gLVhkHa0NinG9Rlnh/TGsHGJXpALTOwI7cLEG4c2wjlpe9yRqqASsJjVEGuU01Ss+8ICfUZuqABZ1MCZ4ol784hfqmD5j5YM/BudBpNwi+/tGGm//lw16JZVT2z6DFcpAq19wMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360078; c=relaxed/simple;
	bh=eMyP2dgM1AKOTI7hIQwWxKAVgZ0xXv59iqceYX+gSjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRMsaR0INYyxPJkBRIP3ZwJny8fjGdVHYio4OyHPbbWK+x1vmR/5WUpGwXj7zxzUejn9QmVb9G+CxhHAd3vZaSaeJ9N2TTmY3W9+6GMVmm3a9CvOFZSh6wQNt9ggL833i+t64GWFiaTzY3VxjVfDyevNUcdcYQz++XnCL0oS0To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DBB2268AA6; Tue, 30 Jul 2024 19:21:11 +0200 (CEST)
Date: Tue, 30 Jul 2024 19:21:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <20240730172111.GA32320@lst.de>
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org> <ZqkeMJ5PPETMb5d3@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqkeMJ5PPETMb5d3@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 30, 2024 at 11:09:04AM -0600, Keith Busch wrote:
> > +	if (blk_rq_nr_phys_segments(req))
> > +		nvme_unmap_data(dev, req);
> 
> This is already applied, but it is kind of strange. We get here only if
> metadata mapping fails. Is there actually a command that has metadata
> without data?

Well, passthrough can always set metadata to map without data even
if there is no NVMe defined command that works that way, so we should
handle the error.

But I suspect this is due to Leon's dma-mapping work, and it probably
points to a bug in that :)

