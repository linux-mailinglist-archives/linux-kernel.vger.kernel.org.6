Return-Path: <linux-kernel+bounces-357431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E33997123
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FA21C212C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85E81E909A;
	Wed,  9 Oct 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULu7JkEG"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE1F1EABC6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490159; cv=none; b=E++MvvEIi9XsRTyYOhetWyGaYMU7oSgEyeSCepm2Z7pCqjbrxp92DEuqHUkuGaCyoPeAfetsdlleb4MUmPcA2UuAfB9rIpjnwt0BGMzNZ8+p/yfDbNK0bv7MoE4s8BwsnAz7juIZ0Sl9qqUEceYXWcP3auDG/szd9O42ZJPiHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490159; c=relaxed/simple;
	bh=pL//0qcr9Tz7E2ekIXYnOj8H6vKZ2yTe3/02guDyE4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qjpJoYtt2/hDDpogX6RWfdZXDYdWQz4WuZnGhErGIPACNSH9xNumyrdl+0Rrbp0jB3hU0YnMIqQDS/vbNlwQ0MV1mAP4u1dTTFj4wHlASqs6gWUalc4rCeYcQVvyrZqRYOqQNzI1eQ1k8Qcc9cu41I2CSWSCaaOezs4tRHhdNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULu7JkEG; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43114c476c2so2157575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728490156; x=1729094956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HupRAXXBqO2c8knr9kCujOHZqjOYFZu7/+ot2dyBYgU=;
        b=ULu7JkEGeqVxnJQIG3Kopy0b9HhOTD3y3TMaJwwMp+nqWLETaam5NbW3BtNjrPVh59
         XEjjx9G+AldEJDgEsHRCv8oA5+I6Pkf2hdpLJhyfdIH3hr0+TMEYaMDaYfxn7ec7R4ul
         3Khhq8I1DtMg3I8X1OsW+2aD4PLTVxoSE3MQMRNL8u2A6fIq3E355MlKWYcovYeoiA5s
         hOplJL9pje5Z1yWA3ynplEoEpRNNuFzav93Lza//eJK5zMxAivLnJhgctBgIiE/CZHgX
         iEDkRIFJFA55euIda9hruvIy/w6QeLPwJKzHmxCks/C+48ofp2wc768Sq6fAbyf/N61S
         yUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490156; x=1729094956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HupRAXXBqO2c8knr9kCujOHZqjOYFZu7/+ot2dyBYgU=;
        b=NFPhK608sADBgpYSbGcUJR87eP8xYN20Ebk/l/cH5ACypktMH1bzuErKDGzWLJLZY5
         SWoikEUrBG9LQCv7oa6JhHXGA8IjUhuaWl/HOf9fqZqQMzZmTOZdOFCBZaQ+TxZzJ8D7
         88ksVmv2+DlLtZjEIjSFRYoPCU63Ztd/586khzSIbvyPoUbV/YQjT03tD7iQ1Yz/TMN6
         JEWG0rUNzHQlw/+LTTdPneUp2dyFsiD37z1DmLxGfG0/TkWOwXBSScbAun7zucuDUgmv
         BLlzdeUxiCV1VUWxKD4Jh4x0QDvOvqGtxAzEPTo0RDXQum6fMgQ6+hZayAsnTfsiAs24
         k9lw==
X-Gm-Message-State: AOJu0YysmBndN/PsfKHyzHbD8fFWFpPbnWF4/fHqdonSatZJHLNdaHhS
	DqRzMZRi+fNK01J8W9xuKPDkyO7eSGqEYs8EpcLk1X2CvhAl6xoYo7esYkSuVSRRMJn6gnz0kTS
	5aQPWugA0JQJ2VqdRPs0RyTEtPR7onU3VSo4wasBWYVzN5j7PcueD3pHTl/zv3f/UUagAnmKsUV
	xqh+hLpjEqHG+UtKJifRZpy3gNzgpRgg==
X-Google-Smtp-Source: AGHT+IF0eoXWAHq3au8yX0LdvnbgYQERBk447P9771B7f8cbOEk+/t/HPey2CQbVWfl9cygw+xLeM33/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:331b:b0:426:67e0:3b2 with SMTP id
 5b1f17b1804b1-430ccefabddmr20795e9.1.1728490155371; Wed, 09 Oct 2024 09:09:15
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:04:44 +0200
In-Reply-To: <20241009160438.3884381-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009160438.3884381-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3518; i=ardb@kernel.org;
 h=from:subject; bh=6GoieogoUAEj17Av6HLsT2CSmywAr8csNjqtL7xNpKA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1t5TzXWXXdV5/qr9v97+vxsDkHP999MSFXzvk3C9cBl
 rO2X9o8O0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEZl1iZHghPLHULP3cMp+6
 cz9NT5ow3TPcfrzua0qmU4Dg27SDJ48z/E84sEs74ejfB2lTLTI6z0zttAue3telfDGjOslWYfl nez4A
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009160438.3884381-12-ardb+git@google.com>
Subject: [PATCH v3 5/5] x86/pvh: Avoid absolute symbol references in .head.text
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
index e6f39d77f0b4..4733a5f467b8 100644
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
2.47.0.rc0.187.ge670bccf7e-goog


