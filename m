Return-Path: <linux-kernel+bounces-250784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7227092FCC9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C740282B78
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E8217277F;
	Fri, 12 Jul 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOJRwdg9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77912171E65
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795373; cv=none; b=r6r5qVzQXA1wBy/n++0NIUgW87pcMJpqT51wx3eRAHNeb5bDB0cAZAi76J1OdSvnajK4LFAADzSGWvFyj1bWfgPNWoyUsqF3PYnOwRT6dANajXBwCeRl6Z4l0nEET4K+hCLN8S6yJ/bWePJRuzaCnz3q+/mqWhboT5p1KuwnOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795373; c=relaxed/simple;
	bh=cs8RAAmeZFibwj6X9RS/L3QWwv7Bo1fpcy8SZbyQFkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1lQ4BeQzcuybxY0G700YNBnqJles36eQiN/WnnD9IiXWq8gRYaV/3k93yLC06Dysq97qnuKNIXWB0MNsAz29K7Y0/i7rlx3qazbv6Vl/KdMrHM5dxXHFTA/uQMfFTzEvs7PDCRI+mxJ/jyQqP366pktp/auEZ+YCmyZBVhWU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOJRwdg9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720795370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qL1WmhqHrdkgEQfSkzrg4ZwshTTtxr8eNmW6cIXKmXw=;
	b=UOJRwdg9kvlffzCSXJt9ydd1r3gWozYQWaZ2k+fkhirNwfF6sUGMD3zZObtyxpjOa6Nyv3
	pgBHZZ4zgunk02LzKF9Mql9c000X3aGwNo0dbF4CeXX1z7c2gIGT3TKrqseRFImQLKQY70
	omnyZ91ROb/EURM1ETbIFjZGkibW120=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-K-2KAKCrO1W19C5c6UXNiw-1; Fri, 12 Jul 2024 10:42:49 -0400
X-MC-Unique: K-2KAKCrO1W19C5c6UXNiw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b5eca5e699so943486d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720795368; x=1721400168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qL1WmhqHrdkgEQfSkzrg4ZwshTTtxr8eNmW6cIXKmXw=;
        b=eCyYGGBOrTTGV9zAzzvJEcwqzLHc74RWlazTh7kvCIeCai2XGxM9SDWrTm8YILqaU2
         V4iz3fqhPnh+Uc0JMP+acUkx7GPlW/O1B5h3hFRl9BJc7uWc8Bn2bty2BbONPw8mPyaJ
         IDck+BH4RXPzo7J7H1uvDgkWVbMQnAR2MMJtyyaadhD5xmvp9/uHtIlgnMCbJ4Ds4JhB
         NQiK7GMDLaRY4cK4oO6qettKX1yhhFfSmHG5e8l0Hh43w+eTGnUfx0nt3uJaViCuPQ4Z
         JIhSGYQFNbJqC9/ukipycNvGS4DZTsxOtPNBMioeOkfg4wsPqHusuHBfRBGmwNp5NrVE
         /ubg==
X-Gm-Message-State: AOJu0Yx4EyZytv6VPDG7K14NBFhtdJx7+ByoU8zEPFJ/sq+dDkWLtpet
	SHWjPe7C6a6EUS+f3VQu9w64J51G36Sp0p4qwY5QEYHeoMJAO/gaeZWO8Xe5cIT8zzyOERRuz93
	YLyeXYvY9ZOuJgfrU5/bv+cmL/35O0YcH40Aio02uj3/KmPS4DeO+h8IaTxBL8Mfou3Dphb2GVg
	GJu4FET+c8LrlMx3xACvH/mE2oNOIh5jFIIDPKetYs/Jk=
X-Received: by 2002:a05:6214:514d:b0:6b2:b13d:5b75 with SMTP id 6a1803df08f44-6b61bc801a7mr119834796d6.1.1720795368105;
        Fri, 12 Jul 2024 07:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeOScnWHFAYqzIrDECr2bZ2kxJhPeSR3us+DvzEHpXbWhPh5U0cpMTIvKk/Nyzyx623Ev09A==
X-Received: by 2002:a05:6214:514d:b0:6b2:b13d:5b75 with SMTP id 6a1803df08f44-6b61bc801a7mr119834396d6.1.1720795367584;
        Fri, 12 Jul 2024 07:42:47 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba77767sm35825716d6.95.2024.07.12.07.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:42:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	x86@kernel.org,
	Yan Zhao <yan.y.zhao@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pei Li <peili.dev@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	David Wang <00107082@163.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Date: Fri, 12 Jul 2024 10:42:44 -0400
Message-ID: <20240712144244.3090089-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is one patch of an old series [1] that got reposted standalone
here, with the hope to fix some reported untrack_pfn() issues reported
recently [2,3], where there used to be other fix [4] but unfortunately
which looks like to cause other issues.  The hope is this patch can fix it
the right way.

X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
start at mmap() of device drivers, then untracked when munmap().  However
in the current code the untrack is done in unmap_single_vma().  This might
be problematic.

For example, unmap_single_vma() can be used nowadays even for zapping a
single page rather than the whole vmas.  It's very confusing to do whole
vma untracking in this function even if a caller would like to zap one
page.  It could simply be wrong.

Such issue won't be exposed by things like MADV_DONTNEED won't ever work
for pfnmaps and it'll fail the madvise() already before reaching here.
However looks like it can be triggered like what was reported where invoked
from an unmap request from a file vma.

There's also work [5] on VFIO (merged now) to allow tearing down MMIO
pgtables before an munmap(), in which case we may not want to untrack the
pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
pfn tracking information as those pfn mappings can be restored later with
the same vma object.  Currently it's not an immediate problem for VFIO, as
VFIO uses UC- by default, but it looks like there's plan to extend that in
the near future.

IIUC, this was overlooked when zap_page_range_single() was introduced,
while in the past it was only used in the munmap() path which wants to
always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
zap_page_range() callers that act on a single VMA use separate helper") is
the initial commit that introduced unmap_single_vma(), in which the chunk
of untrack_pfn() was moved over from unmap_vmas().

Recover that behavior to untrack pfnmap only when unmap regions.

[1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
[2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
[3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
[4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
[5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: x86@kernel.org
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Pei Li <peili.dev@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Wang <00107082@163.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

NOTE: I massaged the commit message comparing to the rfc post [1], the
patch itself is untouched.  Also removed rfc tag, and added more people
into the loop. Please kindly help test this patch if you have a reproducer,
as I can't reproduce it myself even with the syzbot reproducer on top of
mm-unstable.  Instead of further check on the reproducer, I decided to send
this out first as we have a bunch of reproducers on the list now..
---
 mm/memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4bcd79619574..f57cc304b318 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 	if (vma->vm_file)
 		uprobe_munmap(vma, start, end);
 
-	if (unlikely(vma->vm_flags & VM_PFNMAP))
-		untrack_pfn(vma, 0, 0, mm_wr_locked);
-
 	if (start != end) {
 		if (unlikely(is_vm_hugetlb_page(vma))) {
 			/*
@@ -1894,6 +1891,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
 		unsigned long start = start_addr;
 		unsigned long end = end_addr;
 		hugetlb_zap_begin(vma, &start, &end);
+		if (unlikely(vma->vm_flags & VM_PFNMAP))
+			untrack_pfn(vma, 0, 0, mm_wr_locked);
 		unmap_single_vma(tlb, vma, start, end, &details,
 				 mm_wr_locked);
 		hugetlb_zap_end(vma, &details);
-- 
2.45.0


