Return-Path: <linux-kernel+bounces-529085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34892A41FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52533AE530
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD69E24EF60;
	Mon, 24 Feb 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P9azl+wq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6423372A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401163; cv=none; b=JdDxTD/ymycn8eqr80joiAvWtgbl62DwZnZ7c03sUfxNQOrRL36t04AF60PI41louZm5i8AFzOlYON4tZt4W83XPtOfVT4JfW9dM0mAYycaJIEyExvKQ48Avapv6PCJVZ2EItMxj8IvlQShyNPYc7/GBfq+hl0BJR3DsL9zqkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401163; c=relaxed/simple;
	bh=qiHWEsUFhyrAhvzR/3W2KqNPPoF05MG34ACD4hT96GM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UJ6ffqP55UoZRBNSRXfdXqOe+sksGQ4UJ/1FFhIvFaGrVR2NGTWvb/YVjPiPKet8leg1+8uHXBkf2eC2vUevXNtK7rQ8mYWRQ7DKDG4SGbJULVn+SnV4bHF5bG6OcxVt4a768ZHOAVodyqpsdAdweJt0/Qn66Rx2GdOt9Ebof+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P9azl+wq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=XBH0IHGZUCGG4OKLWJTsoSfxC5AGMSYb5ZmdUnOdGdE=; b=P9azl+wqq1NuEIBo/OoXMGmsgD
	SED9BZrXD6cuLTFlqCokO/1VK82YPNcf9wyV+fTFzm/ZC8LIgYSSIPPxC6rCYSLrYUtsF4pP0mE25
	eWM5vRAEGoCIBzNXnQxli8bHDBadAUf9L/MSc+Rj+1JHRnZXW0MUZFOvvuNZxfsln0AltCgk6v5jC
	AnKr7Nl6Y39TdU1YO1i9/vJeNRpD2XknSZDWlkwNFMiaE6fR//JUMF6sA7SadHmj/IrHUfptsUjB2
	glnGf7FPruIUY4L3mffOg07l/eZfbho2ydorJhjsF14ORM/4RuTr3oU531emFueo75JqOBf8ZXvXo
	38R9zcKg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXqM-000000079lb-2IxM;
	Mon, 24 Feb 2025 12:45:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 18E6C3007F0; Mon, 24 Feb 2025 13:45:54 +0100 (CET)
Message-ID: <20250224124200.059556588@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 24 Feb 2025 13:37:05 +0100
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
Subject: [PATCH v4 02/10] x86/ibt: Add exact_endbr() helper
References: <20250224123703.843199044@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

For when we want to exactly match ENDBR, and not everything that we
can scribble it with.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/x86/kernel/alternative.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -863,6 +863,17 @@ __noendbr bool is_endbr(u32 *val)
 	return false;
 }
 
+static __noendbr bool exact_endbr(u32 *val)
+{
+	u32 endbr;
+
+	__get_kernel_nofault(&endbr, val, u32, Efault);
+	return endbr == gen_endbr();
+
+Efault:
+	return false;
+}
+
 static void poison_cfi(void *addr);
 
 static void __init_or_module poison_endbr(void *addr)
@@ -1427,10 +1438,9 @@ static void poison_cfi(void *addr)
 bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
 {
 	unsigned long addr = regs->ip - fineibt_preamble_ud2;
-	u32 endbr, hash;
+	u32 hash;
 
-	__get_kernel_nofault(&endbr, addr, u32, Efault);
-	if (endbr != gen_endbr())
+	if (!exact_endbr((void *)addr))
 		return false;
 
 	*target = addr + fineibt_preamble_size;



