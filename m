Return-Path: <linux-kernel+bounces-574488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ACEA6E5F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C753D3A738D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EDB1EE013;
	Mon, 24 Mar 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUwquHef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D538E1EB9EB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853382; cv=none; b=BICKBE8hmSKRaxDFocnwrxwddFzXSQSDZPElswduknd51jiH2B7onrLNFVyQKZ8vr14B6Wlv0SdWBKq9GbGf4ei4PBzrIRR2IeUwEbK/WF7vYTYgHkddQM+rnFyeoNksfz4Z8uzpIzCPe6s+jtc0xVFcTkonsbq9wAFt469ahB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853382; c=relaxed/simple;
	bh=fpWm/Nk43t3S1gA82488yS7GvdJhsQzb0TugYk58/dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpLvVZUme+0ZPQ83HfKFtu/aHRHpEgpG5h9V8JLJftq9FyqY7Y5dB+664k1R3oGOMFIjzH+SIQmDOI0O3+br7GOwBjcnuNsMfvLLzwwK1fjZVk9e1tkWgg84kjk9YEsXkNnO+qJWJPOmxFDPRu8/nQtzN/r1W08K3Ryw7Vhjt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUwquHef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC0FC4CEEF;
	Mon, 24 Mar 2025 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853382;
	bh=fpWm/Nk43t3S1gA82488yS7GvdJhsQzb0TugYk58/dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUwquHefWWoIZTUoHru8lrAlvTN1fEKsh7+YHGyIml/xuYyVcEzzc+RDJjPs/NQwa
	 Rr9DoHaFlLJJCF+9V6ocW0Zqai430abMYPzRZW8Gmi9AerTcZJ6jer5/uVk2AQu6vC
	 55HQTMzVaJAmcqsxVW4Ei5sz7PxIRLLyOqUMxE337+x57E4M+OqcxxJXZQz5OUqIh0
	 KXFIfi5trX0i8VAz/l2qH3EWy/LBciDu3Pem1GZbdbqJEkmkWzcIIxbMFumXWqBO4l
	 27c0He77ZTBRREmL7FpBL9q4zcUYTi4jjNZ+pBudHo7jMIf+E7tiFDWm6Sz2zuJ1DA
	 m1K7h0ltL44QQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 03/22] objtool: Ignore entire functions rather than instructions
Date: Mon, 24 Mar 2025 14:55:53 -0700
Message-ID: <4af13376567f83331a9372ae2bb25e11a3d0f055.1742852846.git.jpoimboe@kernel.org>
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

STACK_FRAME_NON_STANDARD applies to functions.  Use a function-specific
ignore attribute in preparation for getting rid of insn->ignore.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 35 +++++++++++++++--------------
 tools/objtool/include/objtool/elf.h |  1 +
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 33beefd459a6..8e2f3405d78c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -981,7 +981,6 @@ static int create_direct_call_sections(struct objtool_file *file)
  */
 static void add_ignores(struct objtool_file *file)
 {
-	struct instruction *insn;
 	struct section *rsec;
 	struct symbol *func;
 	struct reloc *reloc;
@@ -1008,8 +1007,7 @@ static void add_ignores(struct objtool_file *file)
 			continue;
 		}
 
-		func_for_each_insn(file, func, insn)
-			insn->ignore = true;
+		func->ignore = true;
 	}
 }
 
@@ -1620,6 +1618,7 @@ static int add_call_destinations(struct objtool_file *file)
 	struct reloc *reloc;
 
 	for_each_insn(file, insn) {
+		struct symbol *func = insn_func(insn);
 		if (insn->type != INSN_CALL)
 			continue;
 
@@ -1630,7 +1629,7 @@ static int add_call_destinations(struct objtool_file *file)
 
 			add_call_dest(file, insn, dest, false);
 
-			if (insn->ignore)
+			if (func && func->ignore)
 				continue;
 
 			if (!insn_call_dest(insn)) {
@@ -1638,7 +1637,7 @@ static int add_call_destinations(struct objtool_file *file)
 				return -1;
 			}
 
-			if (insn_func(insn) && insn_call_dest(insn)->type != STT_FUNC) {
+			if (func && insn_call_dest(insn)->type != STT_FUNC) {
 				WARN_INSN(insn, "unsupported call to non-function");
 				return -1;
 			}
@@ -3478,6 +3477,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	u8 visited;
 	int ret;
 
+	if (func && func->ignore)
+		return 0;
+
 	sec = insn->sec;
 
 	while (1) {
@@ -3723,7 +3725,7 @@ static int validate_unwind_hint(struct objtool_file *file,
 				  struct instruction *insn,
 				  struct insn_state *state)
 {
-	if (insn->hint && !insn->visited && !insn->ignore) {
+	if (insn->hint && !insn->visited) {
 		int ret = validate_branch(file, insn_func(insn), insn, *state);
 		if (ret)
 			BT_INSN(insn, "<=== (hint)");
@@ -3937,10 +3939,11 @@ static bool is_ubsan_insn(struct instruction *insn)
 
 static bool ignore_unreachable_insn(struct objtool_file *file, struct instruction *insn)
 {
-	int i;
+	struct symbol *func = insn_func(insn);
 	struct instruction *prev_insn;
+	int i;
 
-	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP)
+	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP || (func && func->ignore))
 		return true;
 
 	/*
@@ -3959,7 +3962,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	 * In this case we'll find a piece of code (whole function) that is not
 	 * covered by a !section symbol. Ignore them.
 	 */
-	if (opts.link && !insn_func(insn)) {
+	if (opts.link && !func) {
 		int size = find_symbol_hole_containing(insn->sec, insn->offset);
 		unsigned long end = insn->offset + size;
 
@@ -3985,19 +3988,17 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 			 */
 			if (insn->jump_dest && insn_func(insn->jump_dest) &&
 			    strstr(insn_func(insn->jump_dest)->name, ".cold")) {
-				struct instruction *dest = insn->jump_dest;
-				func_for_each_insn(file, insn_func(dest), dest)
-					dest->ignore = true;
+				insn_func(insn->jump_dest)->ignore = true;
 			}
 		}
 
 		return false;
 	}
 
-	if (!insn_func(insn))
+	if (!func)
 		return false;
 
-	if (insn_func(insn)->static_call_tramp)
+	if (func->static_call_tramp)
 		return true;
 
 	/*
@@ -4028,7 +4029,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 
 		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
 			if (insn->jump_dest &&
-			    insn_func(insn->jump_dest) == insn_func(insn)) {
+			    insn_func(insn->jump_dest) == func) {
 				insn = insn->jump_dest;
 				continue;
 			}
@@ -4036,7 +4037,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 			break;
 		}
 
-		if (insn->offset + insn->len >= insn_func(insn)->offset + insn_func(insn)->len)
+		if (insn->offset + insn->len >= func->offset + func->len)
 			break;
 
 		insn = next_insn_same_sec(file, insn);
@@ -4128,7 +4129,7 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 		return 0;
 
 	insn = find_insn(file, sec, sym->offset);
-	if (!insn || insn->ignore || insn->visited)
+	if (!insn || insn->visited)
 		return 0;
 
 	state->uaccess = sym->uaccess_safe;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 4edc957a6f6b..eba04392c6fd 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -68,6 +68,7 @@ struct symbol {
 	u8 embedded_insn     : 1;
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
+	u8 ignore	     : 1;
 	u8 warnings	     : 2;
 	struct list_head pv_target;
 	struct reloc *relocs;
-- 
2.48.1


