Return-Path: <linux-kernel+bounces-219865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8A90D91B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB651F2505A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098A4D9FB;
	Tue, 18 Jun 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAOi3Qtn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE546521
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727836; cv=none; b=FZTv/0dJW+US/Fs5X5Bnl9PWsRz8+XNK89ex2au9egThuDxPlW7L2NO+OADDaH0AlxAzl9DnJf+/jIwOP8HTbfzeuaVUDptF2wHa7MZRELtVbsc6Iq/kQ68Bmw1rx0EveeqtiXIbrgMscS5TqE7eyYYSOOPbmxc+/1WQ9GUYDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727836; c=relaxed/simple;
	bh=4xeT/qCYi2F1Gnln/3rac4dX/aw8TdWIfRPIPf+PvlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JRRXpA5vgLEaVSoQkhI8L6k6AZm3Q7d+k2s+0Kkdt4PiTrwXXxjOQfsiBwcGD3d7gGjr7s4F40kUcpJDteVDG7AYuFmxtsP2AaFG6aJ0f59EBFr9AVX9FkeHWQ/jS7uUtz+FUOyt9LAr9SctJhmXAOVt61FBr5jkUYYCp1zMveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAOi3Qtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEE7C3277B;
	Tue, 18 Jun 2024 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727836;
	bh=4xeT/qCYi2F1Gnln/3rac4dX/aw8TdWIfRPIPf+PvlU=;
	h=From:To:Cc:Subject:Date:From;
	b=jAOi3Qtnlp/JkgKpv7517ZGMfJYwJszop2rzFqupi9ipJPxse4ji1zTR0dmqulBtd
	 xfgjFSUjWAioQ1l/SSkSMTqDnDjy1d5ZfgPPc3lslzBNXtsihCTu9Dp6+Itmq3Wgi8
	 c8d0AaBXIFVo4auBvlJn2RjkJSWTTIzUpM8cTK4XbizQxw7LS7/0+7Bi4cGc+X2+m1
	 c4qwD7HplA/WXmlJ6wXQteJy0yP7d/s6mZ/GnGD0V0A6iPPrJe55IeVK08SkgU10hs
	 hKFh/9rq2s9XBdSZuKCa7FZmaJFZ+cr3CL/CIfcMgEo8K6SCX5od7N26wj8HG8WgJd
	 n8hrAuV8GiEEg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	chenqiwu <qiwuchen55@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Cc: puranjay12@gmail.com
Subject: [PATCH] arm64: stacktrace: fix the usage of ftrace_graph_ret_addr()
Date: Tue, 18 Jun 2024 16:23:42 +0000
Message-Id: <20240618162342.28275-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ftrace_graph_ret_addr() takes an 'idx' integer pointer that is used to
optimize the stack unwinding process. arm64 currently passes `NULL` for
this parameter which stops it from utilizing these optimizations.

Further, the current code for ftrace_graph_ret_addr() will just return
the passed in return address if it is NULL which will break this usage.

Pass a valid integer pointer to ftrace_graph_ret_addr() similar to
x86_64's stack unwinder.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/kernel/stacktrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 6b3258860377..2729faaee4b4 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -25,6 +25,7 @@
  *
  * @common:      Common unwind state.
  * @task:        The task being unwound.
+ * @graph_idx:   Used by ftrace_graph_ret_addr() for optimized stack unwinding.
  * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
  *               associated with the most recently encountered replacement lr
  *               value.
@@ -32,6 +33,7 @@
 struct kunwind_state {
 	struct unwind_state common;
 	struct task_struct *task;
+	int graph_idx;
 #ifdef CONFIG_KRETPROBES
 	struct llist_node *kr_cur;
 #endif
@@ -106,7 +108,7 @@ kunwind_recover_return_address(struct kunwind_state *state)
 	if (state->task->ret_stack &&
 	    (state->common.pc == (unsigned long)return_to_handler)) {
 		unsigned long orig_pc;
-		orig_pc = ftrace_graph_ret_addr(state->task, NULL,
+		orig_pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
 						state->common.pc,
 						(void *)state->common.fp);
 		if (WARN_ON_ONCE(state->common.pc == orig_pc))
-- 
2.40.1


