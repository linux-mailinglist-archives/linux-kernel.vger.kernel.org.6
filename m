Return-Path: <linux-kernel+bounces-567318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88819A68476
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108DE7A9854
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09625252908;
	Wed, 19 Mar 2025 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0bA5oXx"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF902517A7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360898; cv=none; b=FiLeI9BYtuRVhkCdqDCKj28WIz4FOiKsRsVFaF6r3tNusTVKSYOeYcWM+G9/U8Uff8voRb+wvYJ5u2q4nEi03EGAphgWTjwmYWAKnatkLQEsHmvdssmXk1BX6NHvqTmc/Jt91YargXpYunzwev/KVn7CdUWaeFNxuqIEzVKt9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360898; c=relaxed/simple;
	bh=GbxsG9MTzjhI/k4irKic5R/3koEfGE1mTaI8yVw4hYk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CFtSvkDymVBrp61+IAMXMvQKmNMXfPewUPJivMW0maXaDMekpZY8KRq/LbQQZzfJNvysBKfPyXWc9D5CONHTPSqqREQh4W9aqxFtb8zBPccwQiaH38h0clBbFoywl5VCb3gblEKHcFG8VczuLnWomEeCv8H4rBDg08Y/aWfgukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v0bA5oXx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fec6c91630so89806867b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742360894; x=1742965694; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7xBPeAI1ZGK/na4YhBc+S5M0v2o7F6+AZ1yRtBTaOg=;
        b=v0bA5oXxduq8hu5ZaHmP+Ec6uKeiavXOWxlt6YFB/Ra/mjds3esYOr7zmyPXrYxl1S
         mvNyb/WOnb/irLREtf9Ku1IcWE4XfoxrRDZdDkH0v79Aca+WakM8PF+Fd0tOrt6H1LV5
         UFtb5HWSqNq9SN7/pyz09UVXcJtbascqW7v8p9pXtCEdyf19ahpIEYOZYVnL2dCRewsK
         l0Znc8wYHkUF3hzfUgzFiEgQhtWTtl9dTzlBN/zP2+h30suUiQ5ndCmd8Z6zbuMdMc6S
         92woIVMHf5TdzomEHbE4FMPD7Co0v3c56SkAMkoeeaSeMmRmIdLmVusZpCquWKcVrIqi
         YKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360894; x=1742965694;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7xBPeAI1ZGK/na4YhBc+S5M0v2o7F6+AZ1yRtBTaOg=;
        b=PmUwkDuZYcN7w2VxZc5BirVfBymKhuYmlYP9LU9RGLA5xiNEJaKoH7osVY+ew32SSP
         +ys6nXIZ6kL5WiCQ2z5288mYd+O8BbAZJPxSW4q3S6d290NlzxIlJcnPd/WiLcI175oH
         M5wgga2J/AJugsxmMAo8nD7BgXBc9zvfwqs764bpCYxlNTg9mBAIQRIZ2zVhoixKQJVN
         XWMvQHOfWTB6tDgjIokye8y5tZW2xzHCSBY8HahNWXi3XEOYVbP+Tv/Gy8TcGb06NQ5s
         ytNn6F9jXlHCad8hkuwZr8tgPp6xENkqFmpUccq8PE33mOmPMpSzEz0pEp9HEGe9Db6+
         sT2w==
X-Forwarded-Encrypted: i=1; AJvYcCUbLVhgiQQP7o3ptLtyNGeHlguItHR/Z+Y9LjJwVMWp7ISReueBr2IKLSo81A2ZmmsIlvTLKAx1iC122mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIRhVajmyw3VpjpWnYOkjniokh8M6a0Egr3x/6dEUtvNag0AF
	+xMtzGQ5RJBEzCw/n1rjnW8leVrfkdRU7aW1B7FAhxcfrBQIQ+UWOXuY8sZxpkz5mZUNjLe9tHN
	H5j/nzA==
X-Google-Smtp-Source: AGHT+IED/ZLlykbehWpsCbnxI7/VEXCzdceMElPMiVtqa8xKpgrgI1AFRxFexUYRexGCPPRyPnT6SSPwC/n+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8a11:10b5:af90:6031])
 (user=irogers job=sendgmr) by 2002:a05:6902:1824:b0:e5b:33c4:7279 with SMTP
 id 3f1490d57ef6-e667b432965mr506276.4.1742360893839; Tue, 18 Mar 2025
 22:08:13 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:07:39 -0700
In-Reply-To: <20250319050741.269828-1-irogers@google.com>
Message-Id: <20250319050741.269828-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319050741.269828-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v7 12/14] perf trace: Make syscall table stable
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

Namhyung fixed the syscall table being reallocated and moving by
reloading the system call pointer after a move:
https://lore.kernel.org/lkml/Z9YHCzINiu4uBQ8B@google.com/
This could be brittle so this patch changes the syscall table to be an
array of pointers of "struct syscall" that don't move. Remove
unnecessary copies and searches with this change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 87 +++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1c080d95c1e2..a5f31472980b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -151,7 +151,7 @@ struct trace {
 	struct perf_tool	tool;
 	struct {
 		/** Sorted sycall numbers used by the trace. */
-		struct syscall  *table;
+		struct syscall  **table;
 		/** Size of table. */
 		size_t		table_size;
 		struct {
@@ -2473,24 +2473,41 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 	return printed;
 }
 
-static void syscall__init(struct syscall *sc, int e_machine, int id)
+static struct syscall *syscall__new(int e_machine, int id)
 {
-	memset(sc, 0, sizeof(*sc));
+	struct syscall *sc = zalloc(sizeof(*sc));
+
+	if (!sc)
+		return NULL;
+
 	sc->e_machine = e_machine;
 	sc->id = id;
+	return sc;
 }
 
-static void syscall__exit(struct syscall *sc)
+static void syscall__delete(struct syscall *sc)
 {
 	if (!sc)
 		return;
 
-	zfree(&sc->arg_fmt);
+	free(sc->arg_fmt);
+	free(sc);
+}
+
+static int syscall__bsearch_cmp(const void *key, const void *entry)
+{
+	const struct syscall *a = key, *b = *((const struct syscall **)entry);
+
+	if (a->e_machine != b->e_machine)
+		return a->e_machine - b->e_machine;
+
+	return a->id - b->id;
 }
 
 static int syscall__cmp(const void *va, const void *vb)
 {
-	const struct syscall *a = va, *b = vb;
+	const struct syscall *a = *((const struct syscall **)va);
+	const struct syscall *b = *((const struct syscall **)vb);
 
 	if (a->e_machine != b->e_machine)
 		return a->e_machine - b->e_machine;
@@ -2504,27 +2521,33 @@ static struct syscall *trace__find_syscall(struct trace *trace, int e_machine, i
 		.e_machine = e_machine,
 		.id = id,
 	};
-	struct syscall *sc, *tmp;
+	struct syscall *sc, **tmp;
 
 	if (trace->syscalls.table) {
-		sc = bsearch(&key, trace->syscalls.table, trace->syscalls.table_size,
-			     sizeof(struct syscall), syscall__cmp);
-		if (sc)
-			return sc;
+		struct syscall **sc_entry = bsearch(&key, trace->syscalls.table,
+						    trace->syscalls.table_size,
+						    sizeof(trace->syscalls.table[0]),
+						    syscall__bsearch_cmp);
+
+		if (sc_entry)
+			return *sc_entry;
 	}
 
+	sc = syscall__new(e_machine, id);
+	if (!sc)
+		return NULL;
+
 	tmp = reallocarray(trace->syscalls.table, trace->syscalls.table_size + 1,
-			   sizeof(struct syscall));
-	if (!tmp)
+			   sizeof(trace->syscalls.table[0]));
+	if (!tmp) {
+		syscall__delete(sc);
 		return NULL;
+	}
 
 	trace->syscalls.table = tmp;
-	sc = &trace->syscalls.table[trace->syscalls.table_size++];
-	syscall__init(sc, e_machine, id);
-	qsort(trace->syscalls.table, trace->syscalls.table_size, sizeof(struct syscall),
+	trace->syscalls.table[trace->syscalls.table_size++] = sc;
+	qsort(trace->syscalls.table, trace->syscalls.table_size, sizeof(trace->syscalls.table[0]),
 	      syscall__cmp);
-	sc = bsearch(&key, trace->syscalls.table, trace->syscalls.table_size,
-		     sizeof(struct syscall), syscall__cmp);
 	return sc;
 }
 
@@ -3855,14 +3878,14 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
 	return -1;
 }
 
-static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *_sc)
+static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace,
+							     struct syscall *sc)
 {
-	struct syscall sc = *_sc; /* Copy as trace__syscall_info may invalidate pointer. */
 	struct tep_format_field *field, *candidate_field;
 	/*
 	 * We're only interested in syscalls that have a pointer:
 	 */
-	for (field = sc.args; field; field = field->next) {
+	for (field = sc->args; field; field = field->next) {
 		if (field->flags & TEP_FIELD_IS_POINTER)
 			goto try_to_find_pair;
 	}
@@ -3870,18 +3893,17 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 	return NULL;
 
 try_to_find_pair:
-	for (int i = 0, num_idx = syscalltbl__num_idx(sc.e_machine); i < num_idx; ++i) {
-		int id = syscalltbl__id_at_idx(sc.e_machine, i);
-		/* calling trace__syscall_info() may invalidate '_sc' */
-		struct syscall *pair = trace__syscall_info(trace, NULL, sc.e_machine, id);
+	for (int i = 0, num_idx = syscalltbl__num_idx(sc->e_machine); i < num_idx; ++i) {
+		int id = syscalltbl__id_at_idx(sc->e_machine, i);
+		struct syscall *pair = trace__syscall_info(trace, NULL, sc->e_machine, id);
 		struct bpf_program *pair_prog;
 		bool is_candidate = false;
 
-		if (pair == NULL || pair->id == sc.id ||
+		if (pair == NULL || pair->id == sc->id ||
 		    pair->bpf_prog.sys_enter == trace->skel->progs.syscall_unaugmented)
 			continue;
 
-		for (field = sc.args, candidate_field = pair->args;
+		for (field = sc->args, candidate_field = pair->args;
 		     field && candidate_field; field = field->next, candidate_field = candidate_field->next) {
 			bool is_pointer = field->flags & TEP_FIELD_IS_POINTER,
 			     candidate_is_pointer = candidate_field->flags & TEP_FIELD_IS_POINTER;
@@ -3948,7 +3970,8 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 				goto next_candidate;
 		}
 
-		pr_debug("Reusing \"%s\" BPF sys_enter augmenter for \"%s\"\n", pair->name, sc.name);
+		pr_debug("Reusing \"%s\" BPF sys_enter augmenter for \"%s\"\n", pair->name,
+			 sc->name);
 		return pair_prog;
 	next_candidate:
 		continue;
@@ -4044,11 +4067,7 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
 		pair_prog = trace__find_usable_bpf_prog_entry(trace, sc);
 		if (pair_prog == NULL)
 			continue;
-		/*
-		 * Get syscall info again as find usable entry above might
-		 * modify the syscall table and shuffle it.
-		 */
-		sc = trace__syscall_info(trace, NULL, e_machine, key);
+
 		sc->bpf_prog.sys_enter = pair_prog;
 
 		/*
@@ -5316,7 +5335,7 @@ static void trace__exit(struct trace *trace)
 	zfree(&trace->ev_qualifier_ids.entries);
 	if (trace->syscalls.table) {
 		for (size_t i = 0; i < trace->syscalls.table_size; i++)
-			syscall__exit(&trace->syscalls.table[i]);
+			syscall__delete(trace->syscalls.table[i]);
 		zfree(&trace->syscalls.table);
 	}
 	zfree(&trace->perfconfig_events);
-- 
2.49.0.rc1.451.g8f38331e32-goog


