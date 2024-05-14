Return-Path: <linux-kernel+bounces-178926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2297E8C5982
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0031F2503C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7218130D;
	Tue, 14 May 2024 16:15:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D017F398
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703298; cv=none; b=eiiNnieCPMNw1K0TwGaE7QGqCWgIMb91UdEXnd8nHqx7G+u8CCsYx6Tl31VOnFIQ6THBkUkFqRV2NFXerpJIq7MTFf1mJS/mA/Ot+Q31S44SerWCTI/2Kbb8YReGUQmcqXOya5g62P6ywrkoietL+O5ZNolVhR7bhbFbBCcijFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703298; c=relaxed/simple;
	bh=MvNAZ74hBU+Fb/X1FXSdnkak+RI3JAKgG+xFxCEFthg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b1UC2JSfENhro9un3+1Ku87YgcdAscLjRaT56c/CBiRMCbhKnu06TQLVHO4ndmH/XlnCXCjLBPy8SQ9IayCISr5JT6IPR3Thr2sjdFseVePbl/7aIH1IVuFVbB2NgXDc6ipT/4Hpts5rMXSiePwsmcsrOgCCA5gvLB/Pjy7SegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B7DC2BD11;
	Tue, 14 May 2024 16:14:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6uoE-00000003t4S-2Z9j;
	Tue, 14 May 2024 12:15:22 -0400
Message-ID: <20240514161522.476351844@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:14:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [for-next][PATCH 4/7] ftrace: Remove unused list ftrace_direct_funcs
References: <20240514161438.134250861@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Commit 8788ca164eb4b ("ftrace: Remove the legacy _ftrace_direct API")
stopped using 'ftrace_direct_funcs' (and the associated
struct ftrace_direct_func).  Remove them.

Build tested only (on x86-64 with FTRACE and DYNAMIC_FTRACE
enabled)

Link: https://lore.kernel.org/linux-trace-kernel/20240504132303.67538-1-linux@treblig.org

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 1 -
 kernel/trace/ftrace.c  | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 54d53f345d14..b01cca36147f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -83,7 +83,6 @@ static inline void early_trace_init(void) { }
 
 struct module;
 struct ftrace_hash;
-struct ftrace_direct_func;
 
 #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_MODULES) && \
 	defined(CONFIG_DYNAMIC_FTRACE)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9223513414a..4613bf67ef2c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5318,14 +5318,6 @@ ftrace_set_addr(struct ftrace_ops *ops, unsigned long *ips, unsigned int cnt,
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
-struct ftrace_direct_func {
-	struct list_head	next;
-	unsigned long		addr;
-	int			count;
-};
-
-static LIST_HEAD(ftrace_direct_funcs);
-
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
 /*
-- 
2.43.0



