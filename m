Return-Path: <linux-kernel+bounces-224849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E233912798
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CC028D17F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516D1D54B;
	Fri, 21 Jun 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5ll0BPx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F9EAE1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979913; cv=none; b=p7W+TpWox42tCHvjkm3DL74u9TZ+LQb8IWyqxIxxZO4cTSDSpIlYDy99DiTPx/CrpIJSQ8y5PhfRXROjQa7RdiokOwzClQb+I2UyBEAbjhJVpyZAui3qU+6gb+jCqXWNHXEwo111wptNe3zPWCZSP6dkfocF+JUkXAxXYSyP9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979913; c=relaxed/simple;
	bh=X3maeu+nPp7U376b9OYziQeHSc3wrOOoTTYbyUlfQwE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=thYGUSC+1P1WHOeCLkl7xn+Kqh9NiTVeumQxoji64wUnAyDhopmgZjFdNPizGojULKtAwUnJXWKjoSlxc7MIfrTnQuFvAK1yPsa15Eq1IFlPjYlGsv/1Ly+usShDAw0d7sE/TkPntVajWDDCSLUfOLvLp+QqHdRZU9D2u0jL/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5ll0BPx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718979910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rJ2F2lReou/79KtGbEHPf7ReN+ePAiVmvXImVODPK+8=;
	b=c5ll0BPxgVLjR9GHH6sZ9+n0ao89KjVvVLDDX5RfQKk0AmuqfM0cIjCzQJrKBcGivqsXWv
	Lj/qWLsMKRa7mcus/0L6Yp2WF2gdAyXTn1F1fyJFO89Gy7NVrBnrpULA8359xscFZpLZDD
	GJiY0OlDWedLossLfy2OFuXSvecKb7U=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-NKoCztZLOxqx8ExoFbOleA-1; Fri, 21 Jun 2024 10:25:08 -0400
X-MC-Unique: NKoCztZLOxqx8ExoFbOleA-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6faa28bab62so471202a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979908; x=1719584708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJ2F2lReou/79KtGbEHPf7ReN+ePAiVmvXImVODPK+8=;
        b=sJieCTSbE8D1YROB6mtmjgtzL7AICU6Mm3sVpYBfCrS9JdaZ6HLfsskZLJkYaEiNPo
         hjciLMz+UTL4Xkmq+Avkb8+N1pOUCMp/dwlWDEuX9vKffWYxKgRNDhYPGY/G/9AR/80e
         9AtgMd12Aa8XtLdxvMq0wcNlfaWG1qxvMeJBHXicaaViqtSM4e0Q7pITmdLibIjIIUep
         BYHZC+Q7dJa9aDLzNJjAsKEFnepMzYS9NVAOwbW8HUtKFEiBrmtGYlei9vQ+gSrn+duC
         HKkujf8MuX4AUmdpRjyuy/jZcdVZtCtybzCfh++fDxS/nyHAAAXMtEla6ZtR7DOqI5WJ
         PcWQ==
X-Gm-Message-State: AOJu0YxpGRBUYdxK2PonxzscY2gTjMOG9bOfkuKDj30JkD6jqrTW0BRq
	A3YmXoM6XmySr+7LqMef/dqeGzI/T7y4Xm0/QhmCMSDkDS9Vg7jTQxlUEDQw023lKDTEIJR+WsW
	/2TIM+9uMW4prczpud5Cyi8eDMy0CSi2D+op1t5Ivfl2eGxexBcFY0IyGN3sMgEJO2Q/Q42qVSs
	gWOLM/M5ZO9q/2mDvCCmqeNrU5n4Cq2/n0Mbv/RAu3d7o=
X-Received: by 2002:a05:6359:4c82:b0:1a1:cc04:1dfe with SMTP id e5c5f4694b2df-1a1fd54fea5mr982811955d.2.1718979907614;
        Fri, 21 Jun 2024 07:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1Xxdp9urwT8bix6NuH4K7DRA81f/XgNHW39wGHKyZSk8ch5WqsO3pnf6YuhyEDxai+96HrA==
X-Received: by 2002:a05:6359:4c82:b0:1a1:cc04:1dfe with SMTP id e5c5f4694b2df-1a1fd54fea5mr982805755d.2.1718979906763;
        Fri, 21 Jun 2024 07:25:06 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce944cb2sm90564785a.125.2024.06.21.07.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:25:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Jiang <dave.jiang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Ingo Molnar <mingo@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH 0/7] mm/mprotect: Fix dax puds
Date: Fri, 21 Jun 2024 10:24:57 -0400
Message-ID: <20240621142504.1940209-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Based on mm-unstable, commit a53138cdbe3e]

Dax supports pud pages for a while, but mprotect on puds was missing since
the start.  This series tries to fix that by providing pud handling in
mprotect(), while my real goal is adding more types of pud mappings like
hugetlb or pfnmaps, it's just that we probably want pud to work already and
build the rest on top.

Considering nobody reported this until when I looked at those other types
of pud mappings, I am thinking maybe it doesn't need to be a fix for stable
and this may not need to be backported.  I would guess whoever cares about
mprotect() won't care 1G dax puds yet, vice versa.  I hope fixing that in
new kernels would be fine, but I'm open to suggestions.

There're quite a few small things changed here and there to teach mprotect
work on PUDs. E.g. it will start with dropping NUMA_HUGE_PTE_UPDATES which
may stop making much sense when there can be more than one type of huge pte
(meanwhile it doesn't sound right at all to account non-numa operations
too.. more in the commit message of the relevant patch).  OTOH, we'll also
need to push the mmu notifiers from pmd to pud layers, which might need
some attention but so far I think it's safe.  For these small details,
please refer to each patch's commit message.

The mprotect() pud process is hopefully straightforward enough, as I kept
it as simple as possible.  There's no NUMA handled as dax simply doesn't
support that. There's also no userfault involvements as file memory (even
if work with userfault-wp async mode) will need to split a pud, so pud
entry doesn't need to yet know userfault's existance (but hugetlb entries
will; that's also for later).

Tests
=====

What I did test:

- cross-build tests that I normally cover [1], except an known issue
  elsewhere on hugetlb [2]

- smoke tested on x86_64 the simplest program [3] on dev_dax 1G PUD
  mprotect() using QEMU's nvdimm emulations [4] and ndctl to create
  namespaces with proper alignments, which used to throw "bad pud" but now
  it'll run through all fine.  Also I checked sigbus happens if with
  illegal access on protected puds.

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
[2] https://lore.kernel.org/all/202406190956.9j1UCIe5-lkp@intel.com
[2] https://github.com/xzpeter/clibs/blob/master/misc/dax.c
[3] https://github.com/qemu/qemu/blob/master/docs/nvdimm.txt

Peter Xu (7):
  mm/dax: Dump start address in fault handler
  mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES
  mm/mprotect: Push mmu notifier to PUDs
  mm/powerpc: Add missing pud helpers
  mm/x86: Make pud_leaf() only cares about PSE bit
  mm/x86: Add missing pud helpers
  mm/mprotect: fix dax pud handlings

 arch/powerpc/include/asm/book3s/64/pgtable.h |  3 +
 arch/powerpc/mm/book3s64/pgtable.c           | 20 ++++++
 arch/x86/include/asm/pgtable.h               | 39 ++++++++++-
 arch/x86/mm/pgtable.c                        | 11 +++
 drivers/dax/device.c                         |  6 +-
 include/linux/huge_mm.h                      | 24 +++++++
 include/linux/vm_event_item.h                |  1 -
 mm/huge_memory.c                             | 52 ++++++++++++++
 mm/mprotect.c                                | 74 ++++++++++++--------
 mm/vmstat.c                                  |  1 -
 10 files changed, 195 insertions(+), 36 deletions(-)

-- 
2.45.0


