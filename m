Return-Path: <linux-kernel+bounces-515453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C06BCA36516
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39307170C96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E59268C74;
	Fri, 14 Feb 2025 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeFU56tO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB22686B4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555904; cv=none; b=rudMwanXQCtBYvs3mBWh7BiJdr478e9XnYrA5sqaJUSMC5INM+wiCSB2K7FYZLOKw9R3D1LtI+B1imxEk/4EhwHCl96FJOHO1+0rrldcEkpLvFXyTEb6X/B0zsVtGOtYdy0r/gZbOXiR2FE2VfvE0z+nw/+FmNxpQGyM3WEo0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555904; c=relaxed/simple;
	bh=TDh0rbvaz4H6okZVXNT99sLPWxxtzWep85uRQLz5bOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0SUOPS0pelDpyokjBQj1Mj3SzEoKcF2awlGUYcIxGWdrFnpVN32grAFmxHDJy6opdQxOtSeymc0J/yOYnNYoRvURgQLwZ9negtsAS80Jm5m7XH0sSfdaiFWCGS9JA/noth0dGlJzXLwxlT3AZAfosL04e5PcXZpXbsOAuCBvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeFU56tO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c665ef4cso35649385ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555902; x=1740160702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fH8wa9mDFKKjF6AAEuB3tgHwOgdezUr8uBme/mmnzog=;
        b=JeFU56tOdyk2/Fkh557MndMdT7SLbXUugY1fLBfYjEHG2E7bdVU360ZznaeYS8i+Lb
         u8DSQ0ymxXJCKuKYEwbqQveIRBUkv3dudOdPIeFS2bdrh3fSFw3dLhDrimGW+EdT+X1w
         iJiK2n79ooyR0unHVmAJmKsII7Gl/6jG7O0CiJtMDXSR2kqQ3rI8BbBl9Fs9+6lIUksG
         eWnBBXexRZysLR6+NtC9s9nXXbi+3UWJoA5jmkckCZnKB/aL9TrEgEgp2fF5Bo4impiC
         rKV8CRzxPYtYCA7Zlvcwf9IZPs1fjnwLPqwglkBDBktUnssrqxUSonVA0VjDNu9mXtjV
         XVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555902; x=1740160702;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH8wa9mDFKKjF6AAEuB3tgHwOgdezUr8uBme/mmnzog=;
        b=KlzrBolVyv86KGcWPQWurH3RCn3SxTxpEk79w6N1i/k2SUVPQ8SxQnXMBK/wKmyFT1
         AxDTTqR3CSHJsAFfDmEYrxtjWDQ8oGQuHxHV8c/c2KjtVW62vJwa/FpfaToJjBGl39dL
         DIYeal6VbR/vzUUlPi+Fr+IypNo9ayjDhyQ4TbXrtuvfxT/m34zdnPSrKl4vS3SPJnxT
         cOg2ehoIHjrMltdjDmLTgQwcmBa3z0UtQybDSN1MFm+KedzzpxVyKXixIMkBbGdYeKch
         AUSL9q+CTp7nUDkSpN3orcLpB5y4Ccm1Rlt2baKNZZenlkaByUqGVqvXThM79kGeuLVD
         nnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzrCKZvtLvx7qt361jHoImtz90GUthIk1Ag9H0Nlb1fys/Qce0lkYOsxqaJgH+Q5tqT4Xngq0rphg9A5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdfELbBNWCjy7rxZofuDuw6N01jdjZ6NAaawDdww0C4nH2s4U
	DIZNg021BUsjJBdGXHHZHY+K8Y+3liGfhKeneY6cqXZThZC3u3Jartvtn0rTRwg=
X-Gm-Gg: ASbGncs++azANd9oO0ybMh3daOgdyap7kgcWrD2hRan54dlxm1KedeU21Gv0XQDzki+
	kesMC9O3iIjL+l79jOBZ/L44JevqmOkpJCooOsR2Bph145kIujpTAt7pZ2D0FvCz248CtAjeama
	jx+u1gDgIz3KnGp3igzI4ub4Svc+9IRD07vglG5tajQizgwVGzDKo3FHpeUiFrYeDErwXyDc8Ks
	jtMpMOHxC1ugG9d0BSeMRCaByq5CYH5XibFiKLjbJCqwP6KBEQQ8h1dypQ4blSQBxuP7yEuQ+9P
	CqpaI3VFrQvrTuADZDrbaSuvaO1DW+Kz/owp
X-Google-Smtp-Source: AGHT+IGc//Yf3KcYa3gkm02REt+Cv1CxSx5XjNqoq3oIpbzENLsmetvp4vbwpFAd27eNTXoz2k2JEQ==
X-Received: by 2002:a17:902:cccc:b0:21f:5e6f:a432 with SMTP id d9443c01a7336-221040409damr3063105ad.24.1739555902166;
        Fri, 14 Feb 2025 09:58:22 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55943b5sm31216605ad.246.2025.02.14.09.58.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 09:58:21 -0800 (PST)
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
	Kalesh Singh <kaleshsingh@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/7] mm, swap: remove swap slot cache
Date: Sat, 15 Feb 2025 01:57:02 +0800
Message-ID: <20250214175709.76029-1-ryncsn@gmail.com>
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
 mm/swap_slots.c            | 295 ----------------------------------
 mm/swap_state.c            |  79 ++--------
 mm/swapfile.c              | 315 ++++++++++++++++++-------------------
 mm/vmscan.c                |  16 +-
 mm/zswap.c                 |   6 +
 10 files changed, 196 insertions(+), 593 deletions(-)
 delete mode 100644 include/linux/swap_slots.h
 delete mode 100644 mm/swap_slots.c

-- 
2.48.1


