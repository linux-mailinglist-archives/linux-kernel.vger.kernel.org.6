Return-Path: <linux-kernel+bounces-275446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A19485D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1395A283B60
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E016D4EA;
	Mon,  5 Aug 2024 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4ajDMls"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98F14A0AD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900166; cv=none; b=XZbTkbzJuMrgnBK2aqru1KX/q49TBM4YRX6zO7UOPLCisur6r9okGsXjtaOAP1BSChshUjUuYj8M3/SvpWHpukyhIeeVat29MN8lmUV7M+2MIel9unBU41NEbFxfu8Axu/w3n/78iz4HrD2Oqwj/bU67cLCKiB9pyoUCsPF9i90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900166; c=relaxed/simple;
	bh=BsdT0p2BhtyA3225yVqLI/ARZBXEXBiiLQ7IE9XAX2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0pgHIMU4+O0Z32wQfLOYZY80EhI4tvp+OKImiNLNb4H8E9GdqBewcnFi75a6B/QRt3FC6wCoAi8P28j0vWo06hHKye6Kk2Xet6JQsOjsLKR8gB7ChTxdx+mPzECpuQB/IQKedgxADZ7Jvf8x8db82ZaiLpAFarj9FgzqFZ2Qc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4ajDMls; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65f9708c50dso1404487b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722900164; x=1723504964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPYAMMsP0uRNissPNWZSJAta6wImuOv5d58cqRo/XhU=;
        b=D4ajDMlsBZs1honvLvembFPBtxVQtoimsvDpvdcNPrlLvlIZ9JgzwXOkSYU+FSsQJa
         1O8m4Xr4rVlAxmnx/HMo0qM48am/e0k6e9qB9q2Iq7inN7b8aDO4a7wfXy9jpQrEexg7
         EWf59PXaLzYplDOVn/aCi9V27PcMN92NR04aytqLTmTOP447CZNbgh86+Bvf91VCSN+I
         NjzjBjl+ti104fYOiHfjco6KisZ8QNQAIYBDuWexkzBmx/arTgemD99y8Lom3VXp7vD4
         hmvUWO1T4KG+YIg5oC5Ala970Gqa8xPsXNIXnPZAgW5acVrv5F6Ecw8WVzhkvQC2pPbB
         Nv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722900164; x=1723504964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPYAMMsP0uRNissPNWZSJAta6wImuOv5d58cqRo/XhU=;
        b=DHuo6tsJwPPk2woy5TjQyXd53anASRRxuRYLAZSaTdamEK0aoVTQOQAgB+OKHbhHP/
         Vy6jyFSW7SsmqG4T2x0wwJJ2mlbcWEmw0N0jHglTLDvW8dhaOp9YrllxV8aDQh4z6okt
         htT6zTe3JVoaR16LWLXVZ/1gjtvRO0iXZ308gWTpcse+Ar0sEi6q3rkvgCF8kKg4vA1+
         NR9nPXEzQfyJ+dUO8RGdkZ68KSkvTrubdG5Mv5q77LuzY1y0hJiCJv2OgU/3+dF3vnuF
         C1j9NQ+a9qNUsIcnHTWxa2uVkzCACmtsYaBM8yoQ48Ny5QgxmbplBbMAToX82VA4Npkx
         UU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2o9OE3oFOiYcm9SeZUL17PzPPbzXolN8lX+cXOz9kqw/1BY0ru7HZtNLxiFtOO2Ij4rkP0resZWUBPv6WWH5cLrW3NazSiEbRlnd/
X-Gm-Message-State: AOJu0YykGb2ObQa1L6Splq5ktsRN9GW9T1TW1psWO+scpMjzq/VriAKz
	5+1tuL22JxF3Z8APA1F6LSBX1muWa0YIaDmSN981DetRYNj2Zvlf
X-Google-Smtp-Source: AGHT+IFPrHEO/KgU/leyHw2+KcPvaanTNyZl+zRAzc8NLNxP+vaHpLq7G/+mghISbxSoo5k/0kOQtg==
X-Received: by 2002:a81:8501:0:b0:673:b39a:92f0 with SMTP id 00721157ae682-6896077619dmr143576897b3.11.1722900164182;
        Mon, 05 Aug 2024 16:22:44 -0700 (PDT)
Received: from localhost (fwdproxy-nha-005.fbsv.net. [2a03:2880:25ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f4193desm13652377b3.6.2024.08.05.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:22:43 -0700 (PDT)
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
Subject: [PATCH v3 0/2] improving dynamic zswap shrinker protection scheme
Date: Mon,  5 Aug 2024 16:22:41 -0700
Message-ID: <20240805232243.2896283-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: No (intended) functional change
  * Small cleanups, renamings, etc. (suggested by Yosry Ahmed)
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
  zswap: track swapins from disk more accurately

 include/linux/zswap.h |  16 +++----
 mm/page_io.c          |  11 ++++-
 mm/swap_state.c       |   8 +---
 mm/zswap.c            | 108 ++++++++++++++++++++++++------------------
 4 files changed, 82 insertions(+), 61 deletions(-)


base-commit: cca1345bd26a67fc61a92ff0c6d81766c259e522
-- 
2.43.0

