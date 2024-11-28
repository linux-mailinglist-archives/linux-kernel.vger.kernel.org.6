Return-Path: <linux-kernel+bounces-424750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A099DB8EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272DE1642EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228581BD007;
	Thu, 28 Nov 2024 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HQiXQNiz"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6621ADFED
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801020; cv=none; b=DyPLPAYGLpzH9ZEavhWMyKHzaYMWp9DO/zf4VakrrRlP585U4vUcikx3P3Iyt6TKPOGjJhKgK/e38lQn0JGSfiWojxMi3JasSLowbfjt+o3WoV0BiC63jbrMy7WszH1pXOrAEJ1K/JIOliSFwCfkUU1IIv6BJ6//VDUyHzSWOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801020; c=relaxed/simple;
	bh=BBDOWJUMQQVfP0zujIc5xIWnrs6gRTLQkCf6I2SIpPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GwGVBMClDhljlB6HoSng5H47NCJqz0cCWRVRuSOX9xkIwwOAljlervSKBMrKiC8gel8RT7BYx1lKbXChEjz6NMYAAxCAnhOpeandLTIc37byN2bUECYadHxeS/jUyuxaJvzIuPmd7iI102P8pwuOFF1ybHqYECNNCRl0gn3vpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HQiXQNiz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21285c1b196so7811555ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732801018; x=1733405818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUD8vqFZbss9TRcSki6gkGZU4MXDWWiXU3SDa6QRj9s=;
        b=HQiXQNiz9WDas3UsP+I/1jTzhW3KK0Q172En91k/gMbcmD+ky1xdDafRqgJVshRMU5
         UQSWDh5DwoKYHp6My2WPaPzS6fqgVcDUTo4haFX9/oGLy8R5ZrPgpjY6IE5ylfWVhFIQ
         eWBDdpiFB2uK8iyX6BHQVgBuV0ZbxXQzpRSFzu3D7OsCwgD2PvxZrliEY+CLF0FM3oNX
         iHQ1hc2z8O5itxY4/ctYWdnbDxaIYokZWxmJvO8q9kzchatFk1IwNAqxgc/0zi/niqwY
         wrD0w7bEhXu817ra+R9KzbBxoC80O/tZuf0mxX1q0Xy+kq3aICOPjklATcoI6Gn6fKqR
         Kq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732801018; x=1733405818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUD8vqFZbss9TRcSki6gkGZU4MXDWWiXU3SDa6QRj9s=;
        b=UBaFkSh8ROs8N/kgjYZ0UIVdSDIw0EamQfk6TnZPJyZiSsnbCX5m6mAdDvTrn0H5Nk
         WztySrIurfBP0fxR7z5CxeyENzKvJ92SMNR0ug8lJjiGwwjABmmInVem3m7VDMQG7IrJ
         88wfU4PMe9CAAeEfuGqCcLsn9lSxO50+zAvLUczYvLooPvLPDvn/xq+aiTeBAJKtAC+W
         TPs0RMyobrzZ5MbikOyV22mIlWtcYtDkPoV+jwFD1wr7VbJb+XLndK+XdOsOcXQX+VDo
         ajfS+004hxLmo3MuF8jmuFQc2WR/+h4PnXjMB8FJX0x0up011YRnKzO7JN8olz0Py2aR
         yZHA==
X-Forwarded-Encrypted: i=1; AJvYcCUG16jMlWV53GKj9PRE5OGROeRZfz2SDld/bILjRVyolcgxIjK02MNAaE2au0mjr7uBlVSxn2Q9eDmNtFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlrYN3o2bOH8qAnG2WAp9C1Oj6hjBlfk8YOS04bhgio/inZoFD
	p+iJmdO6sIjwgqNxNx+6s+P3zosNxi869EUcu5QaPfn9L01vQvEqhixTG+K8v2Q=
X-Gm-Gg: ASbGnctkryHVl7u1Ga5dM5Uns5WTIa0VI65jZuA9DpGBoX7bUDmhZTuGWdZS2R0aM3u
	P5oGz9X8xKOviCZ9sC8/dZVFi2HwH00r/liORq2fnhhMeXHZBTb4NOSUCXOK2mcHHTRVnuw+uFU
	NPXZGemaY7rHI4ks5UCdzaVp7YXvC2tuIsAI4OTTAUkvyH/8vITsRqXhHCpe32sakrFxUkymsZ0
	36LE6XjgK6Rcfpg9WK4xhy3qIZk8zs7CYTGW8c/jwZihM+/Bcvkc8gDhg==
X-Google-Smtp-Source: AGHT+IGf15rlbVH2/JLbhmcoCT0wHnv6QABKy0ywOplhv0zyME4662tjPK99hOetjLPgzweDrC1BCw==
X-Received: by 2002:a17:902:d54e:b0:212:5b57:80ed with SMTP id d9443c01a7336-21501087642mr98852365ad.11.1732801018544;
        Thu, 28 Nov 2024 05:36:58 -0800 (PST)
Received: from ubuntu20.04 ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985632sm12952975ad.206.2024.11.28.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:36:57 -0800 (PST)
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
Subject: [RFC 08/12] perf event action: Add parsing builtin cpu expr support
Date: Thu, 28 Nov 2024 21:35:49 +0800
Message-Id: <20241128133553.823722-9-yangjihong@bytedance.com>
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

Support parsing of builtin cpu expression.

Testcase:
  # perf record -e sched:sched_switch --action 'print("cpu = %d\n", cpu)'
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  cpu = 7
  ...
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/util/bpf_skel/bpf_record_action.h |  1 +
 tools/perf/util/bpf_skel/record_action.bpf.c | 16 ++++++++++++++++
 tools/perf/util/parse-action.c               |  1 +
 tools/perf/util/parse-action.h               |  1 +
 tools/perf/util/parse-action.l               |  1 +
 tools/perf/util/record_action.c              |  7 +++++--
 6 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/bpf_record_action.h b/tools/perf/util/bpf_skel/bpf_record_action.h
index ee4d03848e58..91a307b89f85 100644
--- a/tools/perf/util/bpf_skel/bpf_record_action.h
+++ b/tools/perf/util/bpf_skel/bpf_record_action.h
@@ -7,6 +7,7 @@
 #define __OUTPUT_FORMATS_MAX_NUM 8
 
 enum __output_format_type {
+	__OUTPUT_FORMAT_TYPE_CPU,
 	__OUTPUT_FORMAT_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/bpf_skel/record_action.bpf.c b/tools/perf/util/bpf_skel/record_action.bpf.c
index 424fa8c3e6f1..4b7698554ead 100644
--- a/tools/perf/util/bpf_skel/record_action.bpf.c
+++ b/tools/perf/util/bpf_skel/record_action.bpf.c
@@ -35,10 +35,22 @@ static inline struct __output_data_payload *sample_data_payload(void)
 	return bpf_map_lookup_elem(&sample_data_tmp, &key);
 }
 
+static inline int output_cpu(__u8 *data, int size)
+{
+	__u32 *cpu = (__u32 *)data;
+
+	if (size < sizeof(__u32))
+		return -1;
+
+	*cpu = bpf_get_smp_processor_id();
+	return sizeof(__u32);
+}
+
 SEC("xxx")
 int sample_output(u64 *ctx)
 {
 	struct __output_data_payload *sample;
+	__u8 *data;
 	int i;
 	int total = 0;
 	int ret = 0;
@@ -50,8 +62,12 @@ int sample_output(u64 *ctx)
 	if (!sample)
 		return 0;
 
+	data = sample->__data;
 	for (i = 0; i < output_format_num && i < __OUTPUT_FORMATS_MAX_NUM; i++) {
 		switch (output_formats[i]) {
+		case __OUTPUT_FORMAT_TYPE_CPU:
+			ret = output_cpu(data + total, __OUTPUT_DATA_MAX_SIZE - total);
+			break;
 		default:
 			ret = -1;
 			break;
diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
index e6299de99bc5..2bb32cc16ae7 100644
--- a/tools/perf/util/parse-action.c
+++ b/tools/perf/util/parse-action.c
@@ -12,6 +12,7 @@
  *   - call:
  *     - print
  *   - builtin:
+ *     - cpu
  */
 
 #include <regex.h>
diff --git a/tools/perf/util/parse-action.h b/tools/perf/util/parse-action.h
index b1a33a77c558..ee949ed07111 100644
--- a/tools/perf/util/parse-action.h
+++ b/tools/perf/util/parse-action.h
@@ -27,6 +27,7 @@ enum evtact_expr_call_type {
 };
 
 enum evtact_expr_builtin_type {
+	EVTACT_EXPR_BUILTIN_TYPE_CPU,
 	EVTACT_EXPR_BUILTIN_TYPE_MAX,
 };
 
diff --git a/tools/perf/util/parse-action.l b/tools/perf/util/parse-action.l
index 1c729b7a0248..dab8066a1038 100644
--- a/tools/perf/util/parse-action.l
+++ b/tools/perf/util/parse-action.l
@@ -103,6 +103,7 @@ ident		[_a-zA-Z][_a-zA-Z0-9]*
 {num_hex}	{ return value(16); }
 {space}		{ }
 
+cpu		{ return builtin(EVTACT_EXPR_BUILTIN_TYPE_CPU);  }
 
 print		{ return call(EVTACT_EXPR_CALL_TYPE_PRINT); }
 
diff --git a/tools/perf/util/record_action.c b/tools/perf/util/record_action.c
index 634d6b199bae..15e8b1740e32 100644
--- a/tools/perf/util/record_action.c
+++ b/tools/perf/util/record_action.c
@@ -86,13 +86,16 @@ int bpf_perf_record_init(void)
 }
 
 static int set_expr_builtin_output_format(struct evtact_expr *expr,
-					  u32 opcode, int *offset,
-					  int *format __maybe_unused)
+					  u32 opcode, int *offset, int *format)
 {
 	int size = 0;
 	struct expr_builtin_output_priv *priv = expr->priv;
 
 	switch (opcode) {
+	case EVTACT_EXPR_BUILTIN_TYPE_CPU:
+		*format = __OUTPUT_FORMAT_TYPE_CPU;
+		size = sizeof(u32);
+		break;
 	default:
 		pr_err("set expr builtin output format unknown opcode: %u\n", opcode);
 		return -1;
-- 
2.25.1


