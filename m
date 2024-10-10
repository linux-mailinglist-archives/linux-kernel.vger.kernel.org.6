Return-Path: <linux-kernel+bounces-358974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30069985EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFB8B22F16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AB51C6F49;
	Thu, 10 Oct 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ihjNd+z"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92E1C6885
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563301; cv=none; b=qotkZW5fHI7DAcp2ZhxF+1K4LAMNbh9uZ76gHvb/dfi48ARCuQi/JbJW9t3WH6B39FhLNzEL5S17M8WBDGEQhjYXNg5vd96qXq5v+NdUqRoMDgVQNkrrX7/0jZFV24fTeSZcO1fkC5cETtVp0Nc324oh301nD3AKPBCKbFPuSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563301; c=relaxed/simple;
	bh=XueFKKJfNv5S62FTI6Nn6miZHSnizhT2/a1kRTz+4zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EXspukqJB2vno4RsDWrnYgTk9RUXVF5x0oLd2ew/aloq6GFISJhyEBtADvslVkPkqvN018vKQlOdeYk4aaBRO773JIi4q7ziKwX/UJgpoW6Z9SzQSWuu7CSXeAzPHdDq5Cvl6O1fp3N37TGCztpWERxiMx29sSejxiahKMnVoSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ihjNd+z; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2913beeddaso167410276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563298; x=1729168098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1h9fFvgBUeRFx9Aotl4DWJObQ4kxzCBME+ifVsDcAJM=;
        b=1ihjNd+z74nFSturzSj7XH1Tw+nKvFIoGap1tnOK+WhOoAoFdyqMnkIXO4Cmkkwy8t
         oShAUJfRB7PgHaPzUGyfdQzdMD+Vdfe7NZcOoJNyc/Y4orl0ShlLlVyqnR7sarDbHk3i
         MXmGQYtZweYJbUscdluVuNm/zBz7wrHGnxa89bAyz/zeE0/gBQB9mcyzf9vL0lqRX929
         NjYoAErCq37sUmLbZ1/gP0BscLRPU4iufPaGL7bORrn7FAzomA1RvfoV/AbMjho/xHfu
         83pVQ9AwWCRpvf/CWec5EZEILOGwv5scc28aHeU9aCBKUEvgSQUqtfTIRYnt+PpVl3Wd
         hsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563298; x=1729168098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1h9fFvgBUeRFx9Aotl4DWJObQ4kxzCBME+ifVsDcAJM=;
        b=hJ4udxajY0Cah3N995LAVrGQSGgPrKU2pLXI/yMrsBzpGDzGLQWXkp+z2IzRZz8vj/
         yrR5jU11DFd73u+0uvqT6905s05rmFyz+bg+5jwlQg2NJYt5NKXjFQFQQfdOxIwJ/B86
         jbamAaUjmfECIkT4PVXOSWnhJsFy9ipqzG1Sr8OsRBmV4pIzP26nCzcHekvrhKGSJ+Sl
         jZDfLkIYnh+iJBG2A+Qv+rPNWXRRpNdd/84zomrcrEXo8pp9yy0309fkTtOS0gcESeeA
         hVDOb0lyjthEepBELW8MduQt+NTz+Pi9+Gg/+h7pAb4VPoBP0GM1cs8EItGRLnSBzlHi
         dSGA==
X-Gm-Message-State: AOJu0YwGCrh2ckHxK8MCje29FSnm6j45QSFHXtVwcE9oGWmWK9r+yNoe
	Ur+fP9/6aRENZ00nls2y3Y5pxDaFJn/qyZndiMLWTJDUFwlXVnDjabzOfv82YK4otcY0s1JcmCl
	DaxhghKhmD/rftnNlcl5YpjJEp6q/4R260iJXDht9BUUfR+ktj+ZRFeFEj/zkwhLDo8HP2NWEJd
	76hA3pms3+/9gYCen0YrMFcHZwx1mTxw==
X-Google-Smtp-Source: AGHT+IE9TBQHDn81ejkh1rw2v+XDC+2cpXnc7DsPnWjm4u6sifCrO6OF2c5NoEQ7evGC5PCEb3uoSlO6
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:6902:2d02:b0:e29:2a3:ad7f with SMTP id
 3f1490d57ef6-e290b5afe99mr42880276.1.1728563298554; Thu, 10 Oct 2024 05:28:18
 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:28:04 +0200
In-Reply-To: <20241010122801.1321976-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6898; i=ardb@kernel.org;
 h=from:subject; bh=jlstyuRGCsVkoeHTvHTTSvfyzwb2vzkKg7m++dSyEtY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ39RKg1x/mChKdFy6Q2BvjdbTARsDHbn87dG1siXWud8
 plB9H1HKQuDGAeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmEiRACPDapENBTc1fXP4/bbW
 cf7M+7RlVUPXE2vNrrSTr69mzAveysjQ4b4s0PydpdP075/X7/ffkfNyRsnsezZLI9o/pc6pvOP ICAA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241010122801.1321976-9-ardb+git@google.com>
Subject: [PATCH v2 2/5] objtool: Allow arch code to discover jump table size
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for adding support for annotated jump tables, where
ELF relocations and symbols are used to describe the locations of jump
tables in the executable, refactor the jump table discovery logic so the
table size can be returned from arch_find_switch_table().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/arch/loongarch/special.c  |  3 +-
 tools/objtool/arch/powerpc/special.c    |  3 +-
 tools/objtool/arch/x86/special.c        |  4 ++-
 tools/objtool/check.c                   | 31 +++++++++++++-------
 tools/objtool/include/objtool/check.h   |  5 +++-
 tools/objtool/include/objtool/special.h |  3 +-
 6 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
index 9bba1e9318e0..87230ed570fd 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -9,7 +9,8 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 }
 
 struct reloc *arch_find_switch_table(struct objtool_file *file,
-				     struct instruction *insn)
+				     struct instruction *insn,
+				     unsigned long *table_size)
 {
 	return NULL;
 }
diff --git a/tools/objtool/arch/powerpc/special.c b/tools/objtool/arch/powerpc/special.c
index d33868147196..51610689abf7 100644
--- a/tools/objtool/arch/powerpc/special.c
+++ b/tools/objtool/arch/powerpc/special.c
@@ -13,7 +13,8 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 }
 
 struct reloc *arch_find_switch_table(struct objtool_file *file,
-				    struct instruction *insn)
+				     struct instruction *insn,
+				     unsigned long *table_size)
 {
 	exit(-1);
 }
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 415e4d035e53..f8fb67636384 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -109,7 +109,8 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
  *    NOTE: MITIGATION_RETPOLINE made it harder still to decode dynamic jumps.
  */
 struct reloc *arch_find_switch_table(struct objtool_file *file,
-				    struct instruction *insn)
+				     struct instruction *insn,
+				     unsigned long *table_size)
 {
 	struct reloc  *text_reloc, *rodata_reloc;
 	struct section *table_sec;
@@ -150,5 +151,6 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	if (!rodata_reloc)
 		return NULL;
 
+	*table_size = 0;
 	return rodata_reloc;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7f7981a93535..5f711ac5b43d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -150,6 +150,15 @@ static inline struct reloc *insn_jump_table(struct instruction *insn)
 	return NULL;
 }
 
+static inline unsigned long insn_jump_table_size(struct instruction *insn)
+{
+	if (insn->type == INSN_JUMP_DYNAMIC ||
+	    insn->type == INSN_CALL_DYNAMIC)
+		return insn->_jump_table_size;
+
+	return 0;
+}
+
 static bool is_jump_table_jump(struct instruction *insn)
 {
 	struct alt_group *alt_group = insn->alt_group;
@@ -2099,6 +2108,7 @@ static int add_special_section_alts(struct objtool_file *file)
 static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			  struct reloc *next_table)
 {
+	unsigned long table_size = insn_jump_table_size(insn);
 	struct symbol *pfunc = insn_func(insn)->pfunc;
 	struct reloc *table = insn_jump_table(insn);
 	unsigned int rtype = reloc_type(table);
@@ -2116,6 +2126,8 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		unsigned long addend = reloc_addend(reloc);
 
 		/* Check for the end of the table: */
+		if (table_size && reloc_offset(reloc) - reloc_offset(table) >= table_size)
+			break;
 		if (reloc != table && reloc == next_table)
 			break;
 
@@ -2175,12 +2187,12 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
  * find_jump_table() - Given a dynamic jump, find the switch jump table
  * associated with it.
  */
-static struct reloc *find_jump_table(struct objtool_file *file,
-				      struct symbol *func,
-				      struct instruction *insn)
+static void find_jump_table(struct objtool_file *file, struct symbol *func,
+			    struct instruction *insn)
 {
 	struct reloc *table_reloc;
 	struct instruction *dest_insn, *orig_insn = insn;
+	unsigned long table_size;
 
 	/*
 	 * Backward search using the @first_jump_src links, these help avoid
@@ -2201,17 +2213,17 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 		     insn->jump_dest->offset > orig_insn->offset))
 		    break;
 
-		table_reloc = arch_find_switch_table(file, insn);
+		table_reloc = arch_find_switch_table(file, insn, &table_size);
 		if (!table_reloc)
 			continue;
 		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
 		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
 
-		return table_reloc;
+		orig_insn->_jump_table = table_reloc;
+		orig_insn->_jump_table_size = table_size;
+		break;
 	}
-
-	return NULL;
 }
 
 /*
@@ -2222,7 +2234,6 @@ static void mark_func_jump_tables(struct objtool_file *file,
 				    struct symbol *func)
 {
 	struct instruction *insn, *last = NULL;
-	struct reloc *reloc;
 
 	func_for_each_insn(file, func, insn) {
 		if (!last)
@@ -2245,9 +2256,7 @@ static void mark_func_jump_tables(struct objtool_file *file,
 		if (insn->type != INSN_JUMP_DYNAMIC)
 			continue;
 
-		reloc = find_jump_table(file, func, insn);
-		if (reloc)
-			insn->_jump_table = reloc;
+		find_jump_table(file, func, insn);
 	}
 }
 
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index daa46f1f0965..e1cd13cd28a3 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -71,7 +71,10 @@ struct instruction {
 	struct instruction *first_jump_src;
 	union {
 		struct symbol *_call_dest;
-		struct reloc *_jump_table;
+		struct {
+			struct reloc *_jump_table;
+			unsigned long _jump_table_size;
+		};
 	};
 	struct alternative *alts;
 	struct symbol *sym;
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 89ee12b1a138..e049679bb17b 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -38,5 +38,6 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc);
 struct reloc *arch_find_switch_table(struct objtool_file *file,
-				    struct instruction *insn);
+				     struct instruction *insn,
+				     unsigned long *table_size);
 #endif /* _SPECIAL_H */
-- 
2.47.0.rc0.187.ge670bccf7e-goog


