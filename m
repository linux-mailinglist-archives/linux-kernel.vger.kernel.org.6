Return-Path: <linux-kernel+bounces-401551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822159C1C2B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987B01C22606
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356881E47A1;
	Fri,  8 Nov 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ijqKXWYB"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040353FB9C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065278; cv=none; b=f6oloaF3unYYI0Rz+jSImBLyG1oWpOF+21BzRDuhNrNFog0KLtPXl6Pa4Tyi8i8D0HvFn3y0rcf5Iy7X0CUODlPbPFfTmrSgPUlGiekRtL4BwZNqT0wWWcyBJ+ZJQeNaiISIR5clSuK1kbCVvyew6lzI1Yj8BadoHdAKdH3OPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065278; c=relaxed/simple;
	bh=gB/i0XDh9py485pmbTc+6MxGbVcC7YBSy6LE9x80AG8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cv8KRuAmRR56FeMeAkI35mUhGggUVwpig7a7RqdG48BE9AM6Rn5MlUz9YV3MmuPW8gk1D855ytjOEmgtA4WP5aHv6GIKciU/ZvBTFx745XzRYkqiHlhDAr7xPI3RS3hvA3h86MaX/mKU1d/hGkygHOoVO2fvBLVzOCGhp+Bdv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ijqKXWYB; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([90.224.241.145])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A8BR6No1572977
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 8 Nov 2024 03:27:08 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A8BR6No1572977
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731065230;
	bh=vOsvObPe5zuM8YWcsPRBouiqIIxLSuRfqmNeDX2RKtk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ijqKXWYBKzQaQjxtmrYFGYmA04k6Ub3FpBDVWBzU1WYbMfqShC4HRyE2UsDvwzZF8
	 e//rk7rQjZZAtUjCZA6qlO/vVJFWSPNPcu7tlgvD5L0cjAN7L4guhUDEGs6iJn+q/V
	 exe1LZ2yJ/GKIOvAiThtusWs4GYnbcwv1s58BFlplS6+TX3ooSk9qN+tEQPuqc9rzP
	 xLo1PvewaGrCJsbNidH1lW+rqJxLkvwh5PqUhVJhZw0GGSIvVMVvFI9lz3Db67j7DK
	 pFvcBft5p0irlJ9HrBtlFBEJ1sPa/ezzVOwuiGEbzTWhIDRgT78avP5UNO/JLZV7hn
	 y8cXE5V/yYIeg==
Date: Fri, 08 Nov 2024 12:26:58 +0100
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Woodhouse <dwmw2@infradead.org>, kexec@lists.infradead.org
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>, linux-kernel@vger.kernel.org,
        Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH 2/2] x86/kexec: Add data section to relocate_kernel
User-Agent: K-9 Mail for Android
In-Reply-To: <20241108052241.3972433-2-dwmw2@infradead.org>
References: <1983c62c02b863f6d70198730dbb55a1ef7ceb9f.camel@infradead.org> <20241108052241.3972433-1-dwmw2@infradead.org> <20241108052241.3972433-2-dwmw2@infradead.org>
Message-ID: <B26FDB75-D8F3-4D9C-9078-C536C461A7CF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2024 6:22:41 AM GMT+01:00, David Woodhouse <dwmw2@infradead=
=2Eorg> wrote:
>From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>
>Now that it's handled sanely by a linker script we can have actual data,
>and just use %rip-relative addressing to access it=2E
>
>If we could call the *copy* instead of the original relocate_kernel in
>the kernel text, then we could use %rip-relative addressing everywhere=2E
>
>Signed-off-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>---
> arch/x86/kernel/relocate_kernel_64=2ES | 58 ++++++++++++++++------------
> arch/x86/kernel/vmlinux=2Elds=2ES        |  2 +-
> 2 files changed, 35 insertions(+), 25 deletions(-)
>
>diff --git a/arch/x86/kernel/relocate_kernel_64=2ES b/arch/x86/kernel/rel=
ocate_kernel_64=2ES
>index 1efcbd340528=2E=2E577aa1672349 100644
>--- a/arch/x86/kernel/relocate_kernel_64=2ES
>+++ b/arch/x86/kernel/relocate_kernel_64=2ES
>@@ -27,18 +27,28 @@
>  * ~ control_page + PAGE_SIZE are used as data storage and stack for
>  * jumping back
>  */
>-#define DATA(offset)		(KEXEC_CONTROL_CODE_MAX_SIZE+(offset))
>=20
>+	=2Esection =2Edata=2Erelocate_kernel,"a";
> /* Minimal CPU state */
>-#define RSP			DATA(0x0)
>-#define CR0			DATA(0x8)
>-#define CR3			DATA(0x10)
>-#define CR4			DATA(0x18)
>-
>+SYM_DATA_LOCAL(saved_rsp, =2Equad 0)
>+SYM_DATA_LOCAL(saved_cr0, =2Equad 0)
>+SYM_DATA_LOCAL(saved_cr3, =2Equad 0)
>+SYM_DATA_LOCAL(saved_cr4, =2Equad 0)
> /* other data */
>-#define CP_PA_TABLE_PAGE	DATA(0x20)
>-#define CP_PA_SWAP_PAGE		DATA(0x28)
>-#define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
>+SYM_DATA_LOCAL(pa_table_page, =2Equad 0)
>+SYM_DATA_LOCAL(pa_swap_page, =2Equad 0)
>+SYM_DATA_LOCAL(pa_backup_pages_map, =2Equad 0)
>+
>+/*
>+ * There are two physical copies of relocate_kernel(), one in the origin=
al
>+ * Kernel text and the other copied to the control page=2E There is a vi=
rtual
>+ * mapping of each, in the original kernel=2E It is the *original* which=
 is
>+ * called from machine_kexec(), largely becaose the copy isn't mapped as=
 an
>+ * executable page=2E Thus, this code cannot just use %rip-relative addr=
essing
>+ * until after the %cr3 change and the jump to identity_mapped()=2E Unti=
l
>+ * then, some pointer arithmetic is required=2E
>+ */
>+#define DATA(x) (x - relocate_kernel)
>=20
> 	=2Esection =2Etext=2Erelocate_kernel,"ax";
> 	=2Ecode64
>@@ -63,13 +73,13 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
> 	pushf
>=20
> 	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
>-	movq	%rsp, RSP(%r11)
>+	movq	%rsp, DATA(saved_rsp)(%r11)
> 	movq	%cr0, %rax
>-	movq	%rax, CR0(%r11)
>+	movq	%rax, DATA(saved_cr0)(%r11)
> 	movq	%cr3, %rax
>-	movq	%rax, CR3(%r11)
>+	movq	%rax, DATA(saved_cr3)(%r11)
> 	movq	%cr4, %rax
>-	movq	%rax, CR4(%r11)
>+	movq	%rax, DATA(saved_cr4)(%r11)
>=20
> 	/* Save CR4=2E Required to enable the right paging mode later=2E */
> 	movq	%rax, %r13
>@@ -94,9 +104,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
> 	movq	PTR(PA_SWAP_PAGE)(%rsi), %r10
>=20
> 	/* save some information for jumping back */
>-	movq	%r9, CP_PA_TABLE_PAGE(%r11)
>-	movq	%r10, CP_PA_SWAP_PAGE(%r11)
>-	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
>+	movq	%r9, DATA(pa_table_page)(%r11)
>+	movq	%r10, DATA(pa_swap_page)(%r11)
>+	movq	%rdi, DATA(pa_backup_pages_map)(%r11)
>=20
> 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx=2E */
> 	movq	%rcx, %r11
>@@ -128,7 +138,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> 	/* set return address to 0 if not preserving context */
> 	pushq	$0
> 	/* store the start address on the stack */
>-	pushq   %rdx
>+	pushq   start_address(%rip)
>=20
> 	/*
> 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
>@@ -227,9 +237,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> 	/* get the re-entry point of the peer system */
> 	movq	0(%rsp), %rbp
> 	leaq	relocate_kernel(%rip), %r8
>-	movq	CP_PA_SWAP_PAGE(%r8), %r10
>-	movq	CP_PA_BACKUP_PAGES_MAP(%r8), %rdi
>-	movq	CP_PA_TABLE_PAGE(%r8), %rax
>+	movq	pa_swap_page(%rip), %r10
>+	movq	pa_backup_pages_map(%rip), %rdi
>+	movq	pa_table_page(%rip), %rax
> 	movq	%rax, %cr3
> 	lea	PAGE_SIZE(%r8), %rsp
> 	call	swap_pages
>@@ -243,11 +253,11 @@ SYM_CODE_END(identity_mapped)
> SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
> 	UNWIND_HINT_END_OF_STACK
> 	ANNOTATE_NOENDBR // RET target, above
>-	movq	RSP(%r8), %rsp
>-	movq	CR4(%r8), %rax
>+	movq	saved_rsp(%rip), %rsp
>+	movq	saved_cr4(%rip), %rax
> 	movq	%rax, %cr4
>-	movq	CR3(%r8), %rax
>-	movq	CR0(%r8), %r8
>+	movq	saved_cr3(%rip), %rax
>+	movq	saved_cr0(%r8), %r8
> 	movq	%rax, %cr3
> 	movq	%r8, %cr0
> 	movq	%rbp, %rax
>diff --git a/arch/x86/kernel/vmlinux=2Elds=2ES b/arch/x86/kernel/vmlinux=
=2Elds=2ES
>index ad451371e179=2E=2E65f879b31a82 100644
>--- a/arch/x86/kernel/vmlinux=2Elds=2ES
>+++ b/arch/x86/kernel/vmlinux=2Elds=2ES
>@@ -100,7 +100,7 @@ const_pcpu_hot =3D pcpu_hot;
> 	=2E =3D ALIGN(PAGE_SIZE);					\
> 	__relocate_kernel_start =3D =2E;				\
> 	*(=2Etext=2Erelocate_kernel);				\
>-	*(=2Erodata=2Erelocate_kernel);				\
>+	*(=2Edata=2Erelocate_kernel);				\
> 	__relocate_kernel_end =3D =2E;
> #else
> #define KEXEC_RELOCATE_KERNEL_TEXT

Looks good at first glance=2E I'm currently traveling so I haven't fully r=
eviewed it though=2E

