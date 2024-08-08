Return-Path: <linux-kernel+bounces-279610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6369C94BF8A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64DFB28667
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032B18E772;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6118E034
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126883; cv=none; b=jjDrFDVpen5RcWKiw9y2QtpVoEFqWcmoL1q6Q0M8CKUC30kYCgqLY/80h5bIPF4VsNXrGvA5nzZtoOx3Sbj0yHr9ZXsqwnJH0QbUcA3LUlcfuoaumunUG5b5Ts90D5PyelIXDRfNID0Zg1A005Q6Z7CF36J5D0033/BDoV8BFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126883; c=relaxed/simple;
	bh=cFZ5Wfyza+azebL5yQgU3MTqo4VywicqKX/Mq8IS7zY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Yn6monbEYCqVnCfgoHzwXujRbA308XFE+HB77xCbNMgDpbGV8YzYibZN0QG99po6axvKaipFX8sJQEGhx8m7OTTunyv3b9TQ2ifeZoJaqbr/MpmWBnk7NMExhkwqH6o9hmtJsjAe0SjltVYrcuFNHeOHphISpJfNj9+8USH3X1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B18C4AF12;
	Thu,  8 Aug 2024 14:21:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sc415-00000000BQY-3i3o;
	Thu, 08 Aug 2024 10:21:23 -0400
Message-ID: <20240808142123.740327307@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 08 Aug 2024 10:20:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 2/9] tracing: Use refcount for trace_event_file reference counter
References: <20240808142037.495820579@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of using an atomic counter for the trace_event_file reference
counter, use the refcount interface. It has various checks to make sure
the reference counting is correct, and will warn if it detects an error
(like refcount_inc() on '0').

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20240726144208.687cce24@rorschach.local.home
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 2 +-
 kernel/trace/trace_events.c  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 9df3e2973626..fed58e54f15e 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -680,7 +680,7 @@ struct trace_event_file {
 	 * caching and such. Which is mostly OK ;-)
 	 */
 	unsigned long		flags;
-	atomic_t		ref;	/* ref count for opened files */
+	refcount_t		ref;	/* ref count for opened files */
 	atomic_t		sm_ref;	/* soft-mode reference counter */
 	atomic_t		tm_ref;	/* trigger-mode reference counter */
 };
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f08fbaf8cad6..7266ec2a4eea 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -992,18 +992,18 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 
 void event_file_get(struct trace_event_file *file)
 {
-	atomic_inc(&file->ref);
+	refcount_inc(&file->ref);
 }
 
 void event_file_put(struct trace_event_file *file)
 {
-	if (WARN_ON_ONCE(!atomic_read(&file->ref))) {
+	if (WARN_ON_ONCE(!refcount_read(&file->ref))) {
 		if (file->flags & EVENT_FILE_FL_FREED)
 			kmem_cache_free(file_cachep, file);
 		return;
 	}
 
-	if (atomic_dec_and_test(&file->ref)) {
+	if (refcount_dec_and_test(&file->ref)) {
 		/* Count should only go to zero when it is freed */
 		if (WARN_ON_ONCE(!(file->flags & EVENT_FILE_FL_FREED)))
 			return;
@@ -3003,7 +3003,7 @@ trace_create_new_event(struct trace_event_call *call,
 	atomic_set(&file->tm_ref, 0);
 	INIT_LIST_HEAD(&file->triggers);
 	list_add(&file->list, &tr->events);
-	event_file_get(file);
+	refcount_set(&file->ref, 1);
 
 	return file;
 }
-- 
2.43.0



