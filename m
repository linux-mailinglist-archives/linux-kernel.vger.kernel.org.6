Return-Path: <linux-kernel+bounces-340339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A2A9871CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB73C1F28DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694241AED4C;
	Thu, 26 Sep 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0+Dv2iq"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309411AED35
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347322; cv=none; b=chTjnlIjAkuGo2YYtSoupXZeDs48yxFMaAjXssW+OG+iL0PEIEJ+s6Jb3c6IITMbljHgpgXKfN3pAtu+i2eSTh0Uym9B8Ru8FqORfEIAGXqKw+2n5dqgjMlRqFDgQ9Sv+gIlRIy/x5GS/0f25JaVJPJl+4FeQyLpc78Hn2ADHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347322; c=relaxed/simple;
	bh=54SWPL39oOvkpQqhC6U3qeiKv7WOrvQz8DdDkuyEg3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lsfk4rRCqyJNJv/TZS9reI+S3/ayprs4oOfmhXPAAepJKNQJKQ1c1t9U1HBnN6UQI2yy7kqpWVL9ntGeVlCA5k9hvIw9aAo4mKCekOMG+C+pd8AJFOJ374o7uDhSZSmLKBDIj5vm10oME6Zl+TTN7mk4bgZeWdubJ9y+9corao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0+Dv2iq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2317d1cb7so10051227b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727347320; x=1727952120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVQAOpFtZ+IFLD65Dag6PltLcshQiZuKZHS02xe9k5U=;
        b=A0+Dv2iqVOwnYtsiws1H26Lmu9LzFaM0qJSiaRPjscsAQG0KUQc63z6kjyogox0uQC
         8TlI53EqorjcMjru1hOralcqnbn/QgLkUn8AIFwcUhBTtPWZWOjWnkQhvZdzxPYghIqK
         g9GQAjiTJKDjd3u+lH7kP7aZiv6m/Rdc3nEyEBACsg7RM25MNfAL1+XDqFcKRtVdiNz6
         lofdALDY5TRckzGbFcHUz8cseRuNWCqapfe9ArTZq4ptQrRTJnO+yTZ6EpJ3/GNSrFd3
         Qh5oavBty+I++8LZhg9TXCJMUZH2foFYkxVEc/GozhSSxALHY/djwvxmWO9JazF5NLrR
         6dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347320; x=1727952120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVQAOpFtZ+IFLD65Dag6PltLcshQiZuKZHS02xe9k5U=;
        b=KzFnUGomdvvXjH3O8dcnUqjvvWi4ZRgLj5TUkPsuvHRUTOJp3A7IG22Zfimw5BSgRG
         m65fAoNkQJO8A8yoh77a0O4LPHNb3563ZONDU0foKCCzhoUjmI5NC5H3b16Jp6lzqSpQ
         etrFGhlT1Nzj7w7MRPcmcqdQ2IcaO5Vh7/EDZxm/7x735V03XxjJeMz21ehWoQDd33Va
         /+nKUXj13kA8XEgm4WtTH7ANH+wDK2Fve9ssS75e52NOMbndHA5A6pHBYWYqzxvvaaYb
         T4CljEjLNfWysseE66xHTt4CnKhk+Wl39qPN05Sehq8DX+FsEJqejo3we6xOjJ1Srotp
         iv+A==
X-Gm-Message-State: AOJu0Yz6A63PWm1LK6pj4yFlg57iSm3+Av0T5xgVBzDUVs7lnWRKnk9K
	aX0qhHmREdR2jNfC9LvVw611MQ/dC6boKuv2KMHo9eZS5yGufGlwkAezM6NebXI3yGQTgv0azQb
	Fw7DuGyK0vYzbeNYDC62QNXkV25/FuEKLRVn7iElZ8iP2telVIGn0Q3tMyYGc7KpTXTrIhgReAs
	kZJT3Q6Mr6UKmB20DJSZl08avkjHqaxQ==
X-Google-Smtp-Source: AGHT+IGFqzFJ5DM6fuJFCR9nZvBpCXoaxNKegwYh6rQwKhd8Opr932KfMh+UgrKPITetFqVET84sn/lt
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:d85:b0:6db:e107:75a2 with SMTP id
 00721157ae682-6e21da5c761mr677017b3.4.1727347319432; Thu, 26 Sep 2024
 03:41:59 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:41:18 +0200
In-Reply-To: <20240926104113.80146-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926104113.80146-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4265; i=ardb@kernel.org;
 h=from:subject; bh=V807GS2Tj3E3lwWN+K0J1jVOybFlVVUTSd+sKKD/vLg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2rVcAFH7mbsx6l51p3OK/XkT7d39ii1zab++TUyPqe6
 dzqXu87SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERMtjIy/Lorcfi/7fSyDmlr
 bgmlmHNfalct0FVotHljq82yv2j2Z4b/tTuXXZiuvNlx21qDp+Kncn/93HKUh2/Hq8SWB7kzTk5 nZQQA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926104113.80146-11-ardb+git@google.com>
Subject: [PATCH 4/5] x86/xen: Avoid relocatable quantities in Xen ELF notes
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

While at it, switch to a 32-bit field for XEN_ELFNOTE_PHYS32_ENTRY,
which better matches the intent as well as the Xen documentation and
source code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 12 ++++++++++++
 arch/x86/platform/pvh/head.S  |  6 +++---
 arch/x86/tools/relocs.c       |  1 +
 arch/x86/xen/xen-head.S       |  6 ++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6e73403e874f..dce17afcc186 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -528,3 +528,15 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #endif /* CONFIG_X86_64 */
+
+#ifdef CONFIG_XEN_PV
+xen_elfnote_entry_offset =
+	ABSOLUTE(xen_elfnote_entry) + ABSOLUTE(startup_xen);
+xen_elfnote_hypercall_page_offset =
+	ABSOLUTE(xen_elfnote_hypercall_page) + ABSOLUTE(hypercall_page);
+#endif
+
+#ifdef CONFIG_PVH
+xen_elfnote_phys32_entry_offset =
+	ABSOLUTE(xen_elfnote_phys32_entry) + ABSOLUTE(pvh_start_xen - LOAD_OFFSET);
+#endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 592747f2d731..e2ab4c74f596 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -52,7 +52,7 @@
 #define PVH_CS_SEL		(PVH_GDT_ENTRY_CS * 8)
 #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
 
-SYM_CODE_START_LOCAL(pvh_start_xen)
+SYM_CODE_START(pvh_start_xen)
 	UNWIND_HINT_END_OF_STACK
 	cld
 
@@ -299,5 +299,5 @@ SYM_DATA_END(pvh_level2_kernel_pgt)
 		     .long KERNEL_IMAGE_SIZE - 1)
 #endif
 
-	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,
-	             _ASM_PTR (pvh_start_xen - __START_KERNEL_map))
+	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY, .global xen_elfnote_phys32_entry;
+		xen_elfnote_phys32_entry: .long xen_elfnote_phys32_entry_offset - .)
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
2.46.0.792.g87dc391469-goog


