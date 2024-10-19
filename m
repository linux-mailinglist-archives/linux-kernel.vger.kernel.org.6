Return-Path: <linux-kernel+bounces-372987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28749A5059
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 20:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24089B22914
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8BC19068E;
	Sat, 19 Oct 2024 18:44:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979A2BAE5
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729363469; cv=none; b=pquEY9y2NVjNz1P19I9IPjPWaQeOdpt131iQwkT5aJkC9cUrORmNAD9msvwVOPOjPhongmhnFm3qtdb/iRZ9EY0gBDCQ65E78VBIQogy5AIkRNW4tmM1mY3ZKWuQODOn0cHfa8FoASL+cnXvORsp7vktfx09cOF5LsR4zkrcc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729363469; c=relaxed/simple;
	bh=x4cs74ucsFNf1x/XHBm23yVZcuOswBT1g5wLUO2Szg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sKlMOQLXDTL/mtZqZaiSF2cVocHS9iKf07BUvfEysCxsbxmjXdI9RNnwIf1YPkozQIMkoeRRT1eDSdfi+px0G++EE05h6uchYPF+SWyQZfn0R+gSKqw9qwNUoSaR9HwdoU506kA7+sJ86CxO7u/uQHAehzrtQRbgZ2Yk/I+wkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F406C4CEC5;
	Sat, 19 Oct 2024 18:44:28 +0000 (UTC)
Date: Sat, 19 Oct 2024 14:44:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] ftrace: Two fixes for v6.12
Message-ID: <20241019144427.5d469ed0@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

ftrace: A couple of fixes to function graph infrastructure

- Fix allocation of idle shadow stack allocation during hotplug

  If function graph tracing is started when a CPU is offline, if it were
  come online during the trace then the idle task that represents the CPU
  will not get a shadow stack allocated for it. This means all function
  graph hooks that happen while that idle task is running (including in
  interrupt mode) will have all its events dropped.

  Switch over to the CPU hotplug mechanism that will have any newly
  brought on line CPU get a callback that can allocate the shadow stack
  for its idle task.

- Fix allocation size of the ret_stack_list array

  When function graph tracing converted over to allowing more than one
  user at a time, it had to convert its shadow stack from an array of
  ret_stack structures to an array of unsigned longs. The shadow stacks
  are allocated in batches of 32 at a time and assigned to every running
  task. The batch is held by the ret_stack_list array. But when the
  conversion happened, instead of allocating an array of 32 pointers, it
  was allocated as a ret_stack itself (PAGE_SIZE). This ret_stack_list
  gets passed to a function that iterates over what it believes is its
  size defined by the FTRACE_RETSTACK_ALLOC_SIZE macro (which is 32).

  Luckily (PAGE_SIZE) is greater than 32 * sizeof(long), otherwise this
  would have been an array overflow. This still should be fixed and the
  ret_stack_list should be allocated to the size it is expected to be as
  someday it may end up being bigger than SHADOW_STACK_SIZE.


Please pull the latest ftrace-v6.12-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace-v6.12-rc3

Tag SHA1: b2de656c065361da94455f0b336df15e5ac3dc32
Head SHA1: fae4078c289a2f24229c0de652249948b1cd6bdb


Steven Rostedt (2):
      fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks
      fgraph: Allocate ret_stack_list with proper size

----
 kernel/trace/fgraph.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)
---------------------------
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f..41e7a15dcb50 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1160,19 +1160,14 @@ void fgraph_update_pid_func(void)
 static int start_graph_tracing(void)
 {
 	unsigned long **ret_stack_list;
-	int ret, cpu;
+	int ret;
 
-	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
+	ret_stack_list = kcalloc(FTRACE_RETSTACK_ALLOC_SIZE,
+				 sizeof(*ret_stack_list), GFP_KERNEL);
 
 	if (!ret_stack_list)
 		return -ENOMEM;
 
-	/* The cpu_boot init_task->ret_stack will never be freed */
-	for_each_online_cpu(cpu) {
-		if (!idle_task(cpu)->ret_stack)
-			ftrace_graph_init_idle_task(idle_task(cpu), cpu);
-	}
-
 	do {
 		ret = alloc_retstack_tasklist(ret_stack_list);
 	} while (ret == -EAGAIN);
@@ -1242,14 +1237,34 @@ static void ftrace_graph_disable_direct(bool disable_branch)
 	fgraph_direct_gops = &fgraph_stub;
 }
 
+/* The cpu_boot init_task->ret_stack will never be freed */
+static int fgraph_cpu_init(unsigned int cpu)
+{
+	if (!idle_task(cpu)->ret_stack)
+		ftrace_graph_init_idle_task(idle_task(cpu), cpu);
+	return 0;
+}
+
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
+	static bool fgraph_initialized;
 	int command = 0;
 	int ret = 0;
 	int i = -1;
 
 	mutex_lock(&ftrace_lock);
 
+	if (!fgraph_initialized) {
+		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
+					fgraph_cpu_init, NULL);
+		if (ret < 0) {
+			pr_warn("fgraph: Error to init cpu hotplug support\n");
+			return ret;
+		}
+		fgraph_initialized = true;
+		ret = 0;
+	}
+
 	if (!fgraph_array[0]) {
 		/* The array must always have real data on it */
 		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)

