Return-Path: <linux-kernel+bounces-328925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227E978ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DBC1C22EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1B1149C41;
	Fri, 13 Sep 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2N2hvJQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE062B9D2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726264003; cv=none; b=HdhCapl1+QJ4y8q/FVecpYwLKqHE3GbiA5v7Hb6TNcbCJgiPsMh1WDjJzQdVdxJ8P8FMwW+a03qD/v3K8WVrb/1CqnpYpjlObBiKhTcTOhucLUcGJ7gfZTDKD99qNx/TvE3+p48+XU6onlom6/VHYEWGF28zxo35ChI0XKWx6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726264003; c=relaxed/simple;
	bh=NRV+0ixBQxnrUIlapYeV9lT77jBqv2DyRM2xA9tpcpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBUmIZ8saIgSAiQ9vPMtlIA3N+Nv9Hmrnhp+tdJAb3arzf8bXEKIGFR6MH9nRDoRXx2oO3S74YJxPo5UiX0edqHkFAq21J7D/NbLYJtqruL7QdB6gYUUnXGIcMeSVrPcxfMMU1dNCQDYvEUk/LtxQzq8LdtAxocsDIAtwI+Z2AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2N2hvJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9CFC4CEC0;
	Fri, 13 Sep 2024 21:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726264003;
	bh=NRV+0ixBQxnrUIlapYeV9lT77jBqv2DyRM2xA9tpcpo=;
	h=From:To:Cc:Subject:Date:From;
	b=a2N2hvJQ9t0VtFCIs5S1Upng1zO4hFCtjTkfzlGszP5pf2Kymbq9ekujoCac7nV+K
	 vOiw1FzdZCbd/5P2ktipqNIIyNiJmljN1ZsSQZOYZN29GG9AGPqCEJMdvn9fInDNmz
	 KNoDvqAq0JzK2LP+0l8JIzJJxZQfFoW0nF1No/LJEVSnKiBkhEJ89pU6c8Rb1JPNGJ
	 /84K0tFym7FI9zlQGAPqYC8n80ngoJfLqmdZVuHuF7omEehepn7oUiuWEiS/pA14n1
	 S1F/CaSuLs0dpEcFjGrVEEpyPMKAER8IcoQEcnrEc3z2sZYMVy0PHM0etBwVNQqzk3
	 QzwKU8XHPbStQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Hillf Danton <hdanton@sina.com>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Subject: [PATCH] kthread: Unpark only parked kthread
Date: Fri, 13 Sep 2024 23:46:34 +0200
Message-ID: <20240913214634.12557-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Reported-and-tested-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
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


