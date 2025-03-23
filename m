Return-Path: <linux-kernel+bounces-572735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCDAA6CDE2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 06:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2EC7A509C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 05:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A91EBFE2;
	Sun, 23 Mar 2025 05:08:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21220102B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742706535; cv=none; b=EbhN6qsiI0bMKQEPZKYQxpRiByH7UDgQRY6LGgGgKIRw9AancuYTzlSM5vfmTwFuO1EG1+lTcdcDLago5vXJmQUF6S17rQtkD1+4bCvwQw6MsKu5AbawamoryGdY6wOEdNeIEAcyoU3Rj3roNnd8HCPs3mM6RuWCqz1LI3fXWLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742706535; c=relaxed/simple;
	bh=+s7BMcybeVwmnT3dHMb0ZKh1i0RPHR00Npbn+PrAVlM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UTMJN2iN39OtYYQ6ooLQ/CG2wmSkfW7gEQh0q6k7B+EJ5nx9yBtXhvFfEhH/lleOW4wnoz0UCw/58vpQzGAaii6KNWzJ3WMt5ngtl0M3j1ISlwYveB5qi0sbz2zwpsJpBTK3I7XY6zQjPTAvRr2HmeWB8zN46GRdGRf98FDtToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3417EC4CEEF;
	Sun, 23 Mar 2025 05:08:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twDaX-00000001x06-38qj;
	Sun, 23 Mar 2025 01:09:33 -0400
Message-ID: <20250323050933.602569205@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 01:09:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [for-next][PATCH 2/4] tracing: Initialize scratch_size to zero to prevent UB
References: <20250323050914.459621318@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In allocate_trace_buffer() the following code:

  buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
				      tr->range_addr_start,
				      tr->range_addr_size,
				      struct_size(tscratch, entries, 128));

  tscratch = ring_buffer_meta_scratch(buf->buffer, &scratch_size);
  setup_trace_scratch(tr, tscratch, scratch_size);

Has undefined behavior if ring_buffer_alloc_range() fails because
"scratch_size" is not initialize. If the allocation fails, then
buf->buffer will be NULL. The ring_buffer_meta_scratch() will return
NULL immediately if it is passed a NULL buffer and it will not update
scratch_size. Then setup_trace_scratch() will return immediately if
tscratch is NULL.

Although there's no real issue here, but it is considered undefined
behavior to pass an uninitialized variable to a function as input, and
UBSan may complain about it.

Just initialize scratch_size to zero to make the code defined behavior and
a little more robust.

Link: https://lore.kernel.org/all/44c5deaa-b094-4852-90f9-52f3fb10e67a@stanley.mountain/

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 68abea81e51a..be97465485b3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9394,7 +9394,7 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 {
 	enum ring_buffer_flags rb_flags;
 	struct trace_scratch *tscratch;
-	unsigned int scratch_size;
+	unsigned int scratch_size = 0;
 
 	rb_flags = tr->trace_flags & TRACE_ITER_OVERWRITE ? RB_FL_OVERWRITE : 0;
 
-- 
2.47.2



