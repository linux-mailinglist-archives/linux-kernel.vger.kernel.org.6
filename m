Return-Path: <linux-kernel+bounces-276933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4DB949A2E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929971C21CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9E7170A1C;
	Tue,  6 Aug 2024 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGxK3eUj"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643316F84A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979739; cv=none; b=NK3ZQ1h5x10HofBP/vcyUx8nKMWJssUVo8qv0CI8hvvoG693dBtZg9fokuCtklU6kGfoqHu3SyUqnIsV+n6DbenQWSvmqZjEtVfilwQxe73L756n3NkSn9eQNmDeb36mrhP/PjTuW5V/GCkp7FwsxR8YZefhOf9Rk9ck5EqU6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979739; c=relaxed/simple;
	bh=v4B/SCbHPpbPlEcxgqBZ7deqT9TH2TdBcorYleNkT6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FT1WtvshZLKVAdUO/aTmM3p93a2BAMK1T6AiiFPxtFuXfKPaaP2ykG1ZSnuyiV7y0aub+u2dxwIexmOpFrSWCEZfJhn0CMItLrdwp8GkwP7zLx56A8jGYKHbbVetb1wD3gSGDsgH4RPeYfZDkQeW4Qj8GZUNN7METz9kFxPuKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGxK3eUj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so7421955e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722979736; x=1723584536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yM1YbCcZNsiuGnwCjfcKYS7TLfeIBdj72FSrCE3wH8=;
        b=CGxK3eUjr2iAMU39BiW5jUblPce6s6fHrtD/wpq2bk30Dcztu09uc7U5WD/1QYZ4U7
         9TZYhh8HHHrIS25Q53YB8vgoro/nxFhzxHV5bUDt4pMkeK+KHerpSinQ6KnXhPCx9WU0
         Ub0OuACorIBECxQOOGScK+TosLlZybXZzsPvfvK7/VuWUrbmoooXrww2NftvWgWUTKLy
         JsmcRQZDwDeRy3uiVdNDBeHkeon6GYVCYbNuJ7Hf2og2rEqk1BNxXyh7KYeBz1EpEzSz
         ipd4dii32Yyj7lyhTYIkslqQyAb9Bi3wxgqXZL5Erpj4YkdFoPVxccyp+qXWsoddzAhN
         Afhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979736; x=1723584536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yM1YbCcZNsiuGnwCjfcKYS7TLfeIBdj72FSrCE3wH8=;
        b=GqIo9Ltnltl2+oFjYTbiXExCEat6yIGvkAnUBFCc0OEISJt0GW0lAmJR7uNOiAb0Wr
         zB2tN2pnnOY/g6oitmtL4Ni+822h6QcraFPFERuj8stysbOJC9e0fVLUEcY8KQmrOW9W
         7uJI/5yp7lDr1UMTxordAK6zB5xcRW8OA4ZEnRE3VHPLa/BRl2x/Bh4ZOFTuQ+EiXNme
         1sx8yE+jrI0V9EAVWwSGXsWvWAwp1vUz1SeCnhxs8sRfH2a2d3YQjxKvvgU4wybkcF9D
         1xHQP5WID3XE+871YrMfdiUotxwpIh2KS2QDgpEnq8cuhFagIfzaM/5QIapJLHqCEMJc
         ra8A==
X-Forwarded-Encrypted: i=1; AJvYcCW44tHPlvJ+o1LOR+e15xu4aDV5KQayx9ilCbro2u5CH/qNByto/UBbW4tWrFdXzGet8dwarFCGmlEf6k1vQa+uHz+8MR00VvX1C0OF
X-Gm-Message-State: AOJu0YySVpHVj7UnWcz+ezkcQkXK005OcaKebWlbOcSUoWCsg7g2jvQn
	UlHcF/bPwcni2v3NbjrnIcnDu5xH3lPSL5hBz4/lielR8HfKc0No
X-Google-Smtp-Source: AGHT+IFKF4Keu7U+7RmhvWeb9infuYn+flZVMPxZCRs2pmlb0q/OoQxxO6a7MebGMm65QOQXTqWjeA==
X-Received: by 2002:a05:600c:468b:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-428e6b7cb7bmr115877715e9.27.1722979735307;
        Tue, 06 Aug 2024 14:28:55 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290501f0d5sm1858545e9.31.2024.08.06.14.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:28:54 -0700 (PDT)
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
Subject: [PATCH 4/7] mm/mremap: Replace can_modify_mm with can_modify_vma
Date: Tue,  6 Aug 2024 22:28:05 +0100
Message-ID: <20240806212808.1885309-5-pedro.falcato@gmail.com>
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

Delegate all can_modify checks to the proper places. Unmap checks are
done in do_unmap (et al).

This patch allows for mremap partial failure in certain cases (for
instance, when destination VMAs aren't sealed, but the source VMA is).
It shouldn't be too troublesome, as you'd need to go out of your way to
do illegal operations on a VMA.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mremap.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e7ae140fc64..8af877d7bb0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -676,6 +676,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (unlikely(flags & MREMAP_DONTUNMAP))
 		to_account = new_len;
 
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		if (vma->vm_start != old_addr)
 			err = vma->vm_ops->may_split(vma, old_addr);
@@ -821,6 +824,10 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 	if (!vma)
 		return ERR_PTR(-EFAULT);
 
+	/* Don't allow vma expansion when it has already been sealed */
+	if (!can_modify_vma(vma))
+		return ERR_PTR(-EPERM);
+
 	/*
 	 * !old_len is a special case where an attempt is made to 'duplicate'
 	 * a mapping.  This makes no sense for private mappings as it will
@@ -902,19 +909,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
-	/*
-	 * In mremap_to().
-	 * Move a VMA to another location, check if src addr is sealed.
-	 *
-	 * Place can_modify_mm here because mremap_to()
-	 * does its own checking for address range, and we only
-	 * check the sealing after passing those checks.
-	 *
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, addr, addr + old_len)))
-		return -EPERM;
-
 	if (flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
@@ -1079,19 +1073,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
-	/*
-	 * Below is shrink/expand case (not mremap_to())
-	 * Check if src address is sealed, if so, reject.
-	 * In other words, prevent shrinking or expanding a sealed VMA.
-	 *
-	 * Place can_modify_mm here so we can keep the logic related to
-	 * shrink/expand together.
-	 */
-	if (unlikely(!can_modify_mm(mm, addr, addr + old_len))) {
-		ret = -EPERM;
-		goto out;
-	}
-
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-- 
2.46.0


