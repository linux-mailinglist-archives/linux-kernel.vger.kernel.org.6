Return-Path: <linux-kernel+bounces-430745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8BE9E34EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD982840A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3CE1714B3;
	Wed,  4 Dec 2024 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="CZa6ESmv";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="sazbsbYT"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC06189F56;
	Wed,  4 Dec 2024 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299504; cv=pass; b=aV/XiTL+zLdP0TF3E+vCk2zw/IBtI+PyEdj1P+4ZDpnucJAFVFZrv9BN3ABLz/qQSnYNce7ONc2mgI3DY3ABGLbMlK/ljKpt4lU6UITL3h9AyzP1ewvKch9I/I9WJZpLlW3yr7mZRwoA4ooTtz0iJsZvOcy4pg9TjajKJ0kyRvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299504; c=relaxed/simple;
	bh=XK3q7ajrPEkEBPZ4BeyLsoPyHAONosmfl2NTR/B5py4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=faUSKGFtmPtsnGinMvYZieTkjgktwO4Wd4HLs3GOh4488qsuRkuWC49wlKU1kIGaq7fv25EAoq2Sj8fAoKkNz20ztlFQl3V9j4PLKQ4AVfcFc+y5ygkPRG0GD+7jPzrQt5t96DnCy890N+Y4SNq8LxnwEzoEyYpFKBBTcuKHhDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=CZa6ESmv; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=sazbsbYT; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
ARC-Seal: i=1; a=rsa-sha256; t=1733299499; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nsIlw2EFyz3yT1LldAYOTcqErG582TjG2oY5nf+QKJFXvRrYHHgvvicjFbqOzYu4RY
    iCGzVqv9FtZ+qj+3iWqOcvY9Amh8aD5TbsqHtw5LoeAOFRCwrkWuCR23d6n9ymugGJhu
    /9sz8WmjWbqBVTzACFtgz7ke34wt/VMq1V5tzKqbcHvH6PqOqyyAjE1CQkE//TSrpdpO
    jTZCQtvMez+2Adr+Ngds/BvP44/1q7oNqejjEAhlJT6Ajb2oBbvbOKWtDnL6FfbzuD+g
    F2tdI21Scq/4jA40xhXZPiYv47pNng4WGyFNDY82ZrX85ebUIKhLj+lQJsCAYlR4SH65
    MQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299499;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7MssRol3K7ItcFHd/ONuI+GpueXbhvQJYbT9pZF/fag=;
    b=glNIhwHaUjoFxCWCXl7lDbpEcxXty6iB2f7NBkq0SWpkYNYaYQhKv+5tK4K7hjbqjr
    MUXKHvECS9oVMm1WFA3pIWgYF+3RrpVg/SnsJFp7imrA6b97SBsPXshQjgSuC1/jL0qL
    zBjfWFSaH3L8WytSWWNKH1teCaK3PqgCX/zdPxXT1odm8t1+CgtKPtcA7h/Z/u45CQV+
    ePbYlWiIFUWICYZ99ffA6DxGaC+tR04PRX2FLZMAkjN9zy8uTZ0vszvB9UQpUwubnB8H
    4dLmG0Z38sIdiJm1QAM6ZOJ2KmA8Kd52e8KMt4AcgsN+sP7SzXQMQWihGV3gSoH26E75
    fISg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299499;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7MssRol3K7ItcFHd/ONuI+GpueXbhvQJYbT9pZF/fag=;
    b=CZa6ESmvRVTrpu0qDNSDvo8+AbWcs5cqcGWHAtfnsSF06zYpYRIaGm7gd8amYOrxv7
    ORlZPd9osDU/hl/bByrr8giyq1irmr5Q8GkUF++e+Nm5Ro8fOhnQs96KMdOeVnPd4qdS
    sfhACz6dPoLzy/ccQYBwRH48IZWk3HHvYqwRoZ0fmAUVBZKbvOspyzWoY1bLSFVxgA4J
    d8A59Eus25PO+uito96EotGvyTbWhtkgDn3ddjHfxh6EBdc+diQDuJfXTqWEHlxx/JHi
    H6BhrYdgjm6qQ9CrRaAznbuHbju2m6VC2sq7sE4zLaWIycRBZBNqEjYIQ/2cfEUUnvMP
    oiiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733299499;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7MssRol3K7ItcFHd/ONuI+GpueXbhvQJYbT9pZF/fag=;
    b=sazbsbYTmKVWZxd6KQ+tBKSuj+kSGr5q2Uzex4U+W4N//uJJUGx9F/pQV4nJigTvXt
    atG3clUnVBa85Zr/n+BQ==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Ja0a030B484xQyk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 09:04:59 +0100 (CET)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH v2] parisc: Remove memcpy_toio and memset_io
Date: Wed,  4 Dec 2024 09:04:40 +0100
Message-Id: <20241204080440.3721170-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Recently new functions for IO memcpy and IO memset were added in
libs/iomem_copy.c. So, remove the arch specific implementations, to fall
back to the generic ones which do exactly the same. Keep memcpy_fromio
for now, because it's slight more optimized by doing 'u16' accesses if
the buffer is aligned this way.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 arch/parisc/include/asm/io.h      |  4 ---
 arch/parisc/kernel/parisc_ksyms.c |  2 --
 arch/parisc/lib/io.c              | 47 -------------------------------
 3 files changed, 53 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index a63190af2f05..3143cf29ce27 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -135,12 +135,8 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 
 #define pci_iounmap			pci_iounmap
 
-void memset_io(volatile void __iomem *addr, unsigned char val, int count);
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
-void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
-#define memset_io memset_io
 #define memcpy_fromio memcpy_fromio
-#define memcpy_toio memcpy_toio
 
 /* Port-space IO */
 
diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index c1587aa35beb..1c366b0d3134 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -43,9 +43,7 @@ EXPORT_SYMBOL($global$);
 #endif
 
 #include <asm/io.h>
-EXPORT_SYMBOL(memcpy_toio);
 EXPORT_SYMBOL(memcpy_fromio);
-EXPORT_SYMBOL(memset_io);
 
 extern void $$divI(void);
 extern void $$divU(void);
diff --git a/arch/parisc/lib/io.c b/arch/parisc/lib/io.c
index 7c00496b47d4..7461366a65c9 100644
--- a/arch/parisc/lib/io.c
+++ b/arch/parisc/lib/io.c
@@ -12,32 +12,6 @@
 #include <linux/module.h>
 #include <asm/io.h>
 
-/* Copies a block of memory to a device in an efficient manner.
- * Assumes the device can cope with 32-bit transfers.  If it can't,
- * don't use this function.
- */
-void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
-{
-	if (((unsigned long)dst & 3) != ((unsigned long)src & 3))
-		goto bytecopy;
-	while ((unsigned long)dst & 3) {
-		writeb(*(char *)src, dst++);
-		src++;
-		count--;
-	}
-	while (count > 3) {
-		__raw_writel(*(u32 *)src, dst);
-		src += 4;
-		dst += 4;
-		count -= 4;
-	}
- bytecopy:
-	while (count--) {
-		writeb(*(char *)src, dst++);
-		src++;
-	}
-}
-
 /*
 ** Copies a block of memory from a device in an efficient manner.
 ** Assumes the device can cope with 32-bit transfers.  If it can't,
@@ -99,27 +73,6 @@ void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
 	}
 }
 
-/* Sets a block of memory on a device to a given value.
- * Assumes the device can cope with 32-bit transfers.  If it can't,
- * don't use this function.
- */
-void memset_io(volatile void __iomem *addr, unsigned char val, int count)
-{
-	u32 val32 = (val << 24) | (val << 16) | (val << 8) | val;
-	while ((unsigned long)addr & 3) {
-		writeb(val, addr++);
-		count--;
-	}
-	while (count > 3) {
-		__raw_writel(val32, addr);
-		addr += 4;
-		count -= 4;
-	}
-	while (count--) {
-		writeb(val, addr++);
-	}
-}
-
 /*
  * Read COUNT 8-bit bytes from port PORT into memory starting at
  * SRC.
-- 
2.34.1


