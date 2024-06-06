Return-Path: <linux-kernel+bounces-205048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CF48FF69B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4003C1F2577B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C742A19AA5D;
	Thu,  6 Jun 2024 21:21:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881801991C6;
	Thu,  6 Jun 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708892; cv=none; b=rTjZGmEhPEyGX3Hmiojs9FRxxuRCL48+eo1vjfx9m13bJqHTPf+nVYBZTktimMv6IpNYn7RFxm2KPaxNC0IxfQvivR7Tg2bj/YvnvS3yxyrpgnVgH6y7S3yH1mVfMG6FnJ9DIjSKzMijDdzdKeNZjw16LV4X7WnLMUjBv/tyjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708892; c=relaxed/simple;
	bh=O4Ds77oTyPv1EEQNm/kU3EECLJjdFwkDFReeIz8Igi8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bWtus16yoqAbvAqSZvqI7WDE4VwZvbOUvD18f4o+Vsjc1GgTqcTj5o2gKsHK4Nl+OFZBUrRl0JRYaNU85aDE9GpAFIN9ga2gl4/f0DoN0QOAysimI3Jg+A8nQZOD4I1FdDCP5SmI3a8Tg6uDOlC2KShBVn4+16+a0J1SjuouZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD6DC3277B;
	Thu,  6 Jun 2024 21:21:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFKYD-00000000qLD-1zlt;
	Thu, 06 Jun 2024 17:21:37 -0400
Message-ID: <20240606212137.333436708@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 17:17:43 -0400
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
 Kees Cook <keescook@chromium.org>,
 linux-mm@kvack.org
Subject: [PATCH v3 08/13] tracing: Add option to use memmapped memory for trace boot instance
References: <20240606211735.684785459@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add an option to the trace_instance kernel command line parameter that
allows it to use the reserved memory from memmap boot parameter.

  memmap=12M$0x284500000 trace_instance=boot_mapped@0x284500000:12M

The above will reserves 12 megs at the physical address 0x284500000.
The second parameter will create a "boot_mapped" instance and use the
memory reserved as the memory for the ring buffer.

That will create an instance called "boot_mapped":

  /sys/kernel/tracing/instances/boot_mapped

Note, because the ring buffer is using a defined memory ranged, it will
act just like a memory mapped ring buffer. It will not have a snapshot
buffer, as it can't swap out the buffer. The snapshot files as well as any
tracers that uses a snapshot will not be present in the boot_mapped
instance.

Cc: linux-mm@kvack.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++
 kernel/trace/trace.c                          | 75 +++++++++++++++++--
 2 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..ff26b6094e79 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6754,6 +6754,15 @@
 			the same thing would happen if it was left off). The irq_handler_entry
 			event, and all events under the "initcall" system.
 
+			If memory has been reserved (see memmap for x86), the instance
+			can use that memory:
+
+				memmap=12M$0x284500000 trace_instance=boot_map@0x284500000:12M
+
+			The above will create a "boot_map" instance that uses the physical
+			memory at 0x284500000 that is 12Megs. The per CPU buffers of that
+			instance will be split up accordingly.
+
 	trace_options=[option-list]
 			[FTRACE] Enable or disable tracer options at boot.
 			The option-list is a comma delimited list of options
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 622fe670949d..13e89023f33b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9504,6 +9504,31 @@ static int instance_mkdir(const char *name)
 	return ret;
 }
 
+static u64 map_pages(u64 start, u64 size)
+{
+	struct page **pages;
+	phys_addr_t page_start;
+	unsigned int page_count;
+	unsigned int i;
+	void *vaddr;
+
+	page_count = DIV_ROUND_UP(size, PAGE_SIZE);
+
+	page_start = start;
+	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return 0;
+
+	for (i = 0; i < page_count; i++) {
+		phys_addr_t addr = page_start + i * PAGE_SIZE;
+		pages[i] = pfn_to_page(addr >> PAGE_SHIFT);
+	}
+	vaddr = vmap(pages, page_count, VM_MAP, PAGE_KERNEL);
+	kfree(pages);
+
+	return (u64)(unsigned long)vaddr;
+}
+
 /**
  * trace_array_get_by_name - Create/Lookup a trace array, given its name.
  * @name: The name of the trace array to be looked up/created.
@@ -10350,6 +10375,7 @@ __init static void enable_instances(void)
 {
 	struct trace_array *tr;
 	char *curr_str;
+	char *name;
 	char *str;
 	char *tok;
 
@@ -10358,19 +10384,56 @@ __init static void enable_instances(void)
 	str = boot_instance_info;
 
 	while ((curr_str = strsep(&str, "\t"))) {
+		unsigned long start = 0;
+		unsigned long size = 0;
+		unsigned long addr = 0;
 
 		tok = strsep(&curr_str, ",");
+		name = strsep(&tok, "@");
+		if (tok) {
+			start = memparse(tok, &tok);
+			if (!start) {
+				pr_warn("Tracing: Invalid boot instance address for %s\n",
+					name);
+				continue;
+			}
+		}
 
-		if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
-			do_allocate_snapshot(tok);
+		if (start) {
+			if (*tok != ':') {
+				pr_warn("Tracing: No size specified for instance %s\n", name);
+				continue;
+			}
+			tok++;
+			size = memparse(tok, &tok);
+			if (!size) {
+				pr_warn("Tracing: Invalid boot instance size for %s\n",
+					name);
+				continue;
+			}
+			addr = map_pages(start, size);
+			if (addr) {
+				pr_info("Tracing: mapped boot instance %s at physical memory 0x%lx of size 0x%lx\n",
+					name, start, size);
+			} else {
+				pr_warn("Tracing: Failed to map boot instance %s\n", name);
+				continue;
+			}
+		} else {
+			/* Only non mapped buffers have snapshot buffers */
+			if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
+				do_allocate_snapshot(tok);
+		}
 
-		tr = trace_array_get_by_name(tok, NULL);
+		tr = trace_array_create_systems(name, NULL, addr, size);
 		if (!tr) {
-			pr_warn("Failed to create instance buffer %s\n", curr_str);
+			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
 			continue;
 		}
-		/* Allow user space to delete it */
-		trace_array_put(tr);
+
+		/* Only allow non mapped buffers to be deleted */
+		if (!start)
+			trace_array_put(tr);
 
 		while ((tok = strsep(&curr_str, ","))) {
 			early_enable_events(tr, tok, true);
-- 
2.43.0



