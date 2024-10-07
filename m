Return-Path: <linux-kernel+bounces-353014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF4B992747
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16A41C22A66
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823618C92D;
	Mon,  7 Oct 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h/gz3C67"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C0218C010
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290392; cv=none; b=ai2cKD4L9RGM15322Kba4oNOJ72/sjer7dbmDoMNW49Gl9kdySNOZLqZi9Linf0jhhrAp6HHXtwLJR8kbQIEMCH0qyLBQlqKxXn5TvsE+c3zV8Rg0X+/bQ6cOCGPZQ/m9ZJRz4qK4wFfkAg6blhkvBDtmd4OKt28lpFNBAAASFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290392; c=relaxed/simple;
	bh=Cpxk5Im5ngM99DexiGUWT69kPu1oQ83W2z1L0o3ev80=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oByTpxws/EZcnEyv0bOKsi4GDqIPB8/dPz+fHJ9a42GD8oPaAAvauzo6sjvOtHQZID0ZSIzAEEmhuPI06Lemy3KeomPHqv8ciIS+nnIkThZBpQApg+UrgYgMliXLW4rXSc5kXp5hKFfETfrGAkckrjc75fvk77YawMVsS+cYVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h/gz3C67; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=W/DmNCV4/IlgXq8PShr2+w7xcmnCVM2NAjS4XwHJ5yY=; b=h/gz3C67iG1+2hhXyG5P6wooM3
	tZgPorNyghsZzmWQ1gAmsBgprmyKkcmyKwREh65nP3LXJ8cYkrkPvSKXSocFgWheAIur6DBSIrRkr
	gOGWfqiDoxeu0pozIjE6b/VqkQ8mdWPUhAo2LyQxFzxsfYMu3mdvdbR+0GQIk/pS02kPcY6l93D0H
	UP3h07b7P51pw336tUL+RJPnehFes2X3lrKgTmpmSQN+o8kjdfw2spp7fPR+6g8PAxPG9dQfSuMu/
	B1TM/vvr5T97m6KdUELkL6TuQKLOjg4YIOVGwCWVe4n/g4yP7ZgQBJoFvcXIJ/YXV1MlEEX5pCv0h
	lzV4tRHA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxjHN-0000000H0Wg-1PkR;
	Mon, 07 Oct 2024 08:39:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E0A3B300ABE; Mon,  7 Oct 2024 10:39:44 +0200 (CEST)
Message-Id: <20241007083844.013379820@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 07 Oct 2024 10:32:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: bp@alien8.de,
 david.kaplan@amd.com,
 jpoimboe@redhat.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 x86@kernel.org
Subject: [RFC][PATCH 1/2] x86: Provide assembly __bug_table helpers
References: <20241007083210.043925135@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Rework the __bug_table helpers such that usage from assembly becomes
possible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h |   50 ++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -28,46 +28,38 @@
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
-# define __BUG_REL(val)	".long " __stringify(val)
+#define ASM_BUG_REL(val)	.long val
 #else
-# define __BUG_REL(val)	".long " __stringify(val) " - ."
+#define ASM_BUG_REL(val)	.long val - .
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+#define ASM_BUGTABLE_VERBOSE(file, line)				\
+	ASM_BUG_REL(file) ;						\
+	.word line
+#define ASM_BUGTABLE_VERBOSE_SIZE	6
+#else
+#define ASM_BUGTABLE_VERBOSE(file, line)
+#define ASM_BUGTABLE_VERBOSE_SIZE	0
+#endif
 
-#define _BUG_FLAGS(ins, flags, extra)					\
-do {									\
-	asm_inline volatile("1:\t" ins "\n"				\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
-		     "\t.word %c1"        "\t# bug_entry::line\n"	\
-		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c3\n"					\
-		     ".popsection\n"					\
-		     extra						\
-		     : : "i" (__FILE__), "i" (__LINE__),		\
-			 "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
-} while (0)
-
-#else /* !CONFIG_DEBUG_BUGVERBOSE */
+#define ASM_BUGTABLE_FLAGS(at, file, line, flags)			\
+	.pushsection __bug_table, "aw" ;				\
+	123:	ASM_BUG_REL(at) ;					\
+	ASM_BUGTABLE_VERBOSE(file, line) ;				\
+	.word	flags ;							\
+	.org 123b + 6 + ASM_BUGTABLE_VERBOSE_SIZE ;			\
+	.popsection
 
 #define _BUG_FLAGS(ins, flags, extra)					\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c1\n"					\
-		     ".popsection\n"					\
-		     extra						\
-		     : : "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
+	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c0, %c1, %c2)) "\n"	\
+			    extra					\
+		     : : "i" (__FILE__), "i" (__LINE__),		\
+			 "i" (flags));					\
 } while (0)
 
-#endif /* CONFIG_DEBUG_BUGVERBOSE */
-
 #else
 
 #define _BUG_FLAGS(ins, flags, extra)  asm volatile(ins)



