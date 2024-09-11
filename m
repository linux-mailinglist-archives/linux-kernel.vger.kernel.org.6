Return-Path: <linux-kernel+bounces-324838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4397516A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AE928B6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C7D185B4A;
	Wed, 11 Sep 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbaoNNZy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3351C4A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056272; cv=none; b=qsc23rf4wiaiQjX8sn33zmd42oBwI8vDfxHitrTm6S7GdlLAKXlWBKtd0Ti1oCyBgx0G0JyzdF5ORrhSane7YhO6W09KUBUdJl/3jIeVqaMOG8olWhGMrfx5Ges3tB9ZOi9m8h3IqRbfFGZB0uXrjfjjqarMOmCxU2bKCHESpdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056272; c=relaxed/simple;
	bh=BrvCDT4TB0sx1BI3jg+JNhXoijBqn8lODDE+FwuTf9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS3rj01DA43242M7dy5F2rzcCBEEj7ktacmGSYB4qUACCpHKr73KZlgvoR8Gxo/GYzZSc8Rwqu/0aGKXnfpSiF8+898R/cHS9BqasLSjL/dnudhbxza+9tL6Zo/ZW8fbnSckKopgD8K2HWifvVdc5NYSB6Us/pjddeXg4f5oaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbaoNNZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C134C4CEC5;
	Wed, 11 Sep 2024 12:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726056271;
	bh=BrvCDT4TB0sx1BI3jg+JNhXoijBqn8lODDE+FwuTf9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbaoNNZyc2VDdC4cYHG62nVDHWyogYtH+EwSEp+XXn1QGJ3BZcSHXyHeKKu4pem49
	 sJo3ahp8hFo+mrmW6C9tJC0voh5NBFr/rJgUkGbFWuJJ6DiG0ai8xGtsA44Dtm0oLP
	 6oO+h6PkIrP3pvWf9CpQQ+awSck2Mgi1hSEBMfWBzsBsYbBguMZAOmjnU68co1QZs8
	 lqSSdFIHjzbO7to2uRsySVFfFVYlFl7g9ZnVeDt07BW4EQ6l+UjqluGZgJp4G6rtsy
	 a6ZhKb01EdM04nIggXhXg6NCwUkkfiMtDPwNxmgVJnm7M+ZltBzOes09FIgur1vXTc
	 PpjBlzp/7HSiw==
Date: Wed, 11 Sep 2024 14:04:28 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
Cc: hdanton@sina.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] kthread: Unpark only parked kthreads (was Re: [syzbot]
 [wireguard?] WARNING in kthread_unpark (2))
Message-ID: <ZuGHTBfUlB0qlgn4@localhost.localdomain>
References: <20240731110501.2425-1-hdanton@sina.com>
 <000000000000af4044061e89668a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000000000000af4044061e89668a@google.com>

Le Wed, Jul 31, 2024 at 04:29:02AM -0700, syzbot a écrit :
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
> Tested-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         dc1c8034 minmax: simplify min()/max()/clamp() implemen..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=1264b511980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
> dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fe9911980000
> 
> Note: testing is done by a robot and is best-effort only.
> 

The problem is in the kthread code. kthread_stop() seem to assume that
the target is parked and since kthread_stop() is seldom called on per-cpu
kthreads (smpboot_unregister_percpu_thread() doesn't have any user yet), this
went unnoticed until workqueue happened to do it.

Can you test the following?
---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Tue, 10 Sep 2024 22:10:19 +0200
Subject: [PATCH] kthread: Unpark only parked kthreads

Calling into kthread unparking unconditionally is mostly harmless when
the kthread is already unparked. The wake up is then simply ignored
because the target is not in TASK_PARKED state.

However if the kthread is per CPU, the wake up is preceded by a call
to kthread_bind() which expects the task to be inactive and in
TASK_PARKED state, which obviously isn't the case if it is unparked.

As a result, calling kthread_stop() on an unparked per-cpu kthread
triggers such a warning:

	WARNING: CPU: 0 PID: 11 at kernel/kthread.c:525 __kthread_bind_mask kernel/kthread.c:525
	 <TASK>
	 kthread_stop+0x17a/0x630 kernel/kthread.c:707
	 destroy_workqueue+0x136/0xc40 kernel/workqueue.c:5810
	 wg_destruct+0x1e2/0x2e0 drivers/net/wireguard/device.c:257
	 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10693
	 default_device_exit_batch+0xa14/0xa90 net/core/dev.c:11769
	 ops_exit_list net/core/net_namespace.c:178 [inline]
	 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
	 process_one_work kernel/workqueue.c:3231 [inline]
	 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
	 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
	 kthread+0x2f0/0x390 kernel/kthread.c:389
	 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
	 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
	 </TASK>

Fix this with skipping unecessary unparking while stopping a kthread.

Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f7be976ff88a..5e2ba556aba8 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -623,6 +623,8 @@ void kthread_unpark(struct task_struct *k)
 {
 	struct kthread *kthread = to_kthread(k);
 
+	if (!test_bit(KTHREAD_SHOULD_PARK, &kthread->flags))
+		return;
 	/*
 	 * Newly created kthread was parked when the CPU was offline.
 	 * The binding was lost and we need to set it again.
-- 
2.46.0


