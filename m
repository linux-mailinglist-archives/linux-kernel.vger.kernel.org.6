Return-Path: <linux-kernel+bounces-204247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A6A8FE63C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0BF1F22D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1030197555;
	Thu,  6 Jun 2024 12:11:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F2195F2A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675861; cv=none; b=HwUkRUaI+iENkTnY5GR3K6HmAK0/IMCXfav0Ptke8noGyZ5dhFrDAyFDRm5WuocrBAz/8Kg5BSocgFLTAEYICGxbiTQpogruGbbzoKdXnE/kWdO9Sknt8quTQvmbDjQpqh84jxghXKtE1WdxVWsPE3bgHRrm/lMEIVRs8TygM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675861; c=relaxed/simple;
	bh=NJYbbejIctt8G+auynjs7BQD1BTTaaHXR8rDk7HRzc0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FpQVlr6OG4/h0DiZxwvsjMPerZmePQhjtJ7R3pVbPUJlltSYxGRlSfBr9Y8iDwHplziohePMOW8WxuyDZg5Pff1sZcY1DdXPEPRbGcnH4ejiSTrxlrcodzbwQexZI3O9oPQW52ZgUlmkKaYraN528JQRn3SjyXSqbNhCXbhd19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A94C4AF0C;
	Thu,  6 Jun 2024 12:11:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxR-00000000nLo-2ink;
	Thu, 06 Jun 2024 08:11:05 -0400
Message-ID: <20240606121105.511202862@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 07/15] ftrace: Add comments to ftrace_hash_move() and friends
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Describe what ftrace_hash_move() does and add some more comments to some
other functions to make it easier to understand.

Link: https://lore.kernel.org/linux-trace-kernel/20240605180409.179520305@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 256b5e07c39a..9c4d01b1bb68 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -169,6 +169,7 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 #endif
 }
 
+/* Call this function for when a callback filters on set_ftrace_pid */
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			    struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
@@ -1318,7 +1319,7 @@ static struct ftrace_hash *alloc_ftrace_hash(int size_bits)
 	return hash;
 }
 
-
+/* Used to save filters on functions for modules not loaded yet */
 static int ftrace_add_mod(struct trace_array *tr,
 			  const char *func, const char *module,
 			  int enable)
@@ -1430,6 +1431,7 @@ static struct ftrace_hash *__move_hash(struct ftrace_hash *src, int size)
 	return new_hash;
 }
 
+/* Move the @src entries to a newly allocated hash */
 static struct ftrace_hash *
 __ftrace_hash_move(struct ftrace_hash *src)
 {
@@ -1444,6 +1446,26 @@ __ftrace_hash_move(struct ftrace_hash *src)
 	return __move_hash(src, size);
 }
 
+/**
+ * ftrace_hash_move - move a new hash to a filter and do updates
+ * @ops: The ops with the hash that @dst points to
+ * @enable: True if for the filter hash, false for the notrace hash
+ * @dst: Points to the @ops hash that should be updated
+ * @src: The hash to update @dst with
+ *
+ * This is called when an ftrace_ops hash is being updated and the
+ * the kernel needs to reflect this. Note, this only updates the kernel
+ * function callbacks if the @ops is enabled (not to be confused with
+ * @enable above). If the @ops is enabled, its hash determines what
+ * callbacks get called. This function gets called when the @ops hash
+ * is updated and it requires new callbacks.
+ *
+ * On success the elements of @src is moved to @dst, and @dst is updated
+ * properly, as well as the functions determined by the @ops hashes
+ * are now calling the @ops callback function.
+ *
+ * Regardless of return type, @src should be freed with free_ftrace_hash().
+ */
 static int
 ftrace_hash_move(struct ftrace_ops *ops, int enable,
 		 struct ftrace_hash **dst, struct ftrace_hash *src)
-- 
2.43.0



