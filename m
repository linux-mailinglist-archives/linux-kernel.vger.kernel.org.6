Return-Path: <linux-kernel+bounces-283535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9BF94F607
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5041F22781
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB05188018;
	Mon, 12 Aug 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="rm9lbJ5M"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93980191
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484730; cv=none; b=a/ZMZiwth7dTIsn/tgQtLmYaElQhHV5xEktLXosgVRVZECRH/4WUDCuBj6JBswMQ2WqRenuhTU9fSHdvBABqchoCX6IlB75tQGuQFbn7W6r9WQjUsSjpGf4v3MNmswljfRrO2GQhVBEQ/R2PWSa5GjsbDF1G7T1RNuxGa+iPmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484730; c=relaxed/simple;
	bh=83ni0oxgvU7wO3TGJK4AznLbgJf+G+hKoJ+YstNEvTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5xEeXss/Tum3ibH2Wo6yRJowGqAYrwyoPM2i1YTKxNw+UVaQZJJIRqrn0vsJXREDxRRZ35aRyI+XODgcyNDrOx6+zeO/Lk6nKlAJUk4YuvzEuvFJiLd+EMvAtuzaqLflerVT3wfatHws+hJ7IJaM8mm+q17nGYU3xceBOFW50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=rm9lbJ5M; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 19654 invoked by uid 990); 12 Aug 2024 17:45:25 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 12 Aug 2024 19:45:25 +0200
From: Florian Rommel <mail@florommel.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
	Stefan Saecherl <stefan.saecherl@fau.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kgdb-bugreport@lists.sourceforge.net,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Florian Rommel <mail@florommel.de>
Subject: [PATCH v2 2/2] x86/kgdb: fix hang on failed breakpoint removal
Date: Mon, 12 Aug 2024 19:43:37 +0200
Message-ID: <20240812174338.363838-3-mail@florommel.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812174338.363838-1-mail@florommel.de>
References: <20240812174338.363838-1-mail@florommel.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) BAYES_HAM(-2.956524) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.056524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=83ni0oxgvU7wO3TGJK4AznLbgJf+G+hKoJ+YstNEvTc=;
	b=rm9lbJ5McaCPuNfKtT2SiDAwQtqhDensizQBTK8IZxXKNzhsvDR/nBh63pG+uyFHOdMHIJknS3
	Sijwsb/BAYu7ijxQVG7ny486hiZZFsvPMtPWSjDTH20PXkowK47mBvh2ZSnw3mEZFqR1Xenu5DIW
	YV7FhD9fS+opIE/IGc7CQjOi4pY5WrHtuYL9E1kbuhcXgKP39MwfZDHfhuA6GHlZWOFU8ulHvlYn
	cWF1w2ONqBpQNpr11MHYS/pz1O9Wnqgt2ZhcxLIjr1BxcRqJ1CDQzFimXvY8+fISusDyTjN6HSOd
	iCqaD1UFuxLe1xAgPxHAs2N990HvSELBJ+4UQjISDNdWwK/l0ecohrPmLXXlCWiOCx0FO8bIQFYM
	8xpnqsxLqkgwVpQVAlBlPcctS7bRTn1AvWRtjxH2At1BdHZJ7zrcfBn0dG8BuaGnCPxpGPGcvsvT
	gtAdilX9gBD51XnWPin18glsYKWKJy+VPefuZFz6g5Oj66i1UeOkGQFRt/pIEG4x/ah5PEfhrsfP
	WsIpMLaG8h9v+Qmr1UShV9bWcE340x396QjAgBVXsmNGHPboOYWBGFTH/bCXUAH4ahb/LQ0kg7+c
	CUUPaN5KNeZ9TmnbMgW94riLE9iAVoWOCffORZaNRX4oacrNxlKp3aRmUAft6XM/bOmsx1zutUpI
	I=

On x86, occasionally, the removal of a breakpoint (i.e., removal of
the int3 instruction) fails because the text_mutex is taken by another
CPU (mainly due to the static_key mechanism, I think).  The function
kgdb_skipexception catches exceptions from these spurious int3
instructions, bails out of KGDB, and continues execution from the
previous PC address.

However, this led to an endless loop between the int3 instruction and
kgdb_skipexception since the int3 instruction (being still present)
triggered again.  This effectively caused the system to hang.

With this patch, we try to remove the concerned spurious int3
instruction in kgdb_skipexception before continuing execution.  This
may take a few attempts until the concurrent holders of the text_mutex
have released it, but eventually succeeds and the kernel can continue.

Signed-off-by: Florian Rommel <mail@florommel.de>
---
 arch/x86/kernel/kgdb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 64c332151af7..585a7a72af74 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -723,7 +723,31 @@ void kgdb_arch_exit(void)
 int kgdb_skipexception(int exception, struct pt_regs *regs)
 {
 	if (exception == 3 && kgdb_isremovedbreak(regs->ip - 1)) {
+		struct kgdb_bkpt *bpt;
+		int i, error;
+
 		regs->ip -= 1;
+
+		/*
+		 * Try to remove the spurious int3 instruction.
+		 * These int3s can result from failed breakpoint removals
+		 * in kgdb_arch_remove_breakpoint.
+		 */
+		for (bpt = NULL, i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
+			if (kgdb_break[i].bpt_addr == regs->ip &&
+			    kgdb_break[i].state == BP_REMOVED &&
+			    (kgdb_break[i].type == BP_BREAKPOINT ||
+			     kgdb_break[i].type == BP_POKE_BREAKPOINT)) {
+				bpt = &kgdb_break[i];
+				break;
+			}
+		}
+		if (!bpt)
+			return 1;
+		error = kgdb_arch_remove_breakpoint(bpt);
+		if (error)
+			pr_err("skipexception: breakpoint remove failed: %lx\n",
+			       bpt->bpt_addr);
 		return 1;
 	}
 	return 0;
-- 
2.46.0


