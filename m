Return-Path: <linux-kernel+bounces-529082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9FBA41FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63993A5FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD48123BCFE;
	Mon, 24 Feb 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RIOgrBco"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5B221F0B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401163; cv=none; b=BrFfIHQHqE1diXzansX6/eT+klIAiW0AM9u+tXgiUuiuANZUpyw+hrCWNHU8GPoO2oqdhJ9TU67mzC5p/poKhmjtVAmMZWO+4snTYdOQb8RD9jEwcwizjlFLyHNmMOgp6ii2oEdtYf9G4sjzV+1lbumU7SRV625XIekSO61FEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401163; c=relaxed/simple;
	bh=QZcp1ab1WZIM4jKs4x15fULENe5ASYKqrGQXPEXTUy0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OQz8DuCca+5M6yCYfz43V5mzHoh4ordZcFhXUAnoOk8Yy+uIeJgD1y/ln7OIYh14fAekt+6yH5QqB2jrQEESF8xkNJYefR8oFtsMb/W1KF78UO38GXfk1AqgNVixPy5lROqKYFAFUwkZN88859RjSrSAGHh71V5o3HjiNSksK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RIOgrBco; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=oXBu27fwzftsCfrJsqq+dp8YXeAeYXuO4u/fE4qHiAE=; b=RIOgrBcofBoKWOxnWmkjFg7LYx
	bG6XFvnFkKWwWoiGLEizBfF9rEsOPPxwnJmpGmhuhi0kRlvszqz/rtOXH7TYOkXNWKodqzOIXxfMO
	SsE/irVcy/cFTH1jMIfJXl9vWB36/eWPWpVhS61uA7nNQXVzJhfBJGeB4jyw4Hw+a9FNG813uDTa+
	df/1vBcZ+sfBzWNSBgtx0U1aY6PwwWduuFtNjGbOi2gkdxkhGy32B1zAMV10Cj1/BmJYELXMBqsBm
	3H/Kq3ASxdyRS8OqOg5TECYhR2Igu8MuNE28WpUfq5nNP1iglabbel3PrgAEEVe/7j8CQpS4HaAKJ
	/G36jZ2w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXqM-00000003C2Q-2EIT;
	Mon, 24 Feb 2025 12:45:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 20B923011E4; Mon, 24 Feb 2025 13:45:54 +0100 (CET)
Message-ID: <20250224124200.275223080@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 24 Feb 2025 13:37:07 +0100
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
Subject: [PATCH v4 04/10] x86/traps: Allow custom fixups in handle_bug()
References: <20250224123703.843199044@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The normal fixup in handle_bug() is simply continuing at the next
instruction. However upcomming patches make this the wrong thing, so
allow handlers (specifically handle_cfi_failure()) to over-ride
regs->ip.

The callchain is such that the fixup needs to be done before it is
determined if the exception is fatal, as such, revert any changes in
that case.

Additinoally, have handle_cfi_failure() remember the regs->ip value it
starts with for reporting.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cfi.c   |    8 ++++----
 arch/x86/kernel/traps.c |   16 +++++++++++++---
 2 files changed, 17 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -67,16 +67,16 @@ static bool decode_cfi_insn(struct pt_re
  */
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
-	unsigned long target;
+	unsigned long target, addr = regs->ip;
 	u32 type;
 
 	switch (cfi_mode) {
 	case CFI_KCFI:
-		if (!is_cfi_trap(regs->ip))
+		if (!is_cfi_trap(addr))
 			return BUG_TRAP_TYPE_NONE;
 
 		if (!decode_cfi_insn(regs, &target, &type))
-			return report_cfi_failure_noaddr(regs, regs->ip);
+			return report_cfi_failure_noaddr(regs, addr);
 
 		break;
 
@@ -90,7 +90,7 @@ enum bug_trap_type handle_cfi_failure(st
 		return BUG_TRAP_TYPE_NONE;
 	}
 
-	return report_cfi_failure(regs, regs->ip, &target, type);
+	return report_cfi_failure(regs, addr, &target, type);
 }
 
 /*
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -287,11 +287,12 @@ static inline void handle_invalid_op(str
 
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
+	unsigned long addr = regs->ip;
 	bool handled = false;
 	int ud_type, ud_len;
 	s32 ud_imm;
 
-	ud_type = decode_bug(regs->ip, &ud_imm, &ud_len);
+	ud_type = decode_bug(addr, &ud_imm, &ud_len);
 	if (ud_type == BUG_NONE)
 		return handled;
 
@@ -339,8 +340,17 @@ static noinstr bool handle_bug(struct pt
 		break;
 	}
 
-	if (handled)
-		regs->ip += ud_len;
+	/*
+	 * When continuing, and regs->ip hasn't changed, move it to the next
+	 * instruction. When not continuing execution, restore the instruction
+	 * pointer.
+	 */
+	if (handled) {
+		if (regs->ip == addr)
+			regs->ip += ud_len;
+	} else {
+		regs->ip = addr;
+	}
 
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();



