Return-Path: <linux-kernel+bounces-562029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D5A61AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735F67AC623
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D1420E027;
	Fri, 14 Mar 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUJXPXLt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740920C48F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980573; cv=none; b=gbFuMsCj2G3NCbfMycmG/EvXzsItjYrWpBH5gw3tuWwTL2z/zPm+w9nwZ4E/JoGcGRoYStB8Z5Vf+FxDcjmLWeJhrGQHKoLdkYFIUk2Lm15qDDRBAkMQJEhRwDVyHysNrwielwE3SzsZGa5UWwYFvy/TdGAuMpxUbQfa/dI8N6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980573; c=relaxed/simple;
	bh=9nv1OxK1s2FTQoqzonluNC3zr/QvLG9y28cu2p9xJRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tx44vStHNg9oyy3R+OD8XFbabr1MLXcgZ8WZcdyQ69nUiTgitjQXwTDb8HUMP2BUQUmQutk0qoQRFdoCT6X2urx0FO66RN5He9PL9eq/tvww/m+ny7aIduiLyssL8mIaw0KeSfzOrRXswgleYq0QEgW9/Eu+6vJAViFsoxTRFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUJXPXLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9ABC4CEF4;
	Fri, 14 Mar 2025 19:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980573;
	bh=9nv1OxK1s2FTQoqzonluNC3zr/QvLG9y28cu2p9xJRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUJXPXLtG6G7QOf5GvZsXLbN2IjW5phKl0hB0JRX2sJoRIEH8Sd/dvMsEDGAXBT6p
	 TqqsP/8CdtL3wa7J0tjJZd8NYzBuYU8eQ8afRjv2CnV7yF5dutEuvTfORgHhC9G376
	 ItLqEWuF6hpoSSRxfUoQOWWjn/QqVmyvKYxnBEklO8mUfAtMtnXzcE9CYuO6ZvM3J+
	 tvojP9z+yeZV/BuGgdTdxEeazl62iQIzfXxsITNuvn18T7+lz0/wMnEzXHvp6m94ov
	 fzkHycg59T7Q1aqvpBY3ULbxaqYfVvJuHinGNv3RNsFbwlksu3+T9W0oQ034C5zyKT
	 CdqUwPN2E5liQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 12/13] objtool: Create backup on error and print args
Date: Fri, 14 Mar 2025 12:29:10 -0700
Message-ID: <7571e30636359b3e173ce6e122419452bb31882f.1741975349.git.jpoimboe@kernel.org>
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

Recreating objtool errors can be a manual process.  Kbuild removes the
object, so it has to be compiled or linked again before running objtool.
Then the objtool args need to be reversed engineered.

Make that all easier by automatically making a backup of the object file
on error, and print a modified version of the args which can be used to
recreate.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c           | 68 +++++++++++++++++++++++--
 tools/objtool/include/objtool/builtin.h |  1 -
 tools/objtool/objtool.c                 | 63 -----------------------
 3 files changed, 65 insertions(+), 67 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c201650efe49..39ddca64cb58 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -91,7 +91,6 @@ static const struct option check_options[] = {
 
 	OPT_GROUP("Options:"),
 	OPT_BOOLEAN(0,   "backtrace", &opts.backtrace, "unwind on error"),
-	OPT_BOOLEAN(0,   "backup", &opts.backup, "create .orig files before modification"),
 	OPT_BOOLEAN(0,   "dry-run", &opts.dryrun, "don't write modifications"),
 	OPT_BOOLEAN(0,   "link", &opts.link, "object is a linked object"),
 	OPT_BOOLEAN(0,   "module", &opts.module, "object is part of a kernel module"),
@@ -228,10 +227,39 @@ static int copy_file(const char *src, const char *dst)
 	return 0;
 }
 
+static char **save_argv(int argc, const char **argv)
+{
+	char **orig_argv;
+
+	orig_argv = calloc(argc, sizeof(char *));
+	if (!orig_argv) {
+		perror("calloc");
+		return NULL;
+	}
+
+	for (int i = 0; i < argc; i++) {
+		orig_argv[i] = strdup(argv[i]);
+		if (!orig_argv[i]) {
+			perror("strdup");
+			return NULL;
+		}
+	};
+
+	return orig_argv;
+}
+
+#define ORIG_SUFFIX ".orig"
+
 int objtool_run(int argc, const char **argv)
 {
 	struct objtool_file *file;
-	int ret;
+	char *backup = NULL;
+	char **orig_argv;
+	int ret = 0;
+
+	orig_argv = save_argv(argc, argv);
+	if (!orig_argv)
+		return 1;
 
 	cmd_parse_options(argc, argv, check_usage);
 
@@ -271,8 +299,42 @@ int objtool_run(int argc, const char **argv)
 	return 0;
 
 err:
-	if (opts.output)
+	if (opts.dryrun)
+		goto err_msg;
+
+	if (opts.output) {
 		unlink(opts.output);
+		goto err_msg;
+	}
+
+	/*
+	 * Make a backup before kbuild deletes the file so the error
+	 * can be recreated without recompiling or relinking.
+	 */
+	backup = malloc(strlen(objname) + strlen(ORIG_SUFFIX) + 1);
+	if (!backup) {
+		perror("malloc");
+		return 1;
+	}
+
+	strcpy(backup, objname);
+	strcat(backup, ORIG_SUFFIX);
+	if (copy_file(objname, backup))
+		return 1;
+
+err_msg:
+	fprintf(stderr, "%s", orig_argv[0]);
+
+	for (int i = 1; i < argc; i++) {
+		char *arg = orig_argv[i];
+
+		if (backup && !strcmp(arg, objname))
+			fprintf(stderr, " %s -o %s", backup, objname);
+		else
+			fprintf(stderr, " %s", arg);
+	}
+
+	fprintf(stderr, "\n");
 
 	return 1;
 }
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index b18f114cdaa4..0fafd0f7a209 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -29,7 +29,6 @@ struct opts {
 
 	/* options: */
 	bool backtrace;
-	bool backup;
 	bool dryrun;
 	bool link;
 	bool mnop;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 53cd881c6b95..1c73fb62fd57 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -20,64 +20,6 @@ bool help;
 
 static struct objtool_file file;
 
-static bool objtool_create_backup(const char *_objname)
-{
-	int len = strlen(_objname);
-	char *buf, *base, *name = malloc(len+6);
-	int s, d, l, t;
-
-	if (!name) {
-		perror("failed backup name malloc");
-		return false;
-	}
-
-	strcpy(name, _objname);
-	strcpy(name + len, ".orig");
-
-	d = open(name, O_CREAT|O_WRONLY|O_TRUNC, 0644);
-	if (d < 0) {
-		perror("failed to create backup file");
-		return false;
-	}
-
-	s = open(_objname, O_RDONLY);
-	if (s < 0) {
-		perror("failed to open orig file");
-		return false;
-	}
-
-	buf = malloc(4096);
-	if (!buf) {
-		perror("failed backup data malloc");
-		return false;
-	}
-
-	while ((l = read(s, buf, 4096)) > 0) {
-		base = buf;
-		do {
-			t = write(d, base, l);
-			if (t < 0) {
-				perror("failed backup write");
-				return false;
-			}
-			base += t;
-			l -= t;
-		} while (l);
-	}
-
-	if (l < 0) {
-		perror("failed backup read");
-		return false;
-	}
-
-	free(name);
-	free(buf);
-	close(d);
-	close(s);
-
-	return true;
-}
-
 struct objtool_file *objtool_open_read(const char *filename)
 {
 	if (file.elf) {
@@ -89,11 +31,6 @@ struct objtool_file *objtool_open_read(const char *filename)
 	if (!file.elf)
 		return NULL;
 
-	if (opts.backup && !objtool_create_backup(objname)) {
-		WARN("can't create backup file");
-		return NULL;
-	}
-
 	hash_init(file.insn_hash);
 	INIT_LIST_HEAD(&file.retpoline_call_list);
 	INIT_LIST_HEAD(&file.return_thunk_list);
-- 
2.48.1


