Return-Path: <linux-kernel+bounces-278465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5A694B09A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D6283D85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD72144D1E;
	Wed,  7 Aug 2024 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfkRH1M4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46123C08A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060100; cv=none; b=UrB0mVwa77Y9u+ohKfD/VQPBbQ6W2jMXu/LWxBQEDJE2ryZWz/DQZAE0Nc/yCuMlBUwAub5/TKE+VcOxQ0UMrprBA6WkZMaxHJK/vagIihdBRChgik3ghggdeb/DA7dhtDcy5RsGeN3QgfDS99RjyeasBD5wR+AMh9D1IsYApco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060100; c=relaxed/simple;
	bh=3XxrDAWZh6Lz/MwtSyn2wVYp015l27Ir9BIbTEgm0JI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Kogis35afcHRaaROSLpww3qUj0+lNsV9OxBAb84VTRNVMYrVgVlHTRHZ6LyQ3VNlOcHrthrro+2by4a94Z3VVWGYoUqh6QtQoFf0mv0c+66Dsa7gBzKaSK5JoxQI/4NzM4XoNEuUHekVfN8Yr3zkdx9ltPCkt1VnzGtM5UMDcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MfkRH1M4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723060097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o3OFHAXa4GjeJOqHDNlzpJASvE7zIeu8ivvI2pMYR/w=;
	b=MfkRH1M4/ZyqPW8sLwQzm7rw2L4hujJrNZxH5r+b/wSyOlu0MrJF2FIdV4M1yXGa2WutNm
	PTgjqHTiAMY8hj5Q5WZlaVWDI9dtJAXJr9NkiBg9rLRdxKNzP0TDYWr9zO6HBHDEPLU5QZ
	kj+tKcANl/9laiy7/Fp+LoNc1Lc8IsE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-xxnO6nqNOreezlgnulSM5Q-1; Wed, 07 Aug 2024 15:48:16 -0400
X-MC-Unique: xxnO6nqNOreezlgnulSM5Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ba92dd246fso407476d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060095; x=1723664895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3OFHAXa4GjeJOqHDNlzpJASvE7zIeu8ivvI2pMYR/w=;
        b=ruUiWCJ0FVLcpgt0pfdyYzBO522V4DdFc/tJn9owR2wUbHqW+pYYu4xe8l33ReRZIK
         Yv8+toLemZJGD7mHZvIymnQV/zviONBeStxFOy67seuNXBWIB3WmC+6QSPGWS23MSOlt
         nH2EItCz6rae0wW6VOyyyHMKOGz1xG4MAONLh43SqyhayyigPN2B4C3XLE+o//aLHj5U
         OfyElNrT0K14wCsm8nL4XNkDhvA302QT+GepuVbtQQAvEbh83AP0BMaI2ecDcOpcxhkO
         2QqfeFnAkH/KGqOwoDeHPWadcukUWTWUYqOgi3dwaadxsEg+UI+yVBrMWJ0l5E2IE5TP
         CfSg==
X-Gm-Message-State: AOJu0Yxo/gmquuHLzBzM2unICRRemCr6NS70rkfRMMgSLpZvgwcJ4b10
	u66+S+LD9Fizu9A31ci3W1HmNrCVy2JcmhbeMXFmmug7s0l+jeGXm+8Xnln0K23q7OvXdw9NEbP
	7ny2QlzKNDqkwkwuWm6ceMZ+ZHwn8elZvXk/masdVCcyD14w7144QJEQLFp+eCUQhLkDQUBjlU5
	2tv1lQkFsdmim4S4XtD5I2sQPX0t3W+okQNhM96F/8oyU=
X-Received: by 2002:ad4:5ba4:0:b0:6b7:9295:3cce with SMTP id 6a1803df08f44-6bb984ae596mr143755296d6.8.1723060095155;
        Wed, 07 Aug 2024 12:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCjDJrPHIrMzNYMf7G/SdTGJGIyVor+2t/BXveAxufE9NNL2pow6YcQrqmHncd+BDg/Ri9nA==
X-Received: by 2002:ad4:5ba4:0:b0:6b7:9295:3cce with SMTP id 6a1803df08f44-6bb984ae596mr143754916d6.8.1723060094671;
        Wed, 07 Aug 2024 12:48:14 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ae4asm59853256d6.33.2024.08.07.12.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:48:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oscar Salvador <osalvador@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	James Houghton <jthoughton@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	peterx@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Hugh Dickins <hughd@google.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH v4 0/7] mm/mprotect: Fix dax puds
Date: Wed,  7 Aug 2024 15:48:04 -0400
Message-ID: <20240807194812.819412-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Based on mm-unstable, commit 98808d08fc0f, Aug 7th]

v4:
- Added tags
- Dropped patch "mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES" [DavidH]
- Touched up comment in pgtable_split_needed() [James]

v1: https://lore.kernel.org/r/20240621142504.1940209-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20240703212918.2417843-1-peterx@redhat.com
v3: https://lore.kernel.org/r/20240715192142.3241557-1-peterx@redhat.com

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
  mm/x86: arch_check_zapped_pud()
  mm/x86: Add missing pud helpers
  mm/mprotect: fix dax pud handlings

 arch/powerpc/include/asm/book3s/64/pgtable.h |  3 +
 arch/powerpc/mm/book3s64/pgtable.c           | 20 ++++++
 arch/x86/include/asm/pgtable.h               | 68 ++++++++++++++++---
 arch/x86/mm/pgtable.c                        | 19 ++++++
 drivers/dax/device.c                         |  6 +-
 include/linux/huge_mm.h                      | 24 +++++++
 include/linux/pgtable.h                      |  7 ++
 mm/huge_memory.c                             | 56 ++++++++++++++-
 mm/mprotect.c                                | 71 +++++++++++++-------
 9 files changed, 236 insertions(+), 38 deletions(-)

-- 
2.45.0


