Return-Path: <linux-kernel+bounces-237214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA591ED87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49DD1C21DB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D756822301;
	Tue,  2 Jul 2024 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OR2tnmeq"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149C801
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 03:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719892392; cv=none; b=XBRSTYl+6PWRKQpBu3cRWvWhWOigh0aixfAG+YWHFUz6okcmoLfPiVDnkRF65UKMNtT4H7yObUdO+1xmCBA9Q4EH+3x6kwpSfNucxORrBGLZu7Ojr8zPhfmgUJR1kDnjW4kl10Wia3Ug3tJJSSsonmAE1JdE0Kd0T4fs+PZME2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719892392; c=relaxed/simple;
	bh=vMdBHqe/N9wE69bD/bPYh1aH8O/oJiRyq5VHsr8qrEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo4l6DJuwcubTQpWOPhWcPWrRWQq4/mPf7OvxHfUT1dQAlbtlCyROo5XC16ka+EoUcP1yibCbtQfD6pj/xg4TbsP4E72b1IpE0tADCslvsRhygjXJwWyePHOrnJCt3qsa39ZUH6d3Qwn6f4ygXA3QEm+foF6txm3Bi4AHYUcKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OR2tnmeq; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tj@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719892388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDIhoAG5xCGl8/+4vUmo5RSEcftTwK8usEtZnMpgwps=;
	b=OR2tnmeqkD2ae0wGDOz3WC8E4fEbqUMIA1xwC9OMeOW7qLA+znxxXNyuMHkkzefHMQVUf/
	+8FPT3rDYvdnJGqaDOGzv8PfKB+w30xUHu4TgvU8S/zMWs40M6V7g60RAWtB6hcH6tUXKk
	tke2Rpu+SLzVitOIYGPDk2WG6VumNIk=
X-Envelope-To: yi.sun@unisoc.com
X-Envelope-To: sunyibuaa@gmail.com
X-Envelope-To: jiangshanlai@gmail.com
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: ebiggers@google.com
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: niuzhiguo84@gmail.com
X-Envelope-To: hao_hao.wang@unisoc.com
X-Envelope-To: yunlongxing23@gmail.com
Date: Mon, 1 Jul 2024 23:53:01 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Yi Sun <yi.sun@unisoc.com>, sunyibuaa@gmail.com, 
	jiangshanlai@gmail.com, jaegeuk@kernel.org, chao@kernel.org, ebiggers@google.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, 
	Hao_hao.Wang@unisoc.com, yunlongxing23@gmail.com
Subject: Re: [PATCH v2 1/2] workqueue: new struct io_work
Message-ID: <ycmaxfuqpnj3vnmseikx7m7jkzsp2t2qtlncgub44xhxohs6du@hucdavhpcvpi>
References: <20240701075138.1144575-1-yi.sun@unisoc.com>
 <20240701075138.1144575-2-yi.sun@unisoc.com>
 <ZoLoJ-uBo9qyAlMg@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoLoJ-uBo9qyAlMg@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 01, 2024 at 07:32:23AM GMT, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jul 01, 2024 at 03:51:37PM +0800, Yi Sun wrote:
> > +/*
> > + * If a work may do disk IO, it is recommended to use struct io_work
> > + * instead of struct work_struct.
> > + */
> > +struct io_work {
> > +	struct work_struct work;
> > +
> > +	/* If the work does submit_bio, io priority may be needed. */
> > +	unsigned short ioprio;
> > +	/* Record kworker's original io priority. */
> > +	unsigned short ori_ioprio;
> > +	/* Whether the work has set io priority? */
> > +	long ioprio_flag;
> > +};
> 
> There are fundamental limitations to this approach in terms of
> prioritization. If you tag each work items with priority and then send them
> to the same workqueue, there's nothing preventing a low priority issuer from
> flooding the workqueue and causing a priority inversion. ie. To solve this
> properly, you need per-issuer-class workqueue so that the concurrency limit
> is not shared across different priorities.
> 
> Now, this limited implementation, while incomplete and easy to defeat, may
> still be useful. After all, ioprio itself, I think, is flawed in the same
> way. If f2fs wants to implement this internally, that's okay, I suppose, but
> as a generic mechanism, I don't think this makes a lot of sense.

And I wonder if the reason for submitting from a workqueue isn't also
priority inversion?

I haven't looked at the f2fs code, but that comes up in bcachefs; we
have IOs that we submit from worqueue context because they're submitted
in contexts where we _really_ cannot block - they're metadata IOs, and
thus also high priority IOs. But if the queue is already full with lower
priority IOs...

perhaps what we need is a bio flag to say "do not block in the
submission path, queue is allowed to exceed normal limits for this (high
priority) IO"

