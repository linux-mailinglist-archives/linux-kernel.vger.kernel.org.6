Return-Path: <linux-kernel+bounces-306112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B4963959
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4A828571B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D7C8287D;
	Thu, 29 Aug 2024 04:28:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5349625
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905700; cv=none; b=TEMW11a5KXsvWwlUMXHBJl/x6cvHxFxvp92/p/6JsJzpp9eTduxFH9K1IAaSHu3m0BdGokrhTX5WGk6IxiNnfckqP2Ytj/so6g0EmWBUW1oaCP86o6CKcvlwPq/BKKGuWUWU/wZZo6xgt/V+9vfD8apQAJZ+HEGdFX7SLo0+c3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905700; c=relaxed/simple;
	bh=O4emDO4DaS6QfRbIYKgZEBFah+nbaEpZLH/zAZyAn2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRb5iIzrN6E6I5+KX1pt58T23xvABOPplPwTuBOMguSY/iT4A56MnbbUK3K/OgL3jc3hkbU7oklZX7IkoozVcVOUaVB4LU18Rg8a4ba9NgraBlP9aVnoR6eFkOjfyf0yAHCUi6er0B4ZCwqeQKGoFtbrPRCR334FWF5I6DZtd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0547768AFE; Thu, 29 Aug 2024 06:28:15 +0200 (CEST)
Date: Thu, 29 Aug 2024 06:28:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Puranjay Mohan <pjy@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay@kernel.org
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <20240829042814.GA4644@lst.de>
References: <20240827132327.1704-1-pjy@amazon.com> <Zs8360kRPGa1B5xy@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs8360kRPGa1B5xy@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 28, 2024 at 08:44:59AM -0600, Keith Busch wrote:
> On Tue, Aug 27, 2024 at 01:23:27PM +0000, Puranjay Mohan wrote:
> > @@ -119,9 +120,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
> >  	struct request_queue *q = req->q;
> >  	struct nvme_ns *ns = q->queuedata;
> >  	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
> > +	bool has_metadata = bdev && meta_buffer && meta_len;
> 
> If this is an admin command, then bdev is NULL, so "has_metadata" is
> false.
> 
> Since has_metadata is false, we continue on to process this admin
> command, but ignore the user's metadata settings. Do we want to return
> error there too?

Ah yes.  I had my brain wrapped around this the wrong way the
entire time.

Maybe a 

	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
	bool has_metadata = meta_buffer && meta_len;

might help poor brains like mine.

