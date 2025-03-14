Return-Path: <linux-kernel+bounces-562026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6ACA61AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548E8463B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2744420E008;
	Fri, 14 Mar 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdO/gDMV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6220A5DE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980572; cv=none; b=M0rWL6VGouZQOQR5AuBdzBKW/+KhlvZcbcY7tLiRd/hjSiTCsN9w1PPB9WQvZyVKTK2TNsfiGK8Ve5TVD6DWqVzFz/JjLcWIYX8hA5uClKNOi4myv9e4TvKObBF9FRh0RwA1S64WKs/AHVjqrWY7nZY56+6P+HPp3cOi0KFmGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980572; c=relaxed/simple;
	bh=KyZF3sb610UPzWkHD9K7JAZK25xgze011L6w0Ci3vzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOrZdj9pmjqfg/L5Yzl3pLQdzzM0yxkbfr+O/oD0nElBCcmO1EFt2GFeDp+6mYeWr4xep+NbBheaKHgs7/PbGMt+gIJlOhxpRAPxUasVJ+9n1580mJrihUTlPf7UgHISTJ7HVyDvraHFHAr+YJMKR7z9sC1iNal3jrVqxF7bfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdO/gDMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEEBC4CEF0;
	Fri, 14 Mar 2025 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980572;
	bh=KyZF3sb610UPzWkHD9K7JAZK25xgze011L6w0Ci3vzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdO/gDMVZrIFMYTUvBe3omaxZEZfrPtvwZXNakSbQwfrzuLXKtEQt3/1fQxi9UNET
	 Q4oO3Zjxcsm2fCyr+ivzQLSRr1nD/2Y2WuHMuVatgxX3dV1S2YeMg42ey7/ce3V2dI
	 o6+hWfbC/XXbzy/mTXoKpwcmSdA0LCLUKt3KO/gYsfKJGHnMBBpxFGV1lSXpMx07wX
	 9u1rJThjMcfNgEQGIHnH/HUuLjZ4yEYdh+ueqGREohxrbELGF7cDTNft78F4w6OuXx
	 qfCpmTwRZvSTSLHwl91nTO8X8yedEzUQVSaT3ZuptG7HUA1PFbGn2pRPfUPEbC1oCI
	 WBJ19rLqhHbqg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 09/13] objtool: Add --output option
Date: Fri, 14 Mar 2025 12:29:07 -0700
Message-ID: <0da308d42d82b3bbed16a31a72d6bde52afcd6bd.1741975349.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741975349.git.jpoimboe@kernel.org>
References: <cover.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add option to allow writing the changed binary to a separate file rather
than changing it in place.

Libelf makes this suprisingly hard, so take the easy way out and just
copy the file before editing it.

Also steal the -o short option from --orc.  Nobody will notice ;-)

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c           | 98 ++++++++++++++++++++-----
 tools/objtool/elf.c                     |  3 -
 tools/objtool/include/objtool/builtin.h |  1 +
 tools/objtool/objtool.c                 | 15 ++--
 tools/objtool/orc_dump.c                |  7 +-
 5 files changed, 89 insertions(+), 35 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 79843512a51b..3de3afa0a19c 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -6,6 +6,10 @@
 #include <subcmd/parse-options.h>
 #include <string.h>
 #include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/sendfile.h>
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 
@@ -14,6 +18,8 @@
 		"error: objtool: " format "\n",		\
 		##__VA_ARGS__)
 
+const char *objname;
+
 struct opts opts;
 
 static const char * const check_usage[] = {
@@ -71,7 +77,7 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
-	OPT_BOOLEAN('o', "orc", &opts.orc, "generate ORC metadata"),
+	OPT_BOOLEAN(0,   "orc", &opts.orc, "generate ORC metadata"),
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN(0,   "rethunk", &opts.rethunk, "validate and annotate rethunk usage"),
 	OPT_BOOLEAN(0,   "unret", &opts.unret, "validate entry unret placement"),
@@ -84,15 +90,16 @@ static const struct option check_options[] = {
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
 	OPT_GROUP("Options:"),
-	OPT_BOOLEAN(0, "backtrace", &opts.backtrace, "unwind on error"),
-	OPT_BOOLEAN(0, "backup", &opts.backup, "create .orig files before modification"),
-	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
-	OPT_BOOLEAN(0, "link", &opts.link, "object is a linked object"),
-	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
-	OPT_BOOLEAN(0, "mnop", &opts.mnop, "nop out mcount call sites"),
-	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
-	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
-	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
+	OPT_BOOLEAN(0,   "backtrace", &opts.backtrace, "unwind on error"),
+	OPT_BOOLEAN(0,   "backup", &opts.backup, "create .orig files before modification"),
+	OPT_BOOLEAN(0,   "dry-run", &opts.dryrun, "don't write modifications"),
+	OPT_BOOLEAN(0,   "link", &opts.link, "object is a linked object"),
+	OPT_BOOLEAN(0,   "module", &opts.module, "object is part of a kernel module"),
+	OPT_BOOLEAN(0,   "mnop", &opts.mnop, "nop out mcount call sites"),
+	OPT_BOOLEAN(0,   "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
+	OPT_STRING('o',  "output", &opts.output, "file", "output file name"),
+	OPT_BOOLEAN(0,   "sec-address", &opts.sec_address, "print section addresses in warnings"),
+	OPT_BOOLEAN(0,   "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
 
 	OPT_END(),
@@ -178,24 +185,75 @@ static bool opts_valid(void)
 	return false;
 }
 
+static int copy_file(const char *src, const char *dst)
+{
+	size_t to_copy, copied;
+	int dst_fd, src_fd;
+	struct stat stat;
+	off_t offset = 0;
+
+	src_fd = open(src, O_RDONLY);
+	if (src_fd == -1) {
+		ERROR("can't open '%s' for reading", src);
+		return 1;
+	}
+
+	dst_fd = open(dst, O_WRONLY | O_CREAT | O_TRUNC);
+	if (dst_fd == -1) {
+		ERROR("can't open '%s' for writing", dst);
+		return 1;
+	}
+
+	if (fstat(src_fd, &stat) == -1) {
+		perror("fstat");
+		return 1;
+	}
+
+	if (fchmod(dst_fd, stat.st_mode) == -1) {
+		perror("fchmod");
+		return 1;
+	}
+
+	for (to_copy = stat.st_size; to_copy > 0; to_copy -= copied) {
+		copied = sendfile(dst_fd, src_fd, &offset, to_copy);
+		if (copied == -1) {
+			perror("sendfile");
+			return 1;
+		}
+	}
+
+	close(dst_fd);
+	close(src_fd);
+	return 0;
+}
+
 int objtool_run(int argc, const char **argv)
 {
-	const char *objname;
 	struct objtool_file *file;
 	int ret;
 
-	argc = cmd_parse_options(argc, argv, check_usage);
-	objname = argv[0];
+	cmd_parse_options(argc, argv, check_usage);
 
 	if (!opts_valid())
 		return 1;
 
+	objname = argv[0];
+
 	if (opts.dump_orc)
 		return orc_dump(objname);
 
+	if (!opts.dryrun && opts.output) {
+		/* copy original .o file to output file */
+		if (copy_file(objname, opts.output))
+			return 1;
+
+		/* from here on, work directly on the output file */
+		objname = opts.output;
+	}
+
 	file = objtool_open_read(objname);
 	if (!file)
-		return 1;
+		goto err;
 
 	if (!opts.link && has_multiple_files(file->elf)) {
 		ERROR("Linked object requires --link");
@@ -204,10 +262,16 @@ int objtool_run(int argc, const char **argv)
 
 	ret = check(file);
 	if (ret)
-		return ret;
+		goto err;
 
-	if (file->elf->changed)
-		return elf_write(file->elf);
+	if (!opts.dryrun && file->elf->changed && elf_write(file->elf))
+		goto err;
 
 	return 0;
+
+err:
+	if (opts.output)
+		unlink(opts.output);
+
+	return 1;
 }
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6f64d611faea..be4f4b62730c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1302,9 +1302,6 @@ int elf_write(struct elf *elf)
 	struct section *sec;
 	Elf_Scn *s;
 
-	if (opts.dryrun)
-		return 0;
-
 	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->truncate)
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index fcca6662c8b4..25cfa01758b9 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -35,6 +35,7 @@ struct opts {
 	bool mnop;
 	bool module;
 	bool no_unreachable;
+	const char *output;
 	bool sec_address;
 	bool stats;
 	bool verbose;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index f40febdd6e36..53cd881c6b95 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -18,7 +18,6 @@
 
 bool help;
 
-const char *objname;
 static struct objtool_file file;
 
 static bool objtool_create_backup(const char *_objname)
@@ -79,18 +78,14 @@ static bool objtool_create_backup(const char *_objname)
 	return true;
 }
 
-struct objtool_file *objtool_open_read(const char *_objname)
+struct objtool_file *objtool_open_read(const char *filename)
 {
-	if (objname) {
-		if (strcmp(objname, _objname)) {
-			WARN("won't handle more than one file at a time");
-			return NULL;
-		}
-		return &file;
+	if (file.elf) {
+		WARN("won't handle more than one file at a time");
+		return NULL;
 	}
-	objname = _objname;
 
-	file.elf = elf_open_read(objname, O_RDWR);
+	file.elf = elf_open_read(filename, O_RDWR);
 	if (!file.elf)
 		return NULL;
 
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index a62247efb64f..05ef0e297837 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -10,7 +10,7 @@
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
 
-int orc_dump(const char *_objname)
+int orc_dump(const char *filename)
 {
 	int fd, nr_entries, i, *orc_ip = NULL, orc_size = 0;
 	struct orc_entry *orc = NULL;
@@ -26,12 +26,9 @@ int orc_dump(const char *_objname)
 	Elf_Data *data, *symtab = NULL, *rela_orc_ip = NULL;
 	struct elf dummy_elf = {};
 
-
-	objname = _objname;
-
 	elf_version(EV_CURRENT);
 
-	fd = open(objname, O_RDONLY);
+	fd = open(filename, O_RDONLY);
 	if (fd == -1) {
 		perror("open");
 		return -1;
-- 
2.48.1


