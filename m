Return-Path: <linux-kernel+bounces-331475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AD197AD5B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9278283B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295BD15B99D;
	Tue, 17 Sep 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="plNwJW+E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ve3MJk/X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24224155A4E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563255; cv=none; b=FF7d7I0hok/Sn+Pp2Z5zi/muIpm5qNFeA2LTI2l70GNsK6bvSSxVdGytqcoaiNPmW631lmf46n2/X/mH2Jnu09YZ1B5cIna4SDoN9Yl/HvG+CMRoVhGq7VsMJGqZV0lNTVitiHH9WnSLUf9y4LjrdPTFYaV4jlTCLfTc1MHd5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563255; c=relaxed/simple;
	bh=vQ0H1uIwaT7gJj5F3xqVzDbLIu3aPEwgTlEYJEE/8Tk=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=bEpCyRNH1jJ6XtR7dxRwIGVbIHozAFiX0SyBXVQcp9Uy1aizK274tDpdw7sS7XulktHYULrb1WBYeUn6cU5rbIHgt0nYy8HMK6mxMrE4YyIe09mjZqj/bWxfzwmhESnOGlaBgznUbwKPPHkGMipBevRT8vls9sXVszv4NC5047A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=plNwJW+E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ve3MJk/X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726563251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=WBzmrmC7fPAF+cDv348cvIsvJUWlDnaq9+dFljm9VtQ=;
	b=plNwJW+EfdM2o3zoCjHstf9+VkbuVnXeegfDigymHdPqT2x1dhYHDcELfXTjJC9Eq6G1N4
	DGPRT20eRtZDP4Px0r5JbK4YVv3opZIt36JzPlPh0q1H82iZ54HYdrj6r8QXzR9hSnvA2r
	s4QPuXaeH6fDpbQsZ8WAI1bOiKatHg5+9oPEl1SduU9jbdBdlP2JNzqwyzZdwQXzP+9IV5
	Ia5LV21vpw/ASrAK9UKzz57vsrhG8Aa8ogHnqQ6+9yWsAH5GOVulI3BdUCMQwCncLdbWUW
	ZB0RzT7KcoLGJNMcDgbb4dIkIQWfYCf5JyfkEzCh3XItMjgfraNdWIw5ws1agw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726563251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=WBzmrmC7fPAF+cDv348cvIsvJUWlDnaq9+dFljm9VtQ=;
	b=ve3MJk/Xt6MigG7/v7YEfiRXv4PYYYCi/l6Eg5HjFWGYjOBK1FtGYQVgWUYce2rJBrEC/H
	acteoiEtfNcztbCg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/fpu for v6.12-rc1
References: <172656198112.2471820.6226852046770294674.tglx@xen13>
Message-ID: <172656198744.2471820.14081573146419941141.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 10:54:10 +0200 (CEST)

Linus,

please pull the latest x86/fpu branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2024-09-=
17

up to:  ba386777a30b: x86/elf: Add a new FPU buffer layout info to x86 core f=
iles

Provide FPU buffer layout in core dumps:

  Debuggers have guess the FPU buffer layout in core dumps, which is error
  prone. This is because AMD and Intel layouts differ.

  To avoid buggy heuristics add a ELF section which describes the buffer
  layout which can be retrieved by tools.

Thanks,

	tglx

------------------>
Vignesh Balasubramanian (1):
      x86/elf: Add a new FPU buffer layout info to x86 core files


 arch/x86/Kconfig                |  1 +
 arch/x86/include/uapi/asm/elf.h | 16 ++++++++
 arch/x86/kernel/fpu/xstate.c    | 89 +++++++++++++++++++++++++++++++++++++++=
++
 fs/binfmt_elf.c                 |  4 +-
 include/uapi/linux/elf.h        |  1 +
 5 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/uapi/asm/elf.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..c15b4b3fb328 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -107,6 +107,7 @@ config X86
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_EXTRA_ELF_NOTES
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/x86/include/uapi/asm/elf.h b/arch/x86/include/uapi/asm/elf.h
new file mode 100644
index 000000000000..468e135fa285
--- /dev/null
+++ b/arch/x86/include/uapi/asm/elf.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_X86_ELF_H
+#define _UAPI_ASM_X86_ELF_H
+
+#include <linux/types.h>
+
+struct x86_xfeat_component {
+	__u32 type;
+	__u32 size;
+	__u32 offset;
+	__u32 flags;
+} __packed;
+
+_Static_assert(sizeof(struct x86_xfeat_component) % 4 =3D=3D 0, "x86_xfeat_c=
omponent is not aligned");
+
+#endif /* _UAPI_ASM_X86_ELF_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5a026fee5e0..f3a2e59a28e7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
+#include <linux/coredump.h>
=20
 #include <asm/fpu/api.h>
 #include <asm/fpu/regset.h>
@@ -23,6 +24,8 @@
 #include <asm/prctl.h>
 #include <asm/elf.h>
=20
+#include <uapi/asm/elf.h>
+
 #include "context.h"
 #include "internal.h"
 #include "legacy.h"
@@ -1838,3 +1841,89 @@ int proc_pid_arch_status(struct seq_file *m, struct pi=
d_namespace *ns,
 	return 0;
 }
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
+
+#ifdef CONFIG_COREDUMP
+static const char owner_name[] =3D "LINUX";
+
+/*
+ * Dump type, size, offset and flag values for every xfeature that is presen=
t.
+ */
+static int dump_xsave_layout_desc(struct coredump_params *cprm)
+{
+	int num_records =3D 0;
+	int i;
+
+	for_each_extended_xfeature(i, fpu_user_cfg.max_features) {
+		struct x86_xfeat_component xc =3D {
+			.type   =3D i,
+			.size   =3D xstate_sizes[i],
+			.offset =3D xstate_offsets[i],
+			/* reserved for future use */
+			.flags  =3D 0,
+		};
+
+		if (!dump_emit(cprm, &xc, sizeof(xc)))
+			return 0;
+
+		num_records++;
+	}
+	return num_records;
+}
+
+static u32 get_xsave_desc_size(void)
+{
+	u32 cnt =3D 0;
+	u32 i;
+
+	for_each_extended_xfeature(i, fpu_user_cfg.max_features)
+		cnt++;
+
+	return cnt * (sizeof(struct x86_xfeat_component));
+}
+
+int elf_coredump_extra_notes_write(struct coredump_params *cprm)
+{
+	int num_records =3D 0;
+	struct elf_note en;
+
+	if (!fpu_user_cfg.max_features)
+		return 0;
+
+	en.n_namesz =3D sizeof(owner_name);
+	en.n_descsz =3D get_xsave_desc_size();
+	en.n_type =3D NT_X86_XSAVE_LAYOUT;
+
+	if (!dump_emit(cprm, &en, sizeof(en)))
+		return 1;
+	if (!dump_emit(cprm, owner_name, en.n_namesz))
+		return 1;
+	if (!dump_align(cprm, 4))
+		return 1;
+
+	num_records =3D dump_xsave_layout_desc(cprm);
+	if (!num_records)
+		return 1;
+
+	/* Total size should be equal to the number of records */
+	if ((sizeof(struct x86_xfeat_component) * num_records) !=3D en.n_descsz)
+		return 1;
+
+	return 0;
+}
+
+int elf_coredump_extra_notes_size(void)
+{
+	int size;
+
+	if (!fpu_user_cfg.max_features)
+		return 0;
+
+	/* .note header */
+	size  =3D sizeof(struct elf_note);
+	/*  Name plus alignment to 4 bytes */
+	size +=3D roundup(sizeof(owner_name), 4);
+	size +=3D get_xsave_desc_size();
+
+	return size;
+}
+#endif /* CONFIG_COREDUMP */
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 19fa49cd9907..01bcbe7fdebd 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2039,7 +2039,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	{
 		size_t sz =3D info.size;
=20
-		/* For cell spufs */
+		/* For cell spufs and x86 xstate */
 		sz +=3D elf_coredump_extra_notes_size();
=20
 		phdr4note =3D kmalloc(sizeof(*phdr4note), GFP_KERNEL);
@@ -2103,7 +2103,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	if (!write_note_info(&info, cprm))
 		goto end_coredump;
=20
-	/* For cell spufs */
+	/* For cell spufs and x86 xstate */
 	if (elf_coredump_extra_notes_write(cprm))
 		goto end_coredump;
=20
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b54b313bcf07..e30a9b47dc87 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -411,6 +411,7 @@ typedef struct elf64_shdr {
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
 /* Old binutils treats 0x203 as a CET state */
 #define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
+#define NT_X86_XSAVE_LAYOUT	0x205	/* XSAVE layout description */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */


