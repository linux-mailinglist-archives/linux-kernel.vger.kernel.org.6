Return-Path: <linux-kernel+bounces-214738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB3908969
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E83A28CAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEDA192B7A;
	Fri, 14 Jun 2024 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du+W80Nr"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD162190477
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359749; cv=none; b=oMPU2947qU+jBLXUawlJtHt6ej8Vn2GjynYbVsG33UnRq+SvZdFY1+FxYZMzZt3X8rJssUy+D2Q36SU8aGphzHzSS3CvPbOc4i14OvodRBOjK8u3vtKE41eZuD5yZdeV7m2HhtNTs2rLt1u2STpWtGsMO/Pne99yjNEr/E1frnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359749; c=relaxed/simple;
	bh=JM1xcNKf2I/n6mF96bc79QSrUtefRckSmNiDaauclg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWVedmhF5lEvSaWEv6uYjk+TKoS4OuHu0dFBpauUR7M0GsSCCo+bXlEeK5bgfK8JL+pstUAf62DiMFWLJ+KZjnpuHtXG2pKbQrlocWvCV8aKugnzZQdrW1XQH53N5qB143ClZoi4kONlVbOUaCdvWwJkKx6sBYRBKOn7xsov2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du+W80Nr; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-80ba5416266so593979241.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718359746; x=1718964546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWc3xb/HQ07XBx75U8zO/2sCP9wicZSlLE1I4NEfPds=;
        b=du+W80NrLO+O2ZsovIyxUuP6sPtB5DgvdggqAC3cL9gdCk3wcwF/jQMAH9Pji5lm8h
         e1vKhXubIQ9LCCDmJdSptNsdtL762agvBjaTOlwBHdR4thbUnvtNnF5Au96Fr2i/HAcI
         QmKImA10eP+0RDSwMA6XS57QdwMDXpdRESyCpRdFeu5+ynPcPj15YWsSZd9wyUEK015p
         44wa73HuZocndq3AYe6/S0BeYKRdx12NREiKdQMmAnFqp2XKykKZ6UwMnTeqbAnQT6+b
         Wjx7CxZHW4qEGTahT9HeUWUkHPHWgr0518kKptUMI/cOqJi8ImkBUA/JEC4uZUaY/uLO
         ER+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718359746; x=1718964546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWc3xb/HQ07XBx75U8zO/2sCP9wicZSlLE1I4NEfPds=;
        b=EHgdwal+grU4dYT6hxHPJNyJQJQQnWyNnyuR33JZBMf+TT7Te3w2gEFBea+k1BL1Lg
         StE+n7E1y/x4kfHIdChPwxLkh/ggcmapDfQMj5ADjrTrI3DAPdXMKQlg77PIUc8zLrUs
         NcXcguQl8NJ5v+uPYCA/mQuM6so0z16mFT0GWk451Mk142lh77put97omoZzXF12puaM
         glEKRnzFroCDO/fFqbDMN5k2y/9zIW5AJTHfNYdOxm1bqFGu+6NJONClbXJfwHTfPN/6
         EcZx9nIvbOjMQNwHWMt3IhiQCoydvSyAqy34NHgjrMbtHBXjKJ5vcxBF+GCRQCl80dK5
         n+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP/L2lmHoak3Wpy7xYw+Tb0J/UdIi8Eypb3mmOxkxFXThLPp8tcIvWgbRaRmU5mHd3IpEOfXGie1vgkR0aB5jotvaHyMMelBYLr9UI
X-Gm-Message-State: AOJu0Yw/mbOIwy1bNGeyXr1AeOTCIcz/FSpHBpqVhgK7U8EXnT2HucMj
	yC1Jl1Y5jXgXhQXJxctvZ4qgPKgKvdrRl6iMYOqm0d+BglzunHM8
X-Google-Smtp-Source: AGHT+IFzbHBz0PdVxNeE2rB6k5bdThJ6O1EORN/j59be7zwxh0ZgAEI356Xg5ZdBQ2/cmO0wswbsIQ==
X-Received: by 2002:a05:6102:9c3:b0:48d:893d:9415 with SMTP id ada2fe7eead31-48dae42ac06mr2225891137.32.1718359746320;
        Fri, 14 Jun 2024 03:09:06 -0700 (PDT)
Received: from localhost (fwdproxy-ash-114.fbsv.net. [2a03:2880:20ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe6b4easm129470685a.123.2024.06.14.03.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:09:05 -0700 (PDT)
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
Subject: [PATCH v5 0/2] mm: store zero pages to be swapped out in a bitmap
Date: Fri, 14 Jun 2024 11:07:04 +0100
Message-ID: <20240614100902.3469724-1-usamaarif642@gmail.com>
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


