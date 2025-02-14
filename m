Return-Path: <linux-kernel+bounces-514696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29C7A35A63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2716C188F685
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C5423A9AA;
	Fri, 14 Feb 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQYdxGU9"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49936205AB8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525432; cv=none; b=sNGzH0cvaxj3kxT3cETaUJDRDDAzRuIbxOvsxHlQgti8lpm8lFwzA5AJvai6+c508E38COw3PIvkTpJCEPx6aE6iC4svTgdle9ad8ft+LG0FZjLEycOgFEtY68gUrHxKvwa7ZQo4ENZxYoyQbLORxbnqfS1ISXknPx8SbfJ1oh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525432; c=relaxed/simple;
	bh=+Zam4ZeLe3mH+g3y9a0rqGDAJNAWfflHp8RcrL2OrpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UoJ9tbW3SHwG5Ar/TSHmyuxdItKY7d1qUQSVVfCCu6YcJLpWwcOZwh9R1UIxDOX07y7r0a7ISbDySlOT5IxwP+WPpsDtzh6fUmltSna0cd94W70SDbnHDhTAkIqSDtS3IdCwe5+JwJcS6v6gKGyeKugABSaatOVp+KH83w+iHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQYdxGU9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d132f16dso26433255ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739525430; x=1740130230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DduguDwADVTSjMMK9ejwaGtXsiipFClLhmxdmWDmii0=;
        b=fQYdxGU9pWm3EofYDRIccPBc+AvA61Lbx+cZm15JMPBgIR06X28sC0/SYT5GAtMHhN
         71YMtKk6GBfGzFBrd8wyHJOukYx2Q2xCE83h7TPEeM0LRMnod3Uk54bFWuNBYw6vJg2u
         TH/jeyAoAzzCBp90m8TqVGMMcjQpbrCwFtdvE2/VvpwOdcLrNfPUe1EG7V4LRytMUsB8
         QBNxby4O+kzs6wam0ifZ+Bsr7xGcGGhZ/NeNlv4WRGispaSzqq6mgc+NumDeNSBu1rux
         qGLlU90UiAxO3di4CidlcjHppJJMfJw1Ayl+7v5w3gxCGhU03ooi9n6whqM6wGqV0zWg
         IV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739525430; x=1740130230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DduguDwADVTSjMMK9ejwaGtXsiipFClLhmxdmWDmii0=;
        b=Sr5ezZ+KY8FJ2EPlqE2GJqkxPC8m5ix+mc+Rm1QoGR/hzCsKQwc73zHkaG8++luCyh
         yRhv8acLEvj6HCAU+K6woZ4chZQDi56PkAAfgNOjWPBVT+FLE+1BwD7WvibfKOrKiF8h
         pOaxdRZNxfzpuF9/fdRDTfrJBxlJYEnj/3s+PiwZTqX/gep2pq9UccVeZ/Ei5CW5vG3e
         DxTqIGhrknAmRgiKKKN7N0tQLiNCsagiEaWHRgEwumI3DBhaffW3sCq1Jzs87NxUDDgJ
         tuN3zXADryG02wVYeWFaXjZCwWZfxs2vMWOuZZNjq4ogtqNw1H8eElz5UMshyn8SN8ve
         kj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz83HEH6hYahQnW3JScz5fcgYQsdisuZB24t4B9EaXH/WrgqXN+NIyhFEBRYqjIeyAxKQBvTCvwJ/QkXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzksinXdXPSBIvHGNwjuH7zD0zJP9wU2cvUjKIOZAdU3434KQ7b
	4OFHStSCoeK2ff+B5izhjhhLAuagVGEMwUM9JcYGNZqnzzfN+TFE
X-Gm-Gg: ASbGncvh0u7jvO1zV4BXmQMkbfkrDW3JUyt4Cvj1aC0ZuN60U7avmsCKpG4ROSwoP5D
	l7EQjFqXW+i4a1J3mXsxoku2UcLNrwORZgqvQgkupi7j9rnRKyBjIQikQVur5NJUAgvjNe9NmsE
	ljGybynwvHMc0S3fnPQioR3GxgVFbTcmkp3s0eqk8wS3h0bark/r+hDYahCIShOsxf28xCDZUeB
	PLjjcQOQV5zQ6GyndCu6zmrNxQPgU+OZ8R+ySVvp0uMkm2YeTzq7veHuTuXgTPRtQmN46e/8GwP
	z4PJfqimQVA30A5Fh08qUexbzHHrbEA=
X-Google-Smtp-Source: AGHT+IFysR9EXVj8qAfuBiPky9qxf+cg8EqLe8Kd8ETuM6oFy6cIZ+w4UdkVArLA8+ej6cCexdZqiA==
X-Received: by 2002:a17:902:ce8b:b0:216:4883:fb43 with SMTP id d9443c01a7336-220bbc8f747mr173264085ad.32.1739525430357;
        Fri, 14 Feb 2025 01:30:30 -0800 (PST)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm25440515ad.148.2025.02.14.01.30.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 01:30:29 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	ioworker0@gmail.com,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	lorenzo.stoakes@oracle.com,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	x86@kernel.org,
	ying.huang@intel.com,
	zhengtangquan@oppo.com
Subject: [PATCH v4 0/4] mm: batched unmap lazyfree large folios during reclamation
Date: Fri, 14 Feb 2025 22:30:11 +1300
Message-Id: <20250214093015.51024-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Commit 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during
shrink_folio_list()") prevents the splitting of MADV_FREE'd THP in
madvise.c. 
However, those folios are still added to the deferred_split list in 
try_to_unmap_one() because we are unmapping PTEs and removing rmap
entries one by one.

Firstly, this has rendered the following counter somewhat confusing, 
/sys/kernel/mm/transparent_hugepage/hugepages-size/stats/split_deferred
The split_deferred counter was originally designed to track operations 
such as partial unmap or madvise of large folios. However, in practice, 
most split_deferred cases arise from memory reclamation of aligned 
lazyfree mTHPs as observed by Tangquan. This discrepancy has made
the split_deferred counter highly misleading.

Secondly, this approach is slow because it requires iterating through 
each PTE and removing the rmap one by one for a large folio. In fact, 
all PTEs of a pte-mapped large folio should be unmapped at once, and
the entire folio should be removed from the rmap as a whole.

Thirdly, it also increases the risk of a race condition where lazyfree
folios are incorrectly set back to swapbacked, as a speculative folio_get
may occur in the shrinker's callback.
deferred_split_scan() might call folio_try_get(folio) since we have
added the folio to split_deferred list while removing rmap for the
1st subpage, and while we are scanning the 2nd to nr_pages PTEs of
this folio in try_to_unmap_one(), the entire mTHP could be
transitioned back to swap-backed because the reference count is
incremented, which can make "ref_count == 1 + map_count" within
try_to_unmap_one() false.

   /*
    * The only page refs must be one from isolation
    * plus the rmap(s) (dropped by discard:).
    */
   if (ref_count == 1 + map_count &&
       (!folio_test_dirty(folio) ||
        ...
        (vma->vm_flags & VM_DROPPABLE))) {
           dec_mm_counter(mm, MM_ANONPAGES);
           goto discard;
   }

This patchset resolves the issue by marking only genuinely dirty folios 
as swap-backed, as suggested by David, and transitioning to batched 
unmapping of entire folios in try_to_unmap_one(). Consequently, the 
deferred_split count drops to zero, and memory reclamation performance 
improves significantly — reclaiming 64KiB lazyfree large folios is now 
2.5x faster(The specific data is embedded in the changelog of patch
3/4).

By the way, while the patchset is primarily aimed at PTE-mapped large 
folios, Baolin and Lance also found that try_to_unmap_one() handles 
lazyfree redirtied PMD-mapped large folios inefficiently — it splits 
the PMD into PTEs and iterates over them. This patchset removes the 
unnecessary splitting, enabling us to skip redirtied PMD-mapped large 
folios 3.5X faster during memory reclamation. (The specific data can 
be found in the changelog of patch 4/4).

-v4:
 * collect reviewed-by of Kefeng, Baolin, Lance, thanks!
 * rebase on top of David's "mm: fixes for device-exclusive entries
(hmm)" patchset v2:
 https://lore.kernel.org/all/20250210193801.781278-1-david@redhat.com/

-v3:
https://lore.kernel.org/all/20250115033808.40641-1-21cnbao@gmail.com/ 

 * collect reviewed-by and acked-by of Baolin, David, Lance and Will.
   thanks!
 * refine pmd-mapped THP lazyfree code per Baolin and Lance.
 * refine tlbbatch deferred flushing range support code per David.

-v2:
 https://lore.kernel.org/linux-mm/20250113033901.68951-1-21cnbao@gmail.com/

 * describle backgrounds, problems more clearly in cover-letter per
   Lorenzo Stoakes;
 * also handle redirtied pmd-mapped large folios per Baolin and Lance;
 * handle some corner cases such as HWPOSION, pte_unused;
 * riscv and x86 build issues.

-v1:
 https://lore.kernel.org/linux-mm/20250106031711.82855-1-21cnbao@gmail.com/

Barry Song (4):
  mm: Set folio swapbacked iff folios are dirty in try_to_unmap_one
  mm: Support tlbbatch flush for a range of PTEs
  mm: Support batched unmap for lazyfree large folios during reclamation
  mm: Avoid splitting pmd for lazyfree pmd-mapped THP in try_to_unmap

 arch/arm64/include/asm/tlbflush.h |  23 +++--
 arch/arm64/mm/contpte.c           |   2 +-
 arch/riscv/include/asm/tlbflush.h |   3 +-
 arch/riscv/mm/tlbflush.c          |   3 +-
 arch/x86/include/asm/tlbflush.h   |   3 +-
 mm/huge_memory.c                  |  24 ++++--
 mm/rmap.c                         | 136 ++++++++++++++++++------------
 7 files changed, 115 insertions(+), 79 deletions(-)

-- 
2.39.3 (Apple Git-146)


