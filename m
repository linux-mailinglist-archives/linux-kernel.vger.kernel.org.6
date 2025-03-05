Return-Path: <linux-kernel+bounces-547450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C569A50954
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29897A8A81
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0305D250BF3;
	Wed,  5 Mar 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjLhEANA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA51C5D4E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198580; cv=none; b=uA/Geo3MoBdWHzCJ4ZQIr/JXT3dDeJsh0L3tpVWOm34ciHVWPs1ba/Iuvqsv8kr5TSU1yssg11ASlm0FxJW/9BjRuF6gDWey4FJA0iwZPgstC0zh5IoY/L2gdHagpbJdZLEI7YuBmY0mOTf8Vm07Me7Uhwt9Ky5n5ZdmHNydf3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198580; c=relaxed/simple;
	bh=9jZeBQED4k4g3lvnJyO4nAm8/6hyfhCy7lonl9CyTYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N++CeTytaQy6LKif+G3Kz86pP3RlitC1sncmW0K7MHxinIysFuwNqjLXPtxFr+EyUN9kGW5Nq2NaR4ZxNBx3CC7K2TKdFSmq4KI6xY6T+3X0WXPwBczFClBUpArODQpDxG83VSY3wCGIP/KOHZIcetb6obsVGAPOpWIfsIErjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjLhEANA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67ADC4CEE0;
	Wed,  5 Mar 2025 18:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198580;
	bh=9jZeBQED4k4g3lvnJyO4nAm8/6hyfhCy7lonl9CyTYY=;
	h=From:To:Cc:Subject:Date:From;
	b=GjLhEANAPAILyRQcR3UoRYbkBrEi+EOjyvySAY8K332CkHZHbfH2gMGxBWwRmKAHv
	 t3adrktc1IqXw45XRTGmzdxxZbmj7KOBZ0g+lXtE5nWDbdcoDmVCQSOiR1hBiPcqDE
	 Sdaw7f/XHA0fy91eVwdqalTPs/fyF4BTGGnkE4wgLPMzpDMugJquqqbWCN5B+wGbiR
	 4ULLireuAFbjF1Dl5K2eqJQgsJ8ldWj4JqBrpGRK9lNJ5a6BMpUwhzoo/TfeHOolJZ
	 x1oAsR+elcdv6Rnvdlb8V+mMMl4hv/FFqsXBxy8fw6vv4HUbXooCFZCs2ykgAMrEbb
	 ClnPwcacLPmkA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for MADV_DONTNEED and MADV_FREE
Date: Wed,  5 Mar 2025 10:15:55 -0800
Message-Id: <20250305181611.54484-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
can happen for each vma of the given address ranges.  Because such tlb
flushes are for address ranges of same process, doing those in a batch
is more efficient while still being safe.  Modify madvise() and
process_madvise() entry level code path to do such batched tlb flushes,
while the internal unmap logics do only gathering of the tlb entries to
flush.

In more detail, modify the entry functions to initialize an mmu_gather
ojbect and pass it to the internal logics.  Also modify the internal
logics to do only gathering of the tlb entries to flush into the
received mmu_gather object.  After all internal function calls are done,
the entry functions finish the mmu_gather object to flush the gathered
tlb entries in the one batch.

Patches Seuquence
=================

First four patches are minor cleanups of madvise.c for readability.

Following four patches (patches 5-8) define new data structure for
managing information that required for batched tlb flushing (mmu_gather
and behavior), and update code paths for MADV_DONTNEED[_LOCKED] and
MADV_FREE handling internal logics to receive it.

Three patches (patches 9-11) for making internal MADV_DONTNEED[_LOCKED]
and MADV_FREE handling logic ready for batched tlb flushing follow.  The
patches keep the support of unbatched tlb flushes use case, for
fine-grained and safe transitions.

Next three patches (patches 12-14) update madvise() and
process_madvise() code to do the batched tlb flushes utilizing the
previous patches introduced changes.

Final two patches (patches 15-16) clean up the internal logics'
unbatched tlb flushes use case support code, which is no more be used.

Test Results
============

I measured the time to apply MADV_DONTNEED advice to 256 MiB memory
using multiple process_madvise() calls.  I apply the advice in 4 KiB
sized regions granularity, but with varying batch size (vlen) from 1 to
1024.  The source code for the measurement is available at GitHub[1].

The measurement results are as below.  'sz_batches' column shows the
batch size of process_madvise() calls.  'before' and 'after' columns are
the measured time to apply MADV_DONTNEED to the 256 MiB memory buffer in
nanoseconds, on kernels that built without and with the MADV_DONTNEED
tlb flushes batching patch of this series, respectively.  For the
baseline, mm-unstable tree of 2025-03-04[2] has been used.
'after/before' column is the ratio of 'after' to 'before'.  So
'afetr/before' value lower than 1.0 means this patch increased
efficiency over the baseline.  And lower value means better efficiency.

    sz_batches    before       after        after/before
    1             102842895    106507398    1.03563204828102
    2             73364942     74529223     1.01586971880929
    4             58823633     51608504     0.877343022998937
    8             47532390     44820223     0.942940655834895
    16            43591587     36727177     0.842529018271347
    32            44207282     33946975     0.767904595446515
    64            41832437     26738286     0.639175910310939
    128           40278193     23262940     0.577556694263817
    256           41568533     22355103     0.537789077136785
    512           41626638     22822516     0.54826709762148
    1024          44440870     22676017     0.510251419470411

For <=2 batch size, tlb flushes batching shows no big difference but
slight overhead.  I think that's in an error range of this simple
micro-benchmark, and therefore can be ignored.  Starting from batch size
4, however, tlb flushes batching shows clear efficiency gain.  The
efficiency gain tends to be proportional to the batch size, as expected.
The efficiency gain ranges from about 13 percent with batch size 4, and
up to 49 percent with batch size 1,024.

Please note that this is a very simple microbenchmark, so real
efficiency gain on real workload could be very different.

References
==========

[1] https://github.com/sjp38/eval_proc_madvise
[2] commit 7b6c5895bb9a ("mm: hugetlb: log time needed to allocate hugepages") # mm-unstable

SeongJae Park (16):
  mm/madvise: use is_memory_failure() from madvise_do_behavior()
  mm/madvise: split out populate behavior check logic
  mm/madvise: deduplicate madvise_do_behavior() skip case handlings
  mm/madvise: remove len parameter of madvise_do_behavior()
  mm/madvise: define and use madvise_behavior struct for
    madvise_do_behavior()
  mm/madvise: pass madvise_behavior struct to madvise_vma_behavior()
  mm/madvise: make madvise_walk_vmas() visit function receives a void
    pointer
  mm/madvise: pass madvise_behavior struct to madvise_dontneed_free()
  mm/memory: split non-tlb flushing part from zap_page_range_single()
  mm/madvise: let madvise_dontneed_single_vma() caller batches tlb
    flushes
  mm/madvise: let madvise_free_single_vma() caller batches tlb flushes
  mm/madvise: batch tlb flushes for
    process_madvise(MADV_DONTNEED[_LOCKED])
  mm/madvise: batch tlb flushes for process_madvise(MADV_FREE)
  mm/madvise: batch tlb flushes for
    madvise(MADV_{DONTNEED[_LOCKED],FREE}
  mm/madvise: remove !tlb support from madvise_dontneed_single_vma()
  mm/madvise: remove !caller_tlb case of madvise_free_single_vma()

 mm/internal.h |   3 +
 mm/madvise.c  | 176 ++++++++++++++++++++++++++++++++++----------------
 mm/memory.c   |  36 +++++++----
 3 files changed, 144 insertions(+), 71 deletions(-)


base-commit: f653b037b4a6d83c68098fc3949090dfb63316fb
-- 
2.39.5

