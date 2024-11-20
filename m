Return-Path: <linux-kernel+bounces-415382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C09D3546
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4ACB239BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD481865E1;
	Wed, 20 Nov 2024 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kwQs3SeM"
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53C17E46E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090802; cv=none; b=ZP/Q3gkWCDxu+I0fgitbz+5ruPtQ+9kGJFWSmAwHTOWpUR/USxph0xC0FzQ6TWORd8D5VXt1l/vOVlPTQnngUUXEH53NGFKzqvjYU/alWA3+WeBj8GS1woy37N9F3aTay9SiEsnwZw+dq5yiIJx6N48n2NJQz3i2nENqG5IJPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090802; c=relaxed/simple;
	bh=Z4BS/kOtJr+ihlFwpjyJkyR1fEICgKBqbU62ef/Pw+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WlHzeMgwI3uGOqEElLTx25o5Gl6xWvCp5xCfDGmWykO0cCAUd5pe73pYa6oTtlQrOoxhIXrjATpmLjbziQVTmwmWj152BKMAMGAkB1pcpuvFBkX0MqEnqwvQK1x1tswcRWQugRsmtw83R6DQvPvAXZ+1qJNEKi13uv4HhvuY3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=kwQs3SeM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4AK8HMLd2838916
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 20 Nov 2024 00:17:25 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4AK8HMLd2838916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024111601; t=1732090646;
	bh=zQjWHRCQ6FuhNwnHpM9Z4TujrxtOpvm/Uta9xnowL1U=;
	h=From:To:Cc:Subject:Date:From;
	b=kwQs3SeMX609wRzbRhEXzW4vAfTWABKltXZgzt93WdYX9VX7G7R6lUpo5ZZ0T+BR1
	 W3vlBXIwwOy9q9zNhBYKRzroXYSE0V3+H3Y2tAS9kxZfqS6KFyX8m88lRAwHxRmwzv
	 PfDAu4vsMg3ZR2UpZ6krlcFQrwHEZIbrbpC2ivE8dPx/RtoiTgJeJ3fGTvKyGO4B+S
	 KgsL49XULl9g/RR4fWBO08jIVl+gyzkxQtXmOyQ8ldMal7W56veDlPKtIGU5G+ojrS
	 aqGgRam7owoJxl648sSh8K4elPZupSnUCWjZSJqVUBGbkhGJIb4rTw/em2N+12aL69
	 DREFjnDNH3H7Q==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        brgerst@gmail.com, ebiederm@xmission.com
Subject: [PATCH v2 1/1] x86/ia32: Normalize any null selector value to 0
Date: Wed, 20 Nov 2024 00:17:21 -0800
Message-ID: <20241120081721.2838905-1-xin@zytor.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first GDT descriptor is reserved as 'null descriptor'.  As bits 0
and 1 of a segment selector, i.e., the DPL bits, are NOT used to index
GDT, selector values 0~3 all point to the null descriptor, thus values
0, 1, 2 and 3 are all valid null selector values.

Furthermore IRET zeros ES, FS, GS, and DS segment registers if any of
them is found to have any null selector value, essentially making 0 a
preferred null selector value.

reload_segments() _unconditionally_ sets ES, FS, GS and DS segement
registers' DPL bits, which is unnecessary for null selector values,
since they will be zeroed later by IRET as used to return to userspace.

Unlike IRET, ERETU, introduced with FRED to return to userspace from
kernel, does not make any of DS, ES, FS, or GS null if it is found to
have DPL < 3.  Thus when FRED is enabled, a userspace segment register
ends up with 3 in it even when its initial value is 0 before entering
kernel, which fails the 32-bit sigreturn selftest.

Normalize any null selector value, 0~3, to 0, while for any non-null
selector, sets both DPL bits to force it to be a user level segment
selector.

Apply the same normalization logic in a 32bit kernel as well.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Changes since v1:
* Normalize non-zero null selector values to 0 (Eric W. Biederman).
* Apply the same normalization logic in a 32bit kernel (Eric W.
  Biederman).
---
 arch/x86/kernel/signal_32.c | 58 +++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index ef654530bf5a..73230892362f 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -33,25 +33,51 @@
 #include <asm/smap.h>
 #include <asm/gsseg.h>
 
+/*
+ * The first GDT descriptor is reserved as 'null descriptor'.  As bits 0
+ * and 1 of a segment selector, i.e., the DPL bits, are NOT used to index
+ * GDT, selector values 0~3 all point to the null descriptor, thus values
+ * 0, 1, 2 and 3 are all valid null selector values.
+ *
+ * Furthermore IRET zeros ES, FS, GS, and DS segment registers if any of
+ * them is found to have any null selector value, essentially making 0 a
+ * preferred null selector value.
+ *
+ * Normalizes any null selector value, 0~3, to 0, while for any non-null
+ * selector, sets both DPL bits to force it to be a user level segment
+ * selector.
+ */
+static inline u16 normalize_useg_selector(u16 sel)
+{
+	return sel <= 3 ? 0 : sel | 3;
+}
+
 #ifdef CONFIG_IA32_EMULATION
 #include <asm/unistd_32_ia32.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
-	unsigned int cur;
+	unsigned int new, cur;
 
+	new = normalize_useg_selector(sc->gs);
 	savesegment(gs, cur);
-	if ((sc->gs | 0x03) != cur)
-		load_gs_index(sc->gs | 0x03);
-	savesegment(fs, cur);
-	if ((sc->fs | 0x03) != cur)
-		loadsegment(fs, sc->fs | 0x03);
-	savesegment(ds, cur);
-	if ((sc->ds | 0x03) != cur)
-		loadsegment(ds, sc->ds | 0x03);
-	savesegment(es, cur);
-	if ((sc->es | 0x03) != cur)
-		loadsegment(es, sc->es | 0x03);
+	cur = normalize_useg_selector(cur);
+	if (new != cur)
+		load_gs_index(new);
+
+#define RELOAD_USEG_SELECTOR(seg) {			\
+	new = normalize_useg_selector(sc->seg);		\
+	savesegment(seg, cur);				\
+	cur = normalize_useg_selector(cur);		\
+	if (new != cur)					\
+		loadsegment(seg, new);			\
+}
+
+	RELOAD_USEG_SELECTOR(fs);
+	RELOAD_USEG_SELECTOR(ds);
+	RELOAD_USEG_SELECTOR(es);
+
+#undef RELOAD_USEG_SELECTOR
 }
 
 #define sigset32_t			compat_sigset_t
@@ -113,10 +139,10 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	 */
 	reload_segments(&sc);
 #else
-	loadsegment(gs, sc.gs);
-	regs->fs = sc.fs;
-	regs->es = sc.es;
-	regs->ds = sc.ds;
+	loadsegment(gs, normalize_useg_selector(sc.gs));
+	regs->fs = normalize_useg_selector(sc.fs);
+	regs->es = normalize_useg_selector(sc.es);
+	regs->ds = normalize_useg_selector(sc.ds);
 #endif
 
 	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);

base-commit: d5546ad1b9b17446e738741435aee92ee49fc4df
-- 
2.47.0


