Return-Path: <linux-kernel+bounces-357114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A609996BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9C4282815
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623CF1990B7;
	Wed,  9 Oct 2024 13:21:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79EE197543
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480074; cv=none; b=HIANU86y/fIXIW8SQ8moR5fYTRpam4cI0NRaps+2vA1VoC+mQuEWwS/OoZsd+ItxW7PpxRya2TqDKhRT0YxgZ7XMF8/H2QsmpPl9sruNg0qojiMwh0TlWf9ikNqbFHHY5ZLlrirDtQLRgZotkzrlKW+/Twk2Sbaka/EQsJJ3GBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480074; c=relaxed/simple;
	bh=APkbll3Cn3bSBzpnJAtnUN00YesvVOHPz6J4si+Z9gA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sbkQi41gqjirbiJhvhV7Am2cVGyXpxos9tTrREaJ8iQNhnkS51f0A2tcjfeipi4w3lF+IzZ/IndqCPr40yFJaGbJwyHOX4FEhhcxTVh205sRO7GxQUsBsYwiyGzpYfxEORkaX4aH3QNNEw3MuRn2ddpum4T+UkNjBO85F3lK5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B930CC4CEC5;
	Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syWcy-0000000177J-1AwM;
	Wed, 09 Oct 2024 09:21:20 -0400
Message-ID: <20241009132120.141894926@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 09 Oct 2024 09:21:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [for-next][PATCH 4/6] tracepoints: Use new static branch API
References: <20241009132104.470687911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

The old static key API is deprecated.  Switch to the new one.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/7a08dae3c5eddb14b13864923c1b58ac1f4af83c.1728414936.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint-defs.h  | 4 ++--
 include/linux/tracepoint.h       | 8 ++++----
 kernel/trace/trace_events_hist.c | 2 +-
 kernel/trace/trace_events_user.c | 4 ++--
 kernel/tracepoint.c              | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 4dc4955f0fbf..60a6e8314d4c 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -31,7 +31,7 @@ struct tracepoint_func {
 
 struct tracepoint {
 	const char *name;		/* Tracepoint name */
-	struct static_key key;
+	struct static_key_false key;
 	struct static_call_key *static_call_key;
 	void *static_call_tramp;
 	void *iterator;
@@ -83,7 +83,7 @@ struct bpf_raw_event_map {
 
 #ifdef CONFIG_TRACEPOINTS
 # define tracepoint_enabled(tp) \
-	static_key_false(&(__tracepoint_##tp).key)
+	static_branch_unlikely(&(__tracepoint_##tp).key)
 #else
 # define tracepoint_enabled(tracepoint) false
 #endif
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 93a9f3070b48..2a29334bbc02 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -248,7 +248,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_RCU(name, proto, args, cond)			\
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
-		if (static_key_false(&__tracepoint_##name.key))		\
+		if (static_branch_unlikely(&__tracepoint_##name.key))	\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
 				TP_CONDITION(cond), 1);			\
@@ -274,7 +274,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
-		if (static_key_false(&__tracepoint_##name.key))		\
+		if (static_branch_unlikely(&__tracepoint_##name.key))	\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
 				TP_CONDITION(cond), 0);			\
@@ -311,7 +311,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline bool						\
 	trace_##name##_enabled(void)					\
 	{								\
-		return static_key_false(&__tracepoint_##name.key);	\
+		return static_branch_unlikely(&__tracepoint_##name.key);\
 	}
 
 /*
@@ -328,7 +328,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	struct tracepoint __tracepoint_##_name	__used			\
 	__section("__tracepoints") = {					\
 		.name = __tpstrtab_##_name,				\
-		.key = STATIC_KEY_INIT_FALSE,				\
+		.key = STATIC_KEY_FALSE_INIT,				\
 		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
 		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
 		.iterator = &__traceiter_##_name,			\
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5f9119eb7c67..cc2924ad32a3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -822,7 +822,7 @@ static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
 {
 	struct tracepoint *tp = event->tp;
 
-	if (unlikely(atomic_read(&tp->key.enabled) > 0)) {
+	if (unlikely(static_key_enabled(&tp->key))) {
 		struct tracepoint_func *probe_func_ptr;
 		synth_probe_func_t probe_func;
 		void *__data;
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 42b0d998d103..17bcad8f79de 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1676,7 +1676,7 @@ static void update_enable_bit_for(struct user_event *user)
 	struct tracepoint *tp = &user->tracepoint;
 	char status = 0;
 
-	if (atomic_read(&tp->key.enabled) > 0) {
+	if (static_key_enabled(&tp->key)) {
 		struct tracepoint_func *probe_func_ptr;
 		user_event_func_t probe_func;
 
@@ -2280,7 +2280,7 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 	 * It's possible key.enabled disables after this check, however
 	 * we don't mind if a few events are included in this condition.
 	 */
-	if (likely(atomic_read(&tp->key.enabled) > 0)) {
+	if (likely(static_key_enabled(&tp->key))) {
 		struct tracepoint_func *probe_func_ptr;
 		user_event_func_t probe_func;
 		struct iov_iter copy;
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8879da16ef4d..1e3de77ea6b3 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -358,7 +358,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 		tracepoint_update_call(tp, tp_funcs);
 		/* Both iterator and static call handle NULL tp->funcs */
 		rcu_assign_pointer(tp->funcs, tp_funcs);
-		static_key_enable(&tp->key);
+		static_branch_enable(&tp->key);
 		break;
 	case TP_FUNC_2:		/* 1->2 */
 		/* Set iterator static call */
@@ -414,7 +414,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		if (tp->unregfunc && static_key_enabled(&tp->key))
 			tp->unregfunc();
 
-		static_key_disable(&tp->key);
+		static_branch_disable(&tp->key);
 		/* Set iterator static call */
 		tracepoint_update_call(tp, tp_funcs);
 		/* Both iterator and static call handle NULL tp->funcs */
-- 
2.45.2



