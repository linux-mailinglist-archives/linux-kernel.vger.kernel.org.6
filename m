Return-Path: <linux-kernel+bounces-361540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5063899A983
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5A81F21C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A6C1C6F59;
	Fri, 11 Oct 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIFY2t62"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7A1C4610
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666552; cv=none; b=SG18wJJyHeMa07orZ6Ev3AGGe0CslDQnhtdAiVHlOAacIfaSO6YBUuVBQWN86ZGwCE8UiYqgwiGflCnWPWmA5opdku0RmzVUruZxnqL47/5lfZhqMPAlEf919x5QPsXdQc8Um7R9r5JIpRGTLqrvhLg/Ht5mdwIh5Om/53S9hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666552; c=relaxed/simple;
	bh=VUujYBiQvSszgV0qs3fJK1Hvr5k7z7tzS0djEyuvxZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lJXm1IvJQm5RrVP3WYRyEMJ5Y54G9bfoej2Le3STEpvwFwSHFlZoQoJVKS7XXyYTPvx5R3FD4ngiz0GqPutaQYCr7AaUg/pnSLGOzGegO/h1FEf+D64eqXfs9DLFaVICopM7Ko5nT4IR6q3YK/f++XhmATTq+MaPK8oRj7r098E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIFY2t62; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-431207426e3so3512685e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666549; x=1729271349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfj0B3nnHjUxcCyCalhugd5ngmM/JrZzfePhPsFLeh4=;
        b=vIFY2t62Kfu9sD1TJtD3E5c4RPwLlZA/U+7yY5NfJhMwZlWqcT9jQRfMBnfpb+pjGg
         voO+yx8Em89gfalkzcJRLCWQC3WsUHGzLxLod9w0Tm1GEOyBxjP2Nk2TPwLlMaE2ZQo2
         X/4si/pDbdI4gzEm2rpjSO0c2MyLMhmmwZluMD7TRqJ3Ia6kncF4Ciu2sTl52sBV0dYz
         Zn8diq3+bald2w7c/7SMa501mLH0rZUd9w4n+ttrZoLNLNtSpeuXyyOdqaRPa6P+e9lq
         eXQ4HfLGNXWmEf4mVktMAPrBeRs8pTcE/nbvAh9v1eKnNaCUeNx5ZCJYbU3buOMDPL3r
         oh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666549; x=1729271349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfj0B3nnHjUxcCyCalhugd5ngmM/JrZzfePhPsFLeh4=;
        b=Meem3kqTVnnZpxNNJ/+gzW7s92uVRlKrlCKSqwq/owwQmB8XgCUET4v8qMVYTT00vm
         c/N/cI7iE6vDwhywuLTcwwr6kkIf7FhnyzNVNI5hr/ly0n2zDqVfXJZXv1SY9Iqf/PN7
         j6Uki3hFn2yhMWE+nLmBCYDF/Q+1dlArVNU/miJT6CA2LYcC0NcyA98Ttf8KPcp1fdQe
         QOcLYhSMJBDmjJm8c3Eqf4/B1RmjFFk9NAAd2ZmX8ppwUBUtNoMSCijAwzZzi1KyurBh
         +0QJVX+NyA4KphfoWjBetEzmynJ5XDaGI3UN6qTYTd7CdX4YofHyZPocEnKvSHTrgW74
         DbqQ==
X-Gm-Message-State: AOJu0YwnGt1Qgvn7cmWkmZ7Uaw/m+K/z5DvItyo7EHv9TP715ec2E7Jc
	9o+lTDksxpRd2eGncgrygryG+9yANzED7b12Hgo/yi5qTZHPSzSzKZOIxzfgnxXjnD+XbPqTw5k
	RvGEiytqsJGkGnwfveY7F2letpd+e/5eMgeCgRqR7vbfvwFGQQ34RiRRv9n2FR35SqI+CLYzLBl
	zf7jQMcIevy+wSjOL6ysHY0HPKSY0tvw==
X-Google-Smtp-Source: AGHT+IFvX/saq2RUfGzHvn3Yuhv8T3E5DzVonOGZChHXCjZPWicr/2IaSFuxMZRFRkaqCDpZgMyInJz/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5d:6890:0:b0:374:badf:9b16 with SMTP id
 ffacd0b85a97d-37d54de7715mr5662f8f.0.1728666548505; Fri, 11 Oct 2024 10:09:08
 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:08:50 +0200
In-Reply-To: <20241011170847.334429-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011170847.334429-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6898; i=ardb@kernel.org;
 h=from:subject; bh=2jvHADU7c8PNtY41id5iwZpe+A4RE0tCIX4zDl/IOwI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0zevGeuTemSKv5/VnNF3SJkT37m5jGny9B0qcX3hCdy
 FY1fcO/jlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR2tMM/wteCl2WXp4vrqrU
 8/PM1Tu7eE0Ka+2OVWe/PrexdoZEgQ3DP7MzGyWTi0uENn70OL9B8qPnx/4X27Z1bYtzXq58O1l YjB8A
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011170847.334429-12-ardb+git@google.com>
Subject: [PATCH v3 2/8] objtool: Allow arch code to discover jump table size
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
index aa07fdf1cf13..b73e43b9b9e3 100644
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
index 86d4af9c5aa9..e7ee7ffccefd 100644
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
2.47.0.rc1.288.g06298d1525-goog


