Return-Path: <linux-kernel+bounces-529087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE8CA41FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FC63AE608
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B524EF64;
	Mon, 24 Feb 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a6OJvkUb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EF23372C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401163; cv=none; b=TTHnbENi8E+NSOGOYVuRp9CBTY11gUMfUtXkG3WtLrOFXl83T1IqKd78t3TqOX+hIPteTInatMYMtbdxpyU7fHjZ/CQ3f/msjxIOeij0zro9ipqvpq+sfB5fce4vDtkGXv3zMybwwNgJu16/EIRJEwgVtfgMc9kUkbyiDzTPnlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401163; c=relaxed/simple;
	bh=rY8hfjQ46+vIUuOFxc40CbgFaBbrCmchkZaVaf0CnzQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Lof4HVSSQTl7zN0o2D8d3li7X+Q0jZ1B53YWsPcOfUAE9Cfa9HthEugCZ7aZIa7d/J7cNhHcKRtKaeLID0vrbfHLTy5vcloic4bBcz3NwV0KP2be0F7JOmg3qhfOpU61tBTSJxcWGWQ9UPS6UEPgyuMv6UQ8JCaQu3hnkOZgf3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a6OJvkUb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=PBme8ixFppy5L5nmk2W/qkNAxpMYSIP56Kuzq+VvDQM=; b=a6OJvkUbU99jcYrVckVv4UjDvF
	qR5US1ipYBEkIxBbUtWwR9oJGWVfpYlbtlI2eXizJEgW257yNPh0YarMqHfhDXpH6eVk+BMwDwqQs
	yj67AIY6eZhv4EqUhJmjIe5fZBAlf9NmI3dHJVUO+stXkiLL5o6zZXtDZTBVnmJt8yy2YANZM4o+M
	Uxyq0a4oV4cxc4rt2Ga7PNi1b9TdUMXi9JdcjNe7tJ3VgA1m9aMT5S5oyLpyy1j/F0/fA3ldF6l1I
	QsUDNXbqDbpmghR/pXIPnDsLrFdU126FXWNnDebtBdUkFdRXa8Iih9dmWKsoKiOiO+lMIdnz3egrU
	c5O+wNiA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXqM-000000079le-2FmP;
	Mon, 24 Feb 2025 12:45:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1C9CA300898; Mon, 24 Feb 2025 13:45:54 +0100 (CET)
Message-ID: <20250224124200.166774696@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 24 Feb 2025 13:37:06 +0100
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
Subject: [PATCH v4 03/10] x86/traps: Decode 0xEA #UD
References: <20250224123703.843199044@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

FineIBT will start using 0xEA as #UD

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h |    1 +
 arch/x86/kernel/traps.c    |   20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -25,6 +25,7 @@
 #define BUG_UD2			0xfffe
 #define BUG_UD1			0xfffd
 #define BUG_UD1_UBSAN		0xfffc
+#define BUG_EA			0xffea
 
 #ifdef CONFIG_GENERIC_BUG
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -96,6 +96,7 @@ __always_inline int is_valid_bugaddr(uns
  * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
  * If it's a UD1, further decode to determine its use:
  *
+ * FineIBT:      ea                      (bad)
  * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
  * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
  * static_call:  0f b9 cc                ud1    %esp,%ecx
@@ -113,6 +114,10 @@ __always_inline int decode_bug(unsigned
 	v = *(u8 *)(addr++);
 	if (v == INSN_ASOP)
 		v = *(u8 *)(addr++);
+	if (v == 0xea) {
+		*len = addr - start;
+		return BUG_EA;
+	}
 	if (v != OPCODE_ESCAPE)
 		return BUG_NONE;
 
@@ -309,10 +314,16 @@ static noinstr bool handle_bug(struct pt
 
 	switch (ud_type) {
 	case BUG_UD2:
-		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
-		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-			regs->ip += ud_len;
+		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
+			handled = true;
+			break;
+		}
+		fallthrough;
+
+	case BUG_EA:
+		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
 			handled = true;
+			break;
 		}
 		break;
 
@@ -328,6 +339,9 @@ static noinstr bool handle_bug(struct pt
 		break;
 	}
 
+	if (handled)
+		regs->ip += ud_len;
+
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
 	instrumentation_end();



