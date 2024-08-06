Return-Path: <linux-kernel+bounces-276931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FAF949A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080B0287200
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663C016F831;
	Tue,  6 Aug 2024 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK7uEJnB"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41DD16A94B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979736; cv=none; b=Of6zSCj0qWqSZV89EyV+sXcwcxJWzUBV6uRagNOIA6D1WgQqvLdRYTxy8122lCSL0i5600M0chUNJ4foALzyMQt75vGD7cINSImgu2h4DkGb4DvCj8luvran4HatviD0sMaa8oV96V55Py/CBiXbg0QvFPQF+wPrOoORXBb5zbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979736; c=relaxed/simple;
	bh=Au4AopVMNHLrw4VI4OdEf3KzGyMoyLBWiOWQCmMfxuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcF75zvXZ3aKDvi5Vzjzi16NUUOtvX8K9jaX6bw7kK71SjTR7THSEHaEIuA/818uYzcgjqxKX3AP5yayFqpOghMi597gswMAUPX/vUotIOYfAExpIG/4tFIh1mxATmEYHZ6gsO2wRxbLvvTa0pMDss9xq3lLGiv4i3aTOFMIjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK7uEJnB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e1915e18so7530845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722979733; x=1723584533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=domfBmFrCeEd8AJ/SLIoCSKrKiJu9/5c5x0kHSbw/Dg=;
        b=SK7uEJnBcOXxSEq8itadqcHmlhp+mXjTcnyApDyDRS5Vy2C3XqgJ4mhTPC3D83DIvC
         YuyTgTGaSUXwRUmxR+ZYwEvEJu+ryIax5BWiIi16YPOZb0IJMmhPTYjE83NmvMwUANIH
         /Y046I5o3p9TFig8gy4EGedji25d5ZCMgcPJUeTvHo2/q943bbvK3dkbLIDwkd0pIXNP
         U1SNnX8LPfXc7lb3dSmVCjQF2W29pRCDs0BPt1DIZqXYxaeVf5NIM8KWD2a5LWBaDaLB
         Lxr0VK6DxOkx+ytPxT4zElYwTzxEzWRzhQWB9gvbi85qnvxSaeQLCtWxlRFaI9Fj2/LW
         +34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979733; x=1723584533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=domfBmFrCeEd8AJ/SLIoCSKrKiJu9/5c5x0kHSbw/Dg=;
        b=dGIln6z0UKgxqZRShWqAgBQy+q06bpOt9/hKVcsOGjR6R3turQTHLn23ym1yTfzdBF
         7r1pcmf60ivYSllJFJDAonYVeGR8DgxWPF/VhKOMc+Y2JhzQGoz69w3U5ziqCrVYxu1m
         g91DK+oZYAFL9SYg1cy2GJUz8GZUhMyE3SlgzRpjIC/mX2VRgiFG3e6eQpJL2zU2GRQL
         rgT2XJeedhDBnHaPpwitMLSdmXLHkgj8Aa+V5lVb+2ST4fE0vHhZNO2r0qpA3xgsiRRc
         HUcfw1H27TgDuoKdoKrXGDOYwYZheugBzAOkBezYztLln240gBAjzmL7b9b3QQ5LCCRL
         Bo7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6nzVY15X/MOpcV1PCVDsPtJXobLYaNuTwgI4jp8xoK8T8/r+ow0R4VXN7EgHFd2LXwjJ+01RQCMaqkOTl1F2/g7wnR1pXwsdRtFWe
X-Gm-Message-State: AOJu0Yzr4rY/ghogNbz5u0OG//+p/OZHkA4UnBFapTom4pGR/4ZKVst3
	9a75k933DXbmiVoUxAxqbimivvsaTLFMAgg1w/DdyDInaNr+9/Y/
X-Google-Smtp-Source: AGHT+IFGyTIIlnKMg0jWiAX9WgQb0wH2svLBOpI0XEtPEz84np7Wxf3BbmF57jPnSkG1elyRKS+FXA==
X-Received: by 2002:a05:600c:4447:b0:426:5dca:50a with SMTP id 5b1f17b1804b1-428e6b31274mr104812875e9.21.1722979733038;
        Tue, 06 Aug 2024 14:28:53 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290501f0d5sm1858545e9.31.2024.08.06.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 14:28:52 -0700 (PDT)
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
Subject: [PATCH 2/7] mm/munmap: Replace can_modify_mm with can_modify_vma
Date: Tue,  6 Aug 2024 22:28:03 +0100
Message-ID: <20240806212808.1885309-3-pedro.falcato@gmail.com>
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

We were doing an extra mmap tree traversal just to check if the entire
range is modifiable. This can be done when we iterate through the VMAs
instead.

Note that this removes the arch_unmap() callsites and therefore isn't
quite ready for Proper(tm) upstreaming.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mmap.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d0dfc85b209..b88666f618b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2660,6 +2660,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
+		/* Don't bother splitting the VMA if we can't unmap it anyway */
+		if (!can_modify_vma(vma)) {
+			error = -EPERM;
+			goto start_split_failed;
+		}
+
 		error = __split_vma(vmi, vma, start, 1);
 		if (error)
 			goto start_split_failed;
@@ -2671,6 +2677,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 	next = vma;
 	do {
+		if (!can_modify_vma(vma)) {
+			error = -EPERM;
+			goto modify_vma_failed;
+		}
+
 		/* Does it split the end? */
 		if (next->vm_end > end) {
 			error = __split_vma(vmi, next, end, 0);
@@ -2763,6 +2774,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	__mt_destroy(&mt_detach);
 	return 0;
 
+modify_vma_failed:
 clear_tree_failed:
 userfaultfd_error:
 munmap_gather_failed:
@@ -2808,17 +2820,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
-	/*
-	 * Check if memory is sealed before arch_unmap.
-	 * Prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
 	/* Find the first overlapping VMA */
 	vma = vma_find(vmi, end);
 	if (!vma) {
@@ -3229,18 +3230,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, struct list_head *uf,
 		bool unlock)
 {
-	struct mm_struct *mm = vma->vm_mm;
-
-	/*
-	 * Check if memory is sealed before arch_unmap.
-	 * Prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
-	arch_unmap(mm, start, end);
-	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
+	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
 }
 
 /*
-- 
2.46.0


