Return-Path: <linux-kernel+bounces-359439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5545998CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8390B2B3ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC831CC89F;
	Thu, 10 Oct 2024 15:26:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474C20DD2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573990; cv=none; b=AKkSWbHo4w+Xd0Hxxa5K1lHxetts/8FdsxlO7ZNmavLBrHWP+Qas76mhSa9D+xRQhS+JPQmuLU0UPF0kKBRh4rFgQUSZfkatdfq3HK1Cy4wJ4hFDBVg2X5jGi2Rktv8QwHJEGtEcPy5qRVxqgOedAcNmjthZ1mtaPeJUMMtlLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573990; c=relaxed/simple;
	bh=C7fnmqYuyPcKiC0cx+MQftXbhZSbo6ITjLwu2xXkE+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WGcPiJ+qnJ51xEL0voIg42BBMKDCttso50DOB3/OM5fsiMpbVEUUCJ1aUEAXGDELoTihj0JGvcNvT3dTEIYmp8SEMPxxQC77zkVdeP5O93l+1JRWj4byaLR4gr/D+eoO9h8PZauv4Jj/FC3SurhZODzvfapcS9RQWZJxVRuyjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E105C4CEC5;
	Thu, 10 Oct 2024 15:26:29 +0000 (UTC)
Date: Thu, 10 Oct 2024 11:26:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] ring-buffer: Fix for 6.12
Message-ID: <20241010112636.2dba6885@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

ring-buffer: Fix for 6.12

- Do not have boot-mapped buffers use CPU hotplug callbacks

  When a ring buffer is mapped to memory assigned at boot, it
  also splits it up evenly between the possible CPUs. But the
  allocation code still attached a CPU notifier callback to this
  ring buffer. When a CPU is added, the callback will happen and
  another per-cpu buffer is created for the ring buffer. But for
  boot mapped buffers, there is no room to add another one (as
  they were all created already). The result of calling the CPU
  hotplug notifier on a boot mapped ring buffer is unpredictable
  and could lead to a system crash. If the ring buffer is boot mapped
  simply do not attach the CPU notifier to it.


Please pull the latest trace-ringbuffer-v6.12-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-ringbuffer-v6.12-rc2

Tag SHA1: 55a5da35c9d43dd15b85d53eeac414b92d70518d
Head SHA1: 912da2c384d510ce40c5af9c3adc316afa4ec547


Steven Rostedt (1):
      ring-buffer: Do not have boot mapped buffers hook to CPU hotplug

----
 kernel/trace/ring_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)
---------------------------
commit 912da2c384d510ce40c5af9c3adc316afa4ec547
Author: Steven Rostedt <rostedt@goodmis.org>
Date:   Tue Oct 8 14:32:42 2024 -0400

    ring-buffer: Do not have boot mapped buffers hook to CPU hotplug
    
    The boot mapped ring buffer has its buffer mapped at a fixed location
    found at boot up. It is not dynamic. It cannot grow or be expanded when
    new CPUs come online.
    
    Do not hook fixed memory mapped ring buffers to the CPU hotplug callback,
    otherwise it can cause a crash when it tries to add the buffer to the
    memory that is already fully occupied.
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Link: https://lore.kernel.org/20241008143242.25e20801@gandalf.local.home
    Fixes: be68d63a139bd ("ring-buffer: Add ring_buffer_alloc_range()")
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 77dc0b25140e..fb04445f92c3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2337,9 +2337,12 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	if (!buffer->buffers[cpu])
 		goto fail_free_buffers;
 
-	ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
-	if (ret < 0)
-		goto fail_free_buffers;
+	/* If already mapped, do not hook to CPU hotplug */
+	if (!start) {
+		ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
+		if (ret < 0)
+			goto fail_free_buffers;
+	}
 
 	mutex_init(&buffer->mutex);
 

