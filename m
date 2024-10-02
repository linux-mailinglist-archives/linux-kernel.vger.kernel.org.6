Return-Path: <linux-kernel+bounces-347679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CD298DA52
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8EB28218B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB941D0BBE;
	Wed,  2 Oct 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUNZH1iQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E71D0434
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878508; cv=none; b=Q8BiF13mk4EHFVdbf0aq9RFQYtdn0cdXLqH6EcooLRDz8FSBIWMB5OiTKAlUnLKxXQ8kkg10LVru6KcT5T5xde1eWVFmpthgs4AXOfSV8to/XeVa72sTc7dsWZLfG/XyB1sbT3GPlpldruim1afber7w8/TIP7NxUua1O4HBeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878508; c=relaxed/simple;
	bh=5c6CzrRmIZzi6AssPCOjh+tRfUfHUxh80sJSkK9Dm0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta6NSUWQQHpN1gxTb4KTBRHx0+stZU1PMhkrQDMkmtz44GlOeKRDHKYg81giZ0GU/aMxmf+1GLfNBy0tjavrdy+p0S96V+vDW8fYiT7nfPkSBFj2LQ7P+2CUJhfQnJN104sruUaNr8981VQMW0kEml1v2LOGx4psoFv35qKhM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUNZH1iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D0EC4CEC2;
	Wed,  2 Oct 2024 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727878508;
	bh=5c6CzrRmIZzi6AssPCOjh+tRfUfHUxh80sJSkK9Dm0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUNZH1iQFWUOdXn7vk27Nqf8FxVEy+lciqd/J4aOKW2Wemcu2mwWhvQO55UUqFJi2
	 mtLWmtTiDSnZzs/GHJplskRe4DQ8uJn9YZG4GTpdbPpXyuwhj72I2RjUF66iA6RexG
	 XDvSgKsl5nEgvtzqOpGklVvMFEkT3dQH0ca89gBCeAl54CEKWpWPtFbkbNPsomAL0j
	 0snSwPWn+7SzTLmmgmpx5rV98GdVjE9+FARXhrR79nz9AdSRdFueTmaac7e/GN80KX
	 5E+T1QTugpqwQ1AhljV3554LzfLoQ40bYACQ+sshCoCF9EtDR+7QZdwVbpCkV2QLpC
	 6qUlqrDwIBpVg==
Date: Wed, 2 Oct 2024 16:15:05 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>,
	syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Subject: Re: [PATCH] kthread: Unpark only parked kthread
Message-ID: <Zv1VadXrQVwqDWE9@localhost.localdomain>
References: <20240913214634.12557-1-frederic@kernel.org>
 <20240926132130.b1d1f6943d225368d3062d5e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240926132130.b1d1f6943d225368d3062d5e@linux-foundation.org>

Le Thu, Sep 26, 2024 at 01:21:30PM -0700, Andrew Morton a écrit :
> On Fri, 13 Sep 2024 23:46:34 +0200 Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > Calling into kthread unparking unconditionally is mostly harmless when
> > the kthread is already unparked. The wake up is then simply ignored
> > because the target is not in TASK_PARKED state.
> > 
> > However if the kthread is per CPU, the wake up is preceded by a call
> > to kthread_bind() which expects the task to be inactive and in
> > TASK_PARKED state, which obviously isn't the case if it is unparked.
> > 
> > As a result, calling kthread_stop() on an unparked per-cpu kthread
> > triggers such a warning:
> > 
> > 	WARNING: CPU: 0 PID: 11 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525
> > 	 <TASK>
> > 	 kthread_stop+0x17a/0x630 kernel/kthread.c:707
> > 	 destroy_workqueue+0x136/0xc40 kernel/workqueue.c:5810
> > 	 wg_destruct+0x1e2/0x2e0 drivers/net/wireguard/device.c:257
> > 	 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10693
> > 	 default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11769
> > 	 ops_exit_list net/core/net_namespace.c:178 [inline]
> > 	 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
> > 	 process_one_work kernel/workqueue.c:3231 [inline]
> > 	 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
> > 	 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
> > 	 kthread+0x2f0/0x390 kernel/kthread.c:389
> > 	 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > 	 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > 	 </TASK>
> > 
> > Fix this with skipping unecessary unparking while stopping a kthread.
> 
> How does userspace trigger this?  Is it an issue in current mainline?

I guess it takes some module unload performing a destroy workqueue to
trigger this. And it's an issue in current mainline.

> 
> Should we backport the fix into -stable kernels (depends on the answers
> to the above questions).
> 
> It looks like the issue is old, so a Fixes: probably isn't needed.  But
> as the issue is old, why did it come to light now?

It's hard to tell. The core of the issue is there for a long while but
the conditions for it to really happen in practice is probably since:

    5c25b5ff89f0 (workqueue: Tag bound workers with KTHREAD_IS_PER_CPU)

So it might deserve a Fixes: actually.

Thanks.

