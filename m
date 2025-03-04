Return-Path: <linux-kernel+bounces-544800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4629A4E630
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C64A8C3BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811029DB9E;
	Tue,  4 Mar 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfBxpJe1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4729DB8C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103348; cv=none; b=WiykHNf1CvvzwsEVBxe4OxwVjX02vtr0g8c7zCxi6ntc/svMAbbLImXomIzBwKqHZp+Z9IXALvi5giYKU+zCQNXjxLNO+ec4PBY9HSZyOsEfqNTDb2DB7kXwSJBbX+kFiVldnYTyZaAr4vnqym/nfqxPvyM/BrXWMwToJi/3vP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103348; c=relaxed/simple;
	bh=Ah9D1oaYdgLAYU43bf6vQIZvtJeF1OpFbII7FyU6mlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrklmz+nW++iA13a9s621k8mhZrvRsFLcS0/xuo+K8DxMjwPkdV8VRwjygelbuKjR8btDQk7MbCCZhZ9iVJgJSv7CHQDQAR8usdDtuZuDCAYBGLTl7KdAan9LqK48S1WoQ05UCy22FuFia9i0Ohu06jcdI+TxIl44mD2diRKB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UfBxpJe1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffON9SnaOWg9oFQtm+MueKUsNfzxra0dWfxUL8seX24=;
	b=UfBxpJe1uXfrul9A9aXrqFX49eXvgsgAQibV76CrxxyJ9/ZxvOgcNtTBkfpepF/bF12Qwf
	fgrEP7eD1lO90d1tY2D3H5ryg3YGQc1dWq8plOzjNdBlKFPYc/e+nCryvW9rczwNnpafan
	UCQD7k+yJl3HCk8iY3kUGTd0aU58B4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-pvYxw9kuPDKHlUtIo1Xh-Q-1; Tue, 04 Mar 2025 10:48:54 -0500
X-MC-Unique: pvYxw9kuPDKHlUtIo1Xh-Q-1
X-Mimecast-MFC-AGG-ID: pvYxw9kuPDKHlUtIo1Xh-Q_1741103333
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bcb061704so5291345e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103333; x=1741708133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffON9SnaOWg9oFQtm+MueKUsNfzxra0dWfxUL8seX24=;
        b=DkTuHu0RqAGfzQCsbY+DkV5XBpAD9lSEN2lwdxx8YoDSOya5V1p7rZrp1YOAB1hqgT
         QHCZb9cZSa64f1XeLdW5/sWK4S+29cUWuhIg8ykQwgCaYc+/r45vLJA5qoSdzkuKpC1L
         l66WTPWaX/RKPHQONviv2HxI7Hsf2qxkdNiY1+wxjtNld7IdpWNynGne+E6rVU/olMFN
         Vsvf9/bMcV/Vl7dob60yLMDCu6cf2HMyHTp3UaeR8jODrDQo8LVib6eKe5e/9MJ45+XF
         KjNcTg0F/ddPb8V4r0R/Uip3/67BiiMACzwDFpPDBm4wkn7uscwCaomN6UMeZrTgjBzG
         sGoA==
X-Gm-Message-State: AOJu0Yw77w8dWG541reo1ODL1uW1ejsBxjqFv9qRoMYqN4uvfGFB52oo
	tymjzWLq8lsROjsFRT0bhB5Yhl+VVRPsH7+EvPOtA5Ciw8T2FJ33m3rW4sOezFFLcenY3gPXWBS
	Z4LtsPvoPkw6HuAK7s90Vib2ZOXZ0WEL6mKccQsUxz/VcUfYY+Tk9hxUkLI2Bw5hLFnp0Gh17W5
	YOQA02BbsHbtNcVwW9QZdTpiW9SAyDIVu8rJmCR4p1COIF
X-Gm-Gg: ASbGncvB8w3WY1dXK0w/oPkMMzxxrW0z6JUx1q+Eom0XkH8EFQTs1v/WJowTjsD0g7S
	QbWJIeMg2G2EzBMMx4VQ3+tvjE2nYyA72Iq/iAjbVe32HscpalP4DdDJCLmMEHMYMcuoN0OUmSn
	8NsvsPlvasEHT+MYq8nAwkzto/x+/Ouhf1DbroNcxbIiLP/sjX/KmQF7PMdhjvvTHVJP09h5Bbe
	Z8rot3AXMbl2ysSZ65zi17XOGIKWfq79fb2QJOTgZhUv0Pa8FU3G+Ys3unQEQmN+cEQ2fPtYIfb
	ZCLUTqYqfxdyGS+co5ovBdlx4LCCcnX3T7s28SViWHAfTXY1BdKgJwQEXQj2vYzOuTUgoZWYvFQ
	D
X-Received: by 2002:a05:600c:3c9d:b0:439:8a62:db42 with SMTP id 5b1f17b1804b1-43ba66e19d9mr153515945e9.8.1741103333183;
        Tue, 04 Mar 2025 07:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4Gjl+jrn0ypwJ4W8O9mKURosa8cKWKJgfr05HkBSuQdnMp7DSreUXUU7A6eFr/8nx/dTcdQ==
X-Received: by 2002:a05:600c:3c9d:b0:439:8a62:db42 with SMTP id 5b1f17b1804b1-43ba66e19d9mr153515575e9.8.1741103332777;
        Tue, 04 Mar 2025 07:48:52 -0800 (PST)
Received: from localhost (p200300cbc73610009e302a8acd3d419c.dip0.t-ipconnect.de. [2003:cb:c736:1000:9e30:2a8a:cd3d:419c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bca26676esm43128935e9.8.2025.03.04.07.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:48:52 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH -next v1 2/3] kernel/events/uprobes: pass VMA to set_swbp(), set_orig_insn() and uprobe_write_opcode()
Date: Tue,  4 Mar 2025 16:48:45 +0100
Message-ID: <20250304154846.1937958-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304154846.1937958-1-david@redhat.com>
References: <20250304154846.1937958-1-david@redhat.com>
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
index a40efdda9052b..4da3bce5e062d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -186,13 +186,13 @@ struct uprobes_state {
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
index 991aacc80d0e0..0276defd6fbfa 100644
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


