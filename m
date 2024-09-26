Return-Path: <linux-kernel+bounces-340340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FE79871CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C511C23D80
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80731AED5E;
	Thu, 26 Sep 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXUHUsda"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB381AED4E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347325; cv=none; b=UMjnbScT9lSSAqJwMCe2b76IZnvTJ+wwvXWBSm1UjdpAfip6XN0gRD3Dan2SWok+88FhTDEEKc1HiVV11/Ox6qBYPjnoralB3Uxq9raFERDH9KHYSbITUSsE27wxtIB4yiu+FLDceHL3t23xy+Ca9ljsiYQMtxb0EI95+oVAjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347325; c=relaxed/simple;
	bh=9Hi5401Jkuskga+L4+THFUEu62P/0WX8gIxQMtQVEYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ppod4AxxamNpQeBSP+h1wE70UPp3gQT1icURvaEdi8LE823np8Z5pXj3iZItHlaqokrwVQVMKjLN61ZPIRJ0S/ao++fwvF3UtTxRH9IiQuEGU2y6PfeIYMCtFa/SvArZD4mBfwo8W2bROOmid1dZO/Oa52Ga1iyQpzHqp+5OEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXUHUsda; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2146737f2so14969147b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727347322; x=1727952122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQvQh3ouoZ2SzJYUdvKa6rkKBNpFrAMDmjZmjc8fkmc=;
        b=WXUHUsdasjMPZLfQDewldGLAxyMk4CfS5O+7y4fXnCV60h46mwnnkCxnPXLeQAN13j
         fx8AwepS3ipI/wVIy7vwAI1ctaA/Tq5MBfwak+4c8eSNT1Rs/b3Djgau6YbbrE028Hi3
         N3B8TXQDUC3Q8FPyl7cK15wMfcWVW6x4rcmXr3p+xawXYdNlNImU4Uxed9lBAf4s7UTb
         4QMknSK0YpMxSTfckEijqdTBOn0kf8zA7yAnyQqj1GbzA9ZgdNLTK/UqYZHVOEvmqSCq
         0mxM7qE8w7uiD6OiP7OufVFScbSL7KxuWciKNRK32b7Xf6Sd5PO47EK8H+P/8VVsDTpA
         wszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347322; x=1727952122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQvQh3ouoZ2SzJYUdvKa6rkKBNpFrAMDmjZmjc8fkmc=;
        b=ru0vu3G/FvrWgnaD433I8twSdrOOQWjhw3wXt7QbF6r4mco+g40YBTBQa8x/BDI3bR
         CY4OBJqsUt7t8yq+BrDACX8IZL0KsIWF3OOe97CWK075kf6HANudIFE4mks+oFNGvuTw
         tJs8qoTivyEU9vK+LbzQRNdK7yolq+XKh9nM7gjt7nJ1VRGZJ3qoNdACNwzVqMhdRPxd
         D8LQKOUZfpKPzRzg70yXR7VLC5wv5dyI2txMiFVLjrOxXmqVjUUVgyatoYnU8vIfhqVo
         VTKpel8eEdaQBtK/PhEbBqyu7rRPDUQfJAWLDxzJ2vKkh8kBVOPPw3PTzETPUrF0gGvx
         EBbw==
X-Gm-Message-State: AOJu0Yw+U1g4x1+7QvRNXBZCFaMlyeqEY5AeE7zlq+SMck4zrXffw6iR
	/gjBn1zPh5tSAjd+Du0K2azer5ZO1Qi6CJDzC5erUKuVBCNNizF08gPu22rgeZVoi32r6PhVJoc
	lknTCpgB1POl3sgVS8j0e6hipSFQyW0nD2iQHJSLuJn1fx7m2Kih5dHVobWmZsecKV1PoweguaX
	QFk2U5x8WHwFAaquuB24O7MfKUeib6pw==
X-Google-Smtp-Source: AGHT+IED/HqLFtACdNSCzdIAMjiljzdhHUspe8O6E5X9FAgkcVHwbKoR9oANRkary8b012uJsnNNw6L8
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:f90:b0:6c1:298e:5a7 with SMTP id
 00721157ae682-6e21d9f2676mr435227b3.5.1727347321787; Thu, 26 Sep 2024
 03:42:01 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:41:19 +0200
In-Reply-To: <20240926104113.80146-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926104113.80146-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3415; i=ardb@kernel.org;
 h=from:subject; bh=x+U+qNnjscbrHmx6YcgJLNHMT4vROYkFANObHeQgRKE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2rVaBDx855y79etX3zniOruepu3tutT/4kaaac3H/9q
 VdHYvucjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRJfGMDLPeRdoFyOhyOd2c
 ffqUd8zxMz2p+foPmpSu3uKavKRtKQ8jw34thinbRFa/qD6buU/y9AuTvefMZK90ymw9clHjOvd cYw4A
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926104113.80146-12-ardb+git@google.com>
Subject: [PATCH 5/5] x86/pvh: Avoid absolute symbol references in .head.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section contains code that may execute from a different
address than it was linked at. This is fragile, given that the x86 ABI
can refer to global symbols via absolute or relative references, and the
toolchain assumes that these are interchangeable, which they are not in
this particular case.

For this reason, all absolute symbol references are being removed from
code that is emitted into .head.text. Subsequently, build time
validation may be added that ensures that no absolute ELF relocations
exist at all in that ELF section.

In the case of the PVH code, the absolute references are in 32-bit code,
which get emitted with R_X86_64_32 relocations, and these are even more
problematic going forward, as it prevents running the linker in PIE
mode.

So update the 64-bit code to avoid _pa(), and to only rely on relative
symbol references: these are always 32-bits wide, even in 64-bit code,
and are resolved by the linker at build time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 30 ++++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index e2ab4c74f596..b2742259ed60 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -6,7 +6,9 @@
 
 	.code32
 	.text
+#ifdef CONFIG_X86_32
 #define _pa(x)          ((x) - __START_KERNEL_map)
+#endif
 #define rva(x)          ((x) - pvh_start_xen)
 
 #include <linux/elfnote.h>
@@ -72,8 +74,7 @@ SYM_CODE_START(pvh_start_xen)
 	movl $0, %esp
 
 	leal rva(gdt)(%ebp), %eax
-	leal rva(gdt_start)(%ebp), %ecx
-	movl %ecx, 2(%eax)
+	addl %eax, 2(%eax)
 	lgdt (%eax)
 
 	mov $PVH_DS_SEL,%eax
@@ -103,10 +104,23 @@ SYM_CODE_START(pvh_start_xen)
 	btsl $_EFER_LME, %eax
 	wrmsr
 
+	/*
+	 * Reuse the non-relocatable symbol emitted for the ELF note to
+	 * subtract the build time physical address of pvh_start_xen() from
+	 * its actual runtime address, without relying on absolute 32-bit ELF
+	 * relocations, as these are not supported by the linker when running
+	 * in -pie mode, and should be avoided in .head.text in general.
+	 */
 	mov %ebp, %ebx
-	subl $_pa(pvh_start_xen), %ebx /* offset */
+	subl rva(xen_elfnote_phys32_entry)(%ebp), %ebx
 	jz .Lpagetable_done
 
+	/*
+	 * Store the resulting load offset in phys_base.  __pa() needs
+	 * phys_base set to calculate the hypercall page in xen_pvh_init().
+	 */
+	movl %ebx, rva(phys_base)(%ebp)
+
 	/* Fixup page-tables for relocation. */
 	leal rva(pvh_init_top_pgt)(%ebp), %edi
 	movl $PTRS_PER_PGD, %ecx
@@ -165,14 +179,6 @@ SYM_CODE_START(pvh_start_xen)
 	xor %edx, %edx
 	wrmsr
 
-	/*
-	 * Calculate load offset and store in phys_base.  __pa() needs
-	 * phys_base set to calculate the hypercall page in xen_pvh_init().
-	 */
-	movq %rbp, %rbx
-	subq $_pa(pvh_start_xen), %rbx
-	movq %rbx, phys_base(%rip)
-
 	/* Call xen_prepare_pvh() via the kernel virtual mapping */
 	leaq xen_prepare_pvh(%rip), %rax
 	addq $__START_KERNEL_map, %rax
@@ -217,7 +223,7 @@ SYM_CODE_END(pvh_start_xen)
 	.balign 8
 SYM_DATA_START_LOCAL(gdt)
 	.word gdt_end - gdt_start - 1
-	.long _pa(gdt_start) /* x86-64 will overwrite if relocated. */
+	.long gdt_start - gdt
 	.word 0
 SYM_DATA_END(gdt)
 SYM_DATA_START_LOCAL(gdt_start)
-- 
2.46.0.792.g87dc391469-goog


