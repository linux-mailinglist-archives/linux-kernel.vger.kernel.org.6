Return-Path: <linux-kernel+bounces-176101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A527F8C29E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8941F236DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8093EA98;
	Fri, 10 May 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oc6i7uZj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACD38DD3
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365778; cv=none; b=SfW+dmLm66yunUu87wRK0bTaaW29QRgRKF2o8CnL5O9WErcIZG5Ohyi3VljVMSSgEbCGGezmAo4Z0D2PtIhaJH30kgbKBk9lpH40PfC8sdX2EDfJNvBp7a+SrKxFTBQhbJsvFzoGy/snKq0UElV9L7RIEp47pjp8BFD5hb1Fbn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365778; c=relaxed/simple;
	bh=/Kfcgt1SydmQzEiEFoDh6aguInxePX0urfq2+5b+HU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R3+LcFdzPNIXx1uVRrSUbliZmqu724xkPHgo2YtYREtdPAdodURp6kcHCW3wiHYQpdl5sbeDwH6cCfeukkiqygusaVSMJ9Y7ODagfzASOIZHLqX+89LoTKb9Wy/votN4ZVOMd/XySAMyA6CDTJu6IeAGxhpOSoKOYsEViJ6VxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oc6i7uZj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de615257412so4037914276.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715365774; x=1715970574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=djjgV/EOUSgIiHJsIm8AWGF7ff5q1uXyb7dMjfHKhrI=;
        b=Oc6i7uZjxhVZQzU724Bak0tdPNGr9QZApqZhERZtHTqVV3Wt4xXcVirSWr5co60wmn
         WD/ZUrgZsJTyfF7BU+1fDeykNsmFkmxMNYaBZ3RMWtrhRfB0Oo/Tzd05LaJxsGej49bw
         qi31Pv5C94srS8o+NPS2waeakdiWU0kJFXtMEwG/QwBmFWMHHR2gCyYnDjjKvDp4aYx9
         /4mnOB2u4RujsxFCn9pqyxMV4K3tkUW12KHa6bFBRRAZF7+byMCudD9liGRmTmXeIJ0Q
         goa+VDjzBBrP9VP2lpmuJYzVk9yhubWDWfs41fgoKb1HnVwfN/z9Ur+kJe7BOuf05pqt
         RorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715365774; x=1715970574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djjgV/EOUSgIiHJsIm8AWGF7ff5q1uXyb7dMjfHKhrI=;
        b=u4LrbxjvEapWyrDM9ukvDmdKrd6F31958eypJzy9jcIuIduQUlfD72jqLFbsQigq/9
         m59ysOeVL78AeBQ/j1JR4FA2c6nllHKI637L/pLhaW14xDAOcJK5/l/nd9I5foZHYb26
         muyOE02pJGoG29QzPbNJUR7TNBmFrsmP1LW/CS2itKhys6BjKqfeu40XkJppkLBjDu2q
         AHywFQ7Lf2MfeAt5yMZZgWfp8Lt+4/KKbPh42yuPka7DuuoGouCqNQdFVlR6f+7++7ji
         WhYDJ8KKUFP96luxxYTLeIIfd8J22jPsN2nhyDZ9PYc4/ykb6pNpRXBqpj7oJVD4PqvC
         +Kxw==
X-Forwarded-Encrypted: i=1; AJvYcCWlge4NVPUy1eh2M7nq6WNopvwa0VEcvveSaDJoV/sIfcN2C804Q1JlooRnBBL3CWCXqyP96g+rIyWPR6dMmr/F9zGCNvV48q8rmvdT
X-Gm-Message-State: AOJu0YySWijof+T8eBeW9390M5LPhdl7+Cn+2OYq4zTb8qTmePSpLQwU
	nOVNchxQw9XpVBxgoPOIFM6Ku1UVrgaTKqhlpsF8K6qEqOTg8MVGeXC4/oGGeQzmsWeQxItIBwF
	V/fGf3HFh2v7AaSnz49RcazzTyA9SxA==
X-Google-Smtp-Source: AGHT+IFerzf95SQt68BSPyg+4slciMy+Qp5Bl/3q5GPRPhHSBZLEJUwSa5o+N+XqGo0DxsH3At45CJWu36ItLUenUz2D
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:6f94:7fe7:5ca2:5501])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:1890:b0:dee:60e9:69f4 with
 SMTP id 3f1490d57ef6-dee60e96aeemr201789276.10.1715365774181; Fri, 10 May
 2024 11:29:34 -0700 (PDT)
Date: Fri, 10 May 2024 11:29:26 -0700
In-Reply-To: <20240510182926.763131-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510182926.763131-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510182926.763131-2-axelrasmussen@google.com>
Subject: [PATCH v2 1/1] arch/fault: don't print logs for pte marker poison errors
From: Axel Rasmussen <axelrasmussen@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>, 
	Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, John Hubbard <jhubbard@nvidia.com>, 
	Liu Shixin <liushixin2@huawei.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Axel Rasmussen <axelrasmussen@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

For real MCEs, various architectures print log messages when poisoned
memory is accessed (which results in a SIGBUS). These messages can be
important for users to understand the issue.

On the other hand, we have two other cases: swapin errors and simulated
poisons via UFFDIO_POISON. These cases also result in SIGBUS, but they
aren't "real" hardware memory poisoning events, so we want to avoid
logging MCE error messages to dmesg for these events. This avoids
spamming the kernel log, and possibly drowning out real events with
these other cases.

To identify this situation, add a new VM_FAULT_HWPOISON_SILENT flag.
This is expected to be set *in addition to* one of the existing
VM_FAULT_HWPOISON or VM_FAULT_HWPOISON_LARGE flags (which are mutually
exclusive).

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 arch/parisc/mm/fault.c   |  7 +++++--
 arch/powerpc/mm/fault.c  |  6 ++++--
 arch/x86/mm/fault.c      |  6 ++++--
 include/linux/mm_types.h | 34 ++++++++++++++++++++--------------
 mm/hugetlb.c             |  3 ++-
 mm/memory.c              |  2 +-
 6 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index c39de84e98b0..6c5e8d6498bf 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -400,9 +400,12 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 #ifdef CONFIG_MEMORY_FAILURE
 		if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
 			unsigned int lsb = 0;
-			printk(KERN_ERR
+
+			if (!(fault & VM_FAULT_HWPOISON_SILENT)) {
+				pr_err(
 	"MCE: Killing %s:%d due to hardware memory corruption fault at %08lx\n",
-			tsk->comm, tsk->pid, address);
+				tsk->comm, tsk->pid, address);
+			}
 			/*
 			 * Either small page or large page may be poisoned.
 			 * In other words, VM_FAULT_HWPOISON_LARGE and
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 215690452495..c43bb6193a80 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -147,8 +147,10 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
 		unsigned int lsb = 0; /* shutup gcc */
 
-		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
-			current->comm, current->pid, address);
+		if (!(fault & VM_FAULT_HWPOISON_SILENT)) {
+			pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
+				current->comm, current->pid, address);
+		}
 
 		if (fault & VM_FAULT_HWPOISON_LARGE)
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 67b18adc75dd..9ae5cc6bd933 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -964,9 +964,11 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 		struct task_struct *tsk = current;
 		unsigned lsb = 0;
 
-		pr_err(
+		if (!(fault & VM_FAULT_HWPOISON_SILENT)) {
+			pr_err(
 	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
-			tsk->comm, tsk->pid, address);
+				tsk->comm, tsk->pid, address);
+		}
 		if (fault & VM_FAULT_HWPOISON_LARGE)
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 		if (fault & VM_FAULT_HWPOISON)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 24323c7d0bd4..7663a2725341 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1224,6 +1224,10 @@ typedef __bitwise unsigned int vm_fault_t;
  * @VM_FAULT_HWPOISON_LARGE:	Hit poisoned large page. Index encoded
  *				in upper bits
  * @VM_FAULT_SIGSEGV:		segmentation fault
+ * @VM_FAULT_HWPOISON_SILENT	Hit a poisoned pte marker, which should not be
+ *				logged to dmesg since it's something besides a
+ *				real hardware memory error (swapin error,
+ *				simulated poison via UFFDIO_POISON, etc.).
  * @VM_FAULT_NOPAGE:		->fault installed the pte, not return page
  * @VM_FAULT_LOCKED:		->fault locked the returned page
  * @VM_FAULT_RETRY:		->fault blocked, must retry
@@ -1237,20 +1241,21 @@ typedef __bitwise unsigned int vm_fault_t;
  *
  */
 enum vm_fault_reason {
-	VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
-	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
-	VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
-	VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
-	VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
-	VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
-	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
-	VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
-	VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
-	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
-	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
-	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
-	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
-	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
+	VM_FAULT_OOM             = (__force vm_fault_t)0x000001,
+	VM_FAULT_SIGBUS          = (__force vm_fault_t)0x000002,
+	VM_FAULT_MAJOR           = (__force vm_fault_t)0x000004,
+	VM_FAULT_HWPOISON        = (__force vm_fault_t)0x000010,
+	VM_FAULT_HWPOISON_LARGE  = (__force vm_fault_t)0x000020,
+	VM_FAULT_SIGSEGV         = (__force vm_fault_t)0x000040,
+	VM_FAULT_HWPOISON_SILENT = (__force vm_fault_t)0x000080,
+	VM_FAULT_NOPAGE          = (__force vm_fault_t)0x000100,
+	VM_FAULT_LOCKED          = (__force vm_fault_t)0x000200,
+	VM_FAULT_RETRY           = (__force vm_fault_t)0x000400,
+	VM_FAULT_FALLBACK        = (__force vm_fault_t)0x000800,
+	VM_FAULT_DONE_COW        = (__force vm_fault_t)0x001000,
+	VM_FAULT_NEEDDSYNC       = (__force vm_fault_t)0x002000,
+	VM_FAULT_COMPLETED       = (__force vm_fault_t)0x004000,
+	VM_FAULT_HINDEX_MASK     = (__force vm_fault_t)0x0f0000,
 };
 
 /* Encode hstate index for a hwpoisoned large page */
@@ -1268,6 +1273,7 @@ enum vm_fault_reason {
 	{ VM_FAULT_HWPOISON,            "HWPOISON" },	\
 	{ VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" },	\
 	{ VM_FAULT_SIGSEGV,             "SIGSEGV" },	\
+	{ VM_FAULT_HWPOISON_SILENT,	"HWPOISON_SILENT" },	\
 	{ VM_FAULT_NOPAGE,              "NOPAGE" },	\
 	{ VM_FAULT_LOCKED,              "LOCKED" },	\
 	{ VM_FAULT_RETRY,               "RETRY" },	\
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6be78e7d4f6e..91517cd7f44c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6485,7 +6485,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 				pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
 
 			if (marker & PTE_MARKER_POISONED) {
-				ret = VM_FAULT_HWPOISON_LARGE |
+				ret = VM_FAULT_HWPOISON_SILENT |
+				      VM_FAULT_HWPOISON_LARGE |
 				      VM_FAULT_SET_HINDEX(hstate_index(h));
 				goto out_mutex;
 			}
diff --git a/mm/memory.c b/mm/memory.c
index eea6e4984eae..721c0731cef2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3938,7 +3938,7 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 
 	/* Higher priority than uffd-wp when data corrupted */
 	if (marker & PTE_MARKER_POISONED)
-		return VM_FAULT_HWPOISON;
+		return VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_SILENT;
 
 	if (pte_marker_entry_uffd_wp(entry))
 		return pte_marker_handle_uffd_wp(vmf);
-- 
2.45.0.118.g7fe29c98d7-goog


