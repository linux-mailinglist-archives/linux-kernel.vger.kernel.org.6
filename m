Return-Path: <linux-kernel+bounces-388248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD29B5CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82316280D95
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648B31DF26A;
	Wed, 30 Oct 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIEm8KUX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B371DE897
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272413; cv=none; b=Sget0xrj6j/kpzY4UqzVx1KWov7uh8xxdmiYsODNnrr4dhJQWVPD5cf/M1CJzio1TfCQN9vGBXwATuY3VVRyWO3wOX/maHCGfXqNqcP1OZ4HYbame/zFEGV3yn25PhRkOp5qe2XZRtDlfd1oOXA7o908dopPFJdWcV3IQsfweKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272413; c=relaxed/simple;
	bh=cgAf50RYNmrWNMXQdxzGetiIXtUbpilyTBEf/xluXWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4TrVg/u21YpkILY48aGZXueV78E/zfte1SADDMVv8ApuGRK+4i711jFAMIkvRnLjz3sLAi4k6qLvf8UEMVT4k/ET2/QGmTCeE1mFZbw/EZgI771VYgNs5VSBT7EZNY4lfvAp8lKMIrvxFZHrlvTm6yN7OqlMssGdvp4WFHMeaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIEm8KUX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730272410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pyc9kuN+esV29UstGSbCAwvAag7jYZFoB05W43HZPo=;
	b=VIEm8KUXG/baIX9L/2akCyFrFGcHHZQ/KlEIVF9cflYz15xl+4JvlLSWvoArARNrSSjhUC
	MHHfrDKOlMYhwUezDuk3GnqCkvQX8dY3AqxuWJbSdFiUGu8mtkTsGgvgglXoYSZ4+KH1er
	q+7LQu1UR4vlDKboqURT+w17OEo8q9Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-AhPlJOCsMfWI29HdTfIJCA-1; Wed,
 30 Oct 2024 03:13:26 -0400
X-MC-Unique: AhPlJOCsMfWI29HdTfIJCA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 771A61955F3E;
	Wed, 30 Oct 2024 07:13:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 906AC300019D;
	Wed, 30 Oct 2024 07:13:14 +0000 (UTC)
Date: Wed, 30 Oct 2024 15:13:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <ZyHchfaUe2cEzFMm@fedora>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyHV7xTccCwN8j7b@ly-workstation>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 30, 2024 at 02:45:03PM +0800, Lai, Yi wrote:
> Hi Ming,
> 
> Greetings!
> 
> I used Syzkaller and found that there is possible deadlock in __submit_bio in linux-next next-20241029.
> 
> After bisection and the first bad commit is:
> "
> f1be1788a32e block: model freeze & enter queue as lock for supporting lockdep
> "
> 
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241029_183511___submit_bio/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241029_183511___submit_bio/bzImage_6fb2fa9805c501d9ade047fc511961f3273cdcb5
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/241029_183511___submit_bio/6fb2fa9805c501d9ade047fc511961f3273cdcb5_dmesg.log
> 
> "
> [   22.219103] 6.12.0-rc5-next-20241029-6fb2fa9805c5 #1 Not tainted
> [   22.219512] ------------------------------------------------------
> [   22.219827] repro/735 is trying to acquire lock:
> [   22.220066] ffff888010f1a768 (&q->q_usage_counter(io)#25){++++}-{0:0}, at: __submit_bio+0x39f/0x550
> [   22.220568] 
> [   22.220568] but task is already holding lock:
> [   22.220884] ffffffff872322a0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x76b/0x21e0
> [   22.221453] 
> [   22.221453] which lock already depends on the new lock.
> [   22.221453] 
> [   22.221862] 
> [   22.221862] the existing dependency chain (in reverse order) is:
> [   22.222247] 
> [   22.222247] -> #1 (fs_reclaim){+.+.}-{0:0}:
> [   22.222630]        lock_acquire+0x80/0xb0
> [   22.222920]        fs_reclaim_acquire+0x116/0x160
> [   22.223244]        __kmalloc_cache_node_noprof+0x59/0x470
> [   22.223528]        blk_mq_init_tags+0x79/0x1a0
> [   22.223771]        blk_mq_alloc_map_and_rqs+0x1f4/0xdd0
> [   22.224127]        blk_mq_init_sched+0x33d/0x6d0
> [   22.224376]        elevator_init_mq+0x2b2/0x400

It should be addressed by the following patch:

https://lore.kernel.org/linux-block/ZyEGLdg744U_xBjp@fedora/

Thanks,
Ming


