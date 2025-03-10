Return-Path: <linux-kernel+bounces-554787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6FAA59DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770453A56CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0FB22ACDC;
	Mon, 10 Mar 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjFxjC3f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8041C5F1B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627404; cv=none; b=fQnuguaylSzcLGF/1OQGMB8Both6N5jZ+EBBMrJfloaO29t2gBRDIribehiLH75zV+JV0p+z2NsJ4NR7/JiewZACcX/hFI17GldoVr93Z+L4GrY6k/qzuqAm8vEDM8F9RgFxgpCh3dDzCPJrxS/AXC5nb0Iob8CeOKkf4qy9n6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627404; c=relaxed/simple;
	bh=sNptMTwkw7HCBqwk5Gcbi9fzS9E3Cm+Gtt9fXZGKwbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HDUYB1pyWz+XdfuyeXga+NcTDcx0jI3QrvFr9CEkltU233wzl8raxwfBq69EtYKOr+e0yu6dZCb2KDIFvuxPiO803KFtsdeq4qGWkFdF2ZttV81TTdwsVw9QG+qTWa15PCZILBIxAKw/aXImFJlIyNCbFoda6YkYdo+Gebu7EFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjFxjC3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBB1C4CEE5;
	Mon, 10 Mar 2025 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627404;
	bh=sNptMTwkw7HCBqwk5Gcbi9fzS9E3Cm+Gtt9fXZGKwbY=;
	h=From:To:Cc:Subject:Date:From;
	b=tjFxjC3fC0al4fi7mLlUsKCDGVx4LdeWvozhH+G/Lq1UdedzM+HZQcWUFAn5vSi7h
	 Cw0/VQ7KyKDCVa7Kyh+IVjErdHVhZol7N6ObjhjRzbSA+gLcLtKLQl9S4dLJ0fyO66
	 zjTgc99ZAVAWdJgN0lGH7+/YVej6DFgtij93OxGTDX73a1ymUgPAB8vywMS9W49889
	 BamRtRgyJHWJold55rMVcq8aFiPoakIpeAudwfT2BcFVRTx+v78HmZtBQhPZ9KabGi
	 e20/2oT8CR1cdAiYEmbB4pjNzW1Ty21MmxQ/xAeOK2U/+qZ+8kue/nYh2hf8JElqR9
	 G3MEyeLxmI3tQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/9] mm/madvise: batch tlb flushes for MADV_DONTNEED and MADV_FREE
Date: Mon, 10 Mar 2025 10:23:09 -0700
Message-Id: <20250310172318.653630-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When process_madvise() is called to do MADV_DONTNEED[_LOCKED] or
MADV_FREE with multiple address ranges, tlb flushes happen for each of
the given address ranges.  Because such tlb flushes are for same
process, doing those in a batch is more efficient while still being
safe.  Modify process_madvise() entry level code path to do such batched
tlb flushes, while the internal unmap logics do only gathering of the
tlb entries to flush.

In more detail, modify the entry functions to initialize an mmu_gather
ojbect and pass it to the internal logics.  And make the internal logics
do only gathering of the tlb entries to flush into the received
mmu_gather object.  After all internal function calls are done, the
entry functions flush the gathered tlb entries at once.

The inefficiency should be smaller on madvise() use case, since it
receives only a single address range.  But if there are multiple vmas
for the range, same problem can happen.  It is unclear if such use case
is common and the inefficiency is significant.  Make the change for
madivse(), too, since it doesn't really change madvise() internal
behavior while helps keeping the code that shared between
process_madvise() and madvise() internal logics clean.

Patches Seuquence
=================

First four patches are minor cleanups of madvise.c for readability.

Fifth patch defines new data structure for managing information
that required for batched tlb flushes (mmu_gather and behavior), and
update code paths for MADV_DONTNEED[_LOCKED] and MADV_FREE handling
internal logics to receive it.

Sixth and seventh patches make internal logics for handling
MADV_DONTNEED[_LOCKED] MADV_FREE be ready for batched tlb flushing.  The
patches keep the support of unbatched tlb flushes use case, for
fine-grained and safe transitions.

Eighth patch updates madvise() and process_madvise() code to do the
batched tlb flushes utilizing the previous patches introduced changes.

The final ninth patch removes the internal logics' unbatched tlb flushes
use case support code, which is no more be used.

Test Results
============

I measured the latency to apply MADV_DONTNEED advice to 256 MiB memory
using multiple process_madvise() calls.  I apply the advice in 4 KiB
sized regions granularity, but with varying batch size per
process_madvise() call (vlen) from 1 to 1024.  The source code for the
measurement is available at GitHub[1].  To reduce measurement errors, I
did the measurement five times.

The measurement results are as below.  'sz_batch' column shows the batch
size of process_madvise() calls.  'Before' and 'After' columns show the
average of latencies in nanoseconds that measured five times on kernels
that built without and with the tlb flushes batching patch of this
series, respectively.  For the baseline, mm-unstable tree of
2025-03-07[2] has been used.  'B-stdev' and 'A-stdev' columns show
ratios of latency measurements standard deviation to average in percent
for 'Before' and 'After', respectively.  'Latency_reduction' shows the
reduction of the latency that the commit has achieved, in percent.
Higher 'Latency_reduction' values mean more efficiency improvements.

    sz_batch   Before        B-stdev   After         A-stdev   Latency_reduction
    1          128691595.4   6.09      106878698.4   2.76      16.95
    2          94046750.8    3.30      68691907      2.79      26.96
    4          80538496.8    5.35      50230673.8    5.30      37.63
    8          72672225.2    5.50      43918112      3.54      39.57
    16         66955104.4    4.25      36549941.2    1.62      45.41
    32         65814679      5.89      33060291      3.30      49.77
    64         65099205.2    2.69      26003756.4    1.56      60.06
    128        62591307.2    4.02      24008180.4    1.61      61.64
    256        64124368.6    2.93      23868856      2.20      62.78
    512        62325618      5.72      23311330.6    1.74      62.60
    1024       64802138.4    5.05      23651695.2    3.40      63.50

Interestingly, the latency has reduced (improved) even with batch size
1.  I think some of compiler optimizations have affected that, like also
observed with the previous process_madvise() mmap_lock optimization
patch sereis[3].

So, let's focus on the proportion between the improvement and the batch
size.  As expected, tlb flushes batching provides latency reduction that
proportional to the batch size.  The efficiency gain ranges from about
27 percent with batch size 2, and up to 63 percent with batch size
1,024.

Please note that this is a very simple microbenchmark, so real
efficiency gain on real workload could be very different.

Changes from RFC
(https://lore.kernel.org/20250305181611.54484-1-sj@kernel.org)
- Clarify motivation of the change on the cover letter
- Add average and stdev of evaluation results
- Show latency reduction on evaluation results
- Fix !CONFIG_MEMORY_FAILURE build error
- Rename is_memory_populate() to is_madvise_populate()
- Squash patches 5-8
- Add kerneldoc for unmap_vm_area_struct()
- Squash patches 10 and 11
- Squash patches 12-14
- Squash patches 15 and 16

References
==========

[1] https://github.com/sjp38/eval_proc_madvise
[2] commit e664d7d28a7c ("selftest: test system mappings are sealed") # mm-unstable
[3] https://lore.kernel.org/20250211182833.4193-1-sj@kernel.org

SeongJae Park (9):
  mm/madvise: use is_memory_failure() from madvise_do_behavior()
  mm/madvise: split out populate behavior check logic
  mm/madvise: deduplicate madvise_do_behavior() skip case handlings
  mm/madvise: remove len parameter of madvise_do_behavior()
  mm/madvise: define and use madvise_behavior struct for
    madvise_do_behavior()
  mm/memory: split non-tlb flushing part from zap_page_range_single()
  mm/madvise: let madvise_{dontneed,free}_single_vma() caller batches
    tlb flushes
  mm/madvise: batch tlb flushes for
    [process_]madvise(MADV_{DONTNEED[_LOCKED],FREE})
  mm/madvise: remove !tlb support from
    madvise_{dontneed,free}_single_vma()

 mm/internal.h |   3 +
 mm/madvise.c  | 221 +++++++++++++++++++++++++++++++++-----------------
 mm/memory.c   |  38 ++++++---
 3 files changed, 176 insertions(+), 86 deletions(-)


base-commit: e993f5f5b0ac851cf60578cfee5488031dfaa80c
-- 
2.39.5

