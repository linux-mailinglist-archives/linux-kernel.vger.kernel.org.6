Return-Path: <linux-kernel+bounces-343459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B072989B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7EB1C20E93
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B7152196;
	Mon, 30 Sep 2024 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxQ0lA/n"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C515CD49
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680538; cv=none; b=uknPWOfW1GGVD6v5XboHdCMtAoCKBaw36PVKYAv0z5Ek1ItCoEa3gjCPBAdZJoF6lpfXhkpfptXOXaI/+DxUM4396Uq0Dj6EiV4KV8/O/2KuBry7xazbL2WfDkgncq/xanpaXsMff0tQ4V0Hp37udKNDSGLwslisjedw25PSb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680538; c=relaxed/simple;
	bh=0v9GbO8mXCnuwnjoX5df+7bRgvm1n059fzJD8mSz/yk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lwx4zoSk31jqtXVAEBTdJplSb7aMOaqM+0nOvQFSP25ztfmEiSUTzF64nhW6Vc7U418LnXaEu6B54dn8AafRb7brTpLiV5E8p6Iye2Ka1GP/0o9L2qdlQRsplF/7SI6Lw05x50QR7yc/KOTsvVGCe1ebuGYTT8BZnk/+UmhTl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxQ0lA/n; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e284982a31so3099117b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727680535; x=1728285335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZtPdBpJzFal/ae5MZUqryOcfcvj4AQCvP+gm4JqXyM=;
        b=CxQ0lA/n4BtVO7sn4VlLD3RtgRBDryOFKkzYyLq/qwtDwVZ/FL7iPL6LTN0i1rpjMS
         NpiEAqNXOZ73hOWgBKLHqWQcwsKpd3Juo6PkvCxMGDv27h3zIR5kIxaPFLmOfxXTIQmL
         QIgK/BDGwoMjB0vzUjrHZYJbLuMbeQ15lxUywMaovp5+T/FfhT4hX+hWvXrd+hwapnA9
         tuWN6DBDqinSRBn73upLf0LBuJQD3cSUVyT1i7jmfKMaJkLbtCxtpU/HtDWXDXdTPnVv
         dceWIBvmE/FK2Q+Im2zsGVePoarJduSdRYFjHh0mMhd1IrIxp6CZy7McEvB/AnnTN+oD
         JfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727680535; x=1728285335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZtPdBpJzFal/ae5MZUqryOcfcvj4AQCvP+gm4JqXyM=;
        b=mqzGrRj2YwlW/dAbqHELb+YS9eIO5gOYXo2uo4ocljIQSWEztjQ/31WlpFiFBfHXTp
         xVVY1Dizjrn4W2OYxAIhS/Ft61M3rzQIW0mTqHQ+MmxamD0f058mo+NMXEEM5g89O5kn
         fnZbbDlcD+HDStllci1tk5AMNDF5TH5YqPV8NJDcby0r2l8pPG8fSvprDyciKDk5+RU1
         nnq8vc8tLXkfP45sB/R8hqjUoEv4STbkeUTe2QEY5fbs5QLuxFmbA8SFivm45XJeM4IJ
         l8zRBx4h2njCV8gJTj1h6HeSC67ERELb9WryOH5fm/N/KwtvPgUph0o5zh4SdTujiZa+
         qpHw==
X-Gm-Message-State: AOJu0YxXUQ56GvwmokmBzVGkBfso2wz41OGE3g/bOV/SdWC6S3OCQ/mq
	uEQSt6+f5AKcwpeJavga2VnVZEN4nruKea6pl4PaqOUhMhcDwiSEVYMtY9byvAJNySBEc2KZXe0
	eNZaj2D0tb9qg+JkYCNVuaE2/ugQVH8qT61IPBNcdeS57twH4Dp8RKDSnRhVc0xG3ZjQ/w40Rsu
	PQ09WS8pd3AUv1QTPW2o56rrUuwJke9A==
X-Google-Smtp-Source: AGHT+IFWZtuu+KunSwgcCbh6Ve5BV0dLmNWi2x2HkYFqhNpsABPu4rTN3FrGFoGmcbxLj6A3YyOTzKqH
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:d045:0:b0:dfb:22ca:1efd with SMTP id
 3f1490d57ef6-e2604b828c6mr119309276.9.1727680535050; Mon, 30 Sep 2024
 00:15:35 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:15:18 +0200
In-Reply-To: <20240930071513.909462-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240930071513.909462-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4140; i=ardb@kernel.org;
 h=from:subject; bh=eRJBFQWOqzRm644YDaD03sEDODYtOLqKPjomM9zMcVo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe1XAPuhF2t5+zhSPgu3tTyOidS9aCBp1+yrcNT4n/r00
 JmnTes7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQubGVkmJV+Ys/d2PLAmsCY
 qVKPXi7e52T1MUgu5MSrXwo3Q45OSWFk+F3/bv+942nVjqavFqjqp8r0qphbWB66/EGiOXxZ6qO DLAA=
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930071513.909462-11-ardb+git@google.com>
Subject: [PATCH v2 4/5] x86/xen: Avoid relocatable quantities in Xen ELF notes
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Xen puts virtual and physical addresses into ELF notes that are treated
by the linker as relocatable by default. Doing so is not only pointless,
given that the ELF notes are only intended for consumption by Xen before
the kernel boots. It is also a KASLR leak, given that the kernel's ELF
notes are exposed via the world readable /sys/kernel/notes.

So emit these constants in a way that prevents the linker from marking
them as relocatable. This involves place-relative relocations (which
subtract their own virtual address from the symbol value) and linker
provided absolute symbols that add the address of the place to the
desired value.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 13 +++++++++++++
 arch/x86/platform/pvh/head.S  |  6 +++---
 arch/x86/tools/relocs.c       |  1 +
 arch/x86/xen/xen-head.S       |  6 ++++--
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6726be89b7a6..2b7c8c14c6fd 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -527,3 +527,16 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #endif /* CONFIG_X86_64 */
+
+#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
+xen_elfnote_entry_offset =
+	ABSOLUTE(xen_elfnote_entry) + ABSOLUTE(startup_xen);
+#endif
+xen_elfnote_hypercall_page_offset =
+	ABSOLUTE(xen_elfnote_hypercall_page) + ABSOLUTE(hypercall_page);
+#endif
+#ifdef CONFIG_PVH
+xen_elfnote_phys32_entry_offset =
+	ABSOLUTE(xen_elfnote_phys32_entry) + ABSOLUTE(pvh_start_xen - LOAD_OFFSET);
+#endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 7ca51a4da217..2b0d887e0872 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -52,7 +52,7 @@
 #define PVH_CS_SEL		(PVH_GDT_ENTRY_CS * 8)
 #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
 
-SYM_CODE_START_LOCAL(pvh_start_xen)
+SYM_CODE_START(pvh_start_xen)
 	UNWIND_HINT_END_OF_STACK
 	cld
 
@@ -300,5 +300,5 @@ SYM_DATA_END(pvh_level2_kernel_pgt)
 		     .long KERNEL_IMAGE_SIZE - 1)
 #endif
 
-	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,
-	             _ASM_PTR (pvh_start_xen - __START_KERNEL_map))
+	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY, .global xen_elfnote_phys32_entry;
+		xen_elfnote_phys32_entry: _ASM_PTR xen_elfnote_phys32_entry_offset - .)
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index c101bed61940..3ede19ca8432 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -56,6 +56,7 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 	[S_ABS] =
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
+	"xen_elfnote_.+_offset$|"
 	"VDSO|"
 	"__kcfi_typeid_|"
 	"__crc_)",
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 758bcd47b72d..3deaae3601f7 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -94,7 +94,8 @@ SYM_CODE_END(xen_cpu_bringup_again)
 	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR __START_KERNEL_map)
 	/* Map the p2m table to a 512GB-aligned user address. */
 	ELFNOTE(Xen, XEN_ELFNOTE_INIT_P2M,       .quad (PUD_SIZE * PTRS_PER_PUD))
-	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
+	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          .globl xen_elfnote_entry;
+		xen_elfnote_entry: _ASM_PTR xen_elfnote_entry_offset - .)
 	ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,       .ascii "!writable_page_tables")
 	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz "yes")
 	ELFNOTE(Xen, XEN_ELFNOTE_L1_MFN_VALID,
@@ -115,7 +116,8 @@ SYM_CODE_END(xen_cpu_bringup_again)
 #else
 # define FEATURES_DOM0 0
 #endif
-	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, _ASM_PTR hypercall_page)
+	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, .globl xen_elfnote_hypercall_page;
+		xen_elfnote_hypercall_page: _ASM_PTR xen_elfnote_hypercall_page_offset - .)
 	ELFNOTE(Xen, XEN_ELFNOTE_SUPPORTED_FEATURES,
 		.long FEATURES_PV | FEATURES_PVH | FEATURES_DOM0)
 	ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz "generic")
-- 
2.46.1.824.gd892dcdcdd-goog


