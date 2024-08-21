Return-Path: <linux-kernel+bounces-295118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1FE9596FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256841F2141A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79091CB136;
	Wed, 21 Aug 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gL1bZxkt"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65FD1CB131
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228450; cv=none; b=N5eBFuYxzGqA82Rh6l8a7TSontZUXC7c0o6xy6qk8cDPUfa9pWSeQROeOKludu9ko1YqmYM3dqKrGl1Ei/a1i7K9iPpyVv/4K3Hkjba6JWAc1St1hREmmZu2H39EZTl1HM//PsWG2HvGXoGGn5oXyi4FdwutSgX2WS6/xBZLyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228450; c=relaxed/simple;
	bh=0/2LlQVYxaSpsSprlESW/M/nT1cUvsLBdrUAt0LwVUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avcKx/jHKDzQmrxnm6VNGm0qeovuvr8gfgwU/iKaTkIVni8uRD9urQYNBY8xPZXn9wBiX2CsaG+jEmO1Ha1pyaoe8Wpl62mQw4N1CJU1IJ96kxPpqh1XxNP8VLSPGZZi38q9+BGY7WodmQ0GnVBSJJEANhim7QTur5zCKjxClv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gL1bZxkt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3b595c18dso390334a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228448; x=1724833248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8nsSUZs0Rgdiv42AW7Io4vKbgKEW01jAKVQTF6mEcw=;
        b=gL1bZxktTGgfcGmanWbgIkqxRlEVivxE7ssa9jAo7Oyd4vKLPaTtgSDzPsm60REEhE
         PuFUNzy3da++Ty/EPo7H/uY+0BAvNWdrzj5q9sQnbgb+fizwb/qn6pGDndIWhrJTD7Zn
         BlGsAzIc4Qz4NN7AxOdJkiZ3bEczTIlzvWdU9fBqRAlhIjsFnOJ2QRY1daBO6lCtmQgV
         IqRaAL9kvQUeFnhDgTcHRT9Q1p4gLCH8BbIMWEqkIPhbfAKwWo3MLFcUxGD8sFHMaaYY
         UOG6ba8avnSqeZdvu3w/iQatQQagUFU3iYbwS++OgwZKyuVRpepAVO77dOsSum2Tm8PE
         imBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228448; x=1724833248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8nsSUZs0Rgdiv42AW7Io4vKbgKEW01jAKVQTF6mEcw=;
        b=ZiBsUrHuatucsrlbsMIZmTTBHWU4WQQABlwHODOj7xFMTpLklFkxOTiE2Vv7KYp4NC
         577dIQSEIDcgfKTb0TRdzOP2B0y0xS6sRljpBdk5NINinTjZdpMA920i1KTjsPbGTbx3
         8aP7/ClcImn4Zbzv9aL9jf/kF2bUwwhTQzIK6qwi1937ZowztKAl4f0+29WfFJB5/rOC
         XzGWSQXXjDHwdJjKb/njQhczReUtipwJYbLhXwkmo4geVHmLZUFqEHyZtiY5pZd4B/8+
         r8I4RIif1iaMcEg1o1PK+6XW3HCkr9y2tI2RAXWYoR5JHdRUYMLf/OQWUPiD32Kge7Kr
         YODg==
X-Gm-Message-State: AOJu0YylnJN71pz6o0a83+pKhFZZjVv4APM7EGldjOF6dt3jkFH9LhO6
	3Ah9SJATvwp6kdjsUQkJdjCZUTy2DdoATnw2Uo0fE04sNKWDn2IfHAA1YvTseEE=
X-Google-Smtp-Source: AGHT+IFBw9G+gRGiVw886HN5nxLIybNKSDx7re7KNY7nJCh1bBtNFP6GTlUB4MiVeFJVy0IWyCdYMw==
X-Received: by 2002:a17:90a:d987:b0:2cf:fd50:a2d8 with SMTP id 98e67ed59e1d1-2d5e997c3demr2593063a91.7.1724228447873;
        Wed, 21 Aug 2024 01:20:47 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:20:47 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 12/14] mm: multi-gen LRU: walk_pte_range() use pte_offset_map_maywrite_nolock()
Date: Wed, 21 Aug 2024 16:18:55 +0800
Message-Id: <1bdb1ec4a30acf6b3a376f746c96236328904768.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724226076.git.zhengqi.arch@bytedance.com>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In walk_pte_range(), we may modify the pte entry after holding the ptl, so
convert it to using pte_offset_map_maywrite_nolock(). At this time, the
write lock of mmap_lock is not held, and the pte_same() check is not
performed after the ptl held, so we should get pmdval and do pmd_same()
check to ensure the stability of pmd entry.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5dc96a843466a..a6620211f138a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3396,8 +3396,10 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
 	DEFINE_MAX_SEQ(walk->lruvec);
 	int old_gen, new_gen = lru_gen_from_seq(max_seq);
+	pmd_t pmdval;
 
-	pte = pte_offset_map_nolock(args->mm, pmd, start & PMD_MASK, &ptl);
+	pte = pte_offset_map_maywrite_nolock(args->mm, pmd, start & PMD_MASK,
+					     &pmdval, &ptl);
 	if (!pte)
 		return false;
 	if (!spin_trylock(ptl)) {
@@ -3405,6 +3407,11 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		return false;
 	}
 
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
+		pte_unmap_unlock(pte, ptl);
+		return false;
+	}
+
 	arch_enter_lazy_mmu_mode();
 restart:
 	for (i = pte_index(start), addr = start; addr != end; i++, addr += PAGE_SIZE) {
-- 
2.20.1


