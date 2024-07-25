Return-Path: <linux-kernel+bounces-262718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35693CB3C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011221F21F95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51409149009;
	Thu, 25 Jul 2024 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCrp5JXG"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F55FDF6C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721950096; cv=none; b=rpeuz1WertweXnoSTW9JoJ+ZXk4QvU5MMEDFrmrlCUZ/rHPRWtsfX90Bp0d49GA0Ycjqb2wrjN/xrwv0iK80jnkND7z3nFU96kB5yVOtN4SN701P5AY6BfvgrJiQ/0K4Bwfutqgxv7wEgxp+ZYj3l/Fux3/G3s9WZIXyzCFo0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721950096; c=relaxed/simple;
	bh=bwfe0gKa2JuqERXfI/rlZhls2dw+jJZcPJAQ5rUQ5rE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6gwGvRzcBsQvB1+6Y7+FmG1i9nbBIprR3LQhnHcArb5UWt1kjQTNI96LRmeYuuKL0ulEYmGDmYTHwu5ZlDPXdV5LvPlDiJ1tRiCYajUlT40gMvpxSdJ3LQwYb5Fw0o56UKDhsdSp7Jf8b2KdJ7cEgQLSQyPUEKASxE3F6l5rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCrp5JXG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-66a1842b452so13100697b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721950094; x=1722554894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NM5TBiYVEjJnHiY+30Cvc0w6+IhqbneG9jlmhAXaw7M=;
        b=DCrp5JXGMfVwGb2HiiAcDweQq556FJcrgNshagv2eYM10EV4badq6SYfgqzMyP0T80
         8U2gpOzAFYkfQmNdyTCXgooCk5c8G+ONdosc26w6ys0yzt3fDmbTpa4iGv0Dqk1vK0z7
         MRx69xnXcctSUamKFbdHnr05YjJKiG/KY5+OIAnmDkoYtsgf9WJCbpgFiyaHVZKm3wP5
         6GUyWEVPrWt0Los6kxsy2YTCjVCUF9dH7QCV1IxTcmRhFE+Pse+2XERIb8jImBcyitaY
         HxECMfflfuMlIg4j86/pxClFonzILfnmfJ5Ux8ZKULQmaW7OLmCsFO4lv+HEjZhfjy9R
         3qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721950094; x=1722554894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NM5TBiYVEjJnHiY+30Cvc0w6+IhqbneG9jlmhAXaw7M=;
        b=wiSmlU5rOc1MzAJ3G2KPqsAOWH6SM3UnT3uodnVipAMVoWdDsPjZiXR0g44U3iI3v1
         RY77Ld1xD23MEo1MhlSTSyAY2YkV0jfolhu4wSBb1OmvvQO+Ebx/fmNajh46s64EdCl4
         d05AAXJmIDyjiybotlMNpZGhDSmipQXEYYzrfQOYOD/XxkwDB+pp01z1VPgDLPTjNH2k
         YCLlyZtXXRFQDP5qPjBOAemHvVEHfwlfebQjSGFiNwu5kchb3nQFeIpxVIxx1azok8E2
         WKha9xKQa7vv/yYpeAwXZ+iQ8TbIXYgNSOhAxzF4O62B/sS8bdyd2nx5qFCJDUxU8eGl
         7Uew==
X-Forwarded-Encrypted: i=1; AJvYcCVLYshG+3JW3G6ZwQCz+pFdFvz50fG+eCMB5nHEwuRwWCZSf/nfjICStwSzcO547EUilklA2IrF/TyO0RhmlpRqcaMsmgt7Nk0iJZ29
X-Gm-Message-State: AOJu0YxiBo2bfhBUH2ypyXXr9TOSTk2gW9wixeLaYgDQO12IHeC2fv5C
	ZXThsYSJvcxL8g4dx3SgwNzbCRTsRfjzAPrjyCd2vYNTCEME7AIR
X-Google-Smtp-Source: AGHT+IGsl3DK2uNyBJ0USj7NsJlVxuixQzCujDPRRj5F4eZJxgAPtvq9k0866tie9uPYRqi8qQMIIg==
X-Received: by 2002:a0d:c802:0:b0:64a:4728:ef1 with SMTP id 00721157ae682-675bcd96622mr40080717b3.39.1721950094069;
        Thu, 25 Jul 2024 16:28:14 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bab3237sm6115467b3.112.2024.07.25.16.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:28:13 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	shakeelb@google.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	flintglass@gmail.com
Subject: [PATCH 0/2] improving dynamic zswap shrinker protection scheme
Date: Thu, 25 Jul 2024 16:28:11 -0700
Message-ID: <20240725232813.2260665-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
   pressure.

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

 include/linux/zswap.h | 16 ++++-----
 mm/page_io.c          | 11 +++++-
 mm/swap_state.c       |  8 ++---
 mm/zswap.c            | 84 +++++++++++++++++++------------------------
 4 files changed, 56 insertions(+), 63 deletions(-)


base-commit: cca1345bd26a67fc61a92ff0c6d81766c259e522
-- 
2.43.0

