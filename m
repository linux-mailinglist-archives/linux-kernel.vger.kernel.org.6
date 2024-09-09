Return-Path: <linux-kernel+bounces-322052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC085972364
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F26F2855E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562A189F3F;
	Mon,  9 Sep 2024 20:14:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C6189916
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912896; cv=none; b=CRQNRmMC23rR6Aw8rm2OAy6poufAUhAndvPPALMPQzUV9Eu3n3gJy4ac0NGMvHOmZyWmgEd0jNNOkRJUBdgILDUMT6pnLurzwiAyrPrNl8mv3rZVAsQ4zFPgINa7vpThSf6T3qOjahn1ZOmsmmEBl1J8wOkW8wQPITSV7yxhsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912896; c=relaxed/simple;
	bh=U9p4r+E9whe3uv37tWAXHD47v4tpNEZt0s8BgBbUemU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FTTYXOcJC9mzru7HxPX5xUelz5DHxa/Mri+wRBkKKQP5cf6uErJJgB6Ux6VH3hanbN5KjPOpDEd3oYY0gm653cx4uPJ2ZFkkhdY7dVCaSp/MFTB6O1+H6AtqZuDwftT3D98q735wa8P2kS/pD1jAN7/wSGEhGfQtvLX/mWjZGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF04C4CEC5;
	Mon,  9 Sep 2024 20:14:55 +0000 (UTC)
Date: Mon, 9 Sep 2024 16:14:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL] tracing: A couple of fixes for 6.11
Message-ID: <20240909161454.1d79e239@gandalf.local.home>
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

More tracing fixes for 6.11:

- Move declaration of interface_lock outside of CONFIG_TIMERLAT_TRACER

  The fix to some locking races moved the declaration of the
  interface_lock up in the file, but also moved it into the
  CONFIG_TIMERLAT_TRACER #ifdef block, breaking the build when
  that wasn't set. Move it further up and out of that #ifdef block.

- Remove unused function run_tracer_selftest() stub

  When CONFIG_FTRACE_STARTUP_TEST is not set the stub function
  run_tracer_selftest() is not used and clang is warning about it.
  Remove the function stub as it is not needed.

Note, I updated my test suite to test the case of OSNOISE tracer enabled
when the TIMERLAT tracer is not to catch the case that the one config not
enabled will not break the build again.


Please pull the latest trace-v6.11-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.11-rc6

Tag SHA1: 0dc65da7e7ed16903411c35ccea3a00ffb3f9fac
Head SHA1: 4e378158e5c15bd237a6ff44b7abb9184d61208c


Andy Shevchenko (1):
      tracing: Drop unused helper function to fix the build

Steven Rostedt (1):
      tracing/osnoise: Fix build when timerlat is not enabled

----
 kernel/trace/trace.c         |  4 ----
 kernel/trace/trace_osnoise.c | 10 +++++-----
 2 files changed, 5 insertions(+), 9 deletions(-)
---------------------------
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index edf6bc817aa1..c3b2c7dfadef 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2226,10 +2226,6 @@ static __init int init_trace_selftests(void)
 }
 core_initcall(init_trace_selftests);
 #else
-static inline int run_tracer_selftest(struct tracer *type)
-{
-	return 0;
-}
 static inline int do_run_tracer_selftest(struct tracer *type)
 {
 	return 0;
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bbe47781617e..7e75c1214b36 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -228,6 +228,11 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
 	return this_cpu_ptr(&per_cpu_osnoise_var);
 }
 
+/*
+ * Protect the interface.
+ */
+static struct mutex interface_lock;
+
 #ifdef CONFIG_TIMERLAT_TRACER
 /*
  * Runtime information for the timer mode.
@@ -252,11 +257,6 @@ static inline struct timerlat_variables *this_cpu_tmr_var(void)
 	return this_cpu_ptr(&per_cpu_timerlat_var);
 }
 
-/*
- * Protect the interface.
- */
-static struct mutex interface_lock;
-
 /*
  * tlat_var_reset - Reset the values of the given timerlat_variables
  */

