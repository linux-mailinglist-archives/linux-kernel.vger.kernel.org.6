Return-Path: <linux-kernel+bounces-543204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14393A4D2CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CFB3AE616
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9D81F63DD;
	Tue,  4 Mar 2025 05:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvB+abLG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805871F585F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064680; cv=none; b=HCMj6u7gBuidNTXxM9tKXjguK2rawJUYPAaV0JN6s4NITVPkJ1jC7wsLrNXhR8sKhBS7NLYrqPLrXe8zMlsOHWdGVl7Qlc8ivf4l+oTeUoFSgDNW4SifRaEjco9nuMXG7uR6xfQIl2eNFGV2lMq8g7lkiEqqYluWg9jApIexaC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064680; c=relaxed/simple;
	bh=8W6V3Mdc3xWK0YKc3vJr7nrKXuZoyFr+hOU5CbP9q3I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Rmo3MUhd6V6j7w8ICVz/G/yM3BUen79RRXBd+ZO084n4xpwkEouERYi/YaKB0Rytcou2KAk5L+Vu8di7CJW2ebwhOQQ+QuXm5PbSjzaa9MskCEbTBfuQRDSaahQalDURLaYTAzwLs3cuw1RitcqzBohJSqTY6qkh5hD6/JEeyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvB+abLG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e583e274095so6256875276.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 21:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064677; x=1741669477; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0epwbCKMSYykA4kwC9635o/Y9dNp67Qk+FkRsi9vRck=;
        b=rvB+abLGg6jZtYqZ8BJodQuMki4522/sWQ+d11uoQ12HBAL5qc3u427ygw6JQ9EB4z
         JMclgs4UexldIDfplkViUV0l0e+h4uHGHZGZh68OzYgTzczD55jC0VKaQ4LC5mI5W7VI
         ns7I7IWzwkDONnPEXFqTB5MzvLAIqFyI8J7KtMpojWAkwctjlBvBUFUKFKXIyGmoNG/U
         ruxtQOv7EUhajAuvh/GZ5befVYDfxt2oLL7HRwrAgdTNvEWJgjHdvpcrsrovbLVMSWaj
         HGngiJ7Dp/RNTtxjR0QkbR1KfVA+dxuJc61gjUhbKHUUkQ79CiBS++Gy1Z3Fi3Yluo0H
         lO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064677; x=1741669477;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0epwbCKMSYykA4kwC9635o/Y9dNp67Qk+FkRsi9vRck=;
        b=SBncMJ1fD4ttDA1nQfe20qlcLwOvONkioJhfLfYb3D2stuhDYoqkpTutYsMVCEGDuF
         EA1qQbH21A+2gHoQxbYSH2KYemqUdqhNwYJCNnkyR9dSP+mgJ3zJB8abUVgQCdqKSesz
         NVkpgCWVDGBYixa18acKXfJFXbnDo5eqTWB6q5inCRhL+A/swy/nqK5KhdgiMC7krGz1
         zlGh2S6Wcq8subDt6iH15/8loCF/TcxknJhj2T38V27SzPD3dCSCVCxsHmIsIzAeGOKE
         ioCL7nPHhDDA8vBdvob26jpv+0uAzdcfjjj1f5CepzJRhEjVRj/jEwNuQE6A3vHYJwUa
         momw==
X-Forwarded-Encrypted: i=1; AJvYcCWaUPMKrjzoUMhKn98IqoxijnG6+pjxg4xMfuuloXayljN966OEKXXi1FzMDtOV7gZVevDkDOfwGOrtYao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzATLnxR4sOOoIPU/JrNq7KGiN/hpEZLX/MNe1p512kMEQrvJgL
	18j1Ko+dn3kTCV2fCepF0ae7vgrBy6YHiA7806Mxc6N1HBqVJ503jj9ouw3GLzxPpdyIP/jyF4F
	ylflplw==
X-Google-Smtp-Source: AGHT+IGQOEYy9F+mKAlJH/5NtOSqhO82ZI1AvFTLT8lzKUM5pGf0NQmOzgTD0cSkWhSSO9Guw5PeqZ3WE930
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a5b:b43:0:b0:e5e:fdc:88e1 with SMTP id
 3f1490d57ef6-e60b2f347b6mr1983728276.4.1741064677594; Mon, 03 Mar 2025
 21:04:37 -0800 (PST)
Date: Mon,  3 Mar 2025 21:03:01 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 07/11] perf thread: Add support for reading the e_machine
 type for a thread
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

First try to read the e_machine from the dsos associated with the
thread's maps. If live use the executable from /proc/pid/exe and read
the e_machine from the ELF header. On failure use EM_HOST. Change
builtin-trace syscall functions to pass e_machine from the thread
rather than EM_HOST, so that in later patches when syscalltbl can use
the e_machine the system calls are specific to the architecture.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 43 ++++++++++----------
 tools/perf/util/thread.c   | 80 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/thread.h   | 14 ++++++-
 3 files changed, 115 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cfc8cb8cbef8..49199d753b7c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2729,16 +2729,16 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	int printed = 0;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
-	int augmented_args_size = 0;
+	int augmented_args_size = 0, e_machine;
 	void *augmented_args = NULL;
-	/* TODO: get e_machine from thread. */
-	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+	struct syscall *sc;
 	struct thread_trace *ttrace;
 
-	if (sc == NULL)
-		return -1;
-
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	e_machine = thread__e_machine(thread, trace->host);
+	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	if (sc == NULL)
+		goto out_put;
 	ttrace = thread__trace(thread, trace);
 	if (ttrace == NULL)
 		goto out_put;
@@ -2806,17 +2806,18 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	struct thread_trace *ttrace;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
-	/* TODO: get e_machine from thread. */
-	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+	struct syscall *sc;
 	char msg[1024];
 	void *args, *augmented_args = NULL;
-	int augmented_args_size;
+	int augmented_args_size, e_machine;
 	size_t printed = 0;
 
-	if (sc == NULL)
-		return -1;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	e_machine = thread__e_machine(thread, trace->host);
+	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	if (sc == NULL)
+		return -1;
 	ttrace = thread__trace(thread, trace);
 	/*
 	 * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
@@ -2881,15 +2882,15 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	bool duration_calculated = false;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
-	int alignment = trace->args_alignment;
-	/* TODO: get e_machine from thread. */
-	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+	int alignment = trace->args_alignment, e_machine;
+	struct syscall *sc;
 	struct thread_trace *ttrace;
 
-	if (sc == NULL)
-		return -1;
-
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	e_machine = thread__e_machine(thread, trace->host);
+	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	if (sc == NULL)
+		goto out_put;
 	ttrace = thread__trace(thread, trace);
 	if (ttrace == NULL)
 		goto out_put;
@@ -3236,8 +3237,8 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 	if (evsel == trace->syscalls.events.bpf_output) {
 		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
-		/* TODO: get e_machine from thread. */
-		struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+		int e_machine = thread ? thread__e_machine(thread, trace->host) : EM_HOST;
+		struct syscall *sc = trace__syscall_info(trace, evsel, e_machine, id);
 
 		if (sc) {
 			fprintf(trace->output, "%s(", sc->name);
@@ -4881,6 +4882,7 @@ static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trac
 {
 	size_t printed = 0;
 	struct thread_trace *ttrace = thread__priv(thread);
+	int e_machine = thread__e_machine(thread, trace->host);
 	double ratio;
 
 	if (ttrace == NULL)
@@ -4900,8 +4902,7 @@ static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trac
 	else if (fputc('\n', fp) != EOF)
 		++printed;
 
-	/* TODO: get e_machine from thread. */
-	printed += thread__dump_stats(ttrace, trace, EM_HOST, fp);
+	printed += thread__dump_stats(ttrace, trace, e_machine, fp);
 
 	return printed;
 }
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 0ffdd52d86d7..89585f53c1d5 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <elf.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -16,6 +18,7 @@
 #include "symbol.h"
 #include "unwind.h"
 #include "callchain.h"
+#include "dwarf-regs.h"
 
 #include <api/fs/fs.h>
 
@@ -51,6 +54,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread__set_ppid(thread, -1);
 		thread__set_cpu(thread, -1);
 		thread__set_guest_cpu(thread, -1);
+		thread__set_e_machine(thread, EM_NONE);
 		thread__set_lbr_stitch_enable(thread, false);
 		INIT_LIST_HEAD(thread__namespaces_list(thread));
 		INIT_LIST_HEAD(thread__comm_list(thread));
@@ -423,6 +427,82 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	}
 }
 
+static uint16_t read_proc_e_machine_for_pid(pid_t pid)
+{
+	char path[6 /* "/proc/" */ + 11 /* max length of pid */ + 5 /* "/exe\0" */];
+	int fd;
+	uint16_t e_machine = EM_NONE;
+
+	snprintf(path, sizeof(path), "/proc/%d/exe", pid);
+	fd = open(path, O_RDONLY);
+	if (fd >= 0) {
+		_Static_assert(offsetof(Elf32_Ehdr, e_machine) == 18, "Unexpected offset");
+		_Static_assert(offsetof(Elf64_Ehdr, e_machine) == 18, "Unexpected offset");
+		if (pread(fd, &e_machine, sizeof(e_machine), 18) != sizeof(e_machine))
+			e_machine = EM_NONE;
+		close(fd);
+	}
+	return e_machine;
+}
+
+static int thread__e_machine_callback(struct map *map, void *machine)
+{
+	struct dso *dso = map__dso(map);
+
+	_Static_assert(0 == EM_NONE, "Unexpected EM_NONE");
+	if (!dso)
+		return EM_NONE;
+
+	return dso__e_machine(dso, machine);
+}
+
+uint16_t thread__e_machine(struct thread *thread, struct machine *machine)
+{
+	pid_t tid, pid;
+	uint16_t e_machine = RC_CHK_ACCESS(thread)->e_machine;
+
+	if (e_machine != EM_NONE)
+		return e_machine;
+
+	tid = thread__tid(thread);
+	pid = thread__pid(thread);
+	if (pid != tid) {
+		struct thread *parent = machine__findnew_thread(machine, pid, pid);
+
+		if (parent) {
+			e_machine = thread__e_machine(parent, machine);
+			thread__set_e_machine(thread, e_machine);
+			return e_machine;
+		}
+		/* Something went wrong, fallback. */
+	}
+	/* Reading on the PID thread. First try to find from the maps. */
+	e_machine = maps__for_each_map(thread__maps(thread),
+				       thread__e_machine_callback,
+				       machine);
+	if (e_machine == EM_NONE) {
+		/* Maps failed, perhaps we're live with map events disabled. */
+		bool is_live = machine->machines == NULL;
+
+		if (!is_live) {
+			/* Check if the session has a data file. */
+			struct perf_session *session = container_of(machine->machines,
+								    struct perf_session,
+								    machines);
+
+			is_live = !!session->data;
+		}
+		/* Read from /proc/pid/exe if live. */
+		if (is_live)
+			e_machine = read_proc_e_machine_for_pid(pid);
+	}
+	if (e_machine != EM_NONE)
+		thread__set_e_machine(thread, e_machine);
+	else
+		e_machine = EM_HOST;
+	return e_machine;
+}
+
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread)
 {
 	if (thread__pid(thread) == thread__tid(thread))
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 6cbf6eb2812e..cd574a896418 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -60,7 +60,11 @@ DECLARE_RC_STRUCT(thread) {
 	struct srccode_state	srccode_state;
 	bool			filter;
 	int			filter_entry_depth;
-
+	/**
+	 * @e_machine: The ELF EM_* associated with the thread. EM_NONE if not
+	 * computed.
+	 */
+	uint16_t		e_machine;
 	/* LBR call stack stitch */
 	bool			lbr_stitch_enable;
 	struct lbr_stitch	*lbr_stitch;
@@ -302,6 +306,14 @@ static inline void thread__set_filter_entry_depth(struct thread *thread, int dep
 	RC_CHK_ACCESS(thread)->filter_entry_depth = depth;
 }
 
+uint16_t thread__e_machine(struct thread *thread, struct machine *machine);
+
+static inline void thread__set_e_machine(struct thread *thread, uint16_t e_machine)
+{
+	RC_CHK_ACCESS(thread)->e_machine = e_machine;
+}
+
+
 static inline bool thread__lbr_stitch_enable(const struct thread *thread)
 {
 	return RC_CHK_ACCESS(thread)->lbr_stitch_enable;
-- 
2.48.1.711.g2feabab25a-goog


