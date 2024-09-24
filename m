Return-Path: <linux-kernel+bounces-337357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66E98490D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F80B21281
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262341AC43A;
	Tue, 24 Sep 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6Yhu30p"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DB1ABEDA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193892; cv=none; b=UR+j6LHSSufK06UwAafmc52JW0EFiZyw//bqMjzQ4PdsARruaercYEYnGhzY1w1O7z77CJMiClVB1//a+ylIpZ5Y1cOB/0g2FbGn0ilfqxqXF8z5Y0NL8JbrcNWpVWHptZ+JzrT0AyTjc/TCkTAYHbOj1KR26jUiMo+8qKlNOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193892; c=relaxed/simple;
	bh=PLU4I0lDGlMLrK+xY01KoXdu2LXpXiaMNRUqveJo6Ps=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TE3G67jWJVCFuLLUoHuaJw6933uKKGJhm5Bten2JXmxLzAaxyC2TtPkgYyabMyyzfFfOPKewEnWoH3YKqFheZpPMtrpObq0TBjeUgDFJv74RLc6JXHivpagHoOCYLSKQCaWwEmq+7Geyv92DqDEtAuxMlVA482OMdXKtGiJ07d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U6Yhu30p; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1ce98dcafaso7797007276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193890; x=1727798690; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqorPOT5WI1jcIIEa3LclCQTORysR8OKk4M5Adg397w=;
        b=U6Yhu30pwKb4v9t4W8eYvXC1ZabOU0YjRaKTk+q3rtEFJxXBDuhbQ/PXZOd6x3kxEM
         Pq0y18ggAwJNq1Qbv96g2RIrJeepsrb5q4TIk4pbvYuS2knob5Ncd0yQY1ynR0Cx9VdU
         qWdJK77d9kUOQf2kyeVnjM8ox97MR+CVuiTfgelcRCBWcJr1c0eOqNofVc8U2UIRbano
         7qpq8dMAKc9vZ2wpTjni3M4K7aiZc2LjmShJHtoAkFxsTJROteLtdOZSbf/dHjG41oAf
         k+aYoZHAaz8Fdg75hNZ4TUxzjxPu2Zq5tesruUEM0cYS+rgvoAubqUyR8PMk9Jfy6+st
         VxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193890; x=1727798690;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqorPOT5WI1jcIIEa3LclCQTORysR8OKk4M5Adg397w=;
        b=omkD+LaXIpaJXKiHDPYBPGEA2hYRL1Y1AgEES2dPki0nb89aToCXjrVwyrGbzf+ha4
         jfh/0Uh0PlkyGIMAH8h10yJ2fhixZHncwH1PBVDj5UVqD9PtK7fbWBTRLDwsW3f6T/lQ
         id3NsdZGWvPLrrcKg5FIrCYfLiY96YnNeecZmJeNrWV0Q4zGFpwZ7PpcIE8rK7FX7mvz
         1kcKtbh7wH10cG6xy6TpULctoUfCYw4JfkUkyEfPU1//5WT58D1ovJjP+qzY2fNIhYU0
         eir6Ri+F04Cag3MA3snb8/JMLZcUENACzbhfUn1XrNcBD5ckxbRfOHcNGs3FgiHbssTw
         SWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGidjm6XqcfLzuP3HJIXN7+ACAJZ36PTQuui/uJekAeRT2uMyK20UaHDKzrDBgOPIsCvd7GzKin0esR9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8PU/hjW1/Y1TSSfq8JQYbjR/uarB6Mu6StV2ytLcmbKwHKGu
	jBJVi0Jek4qQ4lLNY8NaXVy9g0JoIhBMzUxFavAm2vnvD0QiU9XweRA5pA7CpP4iPyqonbpTZab
	UrfuGmg==
X-Google-Smtp-Source: AGHT+IG2Q/xLed4ZQt4yjlTA+ew21JIESrkVnLSdxire2/fqHlOBZff+LPagYrBCe3WX48WZ914CwoJdSIVp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a25:8045:0:b0:e20:2b5b:c6e6 with SMTP id
 3f1490d57ef6-e2250cc2238mr30434276.9.1727193889646; Tue, 24 Sep 2024 09:04:49
 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:10 -0700
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Message-Id: <20240924160418.1391100-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 03/11] perf build: Rename test-dwarf to test-libdw
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
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Be more intention revealing that the dwarf test is actually testing
for libdw support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                     |  6 +++---
 tools/build/feature/Makefile                     | 16 ++++++++--------
 tools/build/feature/test-all.c                   |  6 +++---
 .../build/feature/{test-dwarf.c => test-libdw.c} |  0
 tools/perf/Makefile.config                       |  6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)
 rename tools/build/feature/{test-dwarf.c => test-libdw.c} (100%)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ffd117135094..6025810cc346 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -30,7 +30,7 @@ endef
 #
 FEATURE_TESTS_BASIC :=                  \
         backtrace                       \
-        dwarf                           \
+        libdw                           \
         dwarf_getlocations              \
         dwarf_getcfi                    \
         eventfd                         \
@@ -120,7 +120,7 @@ ifeq ($(FEATURE_TESTS),all)
 endif
 
 FEATURE_DISPLAY ?=              \
-         dwarf                  \
+         libdw                  \
          dwarf_getlocations     \
          glibc                  \
          libbfd                 \
@@ -233,7 +233,7 @@ endef
 
 #
 # generates feature value assignment for name, like:
-#   $(call feature_assign,dwarf) == feature-dwarf=1
+#   $(call feature_assign,libdw) == feature-libdw=1
 #
 feature_assign = feature-$(1)=$(feature-$(1))
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 5938cf799dc6..bece326ac93b 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -5,7 +5,7 @@ FILES=                                          \
          test-all.bin                           \
          test-backtrace.bin                     \
          test-bionic.bin                        \
-         test-dwarf.bin                         \
+         test-libdw.bin                         \
          test-dwarf_getlocations.bin            \
          test-dwarf_getcfi.bin                  \
          test-eventfd.bin                       \
@@ -168,9 +168,9 @@ $(OUTPUT)test-libopencsd.bin:
 	$(BUILD) # -lopencsd_c_api -lopencsd provided by
 		 # $(FEATURE_CHECK_LDFLAGS-libopencsd)
 
-DWARFLIBS := -ldw
+DWLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
+  DWLIBS += -lelf -lz -llzma -lbz2 -lzstd
 
   LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
@@ -179,18 +179,18 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   # Elfutils merged libebl.a into libdw.a starting from version 0.177,
   # Link libebl.a only if libdw is older than this version.
   ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
-    DWARFLIBS += -lebl
+    DWLIBS += -lebl
   endif
 endif
 
-$(OUTPUT)test-dwarf.bin:
-	$(BUILD) $(DWARFLIBS)
+$(OUTPUT)test-libdw.bin:
+	$(BUILD) $(DWLIBS)
 
 $(OUTPUT)test-dwarf_getlocations.bin:
-	$(BUILD) $(DWARFLIBS)
+	$(BUILD) $(DWLIBS)
 
 $(OUTPUT)test-dwarf_getcfi.bin:
-	$(BUILD) $(DWARFLIBS)
+	$(BUILD) $(DWLIBS)
 
 $(OUTPUT)test-libelf-getphdrnum.bin:
 	$(BUILD) -lelf
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 6f4bf386a3b5..d60e072b6eca 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -38,8 +38,8 @@
 # include "test-glibc.c"
 #undef main
 
-#define main main_test_dwarf
-# include "test-dwarf.c"
+#define main main_test_libdw
+# include "test-libdw.c"
 #undef main
 
 #define main main_test_dwarf_getlocations
@@ -187,7 +187,7 @@ int main(int argc, char *argv[])
 	main_test_get_current_dir_name();
 	main_test_gettid();
 	main_test_glibc();
-	main_test_dwarf();
+	main_test_libdw();
 	main_test_dwarf_getlocations();
 	main_test_eventfd();
 	main_test_libelf_getphdrnum();
diff --git a/tools/build/feature/test-dwarf.c b/tools/build/feature/test-libdw.c
similarity index 100%
rename from tools/build/feature/test-dwarf.c
rename to tools/build/feature/test-libdw.c
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 182e14e39cd5..c8e157cc0c5e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -159,8 +159,8 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
     DWARFLIBS += -lebl
   endif
 endif
-FEATURE_CHECK_CFLAGS-dwarf := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-dwarf := $(LIBDW_LDFLAGS) $(DWARFLIBS)
+FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
@@ -470,7 +470,7 @@ else
         $(warning No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR)
       endif
     endif
-    ifneq ($(feature-dwarf), 1)
+    ifneq ($(feature-libdw), 1)
       ifndef NO_LIBDW
         $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
         NO_LIBDW := 1
-- 
2.46.0.792.g87dc391469-goog


