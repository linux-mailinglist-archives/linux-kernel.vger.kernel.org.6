Return-Path: <linux-kernel+bounces-218425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B32890BFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4E02841C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AC319A28F;
	Mon, 17 Jun 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWfd77bU"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903219AA46
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665917; cv=none; b=WNBKrSqBs8e3caSlf8bRs1lBe0xyuM0BZdhac6HMBdkbG5W7eKLu756RgBTTYyLzUeUURP26NXjvw7sfdpgFmoGjVN4GAyKM0sU4dPuox1gIRtmY58HcXNE39fb2E+1zpGV+IE6s9tsKzoHz15ZF1GKSdGXk9lWRm3x9bvJYCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665917; c=relaxed/simple;
	bh=juyczMSrylM+yeB/lAu9GW7f9Vw0N9qx0xSqhCvK/8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tF+JL1CJP6Xqq+Shbz88tDTgBVxgZ1kBFusEVqqDC1zr2qIra6OhP4QTSbwRBvjK62JJCxKxSiDm/3fjjBfrtPI3iDGUOw4E5rhpDNs63k0kbSFTwanrve+7gaX6blnx8aKukRAkN72kq5hswibhfwmgt1iGGrnrK/pQux/nQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWfd77bU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f8395a530dso41997575ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718665915; x=1719270715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvCyWt69PGUZt4BpaxsAne+Mf2MHqVNEFtr7gIEXROw=;
        b=RWfd77bUhedFfCwhBYIk0rmeUpokKa8cqPHzn8aprihc4ak/eS2MF+ozPlCWLrGP0R
         jSt7yMhqoQz1iX7GdMSXw1y6lgjZiGIwvcHQnlPMZe+w31NJkBEkA3GY5A4pLrUh8bN5
         YD2IYwBWmTGHil007h9VlsVNEEzg4Mjot4VI9M7jEx1wgcO4/tmBrltBOyYr9fOsmsQ1
         s5N+mhfkc6BthjfvMf56Ctg973NBBx/PklSGHDs2lvI+Fwx06TUOhkXqOHh4LngD0IgL
         j6rnJe0hfYA723OI8JNG1KRDHCLZSq9V3xESg6Omh4ab3w5OZcJuebZlccAU/FmVdjjg
         8hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665915; x=1719270715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvCyWt69PGUZt4BpaxsAne+Mf2MHqVNEFtr7gIEXROw=;
        b=KgSlgoZNz73CNqpylNKWvwJJ+wG4NBC46OW8PPsbM/k1BgFBglptLVtmoCRFvHW7og
         sNB4MgGVpFaQnBFxG1TLRwNk2URUqiyJLbxLMC23jcpDYOiqK6ula3dVWexzhvWbEs41
         tZ2kNm9H3YSQdHHdcR9pBcDcjKQ4OxkCXAWEFW84hwYlnVoZ5HvvjLKF8kF+6hvO4XBm
         pvurjJzq5eOE3moFywexTNx1PhujYpz2cKCyT7IwAMLpStuMM+IF3kml4TGDw6/LPoMo
         /2lX+cVSJo76IAGFhpRih1/ZPutGhmbzHV00JyyngIFMliJ3fr/UjwzFwCxEI4cIzdAu
         8exw==
X-Forwarded-Encrypted: i=1; AJvYcCUtYUGiD8pn4M4ecWUqZyMjcOurZ5EE/f6LEnmh9kt8WtiiXkFaHLWvKbIp2i+N0IrhS6uTb2PE5z1nvCOIs3cTuKg4TvLvnmtlwwqw
X-Gm-Message-State: AOJu0YyxcLpRo3TzObQdaUHI+xq1GkVcJfXPSxoENTad3C3UnGmvetej
	pp2yIwxNQmfrL4W7WC84RvyvNLU2q2M80xJARnvsWQkaUwE3aapi
X-Google-Smtp-Source: AGHT+IH5DJEcFgg+9xWxSi15GsjyaYgih3hjGgUnN5rZbQBNeoC2YkMtuFoNrtwZuU2horotlw9GLQ==
X-Received: by 2002:a17:902:cec4:b0:1f9:8f8d:cc5f with SMTP id d9443c01a7336-1f98f8dcf99mr6363815ad.26.1718665915014;
        Mon, 17 Jun 2024 16:11:55 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5a0d5sm84658605ad.43.2024.06.17.16.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:11:54 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com
Subject: [PATCH v2 0/3] mm: clarify folio_add_new_anon_rmap() and __folio_add_anon_rmap()
Date: Tue, 18 Jun 2024 11:11:34 +1200
Message-Id: <20240617231137.80726-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The whole thing was originally suggested by David while we tried
to weaken the WARN_ON in __folio_add_anon_rmap() while bringing up
mTHP swapin[1]. This patchset is also preparatory work for mTHP
swapin.

folio_add_new_anon_rmap() assumes that new anon rmaps are always
exclusive. However, this assumption doesn’t hold true for cases
like do_swap_page(), where a new anon might be added to the
swapcache and is not necessarily exclusive.

The patchset extends the rmap flags to allow folio_add_new_anon_rmap()
to handle both exclusive and non-exclusive new anon folios.
The do_swap_page() function is updated to use this extended API with
rmap flags. Consequently, all new anon folios now consistently use
folio_add_new_anon_rmap().
The special case for !folio_test_anon() in __folio_add_anon_rmap() can
be safely removed.

In conclusion, new anon folios always use folio_add_new_anon_rmap(),
regardless of exclusivity. Old anon folios continue to use
__folio_add_anon_rmap() via folio_add_anon_rmap_pmd() and
folio_add_anon_rmap_ptes().

[1] https://lore.kernel.org/linux-mm/20240118111036.72641-6-21cnbao@gmail.com/

-v2:
 * fix crashes reported by Yuan Shuai during swapoff, thanks; David
   also commented unuse_pte() for swapoff;
 * add comments for !anon according to David, thanks;
 * add Yuan Shuai's tested-by tags, thanks for Yuan Shuai's testing
   on real phones;
 * refine changelog;

-v1(RFC):
 https://lore.kernel.org/linux-mm/20240613000721.23093-1-21cnbao@gmail.com/

Barry Song (3):
  mm: extend rmap flags arguments for folio_add_new_anon_rmap
  mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)==false
  mm: remove folio_test_anon(folio)==false path in
    __folio_add_anon_rmap()

 include/linux/rmap.h    |  2 +-
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/memory.c             | 18 +++++++++++++-----
 mm/migrate_device.c     |  2 +-
 mm/rmap.c               | 34 +++++++++++++---------------------
 mm/swapfile.c           | 15 ++++++++++++---
 mm/userfaultfd.c        |  2 +-
 9 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.34.1


