Return-Path: <linux-kernel+bounces-376851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0386F9AB6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5932AB22874
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5277C1CB32D;
	Tue, 22 Oct 2024 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuFzyEW1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E47145A1C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625386; cv=none; b=qDxs05P9jAIa8e22j/ogBWsWfqGwXt6xeJKynZhI++h+qJPk7CFFO7o7fXvpjv9RN5YGTFs2rbR620ZIAS7pW5zWIM/k8/5RdAJmZ6l7e6cPx2DmRocVwrZSaX1CFXsRxgYAxPOJiPAA7cfxHPaPCMiofcz8okwJduXdp2i7QVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625386; c=relaxed/simple;
	bh=Oz0G8QXqhRg/2ouF/eMBap6KkjS1GFg0MlDVyc+tRt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fv2CBBDKh2pbrL4x/TNswSoY43iQ/TpSnUaFVZfoj0BZ3Z55iiTzGM89+tlzAPOfgTmSq+o2/RDqDw9DKmezeWjpWfzN5f1aE3MRJo9vocQ4i50mu/Pe0xj5/NKIdX/bcTYbIPSXFZR9IPhkDc8ltgJJWBdPKFmMH+5Ip+PwLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuFzyEW1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c77459558so51427665ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625384; x=1730230184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGbf0fixLETlFv0KEXjfC5spoDaHmyAsiiYQtt7GTUQ=;
        b=YuFzyEW1t71K4q3+P6sx2F2qHPvQvdEDu/23YfWWl/CPjU40EHJJ9Yy55FCIhygMDQ
         B6K+crZyEaDFB5q4C8S3kNEZ6Jglm1FL/DeTDlN2w/LEDecW/BoywJD6Ar7YPmmI4+4t
         aZacrd3GU8Ma1VuZUf2eG8RaTXG8bM1l1SWK4ejXG/OEKlOWocJD8LkQ+lnC1QNqUNUr
         qEXNIxdi5cVztqAagd3DZYOMabEKFf/X9cl3J33TarOnAICAMdGveMxOmfafuvn+sL4T
         zHutwWksJD4KcMqf2I/xNyg44T5F6Ef4AHfbfSz27ggdHn1BZzhGHlkhp6Um+d0zXyII
         Ay2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625384; x=1730230184;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGbf0fixLETlFv0KEXjfC5spoDaHmyAsiiYQtt7GTUQ=;
        b=SA6EYsSCuXLGsrrzlZ3fJUaF48OFwpyN394+5OO1xSRoNVhmQycBl2P4RmEqqmnhQA
         yO8+Eu60AVztOEMbS0zopj5DlTDdO6nv4vNndXwjQWd4y0oqC/+8jaOYxwGIFLsObtVi
         y3cnGJFHWKTVnvCieSZRMegjAfF2uYmelXVmBL6p/aaAWdeWyg1REzzdF3YrwoVjpu6/
         UnHkMLH4237/tl0zvOsYDXx36luR/HVZ0L9qxdqxbQnbBDFHzgl+xzX2I1VKW4hd3H6S
         Sx3t9OSkkha4k87GVOocgctpOVCK2nN0INR5pnJIjzqvAtcb02os6DIacqJcUPmtE97l
         7bAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeBwdettiKtgj2ly0Zgy587yNIBYo/pSu3WTI6Ci5NeXt0BmnZM98cCo5tIvehHG7Opn/Cl0zkgMy03Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5U5jjTZFyG3k92g7TVqMXt/BcBHB3whrWA4emJNCxBMOlogfF
	ubf1S8kIhyUWKas5L8Twf7dNP0AZmXmzK+6VptNbd/A7xdWBi7xg
X-Google-Smtp-Source: AGHT+IH6LQ0/576MYGNZ72IUYK7iTjTm7UT2gNSleYWllSkzsKZKJANplqlxqEsn0rv7+9y7pDGxrw==
X-Received: by 2002:a17:902:ccc8:b0:20b:5b1a:209 with SMTP id d9443c01a7336-20fa9de0ca2mr3874055ad.9.1729625383805;
        Tue, 22 Oct 2024 12:29:43 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.29.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:29:43 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 00/13] mm, swap: rework of swap allocator locks
Date: Wed, 23 Oct 2024 03:24:38 +0800
Message-ID: <20241022192451.38138-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This series improved the swap allocator performance greatly by reworking
the locking design and simplify a lot of code path.

This is follow up of previous swap cluster allocator series:
https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org/

And this series is based on an follow up fix of the swap cluster
allocator:
https://lore.kernel.org/linux-mm/20241022175512.10398-1-ryncsn@gmail.com/

This is part of the new swap allocator work item discussed in
Chris's "Swap Abstraction" discussion at LSF/MM 2024, and
"mTHP and swap allocator" discussion at LPC 2024.

Previous series introduced a fully cluster based allocation algorithm,
this series completely get rid of the old allocation path and makes the
allocator avoid grabbing the si->lock unless needed. This bring huge
performance gain and get rid of slot cache on freeing path.

Currently, swap locking is mainly composed of two locks, cluster lock
(ci->lock) and device lock (si->lock). The device lock is widely used
to protect many things, causing it to be the main bottleneck for SWAP.

Cluster lock is much more fine-grained, so it will be best to use
ci->lock instead of si->lock as much as possible.

`perf lock` indicates this issue clearly. Doing linux kernel build
using tmpfs and ZRAM with limited memory (make -j64 with 1G memcg and 4k
pages), result of "perf lock contention -ab sleep 3":

  contended   total wait     max wait     avg wait         type   caller

     34948     53.63 s       7.11 ms      1.53 ms     spinlock   free_swap_and_cache_nr+0x350
     16569     40.05 s       6.45 ms      2.42 ms     spinlock   get_swap_pages+0x231
     11191     28.41 s       7.03 ms      2.54 ms     spinlock   swapcache_free_entries+0x59
      4147     22.78 s     122.66 ms      5.49 ms     spinlock   page_vma_mapped_walk+0x6f3
      4595      7.17 s       6.79 ms      1.56 ms     spinlock   swapcache_free_entries+0x59
    406027      2.74 s       2.59 ms      6.74 us     spinlock   list_lru_add+0x39
  ...snip...

The top 5 caller are all users of si->lock, total wait time up sums to
several minutes in the 3 seconds time window.

Following the new allocator design, many operation doesn't need to touch
si->lock at all. We only need to take si->lock when doing operations
across multiple clusters (eg. changing the cluster list), other
operations only need to take ci->lock. So ideally allocator should
always take ci->lock first, then, if needed, take si->lock. But due
to historical reasons, ci->lock is used inside si->lock by design,
causing lock inversion if we simply try to acquire si->lock after
acquiring ci->lock.

This series audited all si->lock usage, simplify legacy codes, eliminate
usage of si->lock as much as possible by introducing new designs based
on the new cluster allocator.

Old HDD allocation codes are removed, cluster allocator is adapted
with small changes for HDD usage, test is looking OK.

And this also removed slot cache for freeing path. The performance is
better without it, and this enables other clean up and optimizations
as discussed before:
https://lore.kernel.org/all/CAMgjq7ACohT_uerSz8E_994ZZCv709Zor+43hdmesW_59W1BWw@mail.gmail.com/

After this series, lock contention on si->lock is nearly unobservable
with `perf lock` with the same test above :

  contended   total wait     max wait     avg wait         type   caller
  ... snip ...
         91    204.62 us      4.51 us      2.25 us     spinlock   cluster_move+0x2e
  ... snip ...
         47    125.62 us      4.47 us      2.67 us     spinlock   cluster_move+0x2e
  ... snip ...
         23     63.15 us      3.95 us      2.74 us     spinlock   cluster_move+0x2e
  ... snip ...
         17     41.26 us      4.58 us      2.43 us     spinlock   cluster_isolate_lock+0x1d
  ... snip ...

cluster_move and cluster_isolate_lock are basically the only users
of si->lock now, performance gain is huge with reduced LOC.

Tests
===

Build kernel with defconfig on tmpfs with ZRAM as swap:
---

Running a test matrix which is scaled up progressive for a intuitive result.
The test are ran on top of tmpfs, using memory cgroup for memory limitation,
on a 48c96t system.

12 test run for each case, it can be seen clearly that as concurrent job
number goes higher the performance gain is higher, the performance is
higher even with low concurrency.

   make -j<NR>     |   System Time (seconds)  |   Total Time (seconds)
 (NR / Mem / ZRAM) | (Before / After / Delta) | (Before / After / Delta)
 With 4k pages only:
  6 / 192M / 3G    |    5258 /  5235 / -0.3%  |    1420 /  1414 / -0.3%
 12 / 256M / 4G    |    5518 /  5337 / -3.3%  |     758 /   742 / -2.1%
 24 / 384M / 5G    |    7091 /  5766 / -18.7% |     476 /   422 / -11.3%
 48 / 768M / 7G    |   11139 /  5831 / -47.7% |     330 /   221 / -33.0%
 96 / 1.5G / 10G   |   21303 / 11353 / -46.7% |     283 /   180 / -36.4%
 With 64k mTHP:
 24 / 512M / 5G    |    5104 /  4641 / -18.7% |     376 /   358 / -4.8%
 48 /   1G / 7G    |    8693 /  4662 / -18.7% |     257 /   176 / -31.5%
 96 /   2G / 10G   |   17056 / 10263 / -39.8% |     234 /   169 / -27.8%

With more aggressive setup, it shows clearly both the performance and
fragmentation are better:

tiem make -j96 / 768M memcg, 4K pages, 10G ZRAM, on Intel 8255C * 2:
(avg of 4 test run)
Before:
Sys time: 73578.30, Real time: 864.05
tiem make -j96 / 1G memcg, 4K pages, 10G ZRAM:
After: (-54.7% sys time, -49.3% real time)
Sys time: 33314.76, Real time: 437.67

time make -j96 / 1152M memcg, 64K mTHP, 10G ZRAM, on Intel 8255C * 2:
(avg of 4 test run)
Before:
Sys time: 74044.85, Real time: 846.51
hugepages-64kB/stats/swpout: 1735216
hugepages-64kB/stats/swpout_fallback: 430333
After: (-51.4% sys time, -47.7% real time, -63.2% mTHP failure)
Sys time: 35958.87, Real time: 442.69
hugepages-64kB/stats/swpout: 1866267
hugepages-64kB/stats/swpout_fallback: 158330

There is a up to 54.7% improvement for build kernel test, and lower
fragmentation rate. Performance improvement should be even larger for
micro benchmarks

Build kernel with tinyconfig on tmpfs with HDD as swap:
---

This test is similar to above, but HDD test is very noisy and slow, the
deviation is huge, so just use tinyconfig instead and take the median test
result of 3 test run, which looks OK:

Before this series:
114.44user 29.11system 39:42.90elapsed 6%CPU
2901232inputs+0outputs (238877major+4227640minor)pagefaults

After this commit:
113.90user 23.81system 38:11.77elapsed 6%CPU
2548728inputs+0outputs (235471major+4238110minor)pagefaults

Single thread SWAP:
---

Sequential SWAP should also be slightly faster as we removed a lot of
unnecessary parts. Test using micro benchmark for swapout/in 4G
zero memory using ZRAM, 10 test runs:

Swapout Before (avg. 3359304):
3353796 3358551 3371305 3356043 3367524 3355303 3355924 3354513 3360776

Swapin Before (avg. 1928698):
1920283 1927183 1934105 1921373 1926562 1938261 1927726 1928636 1934155

Swapout After (avg. 3347511, -0.4%):
3337863 3347948 3355235 3339081 3333134 3353006 3354917 3346055 3360359

Swapin After (avg. 1922290, -0.3%):
1919101 1925743 1916810 1917007 1923930 1935152 1917403 1923549 1921913

Worth noticing the patch "mm, swap: use a global swap cluster for
non-rotation device" introduced minor overhead for certain tests (see
the test results in commit message), but the gain from later commit
covered that, it can be further improved later.

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>

Kairui Song (13):
  mm, swap: minor clean up for swap entry allocation
  mm, swap: fold swap_info_get_cont in the only caller
  mm, swap: remove old allocation path for HDD
  mm, swap: use cluster lock for HDD
  mm, swap: clean up device availability check
  mm, swap: clean up plist removal and adding
  mm, swap: hold a reference of si during scan and clean up flags
  mm, swap: use an enum to define all cluster flags and wrap flags
    changes
  mm, swap: reduce contention on device lock
  mm, swap: simplify percpu cluster updating
  mm, swap: introduce a helper for retrieving cluster from offset
  mm, swap: use a global swap cluster for non-rotation device
  mm, swap_slots: remove slot cache for freeing path

 fs/btrfs/inode.c           |    1 -
 fs/iomap/swapfile.c        |    1 -
 include/linux/swap.h       |   36 +-
 include/linux/swap_slots.h |    3 -
 mm/page_io.c               |    1 -
 mm/swap_slots.c            |   78 +--
 mm/swapfile.c              | 1198 ++++++++++++++++--------------------
 7 files changed, 558 insertions(+), 760 deletions(-)

-- 
2.47.0


