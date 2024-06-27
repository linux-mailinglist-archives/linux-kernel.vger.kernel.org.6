Return-Path: <linux-kernel+bounces-232168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AC991A460
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45971C212C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3436813F43A;
	Thu, 27 Jun 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGF8wSYA"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB913BC31
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485855; cv=none; b=JHdTRl8O/eZgj5nfNA//RpYXlmaznqos1CVWQ94aZHt4DfNzWQU3NhBjfNUI+T8Cs1tmVjT4n8MXb36EQ/igHBVMaPrdawhEaCspxZl9VjVM86MmK3dDI4XzL2SZk6Z72mw90DX9gxRim0/50LCQh4yFpM/RiqTqNjjA32+oRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485855; c=relaxed/simple;
	bh=Vdur4OzoEuk37UUUmRhg5iM791sgOpRVKNEnZRcPXTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBv/WiEMj3dFC1ewQepIeI0dcpE6AMZNMxg+OC7GKsAGewCq7r0N2hP6cx6yLhWFR7eJSStfyYVq5/dMMdTpzvfIKCj+Id2RKRACIjp2WOBsWCGrU3htR14kVStS4t1gOyvRiBSVyk2Ds87WOoKkF+qwtU+OmV3AaBen7Ay3Ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGF8wSYA; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff06b3f413so7209616276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719485853; x=1720090653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WsD/FARGvPOf7vgRzJuB2goC5N5PTWOZHU6FalHWVEQ=;
        b=nGF8wSYAT53pU9hRRp/m8Va2uIJn2Gj21tW8D7GFO0O5q9j3YgB6MX4mjz++knZR7D
         l5jR8gcoVKEoqzlsEJj/PQ9cMEVKkaEfwPBrSAxUYNLszRDERhjfmyuoIq8033Bhezd0
         p1o/Vz4JaIYvIJO/cs0e/tTkJelJrMCUIKHHybU8E/2Wfz68nBrmTyfl+vfoCEOFram1
         ekmXhCnMF+6yC1zP7ntOS37QKotoWAy2A9ilYYgZL/UQ8bg0FCEHd7HaPQH6cEy6iztf
         bF/8ekgd2cGhFU31q0g0MIJycwXUG0bgH3oNBTtIX2+gUwJizG581Om74hnTcV1/YFiJ
         Gd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719485853; x=1720090653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsD/FARGvPOf7vgRzJuB2goC5N5PTWOZHU6FalHWVEQ=;
        b=af226mJ32k3jEouykPFiAoWW2D8ticXn3HY/XhPHWjTNAD2J0/jNye3xeE62BX6rTS
         0fFV97/D/nJ9xPEPmxcW9qc6yH94fJPFeM5NB3MXmnITc/ym86s5XOY4wLjopN8aW/EM
         PJ0RBUwO0s1trnIcIXRnqXsuXaa0FNK1N3Sfn6bzgsNsoCNv5aLZaSlJIO91Rwm2OAca
         t0HuUloAJZ3SV2xxkKBDKGKMqDB7eBQIVvvb044gaBqiDe5U+KMmNfbqdVocjqr+zkj7
         +Jx99nJ9T1rRU+CbLvAiLJM3D/kqTK1Y2Ah/2Vz0GS4rgvxNUPiko4AaLkQhS2jIl2kP
         uf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8Ztf9RCG7DNI6BdCzo7k3GqTlia+91Da4zad/VfZol+I7s0uHmAxgIIdZO6US+S+5PitxTCkccgkRRwt+rnAmJE9rk2hgZCmtT1W7
X-Gm-Message-State: AOJu0YxMNxcmfGry0YiOeZx+kNTPePKthRlBwc14VaMKrAphYU7ODTlA
	MqkFWvd1qOfxb00PmhHY5q/2oOSWBRkuvBm+GVnAUETgyNob1e/9
X-Google-Smtp-Source: AGHT+IGwVk/Fd58WrBQnRqaISapyqM7miJqYT0qpOXhZSoqezURiR7HMbvfIYj8GFrb4XddqStxYsQ==
X-Received: by 2002:a25:2e4b:0:b0:dff:d79:cbb9 with SMTP id 3f1490d57ef6-e0303ff4702mr11132219276.63.1719485852807;
        Thu, 27 Jun 2024 03:57:32 -0700 (PDT)
Received: from localhost (fwdproxy-ash-004.fbsv.net. [2a03:2880:20ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44641fd6fc9sm4742631cf.81.2024.06.27.03.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:57:32 -0700 (PDT)
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
Subject: [PATCH v7 0/2] mm: store zero pages to be swapped out in a bitmap
Date: Thu, 27 Jun 2024 11:55:28 +0100
Message-ID: <20240627105730.3110705-1-usamaarif642@gmail.com>
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
v6 -> v7: (Yosry and David):
- Change to kvmalloc_array for zeromap allocation instead of kvzalloc
  as it does an additional overflow check, and use sizeof(unsigned long)
  for allocation size calculation to take into account 32 bit kernels.

v5 -> v6 (kernel test robot <oliver.sang@intel.com>):
- change bitmap_zalloc/free to kvzalloc/free as a very large swap
  file will result in the allocation order to exceed MAX_PAGE_ORDER
  retulting in bitmap_zalloc to fail.

v4 -> v5 (Yosry):
- Correct comment about using clear_bit instead of bitmp_clear.
- Remove clearing the zeromap from swap_cluster_schedule_discard
  and swap_do_scheduled_discard.

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
 mm/page_io.c         | 113 ++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        |  20 ++++++++
 mm/zswap.c           |  86 +++-----------------------------
 4 files changed, 141 insertions(+), 79 deletions(-)

-- 
2.43.0


