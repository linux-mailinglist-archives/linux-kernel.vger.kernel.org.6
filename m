Return-Path: <linux-kernel+bounces-418210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240649D5EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BA3B259E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711A1DEFCF;
	Fri, 22 Nov 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LWfx/+/c"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7B18B466
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277811; cv=none; b=Ko9bwO/HsxspA0gH2+0oKNdaNu1a26A4RCugttDPJdlG3OwZU6T8thsUMweQWbTGEwYqFCaMHEEiPjUEieKxpetoWRrza3sz6gd9KZVgIbCQz6wB+UQoWUHK0pl65Snjby4q63UrBeaXsLR08Uy6pzWdyS8wk0SG0rludz27PTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277811; c=relaxed/simple;
	bh=3EViGVtiv5ZKDg5nuZD7B+Kiri68iPzlBDpVXHwHSbg=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BHZmaSQ0XIlQeBaD9rKPzp5kvBs8KPH+PIJ3x8KyiSfchwSedX3QgowdV6wp2UuqSyFzrTrUI598Ro1Obbx/SA1/HZfYEml2n/4pmLxUyQmF5+8cGij4A3tKjNFsMwDLRg7E6yIgLifN5u+9Tx3+5gqCd28IYPp1QgqTHiyGToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LWfx/+/c; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=5k6+52P5B35R+WjAC8g6iI0mXf3jovg2NbzDOJS2H5A=; b=LWfx/+/cFneSYXFOTYcMRWchyJ
	ZAYJV0plOZjNhQ/gXekpDmMSiwS25B/fMhlgPjqhfRW4uRI0NZ1Boy7YnJN+XZHaHCY4zcjHOatYp
	UwDTaQSKQ4HjrDVDHxCaz97UZitmvK/hk/UkHtH2FqteIuTmE2Dscndq4oZnedm+2Lml85rmBAWh6
	2SiI16MvY4M7z6RDkE3kowM3JBQj99UBX/A7GRGHoGbNCk8X6xMrhECBmgSWk+mzSedwteRRt9FXb
	i+VNqaKlRRdHRUxoH8edwqoFwsp+F7q0Si9naszzqyJckaLhIwbyjw9c5pThnyPlwIHu7WZbbalsd
	xIYAQPDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESae-00000000hao-0CFX;
	Fri, 22 Nov 2024 12:16:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DD3C7300E95; Fri, 22 Nov 2024 13:16:46 +0100 (CET)
Message-Id: <20241122121555.621070802@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 22 Nov 2024 13:10:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 1/9] objtool: Generic annotation infrastructure
References: <20241122121016.372005127@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Avoid endless .discard.foo sections for each annotation, create a
single .discard.annotate section that takes an annotation type along
with the instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/objtool.h |   18 ++++++++++++++++++
 tools/objtool/check.c   |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -57,6 +57,13 @@
 	".long 998b\n\t"						\
 	".popsection\n\t"
 
+#define ASM_ANNOTATE(x)						\
+	"911:\n\t"						\
+	".pushsection .discard.annotate,\"M\",@progbits,8\n\t"	\
+	".long 911b - .\n\t"					\
+	".long " __stringify(x) "\n\t"				\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -146,6 +153,14 @@
 	.popsection
 .endm
 
+.macro ANNOTATE type:req
+.Lhere_\@:
+	.pushsection .discard.annotate,"M",@progbits,8
+	.long	.Lhere_\@ - .
+	.long	\type
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_OBJTOOL */
@@ -155,6 +170,7 @@
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal) "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
+#define ASM_ANNOTATE(x)
 #define ANNOTATE_NOENDBR
 #define ASM_REACHABLE
 #else
@@ -167,6 +183,8 @@
 .endm
 .macro REACHABLE
 .endm
+.macro ANNOTATE type:req
+.endm
 #endif
 
 #endif /* CONFIG_OBJTOOL */
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2373,6 +2373,49 @@ static int read_unwind_hints(struct objt
 	return 0;
 }
 
+static int read_annotate(struct objtool_file *file, void (*func)(int type, struct instruction *insn))
+{
+	struct section *sec;
+	struct instruction *insn;
+	struct reloc *reloc;
+	int type;
+
+	sec = find_section_by_name(file->elf, ".discard.annotate");
+	if (!sec)
+		return 0;
+
+	if (!sec->rsec)
+		return 0;
+
+	if (sec->sh.sh_entsize != 8) {
+		static bool warned = false;
+		if (!warned) {
+			WARN("%s: dodgy linker, sh_entsize != 8", sec->name);
+			warned = true;
+		}
+		sec->sh.sh_entsize = 8;
+	}
+
+	for_each_reloc(sec->rsec, reloc) {
+		type = *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsize) + 4);
+
+		insn = find_insn(file, reloc->sym->sec,
+				 reloc->sym->offset + reloc_addend(reloc));
+		if (!insn) {
+			WARN("bad .discard.annotate entry: %d of type %d", reloc_idx(reloc), type);
+			return -1;
+		}
+
+		func(type, insn);
+	}
+
+	return 0;
+}
+
+static void __annotate_nop(int type, struct instruction *insn)
+{
+}
+
 static int read_noendbr_hints(struct objtool_file *file)
 {
 	struct instruction *insn;
@@ -2670,6 +2713,8 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	read_annotate(file, __annotate_nop);
+
 	/*
 	 * Must be before read_unwind_hints() since that needs insn->noendbr.
 	 */



