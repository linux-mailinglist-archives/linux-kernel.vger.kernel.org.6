Return-Path: <linux-kernel+bounces-420518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10699D7BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE6D161FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511FF15F41F;
	Mon, 25 Nov 2024 07:22:46 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381561426C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519366; cv=none; b=tBPMxU7bfIeXGThULU7toVGUPQ0yfRrIs3Lm/yuIP9hUGw5q3qgm5m8wtjBLL2RpEi72I5vo3p9tjN11IH8fyUXKeciswEd259R1RIQr4s8Y0Yksg4vgSl9cq24sUAgRRvTmLY2ddMRh/DbF+ovsA80nIZAoJl3ML03YdZkyEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519366; c=relaxed/simple;
	bh=xbmohuxWGqOnx7XFMq+O1ABJI3FUQmYj/WFzd++bg78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8g3BBgaojPvrG8lURGSU+6MQ2Y13ZcYTHZb4QWgVv6xIt9aom5j5tBYzB1GEbJbnBFtC9utZ/ArlLvf2wUEwSpLHWUvu4WdbpDQzkerZ/UGXzOldquvT21lnJYAjvcVIp7YHP6K27OdTj6wD17pEyXkp7zWiYVJZkTwacYha3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 34A3568D09; Mon, 25 Nov 2024 08:22:41 +0100 (CET)
Date: Mon, 25 Nov 2024 08:22:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nvme-tcp: no need to quiesec admin_q in
 nvme_tcp_teardown_io_queues()
Message-ID: <20241125072240.GB15647@lst.de>
References: <cover.1732368538.git.chunguang.xu@shopee.com> <e7c1d7b531cef5fdd2764719e4ca824477579083.1732368538.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7c1d7b531cef5fdd2764719e4ca824477579083.1732368538.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 23, 2024 at 09:37:38PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> As we quiesec admin_q in nvme_tcp_teardown_admin_queue(), so we should no
> need to quiesec it in nvme_tcp_reaardown_io_queues(), make things simple.

Yes.  And this matches what RDMA is doing.  We really need to go
back to the attempt to consolidaste this code..

Reviewed-by: Christoph Hellwig <hch@lst.de>

