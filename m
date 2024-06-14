Return-Path: <linux-kernel+bounces-215259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C008D90904B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30C61C232E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B105E1A2FD5;
	Fri, 14 Jun 2024 16:30:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6619ADAE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382649; cv=none; b=BX3kiqMbFyXbpuV6CJhoLh33DLbYzy1dT2+0nzNS5jPX5AnDaxbBYW4oU/AGsZ3eS2JdBQNeXIJayHnwOvfRov5nAZTIy5f/JfP6Topplz9TKWsGEEqq36dZOVoOJ+jPERBTMO5ZI0xzEw9KZjbsQZoFo51e9Ya+5B1uX5JJshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382649; c=relaxed/simple;
	bh=yhZWfxQ07Xgl1GfOLtClcFtEAGRqH3tUEM+G2XMRyDc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WFS+hQ/JrcHcEEzN7rE+qSXtSOzW7q+/3PDGJmaLJbsJoEyjEiKcnVqpURYEkkbWsdU/ue/Vqg7cKqSQkqpy45TrUmSW5Pe54W31U6y1Bah1ErLG2jKFLpZHqcAjEMKgzmRkLc0QkfPgpWdUrhB4w4tzK61W25NZOziC4Of4r4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525E2C4DDE4;
	Fri, 14 Jun 2024 16:30:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sI9pY-00000001rvQ-1mUy;
	Fri, 14 Jun 2024 12:31:12 -0400
Message-ID: <20240614163112.285102247@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Jun 2024 12:30:28 -0400
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
Subject: [for-next][PATCH 13/13] tracing: Add last boot delta offset for stack traces
References: <20240614163015.456541709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The addresses of a stack trace event are relative to the kallsyms. As that
can change between boots, when printing the stack trace from a buffer that
was from the last boot, it needs all the addresses to be added to the
"text_delta" that gives the delta between the addresses of the functions
for the current boot compared to the address of the last boot. Then it can
be passed to kallsyms to find the function name, otherwise it just shows a
useless list of addresses.

Link: https://lkml.kernel.org/r/20240612232027.145807384@goodmis.org

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
 kernel/trace/trace_output.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b9d2c64c0648..48de93598897 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1233,6 +1233,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	unsigned long *p;
 	unsigned long *end;
+	long delta = iter->tr->text_delta;
 
 	trace_assign_type(field, iter->ent);
 	end = (unsigned long *)((long)iter->ent + iter->ent_size);
@@ -1245,7 +1246,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			break;
 
 		trace_seq_puts(s, " => ");
-		seq_print_ip_sym(s, *p, flags);
+		seq_print_ip_sym(s, (*p) + delta, flags);
 		trace_seq_putc(s, '\n');
 	}
 
-- 
2.43.0



