Return-Path: <linux-kernel+bounces-543030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ABCA4D0C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6108B173B40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2B018C006;
	Tue,  4 Mar 2025 01:24:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E613C689;
	Tue,  4 Mar 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051495; cv=none; b=H/8Ry0hKW8nRN8y6b7NGo2aHSWLcxXjnz8z07pBw2DAcAl4PHww+z0/HyLwGPxN48vKAl06bj4ZvbEUtzLPwATx7hftApN5b1wm3fTfiUn84AFPYYvlkWNZpy9SWVQwTl31zIXTDuyQ3JoeOzmHqQ783s1nGQfishfUFfxgSUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051495; c=relaxed/simple;
	bh=xeJma/NQv+BK6vqf+Jd+sUfFjdDrCU9xW6EFdBhsToQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hejze5+ASOxYLKcR6aozjOl/xmkt8083v7xPQp41Wi/ZZRGsmqsXzV9dXMZWLV4keHToydvzfsd28H/Umf6/4Cy79MJ1Rnyp5sFDzhmeQvKs/O5w9ETjjHkWJv/nvXqbysehsEooqKm28N69ietTx+gE+81fR+hyAKLw6auo1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04784C4CEF7;
	Tue,  4 Mar 2025 01:24:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpH2a-0000000CC7r-3qjl;
	Mon, 03 Mar 2025 20:25:48 -0500
Message-ID: <20250304012548.768162217@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Mar 2025 20:25:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 7/8] tracing: Show module names and addresses of last boot
References: <20250304012516.282694507@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add the last boot module's names and addresses to the last_boot_info file.
This only shows the module information from a previous boot. If the buffer
is started and is recording the current boot, this file still will only
show "current".

  ~# cat instances/boot_mapped/last_boot_info
  10c00000		[kernel]
  ffffffffc00ca000	usb_serial_simple
  ffffffffc00ae000	usbserial
  ffffffffc008b000	bfq

  ~# echo function > instances/boot_mapped/current_tracer
  ~# cat instances/boot_mapped/last_boot_info
  # Current

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20250215034405.244453188@goodmis.org

- Add mutex guard around module_for_each_mod() instead of taking the mutex
  within the callback, as that can cause deadlocks.

 kernel/trace/trace.c | 102 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6674dc985e52..e1f053ffe887 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5999,6 +5999,8 @@ struct trace_scratch {
 	struct trace_mod_entry	entries[];
 };
 
+static DEFINE_MUTEX(scratch_mutex);
+
 static int save_mod(struct module *mod, void *data)
 {
 	struct trace_array *tr = data;
@@ -6039,6 +6041,7 @@ static void update_last_data(struct trace_array *tr)
 		       flex_array_size(tscratch, entries, tscratch->nr_entries));
 		tscratch->nr_entries = 0;
 
+		guard(mutex)(&scratch_mutex);
 		module_for_each_mod(save_mod, tr);
 	}
 
@@ -6876,15 +6879,47 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
-static ssize_t
-tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+#define LAST_BOOT_HEADER ((void *)1)
+
+static void *l_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = m->private;
 	struct trace_scratch *tscratch = tr->scratch;
-	struct seq_buf seq;
-	char buf[64];
+	unsigned int index = *pos;
+
+	(*pos)++;
 
-	seq_buf_init(&seq, buf, 64);
+	if (*pos == 1)
+		return LAST_BOOT_HEADER;
+
+	/* Only show offsets of the last boot data */
+	if (!tscratch || !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return NULL;
+
+	/* *pos 0 is for the header, 1 is for the first module */
+	index--;
+
+	if (index >= tscratch->nr_entries)
+		return NULL;
+
+	return &tscratch->entries[index];
+}
+
+static void *l_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&scratch_mutex);
+
+	return l_next(m, NULL, pos);
+}
+
+static void l_stop(struct seq_file *m, void *p)
+{
+	mutex_unlock(&scratch_mutex);
+}
+
+static void show_last_boot_header(struct seq_file *m, struct trace_array *tr)
+{
+	struct trace_scratch *tscratch = tr->scratch;
 
 	/*
 	 * Do not leak KASLR address. This only shows the KASLR address of
@@ -6894,11 +6929,52 @@ tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t
 	 * should not be the same as the current boot.
 	 */
 	if (tscratch && (tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
-		seq_buf_printf(&seq, "%lx\t[kernel]\n", tscratch->kaslr_addr);
+		seq_printf(m, "%lx\t[kernel]\n", tscratch->kaslr_addr);
 	else
-		seq_buf_puts(&seq, "# Current\n");
+		seq_puts(m, "# Current\n");
+}
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, seq_buf_used(&seq));
+static int l_show(struct seq_file *m, void *v)
+{
+	struct trace_array *tr = m->private;
+	struct trace_mod_entry *entry = v;
+
+	if (v == LAST_BOOT_HEADER) {
+		show_last_boot_header(m, tr);
+		return 0;
+	}
+
+	seq_printf(m, "%lx\t%s\n", entry->mod_addr, entry->mod_name);
+	return 0;
+}
+
+static const struct seq_operations last_boot_seq_ops = {
+	.start		= l_start,
+	.next		= l_next,
+	.stop		= l_stop,
+	.show		= l_show,
+};
+
+static int tracing_last_boot_open(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+	struct seq_file *m;
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = seq_open(file, &last_boot_seq_ops);
+	if (ret) {
+		trace_array_put(tr);
+		return ret;
+	}
+
+	m = file->private_data;
+	m->private = tr;
+
+	return 0;
 }
 
 static int tracing_buffer_meta_open(struct inode *inode, struct file *filp)
@@ -7527,10 +7603,10 @@ static const struct file_operations trace_time_stamp_mode_fops = {
 };
 
 static const struct file_operations last_boot_fops = {
-	.open		= tracing_open_generic_tr,
-	.read		= tracing_last_boot_read,
-	.llseek		= generic_file_llseek,
-	.release	= tracing_release_generic_tr,
+	.open		= tracing_last_boot_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= tracing_seq_release,
 };
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-- 
2.47.2



