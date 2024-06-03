Return-Path: <linux-kernel+bounces-198507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE468D7965
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71401F214B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 00:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C9137E;
	Mon,  3 Jun 2024 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTEoy3vq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9124A10F1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717375159; cv=none; b=vBkIFJmU1bC92c1hrvzopPBJL4bG4h2pNp6AHSZjh+Pq6T8hT64mYCjB+d5pbmgTqu5sxymw/m/+mwbl3qROi2HuTTDwgZw14l/7D2cFQgwlkUjZGpGxj4KOzzw7vlC52iwknlUokghUd2rq85GD/gCTuKdEmh91G7my4WaekKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717375159; c=relaxed/simple;
	bh=sIFA2QLadZPW4ixX8O/PmgC53iTZ7YCsO0p+e5J4s7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn7uSGU996b5HdHouF5164/jgeL4lIO8GmvQc3uyYzIz4ygHIKdqi+2FdEW/HVpyQu8a7MwgNsi8WO0GpuCD+UUMCR8TAU/HLS1VRs2RN1OBuJiQQ2Oy4GG9cmwdKxTFldQ+15PUo1W5dodlYFZeFnUHt2Sa06tJeUPQ4jZhtME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTEoy3vq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717375156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLcyi4sdNMvlRP3KUNt+kw9ubCkYadoueCSm8nk6hEg=;
	b=UTEoy3vqpnT0aLjlpvCMdP8jkA4+V8juZbeKt/B6z2m13lhLwnsPn7BNXDw63I+7kFhggq
	uPfOoPmObu+DEijw3VJ0c9JKwbBk5Sj3adaGM9BxQ/H7McycpRV0VkDdWe42F72L21VVbJ
	VncJXMgwIrLPwP5g0u0U1acA948A31c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-OvVK7Hg0O_6sDsJsWUSXEg-1; Sun, 02 Jun 2024 20:39:09 -0400
X-MC-Unique: OvVK7Hg0O_6sDsJsWUSXEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40EAA81227E;
	Mon,  3 Jun 2024 00:39:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DF8740AD3D3;
	Mon,  3 Jun 2024 00:39:04 +0000 (UTC)
Date: Mon, 3 Jun 2024 08:39:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, ZiyangZhang@linux.alibaba.com, czhong@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in
 ublk_ctrl_start_recovery()
Message-ID: <Zl0QpCbYVHIkKa/H@fedora>
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095313.2568595-1-linan666@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, May 29, 2024 at 05:53:13PM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> When two UBLK_CMD_START_USER_RECOVERY commands are submitted, the
> first one sets 'ubq->ubq_daemon' to NULL, and the second one triggers
> WARN in ublk_queue_reinit() and subsequently a NULL pointer dereference
> issue.
> 
> Continuing execution after WARN is incorrect, as 'ubq->ubq_daemon' is
> known to be NULL. Fix it by return directly if the WARN is triggered.
> 
> Note that WARN will still be triggered after the fix if anyone tries to
> start recovery twice.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000028
>   RIP: 0010:ublk_ctrl_start_recovery.constprop.0+0x82/0x180
>   Call Trace:
>    <TASK>
>    ? __die+0x20/0x70
>    ? page_fault_oops+0x75/0x170
>    ? exc_page_fault+0x64/0x140
>    ? asm_exc_page_fault+0x22/0x30
>    ? ublk_ctrl_start_recovery.constprop.0+0x82/0x180
>    ublk_ctrl_uring_cmd+0x4f7/0x6c0
>    ? pick_next_task_idle+0x26/0x40
>    io_uring_cmd+0x9a/0x1b0
>    io_issue_sqe+0x193/0x3f0
>    io_wq_submit_work+0x9b/0x390
>    io_worker_handle_work+0x165/0x360
>    io_wq_worker+0xcb/0x2f0
>    ? finish_task_switch.isra.0+0x203/0x290
>    ? finish_task_switch.isra.0+0x203/0x290
>    ? __pfx_io_wq_worker+0x10/0x10
>    ret_from_fork+0x2d/0x50
>    ? __pfx_io_wq_worker+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> Fixes: c732a852b419 ("ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support")
> Reported-and-tested-by: Changhui Zhong <czhong@redhat.com>
> Closes: https://lore.kernel.org/all/CAGVVp+UvLiS+bhNXV-h2icwX1dyybbYHeQUuH7RYqUvMQf6N3w@mail.gmail.com
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/block/ublk_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4e159948c912..99b621b2d40f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2630,7 +2630,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
>  {
>  	int i;
>  
> -	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
> +	if (WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq))))
> +		return;

Yeah, it is one bug. However, it could be addressed by adding the check in
ublk_ctrl_start_recovery() and return immediately in case of NULL ubq->ubq_daemon,
what do you think about this way?


Thanks,
Ming


