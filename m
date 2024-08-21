Return-Path: <linux-kernel+bounces-295109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA3C9596E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1771F2526E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F308D1B1D41;
	Wed, 21 Aug 2024 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JguoRKLH"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199B199FA3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228402; cv=none; b=kuG1no6VgQl8CNzuvf2eKhHef3C3Jsg+e6pOPaKH/lrbqaRrb9rq7K/5wWn8nNbNTOcjIhIoyslohnzozHRklIYX22VFECA8w4sSfDoCjaZyIp2NnTZsVdagNcmhkZiay/IIktpd79BWax7Pidu4DHPlYAkIUWXItNFUhVgDdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228402; c=relaxed/simple;
	bh=bPoIcZSmQoKSl1mt0GTa8HT2fvR5BUPjDUZk6CLI5r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSCNNy9RmNuDn0wizpW8iBowUiyK/uWyX/sBDO0FElm36fVGps4mRw8JuX/iuMAJ47244mDKibrc6/T0vdC5ydWqo0bAzQrKRM8jNOEgyn9ghPiy6cSn3PRWkO+bRIlEKen4uBaKBZjtaIR+eEC9LiGC/lZdRZqRLsoLUoNQgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JguoRKLH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so117815a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228400; x=1724833200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWBymtmrK19rfh+o6mKAIf3qo5pwJHde1CNDuWd4778=;
        b=JguoRKLHodNuG6yyL3Vi4vpX/EsgpPP6gbPWkHCLf0leT9WJzHCmMD/Yn74Lp0/nW1
         6xITO+e6JtSwGNWdPomcaDOaOWJxyTejR50Mrbjzreh0KBOg/Tnzu+E6Jyhtoqc3J2wY
         rPM4FNauDsw3w3k6jJ1TD4jXM+2hhgL+uPMjVbYxsjnCks01GHQt+nliQScLLf1doJbg
         DrrQNZOSqBsvmQPuY3aquE0txgCCecWwgUJNGc2VgU3EAY/o5BAo48Wd6+Ukm3bWKfFF
         mVfOmYvh9hHmSJGPlBVMdjMahDHRzdVacCtCMhdSx7DwBgAgVH/4AwbJpDa9n59PrZ9/
         rZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228400; x=1724833200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWBymtmrK19rfh+o6mKAIf3qo5pwJHde1CNDuWd4778=;
        b=pPfVUcmnzOM/gfHx2ZloTqPaHSig4DNzhwEVjZDuaaw38eMLOSTFWjitNYDFWVg8/V
         uiyN3rBoakBejX/WK7vDsEku+sbj5WhIyVstljuhLiEDWWB05gZCkKz6lgH9zD7Bk52Y
         Ie+titnlKV94Qz0c4XHb8Q98PzEqSNhWavhZuK93n23jL79YauVUr0FJYmf9F3Qdeomu
         eNj+Q+YbNHLZcqskZUdz+hcmJg0T4nmtzyV6CKl0Ll1wsqgFvoUcC9UmhvYbKa0Uz74v
         LbPpg60B2sbjxtQRNXIM6JOyDCywnMCNSeqz4FmXMl4oXgkOoaC3Nsvv/rNOtb3JQQes
         XrVg==
X-Gm-Message-State: AOJu0YwRZjBzKE/xcdL/MWaGEv84WUSyvteEV6wpIR73PUjIxBzskgP/
	W4SZifz699S6QPZTFUcmsJe3QVFSrjQTomMZgmnDPKOIFNXKJWNqy8PgZrGc154=
X-Google-Smtp-Source: AGHT+IETLNjbMtdResL0gCQrMShCwCpeGL/L1zL6e1zJRM+ER4woSJMvk4wtR2Cz+Z4m4+aIJL98tA==
X-Received: by 2002:a17:90b:4c8d:b0:2cb:50b8:e59d with SMTP id 98e67ed59e1d1-2d5e99a5e05mr2805975a91.12.1724228400217;
        Wed, 21 Aug 2024 01:20:00 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:19:59 -0700 (PDT)
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
Subject: [PATCH 05/14] mm: khugepaged: __collapse_huge_page_swapin() use pte_offset_map_readonly_nolock()
Date: Wed, 21 Aug 2024 16:18:48 +0800
Message-Id: <e920b08e92471a5a3601cc463a3cf6a1254353e0.1724226076.git.zhengqi.arch@bytedance.com>
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

In __collapse_huge_page_swapin(), we just use the ptl for pte_same() check
in do_swap_page(). In other places, we directly use pte_offset_map_lock(),
so convert it to using pte_offset_map_readonly_nolock().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cdd1d8655a76b..26c083c59f03f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1009,7 +1009,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		};
 
 		if (!pte++) {
-			pte = pte_offset_map_nolock(mm, pmd, address, &ptl);
+			/*
+			 * Here the ptl is only used to check pte_same() in
+			 * do_swap_page(), so readonly version is enough.
+			 */
+			pte = pte_offset_map_readonly_nolock(mm, pmd, address, &ptl);
 			if (!pte) {
 				mmap_read_unlock(mm);
 				result = SCAN_PMD_NULL;
-- 
2.20.1


