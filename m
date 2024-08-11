Return-Path: <linux-kernel+bounces-282428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C5494E3CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF578B2173A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B186E1607A5;
	Sun, 11 Aug 2024 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="yTRAEKNf"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2344C7E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723418588; cv=none; b=ONjEc+HY5U5IguPgIcfYFiH3NEKbmamWN0Lfn17oJZyapi4SficZ5LxlsA2c93tzHXRqmQBxlLhUxt3fDRHBaOmhSd+gGl+Wp4xcZvzMSLM7NvBdpZfkIHzcXs2cqmhm8FbFEwlS60dOxZZYUobZVc9nsz/2cWs7Oex8P5d5cFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723418588; c=relaxed/simple;
	bh=83ni0oxgvU7wO3TGJK4AznLbgJf+G+hKoJ+YstNEvTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUNA57Ru6X2CXd0+b7aAe5CueWFJDV2s2fdfOVPscEYBRfC21E0fqOOfIuXHo7m2V5cJy18NFmFWXYdZbReU3ff5LuEtVunfitLheqUSvShB5qFfa0USmMrACv1u8HcgfZ1LAEh2F59OaqcEnGeONX3iR9agpzb1q/n/Zo535BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=yTRAEKNf; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 9135 invoked by uid 990); 11 Aug 2024 23:22:58 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 12 Aug 2024 01:22:58 +0200
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
Subject: [PATCH 2/2] x86/kgdb: fix hang on failed breakpoint removal
Date: Mon, 12 Aug 2024 01:22:08 +0200
Message-ID: <20240811232208.234261-3-mail@florommel.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240811232208.234261-1-mail@florommel.de>
References: <20240811232208.234261-1-mail@florommel.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ---
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) BAYES_HAM(-2.887071) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -3.987071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=83ni0oxgvU7wO3TGJK4AznLbgJf+G+hKoJ+YstNEvTc=;
	b=yTRAEKNfu1DizVL9DZp9uTn697ofRBui9cOjT13fsPEl2wk0mZ8VMKLxbCwDm9LE/xraa+LilK
	xkuBOCGh2wg9jBunAPd/pGpWp3c2DLS/IahJoY5MT2At3OsiIj/9yv6vfTmEKy+d1TBIrxcwOjza
	SY/bAhv+BE6ohili6YsSh/l0NJv8ueyYFtIHsoV6qJ4vACEdw1iOwbp7DG4k4okloO4+U5Xhi3Gu
	gfKonjkdwqjtqXqZiOp4ZGqU3b78MmwHUj1bznmcJmMVAjDyQdP2l/asruvG5OTUJNpI3bKw2Lo7
	BWFU4NeVZSh5sI+H4cP003mI+plpSHvhI/qCm//JtMEkNDumD/3hZOULvL39X1eTPPtWklJ6j7vM
	tcdbZREELmIy48Bkfxdl9Fig+EOucGNedN0fTU93srnjUuDIXw7iFxjMkZplJvzuxemS0wheK6TG
	YgXJU1Euz64JZMoccHy6crRTWTQcb87ewqAbI61J2zbyinq3qLt7d6YkBxTqTfsj/zdFw3Kg5xF4
	MtNDA23Y20WbGc5zzQpo7zr79uO7h9FxHH8QUVEpfoHoYl7vgqXdgb1cclIlot9ezVog9qFXsaSG
	shuLUtOJYYS0+MAMKS0FiyBMb9ZXypikP7Up9EYwdqdrrOIOljW5ES+Oo71MiAr83ks3TSW8G4d5
	k=

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


