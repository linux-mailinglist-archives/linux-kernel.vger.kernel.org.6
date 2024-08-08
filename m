Return-Path: <linux-kernel+bounces-279852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A36A94C290
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD451F23D03
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3C18E748;
	Thu,  8 Aug 2024 16:21:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F240BF2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134068; cv=none; b=f9VZZyyHBt+wWn4awLBmSXd31iRxGLRPwQMAmy7W5k120BpN57Gz9hgiAX9B7OlKf68oQa08GruSoKbJ/yQD4UAmWxlLWMtlxgXbYDHzgLEKq//Mnt11bQX3H2DtulUNL6kEe2QryuBnbPvF0SHoj+LOItaAKs9gwwpv+16c4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134068; c=relaxed/simple;
	bh=joHIav7kYxBo4a3yeVL8urmr6DxaADC6YbPwrSDj50I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ciwk9MVO4R6zMRDVIQ9cFqsbpnX5JuHs26BQbx3wN3g87UO4HPdCwmC829fUdGjzED2hR/YIFRpYizN2G1GvM1xNAyHiiibJVGRrt1HVXkAirNqVlbH8alKzMzle5Tg18UeMFCfbr7qjA+nZ///3piXhWUO8uBet5hXnHB8Mb88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1731C32782;
	Thu,  8 Aug 2024 16:21:07 +0000 (UTC)
Date: Thu, 8 Aug 2024 12:21:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Jianhui Zhou <912460177@qq.com>,
 Mathias Krause <minipli@grsecurity.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Subject: [GIT PULL] tracing: Updates for 6.11-rc2
Message-ID: <20240808122108.6bf9b799@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

tracing fixes for v6.11:

- Have reading of event format files test if the meta data still exists.
  When an event is freed, a flag (EVENT_FILE_FL_FREED) in the meta data is
  set to state that it is to prevent any new references to it from happening
  while waiting for existing references to close. When the last reference
  closes, the meta data is freed. But the "format" file was missing a check
  to this flag (along with some other files) that allowed new references to
  happen, and a use-after-free bug to occur.

- Have the trace event meta data use the refcount infrastructure instead
  of relying on its own atomic counters.

- Have tracefs inodes use alloc_inode_sb() for allocation instead of
  using kmem_cache_alloc() directly.

- Have eventfs_create_dir() return an ERR_PTR instead of NULL as
  the callers expect a real object or an ERR_PTR.

- Have release_ei() use call_srcu() and not call_rcu() as all the
  protection is on SRCU and not RCU.

- Fix ftrace_graph_ret_addr() to use the task passed in and not current.

- Fix overflow bug in get_free_elt() where the counter can overflow
  the integer and cause an infinite loop.

- Remove unused function ring_buffer_nr_pages()

- Have tracefs freeing use the inode RCU infrastructure instead of
  creating its own. When the kernel had randomize structure fields
  enabled, the rcu field of the tracefs_inode was overlapping the
  rcu field of the inode structure, and corrupting it. Instead,
  use the destroy_inode() callback to do the initial cleanup of
  the code, and then have free_inode() free it.


Please pull the latest trace-v6.11-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.11-rc2

Tag SHA1: 511ef7e0a9da29a1d9a120a99630152d9c779ee3
Head SHA1: 0b6743bd60a56a701070b89fb80c327a44b7b3e2


Jianhui Zhou (1):
      ring-buffer: Remove unused function ring_buffer_nr_pages()

Mathias Krause (3):
      tracefs: Fix inode allocation
      eventfs: Don't return NULL in eventfs_create_dir()
      eventfs: Use SRCU for freeing eventfs_inodes

Petr Pavlu (1):
      function_graph: Fix the ret_stack used by ftrace_graph_ret_addr()

Steven Rostedt (3):
      tracing: Have format file honor EVENT_FILE_FL_FREED
      tracing: Use refcount for trace_event_file reference counter
      tracefs: Use generic inode RCU for synchronizing freeing

Tze-nan Wu (1):
      tracing: Fix overflow in get_free_elt()

----
 fs/tracefs/event_inode.c            |  4 ++--
 fs/tracefs/inode.c                  | 12 +++++------
 fs/tracefs/internal.h               |  5 +----
 include/linux/ring_buffer.h         |  1 -
 include/linux/trace_events.h        |  2 +-
 kernel/trace/fgraph.c               |  2 +-
 kernel/trace/ring_buffer.c          | 12 -----------
 kernel/trace/trace.h                | 23 +++++++++++++++++++++
 kernel/trace/trace_events.c         | 41 ++++++++++++++++++++++---------------
 kernel/trace/trace_events_hist.c    |  4 ++--
 kernel/trace/trace_events_inject.c  |  2 +-
 kernel/trace/trace_events_trigger.c |  6 +++---
 kernel/trace/tracing_map.c          |  6 +++---
 13 files changed, 66 insertions(+), 54 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5d88c184f0fc..01e99e98457d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -112,7 +112,7 @@ static void release_ei(struct kref *ref)
 			entry->release(entry->name, ei->data);
 	}
 
-	call_rcu(&ei->rcu, free_ei_rcu);
+	call_srcu(&eventfs_srcu, &ei->rcu, free_ei_rcu);
 }
 
 static inline void put_ei(struct eventfs_inode *ei)
@@ -736,7 +736,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
 		cleanup_ei(ei);
-		ei = NULL;
+		ei = ERR_PTR(-EBUSY);
 	}
 	return ei;
 }
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1028ab6d9a74..1748dff58c3b 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -42,7 +42,7 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	struct tracefs_inode *ti;
 	unsigned long flags;
 
-	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
+	ti = alloc_inode_sb(sb, tracefs_inode_cachep, GFP_KERNEL);
 	if (!ti)
 		return NULL;
 
@@ -53,15 +53,14 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	return &ti->vfs_inode;
 }
 
-static void tracefs_free_inode_rcu(struct rcu_head *rcu)
+static void tracefs_free_inode(struct inode *inode)
 {
-	struct tracefs_inode *ti;
+	struct tracefs_inode *ti = get_tracefs(inode);
 
-	ti = container_of(rcu, struct tracefs_inode, rcu);
 	kmem_cache_free(tracefs_inode_cachep, ti);
 }
 
-static void tracefs_free_inode(struct inode *inode)
+static void tracefs_destroy_inode(struct inode *inode)
 {
 	struct tracefs_inode *ti = get_tracefs(inode);
 	unsigned long flags;
@@ -69,8 +68,6 @@ static void tracefs_free_inode(struct inode *inode)
 	spin_lock_irqsave(&tracefs_inode_lock, flags);
 	list_del_rcu(&ti->list);
 	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
-
-	call_rcu(&ti->rcu, tracefs_free_inode_rcu);
 }
 
 static ssize_t default_read_file(struct file *file, char __user *buf,
@@ -437,6 +434,7 @@ static int tracefs_drop_inode(struct inode *inode)
 static const struct super_operations tracefs_super_operations = {
 	.alloc_inode    = tracefs_alloc_inode,
 	.free_inode     = tracefs_free_inode,
+	.destroy_inode  = tracefs_destroy_inode,
 	.drop_inode     = tracefs_drop_inode,
 	.statfs		= simple_statfs,
 	.show_options	= tracefs_show_options,
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index f704d8348357..d83c2a25f288 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -10,10 +10,7 @@ enum {
 };
 
 struct tracefs_inode {
-	union {
-		struct inode            vfs_inode;
-		struct rcu_head		rcu;
-	};
+	struct inode            vfs_inode;
 	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
 	struct list_head	list;
 	unsigned long           flags;
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 96d2140b471e..fd35d4ec12e1 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -193,7 +193,6 @@ void ring_buffer_set_clock(struct trace_buffer *buffer,
 void ring_buffer_set_time_stamp_abs(struct trace_buffer *buffer, bool abs);
 bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer);
 
-size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu);
 size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu);
 
 struct buffer_data_read_page;
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
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index fc205ad167a9..d1d5ea2d0a1b 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -902,7 +902,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 
 	i = *idx ? : task->curr_ret_stack;
 	while (i > 0) {
-		ret_stack = get_ret_stack(current, i, &i);
+		ret_stack = get_ret_stack(task, i, &i);
 		if (!ret_stack)
 			break;
 		/*
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..cebd879a30cb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -692,18 +692,6 @@ u64 ring_buffer_event_time_stamp(struct trace_buffer *buffer,
 	return ts;
 }
 
-/**
- * ring_buffer_nr_pages - get the number of buffer pages in the ring buffer
- * @buffer: The ring_buffer to get the number of pages from
- * @cpu: The cpu of the ring_buffer to get the number of pages from
- *
- * Returns the number of pages used by a per_cpu buffer of the ring buffer.
- */
-size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu)
-{
-	return buffer->buffers[cpu]->nr_pages;
-}
-
 /**
  * ring_buffer_nr_dirty_pages - get the number of used pages in the ring buffer
  * @buffer: The ring_buffer to get the number of pages from
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 8783bebd0562..bd3e3069300e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1634,6 +1634,29 @@ static inline void *event_file_data(struct file *filp)
 extern struct mutex event_mutex;
 extern struct list_head ftrace_events;
 
+/*
+ * When the trace_event_file is the filp->i_private pointer,
+ * it must be taken under the event_mutex lock, and then checked
+ * if the EVENT_FILE_FL_FREED flag is set. If it is, then the
+ * data pointed to by the trace_event_file can not be trusted.
+ *
+ * Use the event_file_file() to access the trace_event_file from
+ * the filp the first time under the event_mutex and check for
+ * NULL. If it is needed to be retrieved again and the event_mutex
+ * is still held, then the event_file_data() can be used and it
+ * is guaranteed to be valid.
+ */
+static inline struct trace_event_file *event_file_file(struct file *filp)
+{
+	struct trace_event_file *file;
+
+	lockdep_assert_held(&event_mutex);
+	file = READ_ONCE(file_inode(filp)->i_private);
+	if (!file || file->flags & EVENT_FILE_FL_FREED)
+		return NULL;
+	return file;
+}
+
 extern const struct file_operations event_trigger_fops;
 extern const struct file_operations event_hist_fops;
 extern const struct file_operations event_hist_debug_fops;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6ef29eba90ce..7266ec2a4eea 100644
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
@@ -1386,12 +1386,12 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	char buf[4] = "0";
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
+	file = event_file_file(filp);
 	if (likely(file))
 		flags = file->flags;
 	mutex_unlock(&event_mutex);
 
-	if (!file || flags & EVENT_FILE_FL_FREED)
+	if (!file)
 		return -ENODEV;
 
 	if (flags & EVENT_FILE_FL_ENABLED &&
@@ -1424,8 +1424,8 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	case 1:
 		ret = -ENODEV;
 		mutex_lock(&event_mutex);
-		file = event_file_data(filp);
-		if (likely(file && !(file->flags & EVENT_FILE_FL_FREED))) {
+		file = event_file_file(filp);
+		if (likely(file)) {
 			ret = tracing_update_buffers(file->tr);
 			if (ret < 0) {
 				mutex_unlock(&event_mutex);
@@ -1540,7 +1540,8 @@ enum {
 
 static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct trace_event_call *call = event_file_data(m->private);
+	struct trace_event_file *file = event_file_data(m->private);
+	struct trace_event_call *call = file->event_call;
 	struct list_head *common_head = &ftrace_common_fields;
 	struct list_head *head = trace_get_fields(call);
 	struct list_head *node = v;
@@ -1572,7 +1573,8 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 
 static int f_show(struct seq_file *m, void *v)
 {
-	struct trace_event_call *call = event_file_data(m->private);
+	struct trace_event_file *file = event_file_data(m->private);
+	struct trace_event_call *call = file->event_call;
 	struct ftrace_event_field *field;
 	const char *array_descriptor;
 
@@ -1627,12 +1629,14 @@ static int f_show(struct seq_file *m, void *v)
 
 static void *f_start(struct seq_file *m, loff_t *pos)
 {
+	struct trace_event_file *file;
 	void *p = (void *)FORMAT_HEADER;
 	loff_t l = 0;
 
 	/* ->stop() is called even if ->start() fails */
 	mutex_lock(&event_mutex);
-	if (!event_file_data(m->private))
+	file = event_file_file(m->private);
+	if (!file)
 		return ERR_PTR(-ENODEV);
 
 	while (l < *pos && p)
@@ -1706,8 +1710,8 @@ event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 	trace_seq_init(s);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
-	if (file && !(file->flags & EVENT_FILE_FL_FREED))
+	file = event_file_file(filp);
+	if (file)
 		print_event_filter(file, s);
 	mutex_unlock(&event_mutex);
 
@@ -1736,9 +1740,13 @@ event_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		return PTR_ERR(buf);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
-	if (file)
-		err = apply_event_filter(file, buf);
+	file = event_file_file(filp);
+	if (file) {
+		if (file->flags & EVENT_FILE_FL_FREED)
+			err = -ENODEV;
+		else
+			err = apply_event_filter(file, buf);
+	}
 	mutex_unlock(&event_mutex);
 
 	kfree(buf);
@@ -2485,7 +2493,6 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	if (strcmp(name, "format") == 0) {
 		*mode = TRACE_MODE_READ;
 		*fops = &ftrace_event_format_fops;
-		*data = call;
 		return 1;
 	}
 
@@ -2996,7 +3003,7 @@ trace_create_new_event(struct trace_event_call *call,
 	atomic_set(&file->tm_ref, 0);
 	INIT_LIST_HEAD(&file->triggers);
 	list_add(&file->list, &tr->events);
-	event_file_get(file);
+	refcount_set(&file->ref, 1);
 
 	return file;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ece1308d36a..5f9119eb7c67 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5601,7 +5601,7 @@ static int hist_show(struct seq_file *m, void *v)
 
 	mutex_lock(&event_mutex);
 
-	event_file = event_file_data(m->private);
+	event_file = event_file_file(m->private);
 	if (unlikely(!event_file)) {
 		ret = -ENODEV;
 		goto out_unlock;
@@ -5880,7 +5880,7 @@ static int hist_debug_show(struct seq_file *m, void *v)
 
 	mutex_lock(&event_mutex);
 
-	event_file = event_file_data(m->private);
+	event_file = event_file_file(m->private);
 	if (unlikely(!event_file)) {
 		ret = -ENODEV;
 		goto out_unlock;
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index 8650562bdaa9..a8f076809db4 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -299,7 +299,7 @@ event_inject_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	strim(buf);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
+	file = event_file_file(filp);
 	if (file) {
 		call = file->event_call;
 		size = parse_entry(buf, call, &entry);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4bec043c8690..a5e3d6acf1e1 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -159,7 +159,7 @@ static void *trigger_start(struct seq_file *m, loff_t *pos)
 
 	/* ->stop() is called even if ->start() fails */
 	mutex_lock(&event_mutex);
-	event_file = event_file_data(m->private);
+	event_file = event_file_file(m->private);
 	if (unlikely(!event_file))
 		return ERR_PTR(-ENODEV);
 
@@ -213,7 +213,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 
 	mutex_lock(&event_mutex);
 
-	if (unlikely(!event_file_data(file))) {
+	if (unlikely(!event_file_file(file))) {
 		mutex_unlock(&event_mutex);
 		return -ENODEV;
 	}
@@ -293,7 +293,7 @@ static ssize_t event_trigger_regex_write(struct file *file,
 	strim(buf);
 
 	mutex_lock(&event_mutex);
-	event_file = event_file_data(file);
+	event_file = event_file_file(file);
 	if (unlikely(!event_file)) {
 		mutex_unlock(&event_mutex);
 		kfree(buf);
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index a4dcf0f24352..3a56e7c8aa4f 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -454,7 +454,7 @@ static struct tracing_map_elt *get_free_elt(struct tracing_map *map)
 	struct tracing_map_elt *elt = NULL;
 	int idx;
 
-	idx = atomic_inc_return(&map->next_elt);
+	idx = atomic_fetch_add_unless(&map->next_elt, 1, map->max_elts);
 	if (idx < map->max_elts) {
 		elt = *(TRACING_MAP_ELT(map->elts, idx));
 		if (map->ops && map->ops->elt_init)
@@ -699,7 +699,7 @@ void tracing_map_clear(struct tracing_map *map)
 {
 	unsigned int i;
 
-	atomic_set(&map->next_elt, -1);
+	atomic_set(&map->next_elt, 0);
 	atomic64_set(&map->hits, 0);
 	atomic64_set(&map->drops, 0);
 
@@ -783,7 +783,7 @@ struct tracing_map *tracing_map_create(unsigned int map_bits,
 
 	map->map_bits = map_bits;
 	map->max_elts = (1 << map_bits);
-	atomic_set(&map->next_elt, -1);
+	atomic_set(&map->next_elt, 0);
 
 	map->map_size = (1 << (map_bits + 1));
 	map->ops = ops;

