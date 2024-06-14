Return-Path: <linux-kernel+bounces-215253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC390905B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC1B20CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F54819E7FF;
	Fri, 14 Jun 2024 16:30:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAC19580B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382648; cv=none; b=Ik3/HEICTPbNIBIqOE60yWnnYi5rGLxAro8zVP4d7nB71ed3vL1KOgBfee6O7edgDFfyMloa54/3OOZNz9dGqegQTbKX4cqtumjVvf94JeHpOiihH6fYUCJotj6MbDOTs/aBwFwakTJkBf7DFk9Wequok6vDTYc+/gwfbFntnPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382648; c=relaxed/simple;
	bh=kPa3hw6mnCS/htycpj8NYHDRuDYoDTuQOPQ2D4T2dvM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZT9rL42gg0yeDj/TcWAgIHvZEPUoQvWo6kD9ctbWW+7PMsE/ASfGDd6Lf9y3H+fi1VX2LwiA8Gcxmn3q6Fwd9yUD7MO/aK6lg73+JvACH/8e8atfGsrLvFOsXO3FetZlBKH8uTaNDZ+2xylEs3W9IPvXmarZAqfJn/XBeBJDGuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA995C4DE00;
	Fri, 14 Jun 2024 16:30:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sI9pX-00000001rtP-3Fmn;
	Fri, 14 Jun 2024 12:31:11 -0400
Message-ID: <20240614163111.633961228@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Jun 2024 12:30:24 -0400
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
Subject: [for-next][PATCH 09/13] ring-buffer: Save text and data locations in mapped meta data
References: <20240614163015.456541709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When a ring buffer is mapped to a specific address, save the address of a
text function and some data. This will be used to determine the delta
between the last boot and the current boot for pointers to functions as
well as to data.

Link: https://lkml.kernel.org/r/20240612232026.496176678@goodmis.org

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
 kernel/trace/ring_buffer.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 804dfbdeef84..8c287430411d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -45,6 +45,8 @@
 static void update_pages_handler(struct work_struct *work);
 
 struct ring_buffer_meta {
+	unsigned long	text_addr;
+	unsigned long	data_addr;
 	unsigned long	first_buffer;
 	unsigned long	head_buffer;
 	unsigned long	commit_buffer;
@@ -542,6 +544,9 @@ struct trace_buffer {
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
 
+	long				last_text_delta;
+	long				last_data_delta;
+
 	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
 	unsigned int			max_data_size;
@@ -1821,10 +1826,15 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
+/* Used to calculate data delta */
+static char rb_data_ptr[] = "";
+
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
 	struct ring_buffer_meta *meta;
 	unsigned long delta;
+	unsigned long this_text = (unsigned long)rb_range_meta_init;
+	unsigned long this_data = (unsigned long)rb_data_ptr;
 	void *subbuf;
 	int cpu;
 	int i;
@@ -1841,6 +1851,10 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 			meta->first_buffer += delta;
 			meta->head_buffer += delta;
 			meta->commit_buffer += delta;
+			buffer->last_text_delta = this_text - meta->text_addr;
+			buffer->last_data_delta = this_data - meta->data_addr;
+			meta->text_addr = this_text;
+			meta->data_addr = this_data;
 			continue;
 		}
 
@@ -1857,6 +1871,8 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 		subbuf = rb_subbufs_from_meta(meta);
 
 		meta->first_buffer = (unsigned long)subbuf;
+		meta->text_addr = this_text;
+		meta->data_addr = this_data;
 
 		/*
 		 * The buffers[] array holds the order of the sub-buffers
-- 
2.43.0



