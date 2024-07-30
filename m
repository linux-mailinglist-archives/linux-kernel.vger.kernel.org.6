Return-Path: <linux-kernel+bounces-268294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD39422E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79751C23075
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AEA1917EC;
	Tue, 30 Jul 2024 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCR46h8E"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61468190051
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378430; cv=none; b=oHOX85AeYwpNmn4wspJoP8KRuwZ1gLXy8bswtDRy1mYe4oWD04MN9wM/urHYrqEGrvB/iDIXxbjT3U3pzBJLFqWJKq4B1hajJ4qvjBhtI2xSbrhZ+QfV+39c2s+cg3qw9310nPlk9I3uxOHbSt88r811px8EPyYIZ4owhqf3TMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378430; c=relaxed/simple;
	bh=kPVARcCyFGUJKPcO7q9YGILUTz5svpJJ70KhikQgsPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6skzbwi/sLX0uX6jP5WFnSDIsjWIC+sD0yU4qbQfkZ8gSmgR6Tdn2o8C/m+QD8+1EJwRZMhP0yjAMRKMNB2kaTKPyRf0peXhDrQzk/itqZp+8FzTXmIsTlq0VX36JfogdJGT/dLYfEUnYLpw9aALz/p+PrAuCle6JnhmjUmlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCR46h8E; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-65fdfd7b3deso37258487b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722378428; x=1722983228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfkeNSLPTC1ikCyuKHlEYPZ+QWefpm7U5tn/Vpm9NRk=;
        b=NCR46h8EIHzDpxxEpefyCD14pZlISj3dSRbCgCU1IniaQsVmwOVn4TAJcmJFtbwpmD
         XNniE8lcSiVjNtaoXmWGiFmUiHwTWx4tBLcIL9mPUeHrgQGLIuOVHIZEV700wt/So5mP
         D5MX8lm2Pmiv85biLq1UQC1MtJzH2fJqyK8kZAs+V/Kcf/vHavm+Vi6/XA2glVwV7CuH
         OKiG9i8SS+UF09N9pw9FXVinY0sShRj7nYGXbERVFxyMwQJZAKNty/39rHAbseVKPIfr
         /w58r3dogm8rdqTpYJm9fGgcxn1lQ94/4oLiunM7AmMHZbjzBws3nm+k2DyIjU1raDui
         s8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378428; x=1722983228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfkeNSLPTC1ikCyuKHlEYPZ+QWefpm7U5tn/Vpm9NRk=;
        b=FnOCuVamlLDNOAHAE+zw/sSaHSLDd7WkpSH28+yseX7dxhe6vy18T3Du2Utn0n1dvy
         icFxCXewHFlVnXY11lWsrrfibZoN1clqtKma3XF50UAL3TNbtLrVTqLvCm9oxfITfuMo
         o07QTFDtgSqOQCB0gMKIfWHSGOhYp87QVZ8E9jxD+dNVPZiJfxa7pxej0bUmBiIpTmf4
         rfEub8Bv7SaXgCFr4ipIrF3A+dqX0rDVBRXy/0ZdpF17LN5RDcVdzgryLqpplYJsH1FK
         ucluVjmGnSzdymjsCFNyDTS2cRy93U0rKfJ9qCLCQLY+aSnpiamVEhOFvSHnzMJjbXBr
         Yk1A==
X-Forwarded-Encrypted: i=1; AJvYcCWWszzNSwvOGmLYlOMFYyljMt9Qx/3jLEQGFgYFHzAqx52u8Fqja7knQIaMJHXnuvj4h90KwQ6p6THcU62YbiSa2iyDQxpBRYyGkSNx
X-Gm-Message-State: AOJu0YxiV7DogA7s0bO/3ptQzpW1q1sXotVErIqQNBA4zQHa3PyoSiW7
	GFbrmnL5COnpKhkavEhXAKNsUsy+phNToQboNKjJcmvCMKSTCVDo
X-Google-Smtp-Source: AGHT+IFaSmxbn8C5jRNFT82wnON6P4Dzy9JZ0JAuF+9TVBsmRxvIL89DPOlLv3cl7kGGiAAQd/UNqA==
X-Received: by 2002:a0d:edc6:0:b0:62c:c5e1:ff1a with SMTP id 00721157ae682-67a0a3253f2mr103397147b3.45.1722378428231;
        Tue, 30 Jul 2024 15:27:08 -0700 (PDT)
Received: from localhost (fwdproxy-nha-006.fbsv.net. [2a03:2880:25ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e78esm27322247b3.43.2024.07.30.15.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:27:08 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	flintglass@gmail.com,
	chengming.zhou@linux.dev
Subject: [PATCH v2 0/2] improving dynamic zswap shrinker protection scheme
Date: Tue, 30 Jul 2024 15:27:05 -0700
Message-ID: <20240730222707.2324536-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
  * Add more details in comments, patch changelog, documentation, etc.
    about the second chance scheme and its ability to modulate the
	writeback rate (patch 1) (suggested by Yosry Ahmed).
  * Move the referenced bit (patch 1) (suggested by Yosry Ahmed).

When experimenting with the memory-pressure based (i.e "dynamic") zswap
shrinker in production, we observed a sharp increase in the number of
swapins, which led to performance regression. We were able to trace this
regression to the following problems with the shrinker's warm pages
protection scheme: 

1. The protection decays way too rapidly, and the decaying is coupled with
   zswap stores, leading to anomalous patterns, in which a small batch of
   zswap stores effectively erase all the protection in place for the
   warmer pages in the zswap LRU.

   This observation has also been corroborated upstream by Takero Funaki
   (in [1]).

2. We inaccurately track the number of swapped in pages, missing the
   non-pivot pages that are part of the readahead window, while counting
   the pages that are found in the zswap pool.


To alleviate these two issues, this patch series improve the dynamic zswap
shrinker in the following manner:

1. Replace the protection size tracking scheme with a second chance
   algorithm. This new scheme removes the need for haphazard stats
   decaying, and automatically adjusts the pace of pages aging with memory
   pressure, and writeback rate with pool activities: slowing down when
   the pool is dominated with zswpouts, and speeding up when the pool is
   dominated with stale entries.

2. Fix the tracking of the number of swapins to take into account
   non-pivot pages in the readahead window.

With these two changes in place, in a kernel-building benchmark without
any cold data added, the number of swapins is reduced by 64.12%. This
translate to a 10.32% reduction in build time. We also observe a 3%
reduction in kernel CPU time.

In another benchmark, with cold data added (to gauge the new algorithm's
ability to offload cold data), the new second chance scheme outperforms
the old protection scheme by around 0.7%, and actually written back around
21% more pages to backing swap device. So the new scheme is just as good,
if not even better than the old scheme on this front as well.

[1]: https://lore.kernel.org/linux-mm/CAPpodddcGsK=0Xczfuk8usgZ47xeyf4ZjiofdT+ujiyz6V2pFQ@mail.gmail.com/

Nhat Pham (2):
  zswap: implement a second chance algorithm for dynamic zswap shrinker
  zswap: increment swapin count for non-pivot swapped in pages

 include/linux/zswap.h |  16 +++---
 mm/page_io.c          |  11 ++++-
 mm/swap_state.c       |   8 +--
 mm/zswap.c            | 110 ++++++++++++++++++++++++------------------
 4 files changed, 82 insertions(+), 63 deletions(-)


base-commit: cca1345bd26a67fc61a92ff0c6d81766c259e522
-- 
2.43.0

