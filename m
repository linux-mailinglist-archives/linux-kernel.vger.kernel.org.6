Return-Path: <linux-kernel+bounces-227329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36A0914F82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410841F215FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A1142627;
	Mon, 24 Jun 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCFq4pyT"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F10820330
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237882; cv=none; b=GbEM+bEjgRPC5JOngVdBGfwLC7B7qjtusIaf5pQCl/fZ2Sj6+cWN3IDS21FdMeVT9j0PYx3MHVDDxRlLDaxGLBHfOgc4LllndTciNkgIf0fqsUT9cPfwCciGGudwiHDaWxzC91Id4LJ78V3bXs5yYer+IgK1NCaYsUSltwVqLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237882; c=relaxed/simple;
	bh=/pz/OWJU4u8rErQuJM3R9XHlFgQ9DIUiyVSMMMb0jDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMENLhucx3FJmZxRmUjaU8bik1ewVpa4mSeQtAPT3sua/6/dqv7shQYZIoisMz0SCPxJzY70jjPY//fgqtWqiCJF9ZNHUMg0k6WAmYd5sBPn6cLvnnKJpu6yCRTz7CTp1mE4oXYcGIkYOfzckqVjxMD/Is94FpXUGccX/OYRD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCFq4pyT; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-797dcb558ebso272288785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719237880; x=1719842680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XxqQRI9qdKpXc+d6jBFsRb7em5oO7Aq+aq8gpL0ZAn4=;
        b=TCFq4pyTe9KXtNkDae5LHgL/sRLG6bLOVbcVz4jmfPC1qWOk2aR0Hf0yqhN/TzEDKb
         oNBh+EhspcTExSXBK6Bmn1BR0LtYYGwiSTWX7RJpcMyRubJFrx/7b6+d6MFbBwJnUCpV
         yjBGAJlvs0+xUOSkFZhcug5TS8w49Xhm+vOuFF7HJUWZw2h0giiwXxavpFBOO7FGWOAx
         8dYd/4HCJZ1fmVDz6+kRFxY6RTF7SVsHKHcDd6aDz4OFSl3ROeQf4n1Lqc9UD5BYNQgQ
         7ZqU9Sf/Xk6X0t5Rno1AEuPLfJbNlbhkyM5zGI7yTsaqzw1HhR7BAeH3uuOj2r2dkcGK
         DFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237880; x=1719842680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxqQRI9qdKpXc+d6jBFsRb7em5oO7Aq+aq8gpL0ZAn4=;
        b=w7kV0+Z6gpnMsTiR7kE7WsceBs1FcfMGCgjlax9+CNpSkJiG5x10eJr8yt0uaAJecZ
         j1XntRCbMqehLBkWeX3986PSYC4YNvEo3Uk/vVdT0XByGttpC0TR4RKcBBUam6eGmbkP
         UpeUPRU5lnbT9OfbldpZEoA/sb3pHIoLSfY9c1p7wrFfWGNot9VhQEtdIabDxvXqM4kJ
         wFW/VLfUbcYvg88Gyo7iaB2Pvwzzceu5KkzIuhDCwz9adDUiNXaXERZ85IrTO6dtNcKP
         NV6OWPao2bWPvOdLYkRvfwhK7T0A61mtIEHV0YddcXGxQZ4PK/7KkxuZ1vmu00vE8wqw
         wHXg==
X-Forwarded-Encrypted: i=1; AJvYcCX2byXbsRmmXTkHi/9TneUbaUz0iMCzFzzY2uZ8/i6Gzcnj2cKT1dZSLhuRr5l+aduOxtTD7orm9OBPmipkfHNT4U0UfRDgGVcfKQw0
X-Gm-Message-State: AOJu0YwmIqCNTLkwf+v19VApbmyAWoprBhDeCu2jw9YK1ezx0XHgZ7Kz
	uyJhqXPnIDf2dzk9OJJlNkruVnWTno71DqxyMdBV9kxL+aC3GXOn
X-Google-Smtp-Source: AGHT+IHiCP8v1Xw5+G3dthvuaYvZetHViclKdcF5bjTK3YToKN1dTLh1YEFrqDDDX2V7w6NDiU0MsQ==
X-Received: by 2002:a05:620a:3907:b0:795:5d83:9f96 with SMTP id af79cd13be357-79be703800emr589502385a.57.1719237880328;
        Mon, 24 Jun 2024 07:04:40 -0700 (PDT)
Received: from localhost (fwdproxy-ash-006.fbsv.net. [2a03:2880:20ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bd0beb543sm295596485a.74.2024.06.24.07.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:04:39 -0700 (PDT)
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
Subject: [PATCH v6 0/2] mm: store zero pages to be swapped out in a bitmap
Date: Mon, 24 Jun 2024 15:01:27 +0100
Message-ID: <20240624140427.1334871-1-usamaarif642@gmail.com>
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
 mm/swapfile.c        |  15 ++++++
 mm/zswap.c           |  86 +++-----------------------------
 4 files changed, 136 insertions(+), 79 deletions(-)

-- 
2.43.0


