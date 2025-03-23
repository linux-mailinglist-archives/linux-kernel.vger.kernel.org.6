Return-Path: <linux-kernel+bounces-572736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C27A6CDE3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 06:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30B77A53C0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 05:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0788E200B99;
	Sun, 23 Mar 2025 05:08:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C220102C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742706535; cv=none; b=dAacPqn0FUrOM+m5Kqo/huDa2DY68iN6bCchUouEsAh6oTZ/GR1zc/2dUuyZ1+YCvb+X10tKKhGFX2AoFEQtakeEH8TglWRiQlHTwi1BT/OBtRgt9yJNl0rcO5mFJBFmCdSU3FXVXFSRgyTReIWzuHO6zHdmpcFNpwJRJcirMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742706535; c=relaxed/simple;
	bh=bD8t0AIpqh8YqpWgl6s1KSM/pPLnaCgmd1WcfZa1bYc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=apeRTaSItBxfS5s3Mvt3BX8WnLZYrBj+vyjc7po0Qm1AxLscMpvifH3OUShQaoYR4hLRsDomPJzK8OnuaxJqLTFDvPKSyb5BSCLEnwPND+5fPaj4i9lD/dj+NPm2SMQPvVliEOcFYfPLBpfnjLbiKw3HodzaBHP04+Rc2tSFx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B892C4CEF1;
	Sun, 23 Mar 2025 05:08:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twDaX-00000001x0a-3rTT;
	Sun, 23 Mar 2025 01:09:33 -0400
Message-ID: <20250323050933.770518233@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 01:09:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 3/4] tracing: Skip update_last_data() if cleared and remove active check
 for save_mod()
References: <20250323050914.459621318@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

If the last boot data is already cleared, there is no reason to update it
again. Skip if the TRACE_ARRAY_FL_LAST_BOOT is cleared.
Also, for calling save_mod() when module loading, we don't need to check
the trace is active or not because any module address can be on the
stacktrace.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/174165660328.1173316.15529357882704817499.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be97465485b3..0be048fecc89 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6040,6 +6040,12 @@ static void update_last_data(struct trace_array *tr)
 	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
 		return;
 
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return;
+
+	/* Only if the buffer has previous boot data clear and update it. */
+	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -6052,9 +6058,6 @@ static void update_last_data(struct trace_array *tr)
 		module_for_each_mod(save_mod, tr);
 	}
 
-	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
-		return;
-
 	/*
 	 * Need to clear all CPU buffers as there cannot be events
 	 * from the previous boot mixed with events with this boot
@@ -6077,7 +6080,6 @@ static void update_last_data(struct trace_array *tr)
 #else
 	tscratch->kaslr_addr = 0;
 #endif
-	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 }
 
 /**
@@ -10099,15 +10101,6 @@ static void trace_module_remove_evals(struct module *mod)
 static inline void trace_module_remove_evals(struct module *mod) { }
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
-static bool trace_array_active(struct trace_array *tr)
-{
-	if (tr->current_trace != &nop_trace)
-		return true;
-
-	/* 0 is no events, 1 is all disabled */
-	return trace_events_enabled(tr, NULL) > 1;
-}
-
 static void trace_module_record(struct module *mod)
 {
 	struct trace_array *tr;
@@ -10116,11 +10109,8 @@ static void trace_module_record(struct module *mod)
 		/* Update any persistent trace array that has already been started */
 		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
 		    TRACE_ARRAY_FL_BOOT) {
-			/* Only update if the trace array is active */
-			if (trace_array_active(tr)) {
-				guard(mutex)(&scratch_mutex);
-				save_mod(mod, tr);
-			}
+			guard(mutex)(&scratch_mutex);
+			save_mod(mod, tr);
 		}
 	}
 }
-- 
2.47.2



