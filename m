Return-Path: <linux-kernel+bounces-275261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A64948284
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CD01C20E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D016BE23;
	Mon,  5 Aug 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2QawJHb"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE7166F3E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887074; cv=none; b=ONugfhM3BNcrHGFSVlCZknN5hYWKIabQy2koFpZEoEfWXzfujF+NNORVrDA6CYwu6QXA0S5ei77/AYk/u2iaaDOaU3Bq2KZg9PHIho1CUX9u/xPH28gNbmfLrHpHxkxNGeXWKU7Xwpj5y99UlFLPpMgqF3R2AHUnVeh6wf0nO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887074; c=relaxed/simple;
	bh=1w/sWXNFRS1ROAqvynHYruU4YumUcHdnmP1Zs1x5/BE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=D3PBh876m6dcUxTY/E5Zwrnr2A3s2R2OQHn+kNQKXCrWICyS0yofJoEBFMkZhsG//nSOIp8EeDHtcz1dfsvP0zz/nXSsWL49pNR7VlVTf7DUVtur60+NFnscQl58oYck5LfdrCeW5vjk9pxx+74J38bddM9WptymKUoAvvul8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2QawJHb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64c3f08ca52so199902447b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887072; x=1723491872; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iJXWmNBT0oaBhJJEJy7hYTlF13tlRK8nid7RNuMSvR8=;
        b=k2QawJHbzZ3g0OiqIW7Z6zjphoQ//1LJirEJ6KQWqdKFRKrYbRLVFCtS7sYRjaF9Nq
         iTkqC3yan03hXqPfCvottbpjRaAAoy1dG3EGSumBAfxIOUCAGWpZnPFsG+jl9+CRzH/r
         H2INf4+HJP6coBNTxmR7eQGq+lQ5xxAh6KUBebslEE9P47u+3x4S1g1DySfv1zclfMtA
         kboz8lbm8jskTWy1NjO52h0sMuMvPGBTMj7gQ7LR0HPL3NPohYWTqioJ/mJ08ly9ZZYa
         5thPN4YyOfzVdb0APy413KLrCTKjqwzYcFA0XQAzjiIEIei1bYT+ojhnf/z8l6msbT47
         o/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887072; x=1723491872;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJXWmNBT0oaBhJJEJy7hYTlF13tlRK8nid7RNuMSvR8=;
        b=uIHKyDax+zVAWFq8vXFkub4zRIH2h7jlGH/mKg2YWfR43mp6YB2eord1YKsKNme1Wp
         +5Su42j5NuVk0y9QMytncH7bPn/JMrxUzN0ReUOpyLVHk0LBvkCG9dxqm89dKpjsiKsb
         PYSdPbpJwRzV34i0nata1abPu+OYm/KQQVZgxFP/5B2jOa3wT2o8o7J/J3R//+mEpqWx
         2Pe9SrcnMNQ+YkyfekhcT+0tFseL4TuUcLuFl572rgDdYloTHJEsZhpphOGhFaVUrCpz
         Gku0UIBi4ri0HdkSgt6lnkNHjFsTKN9Dtblnzk+e5xVgvuzpUvrp82ZSOYqzOs221LIL
         py1A==
X-Forwarded-Encrypted: i=1; AJvYcCWJkBL9k2rumE3OCXc7GqrJNVd+8qN4hZIdConfmYQGyApPA8hXepo4U6lUYBemJfIWiYjFQ0B620DeeSxiYpe6r8hVbyvGwnBKg+Z4
X-Gm-Message-State: AOJu0Ywvtqt/BOwoC+gbs4Q15z22ufvOyI/WET6FOyWFLVl5/Fwj0L2T
	a6EDpE/wgcrJZ0uy8czxxum/Q8KIvmyPd7n00/3Ix9XnptrJtF2O2XNWQv7S/djBbIq0W3Qhvcq
	dLgtkyg==
X-Google-Smtp-Source: AGHT+IHJSqpiy7EVr1MrO3N5kEdZB8cHENC2V7KXM1QSWWQkT2wB+WeZ6roGFkSYmicbn8frWZfPR7R4IIZC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1f65:8dc8:61d0:4b08])
 (user=irogers job=sendgmr) by 2002:a05:690c:288:b0:669:f244:2ae5 with SMTP id
 00721157ae682-689601a6da3mr4014357b3.3.1722887072239; Mon, 05 Aug 2024
 12:44:32 -0700 (PDT)
Date: Mon,  5 Aug 2024 12:44:20 -0700
Message-Id: <20240805194424.597244-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 1/5] perf test: Add build test for JEVENTS_ARCH=all
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	Charles Ci-Jyun Wu <dminus@andestech.com>, Locus Wei-Han Chen <locus84@andestech.com>, 
	Atish Patra <atishp@rivosinc.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	vincent.chen@sifive.com, greentime.hu@sifive.com, 
	Eric Lin <eric.lin@sifive.com>
Content-Type: text/plain; charset="UTF-8"

Building with JEVENTS_ARCH=all builds all CPU types and allows things
like assertions to check the validity of the input json.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index a1f8adf85367..8a9edf758f10 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -70,6 +70,7 @@ make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_nondistro      := BUILD_NONDISTRO=1
 make_extra_tests    := EXTRA_TESTS=1
+make_jevents_all    := JEVENTS_ARCH=all
 make_no_bpf_skel    := BUILD_BPF_SKEL=0
 make_gen_vmlinux_h  := GEN_VMLINUX_H=1
 make_no_libperl     := NO_LIBPERL=1
@@ -140,6 +141,7 @@ run += make_python_perf_so
 run += make_debug
 run += make_nondistro
 run += make_extra_tests
+run += make_jevents_all
 run += make_no_bpf_skel
 run += make_gen_vmlinux_h
 run += make_no_libperl
-- 
2.46.0.rc2.264.g509ed76dc8-goog


