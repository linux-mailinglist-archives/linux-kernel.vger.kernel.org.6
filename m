Return-Path: <linux-kernel+bounces-398656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB249BF43F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DFA1C23652
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A1206941;
	Wed,  6 Nov 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bugNXo+A"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881D1F9ABB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914029; cv=none; b=ghq1vMJdzMi13iqDmfmprGeacHLK8KtTxrEczTP+xY2R3zbCPYm/l5HJf5UcnruQ8I8TEM+PpgqEqzTLbpN4K7dam/xA4+2/ZvaU26zCBFCRorl1PEr2eZn0ebToQVsgEt2+4o9vKJ4nMkptr8XWgJ7gQZAtTxpMRa0NaU0Nywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914029; c=relaxed/simple;
	bh=H1qn31TfTmOYcOTa1KZpe7FrkJMF+1dJBpzVEuG39BE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WBOtuP2SyzMDaqz5hHmSxOPEyulGijbevtW/c1JIJHP6D5iwtmlAnjx6qm4wd3Ba7x4eX+UwZDu7ZURkxJphlf066Ji/CTP8ydWtb1tlt/6Q4GIfOV4xR1ktBAuxjK1NFleqqf/+0BwWe5ZlY4IY0mtkN8k4xTNhrq7QvktZrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bugNXo+A; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C815B40E0261;
	Wed,  6 Nov 2024 17:27:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dy7xL1aM1vUV; Wed,  6 Nov 2024 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730914018; bh=Dvy/HIvuV86I1cm58jlPufMKEKiji6KXZ5ZtXk6Dipg=;
	h=Date:From:To:Cc:Subject:From;
	b=bugNXo+AOSQkQkppNpoxw/s47rvyVY7umSvx0ASnIrhbRVjG/LsmtMR/XhM2rKxfg
	 YWqSixElct3YYK8g3q3mcZszKlOUeI/PKCgfjD307uD78PhamMR5RYL5iC7VCW94Ow
	 uT1SlfSEyx20M1jGUKOz7ej6eCmha2dorO9ePn4FUq+P6OPjYBi3FzdcldwZhBwAIO
	 ToVoFkHPeUtRVYB5utFrk+wjdn76pOgdVkT8ycyZCsrp8ERk/JAJ7xQqsuI5D2YG/o
	 alSobgc80oCNTefaWorXc6B4047vShZ082r/tg1nPh2QQ3v4vx1KXtJpdc6WqrGcs0
	 xQTHf3F9/1CcRXdNNzQGeSck9tgeZO4e0gjw0M6OuS7dyBjNoW/E3HeUMEa93FSjOT
	 9vRQIn/YlRIGtCdQYv8QGQkxMRViTk4dqJmmoT6joLRA2XCwEQU/2BNUHczsdUyp7x
	 eK5gRlfHM1dUx+zoGOypEmx5OTQEYRxHwBNDuR/9k2URrOpoNAZRXrAetKWIWYNg00
	 gmIRe1/ggMmnrFDDTYtIvVqMnfUKv+/8cBQlKTUVOGRlZszAFhTe1o8iYcypZ2G+A8
	 IpR/zPGWldPpKnmZGEJp97nz27gvZBcdyevyjVu3jcUquru2KoRSdu1AprqvAdNQ5z
	 G3I71k1RvzBr6LVSe2be7oWc=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 819F540E0163;
	Wed,  6 Nov 2024 17:26:54 +0000 (UTC)
Date: Wed, 6 Nov 2024 18:26:47 +0100
From: "Borislav Petkov (AMD)" <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	linux-coco@lists.linux.dev
Subject: [RFC PATCH] x86/sev: Cleanup vc_handle_msr()
Message-ID: <20241106172647.GAZyum1zngPDwyD2IJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I think we should clean this one up before in-flight patchsets make it more
unreadable and in need for an even more cleanup.

---
Carve out the MSR_SVSM_CAA into a helper with the suggestion that
upcoming future users should do the same. Rename that silly exit_info_1
into what it actually means in this function - whether the MSR access is
a read or a write.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/coco/sev/core.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 97f445f3366a..1efb4a5c5ab3 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1406,35 +1406,39 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 	return 0;
 }
 
+/* Writes to the SVSM CAA MSR are ignored */
+static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
+{
+	if (write)
+		return ES_OK;
+
+	regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
+	regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
+
+	return ES_OK;
+}
+
 static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
 	enum es_result ret;
-	u64 exit_info_1;
+	bool write;
 
 	/* Is it a WRMSR? */
-	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
-
-	if (regs->cx == MSR_SVSM_CAA) {
-		/* Writes to the SVSM CAA msr are ignored */
-		if (exit_info_1)
-			return ES_OK;
-
-		regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
-		regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
+	write = ctxt->insn.opcode.bytes[1] == 0x30;
 
-		return ES_OK;
-	}
+	if (regs->cx == MSR_SVSM_CAA)
+		return __vc_handle_msr_caa(regs, write);
 
 	ghcb_set_rcx(ghcb, regs->cx);
-	if (exit_info_1) {
+	if (write) {
 		ghcb_set_rax(ghcb, regs->ax);
 		ghcb_set_rdx(ghcb, regs->dx);
 	}
 
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, !!write, 0);
 
-	if ((ret == ES_OK) && (!exit_info_1)) {
+	if ((ret == ES_OK) && (!write)) {
 		regs->ax = ghcb->save.rax;
 		regs->dx = ghcb->save.rdx;
 	}
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

