Return-Path: <linux-kernel+bounces-352075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B38B9919CE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B42282EA4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96AC15A86B;
	Sat,  5 Oct 2024 19:12:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBDA487A5
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728155530; cv=none; b=SHPmuyVyptKwxB5drr/K84W2Vv5Hi9cKY/lskqRlhN4yaa1JmWBP/iHV74fzaTdBJe2p5z5315VKs/TJtHPdDCusvqF9mrMV4yvUF/WgdpPTZdozrWZ2JnG+yJN06hxPmZdFBLzmduBINvOXPjgHoMFs4ws+mw3ky4tBKOYkMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728155530; c=relaxed/simple;
	bh=yBqKFhq6FFnAgqfSZngO0ji8X2Koq7ef3QX869pVTJ8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VSVBvQiGpaaHdA1FozSF5NWk5W0uiFx6FMJVtvA2CAfoFOF6J/DOVBLMebEpr1ULcznZl3rLMSp2NsmdEIqSYwWZhTkGJYUoAoBUSdjt3Uv3P3BTqNyzOzkVM03JyEhmlcM5Ey4y9TIWEWZLqGyVVAcxk9MSxGrgQuQLjnGzDOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBB7C4CEC2;
	Sat,  5 Oct 2024 19:12:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sxADE-00000005N8I-2q3D;
	Sat, 05 Oct 2024 15:13:08 -0400
Message-ID: <20241005191308.542725990@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 05 Oct 2024 15:12:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [for-next][PATCH 2/2] function_graph: Remove unnecessary initialization in
 ftrace_graph_ret_addr()
References: <20241005191252.411117350@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Oleg Nesterov <oleg@redhat.com>

After the commit 29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()")
ftrace_graph_ret_addr() doesn't need to initialize "int i" at the start.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/20240916175818.GA28944@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 875aefe60a13..27e523f01ed2 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -930,7 +930,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 {
 	struct ftrace_ret_stack *ret_stack;
 	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
-	int i = task->curr_ret_stack;
+	int i;
 
 	if (ret != return_handler)
 		return ret;
-- 
2.45.2



