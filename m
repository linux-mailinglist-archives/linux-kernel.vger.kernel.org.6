Return-Path: <linux-kernel+bounces-425309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2F9DC04B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A1D281A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2FF1586FE;
	Fri, 29 Nov 2024 08:12:48 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E4156C52
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867968; cv=none; b=sYGtG9vrb0cHFRG4IvwG4t1OPop9oC5tnuGrQwpiBCVPNahUVj/VeK/+Y1tG/5hI1NaBMTrG3n3b6gwliCjclAq43pULh8tOJ2Y9y6mrhpzgoQiaHwg/dYW6AnX/glKAaHo7frBGldsnN+dtqcrlpJFlYOzAgC4R5xjEwcqoSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867968; c=relaxed/simple;
	bh=8Dj7HwWVk9bPxX8a99LIHrVJls1Lg7cn2CPvkpsEeIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrU6mnd50iL9PQJKoDM+KZcbo6Xto4sTPm5nkNYH17CaVj1afIwuE5DIza5bEDGg4J+EQ2aQ+V/TlLXMmLJDUGNy3+R1j5w7KgghHdVQ4CgEoHtOflg6205GZKUGQibfTseDbUcNw27bJ7pDwT4Niw2PoyBMMeFrcv72wc0aRaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EACAF68D31; Fri, 29 Nov 2024 09:12:43 +0100 (CET)
Date: Fri, 29 Nov 2024 09:12:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Message-ID: <20241129081243.GE6819@lst.de>
References: <cover.1732699313.git.chunguang.xu@shopee.com> <9393a06d3fa651f9e68863b3cb9d952254f65e5a.1732699313.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9393a06d3fa651f9e68863b3cb9d952254f65e5a.1732699313.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 27, 2024 at 05:27:51PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now when destroying the IO queue we call nvme_tcp_stop_io_queues() twice,
> nvme_tcp_destroy_io_queues() has an unnecessary call. Here we try to remove
> nvme_tcp_destroy_io_queues() and merge it into nvme_tcp_teardown_io_queues(),
> simplify the code and align with nvme-rdma, make it easy to maintaince.

Please split the reorganization from the fix.

Also can you add Fixes tag to the various bug fix patches?


