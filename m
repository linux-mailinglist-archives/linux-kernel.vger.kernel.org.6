Return-Path: <linux-kernel+bounces-350421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206F69904F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5211F22E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BED2139B0;
	Fri,  4 Oct 2024 13:56:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A676212EFD
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050187; cv=none; b=FBjLcs6Q2CZ1C3yt+1QkEZtPcFIMnEHZ7zOJYhVX0F0o62TF6ec+P7Th56J3I3arFCEOxrD0PhVmGYkCb6RwelVol4IYWQ9RYw4/MgG94f1iyjqHCA1uGqZt6d7cGJysJJERt2LSbcsK9nPc+dbzT2wEHErP///NZqaHsfJlJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050187; c=relaxed/simple;
	bh=gUyHsly5W4oj6s1eQx07m1wwA5qvoBZADocdlOMG69A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YoX44M2ALmZblJBV+SrlWZBsdjrVWj9F/J5gSb7ohrXRdU/zmRaacm7naCWaY3Ho4GXIrz03NXXY/7ApiXfYj2GAkqbdnWwhcIOqr1mr6x4/HjjhW5dA4dgmvoFW4x7wbKFx7Yuk4HflXOL8cf8JtlS7+eARWqmEcXNnwcV4PP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DFFC4CECE;
	Fri,  4 Oct 2024 13:56:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1swio7-00000005C86-1De2;
	Fri, 04 Oct 2024 09:57:23 -0400
Message-ID: <20241004135723.151356550@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 04 Oct 2024 09:56:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alison Schofield <alison.schofield@intel.com>
Subject: [for-linus][PATCH 1/8] tracing: Fix trace_check_vprintf() when tp_printk is used
References: <20241004135655.993267242@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the tp_printk kernel command line is used, the trace events go
directly to printk(). It is still checked via the trace_check_vprintf()
function to make sure the pointers of the trace event are legit.

The addition of reading buffers from previous boots required adding a
delta between the addresses of the previous boot and the current boot so
that the pointers in the old buffer can still be used. But this required
adding a trace_array pointer to acquire the delta offsets.

The tp_printk code does not provide a trace_array (tr) pointer, so when
the offsets were examined, a NULL pointer dereference happened and the
kernel crashed.

If the trace_array does not exist, just default the delta offsets to zero,
as that also means the trace event is not being read from a previous boot.

Link: https://lore.kernel.org/all/Zv3z5UsG_jsO9_Tb@aschofie-mobl2.lan/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241003104925.4e1b1fd9@gandalf.local.home
Fixes: 07714b4bb3f98 ("tracing: Handle old buffer mappings for event strings and functions")
Reported-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c01375adc471..1c69ca1f1088 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3697,8 +3697,8 @@ static void test_can_verify(void)
 void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			 va_list ap)
 {
-	long text_delta = iter->tr->text_delta;
-	long data_delta = iter->tr->data_delta;
+	long text_delta = 0;
+	long data_delta = 0;
 	const char *p = fmt;
 	const char *str;
 	bool good;
@@ -3710,6 +3710,17 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 	if (static_branch_unlikely(&trace_no_verify))
 		goto print;
 
+	/*
+	 * When the kernel is booted with the tp_printk command line
+	 * parameter, trace events go directly through to printk().
+	 * It also is checked by this function, but it does not
+	 * have an associated trace_array (tr) for it.
+	 */
+	if (iter->tr) {
+		text_delta = iter->tr->text_delta;
+		data_delta = iter->tr->data_delta;
+	}
+
 	/* Don't bother checking when doing a ftrace_dump() */
 	if (iter->fmt == static_fmt_buf)
 		goto print;
-- 
2.45.2



