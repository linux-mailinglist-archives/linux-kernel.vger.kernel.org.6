Return-Path: <linux-kernel+bounces-352809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146899245A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDD11C21B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE513BC0E;
	Mon,  7 Oct 2024 06:19:33 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5494101E2
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281973; cv=none; b=u1hzkt2jsysI2+3DRb0Wa+58RYOPktQZYYTdIrYzmpd3iUpa9YYrVe1DRY+5YcsUhAqiL30ocLYvD7559xVL886yIPbUrJxeuS8VrA746FpOJ+6KauhZ0ipx8tityRkKSg/K6cucGFz6RAFblmca7YknnxeoeYmGH7YpdKJf7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281973; c=relaxed/simple;
	bh=Mkev/7tbHfE3RhaYvRkIlaN9L6RZ59hVwkc3tXjLyz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgSzlW/MJd52P0qtcW9GonTc8LYdt1m3+2qOehMI3VPCIn/8SpMUDauy41M2L+lT5j+3uHHArhvcs39YJhwE7+98SWpr/84OuDr7WsZc23akFEDCYt937T+16sy5Cm0pa/N/51I02th2rL3OAFbMsUxX30YQkgJZAG6x6QNVfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 854F8227A8E; Mon,  7 Oct 2024 08:19:26 +0200 (CEST)
Date: Mon, 7 Oct 2024 08:19:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
Message-ID: <20241007061926.GA800@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com> <20241004101014.3716006-2-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004101014.3716006-2-tero.kristo@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> @@ -483,6 +498,27 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
>  			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
>  		writel(nvmeq->sq_tail, nvmeq->q_db);
>  	nvmeq->last_sq_tail = nvmeq->sq_tail;
> +
> +	/* Kick CPU latency while updating queue. */
> +	dev = nvmeq->dev;
> +	if (!dev || dev->cpu_latency < 0)
> +		return;
> +
> +	for_each_cpu(cpu, nvmeq->irq_aff_mask) {

Doing something as complex as this for every doorbell write is not
going to fly.

Even if it was I see nothing nvme-specific in the interface.

So please figure out a way to make things cheap in the I/O path
and move code to the right layers.

Also please avoid all these overly long lines.

