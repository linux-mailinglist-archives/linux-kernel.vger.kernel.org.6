Return-Path: <linux-kernel+bounces-394902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8E9BB594
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B861C211CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800CAD5A;
	Mon,  4 Nov 2024 13:16:57 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B13AD24
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726217; cv=none; b=s2Ps5ubLNxBi/ajHQUthUJzM7yxDtKKsKBEvCEwdtiQ+ufKFOyg5qU4GCqevsnyM1RRC9l3ldbB6809aw7TpvZQvZRROHnvAWKWN4Rju37OqTjmEwKdZIn9nAt41ubkITZKAgceQqxgTLY1U3Qd3Llnqk4qWXuIMBhQG17Q6Mpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726217; c=relaxed/simple;
	bh=eqPHxKB8oYmnFBMYbcUSGgAFHztLYpNlIMJ6GglgQBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIB7sE2/N/TbFd5MCvxHhvxryyCJmb0J4+v/ZTzB8uQr3LNwTO7yC5WLVjM8SNU0gYWR7WTWJK34+6/y6eTmy+79Ir0WYikc+23DbLwYpx6HIWkzpcuv09pBvi8QkR09RCu5x5N/IQG6li910oL3+759oAXor2PDFKfDpBXGE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 39374227AAF; Mon,  4 Nov 2024 14:16:52 +0100 (CET)
Date: Mon, 4 Nov 2024 14:16:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] nvme/host: Fix RCU list traversal to use SRCU primitive
Message-ID: <20241104131652.GB14373@lst.de>
References: <20241104-nvme_rcu-v1-1-ecb19f5c95fa@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-nvme_rcu-v1-1-ecb19f5c95fa@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 04, 2024 at 04:24:40AM -0800, Breno Leitao wrote:
> The code currently uses list_for_each_entry_rcu() while holding an SRCU
> lock, triggering false positive warnings with CONFIG_PROVE_RCU=y
> enabled:
> 
>   drivers/nvme/host/core.c:3770 RCU-list traversed in non-reader section!!
> 
> While the list is properly protected by SRCU lock, the code uses the wrong
> list traversal primitive. Replace list_for_each_entry_rcu() with
> list_for_each_entry_srcu() to correctly indicate SRCU-based protection
> and eliminate the false warning.

I didn't even know there was such as thing as list_for_each_entry_srcu,
but apparently it's been there for a while.  Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> Something similar will need to be done for multipath. I will get it done
> once I get some feedback about this patch first.

Thanks!


