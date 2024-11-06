Return-Path: <linux-kernel+bounces-397594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C2B9BDDCA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C63284FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1DA19148A;
	Wed,  6 Nov 2024 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0Is3a7u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20D3F9D2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730864902; cv=none; b=F2tZywFbZyaQ7NHtuaBwux4fVwoeHUu4SdVMk9/Jmo0w8g7mw/PmbJfpNjCPuekZIdnpKgDn3OvfgjTKvfZXUX3UsyjFX72kSCpT/tqXbGPwb8tx12ciT3GTKcy7BbH34DEWzLYqhOnJAv4B0iqQbrzB+Xe/xq0EWOQqcCuIRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730864902; c=relaxed/simple;
	bh=cOdY+EdKttLHZNHuNF7OKCg2ywpQnGvoGmKCJHKXHQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy1w8tQjHHaCCiX+qe+fqWR+ogn+7B4m/33g9jEGd8ooILbeiT688fjjlZr2K+5H50Yed89jcxeXEK8/Q7mkSB8DniJoG9OGd6sZ+1DTfhDtoDc4r6RByxvL3Zqx0jBZlcCR1PmxYA5FN0C+6gnycSTJNfz5daMh/SHqXnB9lm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0Is3a7u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730864899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=owEzSbX7QOgRoB0yw5RkcuD2LOOAbZTXHyrnqMS0rJo=;
	b=Q0Is3a7uJY2mYl6Im+hwmHAXwWVQZ2m2NDpLW5EMHgpXyxCePLUo7VzVTQ08It7y5F5GHH
	TWSBZyX5Mri7kv6Wy+miGqdEQyI2je2Uvsm0toe65Vmt3DBaNkHOURn86c+aNyW8QniKa9
	bneGXYmbYw3GmQsQsKmNEQtXQUeTp1U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-qGJJv-S2O3eo-NezkuVt2w-1; Tue,
 05 Nov 2024 22:48:14 -0500
X-MC-Unique: qGJJv-S2O3eo-NezkuVt2w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 464001956089;
	Wed,  6 Nov 2024 03:48:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 325CB1955F40;
	Wed,  6 Nov 2024 03:48:07 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:48:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: syzbot <syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_alloc_request
Message-ID: <Zyrm8uw204eZW9wF@fedora>
References: <672ad716.050a0220.2a847.1a9e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672ad716.050a0220.2a847.1a9e.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Nov 05, 2024 at 06:40:22PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e59aa7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
> dashboard link: https://syzkaller.appspot.com/bug?extid=ca7d7c797fee31d2b474
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1250b630580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/760a8c88d0c3/disk-c88416ba.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/46e4b0a851a2/vmlinux-c88416ba.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/428e2c784b75/bzImage-c88416ba.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.12.0-rc5-next-20241101-syzkaller #0 Not tainted
> --------------------------------------------
> udevd/6086 is trying to acquire lock:
> ffff8880288261c0 (&q->q_usage_counter(queue)#67){++++}-{0:0}, at: blk_mq_alloc_request+0x26b/0xab0 block/blk-mq.c:626
> 
> but task is already holding lock:
> ffff8880288261c0 (&q->q_usage_counter(queue)#67){++++}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
> ffff8880288261c0 (&q->q_usage_counter(queue)#67){++++}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&q->q_usage_counter(queue)#67);
>   lock(&q->q_usage_counter(queue)#67);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by udevd/6086:
>  #0: ffff888034a534c8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf0/0xc50 block/bdev.c:904
>  #1: ffff888028826188 (&q->q_usage_counter(io)#81){+.+.}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
>  #1: ffff888028826188 (&q->q_usage_counter(io)#81){+.+.}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187
>  #2: ffff8880288261c0 (&q->q_usage_counter(queue)#67){++++}-{0:0}, at: blk_freeze_queue block/blk-mq.c:177 [inline]
>  #2: ffff8880288261c0 (&q->q_usage_counter(queue)#67){++++}-{0:0}, at: blk_mq_freeze_queue+0x15/0x20 block/blk-mq.c:187

Not get idea how blk_mq_freeze_queue is called in this context.

Is the blk_mq_unfreeze_queue() in sd_revalidate_disk() not released?

Anyway, please test the not-merged fixes.

#syz test: https://github.com/ming1/linux.git for-next


Thanks, 
Ming


