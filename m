Return-Path: <linux-kernel+bounces-535193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC821A47005
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F93188A728
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5205215F330;
	Thu, 27 Feb 2025 00:12:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2ED27005B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615133; cv=none; b=MTK3MT9Fzdzzm0fE2kEmGq2ICMeL9F2WpfClfsp+WRZC649LhixACmuYNjmTSQSuLgwbyi2bcCE32fEo2IFi7oK0ihDnOWikE6BAh2nf7m+me7fYCLT718Let3hKRnlq5OAs2DFx0kJatfiQm8rs3UiqvkaWL6m8i9cdSDvk2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615133; c=relaxed/simple;
	bh=Oprg1SolVFZ2y8feVu/LLbyfcoVDu2BCZyGPuBU+WjA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dTcTmu2ZBGK/n2K1PuWBMMCmU2TL9OBJ/p1QqsdTH/owwaWR6EfZ3HRZm1Ef0m0IzBmcbq+Fe1UT+yHAiKJPQFWL5sPUFYEehIV10CODzizyJvrns2t/UXFA3Cfbt1MQaTvT7wRahtX2H+2Xo9y6LnGEwKQWXEmPSg1MWxBvVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88482C4CEE8;
	Thu, 27 Feb 2025 00:12:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tnRWI-00000009XQY-1ouD;
	Wed, 26 Feb 2025 19:12:54 -0500
Message-ID: <20250227001254.283156805@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Feb 2025 19:12:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Borislav Petkov <bp@alien8.de>
Subject: [for-next][PATCH 1/3] tracing: Add traceoff_after_boot option
References: <20250227001235.355892523@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Sometimes tracing is used to debug issues during the boot process. Since
the trace buffer has a limited amount of storage, it may be prudent to
disable tracing after the boot is finished, otherwise the critical
information may be overwritten.  With this option, the main tracing buffer
will be turned off at the end of the boot process.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lore.kernel.org/20250208103017.48a7ec83@batman.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 kernel/trace/trace.c                            | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..e8ca4eabd152 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7279,6 +7279,15 @@
 			See also "Event triggers" in Documentation/trace/events.rst
 
 
+	traceoff_after_boot
+			[FTRACE] Sometimes tracing is used to debug issues
+			during the boot process. Since the trace buffer has a
+			limited amount of storage, it may be prudent to
+			disable tracing after the boot is finished, otherwise
+			the critical information may be overwritten.  With this
+			option, the main tracing buffer will be turned off at
+			the end of the boot process.
+
 	traceoff_on_warning
 			[FTRACE] enable this option to disable tracing when a
 			warning is hit. This turns off "tracing_on". Tracing can
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e6d517e74e0..61458d8c3a61 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -87,6 +87,7 @@ void __init disable_tracing_selftest(const char *reason)
 static struct trace_iterator *tracepoint_print_iter;
 int tracepoint_printk;
 static bool tracepoint_printk_stop_on_boot __initdata;
+static bool traceoff_after_boot __initdata;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
 
 /* For tracers that don't implement custom flags */
@@ -330,6 +331,13 @@ static int __init set_tracepoint_printk_stop(char *str)
 }
 __setup("tp_printk_stop_on_boot", set_tracepoint_printk_stop);
 
+static int __init set_traceoff_after_boot(char *str)
+{
+	traceoff_after_boot = true;
+	return 1;
+}
+__setup("traceoff_after_boot", set_traceoff_after_boot);
+
 unsigned long long ns2usecs(u64 nsec)
 {
 	nsec += 500;
@@ -10704,6 +10712,9 @@ __init static int late_trace_init(void)
 		tracepoint_printk = 0;
 	}
 
+	if (traceoff_after_boot)
+		tracing_off();
+
 	tracing_set_default_clock();
 	clear_boot_tracer();
 	return 0;
-- 
2.47.2



