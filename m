Return-Path: <linux-kernel+bounces-203592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72598FDD91
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5552028546D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF91DFEB;
	Thu,  6 Jun 2024 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIv1uy6V"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BB19D89B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717645237; cv=none; b=BE7Q8Ej3Ypu17MWp4WEnXhz3BkU6JHVp9KdSQchMMJKthcNFpwGNXBCkBXUPDbzQGLZPtV7iuuOU3xqy4SR8gOhoJNzRmRVWakNrCBEOpW/CYr1xfz1l0souRt7Jd1P0qfnp2iICt8UvNYTOFTAPPZ9tb+/9zI3jWn1E9+AwaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717645237; c=relaxed/simple;
	bh=RmW4qL9FONoAUakOhZfofwOu6g6FtaBG5npi6z6I4qY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WaFQl5//EdrGpvu4Sjj5nzv9cCTnj8oY6SELhQyIpd9qtOmyEXTmRB6sro3Hp13033bIHqDvrv2ZH+uvfr1Di3z1d2ZcGOk+fh0RHOSS2/MBBrC80e1JysZcZkeMecRipKgVpzzVFSssLAI2CGM/Ci5pBEyH61FfFbsdeXW9LkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIv1uy6V; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f44b42d1caso4994025ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 20:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717645235; x=1718250035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m0xWv0/mIfZjELLkhKXh+CJWnTqcZ0qlcrVWS0o/mss=;
        b=NIv1uy6VRYMHnjZYVMU4PCaStPp4JWgE8gkByYcZHujMbE3hCuP5iq16Z+JgRN9nSD
         OrniKfuuYkqAOW+Y+NDefgqvLCcQSaque+aYriHXlqC4kpwm/RJPdYGJwPXf8l58Sz3u
         2HijhZ5q6Zr3CvBoYdnce2qo7DSB7HrclnDO4/6Duyp7V2t4Bc62wpJbQw3qz9zvtS13
         KZ0YOYEDpJkCxYtrm660u5NVFidQHj+er8qMpOUc6ohta37YanzYBnjfAXQObECVbGdY
         iGwufAweC7zMxZkW6lbc3zptxc41XRG35S/erdrsZFj/gZYH3KC25RQkYb/VX+ZOGzh9
         ughA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717645235; x=1718250035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0xWv0/mIfZjELLkhKXh+CJWnTqcZ0qlcrVWS0o/mss=;
        b=h3R6N3O9py3Ii4SZrWY+NlBtumXt0ui6yK7TYDKUhB0PsGeRj1tiEUP+by3B7wv5EZ
         9or0ApT6lilZgZayk6nCzxSdDMPbZi2HHpv82nTtbeacCREmXqIyrPxK+XaZIeXwyUQH
         MvlgTsDiHhac/odYzgmsx9a90s1sI9raQaSjYi+zImt2N6hRgcMVpXjFySJnxF/qQIrC
         5ZLB1PcoEwGYe6NtZcNe4p3AIlsC1i7seBzg4iW6dmYSqnUFW22IjPn3ddeNtjf40ZuV
         IsQgNYtXY0RFI0+aShZkR1Kp2TTxnkwKkdeheF39dHkH7B6Rdr7JNDQGuyOPF7zSpVLR
         6tuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJXQ/mgS73V4VQH6h8FVlWnOYmVvive9IFOxFM798ZFtpXJA7ZUBBdebyF/n9UTIvY93iJu9IZwjdebvzCHc0xYaUJC9pVv0Bk8fcY
X-Gm-Message-State: AOJu0YyQLLDQukirh2fvgfXMcy+bkr8AGmxtoWbfZjGB6EvX4auqyjES
	otdJSKKSwU3w2mejxovfR00I4GYKky49oorzqDJYH3dvZaTPeeuL
X-Google-Smtp-Source: AGHT+IFUSRZyXANCiLPmbIEh7GVsB2DiB97BgrZ+OGnoxcZ2TyJBSstC44wcPExOyKYNeOsgSJTxpw==
X-Received: by 2002:a17:902:e88f:b0:1f6:1778:7f1b with SMTP id d9443c01a7336-1f6a5901d12mr51704285ad.1.1717645235264;
        Wed, 05 Jun 2024 20:40:35 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccf8bsm3148205ad.181.2024.06.05.20.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 20:40:34 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	minchan@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org
Subject: [PATCH] mm: introduce pmd|pte_need_soft_dirty_wp helpers for softdirty write-protect
Date: Thu,  6 Jun 2024 15:40:16 +1200
Message-Id: <20240606034016.82559-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patch introduces the pte_need_soft_dirty_wp and
pmd_need_soft_dirty_wp helpers to determine if write protection is
required for softdirty tracking. This can enhance code readability
and improve its overall appearance.

These new helpers are utilized in gup, huge_memory, and protect,
and are particularly applied in do_swap_page() to optimize a
softdirty scenario where mkwrite can still be performed.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v1:
 this is suggested by David here:
 https://lore.kernel.org/linux-mm/baf84b51-7e8a-4da8-9662-3f5cf14ad6f6@redhat.com/
 thanks!

 mm/gup.c         |  4 ++--
 mm/huge_memory.c |  2 +-
 mm/internal.h    | 10 ++++++++++
 mm/memory.c      |  2 +-
 mm/mprotect.c    |  2 +-
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 83e279731d1b..756d5416df9c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -820,7 +820,7 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 		return false;
 
 	/* ... and a write-fault isn't required for other reasons. */
-	if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
+	if (pmd_need_soft_dirty_wp(vma, pmd))
 		return false;
 	return !userfaultfd_huge_pmd_wp(vma, pmd);
 }
@@ -941,7 +941,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 		return false;
 
 	/* ... and a write-fault isn't required for other reasons. */
-	if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
+	if (pte_need_soft_dirty_wp(vma, pte))
 		return false;
 	return !userfaultfd_pte_wp(vma, pte);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3fbcd77f5957..8fbb62f6e491 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1625,7 +1625,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 		return false;
 
 	/* Do we need write faults for softdirty tracking? */
-	if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
+	if (pmd_need_soft_dirty_wp(vma, pmd))
 		return false;
 
 	/* Do we need write faults for uffd-wp tracking? */
diff --git a/mm/internal.h b/mm/internal.h
index 12e95fdf61e9..51551626da68 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1348,6 +1348,16 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
 
+static inline bool pmd_need_soft_dirty_wp(struct vm_area_struct *vma, pmd_t pmd)
+{
+	return vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd);
+}
+
+static inline bool pte_need_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte)
+{
+	return vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte);
+}
+
 static inline void vma_iter_config(struct vma_iterator *vmi,
 		unsigned long index, unsigned long last)
 {
diff --git a/mm/memory.c b/mm/memory.c
index db9130488231..6307c43796aa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4322,7 +4322,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio_test_ksm(folio) &&
 	    (exclusive || folio_ref_count(folio) == 1)) {
 		if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
-		    !vma_soft_dirty_enabled(vma)) {
+		    !pte_need_soft_dirty_wp(vma, pte)) {
 			pte = pte_mkwrite(pte, vma);
 			if (vmf->flags & FAULT_FLAG_WRITE) {
 				pte = pte_mkdirty(pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 888ef66468db..5aea9ad11ae1 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -53,7 +53,7 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 		return false;
 
 	/* Do we need write faults for softdirty tracking? */
-	if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
+	if (pte_need_soft_dirty_wp(vma, pte))
 		return false;
 
 	/* Do we need write faults for uffd-wp tracking? */
-- 
2.34.1


