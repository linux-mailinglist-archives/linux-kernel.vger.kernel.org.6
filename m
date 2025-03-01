Return-Path: <linux-kernel+bounces-540040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95CDA4ACD3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E7B189732C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0861E51F5;
	Sat,  1 Mar 2025 16:22:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515011E25E3
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740846153; cv=none; b=ek8FYn1X34Oef6fcOqkph53nzgMvU1vdPMP797AKtZVOxoDffQHo+cDp7Vn7FyNrkkvliCA6i1GzmsQz2K4iVi2rUTGfUN1+sD5li2wbcoeV3er7+UJZZqsSwWRARaIXVvBycSUVbZEj977MledDkCUVIRDjtmIMLf37kikun7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740846153; c=relaxed/simple;
	bh=t5EvaYWoI5FL3vzeHxx/tNJOe/m4FapskxyeKZrfXM0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QQ/yJOHwq6TVSf9GrMhHCaMyG47mLjN05ga8v6uyrdUT5kHMFomb30xV6ipliUfufwLqhvF6PzMVpbHFvZLoul5ufAUR6rHZaEqnluMYqb6cCGusMw7YgNJJEQ7k/4cnmvz6SULb9Ec5mRX5/CzHnSTYOxjKe85tKIuCsco0XyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A75C4CEE2;
	Sat,  1 Mar 2025 16:22:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1toPcX-0000000Agxg-0HaL;
	Sat, 01 Mar 2025 11:23:21 -0500
Message-ID: <20250301162320.918285043@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Mar 2025 11:23:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hengqi Chen <hengqi.chen@gmail.com>
Subject: [for-next][PATCH 2/3] tracing: Remove orphaned event_trace_printk
References: <20250301162258.654648143@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Hengqi Chen <hengqi.chen@gmail.com>

The event_trace_printk macro has no callers since commit
b8e65554d80b ("tracing: remove deprecated TRACE_FORMAT").
So drop it.

Link: https://lore.kernel.org/20250213113951.813258-1-hengqi.chen@gmail.com
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5caea596fef0..fa9cf4292dff 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -859,24 +859,6 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		const char *event, bool enable);
-/*
- * The double __builtin_constant_p is because gcc will give us an error
- * if we try to allocate the static variable to fmt if it is not a
- * constant. Even with the outer if statement optimizing out.
- */
-#define event_trace_printk(ip, fmt, args...)				\
-do {									\
-	__trace_printk_check_format(fmt, ##args);			\
-	tracing_record_cmdline(current);				\
-	if (__builtin_constant_p(fmt)) {				\
-		static const char *trace_printk_fmt			\
-		  __section("__trace_printk_fmt") =			\
-			__builtin_constant_p(fmt) ? fmt : NULL;		\
-									\
-		__trace_bprintk(ip, trace_printk_fmt, ##args);		\
-	} else								\
-		__trace_printk(ip, fmt, ##args);			\
-} while (0)
 
 #ifdef CONFIG_PERF_EVENTS
 struct perf_event;
-- 
2.47.2



