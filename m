Return-Path: <linux-kernel+bounces-512002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A39A33298
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E9B188AFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810022045B5;
	Wed, 12 Feb 2025 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKodKl2x"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCDE20408E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399380; cv=none; b=SAgM4OkTLsZvx6AI7P8zGSePW+r2hBuS9X6+5TWvKuGBwhRbzgYI+Zgv1rcPIWAjj37DO9wJ6fBZdmTsAN2iuEwBvNuiGa9hCNamRl9DKWdwH7W9g7EcA/SoZkRWRjNsuTT1TAeaak64Owaf9GKqFch7WJRNvd0DHC0kc0WNs+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399380; c=relaxed/simple;
	bh=OWCpQfV15fjfs91X5TWsuZAUowIODtiQVMeIkdX4org=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sovv6ssLrkxXqtJmfj/uaylDptaOdkyEb0lYMUjis0XeZcOUkcg1vs6AZ1MK6g+31tAFjLD0Gk/mXUATJIEC4XBfync34aKt1xNo2zNre85t00ONSwKTx6VE+f+9TAXcx20f348Klsf43x90NVSS1hJulyrEz2iE2nn9OsbzHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKodKl2x; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220c86b3ef3so13955465ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399379; x=1740004179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9bMfrQLSuEn1cesD7grG9bYwMcsNdAGFS2Zv9IEeA=;
        b=GKodKl2xsijJnTBjQXXPUlKW0+mMUsJl7wZtA6aIW9wC6NxCQ2oX9ZCGor19cj81r+
         MRi+19Wsl72u1IWWKxwoh5axym4lTok47JlyQLuj7Ff/p/sHiG+fd8hia/AyhKZumA8b
         VAw9+ukQI7jazkFIR49luKxcVeS76Feu7hzGVIl/t98sNsQx0UseNICA1cm/u6LuD43+
         UCl6x5FQcXr3ksaA8gvTIfnaxQzn5I3ApTpF5AJoM/vpd5+3NwVm9n1PkifBTgI18wNT
         QJw8xMtmIttSUzRj3ASS2pm/Ix2vg7McgQPzn8Vj6oxepgpwPxA5gOhLhMu8NYd2fZT9
         J9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399379; x=1740004179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9bMfrQLSuEn1cesD7grG9bYwMcsNdAGFS2Zv9IEeA=;
        b=wOrSJf3Z2ToFJQhVorhKJqJX/c4HC5b1OXdQjrF9GNiLeEQ1EWcNcLoNtRNVcFCeTW
         IFmWzIiCmFpN7JzD/0Vz3uqhlvVc2BB/wyK43LaU+k9W8NkiE0iJ5EVhitCzFzsSC4sT
         O5sWOKFp2UUkEj19ymWRrOp0h/Y7d5aa+aeGT88Y43La6G3vrhWORN8xG31FNvWHr6Tq
         ev0zX9hpxaXBb/iS6Pe3iVwQsXsf9W6Jcqa7LBCzlvJMl0nSkgEgz7nFx5gLPO3M7rwL
         XpJJ/qWvzhc9dOHIsZFVOj6OnJLzyIz4I9DRglkCEdCi3cLz2RRE9tkKZWW7JpLIpWEn
         RpxQ==
X-Gm-Message-State: AOJu0Yz0JG94SRDMOgQv7dru9h6Fqelda229xs8BZcuB+niZCKC6o8GF
	YE7bpL+Gymm8JhsvndeihCBlGoOJP6SI70hMluMpKXGFa8IxLz+JU5gjG01EaDAObovz4tklaJu
	cfP7h42s5p7/4MdshvOie6ZUp0DsaKBwg3gqgFwCDEIXmhaBwiXPSLrZhpVvx/sLzbG/GiNDjva
	XQtBL+10X6xuwsSbhT7mxWf8aBW5vP9Hxu0ixpgb8S
X-Google-Smtp-Source: AGHT+IGH91oQbQqQOltRzwNzcwjx/9c8q5oX8zM6hIaW2Mk5foDZ/RclC94i5ELe3GWDZVuHmetFFqhI8es=
X-Received: from pgbcr7.prod.google.com ([2002:a05:6a02:4107:b0:ad5:55c3:4034])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cb:b0:1ee:64c0:aa85
 with SMTP id adf61e73a8af0-1ee6c619d45mr958280637.6.1739399378557; Wed, 12
 Feb 2025 14:29:38 -0800 (PST)
Date: Wed, 12 Feb 2025 14:24:52 -0800
In-Reply-To: <20250212222859.2086080-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212222859.2086080-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212222859.2086080-2-ctshao@google.com>
Subject: [PATCH v5 1/5] perf lock: Add bpf maps for owner stack tracing
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a struct and few bpf maps in order to tracing owner stack.
`struct owner_tracing_data`: Contains owner's pid, stack id, timestamp for
  when the owner acquires lock, and the count of lock waiters.
`stack_buf`: Percpu buffer for retrieving owner stacktrace.
`owner_stacks`: For tracing owner stacktrace to customized owner stack id.
`owner_data`: For tracing lock_address to `struct owner_tracing_data` in
  bpf program.
`owner_stat`: For reporting owner stacktrace in usermode.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/bpf_lock_contention.c         | 14 ++++++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 33 +++++++++++++++++++
 tools/perf/util/bpf_skel/lock_data.h          |  7 ++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index fc8666222399..76542b86e83f 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -131,10 +131,20 @@ int lock_contention_prepare(struct lock_contention *con)
 	else
 		bpf_map__set_max_entries(skel->maps.task_data, 1);
 
-	if (con->save_callstack)
+	if (con->save_callstack) {
 		bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
-	else
+		if (con->owner) {
+			bpf_map__set_value_size(skel->maps.stack_buf, con->max_stack * sizeof(u64));
+			bpf_map__set_key_size(skel->maps.owner_stacks,
+						con->max_stack * sizeof(u64));
+			bpf_map__set_max_entries(skel->maps.owner_stacks, con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_data, con->map_nr_entries);
+			bpf_map__set_max_entries(skel->maps.owner_stat, con->map_nr_entries);
+			skel->rodata->max_stack = con->max_stack;
+		}
+	} else {
 		bpf_map__set_max_entries(skel->maps.stacks, 1);
+	}
 
 	if (target__has_cpu(target)) {
 		skel->rodata->has_cpu = 1;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 6533ea9b044c..23fe9cc980ae 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -27,6 +27,38 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } stacks SEC(".maps");
 
+/* buffer for owner stacktrace */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, 1);
+} stack_buf SEC(".maps");
+
+/* a map for tracing owner stacktrace to owner stack id */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // owner stacktrace
+	__uint(value_size, sizeof(__s32)); // owner stack id
+	__uint(max_entries, 1);
+} owner_stacks SEC(".maps");
+
+/* a map for tracing lock address to owner data */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64)); // lock address
+	__uint(value_size, sizeof(struct owner_tracing_data));
+	__uint(max_entries, 1);
+} owner_data SEC(".maps");
+
+/* a map for contention_key (stores owner stack id) to contention data */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(struct contention_key));
+	__uint(value_size, sizeof(struct contention_data));
+	__uint(max_entries, 1);
+} owner_stat SEC(".maps");
+
 /* maintain timestamp at the beginning of contention */
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
@@ -143,6 +175,7 @@ const volatile int needs_callstack;
 const volatile int stack_skip;
 const volatile int lock_owner;
 const volatile int use_cgroup_v2;
+const volatile int max_stack;
 
 /* determine the key of lock stat */
 const volatile int aggr_mode;
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index c15f734d7fc4..15f5743bd409 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -3,6 +3,13 @@
 #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
 #define UTIL_BPF_SKEL_LOCK_DATA_H
 
+struct owner_tracing_data {
+	u32 pid; // Who has the lock.
+	u32 count; // How many waiters for this lock.
+	u64 timestamp; // The time while the owner acquires lock and contention is going on.
+	s32 stack_id; // Identifier for `owner_stat`, which stores as value in `owner_stacks`
+};
+
 struct tstamp_data {
 	u64 timestamp;
 	u64 lock;
-- 
2.48.1.502.g6dc24dfdaf-goog


