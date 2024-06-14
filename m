Return-Path: <linux-kernel+bounces-215257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF97A90904C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4B4286648
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F21A38CD;
	Fri, 14 Jun 2024 16:30:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5AD199398
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382649; cv=none; b=h5c5pDDJAqjyMjM5V4GQO6nt7v2XP8VHLLT3fWe9T2w2FRSgIbwn6cetah81MaxXn8Nbl9Mpoyo3nvOHLxc7yXLqkpjTjFC7/EU6GXBo7cJ8+8sF9GobGeN6LhpeA10wMItQq6rRffFBz6JkuMgPL+c2CX656grSsg00Jl9Rtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382649; c=relaxed/simple;
	bh=ZHBXI+jB6jbRohzJeTq5RKkD6KRiROjXJbEJFW5LzTw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=G22ANm0H/8UDSVJQDKU9UQLbm03HqtTvg47qI11exvy9N+CuGb+/cRsFXFHrFWdNll1FjJRkIIkaaNRFRd7IL+F8Mfd4/dmOZ+UwN7FFpaCGk1B7CGTwO2bOjYgtZb0uxSLWGGW+gKBKEqgYgWzg/w1oOs86Mh08LzAZRalktDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053E0C4AF48;
	Fri, 14 Jun 2024 16:30:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sI9pY-00000001ruQ-0PDS;
	Fri, 14 Jun 2024 12:31:12 -0400
Message-ID: <20240614163111.956572328@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Jun 2024 12:30:26 -0400
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
Subject: [for-next][PATCH 11/13] tracing: Handle old buffer mappings for event strings and functions
References: <20240614163015.456541709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Use the saved text_delta and data_delta of a persistent memory mapped ring
buffer that was saved from a previous boot, and use the delta in the trace
event print output so that strings and functions show up normally.

That is, for an event like trace_kmalloc() that prints the callsite via
"%pS", if it used the address saved in the ring buffer it will not match
the function that was saved in the previous boot if the kernel remaps
itself between boots.

For RCU events that point to saved static strings where only the address
of the string is saved in the ring buffer, it too will be adjusted to
point to where the string is on the current boot.

Link: https://lkml.kernel.org/r/20240612232026.821020753@goodmis.org

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
 kernel/trace/trace.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dc4eee33d920..71cca10581d6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3671,8 +3671,11 @@ static void test_can_verify(void)
 void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			 va_list ap)
 {
+	long text_delta = iter->tr->text_delta;
+	long data_delta = iter->tr->data_delta;
 	const char *p = fmt;
 	const char *str;
+	bool good;
 	int i, j;
 
 	if (WARN_ON_ONCE(!fmt))
@@ -3691,7 +3694,10 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 
 		j = 0;
 
-		/* We only care about %s and variants */
+		/*
+		 * We only care about %s and variants
+		 * as well as %p[sS] if delta is non-zero
+		 */
 		for (i = 0; p[i]; i++) {
 			if (i + 1 >= iter->fmt_size) {
 				/*
@@ -3720,6 +3726,11 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 				}
 				if (p[i+j] == 's')
 					break;
+
+				if (text_delta && p[i+1] == 'p' &&
+				    ((p[i+2] == 's' || p[i+2] == 'S')))
+					break;
+
 				star = false;
 			}
 			j = 0;
@@ -3733,6 +3744,24 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		iter->fmt[i] = '\0';
 		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
 
+		/* Add delta to %pS pointers */
+		if (p[i+1] == 'p') {
+			unsigned long addr;
+			char fmt[4];
+
+			fmt[0] = '%';
+			fmt[1] = 'p';
+			fmt[2] = p[i+2]; /* Either %ps or %pS */
+			fmt[3] = '\0';
+
+			addr = va_arg(ap, unsigned long);
+			addr += text_delta;
+			trace_seq_printf(&iter->seq, fmt, (void *)addr);
+
+			p += i + 3;
+			continue;
+		}
+
 		/*
 		 * If iter->seq is full, the above call no longer guarantees
 		 * that ap is in sync with fmt processing, and further calls
@@ -3751,6 +3780,14 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		/* The ap now points to the string data of the %s */
 		str = va_arg(ap, const char *);
 
+		good = trace_safe_str(iter, str, star, len);
+
+		/* Could be from the last boot */
+		if (data_delta && !good) {
+			str += data_delta;
+			good = trace_safe_str(iter, str, star, len);
+		}
+
 		/*
 		 * If you hit this warning, it is likely that the
 		 * trace event in question used %s on a string that
@@ -3760,8 +3797,7 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		 * instead. See samples/trace_events/trace-events-sample.h
 		 * for reference.
 		 */
-		if (WARN_ONCE(!trace_safe_str(iter, str, star, len),
-			      "fmt: '%s' current_buffer: '%s'",
+		if (WARN_ONCE(!good, "fmt: '%s' current_buffer: '%s'",
 			      fmt, seq_buf_str(&iter->seq.seq))) {
 			int ret;
 
-- 
2.43.0



