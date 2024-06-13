Return-Path: <linux-kernel+bounces-212394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B6D905F89
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD631C21927
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34D63E;
	Thu, 13 Jun 2024 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVbkd2Ma"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B3389
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237270; cv=none; b=YIIiJ2rMsrQ62vGYjSWKT2rydrU5feJAYacEWOaCf1/iywkVVayZ1UpahuCGckD105912LtNo6+2H50zkyZ11IsEUK8WxipRkh1uyPr49R3qsWN6uFRK3f5NeIZsQoogBWUt38jPDw88Qg9bdME38QPCQwiFyNCFPBgBuGnyGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237270; c=relaxed/simple;
	bh=M0hhbPx08ZW1OZQx3ibm//ZZVj3TCZa5RNqBsa9KAx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pTTBIZpcN51a2+qbqFTV5sQoy+kKUJWKXnUiiIg7QRhcemO3W3hiTtJBEbm38yHekVdjBBJY/h8qJiTSKixE3rgrronaOZCAaPz9hd1ARch4GnLJle9FBUHggUaItldyF1cM0ufOAmU9ipCiY6Bn+XF4epLC81uGWbUz4xOXIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVbkd2Ma; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f44b594deeso4358215ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718237269; x=1718842069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gOphqhTRPNrwsNnyAzOo1trmCQ/oYkaCGbNYcPGgKrY=;
        b=UVbkd2Maew/9GkahV0Aj8UR4AcLDxjZFZBABs0bfbpS/a3BFvjxHlpqh6IyfESbBdg
         vwBArXD5z8hRpa/NvHgjRLjpb2iL1C/k6knlzy8oZL6B0zfYqZ1ZYuya6LgCcMWjHgQG
         loiBd19ZhR+DRZICl1X4nXDcBLew/vl8h+i9zVZaiJG26+5g+G0GHNoQ0z9izVEZRaRY
         SG++7UOfFe9n6FsKHya6Os2tgOKHmcGBHSjoS11vAh0teeFnBgRzCMuhdNn4DyN6J0WI
         OougWEjzLp/6WEHarrF+NDSHC97geqRV5Q0WmK8JryMnKHnKJV1OEGUAa1UxlcjSTSs+
         Klqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718237269; x=1718842069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOphqhTRPNrwsNnyAzOo1trmCQ/oYkaCGbNYcPGgKrY=;
        b=ZhHoAuUdkPKtMp1gLRI6z7GsHFLsTbgHUtb8p0BWCABOB9Ax7ede6MdG0Kfu7hq3iz
         QZS7BjwYp/w4FLCPmwBQvy83A1AOdS0kIrRm0XkPiPvpQaGv23YM6MQRmZQStBGozFhJ
         K9t4gsgpA2yCskMhFpFdEEA45pucuiZioECeWmVLc48QCr3qrUk1eAuaCPKKo+9EJIN1
         /R5mnlSimojKRPfL4K8H1k5QalkQe2XQ+kape128Bxhm1NCSA4pL0ZdtHi5W3K/SoC5C
         Uuh0t3QoJ3PVTAYTjo1QZxICVM0L2VZREtvGyZp80KgX/LSS3FQVZ0Zxu2iyad2O+Uuu
         Qs9A==
X-Forwarded-Encrypted: i=1; AJvYcCV1chgTaEazlF5kyYeBGx5EABMyFxBMLWFuSFw9Tn21k8xxQt2Dfsq1Wsksa9m5k8s0XeV/6uWABwT4YsXaPCbgNbLxO8U1cvs0gzcb
X-Gm-Message-State: AOJu0YzhMt1qTTLCKF7Ng348Z18NY+/b/5TfiHEVEMyT/oyt4mHAqrbC
	L0xWv46KFc0Q2ZYTHohvts/mzLtV8Ss9ro/NfEwqS6VCrE1PwkuG
X-Google-Smtp-Source: AGHT+IHPrZD4U8g8tjCHBz9baPeakX5J4gbi6nxxMt4NJK5+Rfe3vWjhD/0GNpqApURr42/+3A0moQ==
X-Received: by 2002:a17:903:230d:b0:1f7:1bdf:6ce with SMTP id d9443c01a7336-1f83b60f086mr43937295ad.27.1718237268622;
        Wed, 12 Jun 2024 17:07:48 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1af16sm525515ad.246.2024.06.12.17.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 17:07:48 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	yosryahmed@google.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yuzhao@google.com
Subject: [PATCH RFC 0/3] mm: clarify folio_add_new_anon_rmap() and __folio_add_anon_rmap()
Date: Thu, 13 Jun 2024 12:07:18 +1200
Message-Id: <20240613000721.23093-1-21cnbao@gmail.com>
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

Barry Song (3):
  mm: extend rmap flags arguments for folio_add_new_anon_rmap
  mm: do_swap_page: use folio_add_new_anon_rmap() if
    folio_test_anon(folio)==false
  mm: remove folio_test_anon(folio)==false path in
    __folio_add_anon_rmap()

 include/linux/rmap.h    |  2 +-
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/memory.c             | 12 +++++++-----
 mm/migrate_device.c     |  2 +-
 mm/rmap.c               | 32 ++++++++++++--------------------
 mm/swapfile.c           |  2 +-
 mm/userfaultfd.c        |  2 +-
 9 files changed, 26 insertions(+), 32 deletions(-)

-- 
2.34.1


