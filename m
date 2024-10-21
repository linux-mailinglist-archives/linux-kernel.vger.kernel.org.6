Return-Path: <linux-kernel+bounces-373901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7469A5EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2542833A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756901E1C32;
	Mon, 21 Oct 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJvfjADD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C21D278D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499506; cv=none; b=oElXs/gUH3Z6hrkvkQ44v0XGpcqbM7DphNqaUBWaUyFTLEP0pzvwSF+73q2T3tQldUe7CH1COfQNhThZ/pARgYQ9pE8ny9GvdXdlz4l/77Q/2FIhtW5w9Jf5eDNaJUMdpjNdQxsqQC7J29evQgvHHWHG9Tw7pJUqtVvZdw1R1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499506; c=relaxed/simple;
	bh=f21XiQvlg0ti+Xjzxa+Z7uE3FmNRpazGuntm6reHJi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9ZZZ5FRjFcpOmoziXbnviN084cOATyduhxX08iwd77A3eA9cbrQmb1LOV1g3eE5wOjqbJlU9AQUBspPP7vbdZwWwE0WK1JmiaAPx4JmUm9xIKfVscoVrlGvEbp2mNlE/X7tRRS+UckNKCOakUSxG+uP3n/Wg2lzG8ekaVKaEWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJvfjADD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729499503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcSc+4L9y38uraoqMApZCtt9pe8JnUSoYfln1jlvOsY=;
	b=SJvfjADD2URLODkgPq1RboDzyyFB5zRMeRbE8Pa1yQ7/jGiWqam6XpJcWjBm+Nb6wrIYQY
	F/rXnQhzMZM4gODkMxnXaeehjYuDkOJ9sfCJUxNZhwA4SqbvZaTcSOIAc7K2Q4dm7X99P9
	CBO/Aaa5HHOkbcnnMrssblY5E3IiNR0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-36Rx2BnCNDeuD8EftrT9VQ-1; Mon,
 21 Oct 2024 04:31:40 -0400
X-MC-Unique: 36Rx2BnCNDeuD8EftrT9VQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEEAE1955D80;
	Mon, 21 Oct 2024 08:31:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.104])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D147B1956056;
	Mon, 21 Oct 2024 08:31:31 +0000 (UTC)
Date: Mon, 21 Oct 2024 16:31:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
Message-ID: <ZxYRXvyxzlFP_NPl@fedora>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora>
 <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Oct 21, 2024 at 10:05:34AM +0300, Sagi Grimberg wrote:
> 
> 
> 
> On 21/10/2024 4:39, Ming Lei wrote:
> > On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
> > > From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
> > > 
> > > It is observed that nvme connect to a nvme over fabric target will
> > > always fail when 'nohz_full' is set.
> > > 
> > > In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> > > isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
> > > and when nvme connect to a remote target, it may fails on this stack:
> > > 
> > >          blk_mq_alloc_request_hctx+1
> > >          __nvme_submit_sync_cmd+106
> > >          nvmf_connect_io_queue+181
> > >          nvme_tcp_start_queue+293
> > >          nvme_tcp_setup_ctrl+948
> > >          nvme_tcp_create_ctrl+735
> > >          nvmf_dev_write+532
> > >          vfs_write+237
> > >          ksys_write+107
> > >          do_syscall_64+128
> > >          entry_SYSCALL_64_after_hwframe+118
> > > 
> > > due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
> > > blk_mq_ctx on the hw queue.
> > > 
> > > This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
> > > as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
> > > indicate that block layer can fallback to a  blk_mq_ctx whose cpu
> > > is not isolated.
> > blk_mq_alloc_request_hctx()
> > 	...
> > 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > 	...
> > 
> > It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
> > online CPUs, both are same actually from this viewpoint.
> > 
> > It is one long-time problem for nvme fc.
> 
> For what nvmf is using blk_mq_alloc_request_hctx() is not important. It just
> needs a tag from that hctx. the request execution is running where
> blk_mq_alloc_request_hctx() is running.

I am afraid that just one tag from the specified hw queue isn't enough.

The connection request needs to be issued to the hw queue & completed.
Without any online CPU for this hw queue, the request can't be completed
in case of managed-irq.


thanks,
Ming


