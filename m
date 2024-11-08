Return-Path: <linux-kernel+bounces-401555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219289C1C3C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455141C20B6D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F481E4101;
	Fri,  8 Nov 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rvzxnz8A"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2A1E3DC5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065707; cv=none; b=pHZj/FvxQJN2lz+BbZt5691ol/znGQaKzR6CNltm6vrhXpm4tryFVseuCHRXboK1fOxahoMVKS7UhikT4u2Vx3wQvDVwHANBYqfXpGCmj/EWWsk/PKXL4lDzH0QX7po0eFi6GYrWefYXDc+NYfQwyLl2l85PdJ6lsJi8So3Fs4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065707; c=relaxed/simple;
	bh=JnIM12tM59+qUat5gAdMpFMhoi5YbwtxL7M88YFC6fk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ap8xhRD+83nUXrDw+NMGPxio9yr75tV7hogZVZ0nffdcdmGbeUWri19OSsj9A+TjtIfpJ26siujMtVXWSFAuJQ32Bl4G6WtM/9kXZvtDefV+a+IYycgbNbGV6N+3SwXDCWrYdpyrpMIajAfigLWjq91UzU2UprysvwQpweYlMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rvzxnz8A; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea7cfb6e0fso42101597b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731065704; x=1731670504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D42rLpD50SsNXuzg8LivD2CtXeeoEvwN95ZboPt7X8w=;
        b=Rvzxnz8AF+NGI7IMPu2BZ8mPBH2ftlv+zUTNutN4wSMQcuUuNME8oSftBxVPeFhLBU
         ZUJJ30G4rTlcxKb/ccrOIGI7uPI/DRzgFuOuBd/CTbYZYQoGvStrPj4ohAXlV/WcV2te
         mLuE2WXh4wvSB9ylPoPSEbWEshIMD9ieZqISpxdvCVtRq+rp8dL3wAtKLlj+JPRPn+gf
         EoihGd+0I9igTmVFkJp9wFmqLlMr0hmHNNdQypZhi1WvojEiriCijJDbMY+2kvTQ0Ifs
         NWNQKUPNbebi3bcGK/gCxO1OHviIVrR9LVoDPGrgk5H1zl/imylc2HU5V3gETg2XRjsY
         KIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065704; x=1731670504;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D42rLpD50SsNXuzg8LivD2CtXeeoEvwN95ZboPt7X8w=;
        b=L0UDPWxblu+HyraZ7hOWTBdb141ykXgw/T1LhlUhP5Cg5VyfGrlTZMeZPZP7N4HRDh
         QbjwqsnExgGHm5C8GfVD18LgCKfb3TPPjIVFHHw+iMbb6xxg0YWwPurh9MgHwCNEgtAo
         aBDqvHZCWjuEpj3Nkjsyra3CiZhUWWKOHUHts4BFkYGLOHfXp18rRmzlU0CFLzYMmKqQ
         K2acO1IQSVQTbsG3bdS4lWHXQnAyM2TM9wTPeVheRnCzblcgjcHQCR34Bke4MGLGwOEd
         HZL4W5+9xEBe0/5AqJdmZc3nvZ5bh69kstiZFjOKDgaDHZ8AIT+yp96I07dgNCWaHwry
         x8zA==
X-Forwarded-Encrypted: i=1; AJvYcCUBOmUcUqsmc/BUkmxbcmInp+mLgaIlAOJHRdCVEURf6+GKWl319xZDCBkOJfMQBkWywqd7yg18DAa50KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsmolTAHbvp/NZbo/dF7VNpt6iOyfJtlx4mikLtubrB5rmkk53
	F4lNewP5m4/D6hCx9Fje3CHE3bpYND3HGb7fze8fhayb3dMRVzLlsEBbkGewHVNpiTLcnLcEwg=
	=
X-Google-Smtp-Source: AGHT+IEVq4ZB92RQ+5XO1N4eDbZds8vMWL4j02TjhgOSlo3OfmFG5yrjMs51CXGdV/j3StLTZosV0Tjm4Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:1d41:9aa5:8c04:911])
 (user=elver job=sendgmr) by 2002:a0d:e703:0:b0:64a:e220:bfb5 with SMTP id
 00721157ae682-6eaddd87123mr145677b3.1.1731065704476; Fri, 08 Nov 2024
 03:35:04 -0800 (PST)
Date: Fri,  8 Nov 2024 12:34:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108113455.2924361-1-elver@google.com>
Subject: [PATCH v3 1/2] tracing: Add task_prctl_unknown tracepoint
From: Marco Elver <elver@google.com>
To: elver@google.com, Steven Rostedt <rostedt@goodmis.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

prctl() is a complex syscall which multiplexes its functionality based
on a large set of PR_* options. Currently we count 64 such options. The
return value of unknown options is -EINVAL, and doesn't distinguish from
known options that were passed invalid args that also return -EINVAL.

To understand if programs are attempting to use prctl() options not yet
available on the running kernel, provide the task_prctl_unknown
tracepoint.

Note, this tracepoint is in an unlikely cold path, and would therefore
be suitable for continuous monitoring (e.g. via perf_event_open).

While the above is likely the simplest usecase, additionally this
tracepoint can help unlock some testing scenarios (where probing
sys_enter or sys_exit causes undesirable performance overheads):

  a. unprivileged triggering of a test module: test modules may register a
     probe to be called back on task_prctl_unknown, and pick a very large
     unknown prctl() option upon which they perform a test function for an
     unprivileged user;

  b. unprivileged triggering of an eBPF program function: similar
     as idea (a).

Example trace_pipe output:

  test-380     [001] .....    78.142904: task_prctl_unknown: option=1234 arg2=101 arg3=102 arg4=103 arg5=104

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Remove "comm".

v2:
* Remove "pid" in trace output (suggested by Steven).
---
 include/trace/events/task.h | 37 +++++++++++++++++++++++++++++++++++++
 kernel/sys.c                |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 47b527464d1a..209d315852fb 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -56,6 +56,43 @@ TRACE_EVENT(task_rename,
 		__entry->newcomm, __entry->oom_score_adj)
 );
 
+/**
+ * task_prctl_unknown - called on unknown prctl() option
+ * @option:	option passed
+ * @arg2:	arg2 passed
+ * @arg3:	arg3 passed
+ * @arg4:	arg4 passed
+ * @arg5:	arg5 passed
+ *
+ * Called on an unknown prctl() option.
+ */
+TRACE_EVENT(task_prctl_unknown,
+
+	TP_PROTO(int option, unsigned long arg2, unsigned long arg3,
+		 unsigned long arg4, unsigned long arg5),
+
+	TP_ARGS(option, arg2, arg3, arg4, arg5),
+
+	TP_STRUCT__entry(
+		__field(	int,		option)
+		__field(	unsigned long,	arg2)
+		__field(	unsigned long,	arg3)
+		__field(	unsigned long,	arg4)
+		__field(	unsigned long,	arg5)
+	),
+
+	TP_fast_assign(
+		__entry->option = option;
+		__entry->arg2 = arg2;
+		__entry->arg3 = arg3;
+		__entry->arg4 = arg4;
+		__entry->arg5 = arg5;
+	),
+
+	TP_printk("option=%d arg2=%ld arg3=%ld arg4=%ld arg5=%ld",
+		  __entry->option, __entry->arg2, __entry->arg3, __entry->arg4, __entry->arg5)
+);
+
 #endif
 
 /* This part must be outside protection */
diff --git a/kernel/sys.c b/kernel/sys.c
index 4da31f28fda8..b366cef102ec 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -75,6 +75,8 @@
 #include <asm/io.h>
 #include <asm/unistd.h>
 
+#include <trace/events/task.h>
+
 #include "uid16.h"
 
 #ifndef SET_UNALIGN_CTL
@@ -2785,6 +2787,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
 		break;
 	default:
+		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
 		break;
 	}
-- 
2.47.0.277.g8800431eea-goog


