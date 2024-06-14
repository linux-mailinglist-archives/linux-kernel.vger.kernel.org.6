Return-Path: <linux-kernel+bounces-215258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3C909076
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B3FB23575
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ED01A2FDC;
	Fri, 14 Jun 2024 16:30:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BA19AA63
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382649; cv=none; b=mlp4pPbWuLpd30qFTYPcLyDnBOElsdW4vqSHJlBX1IAaSRjUsrM7vzkJfP6FnsB/Rj6E4cbpwA7wYm46RFuglX6snnKeoDShrJaCBxo0dUX5MWYIZvi9tAsc+CAHQ4qLl48yCCLBgwel21PBjeQ7gWwJj1XcH3HCrRkchZlh7Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382649; c=relaxed/simple;
	bh=38sgmhfaC11CHfg5sJR54fmYseuWqVfHviXjrc4UeHQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QAfw+A58mqR1X8L3VQ6Rjuky4fF3RN0ejcBL0Fu72FuBgk4vQW5Rmz+WUpwR4o2J+eys3/VN0mYMWR8MSUeB+2kzmGCqtSfr0cIYkX9O+2UOaIndUlvrNQ47efOQFsyHZDmwwE/bTTq2OktOpu1NFQEkRd9ZE9NXvBNiKa9K7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2389FC4AF66;
	Fri, 14 Jun 2024 16:30:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sI9pY-00000001ruv-16o7;
	Fri, 14 Jun 2024 12:31:12 -0400
Message-ID: <20240614163112.116777739@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Jun 2024 12:30:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 Kees Cook <keescook@chromium.org>
Subject: [for-next][PATCH 12/13] tracing: Update function tracing output for previous boot buffer
References: <20240614163015.456541709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

For a persistent ring buffer that is saved across boots, if function
tracing was performed in the previous boot, it only saves the address of
the functions and uses "%pS" to print their names. But the current boot,
those functions may be in different locations. The persistent meta-data
saves the text delta between the two boots and can be used to find the
address of the saved function of where it is located in the current boot.

Link: https://lkml.kernel.org/r/20240612232026.988226055@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineeth Pillai <vineeth@bitbyteword.org>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d8b302d01083..b9d2c64c0648 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -990,8 +990,11 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
 }
 
 static void print_fn_trace(struct trace_seq *s, unsigned long ip,
-			   unsigned long parent_ip, int flags)
+			   unsigned long parent_ip, long delta, int flags)
 {
+	ip += delta;
+	parent_ip += delta;
+
 	seq_print_ip_sym(s, ip, flags);
 
 	if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
@@ -1009,7 +1012,7 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1674,7 +1677,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
 	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
 	trace_print_time(s, iter,
 			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
-- 
2.43.0



