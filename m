Return-Path: <linux-kernel+bounces-526090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B72EA3F9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39271891435
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530DD215795;
	Fri, 21 Feb 2025 15:52:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16ED215068
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153143; cv=none; b=jSx90yfdPcIGNq/+fNLH5UVSMSjVsS9kGagSjPi60RQS/LeLfbIFFLX+ni2A9OMmqjxMQ7fPksqAts0/UtI9QUQJTCbyfBDO2O6I8QskU9xXdONZWN7lbOX6ReLzt3OAvItFn6o4Hxb8gLpASmqhhXuXicRbArC8yX37yTpkjHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153143; c=relaxed/simple;
	bh=ExI5ZpYBi/5UTqZaA7Z6ckV9+8IPcCLb6nL/KC20IhE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=D1wnEru1vtWD8ugiCa8VObbak3HlHQzf88AJk/Y6eMIbdl6EbB05maPT1KxNwPVyVw5nZbaMChWpUAm6yvRui+mX2a8Wu53MtsTodlXnCbZcOguErPKg5Xk2k0emRcGLoJxtUbFxdxRu4XCq+7+kQXbdsiaQGm6XE7U1m6QeWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6789BC4CEE7;
	Fri, 21 Feb 2025 15:52:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tlVKe-00000006KUa-3WdE;
	Fri, 21 Feb 2025 10:52:52 -0500
Message-ID: <20250221155252.692026476@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 21 Feb 2025 10:52:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Adrian Huang <ahuang12@lenovo.com>
Subject: [for-linus][PATCH 7/7] tracing: Fix memory leak when reading set_event file
References: <20250221155210.755295517@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Adrian Huang <ahuang12@lenovo.com>

kmemleak reports the following memory leak after reading set_event file:

  # cat /sys/kernel/tracing/set_event

  # cat /sys/kernel/debug/kmemleak
  unreferenced object 0xff110001234449e0 (size 16):
  comm "cat", pid 13645, jiffies 4294981880
  hex dump (first 16 bytes):
    01 00 00 00 00 00 00 00 a8 71 e7 84 ff ff ff ff  .........q......
  backtrace (crc c43abbc):
    __kmalloc_cache_noprof+0x3ca/0x4b0
    s_start+0x72/0x2d0
    seq_read_iter+0x265/0x1080
    seq_read+0x2c9/0x420
    vfs_read+0x166/0xc30
    ksys_read+0xf4/0x1d0
    do_syscall_64+0x79/0x150
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

The issue can be reproduced regardless of whether set_event is empty or
not. Here is an example about the valid content of set_event.

  # cat /sys/kernel/tracing/set_event
  sched:sched_process_fork
  sched:sched_switch
  sched:sched_wakeup
  *:*:mod:trace_events_sample

The root cause is that s_next() returns NULL when nothing is found.
This results in s_stop() attempting to free a NULL pointer because its
parameter is NULL.

Fix the issue by freeing the memory appropriately when s_next() fails
to find anything.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250220031528.7373-1-ahuang12@lenovo.com
Fixes: b355247df104 ("tracing: Cache ":mod:" events for modules not loaded yet")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4cb275316e51..513de9ceb80e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1591,6 +1591,13 @@ s_next(struct seq_file *m, void *v, loff_t *pos)
 		return iter;
 #endif
 
+	/*
+	 * The iter is allocated in s_start() and passed via the 'v'
+	 * parameter. To stop the iterator, NULL must be returned. But
+	 * the return value is what the 'v' parameter in s_stop() receives
+	 * and frees. Free iter here as it will no longer be used.
+	 */
+	kfree(iter);
 	return NULL;
 }
 
@@ -1667,9 +1674,9 @@ static int s_show(struct seq_file *m, void *v)
 }
 #endif
 
-static void s_stop(struct seq_file *m, void *p)
+static void s_stop(struct seq_file *m, void *v)
 {
-	kfree(p);
+	kfree(v);
 	t_stop(m, NULL);
 }
 
-- 
2.47.2



