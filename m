Return-Path: <linux-kernel+bounces-392074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D905A9B8F65
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914371F233C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5911AAE3A;
	Fri,  1 Nov 2024 10:36:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68FD19CC0F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457369; cv=none; b=tx2zi1KrF/L/NDubU6g6TKX5APvNHSaZPwT3hn9R5AGBSVRCnfSQM/BarhjEUSiTCjLlWKMfqPojl877m63hySyGDYoThF/XIIFFwr/L7OQLQwee/kONbqbP9h+hCdJYedlDlXmVsHAdqFMG/YM3V0j3LabXDrRCrGsCTN221/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457369; c=relaxed/simple;
	bh=R29ZQy0FjvDDGvhe1C1bVyTO8g35Xi9DDb1KTVaw4lw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Pd+8ICkU6FwejRyr5iAzrSq2ApTKYZLCc19v+s2vzIURrZOvGNQy7y0D5W/uqlb27PXIl/SPJ82liLUsvUU3dCcz6XvARuZVQl0nk2dYBIUQ9aHTVbDYsyy9o3iBr/3MGVu9jEvqi3ZTiBHDryxhYtqKoPawIK6qU/89i07cZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C34C4CED5;
	Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1f-00000005S73-3oST;
	Fri, 01 Nov 2024 06:37:07 -0400
Message-ID: <20241101103707.768085371@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-next][PATCH 06/11] tracing: Remove TRACE_FLAG_IRQS_NOSUPPORT
References: <20241101103647.011707614@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

It was possible to enable tracing with no IRQ tracing support. The
tracing infrastructure would then record TRACE_FLAG_IRQS_NOSUPPORT as
the only tracing flag and show an 'X' in the output.

The last user of this feature was PPC32 which managed to implement it
during PowerPC merge in 2009. Since then, it was unused and the PPC32
dependency was finally removed in commit 0ea5ee035133a ("tracing: Remove
PPC32 wart from config TRACING_SUPPORT").
Since the PowerPC merge the code behind !CONFIG_TRACE_IRQFLAGS_SUPPORT
with TRACING enabled can no longer be selected used and the 'X' is not
displayed or recorded.

Remove the CONFIG_TRACE_IRQFLAGS_SUPPORT from the tracing code. Remove
TRACE_FLAG_IRQS_NOSUPPORT.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241022110112.XJI8I9T2@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst |  3 ---
 include/linux/trace_events.h   | 13 -------------
 kernel/trace/trace_output.c    |  1 -
 3 files changed, 17 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 4073ca48af4a..74d5bd801b1a 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1031,9 +1031,6 @@ explains which is which.
   CPU#: The CPU which the process was running on.
 
   irqs-off: 'd' interrupts are disabled. '.' otherwise.
-	.. caution:: If the architecture does not support a way to
-		read the irq flags variable, an 'X' will always
-		be printed here.
 
   need-resched:
 	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index f8f2e52653df..016b29a56c87 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -184,7 +184,6 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
 
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		= 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
 	TRACE_FLAG_NEED_RESCHED		= 0x04,
 	TRACE_FLAG_HARDIRQ		= 0x08,
 	TRACE_FLAG_SOFTIRQ		= 0x10,
@@ -193,7 +192,6 @@ enum trace_flag_type {
 	TRACE_FLAG_BH_OFF		= 0x80,
 };
 
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
 static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
 {
 	unsigned int irq_status = irqs_disabled_flags(irqflags) ?
@@ -207,17 +205,6 @@ static inline unsigned int tracing_gen_ctx(void)
 	local_save_flags(irqflags);
 	return tracing_gen_ctx_flags(irqflags);
 }
-#else
-
-static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
-{
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
-}
-static inline unsigned int tracing_gen_ctx(void)
-{
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
-}
-#endif
 
 static inline unsigned int tracing_gen_ctx_dec(void)
 {
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 868f2f912f28..2ee6613dce6d 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -460,7 +460,6 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		bh_off ? 'b' :
-		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
 		'.';
 
 	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
-- 
2.45.2



