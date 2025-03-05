Return-Path: <linux-kernel+bounces-547050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62FA50265
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183303B3832
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147B24E006;
	Wed,  5 Mar 2025 14:38:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93A2E3396;
	Wed,  5 Mar 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185500; cv=none; b=Y+UKb09XCMVqazxhRlSyXiB9juSnz7dGZnAJwEZvOOqN2L6HDGVdnDIWuomFSOWjHHlTKA1EYBbF5FbjTR16yUDfY77BbTM3tWnxhedHdgDTaqiiHJ6xyjQr+i8gAyqWpm/886kV86xQYWLDYIb9WVJj1vefd2o5k0XVmwynrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185500; c=relaxed/simple;
	bh=BMmoQzW3AxNTdMe7/ngjvFv9EZpOVEFkw2pwJFHMUq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdDs5pWYBX3ftc/FZTIqMN6BVek7m+WOfJt8CvnlqTRkXFQ2Hx/WoZ7crKTuLDcYj9/9xS0en2bnh+Yxlz+DVulhzR2D8I7n+f6hWY8K+QYvGPYHG54TZ0zYUJMpGnu7w0kMGxoWFfQ0WyWuHAy5IQLV40tkkS1c+xhC+xH73pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49E3568AFE; Wed,  5 Mar 2025 15:38:14 +0100 (CET)
Date: Wed, 5 Mar 2025 15:38:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
Message-ID: <20250305143814.GA18852@lst.de>
References: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain> <20250305142554.GA18330@lst.de> <739d3443-61c4-4b69-866b-142efde59062@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739d3443-61c4-4b69-866b-142efde59062@stanley.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 05, 2025 at 05:37:15PM +0300, Dan Carpenter wrote:
> > 	if (ret >= 0 && ret < sizeof(*icresp))
> > 		ret = -ECONNRESET;
> > 	if (ret < 0) {
> > 		...
> 
> Sure, I can do that.
> 
> I don't love casts either.  I normally have tried to write these as
> "if (ret < 0 || ret < sizeof(*icresp)) {" and people don't love that.

I can see why people don't like it as it's really counterintuitive.
These kinds of interfaces just suck given the type promotion rules
unfortunately.


