Return-Path: <linux-kernel+bounces-409496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D2C9C8D93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92681F24CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE44139CFF;
	Thu, 14 Nov 2024 15:07:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD0288DA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596827; cv=none; b=NtDLTlrRGncisQZ6j0RvQoINfRHM3+kqRvA4epwVWFvHZstImm3Z7r9sFRJbVFA2VQ0gbhZk6Lh0XEKo6PVpWeqBYP5EX9M1q6urVMX/Jqo3ry3KVPgITc9n494LsYaBZJNZXlwAGqxwPdfzvRIO7a0X4P3Czu+Ms160YDBc1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596827; c=relaxed/simple;
	bh=2O40dNeZW+Yay9cLzFK48EdhWRZWLYTXfspxltLsIFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IP1rIXCh5cteTpNkH0MPAzjchmnplHo9yx9TaUJHR7sfNL69+vmN+5G4VJU+4JrAJA7yTqEKcjoSRkKtzcFPp89cuSOO4j5UvgRkpIstvwmnCszlSpYRufXBqaKxw1b5TeqzjKvklf+ct4w7TQmS36Leu6/dBsKEmviWxhRobDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468ACC4CECD;
	Thu, 14 Nov 2024 15:07:06 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:07:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [for-linus][PATCH] Revert: "ring-buffer: Do not have boot mapped
 buffers hook to CPU hotplug"
Message-ID: <20241114100727.7a518800@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Revert: "ring-buffer: Do not have boot mapped buffers hook to CPU hotplug"

- A crash that happened on cpu hotplug was actually caused by the incorrect
  ref counting that was fixed by commit 2cf9733891a4 ("ring-buffer: Fix
  refcount setting of boot mapped buffers"). The removal of calling cpu
  hotplug callbacks on memory mapped buffers was not an issue even though
  the tests at the time pointed toward it. But in fact, there's a check in
  that code that tests to see if the buffers are already allocated or not,
  and will not allocate them again if they are. Not calling the cpu hotplug
  callbacks ended up not initializing the non boot CPU buffers.

  Simply remove that change.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/fixes

Head SHA1: 580bb355bcae7e9a6606ce9644af09b2a793f1bb


Steven Rostedt (1):
      Revert: "ring-buffer: Do not have boot mapped buffers hook to CPU hotplug"

----
 kernel/trace/ring_buffer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)
---------------------------
commit 580bb355bcae7e9a6606ce9644af09b2a793f1bb
Author: Steven Rostedt <rostedt@goodmis.org>
Date:   Wed Nov 13 23:08:39 2024 -0500

    Revert: "ring-buffer: Do not have boot mapped buffers hook to CPU hotplug"
    
    A crash happened when testing cpu hotplug with respect to the memory
    mapped ring buffers. It was assumed that the hot plug code was adding a
    per CPU buffer that was already created that caused the crash. The real
    problem was due to ref counting and was fixed by commit 2cf9733891a4
    ("ring-buffer: Fix refcount setting of boot mapped buffers").
    
    When a per CPU buffer is created, it will not be created again even with
    CPU hotplug, so the fix to not use CPU hotplug was a red herring. In fact,
    it caused only the boot CPU buffer to be created, leaving the other CPU
    per CPU buffers disabled.
    
    Revert that change as it was not the culprit of the fix it was intended to
    be.
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Link: https://lore.kernel.org/20241113230839.6c03640f@gandalf.local.home
    Fixes: 912da2c384d5 ("ring-buffer: Do not have boot mapped buffers hook to CPU hotplug")
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3ea4f7bb1837..5807116bcd0b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2337,12 +2337,9 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	if (!buffer->buffers[cpu])
 		goto fail_free_buffers;
 
-	/* If already mapped, do not hook to CPU hotplug */
-	if (!start) {
-		ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
-		if (ret < 0)
-			goto fail_free_buffers;
-	}
+	ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
+	if (ret < 0)
+		goto fail_free_buffers;
 
 	mutex_init(&buffer->mutex);
 

