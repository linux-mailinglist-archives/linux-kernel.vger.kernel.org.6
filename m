Return-Path: <linux-kernel+bounces-206757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AF0900D5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063AA1C21358
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F315532B;
	Fri,  7 Jun 2024 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjsVL9Jh"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5312D600
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717794866; cv=none; b=a3Y8Jr7ygSLuhz76UpRTz47wRfnSi2MSG1bYLsTqTeQ2IG33t8E/dwwngUICEaLOeKv3LTMySuiXa6fDfTpalCVWrFGDXFs5EdjRPAOaEBqxYgBsKyRq2x1AQGAEsylSdS1i6nn9XzrziKHWoxS3XIUUJcN0+GuqJwC4IPf3qbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717794866; c=relaxed/simple;
	bh=H42gb2DitcbJvZ0il0BlBxvvhBZnL9oKHsL4JaAXjtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFSN/Xl3V3bx+Bb6Php2cwryzqJsnBTjenBkFrdrMh1Egj4+EPWhbtCRZkRhNknZnrzO3fyqapwH/JZfkbfW87Aai8hwB+HTMlg1izEpuLMxhxnicwd48H23QQZdTVT5OrVSBFq9CkZh0sXdHYayPTbbKEwmOCerQLk79/6AI6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjsVL9Jh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-702508bf0a9so2147251b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717794864; x=1718399664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EhyAEXMHGWRHoN2nWQIucIAZ80NTOZFSo695eAloq0=;
        b=KjsVL9JhtFSXAIONZN3TySiV5+Fba/mknISo7SoOpgcOTib/GCz+0ZwC7aAcroI3D8
         EcUBlSlFHCgpan5UKeHhvvt2Q4oqf4byNbmFa+HTb3blBvDKg8Ue3UDHFZhV9cGLbdI9
         cVZFCRn69OCGhE+vLH2zs9JmsYN79JRZTJRcVTB/qGatz0tGRwBI80Jde93bbvFdmDXh
         OqnyWAcLhgM+YMhWmRBm0CGPFa4yv2kVAE2CbfSFiTaSUyZDwykcnJhpLeqTsWHJqrSM
         pVWEM5XR8Y8xoVe2sRYDgCQ7Xix05/ZZ8buLy4LrGNN+Z0UgsbWIRimhmz77WStLYIOY
         lqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717794864; x=1718399664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EhyAEXMHGWRHoN2nWQIucIAZ80NTOZFSo695eAloq0=;
        b=wTPCeywNlGhLv7kmHqM/d7BOREpz/k3/wW+CjrM7RKcI0dKPrk8Ca5wjQHOeavz7wg
         QyI19ZDz0R7iD1j3V8JMYlpGBJhIDrikEzJe7ZjAXJR4uWpSPWwbm2rucMO/ojOmZt+a
         PVwULlJf0QbKs5IgTD+PMn2mmXHgtCFuBWF/e0W741Huaniw+THUEHGVI88KoafEd5be
         Yz7IN/KYKJYYqxIESGBnrgLdqpSkwXC+E51ZmCmRqu4e801E05l/8fn59bmxhjiJtm+9
         SrPaksdhMSAk/E1j9hddmir99OtYZ2oIYLYzIfGmIsg8cvmoew0VbvuCKVv9uMaWXQI+
         YE7w==
X-Forwarded-Encrypted: i=1; AJvYcCVrwzmENFeUF40EKWW7ZDflgHI20ROk3yL8Ynxv5VYhREnWrsMTwHgmSlFBRKqzriUqJpg03nceEh34eG5aM8cdln4UQFn1PFqtV9sD
X-Gm-Message-State: AOJu0YyOmw6Db4CaLwvDNfaGBL6K8mVn2ZrqJZJakejm34QsUN1A214W
	kuIWqYfysiVjsVWqPBtN7H0RzBsqR+n8ri2u06bvKDBtjzxAEd0R
X-Google-Smtp-Source: AGHT+IGVoYiDVigicI/nhRgC8cicg0NVdYKQ8BhxWWU6cBhpa44pUV1eORXN83dUfhdGXGQ3pcR2lA==
X-Received: by 2002:a05:6a20:918f:b0:1a9:dd82:a42a with SMTP id adf61e73a8af0-1b2f9a5f4f4mr4021460637.31.1717794863849;
        Fri, 07 Jun 2024 14:14:23 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6d859ea3csm17912255ad.178.2024.06.07.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:14:23 -0700 (PDT)
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
Subject: [PATCH v2 1/2] mm: introduce pmd|pte_needs_soft_dirty_wp helpers for softdirty write-protect
Date: Sat,  8 Jun 2024 09:13:57 +1200
Message-Id: <20240607211358.4660-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607211358.4660-1-21cnbao@gmail.com>
References: <20240607211358.4660-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patch introduces the pte_needs_soft_dirty_wp and
pmd_needs_soft_dirty_wp helpers to determine if write protection is
required for softdirty tracking. This can enhance code readability
and improve its overall appearance.
These new helpers are then utilized in gup, huge_memory, and mprotect.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/gup.c         |  4 ++--
 mm/huge_memory.c |  2 +-
 mm/internal.h    | 10 ++++++++++
 mm/mprotect.c    |  2 +-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 83e279731d1b..f15756a3646a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -820,7 +820,7 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
 		return false;
 
 	/* ... and a write-fault isn't required for other reasons. */
-	if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
+	if (pmd_needs_soft_dirty_wp(vma, pmd))
 		return false;
 	return !userfaultfd_huge_pmd_wp(vma, pmd);
 }
@@ -941,7 +941,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 		return false;
 
 	/* ... and a write-fault isn't required for other reasons. */
-	if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
+	if (pte_needs_soft_dirty_wp(vma, pte))
 		return false;
 	return !userfaultfd_pte_wp(vma, pte);
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3fbcd77f5957..b29daea9c317 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1625,7 +1625,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 		return false;
 
 	/* Do we need write faults for softdirty tracking? */
-	if (vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd))
+	if (pmd_needs_soft_dirty_wp(vma, pmd))
 		return false;
 
 	/* Do we need write faults for uffd-wp tracking? */
diff --git a/mm/internal.h b/mm/internal.h
index 12e95fdf61e9..b7853fd57d9a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1348,6 +1348,16 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
 
+static inline bool pmd_needs_soft_dirty_wp(struct vm_area_struct *vma, pmd_t pmd)
+{
+	return vma_soft_dirty_enabled(vma) && !pmd_soft_dirty(pmd);
+}
+
+static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte)
+{
+	return vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte);
+}
+
 static inline void vma_iter_config(struct vma_iterator *vmi,
 		unsigned long index, unsigned long last)
 {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 888ef66468db..222ab434da54 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -53,7 +53,7 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 		return false;
 
 	/* Do we need write faults for softdirty tracking? */
-	if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
+	if (pte_needs_soft_dirty_wp(vma, pte))
 		return false;
 
 	/* Do we need write faults for uffd-wp tracking? */
-- 
2.34.1


