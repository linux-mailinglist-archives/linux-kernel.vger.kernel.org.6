Return-Path: <linux-kernel+bounces-283560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024F94F660
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD54B21C91
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14953189B8A;
	Mon, 12 Aug 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5vzaFtH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EB1898EE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486355; cv=none; b=ir+nHdLob7+wZKbgWuHvSMRfehP2e9bIt//xaF6osky8ALdBNMD5GLc92p9F1ZVELi94mnF8HimeuHaeSrd7231CADufjIJQS1LqKmmeH2mwl2YejQG7rEZTfV5I5yO3rG5/kSn3uHgb7vdEuEDlp21wSNy0ggJfXYZdUkoq5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486355; c=relaxed/simple;
	bh=XaEJTxyMs4Nld+dm+nInYnnT4NuSduPbiXMSkai23Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BWaScsGhgG3b6ZOc/rs1zC9M5G7KuVV5HhXsN5oq87+EO3zh4pQEEnTVtCNkF/MlJfgRqY2/dGtyrxxtjoYCEWIiw4dgRVdYvbgmV6bECaVAUXcNXYL+RmotgCaWnwH1Oer0NhkZVbQAC9mCv4pIlfWkhNaLvdpknILPq0pgmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5vzaFtH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723486351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eIfqRhqTBdQt7ItDuA3SYVNl6iQYa6JLleOS9G2I7/o=;
	b=V5vzaFtHDtOyY8b8g3VImwXNN5aWIBI1X2PMlsAuSvQZ1Ak/F2L7xIf8YQ5N/sZfatiZN8
	vJoedmSNVMuH9mdLkLEfzrlbPWuaAxNCi1X8IM5NRoQiLF6nqE5OfRguVa/+dY5ngtlPXX
	1sJNVZWk5f2Icdwus1HG5tK/9K0D2Yc=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-8lbBvETiPBuH0tY1rpREVA-1; Mon, 12 Aug 2024 14:12:30 -0400
X-MC-Unique: 8lbBvETiPBuH0tY1rpREVA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-26490f7a42fso927391fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486349; x=1724091149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIfqRhqTBdQt7ItDuA3SYVNl6iQYa6JLleOS9G2I7/o=;
        b=gRXUemHV7fHBGq5IFlAX/1AmeMbbrMIEOEEcmOOhq0du8jpHkbVLB2kiGgcjTxHduY
         4VtDxiuoirXyhMkKeRcvqhbLAwKSuKXtutOHVud+U0INAxwhjqcjrki7IvxfEZDdrEOQ
         LJkKvPlJaXhmNEAlJoWip3A4L2fNnTV5YE46eXO/PkOJodqExyGx/tcdX7k/eQU5n0MP
         zVfyt2v1lDg5sWqPClAbvRAVsCHAms40TvwW5sruBku+aEEWw17N+jYvU0N6oLVFq5O/
         +lYVEyKN4VfQpPLSqaO6IKeV3jxW8z6/rQH6ph/rxjPFQdXNkKLOmkmtNDGESOpPHqQx
         jeXg==
X-Gm-Message-State: AOJu0YxP7VySKIuj9bL26lPsGLToZTYB4yZuFydyOBhFNkapy1WstYDX
	iY9ad4mUrWbKKzNyD1FJ08ryVw6AR6jpnGYdchwbyLlJYUZHsxYNVwUdzS/h+kTseChAB5/BxoT
	LUXVtWyv/SJAdFk43TibUna4Bwa6nXxGhWzlzNAI/J+F6uQSWEEdZbqGpv8X3l8uuGET1KSZ1WG
	2NeKeSEPKaOz9I+S3R+x0QNbCUZWgreKVYHNhPVre9Zn0=
X-Received: by 2002:a05:6870:ac0c:b0:261:b94:b0b with SMTP id 586e51a60fabf-26fcb61d7fcmr692532fac.1.1723486349065;
        Mon, 12 Aug 2024 11:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6jLTxsSCZJ07oO3D4SmefhCdcQBPUO4jFHyKiLUZDd1WYyR5M288o5ohbA4O9kA1TSpyMOQ==
X-Received: by 2002:a05:6870:ac0c:b0:261:b94:b0b with SMTP id 586e51a60fabf-26fcb61d7fcmr692493fac.1.1723486348633;
        Mon, 12 Aug 2024 11:12:28 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dee013sm268663985a.84.2024.08.12.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:12:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Kirill A . Shutemov" <kirill@shutemov.name>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Huang Ying <ying.huang@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	peterx@redhat.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 0/7] mm/mprotect: Fix dax puds
Date: Mon, 12 Aug 2024 14:12:18 -0400
Message-ID: <20240812181225.1360970-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Based on mm-unstable, commit 98808d08fc0f, Aug 7th. NOTE: it is
 intentional to not have rebased to latest mm-unstable, as this is to
 replace the queued v4]

v5 Changelog:
- Rename patch subject "mm/x86: arch_check_zapped_pud()", add "Implement" [tglx]
- Mostly rewrote commit messages for the x86 patches, follow -tip rules [tglx]
- Line wrap fixes (to mostly avoid newlines when unnecessary) [tglx]
- English fixes [tglx]
- Fix a build issue only happens with i386 pae + clang
  https://lore.kernel.org/r/202408111850.Y7rbVXOo-lkp@intel.com

v1: https://lore.kernel.org/r/20240621142504.1940209-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20240703212918.2417843-1-peterx@redhat.com
v3: https://lore.kernel.org/r/20240715192142.3241557-1-peterx@redhat.com
v4: https://lore.kernel.org/r/20240807194812.819412-1-peterx@redhat.com

Dax supports pud pages for a while, but mprotect on puds was missing since
the start.  This series tries to fix that by providing pud handling in
mprotect().  The goal is to add more types of pud mappings like hugetlb or
pfnmaps.  This series paves way for it by fixing known pud entries.

Considering nobody reported this until when I looked at those other types
of pud mappings, I am thinking maybe it doesn't need to be a fix for stable
and this may not need to be backported.  I would guess whoever cares about
mprotect() won't care 1G dax puds yet, vice versa.  I hope fixing that in
new kernels would be fine, but I'm open to suggestions.

There're a few small things changed to teach mprotect work on PUDs. E.g. it
will need to start with dropping NUMA_HUGE_PTE_UPDATES which may stop
making sense when there can be more than one type of huge pte.  OTOH, we'll
also need to push the mmu notifiers from pmd to pud layers, which might
need some attention but so far I think it's safe.  For such details, please
refer to each patch's commit message.

The mprotect() pud process should be straightforward, as I kept it as
simple as possible.  There's no NUMA handled as dax simply doesn't support
that.  There's also no userfault involvements as file memory (even if work
with userfault-wp async mode) will need to split a pud, so pud entry
doesn't need to yet know userfault's existance (but hugetlb entries will;
that's also for later).

Tests
=====

What I did test:

- cross-build tests that I normally cover [1]

- smoke tested on x86_64 the simplest program [2] on dev_dax 1G PUD
  mprotect() using QEMU's nvdimm emulations [3] and ndctl to create
  namespaces with proper alignments, which used to throw "bad pud" but now
  it'll run through all fine.  I checked sigbus happens if with illegal
  access on protected puds.

- vmtests.

What I didn't test:

- fsdax: I wanted to also give it a shot, but only until then I noticed it
  doesn't seem to be supported (according to dax_iomap_fault(), which will
  always fallback on PUD_ORDER).  I did remember it was supported before, I
  could miss something important there.. please shoot if so.

- userfault wp-async: I also wanted to test userfault-wp async be able to
  split huge puds (here it's simply a clear_pud.. though), but it won't
  work for devdax anyway due to not allowed to do smaller than 1G faults in
  this case. So skip too.

- Power, as no hardware on hand.

Thanks,

[1] https://gitlab.com/peterx/lkb-harness/-/blob/main/config.json
[2] https://github.com/xzpeter/clibs/blob/master/misc/dax.c
[3] https://github.com/qemu/qemu/blob/master/docs/nvdimm.txt

Peter Xu (7):
  mm/dax: Dump start address in fault handler
  mm/mprotect: Push mmu notifier to PUDs
  mm/powerpc: Add missing pud helpers
  mm/x86: Make pud_leaf() only care about PSE bit
  mm/x86: Implement arch_check_zapped_pud()
  mm/x86: Add missing pud helpers
  mm/mprotect: fix dax pud handlings

 arch/powerpc/include/asm/book3s/64/pgtable.h |  3 +
 arch/powerpc/mm/book3s64/pgtable.c           | 20 ++++++
 arch/x86/include/asm/pgtable.h               | 70 ++++++++++++++++---
 arch/x86/mm/pgtable.c                        | 18 +++++
 drivers/dax/device.c                         |  6 +-
 include/linux/huge_mm.h                      | 24 +++++++
 include/linux/pgtable.h                      |  6 ++
 mm/huge_memory.c                             | 56 ++++++++++++++-
 mm/mprotect.c                                | 71 +++++++++++++-------
 9 files changed, 236 insertions(+), 38 deletions(-)

-- 
2.45.0


