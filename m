Return-Path: <linux-kernel+bounces-204916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883DB8FF4F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1980B1F24699
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1413F4E1DD;
	Thu,  6 Jun 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHdgpCYk"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0414652D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699703; cv=none; b=jDwb9zav8NAK7+IySRU44aQI4JQ8J6YGPbPpTmBzvWLJAZ17o480Lel17Uz/P8xglDvBHRtu5cd3hBCTK/jxOLxn2znm36w+l2OQKLiU9w8xkih4Jj+LhNY3QGYSJY2bZ3mrwReV2HTOtpALC0QY2hdw7dWHg/7ADB263M3tz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699703; c=relaxed/simple;
	bh=swNbkUhJX85AnPQBSO1rHUAI4XL5FOuzWRYmH0ezyuU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FFY5+stOAb+42wGZeHIB8J0I8w7CwNrBvGz9p5lZtT2tisWoBqPmXvrf8/ZSqG3e2VdRCjbYpLjfRHSl2SKLLPIGEXYAQ5k/M+FN0uMiQkO/W87xZMWa9hjmq9qqZvAUMgPBHJLPqZ9Zf+mKTw48iLrYyPGCflwAaoSW9nR7BQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHdgpCYk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627e9a500faso20084777b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717699701; x=1718304501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=33EVY1gasG0xwBVR+VPpHnVgd2Suv88JpbujEvfP7pE=;
        b=IHdgpCYkcZawEcgFxyIBsfDh61qQlwy7ozZJVqEc1GJ/Do0iapA0BmaKsvPGtZ6FeB
         8s/woiGlV0q44hIsVvgWt8s+LWxKT+Dbg3BuYEE1iGN5cHvRNcS63YxHwqthplwxkbwK
         zJWGAYp5RhfTIy3XekduufIIDPOHZ927v5EHcvwE7BwgO8MGPM0ZW2v1b6eIWI/xhLdq
         Ot8Egt/ubJ6eNb/XqoWCvNoGyh4/INql0Wk1ymLjFY+CnRAN37eafvVZP+EEXwH8wL2m
         3QYszQHWDv1uOxuz+C/C7wHoEImqNW4jZLDlzRHyjtu2noQMvmMlxfxsaXhtrJ60wdNC
         //7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717699701; x=1718304501;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33EVY1gasG0xwBVR+VPpHnVgd2Suv88JpbujEvfP7pE=;
        b=RS0k2pA1/cTVkpL4t75Xp0MPtNrp1AuBaiuCHqnHL0VF6cWby9upkSXMEXUSQWVRa7
         5WQtGsHgx3+ecxSazhk48Pmqv3wdXDIdoZjnX6AwlMRkBJimcoAGWHD66U5f7d2YHW+7
         8Ep6ZTw53nSSqMVFuKU0qi/Rd29lkf1ZcKXmxWhrXt08W1hwbWfaWYSHjL86Rv2Da+Id
         QYLvhgGSj4E6/ZXWqoMZCdcAKdyBTVfIAz0XRWuKd2jblthZ67kxKSYcGUPJ8fiywWNF
         Lusrtdn57IenFx6KSvqjbAVlzOOJS8mi3jw794DexTHdipR/GYcqX/qEdFTJkae9n5H0
         Xa0w==
X-Forwarded-Encrypted: i=1; AJvYcCXu6648OyfcbWG1+8hJGth6HM9iTdfIpQo5qqBqnfZ1p8WSl5etC3aWmyafQtEcwc4Xeyq1DixJuy/SAOFYlaBsPyueO92CHZttFgYZ
X-Gm-Message-State: AOJu0YwejxzOssC+T5NNGQE5IOlIhwjMp2dWe7BxPu3ZUR6q4qlb1zpW
	riV1neynILhxl/HXcQgn+Z753YNAKRwNtrgdjItI05wy3/yyvkFvrU+vnczqmd8yOUARCodeTrf
	PpI3dD61xjHu8sRW9MQ==
X-Google-Smtp-Source: AGHT+IHzjxbN4O+eAC75lGOtNEstlxb/v3Bkbe/QNm3rRRhuZDaL36ej/IJ0lS6+ElHmlyMkLkNFtiANK5EcF5Y3
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:6612:b0:627:96bd:b2b with SMTP
 id 00721157ae682-62cd5660eccmr571787b3.6.1717699700884; Thu, 06 Jun 2024
 11:48:20 -0700 (PDT)
Date: Thu,  6 Jun 2024 18:48:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240606184818.1566920-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

With ongoing work to support large folio swapin, it is important to make
sure we do not pass large folios to zswap_load() without implementing
proper support.

For example, if a swapin fault observes that contiguous PTEs are
pointing to contiguous swap entries and tries to swap them in as a large
folio, swap_read_folio() will pass in a large folio to zswap_load(), but
zswap_load() will only effectively load the first page in the folio. If
the first page is not in zswap, the folio will be read from disk, even
though other pages may be in zswap.

In both cases, this will lead to silent data corruption.

Proper large folio swapin support needs to go into zswap before zswap
can be enabled in a system that supports large folio swapin.

Looking at callers of swap_read_folio(), it seems like they are either
allocated from __read_swap_cache_async() or do_swap_page() in the
SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so we
are fine for now.

Add a VM_BUG_ON() in zswap_load() to make sure that we detect changes in
the order of those allocations without proper handling of zswap.

Alternatively, swap_read_folio() (or its callers) can be updated to have
a fallback mechanism that splits large folios or reads subpages
separately. Similar logic may be needed anyway in case part of a large
folio is already in the swapcache and the rest of it is swapped out.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

Sorry for the long CC list, I just found myself repeatedly looking at
new series that add swap support for mTHPs / large folios, making sure
they do not break with zswap or make incorrect assumptions. This debug
check should give us some peace of mind. Hopefully this patch will also
raise awareness among people who are working on this.

---
 mm/zswap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index b9b35ef86d9be..6007252429bb2 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1577,6 +1577,9 @@ bool zswap_load(struct folio *folio)
 	if (!entry)
 		return false;
 
+	/* Zswap loads do not handle large folio swapins correctly yet */
+	VM_BUG_ON(folio_test_large(folio));
+
 	if (entry->length)
 		zswap_decompress(entry, folio);
 	else
-- 
2.45.2.505.gda0bf45e8d-goog


