Return-Path: <linux-kernel+bounces-417299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BA39D522F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387DE283235
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074C1AB535;
	Thu, 21 Nov 2024 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C8HA7R8f"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E76CDAF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211749; cv=none; b=uih1bKRZH4EseS1HsNledsMXHNiBRj0Nn939PXE++mbd40ICCdNQX5Sbsw61qmiRSWQCTa7st7t50W0Zpfg9sIjxfLGgIMshYK89wWkCGZ+SzDY7xSOFfDOZu3tufvLtteDQ3sUpB02gFi9MA+AqDpDgRwXKb3agYtTn0bR75Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211749; c=relaxed/simple;
	bh=qosfRgpfUMRRn8i6Nvd5tSsdWVxZVL6jABElPJd8/5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLGBeLGSlPOakI8FDkNtVIRdTrZO2sLBZortyCJZ+JfQr2dcwYYlV42ctrDVoV86HewTaU7/iVGa6jNqvCaT5ThMl+KOTieB3C282EYAHL4QKVTwXiJn0plZRzCrWOm1VDoLqghaOx0bq1TTU2fENbm/jW6obbgSkjD2tirD1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=C8HA7R8f; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4ALHsl343481872
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 21 Nov 2024 09:54:50 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4ALHsl343481872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024111601; t=1732211691;
	bh=vcj377ZY1Vn21NlvCnJ4/TViBidTlPsoqSeX/ItIEV0=;
	h=From:To:Cc:Subject:Date:From;
	b=C8HA7R8f9/keb//TsiE8srrt/QJYlqpSuKA0fQrTUvPVvQkb7D+VHJiG4ZcqPBNrp
	 LUeY3QgqaRnQdD/aJ+XmVOVqAp0K4TOsRfcb5r3+6MPk2SLQmWy1oLwQI8GVevFTeW
	 fMIuuLHKThkpZk7G3HIInzm72UXcPeE8q3muJcFA2bbkgH0XTbUianB10bOLPr2C//
	 sL8cEFPRSSccr1kjnMejeCa1XdkS+TbTGDU3GZmSLgxoZ+Z1dWHRJFUZLml9eWBuhN
	 xmxjdmBZdpCFs78wlwINunvWzaVhtM2NdmBa7ZIgple+Axhfvcg+Pbs/53B30aWltK
	 hhYvv67YCRZ9Q==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        andrew.cooper3@citrix.com, brgerst@gmail.com, ebiederm@xmission.com
Subject: [PATCH v3 1/1] x86/ia32: Leave NULL selector values 0~3 as is
Date: Thu, 21 Nov 2024 09:54:46 -0800
Message-ID: <20241121175446.3481862-1-xin@zytor.com>
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
loading a nonzero NULL selector, and waiting for it to drop to zero.
But there is nothing software can do to prevent it before FRED.

ERETU, the only legit instruction to return to userspace from kernel
under FRED, by design does NOT zero any segment register to avoid this
problem behavior.

As such, leave NULL selector values 0~3 as is.

Do the same on 32-bit kernel as well.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Changes since v2:
* No, don't zero non-zero NULL selector values, essentially revert
  to v1 (Andrew Cooper).

Changes since v1:
* Normalize non-zero NULL selector values to 0 (Eric W. Biederman).
* Apply the same normalization logic in a 32bit kernel (Eric W.
  Biederman).
---
 arch/x86/kernel/signal_32.c | 47 +++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index ef654530bf5a..23879f14aa51 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -33,6 +33,29 @@
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
+ * a nonzero NULL selector and waiting for it to drop to zero.  Before FRED
+ * there is nothing we can do to prevent such an information leak.
+ *
+ * ERETU, the only legit instruction to return to userspace from kernel
+ * under FRED, by design does NOT zero any segment register to avoid this
+ * problem behavior.
+ *
+ * As such, leave NULL selector values 0~3 as is.
+ */
+static inline u16 usrseg(u16 sel)
+{
+	return sel <= 3 ? sel : sel | 3;
+}
+
 #ifdef CONFIG_IA32_EMULATION
 #include <asm/unistd_32_ia32.h>
 
@@ -41,17 +64,17 @@ static inline void reload_segments(struct sigcontext_32 *sc)
 	unsigned int cur;
 
 	savesegment(gs, cur);
-	if ((sc->gs | 0x03) != cur)
-		load_gs_index(sc->gs | 0x03);
+	if (usrseg(sc->gs) != cur)
+		load_gs_index(usrseg(sc->gs));
 	savesegment(fs, cur);
-	if ((sc->fs | 0x03) != cur)
-		loadsegment(fs, sc->fs | 0x03);
+	if (usrseg(sc->fs) != cur)
+		loadsegment(fs, usrseg(sc->fs));
 	savesegment(ds, cur);
-	if ((sc->ds | 0x03) != cur)
-		loadsegment(ds, sc->ds | 0x03);
+	if (usrseg(sc->ds) != cur)
+		loadsegment(ds, usrseg(sc->ds));
 	savesegment(es, cur);
-	if ((sc->es | 0x03) != cur)
-		loadsegment(es, sc->es | 0x03);
+	if (usrseg(sc->es) != cur)
+		loadsegment(es, usrseg(sc->es));
 }
 
 #define sigset32_t			compat_sigset_t
@@ -113,10 +136,10 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	 */
 	reload_segments(&sc);
 #else
-	loadsegment(gs, sc.gs);
-	regs->fs = sc.fs;
-	regs->es = sc.es;
-	regs->ds = sc.ds;
+	loadsegment(gs, usrseg(sc.gs));
+	regs->fs = usrseg(sc.fs);
+	regs->es = usrseg(sc.es);
+	regs->ds = usrseg(sc.ds);
 #endif
 
 	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);

base-commit: 25f324dbc68cd6ff972f5ab3bb07f1bf6200f0e0
-- 
2.47.0


