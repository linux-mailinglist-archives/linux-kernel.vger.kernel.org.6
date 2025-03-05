Return-Path: <linux-kernel+bounces-547025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372E7A501EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAB6188B98D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A8A24BCE8;
	Wed,  5 Mar 2025 14:26:02 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECFB24A077;
	Wed,  5 Mar 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184761; cv=none; b=pDW+gZ7l5Lc0yDiZ6BUjGGQ6xMJfd5lwfihlchjw/xijzMBeILcYyn3Ea3Qvrt0jrpnRw1FLVm3LRQ0SCj49f/mLXbhdBKeboGtfnHcOTACuvFkx9TeXI+knKFFXE2qPaCbZnmzeWpqBIFvamorvih5chp7xgbe9/impQcpk5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184761; c=relaxed/simple;
	bh=MM1lLauZtbBl82rZecWqi2/StKbZuExCJbqi8DGngL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHuC2kskd5EnsBdQjak45Zbq8ach1lLs/iTHQOz4o4LJvHL4jbfGMd/SGeJNdC9ZtX1dU6gQeppGZybAu0GwgbOG9SSRH4KqX+GKJAiZYd/v7QdIjVstAegqmYCXnhdj9MPOPJ2yqHKfxv4eWje8dmWB0rLggqLMFV6sRneA0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5863368AFE; Wed,  5 Mar 2025 15:25:55 +0100 (CET)
Date: Wed, 5 Mar 2025 15:25:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
Message-ID: <20250305142554.GA18330@lst.de>
References: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 28, 2025 at 12:39:41PM +0300, Dan Carpenter wrote:
> index 8a9131c95a3d..361b04ec5b5d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1495,7 +1495,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>  	msg.msg_flags = MSG_WAITALL;
>  	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>  			iov.iov_len, msg.msg_flags);
> -	if (ret < sizeof(*icresp)) {
> +	if (ret < (int)sizeof(*icresp)) {
>  		pr_warn("queue %d: failed to receive icresp, error %d\n",
>  			nvme_tcp_queue_id(queue), ret);
>  		if (ret >= 0)

I hate these magic casts.  What about something like:

	if (ret >= 0 && ret < sizeof(*icresp))
		ret = -ECONNRESET;
	if (ret < 0) {
		...


