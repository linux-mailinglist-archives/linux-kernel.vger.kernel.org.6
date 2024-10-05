Return-Path: <linux-kernel+bounces-352117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89B0991A55
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA23B1C21988
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1125E189507;
	Sat,  5 Oct 2024 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sn9te8xZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BE188937
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158210; cv=none; b=Tobfeo5dMfYIrCyKSgt2nw4KUL5wNqjwQbFsBMuG64m+OVSRj5B2kl8Ei/MscXUK+qlcHGmcF5cgYKIKbub3tHYzLhwALv31y+r9ShzQLBkoBC8n0PLIFgl9k1/BPZYPAt+kFvJ0Lk4MpE/HdwRDtvX30RqgpWeAC64aW0dil9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158210; c=relaxed/simple;
	bh=KPXFlEwWt/UGl7qiXtTbrMb7WVi1MkyXBOPi+pW+OQY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=btAQs8N8EUkbI+iz6Ayx47Y8QE7zPYHKisRABKiCohyXCB7OL0hUYknYZG/pShxC68orXemxBjtUK89HzueihGHRHasvrxiOVxTviPrzbTn2HdDGM8JDMEU7QFg1rWb1WAXf6EEME1gzRydANJE155mgNhceqow9ovYQa5DUXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sn9te8xZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e230808455so40287537b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 12:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158207; x=1728763007; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4nfym4aHRABgeK2o4kYgh7MQauDKY/5wnwGVKCXL/U=;
        b=sn9te8xZlw/6cDKLa+pSkj8uevcvGoeIgSFMNJWIJZ6O9ehrnHlCyCf9s1msd+ZTKu
         8WlrLji7Kb8iic+5luj58swwTRHWYXkZhEqocZNrW9rtNhM7Hp9KSsrhZSuxY7r0MXqE
         Y4BnxDlu5U86QgVis/3EWrZf4QEVa++8CZLPtw99Mz41KA7WcsSy5hLx1XN0D+APNIVi
         fGzqom7k8bDId2NGMWHxOP4uvqSvgjAL008FFGvJyL79JPXET8FY/lueBWPbJ0XBv3QT
         TFIJuhJZUuayDWcS91adRd5PTWySUYZiHir0f9x4AG7186/66U3+czEjkfA74Y561MNb
         1bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158207; x=1728763007;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4nfym4aHRABgeK2o4kYgh7MQauDKY/5wnwGVKCXL/U=;
        b=TAyFX6rpJhWSqSiq9TDIOTo921rQ9b20YcqrtZqYOVSXL6BtlHOcmLZbpEqOSDc7TT
         bXPFSR7vQhaHauJeEtJ+ZMCOdm+N2F/55tt+nUlH3kQ/PhYHh1Z1/0RrCW5xQbiPskZ9
         olsXkF4qUCDfRG8/Gbop+zEEZDBld8/V0JknqPlDwMa6zofLkTffZlok3Bz6Ifr3SOt2
         kigXlzxx24IdXE6aLwKx7gjHOWHOTn0Wj4/BMTYj3tTLJKHeK1+c1M9ZVrJ9kLo8IAbb
         eC65xREkOILqhqX1/9Rs/TcO0QkCyVs2bz4iPFo3DhQZnKHTIH6ZkAomguWMdS5o5//F
         2fUw==
X-Forwarded-Encrypted: i=1; AJvYcCWmhj03x7MFgKHvRCpbCLN99G0da/xDC2xQb++Fe6WMaTzdxLnKgv68tGadakH6Pg6jRzsc1QDIhReaPXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfQVBLLHa6avtu/GRI9Qct6leu+QJY1G+Y6M3lLF+hFrJ8pIoc
	8kisqpumP9NUq9PAk/MQ/EmI9wWHF9FT4ygN/WotGumZLShGeiEBsflB+otGnOaWFCF8YezTn9F
	z5KvTyg==
X-Google-Smtp-Source: AGHT+IGwFa7Hd++IIPfhdwWa5aoWpwfc5FH4Qfd2Wi5L5CDLWvwjg7FsZhYuik7PKcUvMabRjFi+c5q2jqfZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a81:93c7:0:b0:6b1:8b74:978a with SMTP id
 00721157ae682-6e2c728f13bmr1856917b3.4.1728158207463; Sat, 05 Oct 2024
 12:56:47 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:32 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 22/31] perf loongarch: Remove dwarf-regs.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The file just provides the function get_arch_regstr, however, if in
the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case
the function can never be called. So remove as dead code. Tidy up the
EM_NONE cases for loongarch in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/loongarch/util/Build        |  1 -
 tools/perf/arch/loongarch/util/dwarf-regs.c | 34 ---------------------
 tools/perf/util/dwarf-regs.c                |  4 +--
 tools/perf/util/include/dwarf-regs.h        |  3 +-
 4 files changed, 4 insertions(+), 38 deletions(-)
 delete mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c

diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index 06ff95394921..0aa31986ecb5 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,7 +1,6 @@
 perf-util-y += header.o
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
diff --git a/tools/perf/arch/loongarch/util/dwarf-regs.c b/tools/perf/arch/loongarch/util/dwarf-regs.c
deleted file mode 100644
index bee08fdcf2fd..000000000000
--- a/tools/perf/arch/loongarch/util/dwarf-regs.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
- */
-
-#include <stdio.h>
-#include <errno.h> /* for EINVAL */
-#include <string.h> /* for strcmp */
-#include <dwarf-regs.h>
-
-struct pt_regs_dwarfnum {
-	const char *name;
-	unsigned int dwarfnum;
-};
-
-static struct pt_regs_dwarfnum loongarch_gpr_table[] = {
-	{"%r0", 0}, {"%r1", 1}, {"%r2", 2}, {"%r3", 3},
-	{"%r4", 4}, {"%r5", 5}, {"%r6", 6}, {"%r7", 7},
-	{"%r8", 8}, {"%r9", 9}, {"%r10", 10}, {"%r11", 11},
-	{"%r12", 12}, {"%r13", 13}, {"%r14", 14}, {"%r15", 15},
-	{"%r16", 16}, {"%r17", 17}, {"%r18", 18}, {"%r19", 19},
-	{"%r20", 20}, {"%r21", 21}, {"%r22", 22}, {"%r23", 23},
-	{"%r24", 24}, {"%r25", 25}, {"%r26", 26}, {"%r27", 27},
-	{"%r28", 28}, {"%r29", 29}, {"%r30", 30}, {"%r31", 31},
-	{NULL, 0}
-};
-
-const char *get_arch_regstr(unsigned int n)
-{
-	n %= 32;
-	return loongarch_gpr_table[n].name;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 9a76f83af62c..efc41d0fbee9 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,7 +32,7 @@
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
-    || EM_HOST == EM_CSKY
+    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -40,7 +40,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 #endif
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
-    && EM_HOST != EM_CSKY
+    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index b72d9d308ce4..4f205a58db89 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -79,7 +79,8 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
-#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__)
+#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
+    && !defined(__loongarch__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


