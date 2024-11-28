Return-Path: <linux-kernel+bounces-424747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4E39DB8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3ABEB24CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45919CD01;
	Thu, 28 Nov 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EEyIEgsN"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234341AA1F3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801003; cv=none; b=jn0vGUO8I1jrPasng/FtNpNViYWtyTHQClxPW19OzC/Ux1n3+gtB8Vn/7D0jMhpoAEn0+WrzAwJb9ysInUHEm7MLoUHXBzrmia4ew4hCMlEprX1FFtUPD2G0wC3fZuhQ7GxQxF3Mdz6WtqeFKWNVOJAy1pCaJkRzHy1LxOKI/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801003; c=relaxed/simple;
	bh=iQPmTqPMgE6CGRqj3c3+Z0ssTDESghTFmM14erJ5bzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+lf2qoIH3EtRUFmr/XIKPRITQX6FaWG8OUBnnudmtzatg7GVKwe7jQBv8AoEe8W402ESQzKR4rkExYhbcAHxm0mvfFcuPinIo4JQt2Vkw/HoDhMFzRT3InqLvkEIN4fw1Wkgr2DDgBHBZ2Nai2vhVKcoS02NVHiUWiwWjNsA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EEyIEgsN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724f41d520cso559794b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732801001; x=1733405801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug7s3apMrIYGbjn2T08D5A19MS2gdifOXUiskaMTdCU=;
        b=EEyIEgsNWoy1AvJemyzu998JPt9rGQ7cNwcsV3Dyl/NwXx9Do3zD+RVD/SQbAKwKr8
         0Sq/lnGz9HooMDjhTSwxBJT8Gq0ne2WyLk9uamtKOwSG52DH4u01SxDjPrBOQlpXMVZV
         sduAshMINnui/FLQrDlRj4UIOuEkFAC/WMmO9anb3uyxmsWl09uud0XNveOu4O0ufT0j
         m/lZsOn0QpSyewZUQ7hI09QmpMIOL9oZja23KKRgVaqwvxMPgRjmAf+9dSpxfYYxrUKs
         LkRtY9hfeV8VFZin8cyXLXm3kUBP9K9HyzQgMFD3cYqTCUMkSeCRnDwZswJ/Mx5f5NoK
         AAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801001; x=1733405801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug7s3apMrIYGbjn2T08D5A19MS2gdifOXUiskaMTdCU=;
        b=o0S2g4unf+PvZZCcspQQGk2OuT+hKZscf1i7LyViRjsrDFd9GQYEEwElQpFOxs2pIr
         bWtPyZ7bY9HTGt7/gC3S5n8NsvA4P4792B2MbKz5gDdvZwKeLtwSMrAVCxeNNKMUw2UI
         SJipfS+wzH/KENFdpRywxQZWzu9rXBEv0rWtPSlyy41sGQMmx8DQVnqOk682Iwp+gEw6
         9To6YHmXkbGP5yBZazX0YUEh460NqQ8UHm31JULon5shpkuKabWBTQsoeAfyxWH21ccA
         NjSqjfGVxEFxWXQhCkVJ1/UeGTm38LR51s50Dqnho4v33bsGqvsO7vneQo6eI3JBbm0P
         XYCw==
X-Forwarded-Encrypted: i=1; AJvYcCXc4Gg3hpmnxV4RZizD9WqqQCXNnTNANAOo8a59QzqlErbDjeDwjbPi93CZvVLZZvtTB6IF8XvFxbFosek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2I/Vr9HhgAFWY0uGAWJ2G+7QtRVSzsOZI2I2EgTNS4BvWJMDd
	AMZRl/QNLfOOQp7AM/HqEdWMGCtEKVk3TlfT0JFfYBwzn3tZOlHwykNJeqYk+V8=
X-Gm-Gg: ASbGncutULajMZFKmfLuXnGEucsmRi0igESGTaheD6YuuKcbr06y78U0fEHHvbNZUNh
	KUCF43oCgC//JgXuD6syf7/uoFfOql1AcST/q7j3legSL40PblcUSrLdU+l1kdHcA6baHVYb7Fl
	BpWGoppHveif1E8r5s8QX3OhSqu29XZO8nk2hyru5xl4pJ5LRKOf0kS7sT5hkBGUS0yIAyDCZ3s
	urhXSAqfnwZtk0d9JuJFN9cc9yWS5x0AW5u1kiKnjaBsv80eFMRhPnANA==
X-Google-Smtp-Source: AGHT+IEP3FPHTpJbDgEXCPECoTzgQwWMYfxD2So6kaGKpGJn6BnqrIL/OjhQuLz8v4pXQAubpuPN7Q==
X-Received: by 2002:a17:902:d48a:b0:20c:9821:6998 with SMTP id d9443c01a7336-21501086e3bmr82419485ad.10.1732801001570;
        Thu, 28 Nov 2024 05:36:41 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:40 -0800 (PST)
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
Subject: [RFC 05/12] perf event action: Add parsing call expr support
Date: Thu, 28 Nov 2024 21:35:46 +0800
Message-Id: <20241128133553.823722-6-yangjihong@bytedance.com>
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

Add support for parsing function call expression, the format is similar to
C language function call, with parameters specified after function name,
inside the parentheses and separated with a comma.

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/parse-action.c | 25 +++++++++++++++
 tools/perf/util/parse-action.h |  5 +++
 tools/perf/util/parse-action.l |  3 ++
 tools/perf/util/parse-action.y | 56 +++++++++++++++++++++++++++++++---
 4 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 7e5ca889d5b9..40e7c8aad7be 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -9,6 +9,7 @@
  *   - constant:
  *     - integer
  *     - string
+ *   - call:
  */
 
 #include "util/debug.h"
@@ -232,8 +233,32 @@ static struct evtact_expr_class expr_const = {
 	.set_ops = expr_const_set_ops,
 };
 
+static struct evtact_expr_ops *expr_call_ops_list[EVTACT_EXPR_CALL_TYPE_MAX] = {
+};
+
+static int expr_call_set_ops(struct evtact_expr *expr, u32 opcode)
+{
+	if (opcode >= EVTACT_EXPR_CALL_TYPE_MAX) {
+		pr_err("expr_call opcode invalid: %u\n", opcode);
+		return -EINVAL;
+	}
+
+	if (expr_call_ops_list[opcode] == NULL) {
+		pr_err("expr_call opcode not supported: %u\n", opcode);
+		return -ENOTSUP;
+	}
+
+	expr->ops = expr_call_ops_list[opcode];
+	return 0;
+}
+
+static struct evtact_expr_class expr_call = {
+	.set_ops = expr_call_set_ops,
+};
+
 static struct evtact_expr_class *expr_class_list[EVTACT_EXPR_TYPE_MAX] = {
 	[EVTACT_EXPR_TYPE_CONST]   = &expr_const,
+	[EVTACT_EXPR_TYPE_CALL]    = &expr_call,
 };
 
 int parse_action_expr__set_class(enum evtact_expr_type type,
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index ec422f8a05a7..30c2fd6e81d0 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -10,6 +10,7 @@
 
 enum evtact_expr_type {
 	EVTACT_EXPR_TYPE_CONST,
+	EVTACT_EXPR_TYPE_CALL,
 	EVTACT_EXPR_TYPE_MAX,
 };
 
@@ -19,6 +20,10 @@ enum evtact_expr_const_type {
 	EVTACT_EXPR_CONST_TYPE_MAX,
 };
 
+enum evtact_expr_call_type {
+	EVTACT_EXPR_CALL_TYPE_MAX,
+};
+
 struct evtact_expr;
 struct evtact_expr_ops {
 	int (*new)(struct evtact_expr *expr, void *data, int size);
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index f76240276b61..189f73dfc3b1 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -92,6 +92,9 @@ ident		[_a-zA-Z][_a-zA-Z0-9]*
 {space}		{ }
 
 ";"		{ return SEMI; }
+"("		{ return LP;   }
+")"		{ return RP;   }
+","		{ return COM;  }
 
 \"		{
 			int ret;
diff --git a/tools/perf/util/parse-action.y b/tools/perf/util/parse-action.y
index 4922b2d94aee..1b162c694218 100644
--- a/tools/perf/util/parse-action.y
+++ b/tools/perf/util/parse-action.y
@@ -35,15 +35,18 @@ static void parse_action_error(struct list_head *expr __maybe_unused,
 	struct evtact_expr *expr;
 	struct list_head *list;
 	unsigned long long num;
+	u32 opcode;
 }
 
-%token IDENT ERROR NUMBER STRING
-%token SEMI
-%type <expr> action_term expr_term
+%token IDENT ERROR NUMBER STRING CALL
+%token SEMI LP RP COM
+%type <expr> action_term expr_term expr_call_term
 %destructor { parse_action_expr__free($$); } <expr>
 %type <str> IDENT
 %type <num> NUMBER
 %type <str> STRING
+%type <opcode> CALL
+%type <list> opnds
 
 %%
 
@@ -64,11 +67,56 @@ action_term
 }
 
 action_term:
-expr_term
+expr_call_term
 {
 	$$ = $1;
 }
 
+expr_call_term:
+CALL LP RP
+{
+	$$ = parse_action_expr__new(evtact_expr_id_encode(EVTACT_EXPR_TYPE_CALL, $1), NULL, NULL, 0);
+	if ($$ == NULL)
+		YYERROR;
+}
+|
+CALL LP opnds RP
+{
+	$$ = parse_action_expr__new(evtact_expr_id_encode(EVTACT_EXPR_TYPE_CALL, $1), $3, NULL, 0);
+	if ($$ == NULL)
+		YYERROR;
+}
+|
+IDENT LP RP
+{
+	$$ = NULL;
+	pr_err("unknown function '%s()'\n", $1);
+	free($1);
+	YYERROR;
+}
+|
+IDENT LP opnds RP
+{
+	$$ = NULL;
+	pr_err("unknown function '%s()'\n", $1);
+	parse_action_expr__free_opnds($3);
+	free($1);
+	YYERROR;
+}
+
+opnds:
+opnds COM expr_term
+{
+	list_add_tail(&$3->list, $1);
+	$$ = $1;
+}
+|
+expr_term
+{
+	INIT_LIST_HEAD(&$1->list);
+	$$ = &$1->list;
+}
+
 expr_term:
 NUMBER
 {
-- 
2.25.1


