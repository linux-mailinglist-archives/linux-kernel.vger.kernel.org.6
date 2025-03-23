Return-Path: <linux-kernel+bounces-572833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72902A6CF31
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BDF170591
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A02206A3;
	Sun, 23 Mar 2025 12:29:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31C20C039
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732952; cv=none; b=WMJuqPVOLhwdHFG2fjC//3lx5XI/hDaPSj3vG1e1shV2Plp7C6HdVl6b9spPWZ7Id1KiVoINnJyqOkbpc3tCAxByEJ+bWUlN2IM/m1UjG7i/H71fIQdeusgRuEtw4qkp4BofHqluevemQynCgW90A7d5T6TtCF/pTH1FjRV7aVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732952; c=relaxed/simple;
	bh=kQE7lWjLc5+4FxD4hTC5SbZ6DD1VpQnZCqJXFz/ycLI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Zscv6N+nRk1LY8ehRuUwwHYECA4MQ/IAhqDxdYf/aNxzNNlDVI3a8Gi1osJTrAggsGZmFB43BVK9SQY5SyfSuEiwmpYX7AflAQD69CLD5iM5rdezKkoM3gA2u5bhSD+8B4Px61PJGcBHMdFCq5jn7sdTdxxcqkHumyc4nld4Z8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DCEC4CEF8;
	Sun, 23 Mar 2025 12:29:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twKSc-00000001yiC-3eEJ;
	Sun, 23 Mar 2025 08:29:50 -0400
Message-ID: <20250323122950.727283891@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 08:29:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [for-next][PATCH 10/10] tracing: Fix synth event printk format for str fields
References: <20250323122933.407277911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Douglas Raillard <douglas.raillard@arm.com>

The printk format for synth event uses "%.*s" to print string fields,
but then only passes the pointer part as var arg.

Add the missing precision var arg.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250318180939.227696-1-douglas.raillard@arm.com
Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 463b0073629a..d91205bc9f61 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -620,7 +620,8 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
 		if (event->fields[i]->is_string &&
 		    event->fields[i]->is_dynamic)
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
-				", __get_str(%s)", event->fields[i]->name);
+				", (int)__get_dynamic_array_len(%s), __get_str(%s)",
+				event->fields[i]->name, event->fields[i]->name);
 		else if (event->fields[i]->is_stack)
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 				", __get_stacktrace(%s)", event->fields[i]->name);
-- 
2.47.2



