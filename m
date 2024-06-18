Return-Path: <linux-kernel+bounces-220143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9563890DD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5821F2247A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B216F0EB;
	Tue, 18 Jun 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8Af43Vq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760417625B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742017; cv=none; b=tfouuoWGYhju5gQvp3e96SV4crZbh800MLyJctNCttInpJPbi9EXcx+sKj+YWN2a7dY62aqQt3KnKG7iaAfxOoOyXD3/Go38cSdtrev/aVTdo7lRPBh/Ru4rh6lJ/osR1WLUyGk6UcJIYTeVroqdHmFrHkp5Rh9XpCGU81095Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742017; c=relaxed/simple;
	bh=JJgUrXpcAhAJI8K7hE8Nyifer/j3vPzwSf9NPTdPnx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFZQ2uo5oJ945Sxga7jV+IyclTv5WZF44Dnz2K3PRm7be74Mhs4dhskPsuzoCiPNB9i7Bc2gWjVj//KH2s3BsAVd+TvzjYm9K4v2QfzLqaUcWU6yqLdBj8jJwkLLBq9AyUtfHNjEOSLAQ9vBFc9ScB/A1VbKGOmd+HfrKj8zi8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8Af43Vq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718742014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pWagbOy3Dug1A8KU6tJo7JX4+oGGm8zUoClQdGRis5w=;
	b=g8Af43VqggDha1wxYMKStaqhAKROANt7p3omPcZbDRQ1TLKtDZJWgU5ZcTMWL+otCOc7qZ
	wOeFd28Hikk3ysi0SFF8bW6jqdJz8VJP5JJ+VlWZDPQsufKzhl3BMCk9ojF1kQMeqb6Lhv
	vbC1b3lndCuulldl2GUg/RhfmYjweSE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-C6sZAUC2N7yQgBhcYt64-Q-1; Tue,
 18 Jun 2024 16:20:10 -0400
X-MC-Unique: C6sZAUC2N7yQgBhcYt64-Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAFAF19560B2;
	Tue, 18 Jun 2024 20:20:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.193])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E1B319560B0;
	Tue, 18 Jun 2024 20:20:02 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: rrendec@redhat.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] sched/deadline: fix task_struct reference leak
Date: Tue, 18 Jun 2024 17:19:40 -0300
Message-ID: <20240618201940.94955-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

During the execution of the following stress test with linux-rt:

stress-ng --cyclic 30 --timeout 30 --minimize --quiet

kmemleak frequently reported a memory leak concerning the task_struct:

unreferenced object 0xffff8881305b8000 (size 16136):
  comm "stress-ng", pid 614, jiffies 4294883961 (age 286.412s)
  object hex dump (first 32 bytes):
    02 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .@..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  debug hex dump (first 16 bytes):
    53 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00  S...............
  backtrace:
    [<00000000046b6790>] dup_task_struct+0x30/0x540
    [<00000000c5ca0f0b>] copy_process+0x3d9/0x50e0
    [<00000000ced59777>] kernel_clone+0xb0/0x770
    [<00000000a50befdc>] __do_sys_clone+0xb6/0xf0
    [<000000001dbf2008>] do_syscall_64+0x5d/0xf0
    [<00000000552900ff>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

The issue occurs in start_dl_timer(), which increments the task_struct
reference count and sets a timer. The timer callback, dl_task_timer,
is supposed to decrement the reference count upon expiration. However,
if enqueue_task_dl() is called before the timer expires and cancels it,
the reference count is not decremented, leading to the leak.

This patch fixes the reference leak by ensuring the task_struct
reference count is properly decremented when the timer is canceled.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/sched/deadline.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c75d1307d86d..5953f89bfa96 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1805,7 +1805,9 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 			 * problem if it fires concurrently: boosted threads
 			 * are ignored in dl_task_timer().
 			 */
-			hrtimer_try_to_cancel(&p->dl.dl_timer);
+			if (hrtimer_try_to_cancel(&p->dl.dl_timer) == 1 &&
+			    !dl_server(&p->dl))
+				put_task_struct(p);
 			p->dl.dl_throttled = 0;
 		}
 	} else if (!dl_prio(p->normal_prio)) {
-- 
2.45.1


