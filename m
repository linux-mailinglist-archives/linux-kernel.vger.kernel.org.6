Return-Path: <linux-kernel+bounces-184336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969D08CA593
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE85281A96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C7810953;
	Tue, 21 May 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jWRcA1W"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657CE57E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253497; cv=none; b=oTmzc+z2AvxGgcCZ8n4fCDXuEkRxh570K6IlXNAQkAyf71lSOcDH6crB+EUbIpukp/xloClAiZO2Ki9O2qI7aDWqaEfbCwp7HelqHkd8T9HDe/ozZ2nZhf9H6OLpXwfAZnlSECjfNReA+D2Xb0NE5uCsRiJFa2yWLUMxHexjyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253497; c=relaxed/simple;
	bh=NLbFF4wpLQqt64smYdSlaSLO+obgcomAoDAU3uN1XUA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BOiMxSCGhyYjrLUfPePtSiu4e0dYBbSM68krI+qIs1alG00RbUTdRjnChpLnwKr8WqWPs8V/oprufsBpwC4LOcH0kTytknv4sPgwDvWOPJFjMyIStO0vZxcWv6W1r+ZPP22BDmArExN1hk/rFo6d0BDnm6KqN6bZ1tM2cxgBlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3jWRcA1W; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61dfa4090c1so192206477b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716253495; x=1716858295; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPhSRWInrCDvmRK05i6c8rW1j8fIs+rTeSWmpel6vAA=;
        b=3jWRcA1WDUWvyXnConPHJx9JHeAoWbqnC9Y1KmocYF+EmNBOfn4SZ39jx047U89Gbj
         4lqK3HRRjSxT4nPUPUuhnVzbIPFYRqd6vTfVfCbNfSQ/8eyPCTug70M+/Aeplbd/ehj2
         qkPR1St11IjbNq01DtTheGcqYPPfac+7G2r8BayVxer7UkCcnpBcyFnjUs9/KzO6DHqu
         k9MKMVbwTMNXTdR9cQEMdHURd2AnWLgA8Ql6duK6oIqm9ERPNJE28+iX3Svs8ShrDU3+
         eW8VU7G3ISy2MZdINDpn7fldcEHc4Cb8m6EBSjJgDr6Ltbm44MZoXcJTYXuPMmIbwJA7
         ja3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253495; x=1716858295;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPhSRWInrCDvmRK05i6c8rW1j8fIs+rTeSWmpel6vAA=;
        b=pOH6yIvU590WD9Vjm8HnhOPe/acnIrpxZIdjeGobnNtKX2At7JiAiEmGcLcFC/Gb3H
         4tIhjI7F0CuDaxBvKp8plcK4XPdXeeAsmBKLOaXnhkvIsqowonpdT/CW46PG5rpHSC5v
         zl6WrsfFjG9kb45y1yvoBU2BIPrrOTpag9okcldUpQWzbH77YgEE9/VlBPDBQ+2heLhu
         8nQ6Heu+YUT9QGwNVwiGchl8OHngTSAFfe7YtBjFCV4B2JBsvlUmecVitiDYld1OHCiZ
         uWF9kutzINuFIMbHY/ou63jiXx72lSAtqvyUDS9F4EDEhqgHu2uq1PArquwccXiWKw8T
         WMLA==
X-Forwarded-Encrypted: i=1; AJvYcCUnKk5TZneM5A1+kZMGwccaIFvsJg5mY1EbJpchh4NRqYlBEOeFDCliM9VO8WeqEOnlayKvxEGtwAAUbDh9DaJXIXqzexwjeB9TW3vd
X-Gm-Message-State: AOJu0Ywi301ppVQ+PlfmFdxVXSSbiQwfcPIF9NeSwcMxwvjiD0VMtrOA
	PK16F1SbGPbra/UgUF5i44o8Kglw9mlZZkBdASbUk1mIm4LZRef4X5eYGeuLA5u+7Egzk5HT7HQ
	v05tb8A==
X-Google-Smtp-Source: AGHT+IHLfOoCMImGs7w7lqZWNgQwsLGxz8Z7RCiXrdTaUAEQA/bv4s4AKRtMBPsJ8ZKc+n6Evf9N3mll9Wf0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a05:690c:b9d:b0:61b:ec24:a014 with SMTP id
 00721157ae682-622afd6d351mr70898027b3.0.1716253495438; Mon, 20 May 2024
 18:04:55 -0700 (PDT)
Date: Mon, 20 May 2024 18:04:38 -0700
In-Reply-To: <20240521010439.321264-1-irogers@google.com>
Message-Id: <20240521010439.321264-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521010439.321264-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v2 2/3] perf bpf filter: Add uid and gid terms
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the BPF filter to use the uid and gid terms determined by the
bpf_get_current_uid_gid BPF helper. For example, the following will
record the cpu-clock event system wide discarding samples that don't
belong to the current user.

$ perf record -e cpu-clock --filter "uid == $(id -u)" -a sleep 0.1

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt     | 2 +-
 tools/perf/util/bpf-filter.c                 | 5 +++++
 tools/perf/util/bpf-filter.l                 | 2 ++
 tools/perf/util/bpf_skel/sample-filter.h     | 3 +++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 4 ++++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6015fdd08fb6..059bc40c5ee1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -200,7 +200,7 @@ OPTIONS
 	  ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
 	  code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
 	  p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
-	  mem_dtlb, mem_blk, mem_hops
+	  mem_dtlb, mem_blk, mem_hops, uid, gid
 
 	The <operator> can be one of:
 	  ==, !=, >, >=, <, <=, &
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index f10148623a8e..04f98b6bb291 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -63,6 +63,11 @@ static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *
 	    (evsel->core.attr.sample_type & (1 << (expr->term - PBF_TERM_SAMPLE_START))))
 		return 0;
 
+	if (expr->term == PBF_TERM_UID || expr->term == PBF_TERM_GID) {
+		/* Not dependent on the sample_type as computed from a BPF helper. */
+		return 0;
+	}
+
 	if (expr->op == PBF_OP_GROUP_BEGIN) {
 		struct perf_bpf_filter_expr *group;
 
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index 62c959813466..2a7c839f3fae 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -95,6 +95,8 @@ mem_lock	{ return sample_part(PBF_TERM_DATA_SRC, 5); }
 mem_dtlb	{ return sample_part(PBF_TERM_DATA_SRC, 6); }
 mem_blk		{ return sample_part(PBF_TERM_DATA_SRC, 7); }
 mem_hops	{ return sample_part(PBF_TERM_DATA_SRC, 8); }
+uid		{ return sample(PBF_TERM_UID); }
+gid		{ return sample(PBF_TERM_GID); }
 
 "=="		{ return operator(PBF_OP_EQ); }
 "!="		{ return operator(PBF_OP_NEQ); }
diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/bpf_skel/sample-filter.h
index 31bfab7e8d6c..dd98bd1a2669 100644
--- a/tools/perf/util/bpf_skel/sample-filter.h
+++ b/tools/perf/util/bpf_skel/sample-filter.h
@@ -49,6 +49,9 @@ enum perf_bpf_filter_term {
 	PBF_TERM_CODE_PAGE_SIZE	= PBF_TERM_SAMPLE_START + 23, /* SAMPLE_CODE_PAGE_SIZE = 1U << 23 */
 	PBF_TERM_WEIGHT_STRUCT	= PBF_TERM_SAMPLE_START + 24, /* SAMPLE_WEIGHT_STRUCT = 1U << 24 */
 	PBF_TERM_SAMPLE_END	= PBF_TERM_WEIGHT_STRUCT,
+	/* Terms computed from BPF helpers. */
+	PBF_TERM_UID,
+	PBF_TERM_GID,
 };
 
 #define BUILD_CHECK_SAMPLE(x)					\
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index 7bcf0c3de292..1fc319ec5e3f 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -121,6 +121,10 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		}
 		/* return the whole word */
 		return kctx->data->data_src.val;
+	case PBF_TERM_UID:
+		return bpf_get_current_uid_gid() & 0xFFFFFFFF;
+	case PBF_TERM_GID:
+		return bpf_get_current_uid_gid() >> 32;
 	case PBF_TERM_NONE:
 	case __PBF_UNUSED_TERM4:
 	case __PBF_UNUSED_TERM5:
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


