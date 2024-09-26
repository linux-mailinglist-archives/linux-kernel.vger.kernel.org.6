Return-Path: <linux-kernel+bounces-340423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B95498733C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B33E1C24BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C72B1714CC;
	Thu, 26 Sep 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbbmnWO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29314F10E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352429; cv=none; b=F3vYjOg3IzmMr6IexCsU06Gi+DPhjxJZRUhTrnoocRO/ZLcgQ56WBPkChd73GP9w04tvGViYADz1r4zeTQNrRKh17sl5Uo3pLvH2KnwsRN9ZOogG4olKXZRNHbTpSWP5lFfcGnILabdMSpI/1lHluTKVsY8LIDF41kTvwLdoByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352429; c=relaxed/simple;
	bh=5Xv0CHe9cZFQj3XnHPKJAwA0oKrXCrWvJZ6HeBE69JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIuZlvCy+GgJr9F8Z5wTgSZH1KlV3uBKVIpIhdCFl/6hAkjfYm8EXOKYwCDXzfTMd/P2viLdKQxPNUwl0k4ZMIu2Pn1xWHTaLx+dmvV9jN7jxd2ZV9P8oZXHvRtOlSm+g1Og32n28xcMOiF7arkB8sOnu/GK8nnZqUprBg8hel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbbmnWO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3F3C4CEC5;
	Thu, 26 Sep 2024 12:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727352429;
	bh=5Xv0CHe9cZFQj3XnHPKJAwA0oKrXCrWvJZ6HeBE69JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbbmnWO6SHfooL8lKl5OJihJ7ooMWSRppzaoUgreCQzQmuaum7NZwKaAjsA3YPJ5r
	 NwzTieDRODZsqDa6h9Lm03xnvYuwWuAqf4A+6j8nqWsxdS33w+ZCuKquavWOWSIe2j
	 oqWk6tym8BoS2fskVVA4U/4m856vCvSAgN0X7Omxn6SM/XaBX20gVaeIdbmIV+/1Cj
	 bgVRN9hPRQw+Jx2z51m/LOwWhQ2GoO8wdMRG+IGdmrGzKmnuvPmva0JwdnDhCEAI9L
	 VGb9+KGb1xITwJWqB+GpFvL/Q3+FFbB/tJ7yiRgFU6LWYJsTKPWIhBWOZfadvZEQ+H
	 2W3FMt3GWsRbQ==
Date: Thu, 26 Sep 2024 14:07:06 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hillf Danton <hdanton@sina.com>,
	Tejun Heo <tj@kernel.org>,
	syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Subject: Re: [PATCH] kthread: Unpark only parked kthread
Message-ID: <ZvVOaljXvQeUF-Fw@localhost.localdomain>
References: <20240913214634.12557-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913214634.12557-1-frederic@kernel.org>

Gentle Ping?

Le Fri, Sep 13, 2024 at 11:46:34PM +0200, Frederic Weisbecker a écrit :
> Calling into kthread unparking unconditionally is mostly harmless when
> the kthread is already unparked. The wake up is then simply ignored
> because the target is not in TASK_PARKED state.
> 
> However if the kthread is per CPU, the wake up is preceded by a call
> to kthread_bind() which expects the task to be inactive and in
> TASK_PARKED state, which obviously isn't the case if it is unparked.
> 
> As a result, calling kthread_stop() on an unparked per-cpu kthread
> triggers such a warning:
> 
> 	WARNING: CPU: 0 PID: 11 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525
> 	 <TASK>
> 	 kthread_stop+0x17a/0x630 kernel/kthread.c:707
> 	 destroy_workqueue+0x136/0xc40 kernel/workqueue.c:5810
> 	 wg_destruct+0x1e2/0x2e0 drivers/net/wireguard/device.c:257
> 	 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10693
> 	 default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11769
> 	 ops_exit_list net/core/net_namespace.c:178 [inline]
> 	 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
> 	 process_one_work kernel/workqueue.c:3231 [inline]
> 	 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
> 	 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
> 	 kthread+0x2f0/0x390 kernel/kthread.c:389
> 	 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> 	 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 	 </TASK>
> 
> Fix this with skipping unecessary unparking while stopping a kthread.
> 
> Reported-and-tested-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/kthread.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index f7be976ff88a..5e2ba556aba8 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -623,6 +623,8 @@ void kthread_unpark(struct task_struct *k)
>  {
>  	struct kthread *kthread = to_kthread(k);
>  
> +	if (!test_bit(KTHREAD_SHOULD_PARK, &kthread->flags))
> +		return;
>  	/*
>  	 * Newly created kthread was parked when the CPU was offline.
>  	 * The binding was lost and we need to set it again.
> -- 
> 2.46.0
> 

