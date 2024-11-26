Return-Path: <linux-kernel+bounces-422744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2A69D9DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1458FB2BFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFE51DED57;
	Tue, 26 Nov 2024 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RjFrFfhc"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883A1DE3AA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646779; cv=none; b=b+INMGdr0RAck+HDFCr6Wx28OSZ/b4aqjtq4ambFEqEkMlieeM57oHx8vX8/yhMjirft8x6518aGNd0zGSxdD9IWoV8ah3ciDqqPurxueoVISS1LwHHw2ghwfoWCLsmtXXEsqjqPVyFGEebpkaYi2SG9++Rln66uCwuqblEreTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646779; c=relaxed/simple;
	bh=Ox1hgEdBNXvh06xbhlkeNApF8eSlowQFreq31q9bedU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCgo51D0txnsyPKdtPRMsg5LhZlulc2juWBFuyOz+Gzw091IHtlrYT75l9BLQf9Hb2Z1MWuyNr9Aanu+tfevWML4eCuRtZOKI3hJd2zdQUVcG2UXHxqJRSdK5YidD21p7ek34Ag5FcFi/5t0ojJSZ7+uR32o90/Ym7Kn0prILDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=RjFrFfhc; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4AQIjTbq1607347
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 26 Nov 2024 10:45:41 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4AQIjTbq1607347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024111601; t=1732646742;
	bh=bBrM9Xfs+Vj6tQu93nsLcDlIezj5luvtuAVbU9HeC30=;
	h=From:To:Cc:Subject:Date:From;
	b=RjFrFfhc4fe1JFaGxofQXYUu0FEuyozXwoTzOk/1tE5Zu3+5odgzPXrkvUrpeIDWo
	 9PfGOqQ3hWXUJVkYj9UYMjSNK6QDSAa/2UqkmSDHOvLZtpJjzikz/JQdp2ttk0NBfV
	 C0MJJaI1hi9AKesmx1VT/KLwa8PCp15TafmkWRttrbYhRGK30vA7+dQAXtI6kqF2x5
	 yWKmawVegNGoosqj3pT0x/Jge/np4lostGgx2yWzZGmdh72X5Ebb2mCGAZqakbRxRz
	 KS5DA5+XeqaUGatwQxC2IfgdGooeKbxHCmTGOwp9FAIQu/IBvSk5KywiweQWxb6P0m
	 5R7iUG3bwTaEw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        andrew.cooper3@citrix.com, brgerst@gmail.com, ebiederm@xmission.com
Subject: [PATCH v4 1/1] x86/ia32: Leave NULL selector values 0~3 as is
Date: Tue, 26 Nov 2024 10:45:28 -0800
Message-ID: <20241126184529.1607334-1-xin@zytor.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
GDT, selector values 0~3 all point to the NULL descriptor, thus values
0, 1, 2 and 3 are all valid NULL selector values.

When a NULL selector value is to be loaded into a segment register,
reload_segments() sets its RPL bits.  Later IRET zeros ES, FS, GS, and
DS segment registers if any of them is found to have any nonzero NULL
selector value.  The two operations offset each other to actually effect
a nop.

Besides, zeroing of RPL in NULL selector values is an information leak
in pre-FRED systems as userspace can spot any interrupt/exception by
loading a nonzero NULL selector, and waiting for it to become zero.
But there is nothing software can do to prevent it before FRED.

ERETU, the only legit instruction to return to userspace from kernel
under FRED, by design does NOT zero any segment register to avoid this
problem behavior.

As such, leave NULL selector values 0~3 as is.

Do the same on 32-bit kernel as well.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Changes since v3:
* Rename usrseg() to fixup_rpl() to match its intent (Andrew Cooper).
* A few comment improvements (Andrew Cooper).

Changes since v2:
* No, don't zero non-zero NULL selector values, essentially revert
  to v1 (Andrew Cooper).

Changes since v1:
* Normalize non-zero NULL selector values to 0 (Eric W. Biederman).
* Apply the same normalization logic in a 32bit kernel (Eric W.
  Biederman).
---
 arch/x86/kernel/signal_32.c | 62 +++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index ef654530bf5a..1e275268d256 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -33,25 +33,55 @@
 #include <asm/smap.h>
 #include <asm/gsseg.h>
 
+/*
+ * The first GDT descriptor is reserved as 'NULL descriptor'.  As bits 0
+ * and 1 of a segment selector, i.e., the RPL bits, are NOT used to index
+ * GDT, selector values 0~3 all point to the NULL descriptor, thus values
+ * 0, 1, 2 and 3 are all valid NULL selector values.
+ *
+ * However IRET zeros ES, FS, GS, and DS segment registers if any of them
+ * is found to have any nonzero NULL selector value, which can be used by
+ * userspace in pre-FRED systems to spot any interrupt/exception by loading
+ * a nonzero NULL selector and waiting for it to become zero.  Before FRED
+ * there is nothing software can do to prevent such an information leak.
+ *
+ * ERETU, the only legit instruction to return to userspace from kernel
+ * under FRED, by design does NOT zero any segment register to avoid this
+ * problem behavior.
+ *
+ * As such, leave NULL selector values 0~3 as is.
+ */
+static inline u16 fixup_rpl(u16 sel)
+{
+	return sel <= 3 ? sel : sel | 3;
+}
+
 #ifdef CONFIG_IA32_EMULATION
 #include <asm/unistd_32_ia32.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
-	unsigned int cur;
+	u16 cur;
 
+	/*
+	 * Reload fs and gs if they have changed in the signal
+	 * handler.  This does not handle long fs/gs base changes in
+	 * the handler, but does not clobber them at least in the
+	 * normal case.
+	 */
 	savesegment(gs, cur);
-	if ((sc->gs | 0x03) != cur)
-		load_gs_index(sc->gs | 0x03);
+	if (fixup_rpl(sc->gs) != cur)
+		load_gs_index(fixup_rpl(sc->gs));
 	savesegment(fs, cur);
-	if ((sc->fs | 0x03) != cur)
-		loadsegment(fs, sc->fs | 0x03);
+	if (fixup_rpl(sc->fs) != cur)
+		loadsegment(fs, fixup_rpl(sc->fs));
+
 	savesegment(ds, cur);
-	if ((sc->ds | 0x03) != cur)
-		loadsegment(ds, sc->ds | 0x03);
+	if (fixup_rpl(sc->ds) != cur)
+		loadsegment(ds, fixup_rpl(sc->ds));
 	savesegment(es, cur);
-	if ((sc->es | 0x03) != cur)
-		loadsegment(es, sc->es | 0x03);
+	if (fixup_rpl(sc->es) != cur)
+		loadsegment(es, fixup_rpl(sc->es));
 }
 
 #define sigset32_t			compat_sigset_t
@@ -105,18 +135,12 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	regs->orig_ax = -1;
 
 #ifdef CONFIG_IA32_EMULATION
-	/*
-	 * Reload fs and gs if they have changed in the signal
-	 * handler.  This does not handle long fs/gs base changes in
-	 * the handler, but does not clobber them at least in the
-	 * normal case.
-	 */
 	reload_segments(&sc);
 #else
-	loadsegment(gs, sc.gs);
-	regs->fs = sc.fs;
-	regs->es = sc.es;
-	regs->ds = sc.ds;
+	loadsegment(gs, fixup_rpl(sc.gs));
+	regs->fs = fixup_rpl(sc.fs);
+	regs->es = fixup_rpl(sc.es);
+	regs->ds = fixup_rpl(sc.ds);
 #endif
 
 	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);

base-commit: 6ff908de1eafb53f31db75d929b7566a87847d2d
-- 
2.47.0


