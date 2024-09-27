Return-Path: <linux-kernel+bounces-342137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667B988AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65EA1F2419F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC31C4616;
	Fri, 27 Sep 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ptTL+7Cx"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A711C3F39
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466663; cv=none; b=clnwtD2bD7kAfMnWy8VfwUb5YhWIcVhy7cdYHuOYBVFL6dMC8eVxrOugOFeZoU6AJyMIWRblzTreESARJbZpLmhMXJdEtvxwTlnOrF9yuN4DcqmrlJWD+BNmcNBqRsJ332Wx6085k7Z/2f//2yeIChnY0Xi42WJD1SXayEMEsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466663; c=relaxed/simple;
	bh=NVm/025w8faWRZl4j6He/bJwsRYRrGpoESgWPtfeBLY=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UYhm35g8W+OzzRUb4RY8FkTnaIopnQfQbB3eQjr6y1ZkDA7sf4DtSdwoczLtF7YorBbARKdcW9/pmtM+nGO5IfN+fMxdaadLxB0uAC/hSoKBFpJ2gXOBpBFr26+7i9Nv1Su4Twn6qKPo6JavU5C01Pna+mA/XPPwF+j+GNDQAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ptTL+7Cx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=TGYcIgm/NfsHCXx6/jnmfMThkiwjCScFwzdD18YngiQ=; b=ptTL+7CxYX4kgbtUONjtSSdjpX
	xteWt78pbrBoBP2DQBEwMOYdfcNPIE+F57bVYpDC2FlIuKHTxAX1gFD+rDQOBKhhayszhY/YApZKO
	sWp4HygnedMOPW7nlAr3NplETJKLz9zSv7+rqLomr/wujtFZn1kV4pzPasE/KhS4o6a+BXBQpGIq8
	ajli2WncZBo+jBQQsNbcHPJ2nRP+DzhqtH1TuRCye4nf6eZk4AQ/RyLEENTZO7K+lWQz+w2Ixd27R
	mvCWcIJJ65eZcO7XsevGQ7I/ChnamFY9Qi5uznZVnqgE4xxgR7AgmAPOW0GdSI0P2lEkw2k1IY140
	jpNg5GbA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzF-00000002Onk-3zdX;
	Fri, 27 Sep 2024 19:50:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B728D30114C; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194924.730517860@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com
Subject: [PATCH 04/14] objtool/x86: Add .tail_call_sites
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to allow rewriting all direct (tail) calls to ENDBR to go +4, also
generate a tail-call sites section.

This must be different from the .call_sites, because call depth tracking
specifically cares about the CALL instruction, but not JMP instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/vmlinux.lds.S           |    9 ++++-
 tools/objtool/check.c                   |   52 +++++++++++++++++++++++++++++---
 tools/objtool/include/objtool/objtool.h |    1 
 tools/objtool/objtool.c                 |    1 
 4 files changed, 58 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -285,6 +285,7 @@ SECTIONS
 		*(.return_sites)
 		__return_sites_end = .;
 	}
+#endif
 
 	. = ALIGN(8);
 	.call_sites : AT(ADDR(.call_sites) - LOAD_OFFSET) {
@@ -292,7 +293,13 @@ SECTIONS
 		*(.call_sites)
 		__call_sites_end = .;
 	}
-#endif
+
+	. = ALIGN(8);
+	.tail_call_sites : AT(ADDR(.tail_call_sites) - LOAD_OFFSET) {
+		__tail_call_sites = .;
+		*(.tail_call_sites)
+		__tail_call_sites_end = .;
+	}
 
 #ifdef CONFIG_X86_KERNEL_IBT
 	. = ALIGN(8);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -893,7 +893,6 @@ static int create_cfi_sections(struct ob
 
 	sec = find_section_by_name(file->elf, ".cfi_sites");
 	if (sec) {
-		INIT_LIST_HEAD(&file->call_list);
 		WARN("file already has .cfi_sites section, skipping");
 		return 0;
 	}
@@ -1018,6 +1017,45 @@ static int create_direct_call_sections(s
 	return 0;
 }
 
+static int create_direct_tail_call_sections(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".tail_call_sites");
+	if (sec) {
+		INIT_LIST_HEAD(&file->tail_call_list);
+		WARN("file already has .tail_call_sites section, skipping");
+		return 0;
+	}
+
+	if (list_empty(&file->tail_call_list))
+		return 0;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->tail_call_list, call_node)
+		idx++;
+
+	sec = elf_create_section_pair(file->elf, ".tail_call_sites",
+				      sizeof(unsigned int), idx, idx);
+	if (!sec)
+		return -1;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->tail_call_list, call_node) {
+
+		if (!elf_init_reloc_text_sym(file->elf, sec,
+					     idx * sizeof(unsigned int), idx,
+					     insn->sec, insn->offset))
+			return -1;
+
+		idx++;
+	}
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -1417,9 +1455,12 @@ static void annotate_call_site(struct ob
 		return;
 	}
 
-	if (insn->type == INSN_CALL && !insn->sec->init &&
-	    !insn->_call_dest->embedded_insn)
-		list_add_tail(&insn->call_node, &file->call_list);
+	if (!insn->sec->init && !insn->_call_dest->embedded_insn) {
+		if (insn->type == INSN_CALL)
+			list_add_tail(&insn->call_node, &file->call_list);
+		else
+			list_add_tail(&insn->call_node, &file->tail_call_list);
+	}
 
 	if (!sibling && dead_end_function(file, sym))
 		insn->dead_end = true;
@@ -4802,6 +4843,9 @@ int check(struct objtool_file *file)
 			ret = create_direct_call_sections(file);
 			if (ret < 0)
 				goto out;
+			ret = create_direct_tail_call_sections(file);
+			if (ret < 0)
+				goto out;
 			warnings += ret;
 		}
 	}
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -28,6 +28,7 @@ struct objtool_file {
 	struct list_head mcount_loc_list;
 	struct list_head endbr_list;
 	struct list_head call_list;
+	struct list_head tail_call_list;
 	bool ignore_unreachables, hints, rodata;
 
 	unsigned int nr_endbr;
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -106,6 +106,7 @@ struct objtool_file *objtool_open_read(c
 	INIT_LIST_HEAD(&file.mcount_loc_list);
 	INIT_LIST_HEAD(&file.endbr_list);
 	INIT_LIST_HEAD(&file.call_list);
+	INIT_LIST_HEAD(&file.tail_call_list);
 	file.ignore_unreachables = opts.no_unreachable;
 	file.hints = false;
 



