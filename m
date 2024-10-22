Return-Path: <linux-kernel+bounces-376747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DCD9AB572
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141971C22DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A9B1C304C;
	Tue, 22 Oct 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xcod+9R+"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286811B533C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619328; cv=none; b=rMbv4/p2ZK1+AlFjUrCQS+fCNY7/90+miYhLgD5onS+kPhp+y0jnPo9pduPPvHkqhKlN33Bo+bp0GKNCmJEXrMr1V23nISwkYKiuP1xK7mwrZoBPXpWIWXvgRDrVUGslV/9Kxb/YYQuwMD10IYTH1uagx6cfj8H9nyyTs0p+5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619328; c=relaxed/simple;
	bh=417uBo4RxD5iIsz1gAQRcOS/8uxHLhDUAznn1Qi+IQo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Jxl9X3yjBl+V7+MlJNWJ7fjdDKp2WQijmjWjQVVF0TI40kVMP+Ul5nUFJ2D5hTHiXYxYH6Y7VgwTcXHaHmZEtcnvkBkxLTXpAxpB2sPUHzzjHE5K4I2fVK1TtTH80LvzsKfMm6IJHbRqglpEaRTErW9M5cNTvHwmfg93zRsWKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xcod+9R+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2b9f2c6559so9087835276.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729619326; x=1730224126; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l2urrugrBSiQxSiYS91ZkALkXxr51UCaIToV1WlN+AI=;
        b=Xcod+9R+WfR5YNvPfsFGraXWYYq4TTDVAUX/jqLqMJXOKILDObVIDdwc/4LJIPMb9g
         Nmlw7e+BFSmakrrWRcbC16Ar6grqMtaDHmw+nr0jMpbcfsblBpvQ8E0pYeywcRrE8yiC
         /uX3cilcdN+LlYRXN2glsAE/rAH/rvg13WFkN+SdLNrbk3Zv1a9x+Bi4qT7PPPe0enWb
         n77VbPXQ/eaGHYFLHLzbbjxrexhjxVshwHZOeilzj/LtoVa3zS/tbV5+BL0/H2eJqmUu
         iQiWzi0vYab7MZFB5YsXV+9jPbdJ4mlRR4SdwGZzs+CNNNwN9qEiNkkigaVmH1VcHDFK
         8u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729619326; x=1730224126;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2urrugrBSiQxSiYS91ZkALkXxr51UCaIToV1WlN+AI=;
        b=FKx/Yb34o/NuzwxYAooOZuOyZC13F0MpKv+ZCAKAIty5iOSFbA9OCoX5uY/u5dbk9O
         CLgLnB1DxU89TA8/wdrCAz4nTwtI9eZczbLwyvkXIbuynbWwUhkMZ+w4Q3w8FKZH4x/1
         H1rvAK4C9DmDCqk+kYliF4+vOtMf39dtNVViJJEn2EzustnDR3gLEwpn8XzIFVXuYzBU
         qs5Az7edk7CSFC0fwxcYI6lQ1FKskVjnaJH8TNae/S45r0BmuQjHn2+Nuki8xINgQisM
         fyljbql47P6/Zc4ztLef3zcwtN1xBEl+V7uYm3L5M+61MsQFUE1LXq8KtImzsvY390Ti
         FRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfZi7tOwvxb0Ppp3hq/UHUAnZVmsXv8+57gzisfXUBdUZ+suT3eS4jEKorpHokQ9/52CUzY2+FEzAyyj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6+heQ0Zz0/6UtubXI40PVWv4HZgJZZtx5u1jvhDgb1h8dezx
	Df47JdUkXnZvx1x/SghT4oci5R3R30EuVKuT4SksAeKn5WA1CIaAYmxmYHHg8bDcTfuukHvWR6z
	Le5JXUA==
X-Google-Smtp-Source: AGHT+IHR8RMM2t9en/SeuO+FC4DzJ6cXum+yUMSNXMecIOwf/jZbQtO24eho821spgmLqxOphQ026xsLwdLF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a5b:7c7:0:b0:e25:17cb:352e with SMTP id
 3f1490d57ef6-e2bb1698260mr10493276.9.1729619326004; Tue, 22 Oct 2024 10:48:46
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:48:37 -0700
Message-Id: <20241022174838.449862-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 1/2] perf check: Add sanitizer features
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sanitizer builds can break expectations for test disassembly,
particularly in the annotate test. Add features for the different
sanitizer options seen in the source tree.

An example for an asan build:
```
$ perf version --build-options
perf version 6.12.rc3.g939b0caafd01
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
          dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
              auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
              libaudit: [ OFF ]  # HAVE_LIBAUDIT_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
            libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
             sanitizer: [ on  ]  # HAVE_SANITIZER
     sanitizer_address: [ on  ]  # HAVE_SANITIZER_ADDRESS
        sanitizer_leak: [ on  ]  # HAVE_SANITIZER_LEAK
      sanitizer_memory: [ OFF ]  # HAVE_SANITIZER_MEMORY
      sanitizer_thread: [ OFF ]  # HAVE_SANITIZER_THREAD
   sanitizer_undefined: [ OFF ]  # HAVE_SANITIZER_UNDEFINED
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
v3 split out annotate test check
v2 build fix.
---
 tools/perf/builtin-check.c | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 0b76b6e42b78..c44444008d64 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -9,6 +9,49 @@
 #include <string.h>
 #include <subcmd/parse-options.h>
 
+#if defined(__has_feature)
+#define HAS_COMPILER_FEATURE(feature) __has_feature(feature)
+#else
+#define HAS_COMPILER_FEATURE(feature) 0
+#endif
+
+#if defined(__SANITIZE_ADDRESS__) || defined(ADDRESS_SANITIZER) || \
+	HAS_COMPILER_FEATURE(address_sanitizer)
+#define HAVE_SANITIZER_ADDRESS 1
+#define HAVE_SANITIZER_LEAK 1
+#elif defined(LEAK_SANITIZER) || HAS_COMPILER_FEATURE(leak_sanitizer)
+#define HAVE_SANITIZER_ADDRESS 0
+#define HAVE_SANITIZER_LEAK 1
+#else
+#define HAVE_SANITIZER_ADDRESS 0
+#define HAVE_SANITIZER_LEAK 0
+#endif
+
+#if defined(MEMORY_SANITIZER) || HAS_COMPILER_FEATURE(memory_sanitizer)
+#define HAVE_SANITIZER_MEMORY 1
+#else
+#define HAVE_SANITIZER_MEMORY 0
+#endif
+
+#if defined(THREAD_SANITIZER) || HAS_COMPILER_FEATURE(thread_sanitizer)
+#define HAVE_SANITIZER_THREAD 1
+#else
+#define HAVE_SANITIZER_THREAD 0
+#endif
+
+#if defined(UNDEFINED_SANITIZER) || HAS_COMPILER_FEATURE(undefined_sanitizer)
+#define HAVE_SANITIZER_UNDEFINED 1
+#else
+#define HAVE_SANITIZER_UNDEFINED 0
+#endif
+
+#if HAVE_SANITIZER_ADDRESS || HAVE_SANITIZER_LEAK || HAVE_SANITIZER_MEMORY || \
+	HAVE_SANITIZER_THREAD || HAVE_SANITIZER_UNDEFINED
+#define HAVE_SANITIZER 1
+#else
+#define HAVE_SANITIZER 0
+#endif
+
 static const char * const check_subcommands[] = { "feature", NULL };
 static struct option check_options[] = {
 	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
@@ -47,6 +90,12 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
 	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
 	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
+	FEATURE_STATUS("sanitizer", HAVE_SANITIZER),
+	FEATURE_STATUS("sanitizer_address", HAVE_SANITIZER_ADDRESS),
+	FEATURE_STATUS("sanitizer_leak", HAVE_SANITIZER_LEAK),
+	FEATURE_STATUS("sanitizer_memory", HAVE_SANITIZER_MEMORY),
+	FEATURE_STATUS("sanitizer_thread", HAVE_SANITIZER_THREAD),
+	FEATURE_STATUS("sanitizer_undefined", HAVE_SANITIZER_UNDEFINED),
 	FEATURE_STATUS("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
 	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
 	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
-- 
2.47.0.163.g1226f6d8fa-goog


