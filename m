Return-Path: <linux-kernel+bounces-418911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A89D671A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9293AB22757
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC97916C854;
	Sat, 23 Nov 2024 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRXr4y/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E917E110
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732326749; cv=none; b=uFeXWixrzJUEEgk6HvCqkmyFwJYVkpjf9Gh1GHZ9yBJt8g9UZh/oLs4bxjdagu1f7SkEpzodBce1OZC9R9ZwtYzmMIBMBh+3ludgfQmK2J8mQKad4yHv87NMQn0EtJ56/BnHAnrVDl003TWpqPquSDDbNDWwXhULn+PiGAWUcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732326749; c=relaxed/simple;
	bh=kCKLCTtzvXMxGVC1AQNQNxZ1f5M/Pqa2iWzkX60XYMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivEtABT0WsCX50rRZAFc+FcOa/SHrTMiDyUWlEFgy0TiWnNAcAy/GT0M+kiaFoKDP6g7WeJjS2hZ93d2IIjceDMWC/MHYQ4Tk4t+us+Zh+qRrTFNHw4NzL1N8Kj4dgn+Gw+OEw/CjSjX5AzCjKF+kz6Koh++W3d/Bcyd60kVYVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRXr4y/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8F9C4CED6;
	Sat, 23 Nov 2024 01:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732326749;
	bh=kCKLCTtzvXMxGVC1AQNQNxZ1f5M/Pqa2iWzkX60XYMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRXr4y/JlxoBAX7aX43D3fy0riPOxUVVabobn6w0PeGgjR07zj1hN21+oJ9jksa6d
	 LvD96+D4638WYe8BlUgq+CvGTyZM7LOHNEeji89VBRZNDMN8JqvRrNZxEcrxiRaqNI
	 M7ZCB2nGlLg05lkdDdsMGv+vZCrmytf91zqmfvDlAcSxoedg2vT6zxY4LPnSv/CZ+9
	 geCvymrK6FT2eSYvuUenrOHKKwE1JkOuAbvVTlcVOe+Bw6vHIcNGqi0ktKoCRfdt0s
	 nU+yPwQxNYuPHTHml6fuwxAoV+JRCv5mUNJO45+qN9pEqePPBuzsj6cEuIxCR1C5oD
	 1F2Zl3+jS6lzw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/3] objtool: Add noinstr validation for static branches/calls
Date: Fri, 22 Nov 2024 17:52:22 -0800
Message-ID: <b5746646456eb030673cdb62c23d69ed83c2702a.1732326588.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732326588.git.jpoimboe@kernel.org>
References: <cover.1732326588.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Warn about static branches/calls in noinstr regions, unless the
corresponding key is RO-after-init or has been manually whitelisted with
DEFINE_STATIC_KEY_*_NOINSTR(().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/jump_label.h              | 16 +++--
 include/linux/objtool.h                 |  6 ++
 include/linux/static_call.h             |  2 +
 tools/objtool/Documentation/objtool.txt | 34 +++++++++
 tools/objtool/check.c                   | 92 ++++++++++++++++++++++---
 tools/objtool/include/objtool/check.h   |  1 +
 tools/objtool/include/objtool/elf.h     |  1 +
 tools/objtool/include/objtool/special.h |  1 +
 tools/objtool/special.c                 | 20 +++++-
 9 files changed, 155 insertions(+), 18 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 88bb6e32fdcb..eb3e118accc4 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -373,8 +373,9 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_TRUE(name)	\
 	struct static_key_true name = STATIC_KEY_TRUE_INIT
 
-#define DEFINE_STATIC_KEY_TRUE_RO(name)	\
-	struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT
+#define DEFINE_STATIC_KEY_TRUE_RO(name)						\
+	struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT;	\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 #define DECLARE_STATIC_KEY_TRUE(name)	\
 	extern struct static_key_true name
@@ -382,8 +383,9 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_FALSE(name)	\
 	struct static_key_false name = STATIC_KEY_FALSE_INIT
 
-#define DEFINE_STATIC_KEY_FALSE_RO(name)	\
-	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT
+#define DEFINE_STATIC_KEY_FALSE_RO(name)					\
+	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT;	\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 /*
  * The _NOINSTR variants are used to tell objtool the static key is allowed to
@@ -397,10 +399,12 @@ struct static_key_false {
  * definition with the rationale.
  */
 #define DEFINE_STATIC_KEY_TRUE_NOINSTR(name)					\
-	DEFINE_STATIC_KEY_TRUE(name)
+	DEFINE_STATIC_KEY_TRUE(name);						\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 #define DEFINE_STATIC_KEY_FALSE_NOINSTR(name)					\
-	DEFINE_STATIC_KEY_FALSE(name)
+	DEFINE_STATIC_KEY_FALSE(name);						\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 #define DECLARE_STATIC_KEY_FALSE(name)	\
 	extern struct static_key_false name
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index b3b8d3dab52d..53de92666c48 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -34,6 +34,12 @@
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+#define __ANNOTATE_NOINSTR_ALLOWED(key) \
+	static void __used __section(".discard.noinstr_allowed") \
+		*__annotate_noinstr_allowed_##key = &key
+
+#define ANNOTATE_NOINSTR_ALLOWED(key) __ANNOTATE_NOINSTR_ALLOWED(key)
+
 /*
  * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
  * for the case where a function is intentionally missing frame pointer setup,
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 34970e178fdf..a82d0bd7860d 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -196,6 +196,7 @@ extern long __static_call_return0(void);
 		.func = _func,						\
 		.type = 1,						\
 	};								\
+	ANNOTATE_NOINSTR_ALLOWED(STATIC_CALL_TRAMP(name));		\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
@@ -212,6 +213,7 @@ extern long __static_call_return0(void);
 		.func = NULL,						\
 		.type = 1,						\
 	};								\
+	ANNOTATE_NOINSTR_ALLOWED(STATIC_CALL_TRAMP(name));		\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 7c3ee959b63c..922d3b41541d 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -447,6 +447,40 @@ the objtool maintainers.
    names and does not use module_init() / module_exit() macros to create
    them.
 
+13. file.o: warning: func()+0x2a: key: non-RO static key usage in noinstr code
+    file.o: warning: func()+0x2a: key: non-RO static call usage in noinstr code
+
+  This means that noinstr function func() uses a static key or
+  static call named 'key' which can be modified at runtime.  This is
+  discouraged because it prevents code patching IPIs from being
+  deferred.
+
+  You have the following options:
+
+  1) Check whether the static key/call in question is only modified
+     during init.  If so, define it as read-only-after-init with
+     DEFINE_STATIC_KEY_*_RO() or DEFINE_STATIC_CALL_RO().
+
+  2) Avoid the runtime patching.  For static keys this can be done by
+     using static_key_enabled() or by getting rid of the static key
+     altogether if performance is not a concern.
+
+     For static calls, something like the following could be done:
+
+       target = static_call_query(foo);
+       if (target == func1)
+	       func1();
+	else if (target == func2)
+		func2();
+	...
+
+  3) Silence the warning by defining the static key/call with
+     DEFINE_STATIC_*_NOINSTR().  This decision should not
+     be taken lightly as it may result in code patching IPIs getting
+     sent to isolated NOHZ_FULL CPUs running in pure userspace.  A
+     comment should be added above the definition explaining the
+     rationale for the decision.
+
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7fc96c30b79c..225a075bc79e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1068,6 +1068,45 @@ static int create_direct_call_sections(struct objtool_file *file)
 	return 0;
 }
 
+static int read_noinstr_allowed(struct objtool_file *file)
+{
+	struct section *rsec;
+	struct symbol *sym;
+	struct reloc *reloc;
+
+	rsec = find_section_by_name(file->elf, ".rela.discard.noinstr_allowed");
+	if (!rsec)
+		return 0;
+
+	for_each_reloc(rsec, reloc) {
+		switch (reloc->sym->type) {
+		case STT_OBJECT:
+		case STT_FUNC:
+			sym = reloc->sym;
+			break;
+
+		case STT_SECTION:
+			sym = find_symbol_by_offset(reloc->sym->sec,
+						    reloc_addend(reloc));
+			if (!sym) {
+				WARN_FUNC("can't find static key/call symbol",
+					  reloc->sym->sec, reloc_addend(reloc));
+				return -1;
+			}
+			break;
+
+		default:
+			WARN("unexpected relocation symbol type in %s: %d",
+			     rsec->name, reloc->sym->type);
+			return -1;
+		}
+
+		sym->noinstr_allowed = 1;
+	}
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -1955,6 +1994,8 @@ static int handle_jump_alt(struct objtool_file *file,
 		return -1;
 	}
 
+	orig_insn->key = special_alt->key;
+
 	if (opts.hack_jump_label && special_alt->key_addend & 2) {
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
@@ -2731,6 +2772,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_noinstr_allowed(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -3494,9 +3539,9 @@ static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
 	return file->pv_ops[idx].clean;
 }
 
-static inline bool noinstr_call_dest(struct objtool_file *file,
-				     struct instruction *insn,
-				     struct symbol *func)
+static inline bool noinstr_call_allowed(struct objtool_file *file,
+					struct instruction *insn,
+					struct symbol *func)
 {
 	/*
 	 * We can't deal with indirect function calls at present;
@@ -3516,10 +3561,10 @@ static inline bool noinstr_call_dest(struct objtool_file *file,
 		return true;
 
 	/*
-	 * If the symbol is a static_call trampoline, we can't tell.
+	 * Only DEFINE_STATIC_CALL_*_RO allowed.
 	 */
 	if (func->static_call_tramp)
-		return true;
+		return func->noinstr_allowed;
 
 	/*
 	 * The __ubsan_handle_*() calls are like WARN(), they only happen when
@@ -3532,14 +3577,29 @@ static inline bool noinstr_call_dest(struct objtool_file *file,
 	return false;
 }
 
+static char *static_call_name(struct symbol *func)
+{
+	return func->name + strlen("__SCT__");
+}
+
 static int validate_call(struct objtool_file *file,
 			 struct instruction *insn,
 			 struct insn_state *state)
 {
-	if (state->noinstr && state->instr <= 0 &&
-	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
-		WARN_INSN(insn, "call to %s() leaves .noinstr.text section", call_dest_name(insn));
-		return 1;
+	if (state->noinstr && state->instr <= 0) {
+		struct symbol *dest = insn_call_dest(insn);
+
+		if (dest->static_call_tramp) {
+			if (!dest->noinstr_allowed) {
+				WARN_INSN(insn, "non-RO static call usage for '%s' in noinstr",
+					  static_call_name(dest));
+			}
+
+		} else if (!noinstr_call_allowed(file, insn, dest)) {
+			WARN_INSN(insn, "call to %s() leaves .noinstr.text section",
+				  call_dest_name(insn));
+			return 1;
+		}
 	}
 
 	if (state->uaccess && !func_uaccess_safe(insn_call_dest(insn))) {
@@ -3602,6 +3662,17 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 	return 0;
 }
 
+static int validate_static_key(struct instruction *insn, struct insn_state *state)
+{
+	if (state->noinstr && state->instr <= 0 && !insn->key->noinstr_allowed) {
+		WARN_INSN(insn, "non-RO static key usage for '%s' in noinstr",
+			  insn->key->name);
+		return 1;
+	}
+
+	return 0;
+}
+
 static struct instruction *next_insn_to_validate(struct objtool_file *file,
 						 struct instruction *insn)
 {
@@ -3763,6 +3834,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (handle_insn_ops(insn, next_insn, &state))
 			return 1;
 
+		if (insn->key)
+			validate_static_key(insn, &state);
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index daa46f1f0965..c0da7246eac7 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -77,6 +77,7 @@ struct instruction {
 	struct symbol *sym;
 	struct stack_op *stack_ops;
 	struct cfi_state *cfi;
+	struct symbol *key;
 };
 
 static inline struct symbol *insn_func(struct instruction *insn)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index d7e815c2fd15..0cb79931262b 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -69,6 +69,7 @@ struct symbol {
 	u8 embedded_insn     : 1;
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
+	u8 noinstr_allowed   : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 86d4af9c5aa9..ce4759358ec4 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -20,6 +20,7 @@ struct special_alt {
 	bool skip_alt;
 	bool jump_or_nop;
 	u8 key_addend;
+	struct symbol *key;
 
 	struct section *orig_sec;
 	unsigned long orig_off;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 097a69db82a0..d0a9cca27a9c 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -119,14 +119,28 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 
 	if (entry->key) {
 		struct reloc *key_reloc;
+		struct symbol *key;
+		s64 key_addend;
 
 		key_reloc = find_reloc_by_dest(elf, sec, offset + entry->key);
 		if (!key_reloc) {
-			WARN_FUNC("can't find key reloc",
-				  sec, offset + entry->key);
+			WARN_FUNC("can't find key reloc", sec, offset + entry->key);
 			return -1;
 		}
-		alt->key_addend = reloc_addend(key_reloc);
+
+		key = key_reloc->sym;
+		key_addend = reloc_addend(key_reloc);
+
+		if (key->type == STT_SECTION)
+			key = find_symbol_by_offset(key->sec, key_addend & ~3);
+
+		if (!key) {
+			WARN_FUNC("can't find key sym", sec, offset + entry->key);
+			return -1;
+		}
+
+		alt->key = key;
+		alt->key_addend = key_addend;
 	}
 
 	return 0;
-- 
2.47.0


