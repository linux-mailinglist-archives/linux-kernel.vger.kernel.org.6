Return-Path: <linux-kernel+bounces-566724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33AFA67BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7602E1896E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8563E212F82;
	Tue, 18 Mar 2025 18:09:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A49FEACD;
	Tue, 18 Mar 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321394; cv=none; b=ZEv+8ijfjOWVEIFNs2ga7EVFtvp1feRj8edrqebChv8Vl01LEZkir0kbEO1RZROnGoY5FduMWgNal+x7JaXZC7s7wzNSSBWiBupybQDdA5lSpr9I1jki/GsLRnYv10R4mX/IbHMwqJfF4PyloQoxyhCK+NY4DT7ph3aH5JoHtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321394; c=relaxed/simple;
	bh=j2USuNtKynOfTt0kkhPFVKse5rfuH9138xAYkMcmjzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3dKtr3tn1H1Z2uXtqVXPWsN/Q3QhFjxOURMcVXzQuSkEXC4kx1v99iFcVf1eGUNdJDnTZ0uWV62KXNxSnkl/4no5Dol3sawoCdAjbkJHbDEiLnEZdtWtOqBCOKj18maLmcpQCJS9zAykY+7AqU6vIuEj2cGm/0/5v+C4M1vhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECA2613D5;
	Tue, 18 Mar 2025 11:09:56 -0700 (PDT)
Received: from e132430.arm.com (unknown [10.57.85.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1951D3F694;
	Tue, 18 Mar 2025 11:09:46 -0700 (PDT)
From: Douglas RAILLARD <douglas.raillard@arm.com>
To: rostedt@goodmis.org
Cc: douglas.raillard@arm.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix synth event printk format for str fields
Date: Tue, 18 Mar 2025 18:09:38 +0000
Message-ID: <20250318180939.227696-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Douglas Raillard <douglas.raillard@arm.com>

The printk format for synth event uses "%.*s" to print string fields,
but then only passes the pointer part as var arg.

Add the missing precision var arg.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 kernel/trace/trace_events_synth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e3f7d09e5512..274b9b1d9f7d 100644
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
2.43.0


