Return-Path: <linux-kernel+bounces-331480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F797AD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCE41F21017
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25FD17C9B5;
	Tue, 17 Sep 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMfy4wd9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EHQ3Skjq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071815E5DC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563259; cv=none; b=shlFzP3pJM0nePvA23f6OPKybg3Lm5lYPs7QAPmKvSBK/JEMx1RP2N9mywL+su3oyqKFuGOQ0tK7umTUf93MC5TCABpIZZ4y/vwYFgzu+EBVN5yNUEIKgzs8T5dH3ONe+a9VixRhxsgvYH9IzxT7IlzhMOCppdJbEXZuqhea5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563259; c=relaxed/simple;
	bh=5QKJz2YrD7O+bAAZQqeyDfE7FiP4gnmQe8f5LOGAO30=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=oLkb4MfvloWgpBYBEnEOU3Eplztk/36Stfl28rhksL2GMvv/S31XewY00caho2nzC7cWwre6cxmkdj3fqOK7EgkbHeYp1TfBNu65C27P6aVZn7ax1HAMPRguDfx/Eyyb7bGSotMX3gjNR44X207UJkJpjvvKh9YoEZwzbcNAhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMfy4wd9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EHQ3Skjq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726563249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=JuF2uzSmDzXkQ0cFXeAaBY4MPQWJH81tWUiidTtEMs8=;
	b=RMfy4wd9y89avxNl80exv3a/JeQYucG7gyuM8FpIUTM7aIlU+RWQTSrFaj1Zw9Gga26eJ7
	yGzSlpZQsxHnNWomPJw9B1GGyrc0R1fXVIyLeQw1h0mzhmxBcIf2cQdnqIDFZhDv4KKUdz
	JOxb5dcN1S+/xWmdVS22vj8F59XBZeiUIVgRj/80B+AUP5lJjooQHrgTqG7QkSzrOS9DAu
	Z8em2sdjKpYXGhwD1wwzsqMrnMOUrNfTAJVz4XCimZuU7Plvo69izmt0Vo9swiLqoawqRx
	XJMSOm8jy5PbPBcN3kcrC6dSyA/O+4DCBmV5IiQyQ+eQCCOxJD0xjA7hq6G9ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726563249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=JuF2uzSmDzXkQ0cFXeAaBY4MPQWJH81tWUiidTtEMs8=;
	b=EHQ3SkjqGB/ZgCRI0OJe9aIk3jfkDFVpJBaIUzjRR0QFsp4Pg8DY3Cp5daB3nrG8mLljRq
	VNHDD0RRvEy7uwAQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/core for v6.12-rc1
References: <172656198112.2471820.6226852046770294674.tglx@xen13>
Message-ID: <172656198591.2471820.16405077089777095536.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 10:54:09 +0200 (CEST)

Linus,

please pull the latest x86/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2024-09=
-17

up to:  7424fc6b86c8: x86/traps: Enable UBSAN traps on x86

Enable UBSAN traps for x86, which provides better reporting through
metadata encodeded into UD1.

Thanks,

	tglx

------------------>
Gatlin Newhouse (1):
      x86/traps: Enable UBSAN traps on x86


 arch/x86/include/asm/bug.h | 12 ++++++++++
 arch/x86/kernel/traps.c    | 59 ++++++++++++++++++++++++++++++++++++++++++--=
--
 include/linux/ubsan.h      |  5 ++++
 lib/Kconfig.ubsan          |  4 ++--
 4 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index a3ec87d198ac..806649c7f23d 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -13,6 +13,18 @@
 #define INSN_UD2	0x0b0f
 #define LEN_UD2		2
=20
+/*
+ * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
+ */
+#define INSN_ASOP		0x67
+#define OPCODE_ESCAPE		0x0f
+#define SECOND_BYTE_OPCODE_UD1	0xb9
+#define SECOND_BYTE_OPCODE_UD2	0x0b
+
+#define BUG_NONE		0xffff
+#define BUG_UD1			0xfffe
+#define BUG_UD2			0xfffd
+
 #ifdef CONFIG_GENERIC_BUG
=20
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17e5043..415881607c5d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -42,6 +42,7 @@
 #include <linux/hardirq.h>
 #include <linux/atomic.h>
 #include <linux/iommu.h>
+#include <linux/ubsan.h>
=20
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
@@ -91,6 +92,47 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
 	return *(unsigned short *)addr =3D=3D INSN_UD2;
 }
=20
+/*
+ * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
+ * If it's a UD1, get the ModRM byte to pass along to UBSan.
+ */
+__always_inline int decode_bug(unsigned long addr, u32 *imm)
+{
+	u8 v;
+
+	if (addr < TASK_SIZE_MAX)
+		return BUG_NONE;
+
+	v =3D *(u8 *)(addr++);
+	if (v =3D=3D INSN_ASOP)
+		v =3D *(u8 *)(addr++);
+	if (v !=3D OPCODE_ESCAPE)
+		return BUG_NONE;
+
+	v =3D *(u8 *)(addr++);
+	if (v =3D=3D SECOND_BYTE_OPCODE_UD2)
+		return BUG_UD2;
+
+	if (!IS_ENABLED(CONFIG_UBSAN_TRAP) || v !=3D SECOND_BYTE_OPCODE_UD1)
+		return BUG_NONE;
+
+	/* Retrieve the immediate (type value) for the UBSAN UD1 */
+	v =3D *(u8 *)(addr++);
+	if (X86_MODRM_RM(v) =3D=3D 4)
+		addr++;
+
+	*imm =3D 0;
+	if (X86_MODRM_MOD(v) =3D=3D 1)
+		*imm =3D *(u8 *)addr;
+	else if (X86_MODRM_MOD(v) =3D=3D 2)
+		*imm =3D *(u32 *)addr;
+	else
+		WARN_ONCE(1, "Unexpected MODRM_MOD: %u\n", X86_MODRM_MOD(v));
+
+	return BUG_UD1;
+}
+
+
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
@@ -216,6 +258,8 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled =3D false;
+	int ud_type;
+	u32 imm;
=20
 	/*
 	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
@@ -223,7 +267,8 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 * irqentry_enter().
 	 */
 	kmsan_unpoison_entry_regs(regs);
-	if (!is_valid_bugaddr(regs->ip))
+	ud_type =3D decode_bug(regs->ip, &imm);
+	if (ud_type =3D=3D BUG_NONE)
 		return handled;
=20
 	/*
@@ -236,10 +281,14 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN ||
-	    handle_cfi_failure(regs) =3D=3D BUG_TRAP_TYPE_WARN) {
-		regs->ip +=3D LEN_UD2;
-		handled =3D true;
+	if (ud_type =3D=3D BUG_UD2) {
+		if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN ||
+		    handle_cfi_failure(regs) =3D=3D BUG_TRAP_TYPE_WARN) {
+			regs->ip +=3D LEN_UD2;
+			handled =3D true;
+		}
+	} else if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
+		pr_crit("%s at %pS\n", report_ubsan_failure(regs, imm), (void *)regs->ip);
 	}
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
index bff7445498de..d8219cbe09ff 100644
--- a/include/linux/ubsan.h
+++ b/include/linux/ubsan.h
@@ -4,6 +4,11 @@
=20
 #ifdef CONFIG_UBSAN_TRAP
 const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type);
+#else
+static inline const char *report_ubsan_failure(struct pt_regs *regs, u32 che=
ck_type)
+{
+	return NULL;
+}
 #endif
=20
 #endif
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index bdda600f8dfb..1d4aa7a83b3a 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -29,8 +29,8 @@ config UBSAN_TRAP
=20
 	  Also note that selecting Y will cause your kernel to Oops
 	  with an "illegal instruction" error with no further details
-	  when a UBSAN violation occurs. (Except on arm64, which will
-	  report which Sanitizer failed.) This may make it hard to
+	  when a UBSAN violation occurs. (Except on arm64 and x86, which
+	  will report which Sanitizer failed.) This may make it hard to
 	  determine whether an Oops was caused by UBSAN or to figure
 	  out the details of a UBSAN violation. It makes the kernel log
 	  output less useful for bug reports.


