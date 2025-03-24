Return-Path: <linux-kernel+bounces-573086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966DA6D2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A373B2C07
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3673B7A8;
	Mon, 24 Mar 2025 01:59:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EDA79F5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742781597; cv=none; b=poWO04Ad3z4NPp07w+UfZ6vO9t6ecVpB09qlgs7tTcCY6GjerBXfXEHGxTUZWA5mMfplZH5GwYHMu45sARCV0WeJQ27DTPfM/zbibfghgHZbvPrbkn/3H8Z38W9e+rWHjRRLX5/F+djrubbHAfXgs8BMqe4vubwyhcWI71oA5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742781597; c=relaxed/simple;
	bh=iPBfgq/D02S5iq7ZZ8C9YgzHVAKbAHGPtLmnJVSkfv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=o9IzArOKS60Em3UdI1gKk90242nrn4e7gcd6mBWM9k2PSLkrsjvDQESgfxuSdQLnsQjAUIiYSG43nvgAsP8kRTB3pt8ab9Q0kVP60c0jZ5TZqKFEkzLSLNZrDs5q0O0ZA9dLfEe21QZ6fEkcHppZps9fR1u1bF2RNO8SjSRPdVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833E4C4CEE2;
	Mon, 24 Mar 2025 01:59:56 +0000 (UTC)
Date: Sun, 23 Mar 2025 21:59:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Douglas Raillard 
 <douglas.raillard@arm.com>
Subject: [for-next][PATCH] tracing: Do not use PERF enums when perf is not
 defined
Message-ID: <20250323215955.6f6342a3@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

An update was made to up the module ref count when a synthetic event is
registered for both trace and perf events. But if perf is not configured
in, the perf enums used will cause the kernel to fail to build.

Fixes: a1e3ad43115e ("tracing: Ensure module defining synth event cannot be unloaded while tracing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503232230.TeREVy8R-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index d91205bc9f61..5976545403ea 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -859,8 +859,10 @@ static int synth_event_reg(struct trace_event_call *call,
 	struct synth_event *event = container_of(call, struct synth_event, call);
 
 	switch (type) {
-	case TRACE_REG_REGISTER:
+#ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_REGISTER:
+#endif
+	case TRACE_REG_REGISTER:
 		if (!try_module_get(event->mod))
 			return -EBUSY;
 		break;
@@ -871,8 +873,10 @@ static int synth_event_reg(struct trace_event_call *call,
 	int ret = trace_event_reg(call, type, data);
 
 	switch (type) {
-	case TRACE_REG_UNREGISTER:
+#ifdef CONFIG_PERF_EVENTS
 	case TRACE_REG_PERF_UNREGISTER:
+#endif
+	case TRACE_REG_UNREGISTER:
 		module_put(event->mod);
 		break;
 	default:
-- 
2.47.2


