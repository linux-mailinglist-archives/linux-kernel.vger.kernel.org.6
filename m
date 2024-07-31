Return-Path: <linux-kernel+bounces-269454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D099432F5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340411F29D64
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B811BE253;
	Wed, 31 Jul 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POHZleOB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DD1B3F22
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438731; cv=none; b=gmXuvdpsqns9JyOISBlSEGPUkbecaLGnssCkO0Hx10l/gQPRgbLydulSv+AzUtsdj0ccASD1Tv878So6+ezlYdE+EQ7vIdRbdOkf5xINpIQSdikLv4Q2oaA9RU8yatZApHq+IAhQ3eOZPpmCdW3yxDcd3eNvGyGLKwxPcippelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438731; c=relaxed/simple;
	bh=CYrKPX44JicHn3bAtn8FTIGnXuR4A7TV/hToix4HGd0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U34jRjfjRtQNUYeRJSF7hmV9OcM5OpjqLl7FRQ14r3lyKDyBpV5jAREuS6mvXbthmh6Zep/Oc9FvrFxXYoeRZYcmpcvouLmT2cMLU/12ZLpcElFmS0We4y/bYZcLw1hNG+Uoi5cd1p2W1VkV5YXplIzOvtmxLb4/gUsl7QJq5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POHZleOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A490C116B1;
	Wed, 31 Jul 2024 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722438730;
	bh=CYrKPX44JicHn3bAtn8FTIGnXuR4A7TV/hToix4HGd0=;
	h=Date:From:To:Cc:Subject:From;
	b=POHZleOBtX1QPM501tdoy/j8/MZKups7CBV0CixMfvoPqc/vnTTnS3WUb1PUuZBjF
	 SB5aBiUIAzJGz/sWOQIiUTS0n76ubmRctfMP4HhuRCr9Ums9BjnVBdbeyA0ppHUlJC
	 SblqiuEI498voh66GBTY546whZ70hLPujexfQNLckMT7LKVE+iWwSlAvnzCrZXXrdY
	 liqSOLgYrfU+/b5naiAEqwsqHmLCIYhcV5Wnvy5SGErSOWTKTdHBiyHozyOctUmEj9
	 WYAv+XvaEVBLWN8IZ81iNZiN16Dand9QWT3D6/nVUcHtt12DaLF1/SeBZA43wEd2Ll
	 Y5dj2hjXYr2Aw==
Date: Wed, 31 Jul 2024 12:12:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf bpf: Move BPF disassembly routines to separate file
 to avoid clash with capstone bpf headers
Message-ID: <ZqpUSKPxMwaQKORr@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

There is a clash of the libbpf and capstone libraries, that ends up
with:

  In file included from /usr/include/capstone/capstone.h:325,
                   from util/disasm.c:1513:
  /usr/include/capstone/bpf.h:94:14: error: ‘bpf_insn’ defined as wrong kind of tag
     94 | typedef enum bpf_insn {

So far we're just trying to avoid this by not having both headers
included in the same .c or .h file, do it one more time by moving the
BPF diassembly routines from util/disasm.c to util/disasm_bpf.c.

This is only being hit when building with BUILD_NONDISTRO=1, i.e.
building with binutils-devel, that isn't the in the default build due to
a licencing clash. We need to reimplement what is now isolated in
util/disasm_bpf.c using some other library to have BPF annotation
feature that now only is available with BUILD_NONDISTRO=1.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <song@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build        |   1 +
 tools/perf/util/disasm.c     | 187 +--------------------------------
 tools/perf/util/disasm_bpf.c | 193 +++++++++++++++++++++++++++++++++++
 tools/perf/util/disasm_bpf.h |  12 +++
 4 files changed, 207 insertions(+), 186 deletions(-)
 create mode 100644 tools/perf/util/disasm_bpf.c
 create mode 100644 tools/perf/util/disasm_bpf.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0f18fe81ef0b2a74..b24360c04aaea424 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -13,6 +13,7 @@ perf-util-y += copyfile.o
 perf-util-y += ctype.o
 perf-util-y += db-export.o
 perf-util-y += disasm.o
+perf-util-y += disasm_bpf.o
 perf-util-y += env.o
 perf-util-y += event.o
 perf-util-y += evlist.o
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 410e52cd9cfd0306..85fb0cfedf94554b 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -16,6 +16,7 @@
 #include "build-id.h"
 #include "debug.h"
 #include "disasm.h"
+#include "disasm_bpf.h"
 #include "dso.h"
 #include "env.h"
 #include "evsel.h"
@@ -1323,192 +1324,6 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	return 0;
 }
 
-#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
-#define PACKAGE "perf"
-#include <bfd.h>
-#include <dis-asm.h>
-#include <bpf/bpf.h>
-#include <bpf/btf.h>
-#include <bpf/libbpf.h>
-#include <linux/btf.h>
-#include <tools/dis-asm-compat.h>
-
-#include "bpf-event.h"
-#include "bpf-utils.h"
-
-static int symbol__disassemble_bpf(struct symbol *sym,
-				   struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct bpf_prog_linfo *prog_linfo = NULL;
-	struct bpf_prog_info_node *info_node;
-	int len = sym->end - sym->start;
-	disassembler_ftype disassemble;
-	struct map *map = args->ms.map;
-	struct perf_bpil *info_linear;
-	struct disassemble_info info;
-	struct dso *dso = map__dso(map);
-	int pc = 0, count, sub_id;
-	struct btf *btf = NULL;
-	char tpath[PATH_MAX];
-	size_t buf_size;
-	int nr_skip = 0;
-	char *buf;
-	bfd *bfdf;
-	int ret;
-	FILE *s;
-
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
-
-	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
-		  sym->name, sym->start, sym->end - sym->start);
-
-	memset(tpath, 0, sizeof(tpath));
-	perf_exe(tpath, sizeof(tpath));
-
-	bfdf = bfd_openr(tpath, NULL);
-	if (bfdf == NULL)
-		abort();
-
-	if (!bfd_check_format(bfdf, bfd_object))
-		abort();
-
-	s = open_memstream(&buf, &buf_size);
-	if (!s) {
-		ret = errno;
-		goto out;
-	}
-	init_disassemble_info_compat(&info, s,
-				     (fprintf_ftype) fprintf,
-				     fprintf_styled);
-	info.arch = bfd_get_arch(bfdf);
-	info.mach = bfd_get_mach(bfdf);
-
-	info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
-						 dso__bpf_prog(dso)->id);
-	if (!info_node) {
-		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
-		goto out;
-	}
-	info_linear = info_node->info_linear;
-	sub_id = dso__bpf_prog(dso)->sub_id;
-
-	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
-	info.buffer_length = info_linear->info.jited_prog_len;
-
-	if (info_linear->info.nr_line_info)
-		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
-
-	if (info_linear->info.btf_id) {
-		struct btf_node *node;
-
-		node = perf_env__find_btf(dso__bpf_prog(dso)->env,
-					  info_linear->info.btf_id);
-		if (node)
-			btf = btf__new((__u8 *)(node->data),
-				       node->data_size);
-	}
-
-	disassemble_init_for_target(&info);
-
-#ifdef DISASM_FOUR_ARGS_SIGNATURE
-	disassemble = disassembler(info.arch,
-				   bfd_big_endian(bfdf),
-				   info.mach,
-				   bfdf);
-#else
-	disassemble = disassembler(bfdf);
-#endif
-	if (disassemble == NULL)
-		abort();
-
-	fflush(s);
-	do {
-		const struct bpf_line_info *linfo = NULL;
-		struct disasm_line *dl;
-		size_t prev_buf_size;
-		const char *srcline;
-		u64 addr;
-
-		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
-		count = disassemble(pc, &info);
-
-		if (prog_linfo)
-			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
-								addr, sub_id,
-								nr_skip);
-
-		if (linfo && btf) {
-			srcline = btf__name_by_offset(btf, linfo->line_off);
-			nr_skip++;
-		} else
-			srcline = NULL;
-
-		fprintf(s, "\n");
-		prev_buf_size = buf_size;
-		fflush(s);
-
-		if (!annotate_opts.hide_src_code && srcline) {
-			args->offset = -1;
-			args->line = strdup(srcline);
-			args->line_nr = 0;
-			args->fileloc = NULL;
-			args->ms.sym  = sym;
-			dl = disasm_line__new(args);
-			if (dl) {
-				annotation_line__add(&dl->al,
-						     &notes->src->source);
-			}
-		}
-
-		args->offset = pc;
-		args->line = buf + prev_buf_size;
-		args->line_nr = 0;
-		args->fileloc = NULL;
-		args->ms.sym  = sym;
-		dl = disasm_line__new(args);
-		if (dl)
-			annotation_line__add(&dl->al, &notes->src->source);
-
-		pc += count;
-	} while (count > 0 && pc < len);
-
-	ret = 0;
-out:
-	free(prog_linfo);
-	btf__free(btf);
-	fclose(s);
-	bfd_close(bfdf);
-	return ret;
-}
-#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
-static int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
-				   struct annotate_args *args __maybe_unused)
-{
-	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
-}
-#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
-
-static int
-symbol__disassemble_bpf_image(struct symbol *sym,
-			      struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct disasm_line *dl;
-
-	args->offset = -1;
-	args->line = strdup("to be implemented");
-	args->line_nr = 0;
-	args->fileloc = NULL;
-	dl = disasm_line__new(args);
-	if (dl)
-		annotation_line__add(&dl->al, &notes->src->source);
-
-	zfree(&args->line);
-	return 0;
-}
-
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 #include <capstone/capstone.h>
 
diff --git a/tools/perf/util/disasm_bpf.c b/tools/perf/util/disasm_bpf.c
new file mode 100644
index 0000000000000000..14994515beb341ce
--- /dev/null
+++ b/tools/perf/util/disasm_bpf.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "util/annotate.h"
+#include "util/disasm_bpf.h"
+#include "util/symbol.h"
+
+#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+#define PACKAGE "perf"
+#include <bfd.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+#include <dis-asm.h>
+#include <errno.h>
+#include <linux/btf.h>
+#include <tools/dis-asm-compat.h>
+
+#include "util/bpf-event.h"
+#include "util/bpf-utils.h"
+#include "util/debug.h"
+#include "util/dso.h"
+#include "util/map.h"
+#include "util/env.h"
+#include "util/util.h"
+
+int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct bpf_prog_linfo *prog_linfo = NULL;
+	struct bpf_prog_info_node *info_node;
+	int len = sym->end - sym->start;
+	disassembler_ftype disassemble;
+	struct map *map = args->ms.map;
+	struct perf_bpil *info_linear;
+	struct disassemble_info info;
+	struct dso *dso = map__dso(map);
+	int pc = 0, count, sub_id;
+	struct btf *btf = NULL;
+	char tpath[PATH_MAX];
+	size_t buf_size;
+	int nr_skip = 0;
+	char *buf;
+	bfd *bfdf;
+	int ret;
+	FILE *s;
+
+	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
+
+	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
+		  sym->name, sym->start, sym->end - sym->start);
+
+	memset(tpath, 0, sizeof(tpath));
+	perf_exe(tpath, sizeof(tpath));
+
+	bfdf = bfd_openr(tpath, NULL);
+	if (bfdf == NULL)
+		abort();
+
+	if (!bfd_check_format(bfdf, bfd_object))
+		abort();
+
+	s = open_memstream(&buf, &buf_size);
+	if (!s) {
+		ret = errno;
+		goto out;
+	}
+	init_disassemble_info_compat(&info, s,
+				     (fprintf_ftype) fprintf,
+				     fprintf_styled);
+	info.arch = bfd_get_arch(bfdf);
+	info.mach = bfd_get_mach(bfdf);
+
+	info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
+						 dso__bpf_prog(dso)->id);
+	if (!info_node) {
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		goto out;
+	}
+	info_linear = info_node->info_linear;
+	sub_id = dso__bpf_prog(dso)->sub_id;
+
+	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
+	info.buffer_length = info_linear->info.jited_prog_len;
+
+	if (info_linear->info.nr_line_info)
+		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
+
+	if (info_linear->info.btf_id) {
+		struct btf_node *node;
+
+		node = perf_env__find_btf(dso__bpf_prog(dso)->env,
+					  info_linear->info.btf_id);
+		if (node)
+			btf = btf__new((__u8 *)(node->data),
+				       node->data_size);
+	}
+
+	disassemble_init_for_target(&info);
+
+#ifdef DISASM_FOUR_ARGS_SIGNATURE
+	disassemble = disassembler(info.arch,
+				   bfd_big_endian(bfdf),
+				   info.mach,
+				   bfdf);
+#else
+	disassemble = disassembler(bfdf);
+#endif
+	if (disassemble == NULL)
+		abort();
+
+	fflush(s);
+	do {
+		const struct bpf_line_info *linfo = NULL;
+		struct disasm_line *dl;
+		size_t prev_buf_size;
+		const char *srcline;
+		u64 addr;
+
+		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
+		count = disassemble(pc, &info);
+
+		if (prog_linfo)
+			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
+								addr, sub_id,
+								nr_skip);
+
+		if (linfo && btf) {
+			srcline = btf__name_by_offset(btf, linfo->line_off);
+			nr_skip++;
+		} else
+			srcline = NULL;
+
+		fprintf(s, "\n");
+		prev_buf_size = buf_size;
+		fflush(s);
+
+		if (!annotate_opts.hide_src_code && srcline) {
+			args->offset = -1;
+			args->line = strdup(srcline);
+			args->line_nr = 0;
+			args->fileloc = NULL;
+			args->ms.sym  = sym;
+			dl = disasm_line__new(args);
+			if (dl) {
+				annotation_line__add(&dl->al,
+						     &notes->src->source);
+			}
+		}
+
+		args->offset = pc;
+		args->line = buf + prev_buf_size;
+		args->line_nr = 0;
+		args->fileloc = NULL;
+		args->ms.sym  = sym;
+		dl = disasm_line__new(args);
+		if (dl)
+			annotation_line__add(&dl->al, &notes->src->source);
+
+		pc += count;
+	} while (count > 0 && pc < len);
+
+	ret = 0;
+out:
+	free(prog_linfo);
+	btf__free(btf);
+	fclose(s);
+	bfd_close(bfdf);
+	return ret;
+}
+#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+int symbol__disassemble_bpf(struct symbol *sym __maybe_unused, struct annotate_args *args __maybe_unused)
+{
+	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
+}
+#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+
+int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct disasm_line *dl;
+
+	args->offset = -1;
+	args->line = strdup("to be implemented");
+	args->line_nr = 0;
+	args->fileloc = NULL;
+	dl = disasm_line__new(args);
+	if (dl)
+		annotation_line__add(&dl->al, &notes->src->source);
+
+	zfree(&args->line);
+	return 0;
+}
diff --git a/tools/perf/util/disasm_bpf.h b/tools/perf/util/disasm_bpf.h
new file mode 100644
index 0000000000000000..2ecb19545388b114
--- /dev/null
+++ b/tools/perf/util/disasm_bpf.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#ifndef __PERF_DISASM_BPF_H
+#define __PERF_DISASM_BPF_H
+
+struct symbol;
+struct annotate_args;
+
+int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args);
+int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args);
+
+#endif /* __PERF_DISASM_BPF_H */
-- 
2.45.2


