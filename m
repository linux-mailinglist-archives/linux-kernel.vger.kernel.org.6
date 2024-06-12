Return-Path: <linux-kernel+bounces-211509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EAC9052DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5B8287696
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E30176ACD;
	Wed, 12 Jun 2024 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXGVJqQd"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027AC176AA7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196475; cv=none; b=juBQ65ds5OUPKIe7NVJbotP0d07SpKPqnmCEYsK9uwMXKOz7S7MJIA3HcpYRt90n8Zqrbt61xbuyDRdmR7rPTMUvMnH1KuRJEB+NPPvFr7i2K0+0oWfLSH2u/PDMkQ8nGRMfUlIwACzg/CnLy8y5Q4KkPlCx5ITFauOyem+gFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196475; c=relaxed/simple;
	bh=dzZ1EEdvNupymcxs8NWoUBY9+Tp0yfHon3Zvjn2i81k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKzyCIt7/0iDjEg3c+jUPFCqd8eL+YZRbj/DyRMrV2GBe9D++rVcezlayyYJ9yOWXXqVVVzgtWBrTl6EFy0h1Darq9EQ+5Rq9iWY6Px9+nNLPIqodMV0meIb+N0DvAUTVMByXdoWaCrXc6vJeC+F2PcQtvCoCjG/BHxql3LuiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXGVJqQd; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfde20fafb1so1387159276.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718196473; x=1718801273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9F+Cd+tL8ekTIBJ3rfuDvhFdQnCYmwqNON6SdmRqk0=;
        b=TXGVJqQd9NI5kPWDElX5KjEpysXpVsYhoL0ZD+mPxkUG+vPL2ZQuiiDYeCg4WXpdJv
         Uaiv00M/AssOX8HiXwa9o8loydEytYiaMEPoHrBlB1JUA0itW+Z5F+9gtW/NjTRVoxlP
         jvC4+KzW7EbUpVzVHxNFpy+vczzVtuvvLvIB1W9nTwSs7zIUMpvvvgXsyncRU4iN/lsR
         XiaF5asUh7cTKZ0baQC6FxaueeLaJ+JfnemDB2Dvs2cDYz+xfncQEamHSlTJN65ubSZ1
         tYeYKYF+8bqJJyZQa5o8ADh77sk2QZ2zyHhvoDF60gujR2P6kJHcTLcYMz3xJaMDmBsd
         p8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196473; x=1718801273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9F+Cd+tL8ekTIBJ3rfuDvhFdQnCYmwqNON6SdmRqk0=;
        b=bUCSztQgWEiAd6g5QB1D50bC3CPe4bJeUTgsyNsd4orHUHzeezBaelq60svQgXnHrs
         E6eNLK+hWNI3vMFNYpcQ1AkAijso7/Uhi1/EZXf0Gc3rpT0wucPfnqK0vSGPaHX445NL
         rR/wHP2gFu6Y8b471gvMcInN16n1fUnw7yeoWWgPPfC1k9JPQSBDFYlXzzQ5y1D4d5B7
         ByMy2rgNMPFcRozj8YrN5lE6k5PfDgyYZSj2o7GOYgvujWPC8s7Z7dQZAOMyvV9GDwNS
         Ql07R2ggqsANUHpbOQ2dRreeRkR5qH9717F0UiLTH9cAG2oE8ooarQ0ZtpwN3qT/W61W
         R3ig==
X-Forwarded-Encrypted: i=1; AJvYcCXcCEPIG4o7ADEfRsL1Cm8l29KmEO/au2CCjX6SvPuAgObH95ewgaFhjdMIU7Wezpii5UiNV5WNLGiY/+FaCVipN828PnFAeJpd1Vir
X-Gm-Message-State: AOJu0YxBPipDjL0aAY3qrRr7aP2gFRwXnWg55h1SwYfmvWQ/EAyT2VZ0
	0W2UOqXm7Kmkphc1JOwnXWsgA8cq9J81oDre9t6biFih/KDNY+6C
X-Google-Smtp-Source: AGHT+IFYufT33T1Uwmyw4Xl+z3+PXG7RCsDVkLNGUSJ+AUOrxPKBRCeoBLQ0B6MfLbwtpM8TJSwhyA==
X-Received: by 2002:a25:df48:0:b0:dfe:4fb1:7b4a with SMTP id 3f1490d57ef6-dfe65f7414bmr1556605276.8.1718196472842;
        Wed, 12 Jun 2024 05:47:52 -0700 (PDT)
Received: from localhost (fwdproxy-ash-113.fbsv.net. [2a03:2880:20ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4406075025dsm34780511cf.85.2024.06.12.05.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:47:52 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	david@redhat.com,
	ying.huang@intel.com,
	hughd@google.com,
	willy@infradead.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 0/2] mm: store zero pages to be swapped out in a bitmap
Date: Wed, 12 Jun 2024 13:43:34 +0100
Message-ID: <20240612124750.2220726-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As shown in the patchseries that introduced the zswap same-filled
optimization [1], 10-20% of the pages stored in zswap are same-filled.
This is also observed across Meta's server fleet.
By using VM counters in swap_writepage (not included in this
patchseries) it was found that less than 1% of the same-filled
pages to be swapped out are non-zero pages.

For conventional swap setup (without zswap), rather than reading/writing
these pages to flash resulting in increased I/O and flash wear, a bitmap
can be used to mark these pages as zero at write time, and the pages can
be filled at read time if the bit corresponding to the page is set.

When using zswap with swap, this also means that a zswap_entry does not
need to be allocated for zero filled pages resulting in memory savings
which would offset the memory used for the bitmap.

A similar attempt was made earlier in [2] where zswap would only track
zero-filled pages instead of same-filled.
This patchseries adds zero-filled pages optimization to swap
(hence it can be used even if zswap is disabled) and removes the
same-filled code from zswap (as only 1% of the same-filled pages are
non-zero), simplifying code.

This patchseries is based on mm-unstable.

[1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
[2] https://lore.kernel.org/lkml/20240325235018.2028408-1-yosryahmed@google.com/

---
v3 -> v4:
- remove folio_start/end_writeback when folio is zero filled at
  swap_writepage (Matthew)
- check if a large folio is partially in zeromap and return without
  folio_mark_uptodate so that an IO error is emitted, rather than
  checking zswap/disk (Yosry)
- clear zeromap in swap_free_cluster (Nhat)

v2 -> v3:
- Going back to the v1 version of the implementation (David and Shakeel)
- convert unatomic bitmap_set/clear to atomic set/clear_bit (Johannes)
- use clear_highpage instead of folio_page_zero_fill (Yosry)

v1 -> v2:
- instead of using a bitmap in swap, clear pte for zero pages and let
  do_pte_missing handle this page at page fault. (Yosry and Matthew)
- Check end of page first when checking if folio is zero filled as
  it could lead to better performance. (Yosry)


Usama Arif (2):
  mm: store zero pages to be swapped out in a bitmap
  mm: remove code to handle same filled pages

 include/linux/swap.h |   1 +
 mm/page_io.c         | 114 ++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        |  24 ++++++++-
 mm/zswap.c           |  86 +++-----------------------------
 4 files changed, 144 insertions(+), 81 deletions(-)

-- 
2.43.0


