Return-Path: <linux-kernel+bounces-516001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4041A36BD6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A343B1896C2D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5775118A943;
	Sat, 15 Feb 2025 03:52:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C81624E0;
	Sat, 15 Feb 2025 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591569; cv=none; b=leTxK1Gn+UlnmxdgakXUAAELi9L7c+OiXwcijA+DvFGLRLq4HrQLKPI8WT0zcfZbpqIIDd3eXr/mg0xt55MvxYrG1huRVifjHgeB7mDO8q7dHgvnyfJAwJiNRVUiQiijwaytxIhNbLOcd35iG8XxpN2hGf4rhvZoKBPuSjkcrH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591569; c=relaxed/simple;
	bh=gW2hZsCFQxTjSaHx/556S3IDT5o80OmaVZfwNcoiZbw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=unsxxOPcXH8Jtgwfz1CEQd2OhLc+hesRU4L3bcyLIlJgSX2Xp8lbnaHELBkEzGqRK67x52Qkj5afoM7iVB4+yU7VW5C2rGL4LJAVW68sBvctmJaoP9/+5m4KtqJ3/BmxCE6txsCaU7XKb/gnwp6aLMB+BHc0f3iJxTYjFFYYojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606FEC4CEE5;
	Sat, 15 Feb 2025 03:52:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tj9Ek-00000002hE2-1QFs;
	Fri, 14 Feb 2025 22:53:02 -0500
Message-ID: <20250215035302.198095677@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Feb 2025 22:52:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 1/5] ring-buffer: Unlock resize on mmap error
References: <20250215035231.786853904@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Memory mapping the tracing ring buffer will disable resizing the buffer.
But if there's an error in the memory mapping like an invalid parameter,
the function exits out without re-enabling the resizing of the ring
buffer, preventing the ring buffer from being resized after that.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20250213131957.530ec3c5@gandalf.local.home
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b8e0ae15ca5b..07b421115692 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7126,6 +7126,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		kfree(cpu_buffer->subbuf_ids);
 		cpu_buffer->subbuf_ids = NULL;
 		rb_free_meta_page(cpu_buffer);
+		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
 unlock:
-- 
2.47.2



