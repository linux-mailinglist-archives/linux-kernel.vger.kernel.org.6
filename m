Return-Path: <linux-kernel+bounces-534419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE4A466CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B785619C0F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8F21E0BF;
	Wed, 26 Feb 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1J2/pBD"
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6021E086
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587027; cv=none; b=FgPGFLn+ytHuHFdkDuF61E2nI00Rnm9yTsgbUcoNM37nf4N/i/+I8d3sFTRrpbSrt8kn14Tnt5ZHjPmiX6OtnfBkLcV8Dw1jDjPsUPERFF3YxryCzVF0ICejUj+cj1uXwHeJEiQtk5obVoxWDTVMQveM8tEvLyaw41w9fdPI3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587027; c=relaxed/simple;
	bh=40fHOJaclUGDk2yZBiDnH2nN4+0I24hmqSzejuEcnXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZZ+Mt3LrV7ri1m/quxVVCoUxVvfktDXkoaC4n3w+wxOu6UkjoNAA2h8L7GPnTF2Y1F+itgkyJfQNSo+h/AyE9hzzmlHi9i966W2QcqORP2oU7L3OGMG34RlGHtzs0DFneEZ7FSkAy8GG1SLH/g2sdC/JSmZkO+50bcwYxqfMQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1J2/pBD; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e66249f058so904396d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740587024; x=1741191824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iZBOUn5TfaKdJ8fUW/ohyeEciVeQe808dYANdbYN7A=;
        b=s1J2/pBDLb4MXYlyH3gkxCY2Xyxnrgxl8BM+rUYY+FNe5Q08vXyU3UYWzYQyhwXS4o
         V6gAW9q32TxUB7j7JXg5I/6ZmKKGrhDRnju3qKdPsHDWoInZ92+kz32hhI7GH35LcMog
         h1TmICM3VFCr2FtgOJUJhnuK2H1XRQIVaYuTZ/2UarmCTHx0TWRJVN9LQ0d7oMHlQPp/
         7CJWev/AHWHj3I3jBu0e3Fk3C0gOOz2GfwYf2E7YqIvT5/bujfw3cN3UTvTPb0RNAp/O
         jU8jplJTPpdJW5PKUfA6gCJZaDV13K3TGS2ZHmcb8QotHQixwP13LOpnOfcRCcdJ34Am
         JNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740587024; x=1741191824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iZBOUn5TfaKdJ8fUW/ohyeEciVeQe808dYANdbYN7A=;
        b=mXv8/1+tEjPbeY+OuyWT+zq+25sQWGp7PA/fWcGnMGzlpzzJoQZokuJGWUFsBl7Sw6
         JRVtNl3gMADhBHE6AD8ip12TSvtB1sqoJ4hixFmhUQAuKmFkGU6UQAYQzbG2UGwVH/Vt
         VdUKbKt+Dxy70LKLM6/akw97R3ZjaFEROrz6wJCpP+ndyDC5u2wsWkQfI9i95z9cmCa+
         e8EBpifRvE98Cz9wSBH+F5PksqlgkTMvEvsKx7IawsJjbwrBfkM5gH45otMwN9F1E3eK
         P9qndgBzEZGnEGiNnemzpxkDe4uHe0Kc4SpuSMHFwQg/I2N0rQT04nELd5YMHjtA0KjS
         Ah6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNbdFvPiEkmwsEFLaiYUJQgWgHOeoNINoHmcngNsJDHdAkT+syVHK2XrqB/jAIPr8V9mO2I3xv1IYfWVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQykVrnPlmehckaYxan+g6/iCeopIrewi+T8e/JZeE/6PedYIy
	FB1LAE6y+FLe8//pbBcNNIUoQK4h0/A1bLUZ1D6lkFaTuCPHJ0ra5BK1C/PJt9WRLy/LVyE9m1x
	VX4VFAA==
X-Google-Smtp-Source: AGHT+IGETZUu141OjsGUsrKL/0fxcfLOq3YpRMsVuVapIyy/5BXoaepYsdLR4P7IA7Dg0sPqBGRJHRWtp8Cd
X-Received: from qvbml23.prod.google.com ([2002:a05:6214:5857:b0:6dd:d16:e8ab])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:130b:b0:6d4:c6d:17fe
 with SMTP id 6a1803df08f44-6e87ab52085mr112509186d6.25.1740587024722; Wed, 26
 Feb 2025 08:23:44 -0800 (PST)
Date: Wed, 26 Feb 2025 11:23:41 -0500
In-Reply-To: <20250226114815.758217-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226114815.758217-1-bgeffon@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250226162341.915535-1-bgeffon@google.com>
Subject: [PATCH v2] mm: fix finish_fault() handling for large folios
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Brian Geffon <bgeffon@google.com>, stable@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Marek Maslanka <mmaslanka@google.com>
Content-Type: text/plain; charset="UTF-8"

When handling faults for anon shmem finish_fault() will attempt to install
ptes for the entire folio. Unfortunately if it encounters a single
non-pte_none entry in that range it will bail, even if the pte that
triggered the fault is still pte_none. When this situation happens the
fault will be retried endlessly never making forward progress.

This patch fixes this behavior and if it detects that a pte in the range
is not pte_none it will fall back to setting a single pte.

Cc: stable@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>
Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Marek Maslanka <mmaslanka@google.com>
Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 mm/memory.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b4d3d4893267..b6c467fdbfa4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5183,7 +5183,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
 		      !(vma->vm_flags & VM_SHARED);
 	int type, nr_pages;
-	unsigned long addr = vmf->address;
+	unsigned long addr;
+	bool needs_fallback = false;
+
+fallback:
+	addr = vmf->address;
 
 	/* Did we COW the page? */
 	if (is_cow)
@@ -5222,7 +5226,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	 * approach also applies to non-anonymous-shmem faults to avoid
 	 * inflating the RSS of the process.
 	 */
-	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
+	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
+			unlikely(needs_fallback)) {
 		nr_pages = 1;
 	} else if (nr_pages > 1) {
 		pgoff_t idx = folio_page_idx(folio, page);
@@ -5258,9 +5263,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_NOPAGE;
 		goto unlock;
 	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
-		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
-		ret = VM_FAULT_NOPAGE;
-		goto unlock;
+		needs_fallback = true;
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		goto fallback;
 	}
 
 	folio_ref_add(folio, nr_pages - 1);
-- 
2.48.1.711.g2feabab25a-goog


