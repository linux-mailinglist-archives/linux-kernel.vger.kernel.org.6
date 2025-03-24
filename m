Return-Path: <linux-kernel+bounces-574486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BF2A6E5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A383A65F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110A31EC012;
	Mon, 24 Mar 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK7+/llM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0C1E8351
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853382; cv=none; b=oo+C1pvKqEjRAbUP9mejD7HHQPosh+mJwzTa9qTzuf0Wy8NSFU2WdKuvMz5U3B+ctTicGSae6OTQpriShJ+jXULP+ekxpk/ZP9fdAdjFBdfgm0ZUc99aAVDL35etot6EQ2HQ8Zzx9AvHRSkQz/mUJDOm11CWuWjNRVlsPTpBhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853382; c=relaxed/simple;
	bh=/n+9+BkPcWQMa+ukZQtgWSkqXbptBcXwS6cgabiGf/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJ/jje0LdKwdAupFTSuKuNuo3oehR/0qIt0D0adnW0gAuZJISJHbRSN6ZZUCDZtL+KtwLSJmwebxFE7bwGOAgWavrERTiGuKvzB3OlgEhWP/u3MEMf+Jv14QvYmxtHIqXJ6VEVLxitAx2hP8vIRyj6tN4tAESazqb3HuTolVW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK7+/llM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834EDC4CEF0;
	Mon, 24 Mar 2025 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853381;
	bh=/n+9+BkPcWQMa+ukZQtgWSkqXbptBcXwS6cgabiGf/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tK7+/llM1V9H5hAwcPrKx1q6JLDqTJu9Ppw1isme8so9wxXRuIirvvHS1pOtV0tLJ
	 OFFv91WWSWgV4ATt82QjCiW+1+t+M6G44QmrJOEWJfJNWXbV4ig6gM7KPayL1tH6vB
	 prUIJTzWfWeWW4INjpoMnDcZ4D838ar8MbCMkOe6IuDDr6b/4SHxJOvFDdaMof7I+q
	 5ejJmbXnrOluU3Mqj7r//S2oiIjDwbOu/vaHPZdCyEWT56EtsG3niNjwv68kpNdKDl
	 VtHH7g0HRs7qRsosvh5/pjBXUCHYwhsxb8WqO9+CmESOUhgYIePIvVyeaiBr2HiQPK
	 WIrGC2qyrM1cw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 01/22] objtool: Fix detection of consecutive jump tables
Date: Mon, 24 Mar 2025 14:55:51 -0700
Message-ID: <141752fff614eab962dba6bdfaa54aa67ff03bba.1742852846.git.jpoimboe@kernel.org>
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

The jump table detection code assumes jump tables are in the same order
as their corresponding indirect branches.  That's apparently not always
true with Clang 20.

Fix that by changing how multiple jump tables are detected.  In the
first detection pass, mark the beginning of each jump table so the
second pass can tell where one ends and the next one begins.

Fixes the following warnings:

  vmlinux.o: warning: objtool: SiS_GetCRT2Ptr+0x1ad: stack state mismatch: cfa1=4+8 cfa2=5+16
  sound/core/seq/snd-seq.o: warning: objtool: cc_ev_to_ump_midi2+0x589: return with modified stack frame

Fixes: be2f0b1e1264 ("objtool: Get rid of reloc->jump_table_start")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503171547.LlCTJLQL-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202503200535.J3hAvcjw-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 26 ++++++++------------------
 tools/objtool/elf.c                 |  6 +++---
 tools/objtool/include/objtool/elf.h | 27 ++++++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 48d7bc5b4736..33beefd459a6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1949,8 +1949,7 @@ __weak unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct relo
 	return reloc->sym->offset + reloc_addend(reloc);
 }
 
-static int add_jump_table(struct objtool_file *file, struct instruction *insn,
-			  struct reloc *next_table)
+static int add_jump_table(struct objtool_file *file, struct instruction *insn)
 {
 	unsigned long table_size = insn_jump_table_size(insn);
 	struct symbol *pfunc = insn_func(insn)->pfunc;
@@ -1970,7 +1969,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		/* Check for the end of the table: */
 		if (table_size && reloc_offset(reloc) - reloc_offset(table) >= table_size)
 			break;
-		if (reloc != table && reloc == next_table)
+		if (reloc != table && is_jump_table(reloc))
 			break;
 
 		/* Make sure the table entries are consecutive: */
@@ -2061,8 +2060,10 @@ static void find_jump_table(struct objtool_file *file, struct symbol *func,
 		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
 
+		set_jump_table(table_reloc);
 		orig_insn->_jump_table = table_reloc;
 		orig_insn->_jump_table_size = table_size;
+
 		break;
 	}
 }
@@ -2104,31 +2105,20 @@ static void mark_func_jump_tables(struct objtool_file *file,
 static int add_func_jump_tables(struct objtool_file *file,
 				  struct symbol *func)
 {
-	struct instruction *insn, *insn_t1 = NULL, *insn_t2;
-	int ret = 0;
+	struct instruction *insn;
+	int ret;
 
 	func_for_each_insn(file, func, insn) {
 		if (!insn_jump_table(insn))
 			continue;
 
-		if (!insn_t1) {
-			insn_t1 = insn;
-			continue;
-		}
 
-		insn_t2 = insn;
-
-		ret = add_jump_table(file, insn_t1, insn_jump_table(insn_t2));
+		ret = add_jump_table(file, insn);
 		if (ret)
 			return ret;
-
-		insn_t1 = insn_t2;
 	}
 
-	if (insn_t1)
-		ret = add_jump_table(file, insn_t1, NULL);
-
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index be4f4b62730c..0f38167bd840 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -583,7 +583,7 @@ static int elf_update_sym_relocs(struct elf *elf, struct symbol *sym)
 {
 	struct reloc *reloc;
 
-	for (reloc = sym->relocs; reloc; reloc = reloc->sym_next_reloc)
+	for (reloc = sym->relocs; reloc; reloc = sym_next_reloc(reloc))
 		set_reloc_sym(elf, reloc, reloc->sym->idx);
 
 	return 0;
@@ -880,7 +880,7 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 	set_reloc_addend(elf, reloc, addend);
 
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
-	reloc->sym_next_reloc = sym->relocs;
+	set_sym_next_reloc(reloc, sym->relocs);
 	sym->relocs = reloc;
 
 	return reloc;
@@ -979,7 +979,7 @@ static int read_relocs(struct elf *elf)
 			}
 
 			elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
-			reloc->sym_next_reloc = sym->relocs;
+			set_sym_next_reloc(reloc, sym->relocs);
 			sym->relocs = reloc;
 
 			nr_reloc++;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 223ac1c24b90..4edc957a6f6b 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -77,7 +77,7 @@ struct reloc {
 	struct elf_hash_node hash;
 	struct section *sec;
 	struct symbol *sym;
-	struct reloc *sym_next_reloc;
+	unsigned long _sym_next_reloc;
 };
 
 struct elf {
@@ -297,6 +297,31 @@ static inline void set_reloc_type(struct elf *elf, struct reloc *reloc, unsigned
 	mark_sec_changed(elf, reloc->sec, true);
 }
 
+#define RELOC_JUMP_TABLE_BIT 1UL
+
+/* Does reloc mark the beginning of a jump table? */
+static inline bool is_jump_table(struct reloc *reloc)
+{
+	return reloc->_sym_next_reloc & RELOC_JUMP_TABLE_BIT;
+}
+
+static inline void set_jump_table(struct reloc *reloc)
+{
+	reloc->_sym_next_reloc |= RELOC_JUMP_TABLE_BIT;
+}
+
+static inline struct reloc *sym_next_reloc(struct reloc *reloc)
+{
+	return (struct reloc *)(reloc->_sym_next_reloc & ~RELOC_JUMP_TABLE_BIT);
+}
+
+static inline void set_sym_next_reloc(struct reloc *reloc, struct reloc *next)
+{
+	unsigned long bit = reloc->_sym_next_reloc & RELOC_JUMP_TABLE_BIT;
+
+	reloc->_sym_next_reloc = (unsigned long)next | bit;
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
-- 
2.48.1


