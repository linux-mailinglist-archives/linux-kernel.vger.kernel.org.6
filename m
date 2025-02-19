Return-Path: <linux-kernel+bounces-522046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60E9A3C531
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070C13AFFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FFE20C034;
	Wed, 19 Feb 2025 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FWS30tB5"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F351FE44E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983012; cv=none; b=P92Ftb4JgxYI7W/FFTdoUxg/7Xv7L1LQVvSuMGkESk2DdtT1gR+lup+tpWvvkAE1UPXjxYdfq/E95mGMUmM5CeL17sLN3FOTAqFMuykwVWu7x/e6pL93L1oWqX5OwCdTVtw6aTAD9j6bYKMwUvF1WJanmKu2jV3+yJLxPrwzF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983012; c=relaxed/simple;
	bh=XH3MuXAiObT15pcf8fCzwAFGPy5FlpxKu3WYPUsMAT0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=t/Gbn6oNjUyd43ZNpIAkzlDINVN4U6Qe6ulUAYI9haRq6JOC9Na7vcgwN3+cnmuJ4SONLpNSJoIIzAywNR0xLCyNrLuH3V+AVEJNmZWlx5Z11Egg1kxw1ZMnuM0/WYP/6NlbWgnuBIbu3i8xvo3WS2CA3cRU5vPb7lP6nPcHQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FWS30tB5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=PiM728l6AQnzOFGFj6jdFclsn5t3z/jGFxhKy5mQQoA=; b=FWS30tB5oNIVLSFr17j7W9M5mv
	iejn8xIniPiuKybqGO7uDy2IqKRMZxKfngiyzaw86whWdPXpFm1C9G3EIeSkZlqEBplS/D5SWmG34
	9imVnrG3fCKxmBQLYl1fxqMhUaXtkfafOv5oDbumapMo8JQBcaJi0j2psxJOcAX/RstOJ3EaVk48/
	j8ny9lIqZckxqLjImA09XgpVGwuUG6lgWThpg5vRCvqdXVzTXGwhjklJJs6I1G7Or9kG79I+/9XJK
	TsggGE5n8hD6fxE+fveGA+H/OsKoZeJhphz8hqf6+GzvSL8ECJ6ZF7RqkR++c8aGh0PGm8dajMCAe
	OtuB0QVw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn41-00000002HAX-065R;
	Wed, 19 Feb 2025 16:36:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 19081300201; Wed, 19 Feb 2025 17:36:43 +0100 (CET)
Message-ID: <20250219163515.368430004@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 19 Feb 2025 17:21:17 +0100
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
Subject: [PATCH v3 10/10] x86/ibt: Optimize fineibt-bhi arity 1 case
References: <20250219162107.880673196@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Saves a CALL to an out-of-line thunk for the common case of 1
argument.

Suggested-by: Scott Constable <scott.d.constable@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/ibt.h    |    4 ++
 arch/x86/kernel/alternative.c |   61 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -70,6 +70,10 @@ static inline bool __is_endbr(u32 val)
 	if (val == gen_endbr_poison())
 		return true;
 
+	/* See cfi_fineibt_bhi_preamble() */
+	if (IS_ENABLED(CONFIG_FINEIBT_BHI) && val == 0x001f0ff5)
+		return true;
+
 	val &= ~0x01000000U; /* ENDBR32 -> ENDBR64 */
 	return val == gen_endbr();
 }
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1299,6 +1299,55 @@ static int cfi_rand_preamble(s32 *start,
 	return 0;
 }
 
+static void cfi_fineibt_bhi_preamble(void *addr, int arity)
+{
+	bool warn = IS_ENABLED(CONFIG_CFI_PREMISSIVE) || cfi_warn;
+
+	if (!arity)
+		return;
+
+	if (!warn && arity == 1) {
+		/*
+		 * Crazy scheme to allow arity-1 inline:
+		 *
+		 * __cfi_foo:
+		 *  0: f3 0f 1e fa             endbr64
+		 *  4: 41 81 <ea> 78 56 34 12  sub     0x12345678, %r10d
+		 *  b: 49 0f 45 fa             cmovne  %r10, %rdi
+		 *  f: 75 f5                   jne     __cfi_foo+6
+		 * 11: 0f 1f 00                nopl    (%rax)
+		 *
+		 * Code that direct calls to foo()+0, decodes the tail end as:
+		 *
+		 * foo:
+		 *  0: f5                      cmc
+		 *  1: 0f 1f 00                nopl    (%rax)
+		 *
+		 * which clobbers CF, but does not affect anything ABI
+		 * wise.
+		 *
+		 * Notably, this scheme is incompatible with permissive CFI
+		 * because the cmov is unconditional and RDI will have been
+		 * clobbered.
+		 */
+		const u8 magic[9] = {
+			0x49, 0x0f, 0x45, 0xfa,
+			0x75, 0xf5,
+			BYTES_NOP3,
+		};
+
+		text_poke_early(addr + fineibt_preamble_bhi, magic, 9);
+
+		return;
+	}
+
+	text_poke_early(addr + fineibt_preamble_bhi,
+			text_gen_insn(CALL_INSN_OPCODE,
+				      addr + fineibt_preamble_bhi,
+				      __bhi_args[arity]),
+			CALL_INSN_SIZE);
+}
+
 static int cfi_rewrite_preamble(s32 *start, s32 *end)
 {
 	s32 *s;
@@ -1329,14 +1378,8 @@ static int cfi_rewrite_preamble(s32 *sta
 			  "kCFI preamble has wrong register at: %pS %*ph\n",
 			  addr, 5, addr);
 
-		if (!cfi_bhi || !arity)
-			continue;
-
-		text_poke_early(addr + fineibt_preamble_bhi,
-				text_gen_insn(CALL_INSN_OPCODE,
-					      addr + fineibt_preamble_bhi,
-					      __bhi_args[arity]),
-				CALL_INSN_SIZE);
+		if (cfi_bhi)
+			cfi_fineibt_bhi_preamble(addr, arity);
 	}
 
 	return 0;
@@ -1349,7 +1392,7 @@ static void cfi_rewrite_endbr(s32 *start
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 
-		if (!is_endbr(addr + 16))
+		if (!exact_endbr(addr + 16))
 			continue;
 
 		poison_endbr(addr + 16);



