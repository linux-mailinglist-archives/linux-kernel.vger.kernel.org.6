Return-Path: <linux-kernel+bounces-322064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858C972381
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6062859AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E018C937;
	Mon,  9 Sep 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ncuHpAKi"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8318A94C;
	Mon,  9 Sep 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913043; cv=none; b=CpFEW2wg40RbBjlL0pgbhVrjG8jwF7+imYg3yWVGkVQoesQA+lVIyOTrzVto7MlfGLOrNyLi8tJCwuEiTm4FeZRntSalJ6V4ziHkb1iAdwI1Cn+sym9JCbRjZvIbDXzsvD4KpIWtCzyZZ8uw2TszdT/R82i0wOPjKaNDxw7A6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913043; c=relaxed/simple;
	bh=uJq5iVZHWqF4O/NYGe5n5RCWahHYrd6IuFGzrAbE8HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3IX58NeBkO1jfLlmsnRFE7zemkkeDV+8PqGUbai8ELv9+b2ELPqB3brZj/e+/kSHoDG5Kl7xkoDgs5PFNhgUviWfd6ZpvtlEkAQMh268c/BjSRJ6Taw2Hiz+V8y8LFJ1HUSSGYRVXuPwv1K3zKm1pgCAjUazN+1CwYkehi6Pgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ncuHpAKi; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725913038;
	bh=uJq5iVZHWqF4O/NYGe5n5RCWahHYrd6IuFGzrAbE8HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncuHpAKiQfumGWJAbDQIvuzPkv1Z53jIBpwWI7c13yOWIUsN9YbrY4R0tBBkkJVQx
	 ircMRIIvTkPdHtESew4A0PcIa6I8RJi+BakYvq6wLfm0otntEUA2b6g4F48b1ktRaP
	 /Aa6cY9mNwSoAi7YXx/X0bY4O7IZIQIEdwzUpzXQVYzDBdR0Gk4SYZ2xQLzLmC2tEc
	 SPIvMH9pZja73R+WzWvOEEAiEdYAs6toE5wqtQWf14it8SFQBiTmH9zKLE67G5W5m/
	 /ZFcq///C8QiXS02LrsOZEBTIefxia/Vcn22yxsFUuf4mkD4ZG/o2HLTRkuBS5oPng
	 RRpDTa9AdoWwA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X2dRK5MD6z1KhL;
	Mon,  9 Sep 2024 16:17:17 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH 7/8] tracing/perf: Add might_fault check to syscall probes
Date: Mon,  9 Sep 2024 16:16:51 -0400
Message-Id: <20240909201652.319406-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
References: <20240909201652.319406-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a might_fault() check to validate that the perf sys_enter/sys_exit
probe callbacks are indeed called from a context where page faults can
be handled.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/trace/perf.h          | 1 +
 kernel/trace/trace_syscalls.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index 5650c1bad088..321bfd7919f6 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -84,6 +84,7 @@ perf_trace_##call(void *__data, proto)					\
 	u64 __count __attribute__((unused));				\
 	struct task_struct *__task __attribute__((unused));		\
 									\
+	might_fault();							\
 	guard(preempt_notrace)();					\
 	do_perf_trace_##call(__data, args);				\
 }
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 0430890cbb42..53faa791c735 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -600,6 +600,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	 * Syscall probe called with preemption enabled, but the ring
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
+	might_fault();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
@@ -706,6 +707,7 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	 * Syscall probe called with preemption enabled, but the ring
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
+	might_fault();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
-- 
2.39.2


