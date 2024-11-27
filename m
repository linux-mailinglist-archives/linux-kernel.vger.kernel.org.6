Return-Path: <linux-kernel+bounces-423807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6607B9DACF3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0438D162CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5497201017;
	Wed, 27 Nov 2024 18:18:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB813B590;
	Wed, 27 Nov 2024 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732731531; cv=none; b=ZB1dIS9l8YJ1yVxswAwumoIwuoC7EEdB8Ylk/o6EtMbbq+Mei5S7qSx6+Rj6jB9haqfO+zwqa9YUJgQlEz41uywSxLK0vpMJBDfDZJ37ghKkDaLCKE3BStWwTz6Rllwv1LvUeuEUbn+iGycwv/f0OPB9yU1qImKhPeLGiMbJflw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732731531; c=relaxed/simple;
	bh=NMdJWqQnROJoSA9LZFiNvNnSqgtx+COPuOiglaouMGo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EGviZy6ed+HTn+ZCMGtcAhfJz6qZGS3idCAvanJ5sLco1BULoLSDMCSgK1a7ZOuYplD2WYCzrvDx2yX5iNyWBWHmswsfVRBhlz0SSYo8kbv0Rc4QtWmqJb5BvrDH5XI/UPlVPr3ec9xtwWZwO7zh0mNN9urDk2SHsn5MgyREzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC47C4CECC;
	Wed, 27 Nov 2024 18:18:49 +0000 (UTC)
Date: Wed, 27 Nov 2024 13:19:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Miguel Ojeda
 <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] tracing: More updates for 6.13
Message-ID: <20241127131941.3444fbd9@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[ Resend to include LKML ]

Linus,

Tracing updates for 6.13:

- Add trace flag for NEED_RESCHED_LAZY

  Now that NEED_RESCHED_LAZY is upstream, add it to the status bits of the
  common_flags. This will now show when the NEED_RESCHED_LAZY flag is set that
  is used for debugging latency issues in the kernel via a trace.

- Remove leftover "__idx" variable when SRCU was removed from the tracepoint
  code

- Add rcu_tasks_trace guard

  To add a guard() around the tracepoint code, a rcu_tasks_trace guard needs
  to be created first.

- Remove __DO_TRACE() macro and just call __DO_TRACE_CALL() directly

  The DO_TRACE() macro has conditional locking depending on what was passed
  into the macro parameters. As the guts of the macro has been moved to
  __DO_TRACE_CALL() to handle static call logic, there's no reason to keep
  the __DO_TRACE() macro around. It is better to just do the locking in
  place without the conditionals and call __DO_TRACE_CALL() from those
  locations. The "cond" passed in can also be moved out of that macro.
  This simplifies the code.

- Remove the "cond" from the system call tracepoint macros

  The "cond" variable was added to allow some tracepoints to check a
  condition within the static_branch (jump/nop) logic. The system calls do
  not need this. Removing it simplifies the code.

- Replace scoped_guard() with just guard() in the tracepoint logic

  guard() works just as well as scoped_guard() in the tracepoint logic and
  the scoped_guard() causes some issues.

[
  NOTE: The rust tracepoint code added hooks to the same macros that were
  modified in this pull request. The merge has non-trivial conflicts. I
  fixed it up in my "for-next" branch in the same repository. That branch
  was a merge of this branch into the commit where you pulled the rust
  tracepoint code.

  To be consistent, I kept the rust hooks in the system call macros even
  though there are currently no Rust system calls. But if one day there is,
  then this could be useful.

  The rust folks may want to look at that merge too. I ran my normal tests
  but I don't yet have anything that tests Rust tracepoints.
]

Please pull the latest trace-v6.13-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.13-2

Tag SHA1: 6a46d81b2c10dc4fefcc063d9cc5478a66e9e7a2
Head SHA1: 2bd9b57d04df417f31ef54448477c212fcdd14fc


Mathieu Desnoyers (6):
      tracing: Move it_func[0] comment to the relevant context
      tracing: Remove __idx variable from __DO_TRACE
      rcupdate_trace: Define rcu_tasks_trace lock guard
      tracing: Remove conditional locking from __DO_TRACE()
      tracing: Remove cond argument from __DECLARE_TRACE_SYSCALL
      tracing: Use guard() rather than scoped_guard()

Thomas Gleixner (1):
      tracing: Record task flag NEED_RESCHED_LAZY.

----
 Documentation/trace/ftrace.rst |  4 +++
 include/linux/rcupdate_trace.h |  5 +++
 include/linux/trace_events.h   |  1 +
 include/linux/tracepoint.h     | 70 +++++++++++++++---------------------------
 kernel/trace/trace.c           |  2 ++
 kernel/trace/trace_output.c    | 14 ++++++++-
 6 files changed, 49 insertions(+), 47 deletions(-)
---------------------------
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 74d5bd801b1a..272464bb7c60 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1033,9 +1033,13 @@ explains which is which.
   irqs-off: 'd' interrupts are disabled. '.' otherwise.
 
   need-resched:
+	- 'B' all, TIF_NEED_RESCHED, PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is set,
 	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
 	- 'n' only TIF_NEED_RESCHED is set,
 	- 'p' only PREEMPT_NEED_RESCHED is set,
+	- 'L' both PREEMPT_NEED_RESCHED and TIF_RESCHED_LAZY is set,
+	- 'b' both TIF_NEED_RESCHED and TIF_RESCHED_LAZY is set,
+	- 'l' only TIF_RESCHED_LAZY is set
 	- '.' otherwise.
 
   hardirq/softirq:
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index eda493200663..e6c44eb428ab 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -10,6 +10,7 @@
 
 #include <linux/sched.h>
 #include <linux/rcupdate.h>
+#include <linux/cleanup.h>
 
 extern struct lockdep_map rcu_trace_lock_map;
 
@@ -98,4 +99,8 @@ static inline void rcu_read_lock_trace(void) { BUG(); }
 static inline void rcu_read_unlock_trace(void) { BUG(); }
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
+DEFINE_LOCK_GUARD_0(rcu_tasks_trace,
+	rcu_read_lock_trace(),
+	rcu_read_unlock_trace())
+
 #endif /* __LINUX_RCUPDATE_TRACE_H */
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 016b29a56c87..2a5df5b62cfc 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -184,6 +184,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
 
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		= 0x01,
+	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x02,
 	TRACE_FLAG_NEED_RESCHED		= 0x04,
 	TRACE_FLAG_HARDIRQ		= 0x08,
 	TRACE_FLAG_SOFTIRQ		= 0x10,
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 425123e921ac..e398f6e43f61 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -209,36 +209,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DO_TRACE_CALL(name, args)	__traceiter_##name(NULL, args)
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-/*
- * it_func[0] is never NULL because there is at least one element in the array
- * when the array itself is non NULL.
- *
- * With @syscall=0, the tracepoint callback array dereference is
- * protected by disabling preemption.
- * With @syscall=1, the tracepoint callback array dereference is
- * protected by Tasks Trace RCU, which allows probes to handle page
- * faults.
- */
-#define __DO_TRACE(name, args, cond, syscall)				\
-	do {								\
-		int __maybe_unused __idx = 0;				\
-									\
-		if (!(cond))						\
-			return;						\
-									\
-		if (syscall)						\
-			rcu_read_lock_trace();				\
-		else							\
-			preempt_disable_notrace();			\
-									\
-		__DO_TRACE_CALL(name, TP_ARGS(args));			\
-									\
-		if (syscall)						\
-			rcu_read_unlock_trace();			\
-		else							\
-			preempt_enable_notrace();			\
-	} while (0)
-
 /*
  * Make sure the alignment of the structure in the __tracepoints section will
  * not add unwanted padding between the beginning of the section and the
@@ -250,7 +220,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * site if it is not watching, as it will need to be active when the
  * tracepoint is enabled.
  */
-#define __DECLARE_TRACE_COMMON(name, proto, args, cond, data_proto)	\
+#define __DECLARE_TRACE_COMMON(name, proto, args, data_proto)		\
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
@@ -284,29 +254,31 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	}
 
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
-	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void trace_##name(proto)				\
 	{								\
-		if (static_branch_unlikely(&__tracepoint_##name.key))	\
-			__DO_TRACE(name,				\
-				TP_ARGS(args),				\
-				TP_CONDITION(cond), 0);			\
+		if (static_branch_unlikely(&__tracepoint_##name.key)) { \
+			if (cond) {					\
+				guard(preempt_notrace)();		\
+				__DO_TRACE_CALL(name, TP_ARGS(args));	\
+			}						\
+		}							\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
 	}
 
-#define __DECLARE_TRACE_SYSCALL(name, proto, args, cond, data_proto)	\
-	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), cond, PARAMS(data_proto)) \
+#define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void trace_##name(proto)				\
 	{								\
 		might_fault();						\
-		if (static_branch_unlikely(&__tracepoint_##name.key))	\
-			__DO_TRACE(name,				\
-				TP_ARGS(args),				\
-				TP_CONDITION(cond), 1);			\
-		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
+		if (static_branch_unlikely(&__tracepoint_##name.key)) {	\
+			guard(rcu_tasks_trace)();			\
+			__DO_TRACE_CALL(name, TP_ARGS(args));		\
+		}							\
+		if (IS_ENABLED(CONFIG_LOCKDEP)) {			\
 			WARN_ONCE(!rcu_is_watching(),			\
 				  "RCU not watching for tracepoint");	\
 		}							\
@@ -316,6 +288,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * We have no guarantee that gcc and the linker won't up-align the tracepoint
  * structures, so we create an array of pointers that will be used for iteration
  * on the tracepoints.
+ *
+ * it_func[0] is never NULL because there is at least one element in the array
+ * when the array itself is non NULL.
  */
 #define __DEFINE_TRACE_EXT(_name, _ext, proto, args)			\
 	static const char __tpstrtab_##_name[]				\
@@ -386,7 +361,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 
 #else /* !TRACEPOINTS_ENABLED */
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE_COMMON(name, proto, args, data_proto)		\
 	static inline void trace_##name(proto)				\
 	{ }								\
 	static inline int						\
@@ -410,7 +385,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return false;						\
 	}
 
-#define __DECLARE_TRACE_SYSCALL	__DECLARE_TRACE
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto))
+
+#define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
+	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto))
 
 #define DEFINE_TRACE_FN(name, reg, unreg, proto, args)
 #define DEFINE_TRACE_SYSCALL(name, reg, unreg, proto, args)
@@ -476,7 +455,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define DECLARE_TRACE_SYSCALL(name, proto, args)			\
 	__DECLARE_TRACE_SYSCALL(name, PARAMS(proto), PARAMS(args),	\
-				cpu_online(raw_smp_processor_id()),	\
 				PARAMS(void *__data, proto))
 
 #define TRACE_EVENT_FLAGS(event, flag)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3ef047ed9705..be62f0ea1814 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2552,6 +2552,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
+	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RESCHED_LAZY))
+		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
 	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
 		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index e08aee34ef63..da748b7cbc4d 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -462,17 +462,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		bh_off ? 'b' :
 		'.';
 
-	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
+	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
 				TRACE_FLAG_PREEMPT_RESCHED)) {
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'B';
+		break;
 	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'N';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'L';
+		break;
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'b';
+		break;
 	case TRACE_FLAG_NEED_RESCHED:
 		need_resched = 'n';
 		break;
 	case TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'p';
 		break;
+	case TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'l';
+		break;
 	default:
 		need_resched = '.';
 		break;

