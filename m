Return-Path: <linux-kernel+bounces-352100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18365991A31
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB004283D91
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA06173346;
	Sat,  5 Oct 2024 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ALQdxAQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9DE171E70
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158172; cv=none; b=j82qVI/+Vxkwho5SzKe1jp9mTJ+LeXmo5OgZjd6paU7U81tddmep9DHmYmVPYB/4wnJYRWoZPx+VXl7ogWNeQLXVor/m3sg8DcTr5uE4rkPqBdHGta2/3fbznJni/PaVYcLKnbStFtmtnFM7q3MlbRYazttU5qKH8IduVYV2UFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158172; c=relaxed/simple;
	bh=/emFBd27SIpNkbWFY8CWoalwr1F9D3lqF9EGRJG1AJ0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=j/YlgI4lJ237F7j38hhu4NxMSLMOP5b9wRGXG2hyD+SOTQjZzI4NqGW48JWYgQRedIJdyw+9Iv+b4QngV5W4odtSF7lRPq1nhS9Ve4SN6Ucln1x+ODl3UIWDuzws+NOr4y7lxRTG5x0IKhEpCBEsy04EQb/1c58FemByoQztwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ALQdxAQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2364f45a4so42687197b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158170; x=1728762970; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHCrs5RpxQhB9H4vvM4MCWIjboq5jYaTqx9B2UPb0W4=;
        b=2ALQdxAQYFlhRqObFteK3CW5/y3WpjyNmG+hF2jw5DCNVFIS/6HzQ8qYuk/Q7TesLA
         MQ+4/EclnBoHCeDtsg5E3JRO0723SNdpAtEyP8OhNGMvC7J2p1GPSrvRtTwwRziZOdW8
         j0BsalTV73iur8EWpG2TEK/1EhBL+aqlv5yslBKmF7b0FiOMlqmwi0Kgg2deCViZcDXt
         3GAZgYD2ZdYGxFvhNfI1zcQgWYBH+1HVf0eac8d1s3U3IMUIaa/dsDrqEr8WNQHcunr+
         heloiKEnOFz6eKkiDdhmWP/cdGf+tvaC0gCQA3udOwEsy7XL9+Fm4ovrHcebIuHX8E4v
         PqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158170; x=1728762970;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHCrs5RpxQhB9H4vvM4MCWIjboq5jYaTqx9B2UPb0W4=;
        b=UPVUecX8otUVIJf8oJ8MNBpF3FBGj4ZDxd0Zo9JgVNzAksdY5f2uZ8n92PZzXC4osY
         56+SObuirD41ELgd084OQDwIsYPSQq9V8b6TEHFfOusnf534eJjCD9ArSK12PXd61V8I
         GXUHxzG0Nn3mAfE+mvW/kJ+INxUNXrXNXE9ehm1rT15NivbgILh8lutFk92PobjzByGi
         KEbN+ibFZic2gT1++4fdKH1YZE6VY6T9MIcwMZ+NbAkF8y3Uhw/cC0seR12f01dBlZfm
         zm4doyDQeLfD/VQA6IX91fsGCl3DZJd4A5s3Bz0yeIpGNeqpeQnzTY6gEniH2vAq0vGy
         sk8w==
X-Forwarded-Encrypted: i=1; AJvYcCVIUPVCQvAmO7v53mYzkbmlxXGSMMjVXHanRMhIWfoXpDeetLXfswUY4InaNAKfUxhX8XoCU0/0GrzJzFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vXQBOZ5vMS9n3e6P4orwbOW0XNZnoJ5TQIkBIZVXvZmt5kcc
	kHIG5f4aa8wdnUE+TY3irIyzvyceNfCGrMpp/I9cdYaOGTXR6aI6TEUNfbwj1+pzJehdI4aA1Bq
	i38HMNw==
X-Google-Smtp-Source: AGHT+IEhekuG7RUOfycyDG27OWqeWfPbamRuutC2Jb29fG/nD/NbI3iivYWnvTJB6Fr1oIlRUAUSSAQRUKkv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a05:690c:6e13:b0:6e2:120b:be57 with SMTP
 id 00721157ae682-6e2c7292042mr1661887b3.5.1728158169620; Sat, 05 Oct 2024
 12:56:09 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:15 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 05/31] perf build: Combine libdw-dwarf-unwind into libdw
 feature tests
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

Support in libdw has been present for 10 years so let's simplify the
build logic with a single feature test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                  |  2 --
 tools/build/feature/Makefile                  |  4 ----
 tools/build/feature/test-all.c                |  5 -----
 tools/build/feature/test-libdw-dwarf-unwind.c | 14 --------------
 tools/build/feature/test-libdw.c              | 19 ++++++++++++++++++-
 tools/perf/Makefile.config                    |  8 --------
 6 files changed, 18 insertions(+), 34 deletions(-)
 delete mode 100644 tools/build/feature/test-libdw-dwarf-unwind.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 6025810cc346..db3695ec5f83 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -60,7 +60,6 @@ FEATURE_TESTS_BASIC :=                  \
         reallocarray                    \
         stackprotector-all              \
         timerfd                         \
-        libdw-dwarf-unwind              \
         zlib                            \
         lzma                            \
         get_cpuid                       \
@@ -133,7 +132,6 @@ FEATURE_DISPLAY ?=              \
          libpython              \
          libcrypto              \
          libunwind              \
-         libdw-dwarf-unwind     \
          libcapstone            \
          llvm-perf              \
          zlib                   \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index bece326ac93b..7bb409c1f7e6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -52,7 +52,6 @@ FILES=                                          \
          test-pthread-barrier.bin		\
          test-stackprotector-all.bin            \
          test-timerfd.bin                       \
-         test-libdw-dwarf-unwind.bin            \
          test-libbabeltrace.bin                 \
          test-libcapstone.bin			\
          test-compile-32.bin                    \
@@ -314,9 +313,6 @@ $(OUTPUT)test-backtrace.bin:
 $(OUTPUT)test-timerfd.bin:
 	$(BUILD)
 
-$(OUTPUT)test-libdw-dwarf-unwind.bin:
-	$(BUILD) # -ldw provided by $(FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind)
-
 $(OUTPUT)test-libbabeltrace.bin:
 	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index d60e072b6eca..863c82516433 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -98,10 +98,6 @@
 # include "test-stackprotector-all.c"
 #undef main
 
-#define main main_test_libdw_dwarf_unwind
-# include "test-libdw-dwarf-unwind.c"
-#undef main
-
 #define main main_test_zlib
 # include "test-zlib.c"
 #undef main
@@ -202,7 +198,6 @@ int main(int argc, char *argv[])
 	main_test_numa_num_possible_cpus();
 	main_test_timerfd();
 	main_test_stackprotector_all();
-	main_test_libdw_dwarf_unwind();
 	main_test_zlib();
 	main_test_pthread_attr_setaffinity_np();
 	main_test_pthread_barrier();
diff --git a/tools/build/feature/test-libdw-dwarf-unwind.c b/tools/build/feature/test-libdw-dwarf-unwind.c
deleted file mode 100644
index ed03d9505609..000000000000
--- a/tools/build/feature/test-libdw-dwarf-unwind.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <elfutils/libdwfl.h>
-
-int main(void)
-{
-	/*
-	 * This function is guarded via: __nonnull_attribute__ (1, 2).
-	 * Passing '1' as arguments value. This code is never executed,
-	 * only compiled.
-	 */
-	dwfl_thread_getframes((void *) 1, (void *) 1, NULL);
-	return 0;
-}
diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index 8d474bd7371b..793f4ac49514 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -1,11 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dwarf.h>
 #include <elfutils/libdw.h>
+#include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
 
-int main(void)
+int test_libdw(void)
 {
 	Dwarf *dbg = dwarf_begin(0, DWARF_C_READ);
 
 	return (long)dbg;
 }
+
+int test_libdw_unwind(void)
+{
+	/*
+	 * This function is guarded via: __nonnull_attribute__ (1, 2).
+	 * Passing '1' as arguments value. This code is never executed,
+	 * only compiled.
+	 */
+	dwfl_thread_getframes((void *) 1, (void *) 1, NULL);
+	return 0;
+}
+
+int main(void)
+{
+	return test_libdw() + test_libdw_unwind();
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c8e157cc0c5e..93fd6bd74d20 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -161,8 +161,6 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 endif
 FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-dwarf_getlocations := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
@@ -464,12 +462,6 @@ else
       endif
     endif
   else
-    ifndef NO_LIBDW_DWARF_UNWIND
-      ifneq ($(feature-libdw-dwarf-unwind),1)
-        NO_LIBDW_DWARF_UNWIND := 1
-        $(warning No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR)
-      endif
-    endif
     ifneq ($(feature-libdw), 1)
       ifndef NO_LIBDW
         $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
-- 
2.47.0.rc0.187.ge670bccf7e-goog


