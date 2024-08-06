Return-Path: <linux-kernel+bounces-276936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D126949A31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E98B2313F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BA3175D50;
	Tue,  6 Aug 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOAHmeYx"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DBD15ECF1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979741; cv=none; b=IgJIBvAkkdWMXOV9Q/YRqvQjIVHw0sHLs01Yl6iRftS8lT7CANZzJcQzEM3lhBF3SHY7clmkYzOZp9109Ye3fq9Ng0UfQL5EvCV2ZP5q+gC1xJy8APPUKANvtbkTHeuhaWkZ+ZWk/b5D5/3h5qx4udEx/E5ZnWh6jHBCscdUEL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979741; c=relaxed/simple;
	bh=dOp7lOrcLzKiQHMFRW++fqwZuN7KM4NLeFtEqGv9G20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFvbzRI0v14tmux+nj+xAN4N3i+9HECr/4nfI5vR5Z9izhktUjzSAovVFrd8qfJgGKpYLnvNDSzw3qSaGHVNdrFFrDgfMxfMTzzzBlSCS1Yuc4LLOUl4KY6tHahb6DNmZnt6l33evm2v1LTgaHc5exR2gmjZCC+LeaTi/Ll/vtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOAHmeYx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso7520245e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722979738; x=1723584538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etcXdj3Gafh+NAZ3OdhB7G7qgWQmpViAnZzXkT07D14=;
        b=iOAHmeYxoPgn1zIbD8z2RinWNK8t1whGU3yFoGoEuFLl6489qK+ZDwAGnemtBBQBps
         wnMJpVYmf79MSLqg+E4FZK6B3Zi7KbEsyaH58Vdo3ikEaJkuEw5BrLqpwMEK7A6pjmsa
         sWbFyhFL8ta0Y6HR8V10LqjLAqZ37D7FVuYw+xZP9lCj6v2BPxaFhlsRZeAUk/Eod+YE
         oVdQsX2N7aefZcUtQf6w+IEm1nUm8NdvNhlfnrJI4Kw2MQzAY+bFCuLF9nB64dXW6uii
         Se6a1hZwLEXNAbLoggPIshbTC22HVn6Pgy2VUIZHf2axnE9xYbI0YecY6uMhASvoXrPh
         mbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979738; x=1723584538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etcXdj3Gafh+NAZ3OdhB7G7qgWQmpViAnZzXkT07D14=;
        b=K9jF824V++UGKIbQccHak9hMAtl0wmHf9shFtZSAeLWkkzrYUfxGdb1t13LGD3QWoY
         b3tdk6DdS5tT6/5kTmABfrrPUnAGchqNzvt6irnCAfOugH/BxaOT3iU66d+OeduDrdsk
         4JUxoTwSYj6jsdnFQbnICUnwnuIar4OMESXTT7CnXineOg+E7Z+xRuFkF4PzWeX8sKBP
         Pv0ccdVUbFg+xDvoMreCULiIo9phlQqdk45l0paxuFgXJEifkF2u1nLSf1yhrCVcyR2d
         ioZwXe8+ZKyEnOsayKvu2f1qPDZ0ur9+QSqX3J+khOgs2dbE0ecQvfmGdaIfXTPpIxx6
         riOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJAqnTArGwgK/4MQKV9PdWR9BrwDF9RNVzU8wZQsO7bsoh7D0vyoFE4gqSjRo2x+x6AJxysCl9vYedHvvSYWMoahhsyZM8zryFUNKc
X-Gm-Message-State: AOJu0YznYLta9hkGW09Gz3ez2nsTvOV4pzi/GwtQAcm4JidchxzynslE
	Y1ztWvZ0a+ya0btWYycbxTvgDcC2z4NZ8Ljg8gI6+04tuiRaTKM6
X-Google-Smtp-Source: AGHT+IGRFPCSRqOADFcs6F880K74zKy/fyjtmt+7DweFI9MMFLoc37XUfF/Mh7Mb+xtZ0Bt5/QWsCQ==
X-Received: by 2002:a05:600c:46d0:b0:428:29d:4b59 with SMTP id 5b1f17b1804b1-428e6b09a2emr126203285e9.20.1722979737534;
        Tue, 06 Aug 2024 14:28:57 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290501f0d5sm1858545e9.31.2024.08.06.14.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:28:57 -0700 (PDT)
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
Subject: [PATCH 6/7] mseal: Replace can_modify_mm_madv with a vma variant
Date: Tue,  6 Aug 2024 22:28:07 +0100
Message-ID: <20240806212808.1885309-7-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806212808.1885309-1-pedro.falcato@gmail.com>
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
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
index 09ea930540f..4b516618389 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1517,8 +1517,7 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 
 bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end);
-bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
-		unsigned long end, int behavior);
+bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
 #else
 static inline int can_do_mseal(unsigned long flags)
 {
@@ -1531,8 +1530,7 @@ static inline bool can_modify_mm(struct mm_struct *mm, unsigned long start,
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
index 2170e2139ca..fdd1666344f 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -75,24 +75,15 @@ bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned long end)
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


