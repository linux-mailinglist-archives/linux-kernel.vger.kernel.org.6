Return-Path: <linux-kernel+bounces-255685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DBD9343B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E261F22DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADA418412C;
	Wed, 17 Jul 2024 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QgTtztGE"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7C1CD26
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250984; cv=none; b=NSEvfNc3Rcjm579ieJke3sYifjZZfAthNbpDRq2ThrwwkUn92h6oBhCFvcahf1sDd9eq70FE3ezvM+kyiV4k9hBhUoSe/AYsplLC6jlR+Z6jfHtbjpIs9/hgj4oBA2vhwM3vvG3u1ZUkZ3Ce1PbWa54d9zMayJalMgfSRI7WNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250984; c=relaxed/simple;
	bh=DIyKadB4zXLlZJwaQInwG9qHfs495Tc0NTHXpqh9K14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFqfOaJEvnKMFte2eE+KMMSbJXwzjSilC/Lg4eOKcbSLvFjSlJ0XSOdlfGiJ+ma3q+jhR9j1isgecZ3e7c3sjnavqZwV9e+61rlR8VUeBjfaaJXA4kW6xpuq5Tb3HB0Cm8AsD21ZExHenVcazqstXt2k7t8rCbWh1SkrK9n/678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QgTtztGE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1721250980;
	bh=DIyKadB4zXLlZJwaQInwG9qHfs495Tc0NTHXpqh9K14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgTtztGELU+/aFOwNpl5sTMUjyw27GKFo4tsPt+SPmslPvwjYQdQUrCfALLoymkDV
	 i0mtrcnaswUNhfWGCU3vVJ289dTgoBHv/g/NoeghvDmKAxq83yjQ1jHtzGwOVUVjDd
	 wS6Fmt8wcrweWLo1S4/SaR3Y2KGfVM5vDdPbSRsU=
Date: Wed, 17 Jul 2024 23:16:19 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>, 
	Martin Wilck <martin.wilck@suse.com>, Ayush Siddarath <ayush.siddarath@dell.com>
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
Message-ID: <64ec91e8-4ff2-4c56-a468-c194f803db6b@t-8ch.de>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717185550.22102-1-stuart.w.hayes@gmail.com>

Hi,

two tiny nitpicks that can probably be fixed during patch application.

On 2024-07-17 13:55:50+0000, Stuart Hayes wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 782090ce0bc1..dc43146dc03d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2011-2014, Intel Corporation.
>   */
>  
> +#include <linux/async.h>
>  #include <linux/blkdev.h>
>  #include <linux/blk-mq.h>
>  #include <linux/blk-integrity.h>
> @@ -3952,6 +3953,35 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	}
>  }
>  
> +/*

Kernel-doc with /** ?

> + * struct async_scan_info - keeps track of controller & NSIDs to scan
> + * @ctrl:	Controller on which namespaces are being scanned
> + * @next_nsid:	Index of next NSID to scan in ns_list
> + * @ns_list:	Pointer to list of NSIDs to scan
> + *
> + * Note: There is a single async_scan_info structure shared by all instances
> + * of nvme_scan_ns_async() scanning a given controller, so the atomic
> + * operations on next_nsid are critical to ensure each instance scans a unique
> + * NSID.
> + */
> +struct async_scan_info {
> +	struct nvme_ctrl *ctrl;
> +	atomic_t next_nsid;
> +	__le32 *ns_list;
> +};
> +
> +static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
> +{
> +	struct async_scan_info *scan_info = data;
> +	int idx;
> +	u32 nsid;
> +
> +	idx = (u32)atomic_fetch_add(1, &scan_info->next_nsid);

atomic_fetch_inc() ?

> +	nsid = le32_to_cpu(scan_info->ns_list[idx]);
> +
> +	nvme_scan_ns(scan_info->ctrl, nsid);
> +}
> +

