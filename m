Return-Path: <linux-kernel+bounces-574495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F8BA6E5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E57E1892C51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499791F2B8E;
	Mon, 24 Mar 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbyfRpV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E41F1518
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853386; cv=none; b=nG3q/fIs4oMNscKTgQs+5gDmJr7LTcnzJIgWqxOFqj2ZDQwR2X0Vpj3y58HjSLxlZHYbxcB+i69OSYSUqTEdFDhm4vlIs1S1bL0D/vtPQAqiehfNft9nswQ9PrxrO2vpoV3sRwfvu6Xe04c/9wF8UWML1sJVYkLvPrInwm0jp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853386; c=relaxed/simple;
	bh=vX8fmL90uhis5ZiSpKhMTL7v+LsPpwSsXhWLzlVfMuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQWzcN7hd1PbUVfjONJ69EuUVoyN8eRXn5Ja7zRUjRaIMQa3d6fzXo/CBwhv5Z/NvIij8ouBq17o0Rr5sW3d53f4Jaw2a5cbfBjP5lQ1BgU6Dc4ue5dsTCj8ey6F4d35nKxDLGKaQzXp9+RFm7wjQ71C4aRYDEaivnWTT8499dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbyfRpV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CE0C4CEEE;
	Mon, 24 Mar 2025 21:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853386;
	bh=vX8fmL90uhis5ZiSpKhMTL7v+LsPpwSsXhWLzlVfMuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbyfRpV78sLeFgsWrYWxVBxxoPB0MKLPFQPePh7S7EpaeWVP1tf1tHhErH87JFfw7
	 E7UQj4f8J3Er9Mx3Kjg44C2pgeyLoCScBlDrCDsG5p5PwQkG43Mw1/uPYkJBxg+9Ml
	 bEeOZA6nHNNchmqoVN1o6bee7oO3rA1ZC+O89YREk2sn9WbLjtlDJM6SRSZKBc0/v6
	 e3qAi1QY/TTC3hz3XuC13+g3RtOHlbZnkH1ts3vUBjVa57OsUn/bZJNLHpFvEgahx2
	 bseeaJ4lbARDyPpA3pR9Psk6W4yo+aDG1lPd8hI0WCddvpTxSp1W4RQjZMf/qvKQ8y
	 pKLCJcb4RPwKw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 10/22] objtool: Reduce CONFIG_OBJTOOL_WERROR verbosity
Date: Mon, 24 Mar 2025 14:56:00 -0700
Message-ID: <d61df69f64b396fa6b2a1335588aad7a34ea9e71.1742852846.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742852846.git.jpoimboe@kernel.org>
References: <cover.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the following from CONFIG_OBJTOOL_WERROR:

  * backtrace

  * "upgraded warnings to errors" message

  * cmdline args

This makes the default output less cluttered and makes it easier to spot
the actual warnings.  Note the above options are still are available
with --verbose or OBJTOOL_VERBOSE=1.

Also, do the cmdline arg printing on all warnings, regardless of werror.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/Makefile.lib                    |   2 +-
 tools/objtool/builtin-check.c           | 113 ++++++++++++------------
 tools/objtool/check.c                   |  23 ++---
 tools/objtool/include/objtool/builtin.h |   6 +-
 4 files changed, 73 insertions(+), 71 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 99e281966ba3..cdf45722626c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -277,7 +277,7 @@ objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
 objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
 objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
-objtool-args-$(CONFIG_OBJTOOL_WERROR)			+= --Werror --backtrace
+objtool-args-$(CONFIG_OBJTOOL_WERROR)			+= --Werror
 
 objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c973a751fb7d..2bdff910430e 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -15,8 +15,11 @@
 #include <objtool/objtool.h>
 #include <objtool/warn.h>
 
-const char *objname;
+#define ORIG_SUFFIX ".orig"
 
+int orig_argc;
+static char **orig_argv;
+const char *objname;
 struct opts opts;
 
 static const char * const check_usage[] = {
@@ -224,39 +227,73 @@ static int copy_file(const char *src, const char *dst)
 	return 0;
 }
 
-static char **save_argv(int argc, const char **argv)
+static void save_argv(int argc, const char **argv)
 {
-	char **orig_argv;
-
 	orig_argv = calloc(argc, sizeof(char *));
 	if (!orig_argv) {
 		WARN_GLIBC("calloc");
-		return NULL;
+		exit(1);
 	}
 
 	for (int i = 0; i < argc; i++) {
 		orig_argv[i] = strdup(argv[i]);
 		if (!orig_argv[i]) {
 			WARN_GLIBC("strdup(%s)", orig_argv[i]);
-			return NULL;
+			exit(1);
 		}
 	};
-
-	return orig_argv;
 }
 
-#define ORIG_SUFFIX ".orig"
+void print_args(void)
+{
+	char *backup = NULL;
+
+	if (opts.output || opts.dryrun)
+		goto print;
+
+	/*
+	 * Make a backup before kbuild deletes the file so the error
+	 * can be recreated without recompiling or relinking.
+	 */
+	backup = malloc(strlen(objname) + strlen(ORIG_SUFFIX) + 1);
+	if (!backup) {
+		WARN_GLIBC("malloc");
+		goto print;
+	}
+
+	strcpy(backup, objname);
+	strcat(backup, ORIG_SUFFIX);
+	if (copy_file(objname, backup)) {
+		backup = NULL;
+		goto print;
+	}
+
+print:
+	/*
+	 * Print the cmdline args to make it easier to recreate.  If '--output'
+	 * wasn't used, add it to the printed args with the backup as input.
+	 */
+	fprintf(stderr, "%s", orig_argv[0]);
+
+	for (int i = 1; i < orig_argc; i++) {
+		char *arg = orig_argv[i];
+
+		if (backup && !strcmp(arg, objname))
+			fprintf(stderr, " %s -o %s", backup, objname);
+		else
+			fprintf(stderr, " %s", arg);
+	}
+
+	fprintf(stderr, "\n");
+}
 
 int objtool_run(int argc, const char **argv)
 {
 	struct objtool_file *file;
-	char *backup = NULL;
-	char **orig_argv;
 	int ret = 0;
 
-	orig_argv = save_argv(argc, argv);
-	if (!orig_argv)
-		return 1;
+	orig_argc = argc;
+	save_argv(argc, argv);
 
 	cmd_parse_options(argc, argv, check_usage);
 
@@ -279,59 +316,19 @@ int objtool_run(int argc, const char **argv)
 
 	file = objtool_open_read(objname);
 	if (!file)
-		goto err;
+		return 1;
 
 	if (!opts.link && has_multiple_files(file->elf)) {
 		WARN("Linked object requires --link");
-		goto err;
+		return 1;
 	}
 
 	ret = check(file);
 	if (ret)
-		goto err;
+		return ret;
 
 	if (!opts.dryrun && file->elf->changed && elf_write(file->elf))
-		goto err;
+		return 1;
 
 	return 0;
-
-err:
-	if (opts.dryrun)
-		goto err_msg;
-
-	if (opts.output) {
-		unlink(opts.output);
-		goto err_msg;
-	}
-
-	/*
-	 * Make a backup before kbuild deletes the file so the error
-	 * can be recreated without recompiling or relinking.
-	 */
-	backup = malloc(strlen(objname) + strlen(ORIG_SUFFIX) + 1);
-	if (!backup) {
-		WARN_GLIBC("malloc");
-		return 1;
-	}
-
-	strcpy(backup, objname);
-	strcat(backup, ORIG_SUFFIX);
-	if (copy_file(objname, backup))
-		return 1;
-
-err_msg:
-	fprintf(stderr, "%s", orig_argv[0]);
-
-	for (int i = 1; i < argc; i++) {
-		char *arg = orig_argv[i];
-
-		if (backup && !strcmp(arg, objname))
-			fprintf(stderr, " %s -o %s", backup, objname);
-		else
-			fprintf(stderr, " %s", arg);
-	}
-
-	fprintf(stderr, "\n");
-
-	return 1;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fbe2a5ef2c40..03ec485a376a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4740,9 +4740,6 @@ int check(struct objtool_file *file)
 
 	free_insns(file);
 
-	if (opts.verbose)
-		disas_warned_funcs(file);
-
 	if (opts.stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
 		printf("nr_cfi: %ld\n", nr_cfi);
@@ -4751,19 +4748,25 @@ int check(struct objtool_file *file)
 	}
 
 out:
+	if (!ret && !warnings)
+		return 0;
+
+	if (opts.verbose) {
+		if (opts.werror && warnings)
+			WARN("%d warning(s) upgraded to errors", warnings);
+		print_args();
+		disas_warned_funcs(file);
+	}
+
 	/*
 	 * CONFIG_OBJTOOL_WERROR upgrades all warnings (and errors) to actual
 	 * errors.
 	 *
-	 * Note that even "fatal" type errors don't actually return an error
-	 * without CONFIG_OBJTOOL_WERROR.  That probably needs improved at some
-	 * point.
+	 * Note that even fatal errors don't yet actually return an error
+	 * without CONFIG_OBJTOOL_WERROR.  That will be fixed soon-ish.
 	 */
-	if (opts.werror && (ret || warnings)) {
-		if (warnings)
-			WARN("%d warning(s) upgraded to errors", warnings);
+	if (opts.werror)
 		return 1;
-	}
 
 	return 0;
 }
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 0fafd0f7a209..6b08666fa69d 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -43,8 +43,10 @@ struct opts {
 
 extern struct opts opts;
 
-extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
+int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
-extern int objtool_run(int argc, const char **argv);
+int objtool_run(int argc, const char **argv);
+
+void print_args(void);
 
 #endif /* _BUILTIN_H */
-- 
2.48.1


