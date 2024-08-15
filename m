Return-Path: <linux-kernel+bounces-288311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11989538A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7211F21A78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A846C1BBBC4;
	Thu, 15 Aug 2024 16:57:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9351BB697
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741076; cv=none; b=qNdKiDacWDO1ZH6dwuxhBz1O9M1VBp+oIG1PL8Bdy0jr8LjH/onleTtqZMTHuVkU0Ikn+gbZqiINqZy0kWUsh4X5WVIWW7oUai6TixB/ashFDjs8WkFQPvQ34Nb67tTIHgPJQOgYvi2JY/H9mhxEXdLzyrCgFK2w0GVAMvwqafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741076; c=relaxed/simple;
	bh=6JCQMt+lgOieYsZiLCsf2KFHCxW1t5SuiWyQPYDXbrg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eZnA+CuD+eKMG9BRbvchuXrv51VYeu6od9hX1O3JlirltFHjyfvfJsmMngydwmtT3QB0jzmztxVT8BVCUfuK7GlxqsMGOjOL+ar7QqZBJcBp9Xk2ITAOnsKpDrloZTOwTUs/llRcaDsLxZPd2qOMIImu/Q/GYt+9po/fb2OqDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC6CC4AF10;
	Thu, 15 Aug 2024 16:57:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sedng-00000001uLU-1AOo;
	Thu, 15 Aug 2024 12:58:12 -0400
Message-ID: <20240815165812.138795645@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 15 Aug 2024 12:57:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ross Zwisler <zwisler@google.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 2/3] tracing: Allow boot instances to use reserve_mem boot memory
References: <20240815165744.699054530@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Allow boot instances to use memory reserved by the reserve_mem boot
option.

  reserve_mem=12M:4096:trace  trace_instance=boot_mapped@trace

The above will allocate 12 megs with 4096 alignment and label it "trace".
The second parameter will create a "boot_mapped" instance and use the
memory reserved and labeled as "trace" as the memory for the ring buffer.

That will create an instance called "boot_mapped":

  /sys/kernel/tracing/instances/boot_mapped

Note, because the ring buffer is using a defined memory ranged, it will
act just like a memory mapped ring buffer. It will not have a snapshot
buffer, as it can't swap out the buffer. The snapshot files as well as any
tracers that uses a snapshot will not be present in the boot_mapped
instance.

Also note that reserve_mem is not reliable in acquiring the same physical
memory at each soft reboot. It is possible that KALSR could map the kernel
at the previous boot memory location forcing the reserve_mem to return a
different memory location. In this case, the previous ring buffer will be
lost.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20240815082811.669f7d8c@gandalf.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         | 13 +++++++++++
 kernel/trace/trace.c                          | 23 ++++++++++++-------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 35b592823338..388653448e72 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6752,6 +6752,19 @@
 			memory at 0x284500000 that is 12Megs. The per CPU buffers of that
 			instance will be split up accordingly.
 
+			Alternatively, the memory can be reserved by the reserve_mem option:
+
+				reserve_mem=12M:4096:trace trace_instance=boot_map@trace
+
+			This will reserve 12 megabytes at boot up with a 4096 byte alignment
+			and place the ring buffer in this memory. Note that due to KASLR, the
+			memory may not be the same location each time, which will not preserve
+			the buffer content.
+
+			Also note that the layout of the ring buffer data may change between
+			kernel versions where the validator will fail and reset the ring buffer
+			if the layout is not the same as the previous kernel.
+
 	trace_options=[option-list]
 			[FTRACE] Enable or disable tracer options at boot.
 			The option-list is a comma delimited list of options
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8e5a4ca9fd70..9bcef199ae90 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10465,22 +10465,20 @@ __init static void enable_instances(void)
 	str = boot_instance_info;
 
 	while ((curr_str = strsep(&str, "\t"))) {
-		unsigned long start = 0;
-		unsigned long size = 0;
+		phys_addr_t start = 0;
+		phys_addr_t size = 0;
 		unsigned long addr = 0;
 
 		tok = strsep(&curr_str, ",");
 		name = strsep(&tok, "@");
-		if (tok) {
+
+		if (tok && isdigit(*tok)) {
 			start = memparse(tok, &tok);
 			if (!start) {
 				pr_warn("Tracing: Invalid boot instance address for %s\n",
 					name);
 				continue;
 			}
-		}
-
-		if (start) {
 			if (*tok != ':') {
 				pr_warn("Tracing: No size specified for instance %s\n", name);
 				continue;
@@ -10492,10 +10490,19 @@ __init static void enable_instances(void)
 					name);
 				continue;
 			}
+		} else if (tok) {
+			if (!reserve_mem_find_by_name(tok, &start, &size)) {
+				start = 0;
+				pr_warn("Failed to map boot instance %s to %s\n", name, tok);
+				continue;
+			}
+		}
+
+		if (start) {
 			addr = map_pages(start, size);
 			if (addr) {
-				pr_info("Tracing: mapped boot instance %s at physical memory 0x%lx of size 0x%lx\n",
-					name, start, size);
+				pr_info("Tracing: mapped boot instance %s at physical memory %pa of size 0x%lx\n",
+					name, &start, (unsigned long)size);
 			} else {
 				pr_warn("Tracing: Failed to map boot instance %s\n", name);
 				continue;
-- 
2.43.0



