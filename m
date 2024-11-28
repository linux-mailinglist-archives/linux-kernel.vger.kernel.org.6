Return-Path: <linux-kernel+bounces-424749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C3F9DB8E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D0C160652
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C6E1BC066;
	Thu, 28 Nov 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FQ1Ll09+"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20B1BAEDC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801015; cv=none; b=aWQrad/hohZ6+9yTVhhPH3w16vOkN+qOaJUKu0k0z2Xx4m7EdGE44gm3WWtx+rfFvqhivs0VpStFg+FSsmnmLu2EvyJ5H+5AbSCi7aPz9BMBYNCKx6fKucIAmRwNIDnnbaQ0hr7Lwhq551y0cY/VhFSYf8bMgOlXmP+0Dnf/Kc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801015; c=relaxed/simple;
	bh=LWzk7LsEir8pNmymF4y7WFSgVSAN9W9Dot8AfN2IGYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cl5a0hrwD2ZKBXQDY9FwljkKTAQEoQaM7mV7Lku8VH+F8AeZ9f1yu+iG6ak0ThDuV/iTSHnksqjkvDSMnSgdLPMCPHot2ze1vxnyOEMJ5GeLqtvoOopEyQ24+xF7y0/sIxaxXYMEsUYfFNF83FzsXvZg4rz3bB5pBskWzoJsyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FQ1Ll09+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7248c1849bdso819301b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732801013; x=1733405813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pF/gTcrGXSS4/ort4kcDDgWrRYgYOYuykRq88RGJ3I=;
        b=FQ1Ll09+VXIQKop+iIudWEH40bI3x3pTChkTYXZE6r0KggrborSitune/nCsAiLNkB
         CSsC7RYqLGy4X4nTvQAfY9W+6BgvOhMBJGwQYvuH+YzY/BqToLurxB9xEun4bbLXSwcN
         05NZVq654omiTkWLzEROSQo1UZ26Fh0QhhGln5vz3RB1exq+VRA3PNSzL5JBePgUuquk
         GoMmRT2uwl7F1BOQZSuNwi22U4gFo7ty9psvOt/cPtWY7enjEvaR6cFNU+MeZuhdKXGX
         oA7XyVofATzOZT5gI4gvTvIQewVHqe51aQbPPOhU5/KwpqKMOtHHfmhqmD//JlJGLIXs
         SD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801013; x=1733405813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pF/gTcrGXSS4/ort4kcDDgWrRYgYOYuykRq88RGJ3I=;
        b=wlF9XEraGKT2qCCqDHcMiEKx8O/jn4fpLD8WhplrejXhRvPip1PbJPbrwUp5uBt39v
         R6JMVzqlBoseAr5Q4nZ9CrCIGBkYLXq2ekMtQXv3OitfDOATgsoHuN0qVyk2YXawt1Qr
         p1zwVvQxA3KbCiLZhhDqGgt+D1nXreqrTvRkQfSs9xKc6Lp14eUIMP/f4t8CKgXpOQGj
         tgeATW8zqOGR2NJ79iGbeFrM19PsnBMQtrNWUu3VSy82Qyo4mkaeS4sBEIqIHHw0oFUM
         SmtAPkro1NcWGrEdXQbN9+D3t7XTAJCjmhily9kQlxBoNS8PCF6pufIZkaJ2avzVjO3c
         k5jg==
X-Forwarded-Encrypted: i=1; AJvYcCXejw1MFqBYaQOfW1H5YG09B8X9yAaDLZ8KnWAC3cSJpZwwPR1ZvVvMYmbhyFKlBP92XbCi5CX6v3jPBPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOiPzy55m21woJironzFX7yG0s7wNIUGOajLxQQEnCVaGtHwB
	RHWzFp/vRfUNnwrQOvIQTdk8rVfSPAgrhPbsopJnEP7xdSSSsT7bKQKRglw6Zfk=
X-Gm-Gg: ASbGncvl0d6532VVePLy26qNFMHtqaMivqaXcE5OYyt99ofRPPBXUGTwNXzQyso5uOc
	75yIwO5BN1taf18ckkZwXhulFNDqAsIJPxnw6QpmGb7/o4j8P37zX8GNlRItgKTuODAvSxbxso3
	i5O2lDbdZ79gDxQI3kQmlrB7rz2pSLrwf1y8dmoIw55irck9iqgXONBvAfkfBXuw9VchSgwk/Pi
	v4aDYLQk35LtjoaXbvkigqs/Eweg+WxVY+xeOLT8oCsnY0GKRubVHyjXQ==
X-Google-Smtp-Source: AGHT+IHIMHJ67LGq/eKXuEzSHfGZ3n5mOwtZ6W1GG7x7VI5A2fu//2XROxW0PWDTJEFBPPaWxmGEEQ==
X-Received: by 2002:a17:902:ecd0:b0:205:3e6d:9949 with SMTP id d9443c01a7336-21501f63bebmr73513465ad.52.1732801012880;
        Thu, 28 Nov 2024 05:36:52 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:52 -0800 (PST)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [RFC 07/12] perf event action: Add parsing builtin expr support
Date: Thu, 28 Nov 2024 21:35:48 +0800
Message-Id: <20241128133553.823722-8-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128133553.823722-1-yangjihong@bytedance.com>
References: <20241128133553.823722-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

builtin exprs are some built-in special variables (such as cpu, tid, pid).
The bpf program attaches to corresponding event, saves sample data to bpf
perf_event ringuffer in handler, perf-tool read data and run actions.

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/Makefile.perf                     |   1 +
 tools/perf/util/bpf_skel/bpf_record_action.h |  19 +
 tools/perf/util/bpf_skel/record_action.bpf.c |  74 ++++
 tools/perf/util/parse-action.c               |  22 ++
 tools/perf/util/parse-action.h               |   5 +
 tools/perf/util/parse-action.l               |   6 +
 tools/perf/util/parse-action.y               |  11 +-
 tools/perf/util/record_action.c              | 352 ++++++++++++++++++-
 tools/perf/util/record_action.h              |   8 +-
 9 files changed, 492 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/bpf_record_action.h
 create mode 100644 tools/perf/util/bpf_skel/record_action.bpf.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d74241a15131..07bc2f8e2565 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1173,6 +1173,7 @@ SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_top.skel.h
 SKELETONS += $(SKEL_OUT)/bench_uprobe.skel.h
 SKELETONS += $(SKEL_OUT)/augmented_raw_syscalls.skel.h
+SKELETONS += $(SKEL_OUT)/record_action.skel.h
 
 $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
diff --git a/tools/perf/util/bpf_skel/bpf_record_action.h b/tools/perf/util/bpf_skel/bpf_record_action.h
new file mode 100644
index 000000000000..ee4d03848e58
--- /dev/null
+++ b/tools/perf/util/bpf_skel/bpf_record_action.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_UTIL_BPF_SKEL_BPF_RECORD_ACTION_H_
+#define __PERF_UTIL_BPF_SKEL_BPF_RECORD_ACTION_H_
+
+#define __TASK_COMM_MAX_SIZE 16
+
+#define __OUTPUT_FORMATS_MAX_NUM 8
+
+enum __output_format_type {
+	__OUTPUT_FORMAT_TYPE_MAX,
+};
+
+#define __OUTPUT_DATA_MAX_SIZE 256
+struct __output_data_payload {
+	__u32 __size;
+	__u8 __data[__OUTPUT_DATA_MAX_SIZE];
+};
+
+#endif /* __PERF_UTIL_BPF_SKEL_BPF_RECORD_ACTION_H_ */
diff --git a/tools/perf/util/bpf_skel/record_action.bpf.c b/tools/perf/util/bpf_skel/record_action.bpf.c
new file mode 100644
index 000000000000..424fa8c3e6f1
--- /dev/null
+++ b/tools/perf/util/bpf_skel/record_action.bpf.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#include "bpf_record_action.h"
+
+int output_formats[__OUTPUT_FORMATS_MAX_NUM] = { 0 };
+int output_format_num = 0;
+int enabled = 0;
+
+#define MAX_CPUS  1024
+
+/* bpf-output associated map */
+struct __sample_data__ {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, int);
+	__type(value, __u32);
+	__uint(max_entries, MAX_CPUS);
+} __sample_data__ SEC(".maps");
+
+struct sample_data_tmp {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, int);
+	__type(value, struct __output_data_payload);
+	__uint(max_entries, 1);
+} sample_data_tmp SEC(".maps");
+
+static inline struct __output_data_payload *sample_data_payload(void)
+{
+	int key = 0;
+
+	return bpf_map_lookup_elem(&sample_data_tmp, &key);
+}
+
+SEC("xxx")
+int sample_output(u64 *ctx)
+{
+	struct __output_data_payload *sample;
+	int i;
+	int total = 0;
+	int ret = 0;
+
+	if (!enabled)
+		return 0;
+
+	sample = sample_data_payload();
+	if (!sample)
+		return 0;
+
+	for (i = 0; i < output_format_num && i < __OUTPUT_FORMATS_MAX_NUM; i++) {
+		switch (output_formats[i]) {
+		default:
+			ret = -1;
+			break;
+		}
+
+		if (ret < 0)
+			return 0;
+
+		total += ret;
+		if (total > __OUTPUT_DATA_MAX_SIZE)
+			return 0;
+	}
+
+	sample->__size = total;
+	bpf_perf_event_output(ctx, &__sample_data__, BPF_F_CURRENT_CPU,
+			      sample, sizeof(__u32) + total);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 95c06cc071ad..e6299de99bc5 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -11,6 +11,7 @@
  *     - string
  *   - call:
  *     - print
+ *   - builtin:
  */
 
 #include <regex.h>
@@ -19,6 +20,7 @@
 #include "util/parse-action.h"
 #include "util/parse-action-flex.h"
 #include "util/parse-action-bison.h"
+#include "util/record_action.h"
 
 static struct list_head actions_head = LIST_HEAD_INIT(actions_head);
 
@@ -90,10 +92,30 @@ static int parse_action_option(const char *str)
 	return ret;
 }
 
+static bool initialized = false;
+static int parse_action_init(void)
+{
+	int ret;
+
+	if (initialized)
+		return 0;
+
+	ret = bpf_perf_record_init();
+	if (ret)
+		return ret;
+
+	initialized = true;
+	return 0;
+}
+
 int parse_record_action(struct evlist *evlist, const char *str)
 {
 	int ret;
 
+	ret = parse_action_init();
+	if (ret)
+		return ret;
+
 	if (evlist == NULL) {
 		pr_err("--action option should follow a tracer option\n");
 		return -1;
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index f8aece601a84..b1a33a77c558 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -11,6 +11,7 @@
 enum evtact_expr_type {
 	EVTACT_EXPR_TYPE_CONST,
 	EVTACT_EXPR_TYPE_CALL,
+	EVTACT_EXPR_TYPE_BUILTIN,
 	EVTACT_EXPR_TYPE_MAX,
 };
 
@@ -25,6 +26,10 @@ enum evtact_expr_call_type {
 	EVTACT_EXPR_CALL_TYPE_MAX,
 };
 
+enum evtact_expr_builtin_type {
+	EVTACT_EXPR_BUILTIN_TYPE_MAX,
+};
+
 struct evtact_expr;
 struct evtact_expr_ops {
 	int (*new)(struct evtact_expr *expr, void *data, int size);
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index 5e75383ba3e7..1c729b7a0248 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -82,6 +82,12 @@ static int call(u32 opcode)
 	return CALL;
 }
 
+static int builtin(u32 opcode)
+{
+	parse_action_lval.opcode = opcode;
+	return BUILTIN;
+}
+
 %}
 
 num_dec		[0-9]+
diff --git a/tools/perf/util/parse-action.y b/tools/perf/util/parse-action.y
index 1b162c694218..78a15f146ade 100644
--- a/tools/perf/util/parse-action.y
+++ b/tools/perf/util/parse-action.y
@@ -38,14 +38,14 @@ static void parse_action_error(struct list_head *expr __maybe_unused,
 	u32 opcode;
 }
 
-%token IDENT ERROR NUMBER STRING CALL
+%token IDENT ERROR NUMBER STRING CALL BUILTIN
 %token SEMI LP RP COM
 %type <expr> action_term expr_term expr_call_term
 %destructor { parse_action_expr__free($$); } <expr>
 %type <str> IDENT
 %type <num> NUMBER
 %type <str> STRING
-%type <opcode> CALL
+%type <opcode> CALL BUILTIN
 %type <list> opnds
 
 %%
@@ -132,6 +132,13 @@ STRING
 		YYERROR;
 }
 |
+BUILTIN
+{
+	$$ = parse_action_expr__new(evtact_expr_id_encode(EVTACT_EXPR_TYPE_BUILTIN, $1), NULL, NULL, 0);
+	if ($$ == NULL)
+		YYERROR;
+}
+|
 IDENT
 {
 	$$ = NULL;
diff --git a/tools/perf/util/record_action.c b/tools/perf/util/record_action.c
index 44789e0d4678..634d6b199bae 100644
--- a/tools/perf/util/record_action.c
+++ b/tools/perf/util/record_action.c
@@ -1,15 +1,361 @@
 // SPDX-License-Identifier: GPL-2.0
 /**
- * Read event sample data and execute the specified actions.
+ * Read perf event output sample data and execute the specified actions.
  */
 
+#include <errno.h>
+#include <signal.h>
+#include <sys/wait.h>
+#include <linux/err.h>
+
 #include "util/debug.h"
+#include "util/target.h"
 #include "util/parse-action.h"
 #include "util/record_action.h"
 
-int bpf_perf_record(struct evlist *evlist __maybe_unused,
-		    int argc __maybe_unused, const char **argv __maybe_unused)
+#include "util/bpf_counter.h"
+#include "util/bpf_skel/bpf_record_action.h"
+#include "util/bpf_skel/record_action.skel.h"
+
+static struct perf_buffer *pb;
+static struct record_action_bpf *skel;
+
+struct expr_builtin_output_priv {
+	int offset;
+	int size;
+};
+
+static int bpf_expr_builtin_new(struct evtact_expr *expr,
+				void *data __maybe_unused, int size __maybe_unused)
+{
+	struct expr_builtin_output_priv *priv;
+
+	priv = malloc(sizeof(*priv));
+	if (priv == NULL) {
+		pr_err("bpf expr builtin priv malloc failed\n");
+		return -ENOMEM;
+	}
+
+	expr->priv = priv;
+	return 0;
+}
+
+static void bpf_expr_builtin_free(struct evtact_expr *expr)
+{
+	zfree(&expr->priv);
+}
+
+static int bpf_expr_builtin_eval(struct evtact_expr *expr,
+				 void *in, int in_size, void **out, int *out_size)
+{
+	struct expr_builtin_output_priv *priv = expr->priv;
+
+	if (in_size < priv->size)
+		return -EINVAL;
+
+	*out = (u8 *)in + priv->offset;
+	*out_size = priv->size;
+	return 0;
+}
+
+static struct evtact_expr_ops bpf_expr_builtin_common = {
+	.new  = bpf_expr_builtin_new,
+	.free = bpf_expr_builtin_free,
+	.eval = bpf_expr_builtin_eval,
+};
+
+static int bpf_expr_builtin_set_ops(struct evtact_expr *expr, u32 opcode)
+{
+	if (opcode >= EVTACT_EXPR_BUILTIN_TYPE_MAX) {
+		pr_err("bpf expr_builtin opcode invalid: %u\n", opcode);
+		return -EINVAL;
+	}
+
+	expr->ops = &bpf_expr_builtin_common;
+	return 0;
+}
+
+static struct evtact_expr_class bpf_expr_builtin = {
+	.set_ops = bpf_expr_builtin_set_ops,
+};
+
+int bpf_perf_record_init(void)
+{
+	return parse_action_expr__set_class(EVTACT_EXPR_TYPE_BUILTIN,
+					    &bpf_expr_builtin);
+}
+
+static int set_expr_builtin_output_format(struct evtact_expr *expr,
+					  u32 opcode, int *offset,
+					  int *format __maybe_unused)
+{
+	int size = 0;
+	struct expr_builtin_output_priv *priv = expr->priv;
+
+	switch (opcode) {
+	default:
+		pr_err("set expr builtin output format unknown opcode: %u\n", opcode);
+		return -1;
+	}
+
+	priv->offset = *offset;
+	priv->size = size;
+	*offset += size;
+	return 0;
+}
+
+struct output_args {
+	int *num;
+	int *offset;
+	int *formats;
+};
+
+static int do_set_output_format(struct evtact_expr *expr, void *data)
+{
+	int ret;
+	u32 type, opcode;
+	struct output_args *args = data;
+	int num = *(args->num);
+
+	evtact_expr_id_decode(expr->id, &type, &opcode);
+	if (type == EVTACT_EXPR_TYPE_BUILTIN) {
+		if (num >= __OUTPUT_FORMATS_MAX_NUM) {
+			pr_err("bpf record action output formats too many\n");
+			return -1;
+		}
+
+		ret = set_expr_builtin_output_format(expr, opcode, args->offset,
+						     args->formats + num);
+		if (ret)
+			return ret;
+		num++;
+	}
+
+	*(args->num) = num;
+	return 0;
+}
+
+static int bpf_set_output_format(int *formats)
+{
+	int ret;
+	int offset = 0;
+	int num = 0;
+	struct output_args args = {
+		.num     = &num,
+		.offset  = &offset,
+		.formats = formats,
+	};
+
+	ret = event_actions__for_each_expr(do_set_output_format, &args, true);
+	if (ret)
+		return ret;
+
+	if (offset > __OUTPUT_DATA_MAX_SIZE) {
+		pr_err("bpf record action output too large\n");
+		return -1;
+	}
+
+	skel->bss->output_format_num = num;
+	return 0;
+}
+
+
+struct eval_args {
+	void *data;
+	__u32 size;
+};
+
+static int do_sample_handler(struct evtact_expr *expr, void *data)
+{
+	int ret;
+	struct eval_args *args = data;
+
+	if (expr != NULL && expr->ops->eval != NULL) {
+		ret = expr->ops->eval(expr, args->data, args->size, NULL, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void sample_callback(void *ctx __maybe_unused, int cpu __maybe_unused,
+			    void *data, __u32 size __maybe_unused)
+{
+	struct __output_data_payload *sample_data = data;
+	struct eval_args args = {
+		.data = sample_data->__data,
+		.size = sample_data->__size,
+	};
+	(void)event_actions__for_each_expr(do_sample_handler, &args, false);
+}
+
+static void lost_callback(void *ctx __maybe_unused, int cpu, __u64 cnt)
+{
+	fprintf(stderr, "Lost %llu events on CPU #%d\n", cnt, cpu);
+}
+
+static int bpf_record_prepare(const char *subsystem, const char *event_name)
+{
+	int ret, map_fd;
+
+	skel = record_action_bpf__open();
+	if (!skel) {
+		pr_err("open record-action BPF skeleton failed\n");
+		return -1;
+	}
+
+	set_max_rlimit();
+
+	ret = bpf_program__set_type(skel->progs.sample_output, BPF_PROG_TYPE_TRACEPOINT);
+	if (ret) {
+		pr_err("set type record-action BPF skeleton failed\n");
+		goto out;
+	}
+
+	ret = record_action_bpf__load(skel);
+	if (ret) {
+		pr_err("load record-action BPF skeleton failed\n");
+		goto out;
+	}
+
+	ret = bpf_set_output_format(skel->bss->output_formats);
+	if (ret)
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.__sample_data__);
+	if (map_fd < 0) {
+		pr_err("map fd record-action BPF skeleton failed\n");
+		goto out;
+	}
+
+	skel->links.sample_output = bpf_program__attach_tracepoint(
+		skel->progs.sample_output, subsystem, event_name);
+	if (IS_ERR(skel->links.sample_output)) {
+		pr_err("attach record-action BPF skeleton failed\n");
+		goto out;
+	}
+
+	pb = perf_buffer__new(map_fd, 8, sample_callback,
+			      lost_callback, NULL, NULL);
+	ret = libbpf_get_error(pb);
+	if (ret) {
+		pr_err("setup record-action perf_buffer failed: %d\n", ret);
+		goto out;
+	}
+
+	return 0;
+
+out:
+	record_action_bpf__destroy(skel);
+	return -1;
+}
+
+static inline void bpf_record_start(void)
+{
+	skel->bss->enabled = 1;
+}
+
+static inline void bpf_record_stop(void)
 {
+	skel->bss->enabled = 0;
+}
+
+static volatile int done;
+static volatile sig_atomic_t child_finished;
+static void sig_handler(int sig)
+{
+	if (sig == SIGCHLD)
+		child_finished = 1;
+
+	done = 1;
+}
+
+static bool is_bpf_record_supported(struct evlist *evlist,
+				    char **subsystem, char **event_name)
+{
+	struct evsel *evsel;
+
+	if (evlist == NULL) {
+		pr_err("--action option should follow a tracer option\n");
+		return false;
+	}
+
+	/* only one fixed bpf prog and can only be attached to one event. */
+	if (evlist->core.nr_entries > 1) {
+		pr_err("too many events for specified action\n");
+		return false;
+	}
+
+	evsel = evlist__last(evlist);
+	if (evsel == NULL) {
+		pr_err("evlist for bpf record action is empty\n");
+		return false;
+	}
+
+	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT) {
+		pr_err("bpf record action only supports specifying for tracepoint tracer\n");
+		return false;
+	}
+
+	*subsystem = strtok_r(evsel->name, ":", event_name);
+	if (*subsystem == NULL || event_name == NULL) {
+		pr_err("bpf record action tracepoint name format incorrect\n");
+		return false;
+	}
+
+	return true;
+}
+
+int bpf_perf_record(struct evlist *evlist, int argc, const char **argv)
+{
+	int ret;
+	char *subsystem, *event_name;
+	struct target target = {
+		.system_wide = true,
+	};
+
+	if (!is_bpf_record_supported(evlist, &subsystem, &event_name))
+		goto out_free_event_actions;
+
+	ret = bpf_record_prepare(subsystem, event_name);
+	if (ret)
+		goto out_free_event_actions;
+
+	signal(SIGINT, sig_handler);
+	signal(SIGTERM, sig_handler);
+	signal(SIGCHLD, sig_handler);
+
+	if (argc > 0) {
+		ret = evlist__prepare_workload(evlist, &target, argv, false, NULL);
+		if (ret < 0) {
+			pr_err("evlist workload create failed\n");
+			goto out_destroy_record_action_bpf;
+		}
+	}
+
+	bpf_record_start();
+	evlist__start_workload(evlist);
+
+	while ((ret = perf_buffer__poll(pb, 1000)) >= 0) {
+		if (done == 1)
+			break;
+	}
+
+	bpf_record_stop();
+
+	if (argc > 0) {
+		int exit_status;
+
+		if (!child_finished)
+			kill(evlist->workload.pid, SIGTERM);
+
+		wait(&exit_status);
+	}
+
+out_destroy_record_action_bpf:
+	record_action_bpf__destroy(skel);
+out_free_event_actions:
 	event_actions__free();
 	return 0;
 }
diff --git a/tools/perf/util/record_action.h b/tools/perf/util/record_action.h
index 289be4befa97..6cd578af2ccb 100644
--- a/tools/perf/util/record_action.h
+++ b/tools/perf/util/record_action.h
@@ -7,8 +7,9 @@
 
 #ifdef HAVE_BPF_SKEL
 
-int bpf_perf_record(struct evlist *evlist, int argc, const char **argv);
+int bpf_perf_record_init(void);
 
+int bpf_perf_record(struct evlist *evlist, int argc, const char **argv);
 
 #else /* !HAVE_BPF_SKEL */
 
@@ -19,6 +20,11 @@ static inline int bpf_perf_record(struct evlist *evlist __maybe_unused,
 	return -EOPNOTSUPP;
 }
 
+static inline int bpf_perf_record_init(void)
+{
+	return 0;
+}
+
 #endif /* !HAVE_BPF_SKEL */
 
 #endif /* __PERF_UTIL_RECORD_ACTION_H_ */
-- 
2.25.1


