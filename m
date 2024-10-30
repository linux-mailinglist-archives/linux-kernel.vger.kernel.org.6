Return-Path: <linux-kernel+bounces-387941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4939B5836
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D4E1C22B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23461FDD;
	Wed, 30 Oct 2024 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b36o4e5v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E385A41
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246833; cv=none; b=oZNYrThYzMQfRY24zFVp+1CkAkiq3sdfPhsxwNHm6qs3JjttkjrwVHzJPTF26Tt6k1eNn+Adv+4wdOKowzzXNxRt9wTevCTuuHQjCn5H2/1EmcQxtybYxmFO3Gkf3/U1RjfVg8k+4eGadDb2xi7JSvYoJ5QHp/bynLa9eCdzHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246833; c=relaxed/simple;
	bh=W0Q8oy+uE6LFTuwBobrrjFcWcYm1au6UP3Gpe20Go3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NrPEsMPFcLW4t4Jmrs0jryswWQXZnYgugvOZYo6Yl5M/IJf2LXX0HWYWJnZEJTNlVkoi8cXAp6YD3OqkG0vXVRBHdR/3h+y+09R+2ZLObFEpgfyGHoJsOj40G6YzSkvNub/HWDUbdmRhNjqUo8uij85vrqszh8VfG+j2ju8qUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b36o4e5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C60C4CEE3;
	Wed, 30 Oct 2024 00:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730246832;
	bh=W0Q8oy+uE6LFTuwBobrrjFcWcYm1au6UP3Gpe20Go3g=;
	h=Date:From:To:Cc:Subject:From;
	b=b36o4e5vIadgZoA/cSsuDTDHx5mTcpoCAID2/rnHvYs7XYhTMIYDobHwWnX+LEHWG
	 7Z2hbe7KCalqaF7n9nc2OxGUy8jesEEmO1yP01KGjLefznUpoM1VtS2J4jqZAEAq5p
	 NcKiciscRdjAIeyR1E+bmZi3I/ExQL400ec1oe8v1STnG+YpnOlt+w9ty9N0WVoP1I
	 BRE00gLEw5PnhAgxuJNQyTQGBEb58kAL+FyciYQV2EnVyOOfP2+11iiaKhCfFnL6eh
	 0RzcKKKScu7Gi8ypBabLi+0ibUP7KWPiP501u8GCWQ73CFNkZq8gDCkr4xCb1oX1Fq
	 YmEQJMvjhozhw==
Date: Tue, 29 Oct 2024 14:07:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	sched-ext@meta.com
Subject: [RFC PATCH sched/urgent] sched: Task still delay-dequeued after
 switched from fair
Message-ID: <ZyF4rw_nvfpHfouv@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On the current tip/sched/urgent, the following can be easily triggered by
running `tools/testing/selftests/sched_ext/runner -t reload_loop`:

  p->se.sched_delayed
  WARNING: CPU: 0 PID: 1686 at kernel/sched/fair.c:13191 switched_to_fair+0x7a/0x80
  ...
  Sched_ext: maximal (disabling)
  RIP: 0010:switched_to_fair+0x7a/0x80
  Code: a6 fe ff 5b 41 5e c3 cc cc cc cc cc 4c 89 f7 5b 41 5e e9 49 7f fe ff c6 05 53 c0 80 02 01 48 c7 c7 27 4a e6 82 e8 c6 8f fa ff <0f> 0b eb a2 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
  RSP: 0018:ffffc90001253d40 EFLAGS: 00010086
  RAX: 0000000000000013 RBX: ffff888103a6d380 RCX: 0000000000000027
  RDX: 0000000000000002 RSI: 00000000ffffdfff RDI: ffff888237c1b448
  RBP: 0000000000030380 R08: 0000000000001fff R09: ffffffff8368e000
  R10: 0000000000005ffd R11: 0000000000000004 R12: ffffc90001253d58
  R13: ffffffff82eda0c0 R14: ffff888237db0380 R15: ffff888103a6d380
  FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fa289417000 CR3: 0000000003e58000 CR4: 0000000000750eb0
  PKRU: 55555554
  Call Trace:
   <TASK>
   scx_ops_disable_workfn+0x71b/0x930
   kthread_worker_fn+0x105/0x2a0
   kthread+0xe8/0x110
   ret_from_fork+0x33/0x40
   ret_from_fork_asm+0x1a/0x30
   </TASK>

The problem is that when tasks are switched from fair to ext, it can remain
delay-dequeued triggering the above warning when the task goes back to fair.
I can work around with the following patch but it doesn't seem like the
right way to handle it. Shouldn't e.g. fair->switched_from() cancel delayed
dequeue?

Thanks.

---
 kernel/sched/ext.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 65334c13ffa5..601aad1a2625 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5205,8 +5205,12 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
 		struct sched_enq_and_set_ctx ctx;
+		int deq_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 
-		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
+		if (p->se.sched_delayed)
+			deq_flags |= DEQUEUE_SLEEP | DEQUEUE_DELAYED;
+
+		sched_deq_and_put_task(p, deq_flags, &ctx);
 
 		p->scx.slice = SCX_SLICE_DFL;
 		p->sched_class = __setscheduler_class(p->policy, p->prio);

