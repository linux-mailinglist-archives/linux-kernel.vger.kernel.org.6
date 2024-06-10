Return-Path: <linux-kernel+bounces-208142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E590216B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8955D1F2167F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A387E799;
	Mon, 10 Jun 2024 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYIZ+rDm"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64BD7E57C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021906; cv=none; b=LnTLFPdATGI5wqMMS6xlXRh7cmtNtzt/W6Y9VQQ4MZujD2p94x3gw2gPtmQ1q6KZkU5S0xrJJnGte7dXDmJfvtx+yXo0DoibuoFiuJjHUGcUNsl5yQ1tE0Qn62CgnqFxCfm+/s4E8ZCSRaPU1QBzKOldhVXNvobY6WMv1rAXI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021906; c=relaxed/simple;
	bh=aQ6jk11K5ysHvETxy4Xlgu0vY/turwVtvB4rc1wailw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1Da4UtsQ+nn1U7/QBa6DAwNqUvrXltnJ5yuKcopSqE+qPwtgYhhv4K8LZYH2g/EnXZQUUajkXg+mONiR2rqK4LwunNSYX6kYCjHoKg9dTfN78hmFgFnoO5qpb7phYUQPQ9CROgL3wA9OegNHa71ndxa6d3tZ7cXcM6qXEui6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYIZ+rDm; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b970e90ab8so2614505eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718021904; x=1718626704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+Az1PpLJ4JYTtMedJjbgRRlyQLWkppyc96i5melFic=;
        b=nYIZ+rDmdHTitQPk69K7ei3+zVFySXuD9h7D2J5zw3L7WPrg/O6X/UgScIqub5BQ9h
         oOfF1fuA/R5kixjjK38Wkgs+EBNDSjezqjHHFmryy5KVEuAJ7KQ1Dl7b6q/v6BDuMlUq
         ifMjPCZqGzFo1iRTCZxXlDQvZUdjoeSClan0jp751bAyWxMtfCqmYf8YlqBmedYrzkls
         dajPV/nXChVuJWHXXPNZ68/FyoMRZB5eGC7K/5X9HJIApxMTETjJQTKKSBkfTdFqwa6i
         jcdsP1LkYOhUUjed+INi2O1lRLjvcbW6OO7WeBe2NAnZxHl37EUWemz1gNtSjcESwM6i
         2+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718021904; x=1718626704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+Az1PpLJ4JYTtMedJjbgRRlyQLWkppyc96i5melFic=;
        b=Phdd1GN6Me2ki8D9iiipc07QxXxg0NPiCgw3RmRvboAVMn7/TjO37KFfk+m3Vksa9y
         S2XAhczSqxiEAHiAJ7SkAglIkPp6bMekfNLibDw5tkuoa0dbpvkFR080j7TQtu1D9oMC
         BM7Pwd9kBKb7gbKUQ10W2qwvBSHPBK1NjO6MdNTW9yrGWBlJhOO9hNcIoB5v1Q14avSm
         EFVpn1qHoMUp9az8VKDjuk2H7ZqUBUfsSzZFeZrUDldmF2P21h4OEA12KhiRXGBtqEFO
         VlJzcJhjpDscxei5IRar8Tx4Qyk8AwRSOycvSCfS3XS6gR9hh02qnJbj05bJZctPdk0i
         d9bw==
X-Forwarded-Encrypted: i=1; AJvYcCXN2OG8Tng+xljWV2UR8dNQtVIDegNgim+Ij610zg0x46qSsP19a5B/R1nupKGc+tSw+K4bw6DrvJeQbn5W1lHKXmMk8Ks+YewSjdR7
X-Gm-Message-State: AOJu0YwRXa0e/bZ9NbN/jpLZMWyBKm4aI1iMIbO9fKPrRusmADCvNGo5
	vQmOrNip2HrItVwjoRSq8LiBooMHQ7h7fNKEK/isjV5lA77ZjvUV
X-Google-Smtp-Source: AGHT+IHlGKS8y91VhGXHAROeBpYgpO4e/NBHK33a/DUHtG9u+8/tE43i3a/RyUN7beMURh6JEM4UUQ==
X-Received: by 2002:a05:6358:63a3:b0:19f:4d27:fb77 with SMTP id e5c5f4694b2df-19f4d27ff52mr491142255d.5.1718021903745;
        Mon, 10 Jun 2024 05:18:23 -0700 (PDT)
Received: from localhost (fwdproxy-ash-007.fbsv.net. [2a03:2880:20ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b063821c95sm32331886d6.96.2024.06.10.05.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:18:23 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
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
Subject: [PATCH v3 0/2] mm: store zero pages to be swapped out in a bitmap
Date: Mon, 10 Jun 2024 13:15:58 +0100
Message-ID: <20240610121820.328876-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Going back to the v1 implementation of the patchseries. The main reason
is that a correct version of v2 implementation requires another rmap
walk in shrink_folio_list to change the ptes from swap entry to zero pages to
work (i.e. more CPU used) [1], is more complex to implement compared to v1
and is harder to verify correctness compared to v1, where everything is
handled by swap.

---
As shown in the patchseries that introduced the zswap same-filled
optimization [2], 10-20% of the pages stored in zswap are same-filled.
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

A similar attempt was made earlier in [3] where zswap would only track
zero-filled pages instead of same-filled.
This patchseries adds zero-filled pages optimization to swap
(hence it can be used even if zswap is disabled) and removes the
same-filled code from zswap (as only 1% of the same-filled pages are
non-zero), simplifying code.

This patchseries is based on mm-unstable.


[1] https://lore.kernel.org/all/e4d167fe-cb1e-41d1-a144-00bfa14b7148@gmail.com/
[2] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
[3] https://lore.kernel.org/lkml/20240325235018.2028408-1-yosryahmed@google.com/

---
v2->v3:
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

 include/linux/swap.h |  1 +
 mm/page_io.c         | 92 +++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        | 21 +++++++++-
 mm/zswap.c           | 86 ++++-------------------------------------
 4 files changed, 119 insertions(+), 81 deletions(-)

-- 
2.43.0


