Return-Path: <linux-kernel+bounces-252976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD6E931AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FF32841BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB5127E0D;
	Mon, 15 Jul 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPKNGBK/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339636A33A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071311; cv=none; b=fXT4jCTBf4PYtbcPstxHOl0jD7JbROxvwH0d15qMAehU4RaBsPkKr9tpNoJ3jvgHN4dhIo6I3DVg+EVHXi9yzaerru4j27qOrpMwUjIy3tp0+CfnqjkkVK6zC3GPOwZiRWNSuXJNsZ/VjzIq4Xd5qnUR+cXMUdCXNrYZaM1Ig8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071311; c=relaxed/simple;
	bh=7htQciZZmrc97uiuvXFe4uJx+yU6LglrVPysXAXnVI0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cMqM+ky9mjt4AgFl19l9heO3tagRRLZ816yGJM/r766A2PneFSSuW60EZfdEyEIRtHQrbhmAaqBYTOLYO9SYvYxYl3NSFJif4CUtZYWgR3QNoh40qqLcd/UkdxZ0D+YFvfDIYiZA+SaY1UyMY3PokFPEvLnJQD7LAajAZB0QJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPKNGBK/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fcwbFvUlydJ89LCIJbZYnbeNwq+Aa7yYvNbAx9RPsSI=;
	b=YPKNGBK/r2lUQD2Dm4bYOahcgNehBdbNr8G/IyWi9FEWdJhRrE4PoKawXKWDYiy2LK080Z
	My808CXEfhGrqrodB1SlOvRFIhm7U92fOcaWb4HdLrFXuqDJQkEjIDU+2Xp1wGUOJA5beh
	JQ0ftWTLxEcfzoNm98tpO0z1eESExp8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-6LTaJjkXPFqw-TwG5cyrPA-1; Mon, 15 Jul 2024 15:21:48 -0400
X-MC-Unique: 6LTaJjkXPFqw-TwG5cyrPA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b7740643fbso2326556d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071306; x=1721676106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcwbFvUlydJ89LCIJbZYnbeNwq+Aa7yYvNbAx9RPsSI=;
        b=harWYBNYuvx85ISPLOUmiX9EZeC21aOiDURnOxR0EqbSwfwekwA3NmnMYnLJZOXgfS
         RuZB5U6pEn1qkt1gyhN2js9ELEM2RaJXICCpez50fsHIZg6GZB3Vgk9Y9LUF8LSmwQcc
         h4bYA10DFynSDk0Mif5Rg2sc7LdDupaggCJZXorgBPbYrDUKkY20niEb1RgpZu0V/tPi
         SJTIdfEYC42DHJkJL6+rkYdr6zAFR80Pnrxfzfhm8AfzEJ6vI/liEGys0DwTG0kZNIk2
         zwF96fGaVnrZgnEdILmISVzxx710aQCZy2YjhIfPgZP5n1KczYjAToBe6ZlqhQVMHLyh
         5rAw==
X-Forwarded-Encrypted: i=1; AJvYcCVQZUWVmZA3pEFzrzwCu8aKy4+XQGrekqgy0LeTH1WoLHkNPXHp+lVzhXMo/D53m3bXQhp3U2Y7HCRFZoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKtbfGN6LE4cDULxjeFWauoGLtYaGF6p94K+if+UP3/c412Ap
	SIrfj6H4iQfPVchD2PJxf6fNyn2e2kgH8e0pChrtU0J6DNKku8+qYLorD3/UQx2Wn0ANW8VrOqz
	XewS75n/iHHnaw2X8Ye+nTPTNSkhgYu/ymzo+O8gnWe8tZOWjR4jFE8fQP53W/w==
X-Received: by 2002:a05:6214:3d87:b0:6b2:b5b5:124e with SMTP id 6a1803df08f44-6b77dd634e7mr5106726d6.0.1721071306259;
        Mon, 15 Jul 2024 12:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu7hXxUrNpLJfANABTNicknn5i9R99x8eQnIUTwDJYLFg/NIIa0kT9/i+hFib8ttrRFUJmhA==
X-Received: by 2002:a05:6214:3d87:b0:6b2:b5b5:124e with SMTP id 6a1803df08f44-6b77dd634e7mr5106546d6.0.1721071305812;
        Mon, 15 Jul 2024 12:21:45 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761978d30sm24039356d6.31.2024.07.15.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:21:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>,
	x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 0/8] mm/mprotect: Fix dax puds
Date: Mon, 15 Jul 2024 15:21:34 -0400
Message-ID: <20240715192142.3241557-1-peterx@redhat.com>
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

v3:
- Fix a build issue on i386 PAE config
- Moved one line from patch 8 to patch 3

v1: https://lore.kernel.org/r/20240621142504.1940209-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20240703212918.2417843-1-peterx@redhat.com

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
 arch/x86/mm/pgtable.c                        | 19 +++++
 drivers/dax/device.c                         |  6 +-
 include/linux/huge_mm.h                      | 24 +++++++
 include/linux/pgtable.h                      |  7 ++
 include/linux/vm_event_item.h                |  1 -
 mm/huge_memory.c                             | 56 ++++++++++++++-
 mm/mprotect.c                                | 74 ++++++++++++--------
 mm/vmstat.c                                  |  1 -
 11 files changed, 234 insertions(+), 45 deletions(-)

-- 
2.45.0


