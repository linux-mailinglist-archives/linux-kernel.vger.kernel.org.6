Return-Path: <linux-kernel+bounces-255658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4A293435B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EB02826AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4EF1849C2;
	Wed, 17 Jul 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhSQ80c6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4AF1836C2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249204; cv=none; b=LFrR0kDOlk25H6su1JDlOlC1xZNCdfD8GBlkCC10kCQO7Oum4+HDXzKiuEjQU3/HfUaPc5ObbkA01mTYOOx6kvCPL3VGWAsV6dZO9gecq09mt4Uon5I8g4Pu4iVV71jxIDhHs1tNnslgm1o2oBsbGx26dDYlhSTgL0xYJKBguCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249204; c=relaxed/simple;
	bh=VJ0bOKhZM7go/h0ruYNFa7O/uh7behoUmySjHl6SPiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/yZmkC/Jyl70t2YUdHN5opitaJtnEP3uhIhNjz4+dAM5L732oUPel6QKf46+59vrzWxdlUtnWTJJl6CiS8AtkPQkpaRQuoO6ND81edZpgz9YiigmknoaRTc+FgMsW3xdKoMoUZirs7NJ25rYYN7XxeHkRLTL5H1XGeUtxegu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhSQ80c6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB2CC2BD10;
	Wed, 17 Jul 2024 20:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721249203;
	bh=VJ0bOKhZM7go/h0ruYNFa7O/uh7behoUmySjHl6SPiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhSQ80c6IYLEZr6FPzVHoaQwjvvAR/uWkoFBpYHwjDhUAyWBN/X2qAjkfcFxATtE6
	 Fau9pC2UpQiFVyyGPcZTxs8se1jPbilLwrIXpBNSHDnMvZ2IWKhC6H30WFjUNQXksN
	 fVbJ7Z4iKoEsWts9peAcL3ge7GxMYE5YJpy26V++pmaMlbvvRI73YlA9nJ5nDtm+zG
	 a/yVPYZ7v7ciRUYIZBt1ymHQbbWrYNsf2L+iZvdqJOqnsRn/gQupdvysj1wizMdTXN
	 IRmztqmH5q7xDnjl9AZb1FYIDMiDxMwHMDhEMdiUFSsNI5eass1hvRIbYemQC45Che
	 mIznswJl0tW3Q==
Date: Wed, 17 Jul 2024 14:46:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Martin Wilck <martin.wilck@suse.com>,
	Ayush Siddarath <ayush.siddarath@dell.com>
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
Message-ID: <Zpgtr33uqbMogK7c@kbusch-mbp.dhcp.thefacebook.com>
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

On Wed, Jul 17, 2024 at 01:55:50PM -0500, Stuart Hayes wrote:

Looks good to me. Just one minor comment below.

> @@ -3978,11 +4008,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>  	__le32 *ns_list;
>  	u32 prev = 0;
>  	int ret = 0, i;
> +	ASYNC_DOMAIN(domain);
> +	struct async_scan_info scan_info;
>  
>  	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>  	if (!ns_list)
>  		return -ENOMEM;
>  
> +	scan_info.ctrl = ctrl;
> +	scan_info.ns_list = ns_list;
>  	for (;;) {
>  		struct nvme_command cmd = {
>  			.identify.opcode	= nvme_admin_identify,
> @@ -3998,19 +4032,23 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>  			goto free;
>  		}
>  
> +		atomic_set(&scan_info.next_nsid, 0);
>  		for (i = 0; i < nr_entries; i++) {
>  			u32 nsid = le32_to_cpu(ns_list[i]);
>  
>  			if (!nsid)	/* end of the list? */
>  				goto out;
> -			nvme_scan_ns(ctrl, nsid);
> +			async_schedule_domain(nvme_scan_ns_async, &scan_info,
> +						&domain);
>  			while (++prev < nsid)
>  				nvme_ns_remove_by_nsid(ctrl, prev);
>  		}
> +		async_synchronize_full_domain(&domain);
>  	}
>   out:
>  	nvme_remove_invalid_namespaces(ctrl, prev);
>   free:
> +	async_synchronize_full_domain(&domain);

A goto this "free" label appears to mean the async domain has nothing
scheduled, so synchronizing won't be necessary. This should be moved up
tharmlesso the "out" label, I think.

I can change that up when applying; just wanted to mention it in case
I'm missing something.

