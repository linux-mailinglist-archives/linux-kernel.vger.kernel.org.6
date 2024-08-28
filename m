Return-Path: <linux-kernel+bounces-305330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF95962D03
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F141C23B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2941A3BBF;
	Wed, 28 Aug 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+idIZXh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DAE1A2572
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860352; cv=none; b=MQkcbWFLn6mVEl73d5g8CCi2IIZ02T+TSlzCoOUNdaeAKwWyKcXtSGZHNVBNgfzihREqPVNUEuXfQtLgnwiM+swWfDRARIuh9XvyRHxmo7ZfbHc/K4Fi8/DAqhYbsr+mH/g7lfM2VfrKO4/HZDAyGEfaB1xPe4frKAFkpKtnbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860352; c=relaxed/simple;
	bh=aLJZstYbMFsoiIlcnF9iYgXbHkoB/kdXa6tTizeKPLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHe4IEaoiK8ufZwUuK5hZ8hJmgN7/pzlg0HPMqoNW/kr6BdBCJX2SlsAB7mUkvKJGo63PKxyrgtcqSUlqD67sm0qchxpybcSa11ChkKL/NL4SWQlhbBFOD0Kuet3rw1zOl8lEz7htNL7HWbP+z7puTrhPHPjiJRGEBek/w5JdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+idIZXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED034C4CEC2;
	Wed, 28 Aug 2024 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724860351;
	bh=aLJZstYbMFsoiIlcnF9iYgXbHkoB/kdXa6tTizeKPLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+idIZXhm71qDaiB+CSRtRkiCrA21en25/YuTiXq4wMjDxpUitQFB/2D2gN8oUbdU
	 JPG7wE1lHOx8AgAyo/QB+EZ1t2YoiREcVuhOHIwEQ/Y9ipfMgwb8NZPA5XMH3W5tZ/
	 JmFuwCnj2YXHJrnUlBcucITQZSFEySs+smgK6SRG1aEmTAz9AvpNt/8QJo+apHLNJQ
	 3km0M4JMnfCmZFUemMQ3zVyhkbLL4kSURg9n6yMA4VBWyWdgCxPgQ5tBZtN+VsCi7A
	 YNiuHVmYexJ2yYZeYX01IgD8BOPftu4jArnYwLx+yHmYPaChULyrffo9QUfOvdkALc
	 oHMANM+Taynmw==
Date: Wed, 28 Aug 2024 09:52:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay@kernel.org
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <Zs9HvJh8GRvYilFB@kbusch-mbp>
References: <20240827132327.1704-1-pjy@amazon.com>
 <Zs8360kRPGa1B5xy@kbusch-mbp>
 <mb61p1q28y88y.fsf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61p1q28y88y.fsf@amazon.com>

On Wed, Aug 28, 2024 at 03:31:09PM +0000, Puranjay Mohan wrote:
> Keith Busch <kbusch@kernel.org> writes:
> 
> > On Tue, Aug 27, 2024 at 01:23:27PM +0000, Puranjay Mohan wrote:
> >> @@ -119,9 +120,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
> >>  	struct request_queue *q = req->q;
> >>  	struct nvme_ns *ns = q->queuedata;
> >>  	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
> >> +	bool has_metadata = bdev && meta_buffer && meta_len;
> >
> > If this is an admin command, then bdev is NULL, so "has_metadata" is
> > false.
> >
> >>  	struct bio *bio = NULL;
> >>  	int ret;
> >>  
> >> +	if (has_metadata && !blk_get_integrity(bdev->bd_disk))
> >> +		return -EINVAL;
> >> +
> >
> > Since has_metadata is false, we continue on to process this admin
> > command, but ignore the user's metadata settings. Do we want to return
> > error there too?
> 
> As an admin command with metadata is an invalid configuration, we can

It's not that it's an invalid configuration. The spec defines the common
command format allowing admin commands to transfer metadata.

There's just no existing spec defined command that makes use of it.
Nothing stops a vendor specific command from using it. If someone
tried, the kernel reports success, but we didn't execute the requested
command.

> ignore the metada and go ahead with the admin command or I can add the
> following after the above check:
> 
> 	if (!bdev && (meta_buffer || meta_len))
>     	return -EINVAL;
> 
> I don't know what is the best approach here.

Yeah, or just do it in one line with the bdev case too:

	bool has_metadata = meta_buffer && meta_len;
	...

	if (has_metadata && (!bdev || !blk_get_integrity(bdev->bd_disk)))
		return -EINVAL

