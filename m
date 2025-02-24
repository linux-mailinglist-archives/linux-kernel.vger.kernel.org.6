Return-Path: <linux-kernel+bounces-529752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DFDA42A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0C61739E0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23251264A90;
	Mon, 24 Feb 2025 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0bVO1N6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288E264A84
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420172; cv=none; b=RfitjD6LdP4aJodlESSsWdYDaExYPOx7VLKGKWhcvyugFywqmjNUaLIVcnbtVghbrlwIQtKJoCPNmrZmUhiHruVbhIi03P1f5gLesSKP8TlGL9/l69xBpCa3wAXctoFnQB0Ms7DJQf9M9uJ+4dzbHjq5PQSBvj7ERAjswoeD+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420172; c=relaxed/simple;
	bh=itsBLLxlrAwDwIQWDjziEP7HxbzQvPfoj0bBM7KwUcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r62aGzuMzRtTfLG8ckl9PuVMZIiUhaJwPSOAqaRzZJW1wEdBd7mi3ByAoC3ran7NB1bcANXmi3Qdy9vSr9JX8RclEQhgR/aRz7WpYq7bgVqW5gdZfNq4aD1wtQwHw4kl7aJOCg5xw2AHMNORCc6bCtIk4BWBgOf49MjCh3ddTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0bVO1N6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220e989edb6so129140095ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740420170; x=1741024970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFplMvPNGKU5wF32T8NlzWSeNewPtKyBr0rvnILieu4=;
        b=l0bVO1N6Y16GA9RoinwRBdcFV/G9f263hqFlDx7x/dA4ktgltzGg+05FOr+xQtc6+c
         unQ5J3C86k6AAw9kiNokzW22KMNGbBOr0mGbfhW71MBIMXhKF1fyXZ5Xk6gWxu+uh9WP
         XHpQQKh1toCUDCgHNXWW83HuX8yIFPTUCrQsWXJVnx6AGywGHPm0PghOl7G/JOKuFt6C
         9lFLGBZ4NPp804ggKIhZZnp/3wJcKe3CMCTRpZ97vS/673ieiLr1JGq0HF/y1VatE316
         ntvnThP4rcQQJkv8qQZHYjdki1wHNhFxVhJcbw0XelA3C16n5qpnyYVqMbymWHRjlu6x
         kxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740420170; x=1741024970;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFplMvPNGKU5wF32T8NlzWSeNewPtKyBr0rvnILieu4=;
        b=NA7RaQOF/Y27ezdwOl2MjF+BXyZThBx2/szgTKTYhN84jqec4Gv7zs4T9UiCEXLlSA
         /1wbK8d6gBTom8nRNcQBk8cXu+l9SVzVTAl1FOA7935DoNZZmRD/14+aaVeUJf+ctYBP
         57kpVS0j9hj3MkFP56M5fbmMVLGxKaAJOMDqxwI8Tez9dn8itAvhG8N2qTZ+NVHndY5I
         SHV8idy2wwru+0U6iu2/+M+wJOigKPWkGQBeNzbfShFeqWteFvRTRI3q9UlPmczUA4xS
         15Iqw9VYM9duAoWSGSY3sIR/xPrOl1rTv6rqG/KNegGkOV91QTK0bfX4R5LRgR88Cvp/
         h/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVv3hpOXJjfR9HA7Eicvwe7+jP4Ig2kT2rk1Y3qdE59Rr+BAeGBA+tVEqsoNJulW6cTzFBLjp0sHOfVu7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGEKfSVlXsp8HbNwAfzH7TAyTRsxqMDsDR6WdbgqftH20tHW7Z
	jyOQo+eMiQl8tz7ZmXltf4QVnLr3/ntBMxwB/FvRBCZKRL83zCPT
X-Gm-Gg: ASbGncvR5LRsSoRYczUb1VaX9iTqCvsCZMhyzgZr9Ui2uLWHqf0mCuVzstMc7keSzAI
	muiyQKswu5+FKhhLwv7SHIUgVl4nhk6SjMZo8MmjCVQpoh9+FGcEQl/7Q/wfVM2RVj0uJMagZdI
	ZJs1ZSTH3C6AAT6c2z+ePjhNsWIOV3WejdCoRbyCry68KQxIMG4/umVhQF0mfQ7V822vbVKegzV
	VSiakgieLa0xJFI31oR9I/y3fBazTaPBajxi0NBDC4yk+I389wij81L6yf82UIGe/uYBpSl7cL3
	z7UlO2/Y08INplCvxasas78UdwxJyiP/I+fbBAl27tU9
X-Google-Smtp-Source: AGHT+IFjacj+DFQCh6G+bTApcerKaqlV3cTYZ+wt3sRTgERS9Hhv3HCDGIZqHizo19yPjQEhUpUnUw==
X-Received: by 2002:a17:902:ced1:b0:21f:85ee:f2df with SMTP id d9443c01a7336-22307b496fcmr2055065ad.15.1740420169958;
        Mon, 24 Feb 2025 10:02:49 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([1.203.117.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556e15esm184834695ad.190.2025.02.24.10.02.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Feb 2025 10:02:49 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 0/7] mm, swap: remove swap slot cache
Date: Tue, 25 Feb 2025 02:02:05 +0800
Message-ID: <20250224180212.22802-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Slot cache was initially introduced by commit 67afa38e012e ("mm/swap:
add cache for swap slots allocation") to reduce the lock contention
of si->lock.

Previous series "mm, swap: rework of swap allocator locks" [1] removed
swap slot cache for freeing path as freeing path no longer touches
si->lock in most cased. Allocation path also have slight to none
contention on si->lock since that series, but slot cache still helps
to reduce other overheads, like counters and the plist.

This series removes the slot cache from allocation path too, by using
the cluster as allocation fast path and also reduce other overheads.

Now slot cache is completely gone, the code is much simplified without
obvious feature or performance change, also clean up related workaround.
Also this should avoid other potential issues, e.g. the long pinning
of swap slots: swap slot cache pins swap slots with HAS_CACHE, causing
reclaim or allocation fail to use these slots on scanning.

The only behavior change is the swap device allocation rotation
mechanism, as explained in the patch "mm, swap: use percpu cluster
as allocation fast path".

Test results are looking good after deleting the swap slot cache:

- vm-scalability with: `usemem --init-time -O -y -x -R -31 1G`,
12G memory cgroup using simulated pmem as SWAP (32G pmem, 32 CPUs),
16 test runs for each case, measuring the total throughput:

                      Before (KB/s) (stdev)  After (KB/s) (stdev)
Random (4K):          424907.60 (24410.78)   414745.92  (34554.78)
Random (64K):         163308.82 (11635.72)   167314.50  (18434.99)
Sequential (4K, !-R): 6150056.79 (103205.90) 6321469.06 (115878.16)

- Build linux kernel with make -j96, using 4K folio with 1.5G memory
cgroup limit and 64K folio with 2G memory cgroup limit, on top of tmpfs,
12 test runs, measuring the system time:

                  Before (s) (stdev)  After (s) (stdev)
make -j96 (4K):   6445.69 (61.95)     6408.80 (69.46)
make -j96 (64K):  6841.71 (409.04)    6437.99 (435.55)

The performance is unchanged, slightly better in some cases.

[1] https://lore.kernel.org/linux-mm/20250113175732.48099-1-ryncsn@gmail.com/

---

V1: https://lore.kernel.org/linux-mm/20250214175709.76029-1-ryncsn@gmail.com/
Updates from V1:
- Check the cluster with cluster_is_usable and cluster_is_empty in
  fast path too, improve performance and avoid fragmentation.
- Fix a build warning and error for !SWAP build reported by test bot.
- Global cluster array also record device for each order [Baoquan He]
- Adjust of comments and function name [Baoquan He]
- Collect Review-by [Baoquan He]
- Minor function style improvement [Matthew Wilcox]
- Retest didn't show performance beyond noise so just keep using
  the old performance test result.

Signed-off-by: Kairui Song <kasong@tencent.com>


Kairui Song (7):
  mm, swap: avoid reclaiming irrelevant swap cache
  mm, swap: drop the flag TTRS_DIRECT
  mm, swap: avoid redundant swap device pinning
  mm, swap: don't update the counter up-front
  mm, swap: use percpu cluster as allocation fast path
  mm, swap: remove swap slot cache
  mm, swap: simplify folio swap allocation

 include/linux/swap.h       |  21 +--
 include/linux/swap_slots.h |  28 ----
 mm/Makefile                |   2 +-
 mm/shmem.c                 |  21 +--
 mm/swap.h                  |   6 -
 mm/swap_slots.c            | 295 --------------------------------
 mm/swap_state.c            |  79 +--------
 mm/swapfile.c              | 333 +++++++++++++++++++------------------
 mm/vmscan.c                |  16 +-
 mm/zswap.c                 |   6 +
 10 files changed, 210 insertions(+), 597 deletions(-)
 delete mode 100644 include/linux/swap_slots.h
 delete mode 100644 mm/swap_slots.c

-- 
2.48.1


