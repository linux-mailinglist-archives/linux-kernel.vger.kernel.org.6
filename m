Return-Path: <linux-kernel+bounces-571171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE33A6B9FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F48E3AF8F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B80226CF8;
	Fri, 21 Mar 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WK+Tvel6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204382253EC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557044; cv=none; b=OuM+2bgx0JA0X4SEWtEAAWo/98zWqm13GUat4eBXQOIdzbVMmSsf+L3T3HXhT82otq3op2bas9u/abeX87zc+G3AvrkCGOCmm3ovBUAp/c6PpggpT81fhR+gKrTdcU57NzgCDeQ9mXxooHpbXW0yWcz786KL8aeywRzbwVk79Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557044; c=relaxed/simple;
	bh=tnk3bsb90JY2mcV21Ncrc9nnVyKzLcleDYrjSkfxIGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S58s759NQgQXZ7kqHtJ6PiRjVO9tH8PPT/gfe6E5TpEpmgswXlPhYlSRoNpj0Ig8L3w8wA/3y/pobDDly2WaYAo/DbAoex4ZAfxiF+ekAy92seuKgTQDjo2lma2ahycDDWziO3FoHi/jnlXnKW9Ur5H6/9vCyaOAykGQakX7Z7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WK+Tvel6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742557042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LA4tQm8B9yk34e6zjAsFaRrtnSy4omTcdpMVJkFUhlY=;
	b=WK+Tvel68EbUKnclqJtVSioSAx2UmbD7a/IyF4PqlA2yJQx6i01Qq/4SMGBvQiG7ffpbKM
	kKkHUXYFBjormVtLbyVwNuILYzY/f8RFy7lO1fyXbNYrbEZ8XK5khOMUIsQFxGckeMmPs3
	+EyJvYdVe4Rk8K8OjBtDow7CVE8qOyQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-Jt--19hHO0aj532vhBirUw-1; Fri, 21 Mar 2025 07:37:20 -0400
X-MC-Unique: Jt--19hHO0aj532vhBirUw-1
X-Mimecast-MFC-AGG-ID: Jt--19hHO0aj532vhBirUw_1742557040
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913f97d115so908028f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742557040; x=1743161840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA4tQm8B9yk34e6zjAsFaRrtnSy4omTcdpMVJkFUhlY=;
        b=ucpzlofhChaoCkQuNEk5hg0oY+m5Bgo97AbcJumX/yT3mWDXkWxQLrkM0ANy306ztX
         ZLMvb6vWCPB+lpkWhSM2goWj4zCQlMXr/GnXEVICdGm+ZB22LWpjCAQtLtS0I0pfhrNZ
         l9ioBB8sa80NM5PO0+9aYCS5uhmiBPIjMus0+NvJuhMnmqNn49ek17QjfrcIl2CZoK/3
         DIdbdvrYH2/r0ou7O1WiY2U8UHvaUJF5K4yNODBD+335aOKrrKiNveejdnAvww72aOGO
         eQQwOrDtiEPrJUoNmqi92onQBHubqNGQnLwdDj7t/tarMCyWGU4rIS7/cnREI+qtNeKw
         MMQQ==
X-Gm-Message-State: AOJu0Yxb46R/fTmpwx6u4+b1WwbDaDFWdGO489/MrcYauYMTeKPLkwTf
	U/4P6zAPbydHI/OIilRe9YidmG84NjywsPnfwEQf+QtNvXgjAbI48c+hFXzdDv8jBwqb7k9TTcd
	Cb29xrqsu2aUfBz63gXF8aAQEZLeICSg1XU5Mpg9zAuB99UmgUFGDHqSIu7EnvBnHaSyzUgR4o5
	Axvsa3oRx0Ep8DV4ridP/dpNzIDvXjZS84TX556aMPlN8t
X-Gm-Gg: ASbGnctGHgRTmmj/SvQ+s6LO42gXMt8PK4NESaiCtEtlozNmTZaox6fB/8E69K9Ccdr
	DpeZn3I5oSsiv9ZZdrkcWz11KfPyAIUK5FY9Eym90GY4qnjTUW0xxOaJ3cT0zSmdcxlHl1oUaOU
	V05h7EWlGT2eWPdd6432izABjP7Xe73VS8StbUSW6/w28GwrlkL34uiVKNk2UZbABE30XyB/YzN
	ixu0CkHhOmeVVyYgKKjJ57rZuO4dwZkKy/jhiKJcednGhOggOW/HmoH3AV5VKDKwne7c07r4WXg
	1YJ7FjDx/XiPxx/FNPb32kNH0a/wTrNFHG+/GbirP2v6Cv4QXbtpPY5O+KMEuVyKMh88px9YAkN
	t
X-Received: by 2002:a05:6000:4021:b0:390:df83:1f22 with SMTP id ffacd0b85a97d-3997959ce52mr7464174f8f.25.1742557039675;
        Fri, 21 Mar 2025 04:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzgIkkOJsHGuf2WyAxCwKihBA43kh5WjBQNfuxP9FngTIZo6gSbHPXNu6WapbxvVPx5btxjA==
X-Received: by 2002:a05:6000:4021:b0:390:df83:1f22 with SMTP id ffacd0b85a97d-3997959ce52mr7464123f8f.25.1742557039114;
        Fri, 21 Mar 2025 04:37:19 -0700 (PDT)
Received: from localhost (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f43e50sm74599665e9.12.2025.03.21.04.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:37:18 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH v3 2/3] kernel/events/uprobes: pass VMA to set_swbp(), set_orig_insn() and uprobe_write_opcode()
Date: Fri, 21 Mar 2025 12:37:12 +0100
Message-ID: <20250321113713.204682-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321113713.204682-1-david@redhat.com>
References: <20250321113713.204682-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already have the VMA, no need to look it up using
get_user_page_vma_remote(). We can now switch to
get_user_pages_remote().

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm/probes/uprobes/core.c |  4 ++--
 include/linux/uprobes.h        |  6 +++---
 kernel/events/uprobes.c        | 33 +++++++++++++++++----------------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index f5f790c6e5f89..885e0c5e8c20d 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -26,10 +26,10 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 		(UPROBE_SWBP_ARM_INSN & 0x0fffffff);
 }
 
-int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
+int set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	     unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, mm, vaddr,
+	return uprobe_write_opcode(auprobe, vma, vaddr,
 		   __opcode_to_mem_arm(auprobe->bpinsn));
 }
 
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b1df7d792fa16..288a42cc40baa 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -185,13 +185,13 @@ struct uprobes_state {
 };
 
 extern void __init uprobes_init(void);
-extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
-extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
+extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
+extern int set_orig_insn(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 259038d099819..ac17c16f65d63 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -474,19 +474,19 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  *
  * uprobe_write_opcode - write the opcode at a given virtual address.
  * @auprobe: arch specific probepoint information.
- * @mm: the probed process address space.
+ * @vma: the probed virtual memory area.
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
  *
  * Called with mm->mmap_lock held for read or write.
  * Return 0 (success) or a negative errno.
  */
-int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
-			unsigned long vaddr, uprobe_opcode_t opcode)
+int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		unsigned long vaddr, uprobe_opcode_t opcode)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct uprobe *uprobe;
 	struct page *old_page, *new_page;
-	struct vm_area_struct *vma;
 	int ret, is_register, ref_ctr_updated = 0;
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
@@ -498,9 +498,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (is_register)
 		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
-	old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
-	if (IS_ERR(old_page))
-		return PTR_ERR(old_page);
+	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags, &old_page, NULL);
+	if (ret != 1)
+		return ret;
 
 	ret = verify_opcode(old_page, vaddr, &opcode);
 	if (ret <= 0)
@@ -590,30 +590,31 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 /**
  * set_swbp - store breakpoint at a given address.
  * @auprobe: arch specific probepoint information.
- * @mm: the probed process address space.
+ * @vma: the probed virtual memory area.
  * @vaddr: the virtual address to insert the opcode.
  *
  * For mm @mm, store the breakpoint instruction at @vaddr.
  * Return 0 (success) or a negative errno.
  */
-int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+int __weak set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN);
 }
 
 /**
  * set_orig_insn - Restore the original instruction.
- * @mm: the probed process address space.
+ * @vma: the probed virtual memory area.
  * @auprobe: arch specific probepoint information.
  * @vaddr: the virtual address to insert the opcode.
  *
  * For mm @mm, restore the original opcode (opcode) at @vaddr.
  * Return 0 (success) or a negative errno.
  */
-int __weak
-set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+int __weak set_orig_insn(struct arch_uprobe *auprobe,
+		struct vm_area_struct *vma, unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, mm, vaddr,
+	return uprobe_write_opcode(auprobe, vma, vaddr,
 			*(uprobe_opcode_t *)&auprobe->insn);
 }
 
@@ -1153,7 +1154,7 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	if (first_uprobe)
 		set_bit(MMF_HAS_UPROBES, &mm->flags);
 
-	ret = set_swbp(&uprobe->arch, mm, vaddr);
+	ret = set_swbp(&uprobe->arch, vma, vaddr);
 	if (!ret)
 		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
 	else if (first_uprobe)
@@ -1168,7 +1169,7 @@ static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
-	return set_orig_insn(&uprobe->arch, mm, vaddr);
+	return set_orig_insn(&uprobe->arch, vma, vaddr);
 }
 
 struct map_info {
-- 
2.48.1


