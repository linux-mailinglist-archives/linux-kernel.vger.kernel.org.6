Return-Path: <linux-kernel+bounces-422833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C54B89D9ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46DFFB25C92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFA11DF75D;
	Tue, 26 Nov 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwDrUzt7"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB21D5AC6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656180; cv=none; b=mk/s1L6R2jS+3NmSffi7UYuvdqN/W8TaZW3nT7irsnlTo5je220fA8WHL7ssP+9oDaDD9LntX/FVapusCT9W9x8p+hv1w8XEmbuqL4gk/d801D9AKJO27mWwWWotlWGUMgQ2GXm4UUBvU4s0PRQAUAatf0y/+Nx1YDWg4foRJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656180; c=relaxed/simple;
	bh=HvvnpaGaFRoljBjelMH95duoMXY8SYF6uMx4mRgL0jg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EQ6xtM+Z4dbnAGYwDj3KF6gjsG+xww+AB4F88N6JtZPQ0v3oeGtf5A+e8kUMUi+v23cCWws16O7m8iSE2YD4B58OgLUXmYpZ3cHXTKCP4rxiJPFQkKH71EyABb/0wr43qnFaeGgTxtJv8dPZBzjDRX6akYVD6K8dxvLOF5O2+YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwDrUzt7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea9d209e75so5776435a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732656178; x=1733260978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e1SOqFacUzIyRzz4HVCOwpRa3L+4M0gEaauHwyt1g2A=;
        b=uwDrUzt7X/LjbuEm5o4gKJzexEfJIuit46NhbuS731HerOwbd9EZURtBf5qx5oS0B7
         LON/2rK69sB+Ly/EkqjKardFd+Eq6go4tNnUaCMw7l7KCDaA/D2EX+1MpSxixvnkU5Sm
         rAG4CPhsAs7FAOQQyL42yZYc2hWCNBv01neXPVeTUOOl7mYt1p+vPQRo1kwxuZkb4GNR
         pi4Qw/m3DeVRY+dfGB/KFUcOjA1teXXfO7IaOtYqEQI5Vsj1Ofuw7ye/cH1RN7sE5PJW
         Njh5rS66VMpD9NYagcP32U/+x1KPD2D2RqtmI9wb8q6YeFpBYMY/14ftwINZ/gw/IA8R
         kANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656178; x=1733260978;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1SOqFacUzIyRzz4HVCOwpRa3L+4M0gEaauHwyt1g2A=;
        b=UkfrdyJSGsH/m8J6PpklhyFd72s11HfS3uKmLbpKu+ni1tXyMNruMazGNxidxDv1oz
         YzeraBBW03omcZLJ0sAJz2Yw4QJGGbx6C0/kq1fkdLAhsHDZ3YoLLj5nhqI3qMmmURP0
         Q1IOxeLx2hXI8Ylg9k1PqHObRViL9nlacjTRJ1OVh6p6pOWsj48qbAbcsZWKjpIV56Wp
         5BOxKCr80RXhRXCPtFYl/5d5JnR0LwHbYbQGXu078z/iU5p+5JZ5ql4pWw60AYtZYE8w
         16RfFolu7uOXwvik+omEOug2QXiy18SbJnw6GhY/3/6dXjhfWeiymkkX0V29xyQKDI4h
         NIbw==
X-Gm-Message-State: AOJu0YyTrK4gPgE807NOZRXqJVZqI62hWPdG1nw2RrUPICT0htCNhx/e
	pxNOdKHwxH8A+ufSjjWcviDKqExEhvDzB0m0ujBPyvyrnCHi1dXaNv7JZXhrnVKzs1eynW9saHl
	tmgoQ8wnbX6/iB1R94Zg9Pro3OTIr9+YmPHkOyBxAw7ErW1OoRyJOP+D6fDIaG9bII7yFXffPqR
	k57Lm4CLvx+OhtRsaa2EssLahYtHzCflO53N3BMgGh
X-Google-Smtp-Source: AGHT+IH+bifWG7gRrLb93vmRF3BXdhy2Uec4UHi2abgi0cDfMB8YHgtZ//Ipl7Y53dO1XEiLhaZeY3s1w5s=
X-Received: from pjbnd17.prod.google.com ([2002:a17:90b:4cd1:b0:2e7:6ea5:ab67])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cf:b0:2ea:98f1:c172
 with SMTP id 98e67ed59e1d1-2ee08e9bd16mr1041897a91.7.1732656178293; Tue, 26
 Nov 2024 13:22:58 -0800 (PST)
Date: Tue, 26 Nov 2024 13:22:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126212255.3793822-1-ctshao@google.com>
Subject: [PATCH v3 1/2] perf lock: Rename fields in lock_type_table
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`lock_type_table` contains `name` and `str` which can be confusing.
Rename them to `flags_name` and `lock_name` and add descriptions to
enhance understanding.
Tested by building perf for x86.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-lock.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 062e2b56a2ab..c528aff1c9d5 100644
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
@@ -1595,24 +1600,24 @@ static const struct {
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
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
@@ -1620,11 +1625,11 @@ static const char *get_type_name(unsigned int flags)
 static unsigned int get_type_flag(const char *str)
 {
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].name, str))
+		if (!strcmp(lock_type_table[i].flags_name, str))
 			return lock_type_table[i].flags;
 	}
 	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
-		if (!strcmp(lock_type_table[i].str, str))
+		if (!strcmp(lock_type_table[i].lock_name, str))
 			return lock_type_table[i].flags;
 	}
 	return UINT_MAX;
@@ -1732,7 +1737,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "  %10s   %s\n", get_type_str(st->flags), st->name);
+		fprintf(lock_output, "  %10s   %s\n", get_type_flags_name(st->flags), st->name);
 		break;
 	case LOCK_AGGR_TASK:
 		pid = st->addr;
@@ -1742,7 +1747,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned long long)st->addr,
-			st->name, get_type_name(st->flags));
+			st->name, get_type_lock_name(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "  %s\n", st->name);
@@ -1783,7 +1788,8 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		fprintf(lock_output, "%s%s %s", get_type_str(st->flags), sep, st->name);
+		fprintf(lock_output, "%s%s %s",
+			get_type_flags_name(st->flags), sep, st->name);
 		if (verbose <= 0)
 			fprintf(lock_output, "\n");
 		break;
@@ -1795,7 +1801,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 		break;
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
-			st->name, sep, get_type_name(st->flags));
+			st->name, sep, get_type_lock_name(st->flags));
 		break;
 	case LOCK_AGGR_CGROUP:
 		fprintf(lock_output, "%s\n",st->name);
-- 
2.47.0.338.g60cca15819-goog


