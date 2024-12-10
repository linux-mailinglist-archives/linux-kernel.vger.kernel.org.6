Return-Path: <linux-kernel+bounces-440243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23669EBAA3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AD916669E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1F222689E;
	Tue, 10 Dec 2024 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2MykMy4t"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F506226896
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861358; cv=none; b=VsD2Ae1GzGigq8TxQ90TyKuzcoowXku4wqeZonkooK/x4lgzwSq0SVUjd+MslKAPEwOr82zlZ5mwEIcWA5Pax+jRRXRGslst/F3j8wm47LsAr6gpVh2CAE9phQXBCkNneG0GpkMrJkZ9AE5quRcsYfBzc6gQiBtbDLxQ08OFlCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861358; c=relaxed/simple;
	bh=ck8Hd3SR0iGyByfJ6I46aAcyZqxhi0OpQSk1clm98Bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tIhZa10fPuLaT2yodW1I4qsafycVTm2gcAYso8BC4r+Wulh8KFtlmAZdt+ggz+H79kCMVm56GjD5feyMLU71Ou4S3cKdZWhb7vUL7eckP3NNlidbbMMyYWeQS2d0KH7fUEO9DxDzZyR07Ebd7fgfiY7/Bf54oSdwyAWyfAP9nWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2MykMy4t; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef7fbd99a6so3597701a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733861356; x=1734466156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HyrPhgjJ+1dXPotsc2MzygIYEs9nqOKXdT/6gyKv/8=;
        b=2MykMy4t0x2HAryEQEWCYqPLwNBWoAuJd3NzKpYet2PyWy1YzWgQfL2hcpc8lwCEH2
         JN2RP5T4tPt7tbO+uzMZR2/yXhZb0xyMdUmcdR4f2Ypphli9QzLsmP4Wkhg848ZmfbZ3
         121ZflRiygKuig2HAFPdwRVYXVSOxaQNaLTOIQ5QFpXKTWi8Zv6FpdphjrbOG9MR3rNK
         lU/7c9hjSRMSbNC119RwKv8ChXIA58qSrejaFYYm9Zw423zr+GUX7fqnpsC0QRvK+eQY
         ydZCoG56IhP9iXOHUKzPmbvsFRCLkSyM1i/6NpK3n+9qZWddsT5D7lPJsd+Aw2ytahKN
         jCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861356; x=1734466156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HyrPhgjJ+1dXPotsc2MzygIYEs9nqOKXdT/6gyKv/8=;
        b=dl64MgACfZTUUQ/b6Q0Xu17V3vfZrYcH9vShO9yAdhD9GRynJRisetPRpWpFuFqsJM
         MQzeDWNhcHCAmvh9dHPKVAaWG/Gr2raxoLwIo1BHoiIvnE0Y7pJpSfY7Zp/ttCEZqUnZ
         KwQOpd4nmjWtABE1ocChsqFy5unnuGkYQcDWTrAtqTCl09P+Yf45mcCQ7sK40TlHPspH
         imnQhLBdAjtv81zzMK+yDoe8msvR+hj5Hm7QFkJ1DcFhgbXZFbSOzGXn7wZpnxykLSVQ
         GGC7eVqZdSyYdGX0K8ilKb+aNNIIyrT+20rBezk/UdBx6yCHRlH9RjGKfEp1Vm0Xpnxm
         aD4Q==
X-Gm-Message-State: AOJu0YyaGORtSI4pgSx68V0DZ++OyJhZPsfVsDLwe9I5grrkZJk5rfUb
	6+GcTlxTsCxJxPLjVd7TyEStAaJZS9QkY/ir+/9/Y/9Swy5tuODd+DkBcpqyP4ljq6NRawzIkva
	eIoCtMGNkKAabpaKrlZIwDlAi5WxkB/tr2eOxHjQpn3sL5+aV/gwpX84YEEVxIur9vkVygHbw5K
	s/6pZRg0ZOko1MGdjR16rL4nQHJ8ykTDhVkisWwE7h
X-Google-Smtp-Source: AGHT+IEjfTytgoJ35UzZBexgXiatnz+zPJl0oVOFMIeGrDe1QsRe/uTVkBeHQlSnJPBwALaWH4E9LzX/uXo=
X-Received: from pjuj11.prod.google.com ([2002:a17:90a:d00b:b0:2e0:9fee:4b86])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c05:b0:2ee:f687:6ad5
 with SMTP id 98e67ed59e1d1-2f127f55592mr437358a91.2.1733861355836; Tue, 10
 Dec 2024 12:09:15 -0800 (PST)
Date: Tue, 10 Dec 2024 12:08:22 -0800
In-Reply-To: <20241210200847.1023139-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210200847.1023139-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Message-ID: <20241210200847.1023139-3-ctshao@google.com>
Subject: [PATCH v5 3/3] perf lock: Rename fields in lock_type_table
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`lock_type_table` contains `name` and `str` which can be confusing.
Rename them to `flags_name` and `lock_name` and add descriptions to
enhance understanding.
Tested by building perf for x86.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 50630551adad..74085c8e32d3 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1575,8 +1575,13 @@ static void sort_result(void)
 
 static const struct {
 	unsigned int flags;
-	const char *str;
-	const char *name;
+	/*
+	 * Name of the lock flags (access), with delimeter ':'.
+	 * For example, rwsem:R of rwsem:W.
+	 */
+	const char *flags_name;
+	/* Name of the lock (type), for example, rwlock or rwsem. */
+	const char *lock_name;
 } lock_type_table[] = {
 	{ 0,				"semaphore",	"semaphore" },
 	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
@@ -1593,24 +1598,24 @@ static const struct {
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
 };
 
-static const char *get_type_str(unsigned int flags)
+static const char *get_type_flags_name(unsigned int flags)
 {
 	flags &= LCB_F_MAX_FLAGS - 1;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
-			return lock_type_table[i].str;
+			return lock_type_table[i].flags_name;
 	}
 	return "unknown";
 }
 
-static const char *get_type_name(unsigned int flags)
+static const char *get_type_lock_name(unsigned int flags)
 {
 	flags &= LCB_F_MAX_FLAGS - 1;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 		if (lock_type_table[i].flags == flags)
-			return lock_type_table[i].name;
+			return lock_type_table[i].lock_name;
 	}
 	return "unknown";
 }
@@ -1717,7 +1722,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "  %10s   %s\n", get_type_str(st->flags), st->name);
+		fprintf(lock_output, "  %10s   %s\n", get_type_flags_name(st->flags), st->name);
 		break;
 	case LOCK_AGGR_TASK:
 		pid = st->addr;
@@ -1727,7 +1732,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned long long)st->addr,
-			st->name, get_type_name(st->flags));
+			st->name, get_type_lock_name(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "  %s\n", st->name);
@@ -1768,7 +1773,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "%s%s %s", get_type_str(st->flags), sep, st->name);
+		fprintf(lock_output, "%s%s %s", get_type_flags_name(st->flags), sep, st->name);
 		if (verbose <= 0)
 			fprintf(lock_output, "\n");
 		break;
@@ -1780,7 +1785,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
-			st->name, sep, get_type_name(st->flags));
+			st->name, sep, get_type_lock_name(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "%s\n",st->name);
@@ -2343,10 +2348,10 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
 		bool found = false;
 
-		/* `tok` is `str` in `lock_type_table` if it contains ':'. */
+		/* `tok` is a flags name if it contains ':'. */
 		if (strchr(tok, ':')) {
 			for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-				if (!strcmp(lock_type_table[i].str, tok) &&
+				if (!strcmp(lock_type_table[i].flags_name, tok) &&
 				    add_lock_type(lock_type_table[i].flags)) {
 					found = true;
 					break;
@@ -2363,14 +2368,14 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 		}
 
 		/*
-		 * Otherwise `tok` is `name` in `lock_type_table`.
+		 * Otherwise `tok` is a lock name.
 		 * Single lock name could contain multiple flags.
 		 * Replace alias `pcpu-sem` with actual name `percpu-rwsem.
 		 */
 		if (!strcmp(tok, "pcpu-sem"))
 			tok = (char *)"percpu-rwsem";
 		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-			if (!strcmp(lock_type_table[i].name, tok)) {
+			if (!strcmp(lock_type_table[i].lock_name, tok)) {
 				if (add_lock_type(lock_type_table[i].flags)) {
 					found = true;
 				} else {
-- 
2.47.1.545.g3c1d2e2a6a-goog


