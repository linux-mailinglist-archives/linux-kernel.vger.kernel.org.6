Return-Path: <linux-kernel+bounces-210589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 000419045EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADBA1F22ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162961534E8;
	Tue, 11 Jun 2024 20:46:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C38488
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138772; cv=none; b=F2VN4aW3kyf/k55n8hbBIk5me9/xmOtS/54XRoN7Wn2nwSonSak4E8HH5Rrd1I29ji6OnnKnW51LXlf0BTSvYsYzdfEYf94PpwM8zqId9CueMUEYKW7vCXYTNDWgdJ1JJgABgitq+TwExqStsHtdG0CoYJe9HbclLVQAK/JT2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138772; c=relaxed/simple;
	bh=+6gP8t0w01bewNTXjkKuZ7tRG/S6J++weKA38nZj6JM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RqhYN6OKNbcBnnS+x3RKbiiYqV1FzU45K2kkKu+WxCNReS+O1tX2Ifvb0qkYCsu9jhehcTuze22QBT5Dk8MdkBvku6gjlBQh6ODwGdN4Z+OibFKz6d4INisqghBNZhKYnjS5L52DPyWwmgx4OuBoMIQviypURJ5q+CMIqQN00Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3026FC4AF4D;
	Tue, 11 Jun 2024 20:46:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sH8Nw-00000001V39-3J5g;
	Tue, 11 Jun 2024 16:46:28 -0400
Message-ID: <20240611204628.651616294@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 16:45:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Yang Li <yang.lee@linux.alibaba.com>
Subject: [for-next][PATCH 2/4] function_graph: Fix up ftrace_graph_ret_addr()
References: <20240611204554.092271761@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Yang Li sent a patch to fix the kerneldoc of ftrace_graph_ret_addr().
While reviewing it, I realized that the comments in the entire function
header needed a rewrite. When doing that, I realized that @idx parameter
was being ignored. Every time this was called by the unwinder, it would
start the loop at the top of the shadow stack and look for the matching
stack pointer. When it found it, it would return it. When the unwinder
asked for the next function, it would search from the beginning again.

In reality, it should start from where it left off. That was the reason
for the @idx parameter in the first place. The first time the unwinder
calls this function, the @idx pointer would contain zero. That would mean
to start from the top of the stack. The function was supposed to update
the @idx with the index where it found the return address, so that the
next time the unwinder calls this function it doesn't have to search
through the previous addresses it found (making it O(n^2)!).

This speeds up the unwinder's use of ftrace_graph_ret_addr() by an order
of magnitude.

Link: https://lore.kernel.org/linux-trace-kernel/20240610181746.656e3759@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20240611031737.821995106@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Reported-by: Yang Li <yang.lee@linux.alibaba.com>
Fixes: 7aa1eaef9f428 ("function_graph: Allow multiple users to attach to function graph")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 63d0c2f84ce1..91f1eef256af 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -870,18 +870,24 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 }
 
 /**
- * ftrace_graph_ret_addr - convert a potentially modified stack return address
- *			   to its original value
+ * ftrace_graph_ret_addr - return the original value of the return address
+ * @task: The task the unwinder is being executed on
+ * @idx: An initialized pointer to the next stack index to use
+ * @ret: The current return address (likely pointing to return_handler)
+ * @retp: The address on the stack of the current return location
  *
  * This function can be called by stack unwinding code to convert a found stack
- * return address ('ret') to its original value, in case the function graph
+ * return address (@ret) to its original value, in case the function graph
  * tracer has modified it to be 'return_to_handler'.  If the address hasn't
- * been modified, the unchanged value of 'ret' is returned.
+ * been modified, the unchanged value of @ret is returned.
  *
- * 'idx' is a state variable which should be initialized by the caller to zero
- * before the first call.
+ * @idx holds the last index used to know where to start from. It should be
+ * initialized to zero for the first iteration as that will mean to start
+ * at the top of the shadow stack. If the location is found, this pointer
+ * will be assigned that location so that if called again, it will continue
+ * where it left off.
  *
- * 'retp' is a pointer to the return address on the stack.  It's ignored if
+ * @retp is a pointer to the return address on the stack.  It's ignored if
  * the arch doesn't have HAVE_FUNCTION_GRAPH_RET_ADDR_PTR defined.
  */
 #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
@@ -895,6 +901,10 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 	if (ret != return_handler)
 		return ret;
 
+	if (!idx)
+		return ret;
+
+	i = *idx ? : task->curr_ret_stack;
 	while (i > 0) {
 		ret_stack = get_ret_stack(current, i, &i);
 		if (!ret_stack)
@@ -908,8 +918,10 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 		 * Thus we will continue to find real return address.
 		 */
 		if (ret_stack->retp == retp &&
-		    ret_stack->ret != return_handler)
+		    ret_stack->ret != return_handler) {
+			*idx = i;
 			return ret_stack->ret;
+		}
 	}
 
 	return ret;
-- 
2.43.0



