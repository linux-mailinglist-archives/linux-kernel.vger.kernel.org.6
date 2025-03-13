Return-Path: <linux-kernel+bounces-560035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2CCA5FCE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D53E19C1D21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB9526A1B1;
	Thu, 13 Mar 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB0nle1/"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86026A0C8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885275; cv=none; b=NiJpn0nMJTSHCXn2FAJmCj7JtfCJKh43wqho8AZGgz7OvrdMv5ScKfkrk8gxL5f+pvTKEnR+n5JYwnEs76IA3hG5i0QisZ4hrQWUexweJGbkz9PPx6r3QJEC8vhrbaIjGr0h2PrhptVSu6Rh/eRPauYvFZlQRzxYsg2luuoM1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885275; c=relaxed/simple;
	bh=n+zPe90N77goi5Vs/AU7yVAt8EEYh4S4/W38xTvwma0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssy7l6r3WG8FxOJXc27gd5w09SPVQ5CbWBgObG5RiU6usizlj4LTnM3LpN3/dJ2uv30gq0ZVBNEBcAdx6eR2ejCH7UoF+WGaCkvl3mrcj/ebdeOX0Omen4EmeHQk4f/CRgtU5fCxWK/9A7rFLzZz6OeIFFBXZ7cIvK415uE5nhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB0nle1/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2243803b776so35888165ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741885273; x=1742490073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5P82pdBAFVbDSRi5XIPEAoEtfgv9YXlZdJ7xlxw7MDg=;
        b=gB0nle1/GZzH+s72iFhSwdJ6IAk13+/+yvckFG6CGjs7e1dsIWRfA5c2ail0RYk9zm
         0q5C1bkOunMxHv9rP2jY9e3RlHJhTlz2mFXlys4iFYke/yaa/UdvTXLuiyXkfcKUOcKo
         C7FkLpZ7C8zNpJOqPeFVsj+LvC9YcnG5n1EzkVcBRHaPMAK15oF9qcxQiWnHOGxW2xEZ
         oFHuVYqVMvQRY04PQWEqZtY8Hdi/4sb+56RU/gr3Cxrrn9tk3Qr0tCNF4doQizxcWil5
         nY80tyHEY8cWf3bzxE5k+aocyQHMTou9IXhCI/5QfQeumdGrz3jD7/82VMa5j76KHLdG
         a/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885273; x=1742490073;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5P82pdBAFVbDSRi5XIPEAoEtfgv9YXlZdJ7xlxw7MDg=;
        b=CklDXPa7saLwX0nE0wL5y9hM0l41ltT8XTQWTmRHxHNZR12OeAU6MEsvOJfzHLy18H
         Qn/DJgei8ZkqvyEjiXWjjWPTnWqzrKg/8tSh4MB1wIKkRP2zewoCUfMUbKSVkuOMj28Q
         HZHs+soQfNYErdQmLjLoU7HXT1cJYVhbB8MOaOmipg4oaHf8NAYHJI3pG5aHC3Izdi6q
         d0xSrJ1e7tmqoe0lnoIbqWvbbHvMWyHnpt3FDcXdfKfJYGBa9ka1YCDksxRIcFV6Pgc+
         b5yY3hGa2GpUG862IrYme9CM78pHFHIgAbwybiO7UdQis3KvuDAxsu+b9yCbMLUVfVfW
         TMgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnaeuShotBKt+NGsnG222c2kWFqDGnjdbON+lQw411753JKV6S4vQVuZVgO211rPaGdt/k74M3pF8qCLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycdKcexdq6KcGyYJ1VL3Iy0nIX9HeFlmiqxFjZsw8nSO8PABuc
	EPRMtJqYULa5hIOVuB1mxsSRN7JWj0ZLUetSh7Ao/WNyyXerTrSm
X-Gm-Gg: ASbGnctuBaBFPCVtB+bFBFKZGp14u8J26Tym4SFskrqu/hPCL28OuKJWrV2bjsCyrVW
	VjwKTgVuLHUlpGFJYhoLvYocCx2e3tgEXdQPaTbizR4KQgbZfg1M76CcJJaLZRGZsVZU930M7+w
	cHqMgEUMcGl7wZb0WCS2AwIg1H28eQBD5FFggA0iAFjY4v1Jj4t+yCBwUp4gqegvBZR/pdYoMa5
	coC8GCwWs/Bc5vTfG2f4y8B/NVDWB8pALiYuWWimRgMzXg63/KOn0BL9StGsK9S3GBtPUnSGw3v
	Z/neZ6PGJXN4dlN9H8/C6kkGCOdtxVPTnU0bQjikwo9DOPkRm4aEEXFCNHk9s/Z5Z5po2kXIAW2
	K
X-Google-Smtp-Source: AGHT+IFtZYssUMBc4VlC36k5H0KjOuFJKyZR5Lu6B6Wylds+EzqaCHgNjSLG+/KFod08Js6ZDt8GXA==
X-Received: by 2002:a05:6a00:3c8d:b0:736:52d7:daca with SMTP id d2e1a72fcca58-7371f172930mr352757b3a.18.1741885272638;
        Thu, 13 Mar 2025 10:01:12 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167df0esm1613529b3a.93.2025.03.13.10.01.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Mar 2025 10:01:12 -0700 (PDT)
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
Subject: [PATCH v3 0/7] mm, swap: remove swap slot cache
Date: Fri, 14 Mar 2025 00:59:28 +0800
Message-ID: <20250313165935.63303-1-ryncsn@gmail.com>
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

V2: https://lore.kernel.org/linux-mm/20250224180212.22802-1-ryncsn@gmail.com/
Updates from V2:
- Make folio_alloc_swap() inline to fix build error [Stephen Rothwell]
- Flush the global percpu cluster cache on swapoff to prevent new swapon
  devices using the old invalid values. Based on:
  https://lore.kernel.org/linux-mm/CAMgjq7AkRmb5ote-VZErM_2UdEC575j9WcrstcQOypEb+T-DLA@mail.gmail.com/
- Minor update for patch 5/7: in slow path also try the local cluster
  first to avoid fragmentation. It's a intermediate patch change for easier
  testing if someone run into a bisect, the final code after the whole
  series applies is not changed.
- Need to call mem_cgroup_try_charge_swap even if swap allocation failed
  for cgroup events.
- Collect reviews and minor improvements [Baoquan He].

V1: https://lore.kernel.org/linux-mm/20250214175709.76029-1-ryncsn@gmail.com/
Updates from V1:
- Check the cluster with cluster_is_usable and cluster_is_empty in
  fast path too, improve performance and avoid fragmentation.
- Fix a build warning and error for !SWAP build reported by test bot.
- Global cluster array also record device for each order [Baoquan He]
- Adjust of comments and function name [Baoquan He]
- Collect Review-by [Baoquan He]
- Minor function style improvement [Matthew Wilcox]

Kairui Song (7):
  mm, swap: avoid reclaiming irrelevant swap cache
  mm, swap: drop the flag TTRS_DIRECT
  mm, swap: avoid redundant swap device pinning
  mm, swap: don't update the counter up-front
  mm, swap: use percpu cluster as allocation fast path
  mm, swap: remove swap slot cache
  mm, swap: simplify folio swap allocation

 include/linux/swap.h       |  22 +--
 include/linux/swap_slots.h |  28 ---
 mm/Makefile                |   2 +-
 mm/shmem.c                 |  21 +--
 mm/swap.h                  |   6 -
 mm/swap_slots.c            | 295 ------------------------------
 mm/swap_state.c            |  79 +--------
 mm/swapfile.c              | 355 ++++++++++++++++++++-----------------
 mm/vmscan.c                |  16 +-
 mm/zswap.c                 |   6 +
 10 files changed, 232 insertions(+), 598 deletions(-)
 delete mode 100644 include/linux/swap_slots.h
 delete mode 100644 mm/swap_slots.c

-- 
2.48.1


