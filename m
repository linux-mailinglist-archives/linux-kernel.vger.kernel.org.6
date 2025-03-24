Return-Path: <linux-kernel+bounces-574457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE8A6E592
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670821739B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A061E5B7C;
	Mon, 24 Mar 2025 21:17:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683CD1DE8A3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851075; cv=none; b=trnk0LwmWZJvHRPbSwUOtzCnZf06NmgJUzjv3YAH8q+td5qPo9/GwkJikNuEHcxDYXRTRGq3ByTucIlqBHvddvRE6P5lAkE+i6LYDA8Jq4FZF4pWZ2zZ2ZcZ1LD3nZcn6jQWtfWvOa9Z2dkiRUwYc4a8n5k0GuSyZtB++Uyj7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851075; c=relaxed/simple;
	bh=VJZAN0fwL3zSxjDC4mGtPIZ020Fz1tf7o/Urck4bUcs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FOePGj1gzlV6dkl5/XxFq7OLgVUtGnwJ2wEK5CZEUui+X44TT3YJ4P0CLij7GF0uEifZGO4wppylNwPGxgL/Y8vEXCsgI34i3dP3jGGI/xHC7YGz5cf397iWDOszqKbls0zBo8Y9LrsxbULnRpbAow3FkMiz9poIMaWLV7Cb1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA11C4CEF2;
	Mon, 24 Mar 2025 21:17:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twpBt-00000002Ado-2l4d;
	Mon, 24 Mar 2025 17:18:37 -0400
Message-ID: <20250324211837.513945060@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 24 Mar 2025 17:18:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sasha Levin <sashal@kernel.org>
Subject: [for-next][PATCH 3/3] tracing: Use hashtable.h for event_hash
References: <20250324211821.731702961@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sasha Levin <sashal@kernel.org>

Convert the event_hash array in trace_output.c to use the generic
hashtable implementation from hashtable.h instead of the manually
implemented hash table.

This simplifies the code and makes it more maintainable by using the
standard hashtable API defined in hashtable.h.

Rename EVENT_HASHSIZE to EVENT_HASH_BITS to properly reflect its new
meaning as the number of bits for the hashtable size.

Link: https://lore.kernel.org/20250323132800.3010783-1-sashal@kernel.org
Link: https://lore.kernel.org/20250319190545.3058319-1-sashal@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b51ee9373773..72b699f909e8 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -14,16 +14,17 @@
 #include <linux/idr.h>
 #include <linux/btf.h>
 #include <linux/bpf.h>
+#include <linux/hashtable.h>
 
 #include "trace_output.h"
 #include "trace_btf.h"
 
-/* must be a power of 2 */
-#define EVENT_HASHSIZE	128
+/* 2^7 = 128 */
+#define EVENT_HASH_BITS 7
 
 DECLARE_RWSEM(trace_event_sem);
 
-static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
+static DEFINE_HASHTABLE(event_hash, EVENT_HASH_BITS);
 
 enum print_line_t trace_print_bputs_msg_only(struct trace_iterator *iter)
 {
@@ -779,11 +780,8 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 struct trace_event *ftrace_find_event(int type)
 {
 	struct trace_event *event;
-	unsigned key;
 
-	key = type & (EVENT_HASHSIZE - 1);
-
-	hlist_for_each_entry(event, &event_hash[key], node) {
+	hash_for_each_possible(event_hash, event, node, type) {
 		if (event->type == type)
 			return event;
 	}
@@ -838,7 +836,6 @@ void trace_event_read_unlock(void)
  */
 int register_trace_event(struct trace_event *event)
 {
-	unsigned key;
 	int ret = 0;
 
 	down_write(&trace_event_sem);
@@ -871,9 +868,7 @@ int register_trace_event(struct trace_event *event)
 	if (event->funcs->binary == NULL)
 		event->funcs->binary = trace_nop_print;
 
-	key = event->type & (EVENT_HASHSIZE - 1);
-
-	hlist_add_head(&event->node, &event_hash[key]);
+	hash_add(event_hash, &event->node, event->type);
 
 	ret = event->type;
  out:
@@ -888,7 +883,7 @@ EXPORT_SYMBOL_GPL(register_trace_event);
  */
 int __unregister_trace_event(struct trace_event *event)
 {
-	hlist_del(&event->node);
+	hash_del(&event->node);
 	free_trace_event_type(event->type);
 	return 0;
 }
-- 
2.47.2



