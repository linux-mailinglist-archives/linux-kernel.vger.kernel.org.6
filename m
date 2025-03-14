Return-Path: <linux-kernel+bounces-562018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D1DA61A98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7808A463939
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AFF207A15;
	Fri, 14 Mar 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO2Gv+dq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C292066D3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980569; cv=none; b=faiuIAI73XHHEce4RCPZcsgv4oIMpEAkpavCWrrsEOvR0q0Q2aZ4lkA+qUJIxyTWk0Fi50JMAseLWn0GYR1hWEl2+EaFXi1quowhXd2k5qQCTGM86WbaQ/K93oJn6tjwvCgwGc+8aVfwBYjVUfdvdZBfEH82mWn3jkq5NY8uoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980569; c=relaxed/simple;
	bh=hYgMEAw5PslVkJ+AsTy0iKOBz7QcQIybK/ajB1gRwYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5ZR1zuzw7ItUpBk/547BCWvJKT4Be2gFvhc6d38d1z925p9NThRgTay1wMX7rtDysOg58It1dLY7XWaleiwptaSAp0VVxhRpPeu83kI3nLOYPEXqIIPEt7PrvCdcfunURLdrNoG+nsB4fBCxkwSlUbDKdf0nVBOc0LIlZeilnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO2Gv+dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B824EC4AF54;
	Fri, 14 Mar 2025 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980569;
	bh=hYgMEAw5PslVkJ+AsTy0iKOBz7QcQIybK/ajB1gRwYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vO2Gv+dqJcgTOdhfxNDT5TmgwVkxozC8FpRDZeWV8z32xkI+o7nkn7H41AXcRp8ij
	 4gcdkHwi4rNHJLLMmWXBoDQM36s4GmvfGl3YZ6+gxvmVCw5b8YKfY2aEc0t/XzjqO+
	 Oc7GEwzQdXnjSYPGpC+Od0sqbwRE9x5lIKhMJT1GH87Yf9oNcCS+TrJ23PkOU4rsAY
	 sSUeZc6qKyDMRDaRf7hW6Sw+TNF/CIdOj1aCQGJU3vsqZnfwWOCe2KQXsmOkyzrpkU
	 3MTz5fedwxmnunXDDthl8yO6f+6T3iJWlI0enx8joGEEMRqDzfHJ3T+WTQR6jH8Mq1
	 qlr5VTMD0hfLg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 01/13] x86/traps: Make exc_double_fault() consistently noreturn
Date: Fri, 14 Mar 2025 12:28:59 -0700
Message-ID: <d1f4026f8dc35d0de6cc61f2684e0cb6484009d1.1741975349.git.jpoimboe@kernel.org>
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

The CONFIG_X86_ESPFIX64 version of exc_double_fault() can return to its
caller, but the !CONFIG_X86_ESPFIX64 version never does.  In the latter
case the compiler and/or objtool may consider it to be implicitly
noreturn.

However, due to the currently inflexible way objtool detects noreturns,
a function's noreturn status needs to be consistent across configs.

The current workaround for this issue is to suppress unreachable
warnings for exc_double_fault()'s callers.  Unfortunately that can
result in ORC coverage gaps and potentially worse issues like inert
static calls and silently disabled CPU mitigations.

Instead, prevent exc_double_fault() from ever being implicitly marked
noreturn by forcing a return behind a never-taken conditional.

Until a more integrated noreturn detection method exists, this is likely
the least objectionable workaround.

Fixes: 55eeab2a8a11 ("objtool: Ignore exc_double_fault() __noreturn warnings")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/traps.c | 18 +++++++++++++++++-
 tools/objtool/check.c   | 31 +------------------------------
 2 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f4263cb3d21e..9f88b8a78e50 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -461,6 +461,21 @@ __visible void __noreturn handle_stack_overflow(struct pt_regs *regs,
 }
 #endif
 
+/*
+ * Prevent the compiler and/or objtool from marking the !CONFIG_X86_ESPFIX64
+ * version of exc_double_fault() as noreturn.  Otherwise the noreturn mismatch
+ * between configs triggers objtool warnings.
+ *
+ * This is a temporary hack until we have compiler or plugin support for
+ * annotating noreturns.
+ */
+#ifdef CONFIG_X86_ESPFIX64
+#define always_true() true
+#else
+bool always_true(void);
+bool __weak always_true(void) { return true; }
+#endif
+
 /*
  * Runs on an IST stack for x86_64 and on a special task stack for x86_32.
  *
@@ -596,7 +611,8 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 
 	pr_emerg("PANIC: double fault, error_code: 0x%lx\n", error_code);
 	die("double fault", regs, error_code);
-	panic("Machine halted.");
+	if (always_true())
+		panic("Machine halted.");
 	instrumentation_end();
 }
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 814d40724069..3a3a1a905199 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4441,35 +4441,6 @@ static int validate_sls(struct objtool_file *file)
 	return warnings;
 }
 
-static bool ignore_noreturn_call(struct instruction *insn)
-{
-	struct symbol *call_dest = insn_call_dest(insn);
-
-	/*
-	 * FIXME: hack, we need a real noreturn solution
-	 *
-	 * Problem is, exc_double_fault() may or may not return, depending on
-	 * whether CONFIG_X86_ESPFIX64 is set.  But objtool has no visibility
-	 * to the kernel config.
-	 *
-	 * Other potential ways to fix it:
-	 *
-	 *   - have compiler communicate __noreturn functions somehow
-	 *   - remove CONFIG_X86_ESPFIX64
-	 *   - read the .config file
-	 *   - add a cmdline option
-	 *   - create a generic objtool annotation format (vs a bunch of custom
-	 *     formats) and annotate it
-	 */
-	if (!strcmp(call_dest->name, "exc_double_fault")) {
-		/* prevent further unreachable warnings for the caller */
-		insn->sym->warned = 1;
-		return true;
-	}
-
-	return false;
-}
-
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn, *prev_insn;
@@ -4486,7 +4457,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		prev_insn = prev_insn_same_sec(file, insn);
 		if (prev_insn && prev_insn->dead_end) {
 			call_dest = insn_call_dest(prev_insn);
-			if (call_dest && !ignore_noreturn_call(prev_insn)) {
+			if (call_dest) {
 				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
 					  call_dest->name);
 				warnings++;
-- 
2.48.1


