Return-Path: <linux-kernel+bounces-200586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3108D8FB21F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BE22842B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42017146585;
	Tue,  4 Jun 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfcHOrX4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524C146581
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503980; cv=none; b=WGWhJcdJ8FzFDN4dDXpVR3Ql8UjgOwU6mNGdxrnoggyWgxQWXiSQc3CDHbxsn36/RBcV4ckVITTNDaOPiR+C0u6wvoGRfy4LTaZMGjugEfoqAPP5w0nPzihfwNepngne4nbev6APanCqFPgUFUn8DtKVUFOW6K2BsU/WEeTk7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503980; c=relaxed/simple;
	bh=7TloC/YZDDY1Iat+MWMKEijUu24a/+pzrNxIBZo32Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grGcSbUuCIylK3bFLp6fBYzTk1D4v1lndzWdtcljaa3oYeAeHJ1jYUhrk3cD05swGbGNOuUODpO7B3fndx7q5jBBbex3dedOyhyK20Nnq4qXJ629B96zTFEZZ5xmEHvi+XebfodIuxQ7WBebteonYt+Z6H1V0TkjytiA3QpHBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfcHOrX4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717503977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXfKzgnS1a7dNjnPxPlU/qmVEHFMnEf3bxdZwelxxd0=;
	b=AfcHOrX4+746ahQ3A7zpwEwvNueYMkUOGavCe618GxWdDnpfavIT5r9X1Ys9lJ5/CTIkFY
	cwY63sau/sBSeOrTK7I/C5HiuqHmIbBvdUIm8D9JGv20Axa3lHDasDSA4gHR7m5w9n9tMf
	FN1mRL1AiukyPpMVqjqVHAqyYa1dSa0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-ODGmKQOXNA-4YSKHFzPAow-1; Tue,
 04 Jun 2024 08:26:14 -0400
X-MC-Unique: ODGmKQOXNA-4YSKHFzPAow-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E85DF18BF6E4;
	Tue,  4 Jun 2024 12:26:10 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B8851955D8B;
	Tue,  4 Jun 2024 12:26:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guillaume Morin <guillaume@morinfr.org>,
	Russell King <linux@armlinux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH RFC 2/3] kernel/events/uprobes: pass VMA to set_swbp(), set_orig_insn() and uprobe_write_opcode()
Date: Tue,  4 Jun 2024 14:25:47 +0200
Message-ID: <20240604122548.359952-3-david@redhat.com>
In-Reply-To: <20240604122548.359952-1-david@redhat.com>
References: <20240604122548.359952-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index f46e0ca0169c7..77580dba6f8de 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -103,13 +103,13 @@ struct uprobes_state {
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
 extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
 extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c6d6b7a8e4410..f2b1fef7f1d62 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -449,19 +449,19 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  *
  * uprobe_write_opcode - write the opcode at a given virtual address.
  * @auprobe: arch specific probepoint information.
- * @mm: the probed process address space.
+ * @vma: the probed virtual memory area.
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
  *
  * Called with mm->mmap_lock held for write.
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
@@ -473,9 +473,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
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
@@ -560,30 +560,31 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
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
 
@@ -905,7 +906,7 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	if (first_uprobe)
 		set_bit(MMF_HAS_UPROBES, &mm->flags);
 
-	ret = set_swbp(&uprobe->arch, mm, vaddr);
+	ret = set_swbp(&uprobe->arch, vma, vaddr);
 	if (!ret)
 		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
 	else if (first_uprobe)
@@ -920,7 +921,7 @@ static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
-	return set_orig_insn(&uprobe->arch, mm, vaddr);
+	return set_orig_insn(&uprobe->arch, vma, vaddr);
 }
 
 static inline bool uprobe_is_active(struct uprobe *uprobe)
-- 
2.45.1


