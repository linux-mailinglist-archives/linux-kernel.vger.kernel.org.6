Return-Path: <linux-kernel+bounces-266900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EAB94093D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2021F20F75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9218FC6D;
	Tue, 30 Jul 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPOzJY8B"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FE8150981
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323648; cv=none; b=KDYEx0hrPP36NEasa2JbcmjBDvSGWI8ymRQVAqSEHMrINei2KKMj1xiRNaG+Ny12WCZxGAItDrUjEE71LIGctJoX1UYR2fokIkQeQmCaifl7lE0G5/01vbwLSbQt+nEjmxidHFF7Swmdks2VKx3gwhslD/k0oRkSCFNLwoR7MDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323648; c=relaxed/simple;
	bh=aLBqujg0DCn5ZfqmX8AmajL+kPPkkYzb07eUSMPXVX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZbuONG+d+Msx5yS5WCQbFQar1+4oRGNdQxIXO++yT4FxpodGSDmbrpF6klt4g5l8bRimOgy7b7QjJiyKls39xCQE4F9MaTUpVWLHz35ZRAP4mOOTdyBzuslevAko3oZDBBOy0WobqXF7Kk9v3lrXB60YHNnxv+H5eicmMZGaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPOzJY8B; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-75a6c290528so2665001a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722323647; x=1722928447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rpVSJhXd5VbYI3+8Mr7AbFAtjp887GR7s1Le6UFvvB0=;
        b=IPOzJY8BHjSeu/RZ7tOpvbhHEanDfL6u6KV5OVCw9P0AOYtvw0psZEJAQLKCu9tva3
         b3I86drE+j5QmxXEFITARQ2v0KAJDKmktaqqzGZxOuI9A+EGzhxF6MBBK8c92LSlSvPx
         5QRjyvHwuDB9Hn16GHarHJwj1bS6HR0mW5kTCQG1jzwNrI5keUmFsYgwhtwbV/DZZbiv
         kGEzybCkWgUhY8OayQVXO2JmBCfN5FTdDQJAUuaJwv34gMviOithglkXpeoSLpgTLqm+
         e0zugF6WjxjQjJAaAoGSSyRMASSM6Qd0cpXy6fIo+AB2U3Hr2/eFadF/MdUk+qp3D8TZ
         5lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722323647; x=1722928447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpVSJhXd5VbYI3+8Mr7AbFAtjp887GR7s1Le6UFvvB0=;
        b=W2U08g91TiyquxiA0zhPndNR6rdyBUbN63aL0z1c+DqRj3F9IFVjEVLn95HdfBmalt
         di3Ny6SJ1tLN9IqNXy0KZO8EPdq0sgEd78obpFIl4bHIW+vDR/THTg67/FWvTZ97ryLB
         +rsjl06KKenFk7wugIHtF5bJ4AkeCjvAID/llx/HPcSwhcbgfI5hZ6I6IdS5xSFc71wy
         C0tcUkE/SidMOJG9thGhyb0Do4o55v3IHFrlrKW/ZitFRDcDM/hJQ1i1bCktN9cgaT67
         sUBMXylYmSeOLnVODaTDDStExn30hOrxWX2IrDYWJoeKAyvphS+2KctToGXyehq8ewPW
         laFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjHZHFK1l2EzveVOc+L4+ydpMEZu6BF9qLWKJ3jtMOX64inykH60ZJfLjDWBSaBVqi3Jt76YSNIGiXH0NtmYq2yC8/d4fk5STf5yVu
X-Gm-Message-State: AOJu0YzbPsF1o4eINFccMplJ3JBsC8nQJp3ZWB5MuP1nymyzYBYlspeP
	xCc60WCJ/7+q9rBX4GUpBPHVyljtdbkmQ5yYNSrdd/wMRilQkQiR
X-Google-Smtp-Source: AGHT+IFepfWS3ibzltNNj2a4WSvl9NHxlJg7gDdRNuJYedVJOZzIUZaFbh3pgAoBt1vDAYsgYAcizA==
X-Received: by 2002:a17:90a:fc98:b0:2cd:2f63:a429 with SMTP id 98e67ed59e1d1-2cf7e726968mr8043875a91.35.1722323646682;
        Tue, 30 Jul 2024 00:14:06 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28de71a1sm9736452a91.41.2024.07.30.00.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:14:06 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com
Subject: [PATCH 0/1] mm: swap: add nr argument in swapcache_prepare() and swapcache_clear()
Date: Tue, 30 Jul 2024 19:13:38 +1200
Message-Id: <20240730071339.107447-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>


Per Baolin's request[1], shmem also depends on this patch. So I am separating
it from mTHP swap-in series[2] so that it can be pulled by Andrew earlier.

Differences with the version in the original series[2]
 * collect Baolin's reviewed-by tag, thanks!
 * add nr argument rather than instroduce new swapcache_prepare_nr() and
   swapcache_clear_nr() according to Willy's comment, thanks!

[1] https://lore.kernel.org/all/c2122229-3710-4e16-8932-303da0644a6a@linux.alibaba.com/
[2] https://lore.kernel.org/all/20240726094618.401593-1-21cnbao@gmail.com/

Barry Song (1):
  mm: swap: add nr argument in swapcache_prepare and swapcache_clear to
    support large folios

 include/linux/swap.h |   4 +-
 mm/memory.c          |   6 +--
 mm/swap.h            |   5 ++-
 mm/swap_state.c      |   2 +-
 mm/swapfile.c        | 101 +++++++++++++++++++++++++------------------
 5 files changed, 68 insertions(+), 50 deletions(-)

-- 
2.34.1


