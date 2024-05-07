Return-Path: <linux-kernel+bounces-171510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DAC8BE549
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87A81C23307
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9970115FA90;
	Tue,  7 May 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8IfJJl6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE915ECD8;
	Tue,  7 May 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090945; cv=none; b=I8yetT5ACAmpfuDDsHPCZ+NEZbZXjf3kUR9g/cvoX/LF7lbr8y1v9vSKOJdV5G02PM3ZO9iv6z4hoCnG85ZzvnBAuav6pMdypPs+f3tSoc9HIbH7I8h4KZ+DA+Ml7mZ1pSlzMMi+0xEwPBs472kN6IKrluNC1itrVNc8fzCJ8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090945; c=relaxed/simple;
	bh=v6a8A4n/NQNVvl6IUBlyb4ncY6wKsPnocwxI4QmL7G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g65+gw4EBILZtR/QG8YErEaAQUQxZjiSg01xivGSGrGrqzxI5vqFRfu7OOmpQma1WzUbtaSQahEyJbDTa1YoP37EnkYoXK0dzZP9UeOu/rFhJ0SEm4/O34/7gdjTVlDRJqAw36DUt96KCUSwfcuWGS0h5veSGsqioREgJ3cnTeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8IfJJl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20DEC2BBFC;
	Tue,  7 May 2024 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715090945;
	bh=v6a8A4n/NQNVvl6IUBlyb4ncY6wKsPnocwxI4QmL7G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8IfJJl6+0sZvwL5knwXSlWFzYCOSnHneGE5W1pj4dQX4v86eIjwQjm22o3HdPoeE
	 U1ayi8zgncgcyOmxZOunDL+Uyx6LQ9RHkG2GiM9bfhxfT5qjjWIZphgk1HcODObQfp
	 UarLHDFTviiCashKBTsN+nJx0f+fuq5G736g/Wyim1Et0dCS697/wj7tLa8xLF0VEB
	 jnInb8KOgmtbYMbq6blCk9wVjx4ugF00wPgiQGDQWLCdOZGPcsphikVPWp8eCATibU
	 XN1rx5Yw0PA9xTjcELdoovCXpWGSYBVrNMFt921CuJf+wThe8YUpKIhIsby3lyZUpB
	 hFMsCGfrQl6XQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH v10 05/36] fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
Date: Tue,  7 May 2024 23:08:59 +0900
Message-Id: <171509093949.162236.14518699447151894536.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171509088006.162236.7227326999861366050.stgit@devnote2>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Instead of using "ALIGN()", use BUILD_BUG_ON() as the structures should
always be divisible by sizeof(long).

Link: http://lkml.kernel.org/r/20190524111144.GI2589@hirez.programming.kicks-ass.net

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v7:
  - Use DIV_ROUND_UP() to calculate FGRAPH_RET_INDEX
---
 kernel/trace/fgraph.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 30edeb6d4aa9..6f8d36370994 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -26,10 +26,9 @@
 #endif
 
 #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
-#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))
+#define FGRAPH_RET_INDEX DIV_ROUND_UP(FGRAPH_RET_SIZE, sizeof(long))
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
-#define SHADOW_STACK_INDEX			\
-	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
+#define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
 #define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
 
@@ -91,6 +90,8 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (!current->ret_stack)
 		return -EBUSY;
 
+	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
+
 	/*
 	 * We must make sure the ret_stack is tested before we read
 	 * anything else.
@@ -325,6 +326,8 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
 	int index = task->curr_ret_stack;
 
+	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
+
 	index -= FGRAPH_RET_INDEX * (idx + 1);
 	if (index < 0)
 		return NULL;


