Return-Path: <linux-kernel+bounces-424741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219FC9DB8DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7258D2828CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315F31AA1D9;
	Thu, 28 Nov 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EFV91fgj"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D51A29A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800983; cv=none; b=OFBD9ugqdU1IXObr2s6LleFtSWcjEd1l3mWo1YhhFfi5Jv5t31GZCTPNdmobo80lMkibcKBw9tLlhdeza+MVFC7lWdrf9DXlG7SAgG22Gt0gtNIp7uPiCEZGiFDaQRxKWkitxMuj5Q5PUxIazPxsui6g8KuFZSCBETcgbgmUsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800983; c=relaxed/simple;
	bh=nDvvicLumv7EtNvS5GruBIHrJOOqtlAQ1xL9L19APP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kx9JQhrK08KbRkWQRrxp/1hSpbQtmnp1MrFxx+Pv3DH3QR/pQiLQotAhXoIWieXaAhZeaXINhMlWtQjB5MHBBh/rpDDWpK122CnW8E/1/D2M0ruT3Gqmgm0OY+LGFJvmjWS//p1aHcslwJMY6OZRCC923At/bMuyQy1UbvBCJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EFV91fgj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21290973bcbso7708815ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732800979; x=1733405779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcU2ut98rpKpyOZJT3GpoD2fKQDnhCpCbslumGtWhKQ=;
        b=EFV91fgjVaf6GoiZA4KPwfYm3PQcD1fakdpWnCshh0xL44I7gcxkNSfCo1Y7x8b0rB
         ua5qyMnUK6jwll5fNw5pka+J7M8jbVoGk1TvkNW07IGPoMyutTYUUZfZ/PSOysrk2IxM
         5p5mggz/vAgGSCsQNgPCn1/jZItsGdDtdcYwJQQs98uMwm8s3ZbHtDERRfeqquisbzV/
         SLPZBEf55DMeBb5U7RlMZJHeiPcNFVkA+gjfUaTFfcGtUbkeIWy5mQrBfQy40F0SM8d8
         Cvay/2Jjdrwsx5i+/VdqdouHme0BPX5AQ5eF5yOE3yGjJglz/g6N55CuBSWG4eDMjyAP
         I8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800979; x=1733405779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcU2ut98rpKpyOZJT3GpoD2fKQDnhCpCbslumGtWhKQ=;
        b=ZNEis4v9QJFhKnOlgpVLn/AkJyKXC5KymT1Cm5Uqv3fJPYi1DKnxtjc/i5NhwTnsYu
         7vyNzkpXuPEwKIhJVKZqzWK0LiAF+bcdv2d5T/HGOL1n8wSrz8JmWcpqsm2fxkVwTE6Q
         cb9qdk0esH2kZ9BZVyr34mAPHgJcRubq1+vEDo/vMKFlWC8LEGDvr0g74q/MD9io9vLd
         z0QVyo/Hb0s6rqMYcMiYeYcBEtXmBIBnKucPPkLo7D4+Kch3lvzsCKhEnMLTZgLNnhOM
         fcxS+HpJHJXEJlU/sLRTEJC129xl5FgvjwzlpvquahoSVOm8evnYfGvquul3lUbjk4sY
         kzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvOSvMwWgYRHDC07Y0eZwRcWapOONj5+O++Mzm9BTAuUFwVXzGCcSXd1/3iKc6mlcI/6XVUw0OZAMnYdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BQ9TL2mIAX+9diTw/U/ab1oxtoEIkZjPXlZFxCAxN7n2MOSB
	3RmeA/tn/XD8JvKkZqQpJ2f6kRhiyUnVfx+Ow6AYxt0rZJYPr3xYTeRii9oXiQ0=
X-Gm-Gg: ASbGncvm3WZCiX2k9IbhRmi8gQkDUwKKPoVt97E3yXFNTAbxDVqJuh5DmtTCyDpCWT+
	9jypZz36lnq41+tXnrc4hJueJlMLaUMyhIVcQxRDLqPGEExa0wr8ZC4bnWFhMHD59r3GDZMBw9K
	vJQ9ggGZlbeAaiQClJAqYEMGzxUQ+LjC4VpnteymJAuCWh36QZ3wLt3RVmYCu2Wo09zmds527O0
	kfCR16/Zb0dAX/2UkX3vfWlFJtHxw8LjGYUZAQJkNxlnseVG/J7jWA30A==
X-Google-Smtp-Source: AGHT+IGXKXpqj6vJl7YkVSjkabWL+8zZNuS1RTCfG2jC3Ds6bcGG/wUkZQPL9fTcY/v0XBWMriNiDQ==
X-Received: by 2002:a17:902:e5c7:b0:212:5814:8916 with SMTP id d9443c01a7336-21501b5a330mr69771825ad.45.1732800979052;
        Thu, 28 Nov 2024 05:36:19 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:18 -0800 (PST)
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
Subject: [RFC 01/12] perf record: Add event action support
Date: Thu, 28 Nov 2024 21:35:42 +0800
Message-Id: <20241128133553.823722-2-yangjihong@bytedance.com>
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

In perf-record, when an event is triggered, default behavior is to
save sample data to perf.data. Sometimes, we may just want to do
some lightweight actions, such as printing a log.

Based on this requirement, add the --action option to the event to
specify the behavior when the event occurs.

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/Documentation/perf-record.txt |   8 +
 tools/perf/builtin-record.c              |  31 +++
 tools/perf/util/Build                    |  18 ++
 tools/perf/util/parse-action.c           | 230 +++++++++++++++++++++++
 tools/perf/util/parse-action.h           |  75 ++++++++
 tools/perf/util/parse-action.l           |  40 ++++
 tools/perf/util/parse-action.y           |  82 ++++++++
 tools/perf/util/record_action.c          |  15 ++
 tools/perf/util/record_action.h          |  24 +++
 9 files changed, 523 insertions(+)
 create mode 100644 tools/perf/util/parse-action.c
 create mode 100644 tools/perf/util/parse-action.h
 create mode 100644 tools/perf/util/parse-action.l
 create mode 100644 tools/perf/util/parse-action.y
 create mode 100644 tools/perf/util/record_action.c
 create mode 100644 tools/perf/util/record_action.h

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 242223240a08..d0d9e0f69f3d 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -833,6 +833,14 @@ filtered through the mask provided by -C option.
 	Prepare BPF filter to be used by regular users.  The action should be
 	either "pin" or "unpin".  The filter can be used after it's pinned.
 
+--action=<action>::
+	Actions are the programs that run when the sampling event is triggered.
+	The action is a list of expressions separated by semicolons (;).
+	The sample data is saved by bpf prog attached by the event.
+	The call currently supported is print(); some commonly used built-in special
+	variables are also supported
+	For example:
+	  # perf record -e sched:sched_switch --action 'print("[%llu]comm=%s, cpu=%d, pid=%d, tid=%d\n", time, comm, cpu, pid, tid)' true
 
 include::intel-hybrid.txt[]
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f83252472921..108d98706873 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -51,6 +51,10 @@
 #include "util/clockid.h"
 #include "util/off_cpu.h"
 #include "util/bpf-filter.h"
+#ifdef HAVE_BPF_SKEL
+#include "util/parse-action.h"
+#include "util/record_action.h"
+#endif
 #include "asm/bug.h"
 #include "perf.h"
 #include "cputopo.h"
@@ -182,6 +186,7 @@ struct record {
 	struct pollfd_index_map	*index_map;
 	size_t			index_map_sz;
 	size_t			index_map_cnt;
+	bool			custom_action;
 };
 
 static volatile int done;
@@ -3316,6 +3321,23 @@ static int parse_record_synth_option(const struct option *opt,
 	return 0;
 }
 
+#ifdef HAVE_BPF_SKEL
+static int parse_record_action_option(const struct option *opt,
+				      const char *str,
+				      int unset __maybe_unused)
+{
+	int ret;
+	struct record *rec = (struct record *)opt->value;
+
+	ret = parse_record_action(rec->evlist, str);
+	if (ret)
+		return ret;
+
+	rec->custom_action = true;
+	return 0;
+}
+#endif
+
 /*
  * XXX Ideally would be local to cmd_record() and passed to a record__new
  * because we need to have access to it in record__exit, that is called
@@ -3564,6 +3586,9 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
 	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
 		   "BPF filter action"),
+#ifdef HAVE_BPF_SKEL
+	OPT_CALLBACK(0, "action", &record, "action", "event action", parse_record_action_option),
+#endif
 	OPT_END()
 };
 
@@ -4001,6 +4026,12 @@ int cmd_record(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+#ifdef HAVE_BPF_SKEL
+	/* Currently, event actions only supported using bpf prog. */
+	if (rec->custom_action)
+		return bpf_perf_record(rec->evlist, argc, argv);
+#endif
+
 	err = symbol__validate_sym_arguments();
 	if (err)
 		return err;
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c06d2ee9024c..db4c4cabc5f8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -249,6 +249,12 @@ perf-util-$(CONFIG_LIBBPF) += bpf-utils.o
 
 perf-util-$(CONFIG_LIBPFM4) += pfm.o
 
+# perf record event action
+perf-util-$(CONFIG_PERF_BPF_SKEL) += parse-action.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += parse-action-flex.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += parse-action-bison.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += record_action.o
+
 CFLAGS_config.o   += -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 
 # avoid compiler warnings in 32-bit mode
@@ -294,6 +300,16 @@ $(OUTPUT)util/bpf-filter-bison.c $(OUTPUT)util/bpf-filter-bison.h: util/bpf-filt
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/bpf-filter-bison.c -p perf_bpf_filter_
 
+$(OUTPUT)util/parse-action-flex.c $(OUTPUT)util/parse-action-flex.h: util/parse-action.l $(OUTPUT)util/parse-action-bison.c util/parse-action.h
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-action-flex.c \
+		--header-file=$(OUTPUT)util/parse-action-flex.h $(PARSER_DEBUG_FLEX) $<
+
+$(OUTPUT)util/parse-action.c $(OUTPUT)util/parse-action-bison.h: util/parse-action.y util/parse-action.h
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
+		-o $(OUTPUT)util/parse-action-bison.c -p parse_action_
+
 FLEX_VERSION := $(shell $(FLEX) --version | cut -d' ' -f2)
 
 FLEX_GE_260 := $(call version-ge3,$(FLEX_VERSION),2.6.0)
@@ -345,11 +361,13 @@ CFLAGS_parse-events-flex.o  += $(flex_flags) -Wno-unused-label
 CFLAGS_pmu-flex.o           += $(flex_flags)
 CFLAGS_expr-flex.o          += $(flex_flags)
 CFLAGS_bpf-filter-flex.o    += $(flex_flags)
+CFLAGS_parse-action-flex.o  += $(flex_flags)
 
 CFLAGS_parse-events-bison.o += $(bison_flags)
 CFLAGS_pmu-bison.o          += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 CFLAGS_bpf-filter-bison.o   += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
+CFLAGS_parse-action-bison.o += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 
 $(OUTPUT)util/parse-events.o: $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-bison.c
 $(OUTPUT)util/pmu.o: $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-bison.c
diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
new file mode 100644
index 000000000000..01c8c7fdea59
--- /dev/null
+++ b/tools/perf/util/parse-action.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Generic actions for sampling events
+ * Actions are the programs that run when the sampling event is triggered.
+ * The action is a list of expressions separated by semicolons (;).
+ * Each action is an expression, added to actions_head node as list_head node.
+ */
+
+#include "util/debug.h"
+#include "util/parse-action.h"
+#include "util/parse-action-flex.h"
+#include "util/parse-action-bison.h"
+
+static struct list_head actions_head = LIST_HEAD_INIT(actions_head);
+
+int event_actions__for_each_expr(int (*func)(struct evtact_expr *, void *arg),
+				 void *arg, bool recursive)
+{
+	int ret;
+	struct evtact_expr *expr, *opnd;
+
+	if (list_empty(&actions_head))
+		return (*func)(NULL, arg);
+
+	list_for_each_entry(expr, &actions_head, list) {
+		ret = (*func)(expr, arg);
+		if (ret)
+			return ret;
+
+		if (recursive && !list_empty(&expr->opnds)) {
+			list_for_each_entry(opnd, &expr->opnds, list) {
+				ret = (*func)(opnd, arg);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+int event_actions__for_each_expr_safe(int (*func)(struct evtact_expr *, void *arg),
+				      void *arg, bool recursive)
+{
+	int ret;
+	struct evtact_expr *expr, *tmp;
+	struct evtact_expr *opnd, *opnd_tmp;
+
+	if (list_empty(&actions_head))
+		return (*func)(NULL, arg);
+
+	list_for_each_entry_safe(expr, tmp, &actions_head, list) {
+		ret = (*func)(expr, arg);
+		if (ret)
+			return ret;
+
+		if (recursive && !list_empty(&expr->opnds)) {
+			list_for_each_entry_safe(opnd, opnd_tmp, &expr->opnds, list) {
+				ret = (*func)(opnd, arg);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int parse_action_option(const char *str)
+{
+	int ret;
+	YY_BUFFER_STATE buffer;
+
+	buffer = parse_action__scan_string(str);
+	ret = parse_action_parse(&actions_head);
+
+	parse_action__flush_buffer(buffer);
+	parse_action__delete_buffer(buffer);
+	parse_action_lex_destroy();
+
+	return ret;
+}
+
+int parse_record_action(struct evlist *evlist, const char *str)
+{
+	int ret;
+
+	if (evlist == NULL) {
+		pr_err("--action option should follow a tracer option\n");
+		return -1;
+	}
+
+	ret = parse_action_option(str);
+	if (ret) {
+		event_actions__free();
+		pr_err("parse action option failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int do_action_free(struct evtact_expr *action, void *data __maybe_unused)
+{
+	if (action == NULL)
+		return 0;
+
+	list_del(&action->list);
+	parse_action_expr__free(action);
+	return 0;
+}
+
+void event_actions__free(void)
+{
+	(void)event_actions__for_each_expr_safe(do_action_free, NULL, false);
+}
+
+static struct evtact_expr_class *expr_class_list[EVTACT_EXPR_TYPE_MAX] = {
+};
+
+int parse_action_expr__set_class(enum evtact_expr_type type,
+				 struct evtact_expr_class *class)
+{
+	if (type >= EVTACT_EXPR_TYPE_MAX) {
+		pr_err("action expr set class ops type invalid\n");
+		return -EINVAL;
+	}
+
+	if (expr_class_list[type] != NULL) {
+		pr_err("action expr set class ops type already exists\n");
+		return -EEXIST;
+	}
+
+	expr_class_list[type] = class;
+	return 0;
+}
+
+static int expr_set_type(struct evtact_expr *expr)
+{
+	u64 id;
+	int ret;
+	u32 type, opcode;
+	struct evtact_expr_class *class;
+
+	id = expr->id;
+	evtact_expr_id_decode(id, &type, &opcode);
+
+	if (type >= EVTACT_EXPR_TYPE_MAX) {
+		pr_err("parse_action_expr type invalid: %u\n", type);
+		return -EINVAL;
+	}
+
+	class = expr_class_list[type];
+	if (class == NULL) {
+		pr_err("parse_action_expr class not supported: %u\n", type);
+		return -ENOTSUP;
+	}
+
+	if (class->set_ops != NULL) {
+		ret = class->set_ops(expr, opcode);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct evtact_expr *parse_action_expr__new(u64 id, struct list_head *opnds,
+					   void *data, int size)
+{
+	int ret;
+	struct evtact_expr *expr;
+
+	expr = malloc(sizeof(*expr));
+	if (expr == NULL) {
+		pr_err("parse_action_expr malloc failed\n");
+		goto out_free_opnds;
+	}
+	expr->id = id;
+
+	if (opnds != NULL)
+		list_add_tail(&expr->opnds, opnds);
+	else
+		INIT_LIST_HEAD(&expr->opnds);
+
+	ret = expr_set_type(expr);
+	if (ret)
+		goto out_list_del_opnds;
+
+	if (expr->ops->new != NULL) {
+		ret = expr->ops->new(expr, data, size);
+		if (ret)
+			goto out_free_expr;
+	}
+
+	return expr;
+
+out_free_expr:
+	free(expr);
+out_list_del_opnds:
+	list_del(&expr->opnds);
+out_free_opnds:
+	parse_action_expr__free_opnds(opnds);
+
+	return NULL;
+}
+
+void parse_action_expr__free_opnds(struct list_head *opnds)
+{
+	struct evtact_expr *opnd, *tmp;
+
+	if (opnds != NULL && !list_empty(opnds)) {
+		list_for_each_entry_safe(opnd, tmp, opnds, list) {
+			list_del(&opnd->list);
+			parse_action_expr__free(opnd);
+		}
+	}
+}
+
+void parse_action_expr__free(struct evtact_expr *expr)
+{
+	if (expr == NULL)
+		return;
+
+	if (expr->ops->free != NULL)
+		expr->ops->free(expr);
+
+	parse_action_expr__free_opnds(&expr->opnds);
+	free(expr);
+}
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
new file mode 100644
index 000000000000..71a0a166959e
--- /dev/null
+++ b/tools/perf/util/parse-action.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_UTIL_PARSE_ACTION_H_
+#define __PERF_UTIL_PARSE_ACTION_H_
+
+#include <linux/types.h>
+
+#include <subcmd/parse-options.h>
+
+#include "evlist.h"
+
+enum evtact_expr_type {
+	EVTACT_EXPR_TYPE_MAX,
+};
+
+struct evtact_expr;
+struct evtact_expr_ops {
+	int (*new)(struct evtact_expr *expr, void *data, int size);
+	int (*eval)(struct evtact_expr *expr,
+		    void *in, int in_size, void **out, int *out_size);
+	void (*free)(struct evtact_expr *expr);
+};
+
+struct evtact_expr_class {
+	int (*set_ops)(struct evtact_expr *expr, u32 opcode);
+};
+
+struct evtact_expr {
+	struct list_head list;
+	u64 id;
+	struct evtact_expr_ops *ops;
+	struct list_head opnds;
+	void *priv;
+};
+
+/*
+ * The expr id contains two fileds:
+ * |--------------|----------------|
+ * |     type     |     opcode     |
+ * |--------------|----------------|
+ *      32-bit           32-bit
+ */
+#define EVTACT_EXPR_ID_TYPE_BITS_SHIFT 32
+static inline u64 evtact_expr_id_encode(u32 type, u32 opcode)
+{
+	return (u64)type << EVTACT_EXPR_ID_TYPE_BITS_SHIFT | opcode;
+}
+
+static inline void evtact_expr_id_decode(u64 id, u32 *type, u32 *opcode)
+{
+	if (type != NULL)
+		*type = id >> EVTACT_EXPR_ID_TYPE_BITS_SHIFT;
+
+	if (opcode != NULL)
+		*opcode = id & GENMASK(EVTACT_EXPR_ID_TYPE_BITS_SHIFT, 0);
+}
+
+int parse_record_action(struct evlist *evlist, const char *str);
+void event_actions__free(void);
+
+int event_actions__for_each_expr(int (*func)(struct evtact_expr *, void *arg),
+				 void *arg, bool recursive);
+
+int event_actions__for_each_expr_safe(int (*func)(struct evtact_expr *, void *arg),
+				      void *arg, bool recursive);
+
+struct evtact_expr *parse_action_expr__new(u64 id, struct list_head *opnds,
+					   void *data, int size);
+
+void parse_action_expr__free_opnds(struct list_head *opnds);
+void parse_action_expr__free(struct evtact_expr *expr);
+
+int parse_action_expr__set_class(enum evtact_expr_type type,
+				 struct evtact_expr_class *ops);
+
+#endif /* __PERF_UTIL_PARSE_ACTION_H_ */
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
new file mode 100644
index 000000000000..3cb72de50372
--- /dev/null
+++ b/tools/perf/util/parse-action.l
@@ -0,0 +1,40 @@
+%option prefix="parse_action_"
+%option noyywrap
+%option stack
+
+%{
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "util/debug.h"
+
+#include "parse-action.h"
+#include "parse-action-bison.h"
+
+%}
+
+space		[ \t]
+ident		[_a-zA-Z][_a-zA-Z0-9]*
+
+%%
+
+{space}		{ }
+
+";"		{ return SEMI; }
+
+{ident}		{
+			parse_action_lval.str = strdup(parse_action_text);
+			if (parse_action_lval.str == NULL) {
+				pr_err("parse_action malloc ident string failed\n");
+				return ERROR;
+			}
+			return IDENT;
+		}
+.		{
+			pr_err("invalid character: '%s'\n", parse_action_text);
+			return ERROR;
+		}
+
+%%
diff --git a/tools/perf/util/parse-action.y b/tools/perf/util/parse-action.y
new file mode 100644
index 000000000000..fade9d093d4a
--- /dev/null
+++ b/tools/perf/util/parse-action.y
@@ -0,0 +1,82 @@
+%parse-param {struct list_head *actions_head}
+%define parse.error verbose
+
+%{
+
+#ifndef NDEBUG
+#define YYDEBUG 1
+#endif
+
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <linux/compiler.h>
+#include <linux/list.h>
+
+#include "util/debug.h"
+#include "util/parse-action.h"
+
+int parse_action_lex(void);
+
+static void parse_action_error(struct list_head *expr __maybe_unused,
+			       char const *msg)
+{
+	pr_err("parse_action: %s\n", msg);
+}
+
+%}
+
+%union
+{
+	char *str;
+	struct evtact_expr *expr;
+	struct list_head *list;
+}
+
+%token IDENT ERROR
+%token SEMI
+%type <expr> action_term expr_term
+%destructor { parse_action_expr__free($$); } <expr>
+%type <str> IDENT
+
+%%
+
+actions:
+action_term SEMI actions
+{
+	list_add(&$1->list, actions_head);
+}
+|
+action_term SEMI
+{
+	list_add(&$1->list, actions_head);
+}
+|
+action_term
+{
+	list_add(&$1->list, actions_head);
+}
+
+action_term:
+expr_term
+{
+	$$ = $1;
+}
+
+expr_term:
+IDENT
+{
+	$$ = NULL;
+	pr_err("unsupported ident: '%s'\n", $1);
+	free($1);
+	YYERROR;
+}
+|
+ERROR
+{
+	$$ = NULL;
+	YYERROR;
+}
+
+%%
diff --git a/tools/perf/util/record_action.c b/tools/perf/util/record_action.c
new file mode 100644
index 000000000000..44789e0d4678
--- /dev/null
+++ b/tools/perf/util/record_action.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Read event sample data and execute the specified actions.
+ */
+
+#include "util/debug.h"
+#include "util/parse-action.h"
+#include "util/record_action.h"
+
+int bpf_perf_record(struct evlist *evlist __maybe_unused,
+		    int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	event_actions__free();
+	return 0;
+}
diff --git a/tools/perf/util/record_action.h b/tools/perf/util/record_action.h
new file mode 100644
index 000000000000..289be4befa97
--- /dev/null
+++ b/tools/perf/util/record_action.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_UTIL_RECORD_ACTION_H_
+#define __PERF_UTIL_RECORD_ACTION_H_
+
+#include <errno.h>
+#include "evlist.h"
+
+#ifdef HAVE_BPF_SKEL
+
+int bpf_perf_record(struct evlist *evlist, int argc, const char **argv);
+
+
+#else /* !HAVE_BPF_SKEL */
+
+static inline int bpf_perf_record(struct evlist *evlist __maybe_unused,
+				  int argc __maybe_unused,
+				  const char **argv __maybe_unused)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* !HAVE_BPF_SKEL */
+
+#endif /* __PERF_UTIL_RECORD_ACTION_H_ */
-- 
2.25.1


