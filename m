Return-Path: <linux-kernel+bounces-529863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2480A42BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710C8179D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B07266577;
	Mon, 24 Feb 2025 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1KpQT9j"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2AB263F59
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422989; cv=none; b=mxf4De1bC8Ee2LUAxymM80l5GEi9qzFlJpspiFFaLNErKdumHN189TK10H6meojnaEx9huhagv4q7NQjcEuQa9VWYihShBfeNYj96O9eRIXp8VDoSLW7Bu2UEu61fm611BqH8s66WbkvXMLyF5r+cV5nEqHFtOfPnoGc50Hok50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422989; c=relaxed/simple;
	bh=uMnqvAw20MjO8y1DkOGmvKZ76yZAmQWMHc3q5tVE6c4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=di027tMjOGv+jigghW+lYxv3c/FXbPUTmTEnfu3+3UsBvLKL+/0EJAnx7C6zjuUmTHlyLjKJTzGTH3W2NTTlIeYprfYAbhQlKB+huDQR6u/+iB0Q9wasjbg8zaPVnkQNKnulFarShGeCKWEdsK0wDnTBD8XcVaDOZgiq4qAuF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z1KpQT9j; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so15725357a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740422987; x=1741027787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LIHL/AK+Ozu93SKs05RSuuBRbA8GccmzuqZN2pzdx8=;
        b=Z1KpQT9jJX3mdhPHgOKCypSGCxakMaANE2uRlvMkinlGzTPv3ZLXQBlOV48WN3twTp
         uoPkMmF8B558NhoBpFTLxXvk6TZme2qczs8SKs+Bxlxl8qifVb1kd60cBLymQm6jAZ7O
         rk4f9mjNijsxy3U2jvb4NGKp6mlJ8DYbp5l1nZ2E4bbu0xLmJYKt91jJgJpbxIc1mayd
         EPIW7iW7ZluAF/TzEjOpvrjuHZylX+3Wvs8U+M+lL+fGX6tHl3YMrDu0ZU17VCksYFsF
         zVTaLfK44/GWC93WVPe1XEmxENa6d6cMlsy8H3jSso7+zovPMLGB6L3zqhtwc1P6/4Q5
         5wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422987; x=1741027787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LIHL/AK+Ozu93SKs05RSuuBRbA8GccmzuqZN2pzdx8=;
        b=KtdB9m4CUevyGMZqjkkaysbtpaeuG7kCU5Fz1hY+744/8G0cxv8StZx0oSJEqlAXa8
         zfNgftBzaxJds2r+OttD8jA38t7oNufkBEGXHYmpjOMCWdi06EETjhlZrsOUaE1gVck9
         uwfPmKkqMcEF3rUS2KWhb+MMAVDGFW4QCAi40swMH6ZHT3lqEdXjPgdyGdmhT7HhP+uO
         4lBQg1hMH/k1XbtFkrC+VBB70B0vaoanvS7XLt+3JNyFQbDvq3LElHsTVyyJjXwsuXaP
         DYg4s/j3sHVbD0r6usYQ7tpl6B+kfPR9xSWOwnT6fi9Dy2biIsUpfBfIzG/2ss6hxKg6
         YXEA==
X-Gm-Message-State: AOJu0Yw1ySi+Or00BRT1c9/o3XjHQPGkrqGYw31YznpNOJfDwxk8cJQO
	ydImYtCTwe8LGEI0LbE6VfcTe8va8oXz1TO9KTR2BR66kAupbmmNvS3Fr7E69+AqimK4IGkCmtE
	SPPM8WL6QWMmsjJhjq9xYhAn8cLWP2FhFKbLlBDfidr3wc4dX4WDLlhRJb3WHD50KODvyHyLV3f
	DjsgUlDjnnjZ9t+TPa2tjDEBNmvKr+Vfu81XAoOSQ7
X-Google-Smtp-Source: AGHT+IEh1EoJ/IsWmaDouBD9aRZTYrXlU/wFe3qPhbp9wKPPXJthGmxpT4u1854QjNGNn1vgPxuVUrbYIGg=
X-Received: from pjbtb3.prod.google.com ([2002:a17:90b:53c3:b0:2f4:465d:5c61])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e51:b0:2ea:4c8d:c7a2
 with SMTP id 98e67ed59e1d1-2fce7b23af6mr25948512a91.24.1740422986785; Mon, 24
 Feb 2025 10:49:46 -0800 (PST)
Date: Mon, 24 Feb 2025 10:42:48 -0800
In-Reply-To: <20250224184742.4144931-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224184742.4144931-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250224184742.4144931-2-ctshao@google.com>
Subject: [PATCH v7 1/4] perf lock: Add bpf maps for owner stack tracing
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
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
2.48.1.658.g4767266eb4-goog


