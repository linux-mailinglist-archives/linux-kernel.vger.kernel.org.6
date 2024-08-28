Return-Path: <linux-kernel+bounces-304307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A06961DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C272852F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305271474B5;
	Wed, 28 Aug 2024 04:29:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3C18030
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819359; cv=none; b=kGJytPz92D8x7hsfGp0vtpV0V/YJTFgzBjUAKTk4yhy1EaBpBIKwxgpZ4PJF5M8rGz0Gzny+om6V2PFds25ZwNjFB2UjoPSCa60QVumCJT905QUY3RVurJ9OpCixaEc1+MrT7AfoS/GcNuV82tZbyXdJTAePyQDzH7CUT455Rac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819359; c=relaxed/simple;
	bh=VHthfqoyT1tPAVpiX19iecuRXcaTisHYy9Gz5+35zXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdSLNRY/JsQUcu61oe08qWpAw+9bb9MnN7j2oAxLjAZ85HcgO8OzKar5GrJszfUSJg0GbjJvNdqFmbjfFSsjtN4ZZ+yqx0uhohXp8sQvU4tys2KtXshFm+VdZd/7mZTYevFYciZLBtJmljDrxKyBKIGBb9zJtgRpd3HWCXgWMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 829DE68B05; Wed, 28 Aug 2024 06:29:15 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:29:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Puranjay Mohan <pjy@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay@kernel.org
Subject: Re: [PATCH] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <20240828042915.GB30879@lst.de>
References: <20240827121701.48792-1-pjy@amazon.com> <Zs3z0CNrREMYafoC@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3z0CNrREMYafoC@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 09:42:08AM -0600, Keith Busch wrote:
> On Tue, Aug 27, 2024 at 12:17:01PM +0000, Puranjay Mohan wrote:
> > @@ -122,6 +123,9 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
> >  	struct bio *bio = NULL;
> >  	int ret;
> >  
> > +	if (meta_buffer && meta_len && bdev && !blk_get_integrity(bdev->bd_disk))
> > +		return -EINVAL;
> > +
> 
> Should we also fail if there's no bdev? The driver won't use the
> requested metadata for admin commands either, so that is also an invalid
> user request.

Yes, the last version gets the right.

