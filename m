Return-Path: <linux-kernel+bounces-343460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D33989B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80A61F2253F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84916B391;
	Mon, 30 Sep 2024 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYvt9ry3"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62E165EFC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680540; cv=none; b=qzFtCdQXnCAKXRkKAxGetIkMD3qjbiXuS8JYgCZemtG99dNQj89kngegBzGCf+J1rmv7u+kycZx25q5GHw0rwZLTMVbkhl86/xBXaoan6GVHg0e1ZnrV1M9scHF/U7ZfUmS9NkJNKRRUlH/RxHK9GoL0OjzYje+3IJTvZyK53yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680540; c=relaxed/simple;
	bh=IsJuvBV+H/k7uttc1b8/h5o3gFUL5UfB3UPoocTTsgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NUi+2Xl44+IfCWo133OYOapWOK+OhIXRHBFsBbm7PXAua6v3d91xPcu8tAgVgRaArXHiXFOp362IrOQRFs0U8OBsQwKsRft56pQggJq2JhpA66Vk0JBVbQsZ9NQCnlp5nJK+S0LkSi+J+TrixWXmXAzDVGC9eIa+hofKMgNwjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYvt9ry3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e260b122770so3037266276.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727680537; x=1728285337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CFvtg1tsmmc7nnsyP1PbKrXmu+3EkOxGHWY/dTtKRQ=;
        b=FYvt9ry3qCFr5PH3TXXzjIw7z3rmDVdMLrh+R2hjhcW0L1LUOgZ4LM+3HFfSi/tuEc
         GKWTAM/vNJgTyU2RfEYvLAYp4v/Op/vVHN0LyGeh+LYOFTqCZoejrOYWowUTyS8YQS41
         /WasEfT4Rxe0GZfhdbc2p5za1vB0XZX+sJhWa4uS4zKkgp5HaFEVRhkIrzYcrlFwnydp
         TTl5PooINK/aj2s9lbpMV84u7t6MOfCYXsleBZWPFXaUrmnkbyYpV8knS6CxpnobP4kP
         uPrRgkAlhA4nKd0Xf7/gTi86FBgN9yacRBT2N/ZJaF2JLZKcenFNR9t6YacloVOJNI6b
         OfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727680537; x=1728285337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CFvtg1tsmmc7nnsyP1PbKrXmu+3EkOxGHWY/dTtKRQ=;
        b=QSDKJUTcwa9iwUDndpmlmWium0rv4rgxnKtwXTUpNfGw/gfoMuyyakVmoWC1hPvsji
         TKx/4z/JAlZvq5n1gzaWFNByif20FUJKPNTlsgvsbhiBlhhmOhMJBwNDgWSzHPkqg/K0
         EgSY7T/+6QoQq64VEPw4GMqVzkwJEBhy/Cibq2CtU0vsX2wDcEAoHDFQZAS/Aop19xIA
         jv7/lSOb8bdSbBWebNQ/QqcEDiJLJw/UsJImxOyYCdNL0O7WqJdO7EZIA2Tm1MgqOWrB
         +35sXjHm0/oiWOuUFoRK3wpIMrjidLseH18v6LDsXbb0yGGCxxU05wIBNRNEYDgjNfH2
         dmqw==
X-Gm-Message-State: AOJu0Yy/PgMK6uZnUowFymgOlspb7WX4/VbAgG3PDMzSvXeHnG1xSH5q
	W3bJbXyx/lUwcELJ+8NS1cIguvJHFhxLzIEH+h51Dw2QEH6nYh/tZ+zII+ZbhmjGRrMO3Ngh42F
	MI86AZqZaEJ3x+75EGWv8GwR6SY+symQIj6EKBHiiftVvecn//GyzzOeUIQ8ICSMsBVHWjrohn3
	44pfSWM3jXEsZ+fXpRHb3qUQbpitpMoQ==
X-Google-Smtp-Source: AGHT+IFA41+aY1vjA3qRLYDvZ5y36Ykxv072kp8hE6GaWoKZfJQ0OURO8Mgln/pCtspPyxRtv5RBaV37
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:b2a5:0:b0:e20:1596:87b8 with SMTP id
 3f1490d57ef6-e2604c96b81mr122133276.11.1727680537310; Mon, 30 Sep 2024
 00:15:37 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:15:19 +0200
In-Reply-To: <20240930071513.909462-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240930071513.909462-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3514; i=ardb@kernel.org;
 h=from:subject; bh=egKJbcLb5hGkTqo8SwRF/Pu4TXJQbEy7JOjiJJa0ERg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe1XAEestNQGk6l50lmPs5eufzv/6Lmly76atGQ+v9Td+
 ewGZyprRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiI/HmG/+4pHxsFSpvWz+3h
 OKl79PF2Vud3V+eaLVi24Y1424yTaUsYGXatXdDioZAscT/1TO/jQ6Gq9w1elZ7/7bfv2KxbgaU /y1gB
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930071513.909462-12-ardb+git@google.com>
Subject: [PATCH v2 5/5] x86/pvh: Avoid absolute symbol references in .head.text
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
which gets emitted with R_X86_64_32 relocations, and these are even more
problematic going forward, as it prevents running the linker in PIE
mode.

So update the 64-bit code to avoid _pa(), and to only rely on relative
symbol references: these are always 32-bits wide, even in 64-bit code,
and are resolved by the linker at build time.

Reviewed-by: Jason Andryuk <jason.andryuk@amd.com>
Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 30 ++++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 2b0d887e0872..cf89b2385c5a 100644
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
 	subq phys_base(%rip), %rax
@@ -218,7 +224,7 @@ SYM_CODE_END(pvh_start_xen)
 	.balign 8
 SYM_DATA_START_LOCAL(gdt)
 	.word gdt_end - gdt_start - 1
-	.long _pa(gdt_start) /* x86-64 will overwrite if relocated. */
+	.long gdt_start - gdt
 	.word 0
 SYM_DATA_END(gdt)
 SYM_DATA_START_LOCAL(gdt_start)
-- 
2.46.1.824.gd892dcdcdd-goog


