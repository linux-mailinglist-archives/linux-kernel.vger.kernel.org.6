Return-Path: <linux-kernel+bounces-438767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E0D9EA55E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555DE188B0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F231ACEC0;
	Tue, 10 Dec 2024 02:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xkfmh4b1"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9261A01CD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798489; cv=none; b=gO8bq9INWGYsuYy6+tS/aDi0Ze1TurD4R7m9/fyhgGPErOtd3sXOjk4ESt1eWRvz47hB5heuxoNSpwqUfCmGKFYsR/GWriAdikLMSPQ++uuos7Ab9pMHLDbCdjihcO80r7/gMh2fR3EugeGP/odZkZB0p7g0fXbX/DseyE+T/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798489; c=relaxed/simple;
	bh=mpvxmscjVgbLdO7cK/zBkRD+gPYja4DIS+1NwMw48+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EfwpXeefrptzlzultvNQRymGImqMJVeXpkVNl+Ntth3vMaTlcuX2afiyh2nadmmmr6cXzdEsnig+SR/LoKlRkflnOK0sOCTyTEik7TFCA+6JZgQhG3RWYWzLFlSKvwHMvA3qTUA6NC8QRObNBU1xNPxgcraukDcopkOFbWaEIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xkfmh4b1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fb966ee0cdso3579477a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 18:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798485; x=1734403285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nXKIsvWsBBTYmcaRz8JoUa2+7Qpfg8xMl3r7PMmLvBk=;
        b=Xkfmh4b1HMhS6EeVnOfmT4VtEykAz9/o9O3C8yXC65ttVozCZ1R5Sdm2wHW35ssCCq
         QaStk5pi9SgHr0Z5QgzaP6s+HnyI7lNwuSl9b/wGQ53Pi7mud9Z2C88R4Yb4K7Uj/R6R
         p9FQr6WLVL/Lpl6/fWWpNiAlCxa2WFG9oVOZoF8+uuw2UL72BdbelcyOC1mcrzx/RNNu
         chGebqPASiRlDZ5i2ECCBSfvMGZyf7Y2+v71RDRZSdfx4m4TQlWQAIDn6nbbEDnsQonJ
         uHTKtjH2AFE3AD3WMiarsi9YLRhXv6vcX6DAxFNXOOsgCbAh+bgQgZZer/YypWKjgFK0
         sJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798485; x=1734403285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXKIsvWsBBTYmcaRz8JoUa2+7Qpfg8xMl3r7PMmLvBk=;
        b=XS5d6hqwIZp2EyO1PDGtmX5pQAgAbxUxdcCLLJvX+rG194RvnzQeYduF9p6ByYQM+v
         8pfxWwOPkKT4FF3XeYUFEisOw/JMbxUa6Vx4UeYWvbArKR/hiaadi7Xrcf6Oq7pdAoF5
         reaFQt9doA4H9YN5+lvQAecvq7PkSXM4XyzOG/Jsd71tT1EL3BEAaC+8oAjRmTp10AF9
         qSqy9wsS6cS/GZT2IOstfVdLOqyf+xpbHVNGzRG0Elxxp7fzVt6VGrPyJWgslqiviywG
         x4c7duCoEVucyljYG0DGoQSBSEhnX/dvGuX81rTR2YhXtw/FFzidOZ9GkMDjfqe4zNKd
         xJAA==
X-Forwarded-Encrypted: i=1; AJvYcCX2LxJGhOmIWkEs1vQWNfMTAzOV/TQEJ0HoldiKMtUvpfKTjhhUEOMNghNXgFIraEepIteRQDlfTGnunOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCu4+o/MfN5PdX+cOBYxUibwt8VGbTSLgXfrZvuqQYJtvbjjkt
	DYdwBHhNaCtcdwM6lhgQU657ZQeT0LyThBgws3YO897QuX7ijuQDto1ni45ZMmkXP2iuGwVpsNZ
	GHiv+AIEouKgCPWJ2uNQuew==
X-Google-Smtp-Source: AGHT+IEes4vFC8x7oz2PD6CyRh4s+tzg2fdn8MPTeQEnOJJBB4JDPOzOCc3jB91eMpzo0BdpMiIRvdYY+YmWIeDh+w==
X-Received: from pfau15.prod.google.com ([2002:a05:6a00:aa8f:b0:728:2357:646a])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7483:b0:1e1:adb8:c011 with SMTP id adf61e73a8af0-1e1b4435999mr2770722637.18.1733798485628;
 Mon, 09 Dec 2024 18:41:25 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:03 -0800
In-Reply-To: <20241210024119.2488608-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-2-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 01/17] mm: Introduce generic_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Consolidate the hint searches from both direcitons (topdown and
bottomup) into generic_mmap_hint().

No functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 include/linux/sched/mm.h |  4 ++++
 mm/mmap.c                | 45 ++++++++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 928a626725e6..edeec19d1708 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -201,6 +201,10 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm,
 					   unsigned long flags,
 					   vm_flags_t vm_flags);
 
+unsigned long generic_mmap_hint(struct file *filp, unsigned long addr,
+				unsigned long len, unsigned long pgoff,
+				unsigned long flags);
+
 unsigned long
 generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			  unsigned long len, unsigned long pgoff,
diff --git a/mm/mmap.c b/mm/mmap.c
index df9154b15ef9..e97eb8bf4889 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -620,6 +620,27 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 	return addr;
 }
 
+unsigned long generic_mmap_hint(struct file *filp, unsigned long addr,
+				unsigned long len, unsigned long pgoff,
+				unsigned long flags)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
+
+	if (!addr)
+		return 0;
+
+	addr = PAGE_ALIGN(addr);
+	vma = find_vma_prev(mm, addr, &prev);
+	if (mmap_end - len >= addr && addr >= mmap_min_addr &&
+	    (!vma || addr + len <= vm_start_gap(vma)) &&
+	    (!prev || addr >= vm_end_gap(prev)))
+		return addr;
+
+	return 0;
+}
+
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.
  *
@@ -637,7 +658,6 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			  unsigned long flags, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma, *prev;
 	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
@@ -647,14 +667,9 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (flags & MAP_FIXED)
 		return addr;
 
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma_prev(mm, addr, &prev);
-		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)) &&
-		    (!prev || addr >= vm_end_gap(prev)))
-			return addr;
-	}
+	addr = generic_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
 
 	info.length = len;
 	info.low_limit = mm->mmap_base;
@@ -685,7 +700,6 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 				  unsigned long len, unsigned long pgoff,
 				  unsigned long flags, vm_flags_t vm_flags)
 {
-	struct vm_area_struct *vma, *prev;
 	struct mm_struct *mm = current->mm;
 	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
@@ -698,14 +712,9 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 		return addr;
 
 	/* requesting a specific address */
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma_prev(mm, addr, &prev);
-		if (mmap_end - len >= addr && addr >= mmap_min_addr &&
-				(!vma || addr + len <= vm_start_gap(vma)) &&
-				(!prev || addr >= vm_end_gap(prev)))
-			return addr;
-	}
+	addr = generic_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-- 
2.47.0.338.g60cca15819-goog


