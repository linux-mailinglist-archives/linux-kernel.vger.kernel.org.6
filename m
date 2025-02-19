Return-Path: <linux-kernel+bounces-522038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC57FA3C533
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE9189D632
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667EE1FECB0;
	Wed, 19 Feb 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JPOeqdbA"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822F1F8F09
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983011; cv=none; b=A/3iFDjOF3Mt/YqP/udQiVUw09X6el+xykMveNYB9J3yfSDfvX3v8C80zmRwYwBlTrFKwNR+/9aRbFd2ahb8B7dbqBwMvYQRKhbwm9sXVdVCdo+agNIdud/ZSmbGH01mo72Bpwzlg+Ub1mS+LsmEZzLTfY0FBgXQFhq2/U6Ovm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983011; c=relaxed/simple;
	bh=l06kFxeKrcAhg/x/b2aTiCRIVs83ZHWC/2HlO0/Qs4s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lwyHwgtcIw+2juxhWbNyqVLJ6zHxTXUagMbwHq0OSeAY4VdtWaYx7atvg1tb2SZ++43rAI/nhaYhQHLhB1RgYXpSlyEys0H0/6gz9Vfq5OQR5CIiVDbVAIxd1KeBfy4zKCfCA//5ikhUbAjO9vXezN5/eexTNoXIedpVbYWvzKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JPOeqdbA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=gFdsCjt9iaR5QNqBsC/Zj16q/fjCzjNxQUrJ7toUTpQ=; b=JPOeqdbAAGa2KgldSFkG4S2ywV
	I7d31HyN+Szd0oatA29mYWdeV0mB0MP+ZXI4+KTX/9AdXfnUl/wWlG0AYpRCcxYNiwuT71G/p7pBd
	76kpWjfCHADLfaMyUW3cSM+wivhNz+hbkr8edQc+//szQix9s2Z9AtlAB9KLUNZq6Mz1wv5lBX89L
	Ye+3pm0CXZ/oVcUPrmuqJUGL9ugbObFPMlB8SPN5hYCP4//7dz+mNcNuVyDpDQe5FyQHIJZIUFeZ1
	8sSCCaTBaYWo/UoYai4Vnlb78ug0BbZb5ePffkSkffVHufiuCB84L2nTkqRYA7DJHwOtYml2L84Nd
	evmV1GzA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn40-00000002HAI-0JSg;
	Wed, 19 Feb 2025 16:36:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F22CF3007CD; Wed, 19 Feb 2025 17:36:42 +0100 (CET)
Message-ID: <20250219163514.581527735@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 19 Feb 2025 17:21:10 +0100
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
Subject: [PATCH v3 03/10] x86/traps: Decode 0xEA #UD
References: <20250219162107.880673196@infradead.org>
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
 arch/x86/kernel/traps.c    |   12 ++++++++++++
 2 files changed, 13 insertions(+)

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
 
@@ -308,6 +313,13 @@ static noinstr bool handle_bug(struct pt
 		raw_local_irq_enable();
 
 	switch (ud_type) {
+	case BUG_EA:
+		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
+			regs->ip += ud_len;
+			handled = true;
+		}
+		break;
+
 	case BUG_UD2:
 		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
 		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {



