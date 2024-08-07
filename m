Return-Path: <linux-kernel+bounces-278562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFD094B1D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA771C21A69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C5153836;
	Wed,  7 Aug 2024 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8jA80bW"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E915350B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065202; cv=none; b=nv755oQ0MiUHb99gl5sy0Tib3ndX9fwTpUzeDN+CfBJgYNrv0E7XEa+aLUCm+ZZLAGcYEDrWgjEMjdzaH6tauwPbB+ktwZcddaHoqF57zyLlzLJ2yp4XJ0SISmy1du6MEWrK3bQic2gEkrZxh7A9Hvm2NDV4nbH25hXvC6orXHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065202; c=relaxed/simple;
	bh=/gspaFWJDJLeLetQL90OX237oaMCnuZKq5sjs9BKJm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ14Y64Q32wNicTHCM6xUAFLWD0zfHnVlPFqffc+9vloSbHUYon/JAeu+963Gcj3FI0DooQCZKQoVLgam8PCUx8pcW+z59yBmbyAyztfmTDXCkPrOi6wN+R7hob2ux8kiB3IRItC14f3ZDWRoBpY1X4aVyf0cU8v3TMrSWC0jVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8jA80bW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso7977235e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723065199; x=1723669999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qlhSaIRab8Wung5E+rEtGMuSqzg1qoR4sFw2btGeDg=;
        b=b8jA80bWvcgG4gazRjZWMCNfO42EY0VHkMCaP+uEuC1h4Z2pynDqtjw/k8NR6QOECb
         yQjuXoCImZhKKNyfTubr100Ty7+apXAEB6FSPvx5Ekrb/lB1zMbHw7YWRR+nuLqN5Y1i
         01+ZEsroGgZ2DzzeCs9ZzTO3c6ZdnfdDqErNGghTTGzDFYIkA14fL8iGXMkQkpOazn93
         tG4PL8ZD/uwJLclx9TMJoZ/GuOmLGxmW0NDrLP4FJvQQK+crxmGIDZntfrQuro7oN2iy
         oVtFeIdkRe5Q6L+WtnHCNIujzCjvS4qXJyLzG3qdU1AuU67Hr6GyheUf0D2Qvz0C4RsF
         uLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065199; x=1723669999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qlhSaIRab8Wung5E+rEtGMuSqzg1qoR4sFw2btGeDg=;
        b=MRUatxR/+/UapChj+/Iz4G/6PZpWBF5dz2BZXyR+S2cYKspE/WOzE9y5J9ANs+Nj+1
         CcYe8Ergon3fjGHX9Et7+WZEwSS/Vyufziq53b5lD+4/jnpJU10weGF8Gfy1cX/V5tz1
         n3f9/CqlRG1BL3sVfwUpJz+Vg/zoPgkE0djQweamy2d0ae9rwRTtDibcuy0JvxnTGYkt
         QNud++pdKmmRhGh9X4Avauji0K/AsCQeC3ogkDOFZuSJJUigMSin3+4qZ9sEKCQNvPRn
         gGvJB7D0uDoDVmhSA4sP+WkTfLgB0jFcEH6n/loGJ0uj2sihispF8U4GhZyBIo/0Kbzk
         B+5w==
X-Forwarded-Encrypted: i=1; AJvYcCVquYEoFVnPB90Ef6qQNEmH0ZLIk2u0m1Y0lDBhw16k3CZbD/8l1zS4qTqGG2DueQbJZ3x9xzKB80nayXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCULk2l19YGoBjREEI6kCFjEIAa054xlecSD44othHsMnQyBD
	f+sEhex1fYvR5u13XKZt4Kzdf0x4w9QvpyjvIXZqvQBG1cPEeChG
X-Google-Smtp-Source: AGHT+IEFvCk2bGgrTTvk0BjzIOPz08n+ZvmcQ77dBJ4LSBJvkWxUtgROJJ64vDaajtz7dL3+Xzk3EA==
X-Received: by 2002:a05:600c:3591:b0:426:5fa7:b495 with SMTP id 5b1f17b1804b1-429052dbdfcmr24752385e9.15.1723065198977;
        Wed, 07 Aug 2024 14:13:18 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057a92c8sm45869525e9.23.2024.08.07.14.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:13:18 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	torvalds@linux-foundation.org,
	jeffxu@google.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2 5/6] mseal: Replace can_modify_mm_madv with a vma variant
Date: Wed,  7 Aug 2024 22:13:08 +0100
Message-ID: <20240807211309.2729719-6-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807211309.2729719-1-pedro.falcato@gmail.com>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace can_modify_mm_madv() with a single vma variant, and associated
checks in madvise.

While we're at it, also invert the order of checks in:
 if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma))

Checking if we can modify the vma itself (through vm_flags) is
certainly cheaper than is_ro_anon() due to arch_vma_access_permitted()
looking at e.g pkeys registers (with extra branches) in some
architectures.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/internal.h |  6 ++----
 mm/madvise.c  | 13 +++----------
 mm/mseal.c    | 17 ++++-------------
 3 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 90f50f3c4cf..3f9a5c17626 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1373,8 +1373,7 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 
 bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end);
-bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
-		unsigned long end, int behavior);
+bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
 #else
 static inline int can_do_mseal(unsigned long flags)
 {
@@ -1387,8 +1386,7 @@ static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 	return true;
 }
 
-static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
-		unsigned long end, int behavior)
+static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
 {
 	return true;
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index 89089d84f8d..4e64770be16 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1031,6 +1031,9 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	struct anon_vma_name *anon_name;
 	unsigned long new_flags = vma->vm_flags;
 
+	if (unlikely(!can_modify_vma_madv(vma, behavior)))
+		return -EPERM;
+
 	switch (behavior) {
 	case MADV_REMOVE:
 		return madvise_remove(vma, prev, start, end);
@@ -1448,15 +1451,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	start = untagged_addr_remote(mm, start);
 	end = start + len;
 
-	/*
-	 * Check if the address range is sealed for do_madvise().
-	 * can_modify_mm_madv assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm_madv(mm, start, end, behavior))) {
-		error = -EPERM;
-		goto out;
-	}
-
 	blk_start_plug(&plug);
 	switch (behavior) {
 	case MADV_POPULATE_READ:
@@ -1470,7 +1464,6 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	}
 	blk_finish_plug(&plug);
 
-out:
 	if (write)
 		mmap_write_unlock(mm);
 	else
diff --git a/mm/mseal.c b/mm/mseal.c
index 4591ae8d29c..6559242dd05 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -67,24 +67,15 @@ bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
 }
 
 /*
- * Check if the vmas of a memory range are allowed to be modified by madvise.
- * the memory ranger can have a gap (unallocated memory).
- * return true, if it is allowed.
+ * Check if a vma is allowed to be modified by madvise.
  */
-bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, unsigned long end,
-		int behavior)
+bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
 {
-	struct vm_area_struct *vma;
-
-	VMA_ITERATOR(vmi, mm, start);
-
 	if (!is_madv_discard(behavior))
 		return true;
 
-	/* going through each vma to check. */
-	for_each_vma_range(vmi, vma, end)
-		if (unlikely(is_ro_anon(vma) && !can_modify_vma(vma)))
-			return false;
+	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
+		return false;
 
 	/* Allow by default. */
 	return true;
-- 
2.46.0


