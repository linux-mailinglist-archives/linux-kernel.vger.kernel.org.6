Return-Path: <linux-kernel+bounces-189336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF068CEE93
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A3B21168
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA4B364D2;
	Sat, 25 May 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KALeqecB"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898CB67D
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716634085; cv=none; b=ahPnzoRvfA+gGjDQGYbPmedWl/jddh+a4uhbmjJTIJYEHvIUkPEMMoJJU/jaMYwoYLkjF3GQ4CcByRGdGLiU4owsRUC6yoG9LHGBAtwkR2/Hh2cpRy+2yoZ6BsHPdCP7jK2c12WY0AQVMPWUweE2R7G6XEuUtCOGv/TlTP9XP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716634085; c=relaxed/simple;
	bh=453us0v7/PG5mYKmjp0bD2i6YyQIBAhZQcSS6kRkQJc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hS9z4s+h7hlecF0959TKkeqVZzXdCD/SzYJQSsKY0l8//CUbaM1xXwy7cN/d3VVpneWXR0lACw7uImnKi2R09w13xBiglJRGy6JCtXcq3snc2wKQmHU9xbrBKDmqAwdl9wGlsmzUKBnpRZ7t9yNE0n+LvEibuwo/2hE6agjPQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KALeqecB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627e4afa326so18086227b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716634082; x=1717238882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9HPpoKP2EfznO0vgFKg9PdNvX/1gZFb+OChgSD84qho=;
        b=KALeqecBEew8yrF4LnUH26WrR7Btb5XgysEQ3Il4d66qBjhB9etDrqlepyJDctWoC0
         PsuJNMwI9tF37e/KYf72zPQSnKJmDRiDT77/347tSb8PFxOJq/ytSrvInxgUEjW9E2s0
         O6JbKSvTiA9n9jVMlC/Tj9/HbSlFaOXL5pPpRXu3grh3RCT8VjFSMqITY0Qq/yrNbv3d
         ScapU+1/RPeQOA+3tcsxlGRk3/Bne4zQhyCeSY9X59UlkBx16Ax8wlfxPDZdoEZ5rMev
         VcYpwqpdxMdbyz5eN2YRY/fygDA4P0cOImc7PEXKJlT7RHEA248xKaw8svb7ca88S3Ot
         2fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716634082; x=1717238882;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9HPpoKP2EfznO0vgFKg9PdNvX/1gZFb+OChgSD84qho=;
        b=cHY0ir4d/6b4um2NyItNpQfdiZKJc5MLPFIRhWz9sShHuBeZUYbYg0KijTR9YIVRA8
         OUksYkUofeboA4bsCM0yw39vFezBa8NP/lEPgToyZTcZpk6nVGr9+DyfuhsZ4h/mEOQw
         pzulh4QJGMAIqKv+oOZ+fNsm21IsZ4G/gnvq7joBwr3fuuReY7LFcPwnzDE8417dlgvj
         vYcJHOBVsxrod0dz0McMG1DIRCoOJIK8Jog5QbqOqVO9B9SBu/uSCtu743tik/6RV2oh
         23MlXZW5oCBbtIapF0mCeVw7TByPuaDTzD+X7zSNESZXl4gUyyrUf3B94yGfUqTolANP
         KX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCb+VrGJAKuj9jWLM3Zq0+v9yfOhYHrrhH7YUN+T3pmeF0kgauHseJznIqBYipbkixkF8qemnb9h5TKTtEzj2JcxyITEWgiHeh4UG8
X-Gm-Message-State: AOJu0YwnpLBz5xKFchpqCkT/6+n5qqhAuLGLgvh6Is/MkwLvsSSYS1Rs
	No8y5bHJEsZv9XNRguKsPrf5NjjFH9Ta2rCyhf14bb4tnvlCnF5chBrGe61Bibh2fjRjeHdMGQ=
	=
X-Google-Smtp-Source: AGHT+IE3uAusjhlb5QfvAfrR/6Swpb9p++1Vpegd+VybwqYKgQBHpBFjN7VOqZEzYBuAO68cp0vzQp9y4Q==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:8cba:1aee:d3cd:626f])
 (user=sesse job=sendgmr) by 2002:a05:690c:4a02:b0:61b:e253:31ad with SMTP id
 00721157ae682-62a08fa9d1dmr10694227b3.8.1716634082087; Sat, 25 May 2024
 03:48:02 -0700 (PDT)
Date: Sat, 25 May 2024 12:47:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240525104755.324014-1-sesse@google.com>
Subject: [PATCH v6 1/3] perf report: Support LLVM for addr2line()
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, "Steinar H. Gunderson" <sesse@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

In addition to the existing support for libbfd and calling out to
an external addr2line command, add support for using libllvm directly.
This is both faster than libbfd, and can be enabled in distro builds
(the LLVM license has an explicit provision for GPLv2 compatibility).
Thus, it is set as the primary choice if available.

As an example, running perf report on a medium-size profile with
DWARF-based backtraces took 58 seconds with LLVM, 78 seconds with
libbfd, 153 seconds with external llvm-addr2line, and I got tired
and aborted the test after waiting for 55 minutes with external
bfd addr2line (which is the default for perf as compiled by distributions
today). Evidently, for this case, the bfd addr2line process needs
18 seconds (on a 5.2 GHz Zen 3) to load the .debug ELF in question,
hits the 1-second timeout and gets killed during initialization,
getting restarted anew every time. Having an in-process addr2line
makes this much more robust.

As future extensions, libllvm can be used in many other places where
we currently use libbfd or other libraries:

 - Symbol enumeration (in particular, for PE binaries).
 - Demangling (including non-Itanium demangling, e.g. Microsoft
   or Rust).
 - Disassembling (perf annotate).

However, these are much less pressing; most people don't profile
PE binaries, and perf has non-bfd paths for ELF. The same with
demangling; the default _cxa_demangle path works fine for most
users. Disassembling is coming in a later patch in the series;
however do note that while bfd objdump can be slow on large binaries,
it is possible to use --objdump=llvm-objdump to get the speed benefits.
(It appears LLVM-based demangling is very simple, should we want
that.)

Tested with LLVM 14, 15, 16, 18 and 19. For some reason, LLVM 12 was not
correctly detected using feature_check, and thus was not tested.

Signed-off-by: Steinar H. Gunderson <sesse@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature       |   1 +
 tools/perf/Makefile.config         |  15 ++++
 tools/perf/builtin-version.c       |   1 +
 tools/perf/util/Build              |   1 +
 tools/perf/util/llvm-c-helpers.cpp | 134 +++++++++++++++++++++++++++++
 tools/perf/util/llvm-c-helpers.h   |  47 ++++++++++
 tools/perf/util/srcline.c          |  57 +++++++++++-
 7 files changed, 255 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/llvm-c-helpers.cpp
 create mode 100644 tools/perf/util/llvm-c-helpers.h

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 1e2ab148d5db..278b26216254 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -136,6 +136,7 @@ FEATURE_DISPLAY ?=              \
          libunwind              \
          libdw-dwarf-unwind     \
          libcapstone            \
+         llvm                   \
          zlib                   \
          lzma                   \
          get_cpuid              \
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..42f5ad89c0ca 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -969,6 +969,21 @@ ifdef BUILD_NONDISTRO
   endif
 endif
 
+ifndef NO_LIBLLVM
+  $(call feature_check,llvm)
+  ifeq ($(feature-llvm), 1)
+    CFLAGS += -DHAVE_LIBLLVM_SUPPORT
+    CXXFLAGS += -DHAVE_LIBLLVM_SUPPORT
+    CXXFLAGS += $(shell $(LLVM_CONFIG) --cxxflags)
+    LIBLLVM = $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG) --system-libs)
+    EXTLIBS += -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
+    $(call detected,CONFIG_LIBLLVM)
+  else
+    $(warning No libllvm found, slower source file resolution, please install llvm-devel/llvm-dev)
+    NO_LIBLLVM := 1
+  endif
+endif
+
 ifndef NO_DEMANGLE
   $(call feature_check,cxa-demangle)
   ifeq ($(feature-cxa-demangle), 1)
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 398aa53e9e2e..4b252196de12 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -65,6 +65,7 @@ static void library_status(void)
 	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
 	STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
 	STATUS(HAVE_LIBELF_SUPPORT, libelf);
+	STATUS(HAVE_LIBLLVM_SUPPORT, libllvm);
 	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
 	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
 	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index da64efd8718f..6a1fd8f1a488 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -226,6 +226,7 @@ perf-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
 perf-y += demangle-ocaml.o
 perf-y += demangle-java.o
 perf-y += demangle-rust.o
+perf-$(CONFIG_LIBLLVM) += llvm-c-helpers.o
 
 ifdef CONFIG_JITDUMP
 perf-$(CONFIG_LIBELF) += jitdump.o
diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
new file mode 100644
index 000000000000..3cc967ec6f28
--- /dev/null
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Must come before the linux/compiler.h include, which defines several
+ * macros (e.g. noinline) that conflict with compiler builtins used
+ * by LLVM.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM <= 15 */
+#include <llvm/DebugInfo/Symbolize/Symbolize.h>
+#pragma GCC diagnostic pop
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <linux/compiler.h>
+extern "C" {
+#include <linux/zalloc.h>
+}
+#include "symbol_conf.h"
+#include "llvm-c-helpers.h"
+
+using namespace llvm;
+using llvm::symbolize::LLVMSymbolizer;
+
+/*
+ * Allocate a static LLVMSymbolizer, which will live to the end of the program.
+ * Unlike the bfd paths, LLVMSymbolizer has its own cache, so we do not need
+ * to store anything in the dso struct.
+ */
+static LLVMSymbolizer *get_symbolizer()
+{
+	static LLVMSymbolizer *instance = nullptr;
+	if (instance == nullptr) {
+		LLVMSymbolizer::Options opts;
+		/*
+		 * LLVM sometimes demangles slightly different from the rest
+		 * of the code, and this mismatch can cause new_inline_sym()
+		 * to get confused and mark non-inline symbol as inlined
+		 * (since the name does not properly match up with base_sym).
+		 * Thus, disable the demangling and let the rest of the code
+		 * handle it.
+		 */
+		opts.Demangle = false;
+		instance = new LLVMSymbolizer(opts);
+	}
+	return instance;
+}
+
+/* Returns 0 on error, 1 on success. */
+static int extract_file_and_line(const DILineInfo &line_info, char **file,
+				 unsigned int *line)
+{
+	if (file) {
+		if (line_info.FileName == "<invalid>") {
+			/* Match the convention of libbfd. */
+			*file = nullptr;
+		} else {
+			/* The caller expects to get something it can free(). */
+			*file = strdup(line_info.FileName.c_str());
+			if (*file == nullptr)
+				return 0;
+		}
+	}
+	if (line)
+		*line = line_info.Line;
+	return 1;
+}
+
+extern "C"
+int llvm_addr2line(const char *dso_name, u64 addr,
+		   char **file, unsigned int *line,
+		   bool unwind_inlines,
+		   llvm_a2l_frame **inline_frames)
+{
+	LLVMSymbolizer *symbolizer = get_symbolizer();
+	object::SectionedAddress sectioned_addr = {
+		addr,
+		object::SectionedAddress::UndefSection
+	};
+
+	if (unwind_inlines) {
+		Expected<DIInliningInfo> res_or_err =
+			symbolizer->symbolizeInlinedCode(dso_name,
+							 sectioned_addr);
+		if (!res_or_err)
+			return 0;
+		unsigned num_frames = res_or_err->getNumberOfFrames();
+		if (num_frames == 0)
+			return 0;
+
+		if (extract_file_and_line(res_or_err->getFrame(0),
+					  file, line) == 0)
+			return 0;
+
+		*inline_frames = (llvm_a2l_frame *)calloc(
+			num_frames, sizeof(**inline_frames));
+		if (*inline_frames == nullptr)
+			return 0;
+
+		for (unsigned i = 0; i < num_frames; ++i) {
+			const DILineInfo &src = res_or_err->getFrame(i);
+
+			llvm_a2l_frame &dst = (*inline_frames)[i];
+			if (src.FileName == "<invalid>")
+				/* Match the convention of libbfd. */
+				dst.filename = nullptr;
+			else
+				dst.filename = strdup(src.FileName.c_str());
+			dst.funcname = strdup(src.FunctionName.c_str());
+			dst.line = src.Line;
+
+			if (dst.filename == nullptr ||
+			    dst.funcname == nullptr) {
+				for (unsigned j = 0; j <= i; ++j) {
+					zfree(&(*inline_frames)[j].filename);
+					zfree(&(*inline_frames)[j].funcname);
+				}
+				zfree(inline_frames);
+				return 0;
+			}
+		}
+
+		return num_frames;
+	} else {
+		if (inline_frames)
+			*inline_frames = nullptr;
+
+		Expected<DILineInfo> res_or_err =
+			symbolizer->symbolizeCode(dso_name, sectioned_addr);
+		if (!res_or_err)
+			return 0;
+		return extract_file_and_line(*res_or_err, file, line);
+	}
+}
diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-helpers.h
new file mode 100644
index 000000000000..1b28cdc9f9b7
--- /dev/null
+++ b/tools/perf/util/llvm-c-helpers.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_LLVM_C_HELPERS
+#define __PERF_LLVM_C_HELPERS 1
+
+/*
+ * Helpers to call into LLVM C++ code from C, for the parts that do not have
+ * C APIs.
+ */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct llvm_a2l_frame {
+	char *filename;
+	char *funcname;
+	unsigned int line;
+};
+
+/*
+ * Implement addr2line() using libLLVM. LLVM is a C++ API, and
+ * many of the linux/ headers cannot be included in a C++ compile unit,
+ * so we need to make a little bridge code here. llvm_addr2line() will
+ * convert the inline frame information from LLVM's internal structures
+ * and put them into a flat array given in inline_frames. The caller
+ * is then responsible for taking that array and convert it into perf's
+ * regular inline frame structures (which depend on e.g. struct list_head).
+ *
+ * If the address could not be resolved, or an error occurred (e.g. OOM),
+ * returns 0. Otherwise, returns the number of inline frames (which means 1
+ * if the address was not part of an inlined function). If unwind_inlines
+ * is set and the return code is nonzero, inline_frames will be set to
+ * a newly allocated array with that length. The caller is then responsible
+ * for freeing both the strings and the array itself.
+ */
+int llvm_addr2line(const char *dso_name,
+		   u64 addr,
+		   char **file,
+		   unsigned int *line,
+		   bool unwind_inlines,
+		   struct llvm_a2l_frame **inline_frames);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __PERF_LLVM_C_HELPERS */
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 9d670d8c1c08..71d7decc08fd 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -16,6 +16,9 @@
 #include "util/debug.h"
 #include "util/callchain.h"
 #include "util/symbol_conf.h"
+#ifdef HAVE_LIBLLVM_SUPPORT
+#include "util/llvm-c-helpers.h"
+#endif
 #include "srcline.h"
 #include "string2.h"
 #include "symbol.h"
@@ -130,7 +133,59 @@ static struct symbol *new_inline_sym(struct dso *dso,
 
 #define MAX_INLINE_NEST 1024
 
-#ifdef HAVE_LIBBFD_SUPPORT
+#ifdef HAVE_LIBLLVM_SUPPORT
+
+static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
+				    int num_frames)
+{
+	if (inline_frames != NULL) {
+		for (int i = 0; i < num_frames; ++i) {
+			zfree(inline_frames[i].filename);
+			zfree(inline_frames[i].funcname);
+		}
+		zfree(inline_frames);
+	}
+}
+
+static int addr2line(const char *dso_name, u64 addr,
+		     char **file, unsigned int *line, struct dso *dso,
+		     bool unwind_inlines, struct inline_node *node,
+		     struct symbol *sym)
+{
+	struct llvm_a2l_frame *inline_frames = NULL;
+	int num_frames = llvm_addr2line(dso_name, addr, file, line,
+					node && unwind_inlines, &inline_frames);
+
+	if (num_frames == 0 || !inline_frames) {
+		/* Error, or we didn't want inlines. */
+		return num_frames;
+	}
+
+	for (int i = 0; i < num_frames; ++i) {
+		struct symbol *inline_sym =
+			new_inline_sym(dso, sym, inline_frames[i].funcname);
+		char *srcline = NULL;
+
+		if (inline_frames[i].filename)
+			srcline = srcline_from_fileline(
+				inline_frames[i].filename,
+				inline_frames[i].line);
+		if (inline_list__append(inline_sym, srcline, node) != 0) {
+			free_llvm_inline_frames(inline_frames, num_frames);
+			return 0;
+		}
+	}
+	free_llvm_inline_frames(inline_frames, num_frames);
+
+	return num_frames;
+}
+
+void dso__free_a2l(struct dso *)
+{
+	/* Nothing to free. */
+}
+
+#elif defined(HAVE_LIBBFD_SUPPORT)
 
 /*
  * Implement addr2line using libbfd.
-- 
2.45.1


