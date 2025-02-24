Return-Path: <linux-kernel+bounces-529083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18139A41FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93F63A8F09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5B524889D;
	Mon, 24 Feb 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BMo6Ql1P"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFC2192EB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401163; cv=none; b=mdeO3/iRw4ySqGPydoFizFl13VSEiEoWmJN0CGin3F40tlRaJzd/gApuXwWkW0W4kuEfCoJPhF5BEYjglKVBXyRVepobC/caf2fBbZ3qtcqEejEbjHL/AsJAU2f25LH1mlqV1ran0Sj8KBO1oKK0TNLCfiE8xqauPoEpR+i8Vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401163; c=relaxed/simple;
	bh=Cf8HCTGmOx/qRDAOIVvByhVe67UrJTu9m54l6Wmgn8c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=c21MDLR0B2a16Gp1QwE+BWRrGtOl69UX9i6bYXH7hSqXQ5Y34CUZ4PqLDdxI7sDO3TTmKRPRqDlWSUcpic35U9rSaTHcbZBRFeHwmHIdytL6KshzeBWw4vdlsBFdfBE4X+7Rz6JwgZIbO7NQ0HmAlfU4hFeZBw1/IynHQSg0X14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BMo6Ql1P; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=EhQ12QSerGcZU41eLzZyyGD3alpvSewb0+Htu+1LdoA=; b=BMo6Ql1P1+eSr7GzOloLqd79f+
	Mk/REyJk/eAdyQDCYwNhTR18crPfKbkVlyon2879cFiTdCw1KlqGP6B7ljnOIG0Gtz1iVTH9diwNu
	GnZIeO97DGzysIQqNFJi+8cHKzjOdJENPAVBxXvC+ujP2DulYi+IVqVWEFfBeYM7iKaohMZtjLdeN
	AkF8cl8Obovhj/JSXKQY3eqGmfI8gDrc9vtdAlcrT4d66W3JHQADx7p6ZqBrTQ3EaCEFbDvhNWOjN
	Y/jD1WXoGVBjWXaw8jJ+IQxSIR7NdNIf7E5yTrfLqSRfAWrjojM141MAFOYEPbP/gq8etAyqWUomM
	7hMSpykw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXqM-00000003C2P-2CgY;
	Mon, 24 Feb 2025 12:45:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 14D3D30078F; Mon, 24 Feb 2025 13:45:54 +0100 (CET)
Message-ID: <20250224124159.924496481@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 24 Feb 2025 13:37:04 +0100
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
 alexei.starovoitov@gmail.com,
 mhiramat@kernel.org,
 jmill@asu.edu
Subject: [PATCH v4 01/10] x86/cfi: Add warn option
References: <20250224123703.843199044@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Rebuilding with CFI_PERMISSIVE toggled is such a pain, esp. since
clang is so slow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |    3 +++
 arch/x86/kernel/cfi.c         |    8 ++++----
 include/linux/cfi.h           |    2 ++
 kernel/cfi.c                  |    4 +++-
 4 files changed, 12 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1022,6 +1022,9 @@ static __init int cfi_parse_cmdline(char
 			cfi_mode = CFI_FINEIBT;
 		} else if (!strcmp(str, "norand")) {
 			cfi_rand = false;
+		} else if (!strcmp(str, "warn")) {
+			pr_alert("CFI mismatch non-fatal!\n");
+			cfi_warn = true;
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <asm/cfi.h>
 
+extern bool cfi_warn;
+
 #ifndef cfi_get_offset
 static inline int cfi_get_offset(void)
 {
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -7,6 +7,8 @@
 
 #include <linux/cfi.h>
 
+bool cfi_warn __ro_after_init = IS_ENABLED(CONFIG_CFI_PERMISSIVE);
+
 enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 				      unsigned long *target, u32 type)
 {
@@ -17,7 +19,7 @@ enum bug_trap_type report_cfi_failure(st
 		pr_err("CFI failure at %pS (no target information)\n",
 		       (void *)addr);
 
-	if (IS_ENABLED(CONFIG_CFI_PERMISSIVE)) {
+	if (cfi_warn) {
 		__warn(NULL, 0, (void *)addr, 0, regs, NULL);
 		return BUG_TRAP_TYPE_WARN;
 	}



