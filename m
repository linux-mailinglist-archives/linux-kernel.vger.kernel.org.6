Return-Path: <linux-kernel+bounces-188080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A678CDCE8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07877285AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E8128393;
	Thu, 23 May 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QroaYoqV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A882897
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503875; cv=none; b=fjbIG99rv9nrUIiRWyC4q3M/7KGJUK5Or6bGfcelS6IHWt/CGPsPk0Lwc75Uc9AJldaeOw5eMQkLdX0xlO6fBKso3WCRDWoVJYLt/hcbXx1ol7P+yfPjW1bFggk1ACIYLaKPmwBsBbMCVbIm4Z+h+f9AIxk9xk51n31j/OCaOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503875; c=relaxed/simple;
	bh=QWzUAxT1fadAj+S8ZExg6ADwc0sLe2rrYettfgCQdmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ayk+HHhzk+Gefiadpo4RldaLVkS6dddLcskq9AYYcMwCO/W9Xw6CUGMbo9WVeNyBeQro83IiCV3payxu/Cki3aWU7ep4upC58PQzjDJBDBRI3CfeobQ/3nSszrLhJu8UnD9PLoGNxJdBPY55sN5pocTdB6hUdWGbZMqMwbmwYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QroaYoqV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716503872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5pESLIFkXbJ9rNrzrPx/8xy3yB6kYubSyOytZTtev4=;
	b=QroaYoqVrzrmYAj05Q1mUD4XFocC0o5KBim04zO11Z1dQmUEzclvQTqEPF80zkZHUhEbvS
	TcrCdMVpm39Vc8PhTstNXzYynEGhALrJHt0Q/gM+Y+wxhd0pXVo3C0rKBQhMoIqczq6Y06
	9WvCP2nCERZlJYO7cQg5WuunU3zxP9c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-76KX8JS7NXeIQJkjyVvdWw-1; Thu, 23 May 2024 18:37:51 -0400
X-MC-Unique: 76KX8JS7NXeIQJkjyVvdWw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6a35d03abb4so1402576d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716503871; x=1717108671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5pESLIFkXbJ9rNrzrPx/8xy3yB6kYubSyOytZTtev4=;
        b=jUph5xJIwrotIYpAuz7nWyZCjDqhqhl+ackgTPCO7eqZXWR+x1lUkcY5rhgGCtBepO
         g4Zrpq0Hi/22tF862nRgAIkONuLjtw2QwbpnJPrUB4m5NmN9XVBI42uOA+/LGU/fkgYQ
         H1FKYgUjjGj+INk1elcaISHT3Jaey4QkNaUn2L4qHdj2U3iS8jwW2B2L46O9kKQ5lT2k
         koDYDXSngsvll8SNJ9d/6Pho/ok4GzAtPs5DugJxl8tFBxCwZd3KTVlerPTm35ZD6StK
         jT20CHj0aLkxezUQgHa+v8O/9KQNu/Y1GDXWwfbWXtrxoLndGvn5T5IdFcPux6bn0pMu
         i2og==
X-Forwarded-Encrypted: i=1; AJvYcCXubi6bCgsw196bPZwyPBW+OD06L5hLMdBFE+5/OZm0Zq/LsfPjeZ67gJxWdoJwKMisYQij6DZiZ1S9S12VxwC7UV/FEoojVgO8szfS
X-Gm-Message-State: AOJu0YwC7kmBfoNlpynjtWjqI+f+7zNlBCAwVCtslG+tNN4AmWGpFzaf
	iESnwcNXhkkEKMBMuowJxC7nbxla+FCj6YDujAKolgYMSsDxNpyOfK/bVp16SuF3ioQnpZNQHer
	JCkRsNzdvtZd89tipSCk+OvBQUMRut5nqRy0jVKVtexyi2hQSMGiyuYEdjOQ9hg==
X-Received: by 2002:ac8:590c:0:b0:439:a36f:eaeb with SMTP id d75a77b69052e-43fb0d79eefmr5060671cf.0.1716503870450;
        Thu, 23 May 2024 15:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBsa85pBg63N2c/DHFGiqK33waIm3Jb+f2auHqGTdFvIXtAgZRarZeur5jH8bVIPCG4ZRiKQ==
X-Received: by 2002:ac8:590c:0:b0:439:a36f:eaeb with SMTP id d75a77b69052e-43fb0d79eefmr5060331cf.0.1716503869770;
        Thu, 23 May 2024 15:37:49 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18af1d2sm1066701cf.65.2024.05.23.15.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 15:37:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	peterx@redhat.com,
	Dan Williams <dan.j.williams@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Rapoport <rppt@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Subject: [PATCH RFC 1/2] mm/x86/pat: Only untrack the pfn range if unmap region
Date: Thu, 23 May 2024 18:37:44 -0400
Message-ID: <20240523223745.395337-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523223745.395337-1-peterx@redhat.com>
References: <20240523223745.395337-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

X86 uses pfn tracking to do pfnmaps.  It looks like the tracking is
normally started at mmap() of device drivers, then untracked when munmap().

However in the current code the untrack is done in unmap_single_vma().
This might be problematic.

For example, unmap_single_vma() can be used nowadays even for zapping a
single page rather than the whole vmas.  It's very confusing to do whole
vma untracking in this function even if a caller would like to zap one
page.

That may not yet be a problem, may because of multiple reasons:

 (1) Things like MADV_DONTNEED won't ever work for pfnmaps and it'll fail
     already before reaching here.

 (2) If some pfn tracking is lost by accident, the default fallback is to
     use UC-, which might be safe enough even if it may not be wanted.  One
     can see track_pfn_insert() -> lookup_memtype() which can fall back to
     the default _PAGE_CACHE_MODE_UC_MINUS for a MMIO range.

However there's ongoing work [1] on VFIO driver to allow tearing down MMIO
pgtables before an munmap(), in which case we may not want to untrack the
pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
pfn tracking information as those pfn mappings can be restored later with
the same vma object.  In VFIO's use case it can be remapped later if the
VFIO mapped MMIO region got re-enabled (e.g. PCI_COMMAND_MEMORY set).  In
this case we should do pfn track for the whole lifecycle of the vma.

IIUC, this was overlooked when zap_page_range_single() was introduced,
while in the past it was only used in the munmap() path which wants to
always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
zap_page_range() callers that act on a single VMA use separate helper") is
the initial commit that introduced unmap_single_vma(), in which the chunk
of untrack_pfn() was moved over from unmap_vmas().

Recover that behavior to untrack pfnmap only when unmap regions.

[1] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com

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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b5453b86ec4b..9db5e8730d12 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1821,9 +1821,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 	if (vma->vm_file)
 		uprobe_munmap(vma, start, end);
 
-	if (unlikely(vma->vm_flags & VM_PFNMAP))
-		untrack_pfn(vma, 0, 0, mm_wr_locked);
-
 	if (start != end) {
 		if (unlikely(is_vm_hugetlb_page(vma))) {
 			/*
@@ -1888,6 +1885,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
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


