Return-Path: <linux-kernel+bounces-529080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF9A41F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D491893CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7CF23BCF5;
	Mon, 24 Feb 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mW0IDIXk"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC6233729
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401163; cv=none; b=FmV7j0xrEWVF4OgDjbYOb22iIYRGNBlZd/+VM+q/h5MBF22Vv4dbtSuha+BGbNrdMbtxf4ruyyPwgSuu5DWwXx7ZUCsSnReI3dr0Fwg594NHtCEjZ7CxKZ8oo8f4JgBxyBvwMQTJFQ/0J3M5oqtrb+H5RK/MGkzTfUmcxrkxBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401163; c=relaxed/simple;
	bh=rV8WiMc3I/ryESvRkeKTE5+/FDqde/84N1oS1AJJf4E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=i2H0fuom+v7hHbcHUWUeantKJSQhZCwYaWr3TPmUR56VQqeoGxy0DMo8BXMXQwi+v7MxdPyu27kM/sCiL/oVNjQYffKahi49nOapAny5u8x1HSQm5LQiSSbRgBujeVMQOp+JnuPSX/4UN2pKNA8mTqyyJ4yZBU8fBzPLBO/1sGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mW0IDIXk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=O8nlW/K8BIYLcoU8UNNApEKwuDGERPFhYSQAbOj23I8=; b=mW0IDIXkQ5lRIWqcDZIzGWW38V
	l0pqGOL9P1MhAkFhyWY+wOT5EW75/IBg5xJ+qmSs01KgVAg/wKR2/FykpW+yubZvMo7QwtMTGZVG1
	M0Dhb63d7SlVORhr8B2K1r7fNMObEdaAiwD5Gi75kVYCS7o8YejFCSraWHf8nNr0Ol17yqxsJ3Qbv
	ho493bXF+psarR4zfbI6kTY2avCROTVHiVIeFzovyifJF9P2xeuLcnEhkKEn3LOUBgtwUQTa31Mmh
	7nVrkf9FK8hIrgWFFdpKQGl8C8u3jeIPor8yxjPF8ZAjcWfFf8p5l1xvWsWILEQaV144kZV7JiiMh
	8bybHuXA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXqN-00000003C2U-0aum;
	Mon, 24 Feb 2025 12:45:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 286E6306573; Mon, 24 Feb 2025 13:45:54 +0100 (CET)
Message-ID: <20250224124200.486463917@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 24 Feb 2025 13:37:09 +0100
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
Subject: [PATCH v4 06/10] x86/traps: Decode LOCK Jcc.d8 #UD
References: <20250224123703.843199044@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Because overlapping code sequences are all the rage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/x86/include/asm/bug.h |    2 ++
 arch/x86/kernel/traps.c    |   26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -17,6 +17,7 @@
  * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
  */
 #define INSN_ASOP		0x67
+#define INSN_LOCK		0xf0
 #define OPCODE_ESCAPE		0x0f
 #define SECOND_BYTE_OPCODE_UD1	0xb9
 #define SECOND_BYTE_OPCODE_UD2	0x0b
@@ -26,6 +27,7 @@
 #define BUG_UD1			0xfffd
 #define BUG_UD1_UBSAN		0xfffc
 #define BUG_EA			0xffea
+#define BUG_LOCK		0xfff0
 
 #ifdef CONFIG_GENERIC_BUG
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -97,6 +97,7 @@ __always_inline int is_valid_bugaddr(uns
  * If it's a UD1, further decode to determine its use:
  *
  * FineIBT:      ea                      (bad)
+ * FineIBT:      0f 75 f9                lock jne . - 6
  * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
  * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
  * static_call:  0f b9 cc                ud1    %esp,%ecx
@@ -106,6 +107,7 @@ __always_inline int is_valid_bugaddr(uns
 __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 {
 	unsigned long start = addr;
+	bool lock = false;
 	u8 v;
 
 	if (addr < TASK_SIZE_MAX)
@@ -114,12 +116,29 @@ __always_inline int decode_bug(unsigned
 	v = *(u8 *)(addr++);
 	if (v == INSN_ASOP)
 		v = *(u8 *)(addr++);
-	if (v == 0xea) {
+
+	if (v == INSN_LOCK) {
+		lock = true;
+		v = *(u8 *)(addr++);
+	}
+
+	switch (v) {
+	case 0x70 ... 0x7f: /* Jcc.d8 */
+		addr += 1; /* d8 */
+		*len = addr - start;
+		WARN_ON_ONCE(!lock);
+		return BUG_LOCK;
+
+	case 0xea:
 		*len = addr - start;
 		return BUG_EA;
-	}
-	if (v != OPCODE_ESCAPE)
+
+	case OPCODE_ESCAPE:
+		break;
+
+	default:
 		return BUG_NONE;
+	}
 
 	v = *(u8 *)(addr++);
 	if (v == SECOND_BYTE_OPCODE_UD2) {
@@ -322,6 +341,7 @@ static noinstr bool handle_bug(struct pt
 		fallthrough;
 
 	case BUG_EA:
+	case BUG_LOCK:
 		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
 			handled = true;
 			break;



