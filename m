Return-Path: <linux-kernel+bounces-302957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F356960589
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C6E1F2335E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A219DFBB;
	Tue, 27 Aug 2024 09:27:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36310145A07
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750824; cv=none; b=kpTUJU94gcy+mH48X7m53h0A4zwE+1X7ul1VYFmPX/k17YPqaaXzOMLPzABWnsH+M6otIeK7Ynr1g414kdyXxI5znniIkgNjh19jqRmb7duzNQrGcR5+A/I2Qm9Ljlj57KQJVgbcJwQ5/nQ3UaedjBCSZJvTvVfyiv0aybZBET8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750824; c=relaxed/simple;
	bh=lzWD84QPzg//5zKEy3MASL8dK04s/QEOMWhC7WcCjfo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RtUoZcVd0nOSTNy0j4W5mZb6xvAStWOSCc0V6t3dYT4beIEpX3OapG6lxE1m1PaKbDZeHK54wGHoTDaxE9hyL30aJC8Wyt4lxQE+tXWmlqDg3LfgbhZS6r9fjXekdff1XuAVhxyPZk4xF3ajWfHAc6816ZhQOMMvwq89Z42XbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DFBC8B7B5;
	Tue, 27 Aug 2024 09:27:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sisUM-00000004SKm-1PmM;
	Tue, 27 Aug 2024 05:27:46 -0400
Message-ID: <20240827092746.200961303@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 27 Aug 2024 05:27:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 1/8] ring-buffer: Dont reset persistent ring-buffer meta saved addresses
References: <20240827092716.515115830@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The text and data address is saved in the meta data so that it can be used
to know the delta of the text and data addresses of the last boot compared
to the text and data addresses of the current boot. The delta is used to
convert function pointer entries in the ring buffer to something that can
be used by kallsyms (note this only works for built-in functions).

But the saved addresses get reset on boot up. If the buffer is not used
and there's another reboot, then the saved text and data addresses will be
of the last boot and not that of the boot that created the content in the
ring buffer.

To get an idea of the issue:

 # trace-cmd start -B boot_mapped -p function
 # reboot
 # trace-cmd show -B boot_mapped | tail
           <...>-1       [000] d..1.   461.983243: native_apic_msr_write <-native_kick_ap
           <...>-1       [000] d..1.   461.983244: __pfx_native_apic_msr_eoi <-native_kick_ap
           <...>-1       [000] d..1.   461.983244: reserve_irq_vector_locked <-native_kick_ap
           <...>-1       [000] d..1.   461.983262: branch_emulate_op <-native_kick_ap
           <...>-1       [000] d..1.   461.983262: __ia32_sys_ia32_pread64 <-native_kick_ap
           <...>-1       [000] d..1.   461.983263: native_kick_ap <-__smpboot_create_thread
           <...>-1       [000] d..1.   461.983263: store_cache_disable <-native_kick_ap
           <...>-1       [000] d..1.   461.983279: acpi_power_off_prepare <-native_kick_ap
           <...>-1       [000] d..1.   461.983280: __pfx_acpi_ns_delete_node <-acpi_suspend_enter
           <...>-1       [000] d..1.   461.983280: __pfx_acpi_os_release_lock <-acpi_suspend_enter
 # reboot
 # trace-cmd show -B boot_mapped  |tail
           <...>-1       [000] d..1.   461.983243: 0xffffffffa9669220 <-0xffffffffa965f3db
           <...>-1       [000] d..1.   461.983244: 0xffffffffa96690f0 <-0xffffffffa965f3db
           <...>-1       [000] d..1.   461.983244: 0xffffffffa9663fa0 <-0xffffffffa965f3db
           <...>-1       [000] d..1.   461.983262: 0xffffffffa9672e80 <-0xffffffffa965f3e0
           <...>-1       [000] d..1.   461.983262: 0xffffffffa962b940 <-0xffffffffa965f3ec
           <...>-1       [000] d..1.   461.983263: 0xffffffffa965f540 <-0xffffffffa96e1362
           <...>-1       [000] d..1.   461.983263: 0xffffffffa963c940 <-0xffffffffa965f55b
           <...>-1       [000] d..1.   461.983279: 0xffffffffa9ee30c0 <-0xffffffffa965f59b
           <...>-1       [000] d..1.   461.983280: 0xffffffffa9f16c10 <-0xffffffffa9ee3157
           <...>-1       [000] d..1.   461.983280: 0xffffffffa9ee02e0 <-0xffffffffa9ee3157

By not updating the saved text and data addresses in the meta data at
every boot up and only updating them when the buffer is reset, it
allows multiple boots to see the same data.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20240815113629.0dc90af8@rorschach.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8e3a7123937a..b16f301b8a93 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1817,12 +1817,19 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 /* Used to calculate data delta */
 static char rb_data_ptr[] = "";
 
+#define THIS_TEXT_PTR		((unsigned long)rb_meta_init_text_addr)
+#define THIS_DATA_PTR		((unsigned long)rb_data_ptr)
+
+static void rb_meta_init_text_addr(struct ring_buffer_meta *meta)
+{
+	meta->text_addr = THIS_TEXT_PTR;
+	meta->data_addr = THIS_DATA_PTR;
+}
+
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
 	struct ring_buffer_meta *meta;
 	unsigned long delta;
-	unsigned long this_text = (unsigned long)rb_range_meta_init;
-	unsigned long this_data = (unsigned long)rb_data_ptr;
 	void *subbuf;
 	int cpu;
 	int i;
@@ -1839,10 +1846,8 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 			meta->first_buffer += delta;
 			meta->head_buffer += delta;
 			meta->commit_buffer += delta;
-			buffer->last_text_delta = this_text - meta->text_addr;
-			buffer->last_data_delta = this_data - meta->data_addr;
-			meta->text_addr = this_text;
-			meta->data_addr = this_data;
+			buffer->last_text_delta = THIS_TEXT_PTR - meta->text_addr;
+			buffer->last_data_delta = THIS_DATA_PTR - meta->data_addr;
 			continue;
 		}
 
@@ -1859,8 +1864,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 		subbuf = rb_subbufs_from_meta(meta);
 
 		meta->first_buffer = (unsigned long)subbuf;
-		meta->text_addr = this_text;
-		meta->data_addr = this_data;
+		rb_meta_init_text_addr(meta);
 
 		/*
 		 * The buffers[] array holds the order of the sub-buffers
@@ -5990,6 +5994,7 @@ static void reset_disabled_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+	struct ring_buffer_meta *meta;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return;
@@ -6008,6 +6013,11 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 	atomic_dec(&cpu_buffer->record_disabled);
 	atomic_dec(&cpu_buffer->resize_disabled);
 
+	/* Make sure persistent meta now uses this buffer's addresses */
+	meta = rb_range_meta(buffer, 0, cpu_buffer->cpu);
+	if (meta)
+		rb_meta_init_text_addr(meta);
+
 	mutex_unlock(&buffer->mutex);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
@@ -6022,6 +6032,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
+	struct ring_buffer_meta *meta;
 	int cpu;
 
 	/* prevent another thread from changing buffer sizes */
@@ -6049,6 +6060,11 @@ void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 
 		reset_disabled_cpu_buffer(cpu_buffer);
 
+		/* Make sure persistent meta now uses this buffer's addresses */
+		meta = rb_range_meta(buffer, 0, cpu_buffer->cpu);
+		if (meta)
+			rb_meta_init_text_addr(meta);
+
 		atomic_dec(&cpu_buffer->record_disabled);
 		atomic_sub(RESET_BIT, &cpu_buffer->resize_disabled);
 	}
-- 
2.43.0



