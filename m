Return-Path: <linux-kernel+bounces-418516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095369D6276
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6C0160866
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7F1DED6A;
	Fri, 22 Nov 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XT241HZk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58613635E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293681; cv=none; b=O/ctG9gKUX6N4KbFCdRm/oOTBnnPebiqdPPHuLLbXBQOCOEnvazVBJo+TPV9kTBJEbpIfhbkqddggwI23WZ82vx0UBQ9zWfEb2sXXe1MHQxSPrgBw/L4SYXC46lf+/q3aT4WdJZZTQ+FSyNUh0BHwcrnwIaf1QSRqnnQXfr/Elo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293681; c=relaxed/simple;
	bh=Np9F9pqp3MIzMSg06qdAbmAYOiV6B6OSkUYtJ627eZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HHa4sdb4T3QZLg+GK6chZ8Z0W8CwJu651/4DeM34YIgpEI1yn3g772gL68Uachis7ohxZjmL6QFjDHNgwJOt449d68Lg344pCUfjEfn62KHmu9lnzbNij4zWoAjkQyppsL6jNxvTvvzYq26K31WD57l1KzBkaJ7JZui56vOMEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XT241HZk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 03E2B40E0219;
	Fri, 22 Nov 2024 16:31:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JW_bQ_xKXDcu; Fri, 22 Nov 2024 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732293109; bh=+2gWvPFDz50jxaSPdmOERCbadoPzHtY+/IAhZDrwnGs=;
	h=Date:From:To:Cc:Subject:From;
	b=XT241HZkwDGnmbmWLkDw06j37IwdZBhcaoqVc9sseyFsNBB7JcWgdMhMRUvRfmKRv
	 JFT7uHoLic5ErcU5jozc3Cy9as8IpzodhZxBgr0HTMUpjQzlrCLuoga8WszSvkfBMb
	 XYhzF7i889cmLteBdY2lklHTEhYE+TWCoDlAGMztzjxUn6v5lz2eOJNUp1oPCuIQgT
	 fHNfmLUoh+YCm+SyXGbz5cXrQa/iULA5Qp3QTPD89WWe81qjrjNc0KEkY5cgx6x195
	 KmUMZr3gqRcdoP9dq1DW3ZAE4eZ38wdaPZEHLbkr4/Z1q4Wa6PdeM1yUX1uwYWjjBQ
	 WQ1Gaevd1NSQYa0NtKdzsTwcU9fz0rUGyEIHdI7vOowBgPBjl+kkEB9IMzlTOyisBJ
	 GsW9ztV/tGaQSAqlzibByBPtIx8KKTULtBA9/MbhoPncimEMxDpvzvqLNzy/0bTN9x
	 5UwGJhFsV6PJQEpzBoQMdI+O4u6Qwn+0A7qp25qboC/kAGFusdTQEnDdGD35jbWipt
	 aEveE5U/NOsL4hEWx4fuKms/3avlkFI21Cy0YqnTZPGNuggvMTBJQaZEAbOUpQ2I+l
	 2eIBusPejRVN3/33UtLUXOfSNfiBQ98TmO3zgnmEwjP2C8b7HEr3hx3k1YPRPkHsMJ
	 zZy9KUgB0kGQAu0tD52UTBq4=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D96A40E015F;
	Fri, 22 Nov 2024 16:31:46 +0000 (UTC)
Date: Fri, 22 Nov 2024 17:31:39 +0100
From: "Borislav Petkov (AMD)" <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] x86/boot: Get rid of linux/init.h include
Message-ID: <20241122163139.GAZ0Cx63Ia9kgYgRIr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

this is what I think we should do (just a first patch) to decouple the
decompressor from kernel proper headers namespace so that there's no
collisions and ugly ifdeffery when those kernel proper headers get shared.

And if we want to share things, we will use asm/shared/ to put such shared
definitions there.

Thoughts?

---

Get rid of the linux/init.h kernel proper namespace include and add
a KERNEL_PROPER_HEADER header guard to protect any future inclusions
into the decompressor.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/boot/compressed/error.h   | 2 --
 arch/x86/boot/compressed/head_32.S | 7 +++++--
 arch/x86/boot/compressed/head_64.S | 7 +++++--
 arch/x86/include/asm/init.h        | 2 +-
 include/linux/init.h               | 2 ++
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/error.h b/arch/x86/boot/compressed/error.h
index 31f9e080d61a..938f6f1f1589 100644
--- a/arch/x86/boot/compressed/error.h
+++ b/arch/x86/boot/compressed/error.h
@@ -2,8 +2,6 @@
 #ifndef BOOT_COMPRESSED_ERROR_H
 #define BOOT_COMPRESSED_ERROR_H
 
-#include <linux/compiler.h>
-
 void warn(const char *m);
 void error(char *m) __noreturn;
 void panic(const char *fmt, ...) __noreturn __cold;
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 1cfe9802a42f..6d7728582215 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -24,7 +24,6 @@
  */
 	.text
 
-#include <linux/init.h>
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page_types.h>
@@ -32,6 +31,10 @@
 #include <asm/asm-offsets.h>
 #include <asm/bootparam.h>
 
+#ifdef KERNEL_PROPER_HEADER
+#error Do not include kernel proper namespace headers
+#endif
+
 /*
  * These symbols needed to be marked as .hidden to prevent the BFD linker from
  * generating R_386_32 (rather than R_386_RELATIVE) relocations for them when
@@ -42,7 +45,7 @@
 	.hidden _ebss
 	.hidden _end
 
-	__HEAD
+	.section ".head.text","ax"
 SYM_FUNC_START(startup_32)
 	cld
 	cli
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1dcb794c5479..75ea0c8e4116 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -25,7 +25,6 @@
 	.code32
 	.text
 
-#include <linux/init.h>
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/boot.h>
@@ -37,6 +36,10 @@
 #include <asm/trapnr.h>
 #include "pgtable.h"
 
+#ifdef KERNEL_PROPER_HEADER
+#error Do not include kernel proper namespace headers
+#endif
+
 /*
  * Fix alignment at 16 bytes. Following CONFIG_FUNCTION_ALIGNMENT will result
  * in assembly errors due to trying to move .org backward due to the excessive
@@ -52,7 +55,7 @@
 	.hidden _ebss
 	.hidden _end
 
-	__HEAD
+	.section ".head.text","ax"
 
 /*
  * This macro gives the relative virtual address of X, i.e. the offset of X
diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 14d72727d7ee..6c47c84a3731 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_INIT_H
 #define _ASM_X86_INIT_H
 
-#define __head	__section(".head.text")
+#define __head __section(".head.text")
 
 struct x86_mapping_info {
 	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
diff --git a/include/linux/init.h b/include/linux/init.h
index ee1309473bc6..21e636abf3c4 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_INIT_H
 #define _LINUX_INIT_H
 
+#define KERNEL_PROPER_HEADER
+
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/stringify.h>
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

