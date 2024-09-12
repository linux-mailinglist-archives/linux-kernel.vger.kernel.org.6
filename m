Return-Path: <linux-kernel+bounces-326404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E69767ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1412B1F21422
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3304118A6A9;
	Thu, 12 Sep 2024 11:31:57 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4513BAE7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140716; cv=none; b=UTZd7w3bN6doaeIlSWONHOgPbGF9GDKmOSrH+6weY2MbXEjAm/r2/gaDQH+DJMyMq9mUwQb07DtSNeZ9MtZGgMY6KgneA3u4nccZ0lTkCz0AlydhB5KbXEmdRndzLrbbdgSETbd+ETPn5HjDpyqIQHlbaZqaXwGYMoqSIs/2JqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140716; c=relaxed/simple;
	bh=0Q13zq5UXTRsC1+YTOapYEFcLTxXJGvGI8fyA/Nebrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SaovW8AhmghT7TfSE0FBHlocQ3xf+6Ct7ct4j3w8c5mqFPQBMThpUq25MaVIlidggTgvSsTxwR5wImr4pPFsijE3IL83A0BHFoLiD8M29t+4Dszam8QCkbSLuq540AD2nJPx4zxO06L0aMMwSpvyPWBnQj1w1Tcw3EqXV8W1xmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.190])
	by sina.com (10.185.250.24) with ESMTP
	id 66E2D0F500004B0B; Thu, 12 Sep 2024 19:31:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5561210748402
X-SMAIL-UIID: D3B2DA85485B4ACAB836028454744649-20240912-193104-1
From: Hillf Danton <hdanton@sina.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] kthread: Unpark only parked kthreads (was Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2))
Date: Thu, 12 Sep 2024 19:30:52 +0800
Message-Id: <20240912113052.2904-1-hdanton@sina.com>
In-Reply-To: <ZuGHTBfUlB0qlgn4@localhost.localdomain>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 11 Sep 2024 14:04:28 +0200 Frederic Weisbecker <frederic@kernel.org>
> 
> Can you test the following?
> ---

One line is needed to feed syzbot including four parts, see below for an example
	two keywords 	tree  		tag or commit
	syz test	upstream	master

> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Tue, 10 Sep 2024 22:10:19 +0200
> Subject: [PATCH] kthread: Unpark only parked kthreads
> 
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
> Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
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


#syz test upstream master

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -623,6 +623,8 @@ void kthread_unpark(struct task_struct *
 {
 	struct kthread *kthread = to_kthread(k);
 
+	if (!test_bit(KTHREAD_SHOULD_PARK, &kthread->flags))
+		return;
 	/*
 	 * Newly created kthread was parked when the CPU was offline.
 	 * The binding was lost and we need to set it again.
--

