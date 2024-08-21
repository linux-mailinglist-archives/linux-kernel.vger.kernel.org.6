Return-Path: <linux-kernel+bounces-295114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB819596F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B384B1C20DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA34E1C8711;
	Wed, 21 Aug 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Od+7Pb05"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B291C86F2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228430; cv=none; b=oZFUW9qKMzY2hLUs/XJin94wA+07vE6m9JPWougIMjwPTk2u9FyHDT8ZGUq5GmUbH0O6nO95y5yND4XQCgYVHKA3zuFSHisjVXhNaJ4CBoJ2wRAsIEx8SBLkHV9EvAXxaVAj1nGasiXBdBhs/w/LV0cXpM4udVzpfRobekjo2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228430; c=relaxed/simple;
	bh=jJszyVjKZJbuadp7xF9NHpuk6YVJlOW7Oz98iizgmSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPYjsTL6a4cewM5kSixvwGWKe7h4BE5UWZnjSsYMdck60Kaoot1wC7wv+M8ZhifiHuHQnmY6WPZ7ruaTc80zvocUNIctA8JcLHChaNzxtKduQaAQRDftAqJa7hJ4MMp5qSHiPEKGSfrSOCu5M7VpiQEsVZRjN9AkP+r+FU+bdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Od+7Pb05; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so4458448a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228428; x=1724833228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wf5h3KMWWmEe6/3TeJpf55VgCdFHsYKNAkaT296AWg=;
        b=Od+7Pb05nM6n3TsGPEM1lc7AiZhNj/DX+/24kh4670eLmLMqiondESy2iOtbzjvcaH
         Wu16UTtLr0DWcPL66tslsN8fb1g5+svA19UGOfjeVGDjI5zIa1bfSTKjgEW4goEzxzZS
         SxgA07Q2TZjbtYjs5rFuzJw1M0gmYK7o5UwFwPNxdr9etCQnKyIyYwS5QqiL81BM+yj9
         jZqO/osAG3bmOQ4GxtSXA2+JT05YupQ50G3LAzdKMyysnQPkeOJzTS6X32HHHQznxAwh
         kZbD9fH15jUODV1cToXbeEsG3GFObqqshh8jqPCMczw0yOIlKRVZL85mun6f5Hiq/9lE
         Z3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228428; x=1724833228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wf5h3KMWWmEe6/3TeJpf55VgCdFHsYKNAkaT296AWg=;
        b=lqpzzwKvaiVjlSdJaIo9lmk2qnRv7aev4CfRuZLA3boW27700xoq7rtNOsCHOSWNuh
         E2ALnxsaJrOSEKeDSigfAmrJvdrdz9o0/bfO0niBIgsBFAdFSHtAXmfojICzxSqjTTsQ
         y/R4ZsM6DG01h+xhTrD1cZ0K3a1Xb2PKdsQj/TvLFq9IDelaVXqLKRI+CCoSgD6d/DT4
         Dk0VZYFzycxJ/EwFOdRdOdycMTW81aFj9bm8Kz2aYw0vXxIiN2W1Kq8LJtcMEbByQgND
         ppxQmS//oejg6VG9sqktIwTt4p9cbEEwQQly+JK3wna2iMMoHNpe+UzinURN3oJ1OEZW
         /44w==
X-Gm-Message-State: AOJu0YxIGo4SN5dxoTx1B3b+r/2K/zWI+daRWS4PjcTvFNEpJsgxEHM5
	Ae5VCHIwwVn/loXKuqjTg12a0wAE9F4bSMlSB+pHa4ZYTTq7xjksXB+xUZ/d2as=
X-Google-Smtp-Source: AGHT+IGct1lfg7s+Av92JTuFI7wGr/k4q1ybIYiVEVcgmdImld0nRYlRbV5Vh9eNiEYSyV0nSbS/hA==
X-Received: by 2002:a17:90a:7893:b0:2c9:635b:7271 with SMTP id 98e67ed59e1d1-2d5e9a24ea2mr1616047a91.21.1724228428100;
        Wed, 21 Aug 2024 01:20:28 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:20:27 -0700 (PDT)
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
Subject: [PATCH 09/14] mm: mremap: move_ptes() use pte_offset_map_maywrite_nolock()
Date: Wed, 21 Aug 2024 16:18:52 +0800
Message-Id: <89bd1d48db1986ec83dcae228defa748f38238ff.1724226076.git.zhengqi.arch@bytedance.com>
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

In move_ptes(), we may modify the new_pte after acquiring the new_ptl, so
convert it to using pte_offset_map_maywrite_nolock(). But since we already
hold the exclusive mmap_lock, there is no need to get pmdval to do
pmd_same() check, just pass NULL to pmdvalp parameter.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/mremap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e7ae140fc6409..33a0ccf79c32d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -175,7 +175,12 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		err = -EAGAIN;
 		goto out;
 	}
-	new_pte = pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
+	/*
+	 * Use the maywrite version to indicate that new_pte will be modified,
+	 * but since we hold the exclusive mmap_lock, there is no need to
+	 * recheck pmd_same() after acquiring the new_ptl.
+	 */
+	new_pte = pte_offset_map_maywrite_nolock(mm, new_pmd, new_addr, NULL, &new_ptl);
 	if (!new_pte) {
 		pte_unmap_unlock(old_pte, old_ptl);
 		err = -EAGAIN;
-- 
2.20.1


