Return-Path: <linux-kernel+bounces-422356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE99D9895
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEF21635D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521E5CA5A;
	Tue, 26 Nov 2024 13:35:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09CB652
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628128; cv=none; b=uxyt6p6vi7bzsVVTA1/VBDGYQLAKUnAKrcvRV78Z6+1YA5Zozp0eiw0sszRuADnM8wJaXUaJa/0NGhfGNHy/loQHC41fdtr15lE00zM/OE+CRXQJmRwhXpBhUxU4qmaWA7P02QuEfwWswhMmjB6cS9K2cgFrWmYgZBgxV2Hur9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628128; c=relaxed/simple;
	bh=mD6T0KzAr+GxJs1Ts0FAm9TI0qxcxb+omjemism4Zzw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R+zX/gLRSIXRIa/c9Q0P0t75NaR+2UgzCM1uGbGXXLsnQroJXF3TDgOEObYwLORMYCH77f1l4jc7cYjpjy6hbFGjJDaR3LmJX6moIL33pFQAW6BIy8jCVlYJF3zVc74ep0u0JraelPwmu3HgHb7JdysKeSuOFZrSarURLKE5lss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E411DC4CECF;
	Tue, 26 Nov 2024 13:35:24 +0000 (UTC)
Date: Tue, 26 Nov 2024 08:36:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [for-next][PATCH] tracing: Use guard() rather than scoped_guard()
Message-ID: <20241126083614.29ae8296@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 2bd9b57d04df417f31ef54448477c212fcdd14fc


Mathieu Desnoyers (1):
      tracing: Use guard() rather than scoped_guard()

----
 include/linux/tracepoint.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
---------------------------
commit 2bd9b57d04df417f31ef54448477c212fcdd14fc
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Nov 25 09:25:14 2024 -0500

    tracing: Use guard() rather than scoped_guard()
    
    Using scoped_guard() in the implementation of trace_##name() adds an
    unnecessary level of indentation.
    
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Michael Jeanson <mjeanson@efficios.com>
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Yonghong Song <yhs@fb.com>
    Cc: Paul E. McKenney <paulmck@kernel.org>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
    Cc: bpf@vger.kernel.org
    Cc: Joel Fernandes <joel@joelfernandes.org>
    Cc: Jordan Rife <jrife@google.com>
    Link: https://lore.kernel.org/20241125142514.2897143-1-mathieu.desnoyers@efficios.com
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index b2633a72e871..e398f6e43f61 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -259,8 +259,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	{								\
 		if (static_branch_unlikely(&__tracepoint_##name.key)) { \
 			if (cond) {					\
-				scoped_guard(preempt_notrace)		\
-					__DO_TRACE_CALL(name, TP_ARGS(args)); \
+				guard(preempt_notrace)();		\
+				__DO_TRACE_CALL(name, TP_ARGS(args));	\
 			}						\
 		}							\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
@@ -275,8 +275,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	{								\
 		might_fault();						\
 		if (static_branch_unlikely(&__tracepoint_##name.key)) {	\
-			scoped_guard(rcu_tasks_trace)			\
-				__DO_TRACE_CALL(name, TP_ARGS(args));	\
+			guard(rcu_tasks_trace)();			\
+			__DO_TRACE_CALL(name, TP_ARGS(args));		\
 		}							\
 		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
 			WARN_ONCE(!rcu_is_watching(),			\

