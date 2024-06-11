Return-Path: <linux-kernel+bounces-210511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764AD9044A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA4428823C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D2A15622F;
	Tue, 11 Jun 2024 19:28:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACE152DF1;
	Tue, 11 Jun 2024 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134133; cv=none; b=J/0Ex3PrY2apdjGOnUcowYHy8ktdTkvgJkmLvaMtXm5qYDy4+RwxFVJxoElsoyEeIOjX6lAVhgk25Gdnnk4nHbMrZtPdw/eKD6PZsN523swqy3thgU/7G7WelkzcLh+MAMvuYfFaQvNeyTkCevS14hZoQKITCwuC/c1N4WqEwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134133; c=relaxed/simple;
	bh=5vY8upmAWCSCeuI23auVBMfapEFPUJFegpBwQdZuq6o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AY4KtWNnNyGz6eWl2rWwosdX1+rEntkx4ardpqYMpTc/giXZtXmtmgO46Khk4XwzW4gts9OLtdsS5lpu4OQjHf1Zn2J9fuuXIP3/WOSDt+5juix2z945F64/SkIooFucEs9twUXiM05lY/D3DtNqKaEQ9oTqJzLXkqUJdWk2R+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE75AC4AF49;
	Tue, 11 Jun 2024 19:28:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sH7B7-00000001Tvw-1s67;
	Tue, 11 Jun 2024 15:29:09 -0400
Message-ID: <20240611192909.310647031@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 15:28:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
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
Subject: [PATCH v4 13/13] tracing: Add last boot delta offset for stack traces
References: <20240611192828.691638177@goodmis.org>
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



