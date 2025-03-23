Return-Path: <linux-kernel+bounces-572829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0BA6CF2F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B9D170384
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950C214A8C;
	Sun, 23 Mar 2025 12:29:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF7205AC7
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732951; cv=none; b=m7Fqic18Dr84cx4kXkdw8fnk6a7PUdLgOsIortbAsA35lHl0bhZKEhUTGO08JN1TxNO+GP3UvjSfPFATocBSq83p0hrM8J36OYuCz8w+n5BZh0FNZ08gmLLdOyqr+skSO7LMzatrX0I5wEtiVtZ9yB8kVPJseydKmG0357m2Bbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732951; c=relaxed/simple;
	bh=i5XarV9KCEDCcdJI/pujoKeQy3eMNiCv9+BoZzU3Qhk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=R09GCoN+meW/FaDP425n/nqmO9FmujZWXd/K2W3oLc6Kp40G19kMHP7dh5A0XNtk5L33aoIZ8jEmkbkYN/XzylA5ilSwcNA1jEiQrNsA4GyBpvbtahEMFsu5fnK0dCFxkl1KX+lmDhApduTDXXfUtwABPYD4TQP1/puXU7BePn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4161C4CEED;
	Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twKSc-00000001yfi-09sb;
	Sun, 23 Mar 2025 08:29:50 -0400
Message-ID: <20250323122949.894511377@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 08:29:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sasha Levin <sashal@kernel.org>
Subject: [for-next][PATCH 05/10] tracing: Use hashtable.h for event_hash
References: <20250323122933.407277911@goodmis.org>
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

Link: https://lore.kernel.org/20250319190545.3058319-1-sashal@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 03d56f711ad1..3144d020e6c6 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -12,15 +12,16 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
 #include <linux/idr.h>
+#include <linux/hashtable.h>
 
 #include "trace_output.h"
 
-/* must be a power of 2 */
-#define EVENT_HASHSIZE	128
+/* 2^7 = 128 */
+#define EVENT_HASH_BITS 7
 
 DECLARE_RWSEM(trace_event_sem);
 
-static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
+static DEFINE_HASHTABLE(event_hash, EVENT_HASH_BITS);
 
 enum print_line_t trace_print_bputs_msg_only(struct trace_iterator *iter)
 {
@@ -694,11 +695,8 @@ int trace_print_lat_context(struct trace_iterator *iter)
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
@@ -753,7 +751,6 @@ void trace_event_read_unlock(void)
  */
 int register_trace_event(struct trace_event *event)
 {
-	unsigned key;
 	int ret = 0;
 
 	down_write(&trace_event_sem);
@@ -786,9 +783,7 @@ int register_trace_event(struct trace_event *event)
 	if (event->funcs->binary == NULL)
 		event->funcs->binary = trace_nop_print;
 
-	key = event->type & (EVENT_HASHSIZE - 1);
-
-	hlist_add_head(&event->node, &event_hash[key]);
+	hash_add(event_hash, &event->node, event->type);
 
 	ret = event->type;
  out:
@@ -803,7 +798,7 @@ EXPORT_SYMBOL_GPL(register_trace_event);
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



