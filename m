Return-Path: <linux-kernel+bounces-375383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E39A954D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F5B1C20F35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E785E811E2;
	Tue, 22 Oct 2024 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZRQ16xt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8C41C94
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559615; cv=none; b=jpuL0RirKqtVFbbLnnSJ4f27wdat7dgIj1+Ckg3zXo/lttM+mmW2yYUf6BRcbaF7K3J4gaAy/FWanuUmiRCc8p0D337rHQlPI5vONCJ7StUFBCgix2gYxiydhhK73ZKoeuRkXE72qXU2+FwiuApM7QfIALx22CqyXrIC3vwSPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559615; c=relaxed/simple;
	bh=rbRyCyHuqHZe9+vp6e+kY5h5jlCXrFDgu2KJ90rHzuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLstJpGwme1C+GGONKrzPKleyNnflmi+bDsJI2YqUh/6J6RqbVUZz/lQ5Hm8gQoLk/WUECRhKH7FLwvWhrPEh7VtlNr0Bx3CZdM3eJEsDidQEIydNAXrqcVKOAEJr6e1y8r+RokVAA6wESL0xpAI1f3hW31aBpSJmWt6/AcTHwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZRQ16xt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729559611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fuU7Pk5ir/W1+5iFZkdVjz+lD+cUxjKbexv+u9sHBo4=;
	b=WZRQ16xtNm7mNu+y/1TvGKt120ZKG13yBW7uJuSlqOfo4K0vU6YB3+DDmJnrEd/NQk8mIJ
	QmT8EzsqmZ0BngDmhKj2C5tsMPJG3uT8p/ERgpPZ1bYdbnYgQx5LawlLPhCkaIvUcqLlvR
	ec+3qWdVMaHpp9Xxc4KL3lf49vSY4/g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-1FVvjAtWMyiKfyY_BPofrg-1; Mon,
 21 Oct 2024 21:13:28 -0400
X-MC-Unique: 1FVvjAtWMyiKfyY_BPofrg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 174CF195608C;
	Tue, 22 Oct 2024 01:13:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 289131955F41;
	Tue, 22 Oct 2024 01:13:18 +0000 (UTC)
Date: Tue, 22 Oct 2024 09:13:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
Message-ID: <Zxb8KaoUVstRCxiP@fedora>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora>
 <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora>
 <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
 <ZxZm5HcsGCYoQ6Mv@fedora>
 <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Oct 21, 2024 at 06:27:51PM +0300, Sagi Grimberg wrote:
> 
> 
> 
> On 21/10/2024 17:36, Ming Lei wrote:
> > On Mon, Oct 21, 2024 at 02:30:01PM +0300, Sagi Grimberg wrote:
> > > 
> > > 
> > > On 21/10/2024 11:31, Ming Lei wrote:
> > > > On Mon, Oct 21, 2024 at 10:05:34AM +0300, Sagi Grimberg wrote:
> > > > > 
> > > > > On 21/10/2024 4:39, Ming Lei wrote:
> > > > > > On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
> > > > > > > From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
> > > > > > > 
> > > > > > > It is observed that nvme connect to a nvme over fabric target will
> > > > > > > always fail when 'nohz_full' is set.
> > > > > > > 
> > > > > > > In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> > > > > > > isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
> > > > > > > and when nvme connect to a remote target, it may fails on this stack:
> > > > > > > 
> > > > > > >            blk_mq_alloc_request_hctx+1
> > > > > > >            __nvme_submit_sync_cmd+106
> > > > > > >            nvmf_connect_io_queue+181
> > > > > > >            nvme_tcp_start_queue+293
> > > > > > >            nvme_tcp_setup_ctrl+948
> > > > > > >            nvme_tcp_create_ctrl+735
> > > > > > >            nvmf_dev_write+532
> > > > > > >            vfs_write+237
> > > > > > >            ksys_write+107
> > > > > > >            do_syscall_64+128
> > > > > > >            entry_SYSCALL_64_after_hwframe+118
> > > > > > > 
> > > > > > > due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
> > > > > > > blk_mq_ctx on the hw queue.
> > > > > > > 
> > > > > > > This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
> > > > > > > as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
> > > > > > > indicate that block layer can fallback to a  blk_mq_ctx whose cpu
> > > > > > > is not isolated.
> > > > > > blk_mq_alloc_request_hctx()
> > > > > > 	...
> > > > > > 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > > > > > 	...
> > > > > > 
> > > > > > It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
> > > > > > online CPUs, both are same actually from this viewpoint.
> > > > > > 
> > > > > > It is one long-time problem for nvme fc.
> > > > > For what nvmf is using blk_mq_alloc_request_hctx() is not important. It just
> > > > > needs a tag from that hctx. the request execution is running where
> > > > > blk_mq_alloc_request_hctx() is running.
> > > > I am afraid that just one tag from the specified hw queue isn't enough.
> > > > 
> > > > The connection request needs to be issued to the hw queue & completed.
> > > > Without any online CPU for this hw queue, the request can't be completed
> > > > in case of managed-irq.
> > > None of the consumers of this API use managed-irqs. the networking stack
> > > takes care of steering irq vectors to online cpus.
> > OK, it looks not necessary to AND with cpu_online_mask in
> > blk_mq_alloc_request_hctx, and the behavior is actually from commit
> > 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU").
> 
> it is a long time ago...
> 
> > 
> > But it is still too tricky as one API, please look at blk_mq_get_tag(), which may
> > allocate tag from other hw queue, instead of the specified one.
> 
> I don't see how it can help here.

Without taking offline cpus into account, every hctx has CPUs mapped
except for cpu isolation, then the failure of 'cpu >= nr_cpu_ids' won't
be triggered.

> 
> > 
> > It is just lucky for connection request because IO isn't started
> > yet at that time, and the allocation always succeeds in the 1st try of
> > __blk_mq_get_tag().
> 
> It's not lucky, we reserve a per-queue tag for exactly this flow (connect)
> so we
> always have one available. And when the connect is running, the driver
> should
> guarantee nothing else is running.

What if there is multiple concurrent allocation(reserve) requests? You still
may run into allocation from other hw queue. In reality, nvme may don't
use in that way, but as one API, it is still not good, or at least the
behavior should be documented.


thanks,
Ming


