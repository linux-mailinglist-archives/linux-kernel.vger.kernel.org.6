Return-Path: <linux-kernel+bounces-179775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877338C6520
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95E21C20ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066E604C8;
	Wed, 15 May 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQT08CTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E45EE82
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770090; cv=none; b=DeoA1zeJDBJQ4CL9b2PDJekZz5XYirMjW0wKUX/b8PZP/ftMWKxpelLoSgo2QyzwbS6mYGFBr7q0uSDTuxAKyvxvwUs1DDDlUjB7amNAGhFrxcpFg4/l7Rr/MRkE3cKXF/fTUM9VvcrD0Jfqi+7RnBKfYWfAfKH3UJHm3O1jgsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770090; c=relaxed/simple;
	bh=cJsCowm24pHU8O1Fj+KfzZ3M0w4ZHFAvFQxKmt/ilis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAqtuhrKlWliaZ6wsLPlxFretAbuEJV//ca58VbRLyf/D4y3TLjuUtnkBHUMYUnfryg/5uTD1gZUDMnJt/WXorHnjOLS4XFLJs17cEWNmpSNK3DSjeCGxlknQCI8Bn53zeeK8EqMtaQ2GTw9ermuuUngYLlY8+ydnoZRxkJ54ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQT08CTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A841C116B1;
	Wed, 15 May 2024 10:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715770089;
	bh=cJsCowm24pHU8O1Fj+KfzZ3M0w4ZHFAvFQxKmt/ilis=;
	h=From:To:Cc:Subject:Date:From;
	b=sQT08CTqIYH+H4EsDlEn0mNKQDSEKAS/oLggFTe8dzi3ll/zUsyfBoJ7HRJzVsbfD
	 mf5xiwoh0ROAJlpJOyNOqK9di8Q4olb4pdssrlJE0J7Ok7DL8m4ZJh2qDPcLPOhg9b
	 CUNgh9GOS6jNxkwSiGeAS4GvBH5Qzb9Z+3jJclGlPY1DEwiawHYaNtvcI3bWjZifUg
	 OoSuzETViJWo0Lawk8pdY+ZGasMdBP8jQxoSOhM9eCYVwPaVUyMCRsabMwD8uKR3Yb
	 B+saqmtTtLzqsJkDjdUFijKsUitAxLgcYit/A5ftD7A3y1HBP06ltfscmD3e8O5nXu
	 nMM5VSwOa8jug==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] x86/alternative: Use the correct length when optimizing NOPs
Date: Wed, 15 May 2024 12:48:04 +0200
Message-ID: <20240515104804.32004-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit in Fixes moved the optimize_nops() call inside apply_relocation()
and made it a second optimization pass after the relocations have been
done.

Since optimize_nops() works only on NOPs, that is fine and it'll simply
jump over instructions which are not NOPs.

However, it made that call with repl_len as the buffer length to
optimize.

However, it can happen that there are alternatives calls like this one:

  alternative("mfence; lfence", "", ALT_NOT(X86_FEATURE_APIC_MSRS_FENCE));

where the replacement length is 0. And using repl_len is wrong because
apply_alternatives() expands the buffer size to the length of the source
insn that is being patched, by padding it with one-byte NOPs:

	for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
		insn_buff[insn_buff_sz] = 0x90;

Long story short: pass the length of the original instruction(s) as the
length of the temporary buffer which to optimize.

Result:

  SMP alternatives: feat: 11*32+27, old: (lapic_next_deadline+0x9/0x50 (ffffffff81061829) len: 6), repl: (ffffffff89b1cc60, len: 0) flags: 0x1
  SMP alternatives: ffffffff81061829:   old_insn: 0f ae f0 0f ae e8
  SMP alternatives: ffffffff81061829: final_insn: 90 90 90 90 90 90

=>

  SMP alternatives: feat: 11*32+27, old: (lapic_next_deadline+0x9/0x50 (ffffffff81061839) len: 6), repl: (ffffffff89b1cc60, len: 0) flags: 0x1
  SMP alternatives: ffffffff81061839: [0:6) optimized NOPs: 66 0f 1f 44 00 00
  SMP alternatives: ffffffff81061839:   old_insn: 0f ae f0 0f ae e8
  SMP alternatives: ffffffff81061839: final_insn: 66 0f 1f 44 00 00

Fixes: da8f9cf7e721 ("x86/alternatives: Get rid of __optimize_nops()")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7555c15b7183..89de61243272 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -372,7 +372,7 @@ static void __apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen,
 void apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len)
 {
 	__apply_relocation(buf, instr, instrlen, repl, repl_len);
-	optimize_nops(instr, buf, repl_len);
+	optimize_nops(instr, buf, instrlen);
 }
 
 /* Low-level backend functions usable from alternative code replacements. */
-- 
2.43.0


