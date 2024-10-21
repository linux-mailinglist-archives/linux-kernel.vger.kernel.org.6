Return-Path: <linux-kernel+bounces-374574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36989A6C50
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E50B21466
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BF31F9A8C;
	Mon, 21 Oct 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XllLZWIL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9AA1E0B96
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521403; cv=none; b=ncfJk1eapaFew9XhBSSiuOvvXOw+RSyvN2kPmR0kbv9nS9ivk1tTYrtwS1r8QyPTfze+SzwRg1wCHjy7EQSNU/HCYx/ko1bj0dNp40XPXP7MbxyAHqK/b5ZhYRbgPWE0s9x/Z9bl0zRskJz8NORFGZeNm5IgJu5wHEsTrlbD/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521403; c=relaxed/simple;
	bh=RgU58RN4trfD5valkvE0kXJVfUlucPbMoeUgDlvOaJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPOCM67HisK07UNXO+7cC2SYwQawgHaxG8zQH9roz+xuW7bOifb+YKVgjr5eNmccadAoLJJgEiUgv4sY1zAYbs0wuaC8HPQiYRIS5ZWtAoDEBcO7A3lgH2Fpkrr8BELYCxoEj2WJR7X+Jner4ioqACHQRanMEJ3aoy50MTICRo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XllLZWIL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729521400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XdHMHctRtd6RpWu83wzIm149e96GKtvvM481R456WxY=;
	b=XllLZWILhKlxdXEhkf16PZxBydWDtEP8Hv2bPuL2/x845t+lxFBxapG6veht3cLjIm0Ipg
	8YPMgDy8wjWCLrZLalLFcVOkzW4Xfi/IrSnvPvR2F+YzDDkwkp5rvgxA/i2lLJJrdkx+tO
	aKe1/2VRefgmx8aRmku0oiPfnN0g968=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-0pwV072UOfySrmjNGC_Seg-1; Mon,
 21 Oct 2024 10:36:35 -0400
X-MC-Unique: 0pwV072UOfySrmjNGC_Seg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FCB7195608D;
	Mon, 21 Oct 2024 14:36:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFC941956056;
	Mon, 21 Oct 2024 14:36:25 +0000 (UTC)
Date: Mon, 21 Oct 2024 22:36:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
Message-ID: <ZxZm5HcsGCYoQ6Mv@fedora>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora>
 <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora>
 <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Oct 21, 2024 at 02:30:01PM +0300, Sagi Grimberg wrote:
> 
> 
> 
> On 21/10/2024 11:31, Ming Lei wrote:
> > On Mon, Oct 21, 2024 at 10:05:34AM +0300, Sagi Grimberg wrote:
> > > 
> > > 
> > > On 21/10/2024 4:39, Ming Lei wrote:
> > > > On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
> > > > > From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
> > > > > 
> > > > > It is observed that nvme connect to a nvme over fabric target will
> > > > > always fail when 'nohz_full' is set.
> > > > > 
> > > > > In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> > > > > isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
> > > > > and when nvme connect to a remote target, it may fails on this stack:
> > > > > 
> > > > >           blk_mq_alloc_request_hctx+1
> > > > >           __nvme_submit_sync_cmd+106
> > > > >           nvmf_connect_io_queue+181
> > > > >           nvme_tcp_start_queue+293
> > > > >           nvme_tcp_setup_ctrl+948
> > > > >           nvme_tcp_create_ctrl+735
> > > > >           nvmf_dev_write+532
> > > > >           vfs_write+237
> > > > >           ksys_write+107
> > > > >           do_syscall_64+128
> > > > >           entry_SYSCALL_64_after_hwframe+118
> > > > > 
> > > > > due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
> > > > > blk_mq_ctx on the hw queue.
> > > > > 
> > > > > This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
> > > > > as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
> > > > > indicate that block layer can fallback to a  blk_mq_ctx whose cpu
> > > > > is not isolated.
> > > > blk_mq_alloc_request_hctx()
> > > > 	...
> > > > 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > > > 	...
> > > > 
> > > > It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
> > > > online CPUs, both are same actually from this viewpoint.
> > > > 
> > > > It is one long-time problem for nvme fc.
> > > For what nvmf is using blk_mq_alloc_request_hctx() is not important. It just
> > > needs a tag from that hctx. the request execution is running where
> > > blk_mq_alloc_request_hctx() is running.
> > I am afraid that just one tag from the specified hw queue isn't enough.
> > 
> > The connection request needs to be issued to the hw queue & completed.
> > Without any online CPU for this hw queue, the request can't be completed
> > in case of managed-irq.
> 
> None of the consumers of this API use managed-irqs. the networking stack
> takes care of steering irq vectors to online cpus.

OK, it looks not necessary to AND with cpu_online_mask in
blk_mq_alloc_request_hctx, and the behavior is actually from commit
20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU").

But it is still too tricky as one API, please look at blk_mq_get_tag(), which may
allocate tag from other hw queue, instead of the specified one.

It is just lucky for connection request because IO isn't started
yet at that time, and the allocation always succeeds in the 1st try of
__blk_mq_get_tag().



thanks,
Ming


