Return-Path: <linux-kernel+bounces-529086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8FA41FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DCF16EFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E2624EF62;
	Mon, 24 Feb 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PRMkQEJ8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701C163
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401163; cv=none; b=bEZypZr0576R8fZkyxttWwJj5cwE2aC8rOW2UxNRGgShLBKSNtusqNebCpGrxnD6F5AnD3XS/xgnmKcOZ6NUoixXX0xYzbO/JRwaIwMjMVNreoAixGdWMVJz519wDU2Wl1Cp1ZQljhfZC/jZhnNRIF0sSLR74DODxq/fz+RyKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401163; c=relaxed/simple;
	bh=pDgaArRbB9J1a9tmEa0hR/h0yVxFlmcKaFGE2f+f6Pg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b4uffJ6H8yGnakH+1pfRuMS4k5sUv45S2/7ZDc1BH/vrFK9sntRH3IsUaiX6Bn7BloTQ2cB9ZJLGaCeJf2nib8Tu5rPhbuhDPtRaz3KtlxdjzoIouyIindCeAMrKNmVtegV3nzLL4obFaRH+LAXeOkyfPonU/djPKyhFC2Fg8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PRMkQEJ8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=YqfLieYxAGFlflkWnT6nHogORevj322hTYMScSLzSlo=; b=PRMkQEJ8kid/DriIa1Z+F78wW2
	3Vk/AznrgtdqTqStRzJZ6rM63JevBtnolHf8iNeg1fGctAN77qjKhWdcUjujgAM0/hv7jcF0zNXlB
	cu4Y05Qe44dv5gwofHQSswvymW3uHoA0WJOCeVmLHJxcXIUelz+8FZ09zRND5QCf4sNwd96IP0uSa
	95twV2UnDpbptKKhDah8inu7FI1fvtYnUy6QMD+C1cYGmamTT1OpKDrWQIXy3itKvslxd2xf3wH0X
	HjO1YUq8DSBEW26xIV9aiAlNYtZL8g4FeaeYNhhMqG50r7OgPpOc2NT3xZo7C4e+2/hSG1ElP/EeY
	moXNI//Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXqN-000000079mm-1xXd;
	Mon, 24 Feb 2025 12:45:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 360E73080BA; Mon, 24 Feb 2025 13:45:54 +0100 (CET)
Message-ID: <20250224124200.927885784@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 24 Feb 2025 13:37:13 +0100
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
Subject: [PATCH v4 10/10] x86/ibt: Optimize fineibt-bhi arity 1 case
References: <20250224123703.843199044@infradead.org>
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
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/x86/include/asm/ibt.h    |    4 ++
 arch/x86/kernel/alternative.c |   59 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 9 deletions(-)

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
@@ -1307,6 +1307,53 @@ static int cfi_rand_preamble(s32 *start,
 	return 0;
 }
 
+static void cfi_fineibt_bhi_preamble(void *addr, int arity)
+{
+	if (!arity)
+		return;
+
+	if (!cfi_warn && arity == 1) {
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
+		 * because the CMOVcc is unconditional and RDI will have been
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
@@ -1337,14 +1384,8 @@ static int cfi_rewrite_preamble(s32 *sta
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
@@ -1357,7 +1398,7 @@ static void cfi_rewrite_endbr(s32 *start
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 
-		if (!is_endbr(addr + 16))
+		if (!exact_endbr(addr + 16))
 			continue;
 
 		poison_endbr(addr + 16);



