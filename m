Return-Path: <linux-kernel+bounces-204252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9178FE641
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B0CB23153
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E7A19883C;
	Thu,  6 Jun 2024 12:11:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D1197524
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675862; cv=none; b=DuZsRdtWuVAY4Oa58LMkt68K1Z8QTe92zwUJTywM9YPmcP1j2OK1IK1whXLTWsnTAv/uhLBa18luAI7M6ebAohiBhwLrpSOv/PQiuqHXCGKgB8rWF4ca+amR5YWOW0NV6BgoMXKPNccCyHkWKQnbKZMyzNyEKYP05JaQcuWOxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675862; c=relaxed/simple;
	bh=Mh8Nc2PUn8WQF6A4kwG6AMoIRiTAM/kSAgU2FgOhyiU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=F/6XJX8i9nE+225KVKyPnofudNDVmaMam2rrZCwsCF534ZF94Jd/cJCNUTaENIT2kis6rL0pZco0LGc12Oijd9QftzvsZ3qxjbxUCvwvPl0ScCWiLjalzsP7FFk2vTGpkW1SNMnED0R7InRBc25B5Au3zZfA3vUzpoQJagaiqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1567C32782;
	Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxS-00000000nNo-1Avm;
	Thu, 06 Jun 2024 08:11:06 -0400
Message-ID: <20240606121106.141319090@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 11/15] ftrace: Fix prototypes for ftrace_startup/shutdown_subops()
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The ftrace_startup_subops() was in the wrong header, and both functions
were not defined on !CONFIG_DYNAMIC_FTRACE.

Link: https://lore.kernel.org/linux-trace-kernel/20240605202708.773583114@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 5fccc7552ccbc ("ftrace: Add subops logic to allow one ops to manage many")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406051524.a12JqLqx-lkp@intel.com/
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace_internal.h | 9 +++++++++
 kernel/trace/trace.h           | 1 -
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index bfba10c2fcf1..4bb1e881154a 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -15,6 +15,7 @@ extern struct ftrace_ops global_ops;
 int ftrace_startup(struct ftrace_ops *ops, int command);
 int ftrace_shutdown(struct ftrace_ops *ops, int command);
 int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs);
+int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
 int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
 
 #else /* !CONFIG_DYNAMIC_FTRACE */
@@ -39,6 +40,14 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 {
 	return 1;
 }
+static inline int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
+{
+	return -EINVAL;
+}
+static inline int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b37402e3f0c9..8783bebd0562 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1186,7 +1186,6 @@ extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
 			     int len, int reset);
 extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
 			      int len, int reset);
-extern int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
 #else
 struct ftrace_func_command;
 
-- 
2.43.0



