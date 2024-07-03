Return-Path: <linux-kernel+bounces-240203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6DF926A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DB41F22CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E206191F97;
	Wed,  3 Jul 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGfamF6d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB50191F83
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042168; cv=none; b=LPVrDk7cCUGX1jM6cwffN6+uR84j3S5/zISU31BygFwcms36H46BSxRnFwR+4DGmymiP2HL/1UpzAwY2ceD7Ceo/M20I6mq0AZpb18LdhwdKuPZKCOon1YMiPVuVeg3RqYzEULcPgzfVTJ+pW/h5XOeQukpwCZySwqp9UDHwORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042168; c=relaxed/simple;
	bh=k9cYfSlX1eysxnScf8B+a2GY0V103T8Wi3ZGJ9gn9HE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jNWVpOJBPw2TkYJDb/Pd+rsdl9HsI/MkQ4faXpDPpAADWlW9jrYzDRw1tzmUx3abVJgz6TMRWtAcMLkL5M3U9DlfMdw1GQT0tgjIBWoBAyZ07kJLSNpeVHFjfP55PCZaClAjUt8MY7VvHHRoHeXdLTxT0RE4VsUn9w/of+ghMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGfamF6d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720042164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O2GbkT3IfNneZLzmTfXKMGxGoFvHWp+ovSbzv55/oNo=;
	b=KGfamF6dFkUrkj1hvsK6jKvMlVzTszRSGWYoFltwquF6hkfW8i6qCIKPN8BzTnmdXou6TI
	on1Ijvb1GUD6n4QIwQ3GE/xv/ZhuVNGE0U0WWfCMcJOknL0o1/PuN7gS0GZ0FU1c5Kp6Ko
	DF4uwGkDXwrRxPPAxt6NERhTsZlU2QQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-XeyYqCKgMpG58BT-67pkpg-1; Wed, 03 Jul 2024 17:29:23 -0400
X-MC-Unique: XeyYqCKgMpG58BT-67pkpg-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-48f42df4597so502102137.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042162; x=1720646962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2GbkT3IfNneZLzmTfXKMGxGoFvHWp+ovSbzv55/oNo=;
        b=e2nc2vW9KemRsoF40zzN2Mma7VTD/Tm+3Hgq1TeuCt1wrG5BMLG5UraqJ/GKz9+0Pr
         xQ14jxs/FLB/xG13PhGjYAXFTX6SLjwRnyCrR7SJq16gZjWCjmlz17BFBDDn7A1VKpDc
         f14EbciE0qbjmKn6meZLSGkQcdJH5vwmai34AJwjzZBw2IlEPj7c3oHSjDHGiwd6q8Lb
         /mwIixE36ABoASJjKeqMCReloztCJ14fsB9zzBLy16qKHMljqP7/TLa4yT03Dz2zSVu2
         +RtThR9LeLVTkBPyeT+Ldat7EaUuy1jLjfuxFigpK3kn/Dz6STgKRBdbzOu4hoPGUn/X
         Z+jA==
X-Gm-Message-State: AOJu0YzTZ2y8rS3wVQ2AbyapevPktg01B2T57pSNZsb6NhT0n/OAXMDA
	AJfa8CBdmfmzls1T2cq6bMrwe2KIJ3kYn/tMXb7QA7oExmKLpJvnn+IUl/ymlOLPyJaKL6giIWN
	Fiu5BVyF3+72QoWeWZk798MsexcLW+qRifuWcnHwTYchvOwaqam6bKY8ik57F9+9V56ACY/ge+M
	5ncvYh4FJbEbdgSEzMdjae7Q4oWZDmBLgsm17J93H1PaI=
X-Received: by 2002:a05:6122:221d:b0:4ec:ef42:a7a2 with SMTP id 71dfb90a1353d-4f2a56b62b8mr11877048e0c.1.1720042161927;
        Wed, 03 Jul 2024 14:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVxFROGUHiFRpsdTx4NqsAs9vB+SYw6qbXBu8UHMAgFYonw5PPnwd/CcFF1S+TO8MfCwLRIA==
X-Received: by 2002:a05:6122:221d:b0:4ec:ef42:a7a2 with SMTP id 71dfb90a1353d-4f2a56b62b8mr11876994e0c.1.1720042161205;
        Wed, 03 Jul 2024 14:29:21 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143eb1csm54337481cf.57.2024.07.03.14.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:29:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Dave Jiang <dave.jiang@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Dan Williams <dan.j.williams@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	peterx@redhat.com,
	Hugh Dickins <hughd@google.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 0/8] mm/mprotect: Fix dax puds
Date: Wed,  3 Jul 2024 17:29:10 -0400
Message-ID: <20240703212918.2417843-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Based on mm-unstable, commit 31334cf98dbd, July 2nd]

v2:
- Added tags
- Fix wrong pmd helper used in powerpc
- Added patch "mm/x86: arch_check_zapped_pud()" [Rick]
- Do proper dirty bit shifts for shadow stack on puds [Dave]
- Add missing page_table_check hooks in pudp_establish() [Dave]

v1: https://lore.kernel.org/r/20240621142504.1940209-1-peterx@redhat.com

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

Peter Xu (8):
  mm/dax: Dump start address in fault handler
  mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES
  mm/mprotect: Push mmu notifier to PUDs
  mm/powerpc: Add missing pud helpers
  mm/x86: Make pud_leaf() only cares about PSE bit
  mm/x86: arch_check_zapped_pud()
  mm/x86: Add missing pud helpers
  mm/mprotect: fix dax pud handlings

 arch/powerpc/include/asm/book3s/64/pgtable.h |  3 +
 arch/powerpc/mm/book3s64/pgtable.c           | 20 ++++++
 arch/x86/include/asm/pgtable.h               | 68 +++++++++++++++---
 arch/x86/mm/pgtable.c                        | 18 +++++
 drivers/dax/device.c                         |  6 +-
 include/linux/huge_mm.h                      | 24 +++++++
 include/linux/pgtable.h                      |  7 ++
 include/linux/vm_event_item.h                |  1 -
 mm/huge_memory.c                             | 56 ++++++++++++++-
 mm/mprotect.c                                | 74 ++++++++++++--------
 mm/vmstat.c                                  |  1 -
 11 files changed, 233 insertions(+), 45 deletions(-)

-- 
2.45.0


