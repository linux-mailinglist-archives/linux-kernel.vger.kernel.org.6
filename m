Return-Path: <linux-kernel+bounces-366130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B189B99F136
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD65287515
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45961D9A5E;
	Tue, 15 Oct 2024 15:31:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC591B395C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006266; cv=none; b=ObqoKXI0Mb6KAtu9/Jlpp9voy+q2XBTkW4eMRGM/Ps2rNYChjRkYEcyu1FZwqbhHrdGW8a8LtbaEax44vS+x1tP36O0k6M8BbegNp8tFWCjwNPd1UMmp2+eO7WNg7KMpEkweU5U0/6KnuwOAE9V7pE6FGiTwZkuqd9dlVwDgGpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006266; c=relaxed/simple;
	bh=JSQyNLBxRPVAXXJ9vx2ZiVSFZk8hmcWcME6zlpWUfNY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=t6PUf5S9yN9uns91sy4jk2+t5LfvYbHnSSST/0siT0heYVoYpG7P4302FBNUqzX9SP/DR49SZqsiLV1IBT7Ld2cbUo00oQ83eR8zWfDLdpoC3vTJSpsOg5znJQRnBAZ2DSVC8bqA8tWHVlK21ZK8ZV/dTstOiBiXRW1XOdvlX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09018C4CEC6;
	Tue, 15 Oct 2024 15:31:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t0jW9-00000002z4B-1yaO;
	Tue, 15 Oct 2024 11:31:25 -0400
Message-ID: <20241015153105.843619901@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 15 Oct 2024 11:31:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] ring-buffer: Fixes for v6.12
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


ring-buffer: Fixes for v6.12

- Fix ref counter of buffers assigned at boot up

  A tracing instance can be created from the kernel command line.
  If it maps to memory, it is considered permanent and should not
  be deleted, or bad things can happen. If it is not mapped to memory,
  then the user is fine to delete it via rmdir from the instances
  directory. But the ref counts assumed 0 was free to remove and
  greater than zero was not. But this was not the case. When an
  instance is created, it should have the reference of 1, and if
  it should not be removed, it must be greater than 1. The boot up
  code set normal instances with a ref count of 0, which could get
  removed if something accessed it and then released it. And memory
  mapped instances had a ref count of 1 which meant it could be deleted,
  and bad things happen. Keep normal instances ref count as 1, and
  set memory mapped instances ref count to 2.

- Protect sub buffer size (order) updates from other modifications

  When a ring buffer is changing the size of its sub-buffers, no other
  operations should be performed on the ring buffer. That includes
  reading it. But the locking only grabbed the buffer->mutex that
  keeps some operations from touching the ring buffer. It also must
  hold the cpu_buffer->reader_lock as well when updates happen as
  other paths use that to do some operations on the ring buffer.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/urgent

Head SHA1: 09661f75e75cb6c1d2d8326a70c311d46729235f


Petr Pavlu (1):
      ring-buffer: Fix reader locking when changing the sub buffer order

Steven Rostedt (1):
      ring-buffer: Fix refcount setting of boot mapped buffers

----
 kernel/trace/ring_buffer.c | 44 ++++++++++++++++++++++++++------------------
 kernel/trace/trace.c       |  6 +++---
 2 files changed, 29 insertions(+), 21 deletions(-)

