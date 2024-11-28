Return-Path: <linux-kernel+bounces-424746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BE29DB8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB99D165097
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171191B6CED;
	Thu, 28 Nov 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gKDL0JUj"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB481B392C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800998; cv=none; b=FyINmdCEtRM3rV4iIeixv/L5EX33bsSk+rRgJgZu7aP7e4kXQkw0WkRujx0znyPVipvldT7g9RDwtuj+b9TTK1ViT5vUb9jhO0auU6RhIHFQjJBp21PcVkZX02t/z995VWKn7lXU/Ie5FrKDVixTzgrKIg7vG0K57Y0aF8WT+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800998; c=relaxed/simple;
	bh=UF8YKzahIh+PwN3AwO6NZv3Y89s7Ox98ADCP/IHgSL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FeHsaU9VVNn6FrraVhdTGcGZ/9SvfgXzy17ZOZf/D1GkDmPc34Ttt9jRET0rVHKuDzShRMONz1wTPbbV/Y2kC+grdBd5yyNZl5FNz7iukSWMtQTCq+yBlsFZIV2IvyLquzrWlyDU8RXN3xo+QL4B6pMQRjw12uocCPUF0VTIFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gKDL0JUj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2124a86f4cbso6682255ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732800996; x=1733405796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ0MaacFYTQJTLNs968qndbUwHA1XnYLHyx9b8Hlr5k=;
        b=gKDL0JUjy/aOnvu/4+hmQ1AjfQYQF448GRvFWaiLl+hQEY3i8363TBEbg9xyl46Kl3
         GuzsdTtzwKQmhjgpxScG8FEoNTBMpfjmvx9jR8O5nA3vIWxP7GyNpy3f4TmwtFhjHf8r
         gDmNAtDpYY6s5/x7ZFLP0rhIbBNgptiETQ+qntWZtl/gFCTNTmscAzQ177qNU+lppDOD
         GXlA2j05Yu+6mLOr/4E/3DVUkjTBOpEjPSt5FULeRkxojpa3p+axI4b7J4rtrq3J88nI
         FIk/1h4UnUKtYyt2674VVSLFEbBh5JWNBR9AVWMbKveqcXxEHe1KB5xqjMeI44ruorJk
         Aj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800996; x=1733405796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ0MaacFYTQJTLNs968qndbUwHA1XnYLHyx9b8Hlr5k=;
        b=ZyOQ1yWYdS9a5oHFahixSXxYFYSxic3vaMX47lGDRPv7zhxRYIA5ySpJmYlb+WfCQ8
         3Zg3VsL9yEOilYRUDwiMaaGwDsEJlXDjic+Rx30HuzQ68RdE17G6B3aQSaTBhQPjFdiq
         zOrs9OtrQpDBX7qCIjGQF/pGEjIoZQcmUMe9J9KmkRnUnas0pbhh1vFWbqAFgjtU/wM5
         BenQ1LJFi4h1bxzZ0iifNSJXpfAqDRob9X1cx3H8suVO8ru1lfOfS5z59IgkMufPzEJy
         TWQi2sR5vmurALfoMOwdGzPVhQ7TCkhE5pLXkzV8+U8FqrFeiRvqiHXBc4UL/CV/IhWY
         KFgw==
X-Forwarded-Encrypted: i=1; AJvYcCUEX/k+vet8TvzU+uxAFOZ0wbLWSl5pFcZsZYj2++dITcehrZcrneAyD6d4Ina70H4smPDdX08pJEJFZYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4kxEt7jTobaK1W5GWMSs6UQWlZtNvFuiGOJ2vTefvvSXLyOx
	kU8QwrRDCRusZlxW4xcKVHRUwNvxxNLxwiT/MIkC/SZEn9G+LOUQkEBTytzNXuE=
X-Gm-Gg: ASbGncsABCfJB4y6qw/9e6mGSM7ZuYip37pm5bx1liWjQEO6y9HKx0Ewxl8VqMOI6ZS
	AIhghn7cprwCsxqipRzKae3+M7Uo9LV6RirEvT9/coZeMxQi5URAR0eBJTCYf+qatjnpWS2BASP
	BqIUOL9itRDlW6094JMlrOLot0+TUhQppyghMzz10Gjc2tL2+bxZjzJ0GjBkOlLtEWR/0+b9I7/
	W2i/OyFALMuVQ36g/aqlYexLEjNE6rCfWkzaXb5uK0XM0lyNhfFiBQVTw==
X-Google-Smtp-Source: AGHT+IEjDUsjrDGDGc5fQqIO+T+FruzKH27Usz7tqWm1DjvNhvcAFC7JN1TUKGdNBDbfARzHkP8zwQ==
X-Received: by 2002:a17:902:c944:b0:20c:bffe:e1e5 with SMTP id d9443c01a7336-2150109a094mr79756385ad.19.1732800996021;
        Thu, 28 Nov 2024 05:36:36 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:35 -0800 (PST)
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
Subject: [RFC 04/12] perf event action: Add parsing const string expr support
Date: Thu, 28 Nov 2024 21:35:45 +0800
Message-Id: <20241128133553.823722-5-yangjihong@bytedance.com>
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

Support parsing of constant string expression.

Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/parse-action.c |  39 ++++++++++++
 tools/perf/util/parse-action.h |   1 +
 tools/perf/util/parse-action.l | 108 +++++++++++++++++++++++++++++++++
 tools/perf/util/parse-action.y |  10 ++-
 4 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index 3b10cf9f99b3..7e5ca889d5b9 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -8,6 +8,7 @@
  * Supported expressions:
  *   - constant:
  *     - integer
+ *     - string
  */
 
 #include "util/debug.h"
@@ -169,8 +170,46 @@ static struct evtact_expr_ops expr_const_int_ops = {
 	.eval = expr_const_int_eval,
 };
 
+static int expr_const_str_new(struct evtact_expr *expr,
+			      void *data, int size __maybe_unused)
+{
+	if (data == NULL) {
+		pr_err("exper const string is NULL\n");
+		return -EINVAL;
+	}
+
+	expr->priv = data;
+	INIT_LIST_HEAD(&expr->opnds);
+	return 0;
+}
+
+static void expr_const_str_free(struct evtact_expr *expr)
+{
+	zfree(&expr->priv);
+}
+
+static int expr_const_str_eval(struct evtact_expr *expr,
+			       void *in __maybe_unused, int in_size __maybe_unused,
+			       void **out, int *out_size)
+{
+	if (out != NULL)
+		*out = expr->priv;
+
+	if (out_size != NULL)
+		*out_size = strlen(expr->priv);
+
+	return 0;
+}
+
+static struct evtact_expr_ops expr_const_str_ops = {
+	.new  = expr_const_str_new,
+	.free = expr_const_str_free,
+	.eval = expr_const_str_eval,
+};
+
 static struct evtact_expr_ops *expr_const_ops_list[EVTACT_EXPR_CONST_TYPE_MAX] = {
 	[EVTACT_EXPR_CONST_TYPE_INT] = &expr_const_int_ops,
+	[EVTACT_EXPR_CONST_TYPE_STR] = &expr_const_str_ops,
 };
 
 static int expr_const_set_ops(struct evtact_expr *expr, u32 opcode)
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index ac81278c590e..ec422f8a05a7 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -15,6 +15,7 @@ enum evtact_expr_type {
 
 enum evtact_expr_const_type {
 	EVTACT_EXPR_CONST_TYPE_INT,
+	EVTACT_EXPR_CONST_TYPE_STR,
 	EVTACT_EXPR_CONST_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index 9237399a11ac..f76240276b61 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -28,6 +28,54 @@ static int value(int base)
 	return NUMBER;
 }
 
+static char *str_buf;
+static unsigned int str_buf_size = 64;
+static int str_begin(void)
+{
+	if (str_buf == NULL) {
+		str_buf = malloc(str_buf_size);
+		if (str_buf == NULL) {
+			pr_err("parse_action malloc string buffer failed\n");
+			return ERROR;
+		}
+	}
+
+	str_buf[0] = '\0';
+	return 0;
+}
+
+static int str_write(const char *s)
+{
+	char *new_buf;
+
+	if (strlen(str_buf) + strlen(s) >= str_buf_size) {
+		str_buf_size = strlen(str_buf) + strlen(s) + 1;
+		new_buf = realloc(str_buf, str_buf_size);
+		if (new_buf == NULL) {
+			free(str_buf);
+			str_buf = NULL;
+			pr_err("parse_action realloc string buffer failed\n");
+			return ERROR;
+                } else {
+			str_buf = new_buf;
+		}
+	}
+
+	strcat(str_buf, s);
+	return 0;
+}
+
+static int str_end(void)
+{
+	parse_action_lval.str = strdup(str_buf);
+	if (parse_action_lval.str == NULL) {
+		pr_err("parse_action strdup string buffer failed\n");
+		return ERROR;
+	}
+
+	return STRING;
+}
+
 %}
 
 num_dec		[0-9]+
@@ -35,6 +83,8 @@ num_hex		0[xX][0-9a-fA-F]+
 space		[ \t]
 ident		[_a-zA-Z][_a-zA-Z0-9]*
 
+%x STR_BEGIN
+
 %%
 
 {num_dec}	{ return value(10); }
@@ -43,6 +93,64 @@ ident		[_a-zA-Z][_a-zA-Z0-9]*
 
 ";"		{ return SEMI; }
 
+\"		{
+			int ret;
+			yy_push_state(STR_BEGIN);
+			ret = str_begin();
+			if (ret) {
+				yy_pop_state();
+				return ret;
+			}
+		}
+<STR_BEGIN>{
+  \"		{
+			yy_pop_state();
+			return str_end();
+		}
+  [^\\\n\"]+	{
+			int ret;
+			ret = str_write((const char *)yytext);
+			if (ret) {
+				yy_pop_state();
+				return ret;
+			}
+		}
+  \\n		{
+			int ret;
+			ret = str_write("\n");
+			if (ret) {
+				yy_pop_state();
+				return ret;
+                        }
+                }
+  \\t           {
+			int ret;
+			ret = str_write("\t");
+			if (ret) {
+				yy_pop_state();
+				return ret;
+			}
+		}
+  \\\\		{
+			int ret;
+			ret = str_write("\\");
+			if (ret) {
+				yy_pop_state();
+				return ret;
+			}
+		}
+  \\.		{
+			yy_pop_state();
+			pr_err("parse_action invalid escape character: '%s'\n", parse_action_text);
+			return ERROR;
+		}
+  .		{
+			yy_pop_state();
+			pr_err("parse_action invalid character: '%s'\n", parse_action_text);
+			return ERROR;
+		}
+}
+
 {ident}		{
 			parse_action_lval.str = strdup(parse_action_text);
 			if (parse_action_lval.str == NULL) {
diff --git a/tools/perf/util/parse-action.y b/tools/perf/util/parse-action.y
index 51e77e54f157..4922b2d94aee 100644
--- a/tools/perf/util/parse-action.y
+++ b/tools/perf/util/parse-action.y
@@ -37,12 +37,13 @@ static void parse_action_error(struct list_head *expr __maybe_unused,
 	unsigned long long num;
 }
 
-%token IDENT ERROR NUMBER
+%token IDENT ERROR NUMBER STRING
 %token SEMI
 %type <expr> action_term expr_term
 %destructor { parse_action_expr__free($$); } <expr>
 %type <str> IDENT
 %type <num> NUMBER
+%type <str> STRING
 
 %%
 
@@ -76,6 +77,13 @@ NUMBER
 		YYERROR;
 }
 |
+STRING
+{
+	$$ = parse_action_expr__new(expr_id(CONST, STR), NULL, (void *)$1, strlen($1));
+	if ($$ == NULL)
+		YYERROR;
+}
+|
 IDENT
 {
 	$$ = NULL;
-- 
2.25.1


