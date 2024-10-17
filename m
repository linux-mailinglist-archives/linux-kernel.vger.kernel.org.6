Return-Path: <linux-kernel+bounces-369558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A349A1EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619F0B24E04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12CA1D9A59;
	Thu, 17 Oct 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hbUyKZKs"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E671DB953
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158484; cv=none; b=j0QScizei6Fhrxl1vhRlnk34m0it21jUV4uZK6YLmS1Ou39sb7dalWNA3sN1omGv/fu1uNKWiEhBaCCznOM5H+r2Zpfgm4VlDmoANUGPeFMIl4TSi+EaULYlSgorT6hFMqK7mJhCO2PhykThJkxn8UQqRIkIAuApivqwNdT2VDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158484; c=relaxed/simple;
	bh=PuVSu6LbH9IyVae19F5YhUQxNt5tQRY/J+tLwJFocQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2ZS23OY1EGMJT4NiR/r81MfkWkKujFOGbu+vBB8EYBGICATj7DhHcq/MrRC9UoMbCSFFwzD1zEmLvGwhuAZGSSQdFcHyeKU/+1uzXCpYwtaU3i2ibRqmiGJImUtXWMM7vo1l5GtKoM2KI4j852QJ5UnZsNHUfdnAX0Q/BGo6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hbUyKZKs; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7db54269325so628091a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729158481; x=1729763281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKkeoST6I/bkefiDvyHuFZOvKUoGTogE4tqpFCMcSq8=;
        b=hbUyKZKs/kcqIUDmsmEHh7ZfkFWBmewxmJVbvMdpIbIMPyHm4IaVeZBSH+XD4DHFRI
         pLUbOV+utVwr8fqoK/IqmUXFnDb3d/VlFwS+cldikXu+6uiQydPSUFwfSO6cMpA3ITlt
         CDayg/pmV2UnXBO03UMIVV+S3sSpVzE9GfQxWV3tSe9942+AwBgHTuBadwr97Q78DYpB
         df/lplUYYfscQxUh4GtehdPEMJbbQhzSXkDxb7QZxlpVAYslP5D7Id4Qle7vKD4rFWtr
         OmiDJD60oyM6O6ZvtuEc9trDdGKsD0GF0offthl2O4aWYMO90/kvORxFpBSrkVw1UZMP
         5xhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158481; x=1729763281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKkeoST6I/bkefiDvyHuFZOvKUoGTogE4tqpFCMcSq8=;
        b=kTT292+ZFc6qDIKxsuC4Fv5midk8728heF1/pNNqGCHVdwaYX2/FWl1uJDCgO327xy
         kzhVS6p9urF1uEk6R2TTILJURB37xoEtqptkvKfk8DR0P+u2yQhEaa85vk8q+unrI9T1
         Qu+O0d3M/fN+TEh5wTi46vxP4FY9LhmbPVGTWGLhrSUGuFe70EXZkwTuWNGx3MCiNM8Z
         bWZAxubsPbSlKjDf86ZAIEgLaSELEHTJCQGM1t2AH4KsI+7+jPIvfk+aWTiCv9J6jrZe
         bMrycvD6d1LZxIMSbEhoA9w9Un2IostDKaqVViQHapHDWkp3hm0wGmop1HLrOC670E0F
         jSow==
X-Forwarded-Encrypted: i=1; AJvYcCU2b95i7dBrRdW1YzshsGixoa0CN9oiUu0yB5PhcrtivbbMgw7D6EhhjNNylcAH75ys7BdtqkkMtZkkKeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTUHdJWQeyHrfAuIjK08OZF1c6t9c6jelIAuYrTQpqGHTeRIp
	MS5GGwgxOnjCOZRCkDbEoHoQTbB0lskp7INXL2UGBcbiE5Z362Y4YA5nkUfLIKM=
X-Google-Smtp-Source: AGHT+IEI5E0ziycErtAHmWC08AA6d27vlvkOtexRBD8N1aJkqSz6qnPieAM9Lamrn4x3BOyjY5wnjQ==
X-Received: by 2002:a05:6a21:3998:b0:1d9:21c7:5af7 with SMTP id adf61e73a8af0-1d921c75b3dmr1710778637.15.1729158480809;
        Thu, 17 Oct 2024 02:48:00 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4218sm4385365b3a.120.2024.10.17.02.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:48:00 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	jannh@google.com,
	peterx@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 2/7] mm: make zap_pte_range() handle full within-PMD range
Date: Thu, 17 Oct 2024 17:47:21 +0800
Message-Id: <cd03a570f23e67016d23c3aa27f5931715570416.1729157502.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1729157502.git.zhengqi.arch@bytedance.com>
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for reclaiming empty PTE pages, this commit first makes
zap_pte_range() to handle the full within-PMD range, so that we can more
easily detect and free PTE pages in this function in subsequent commits.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index caa6ed0a7fe5b..fd57c0f49fce2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1602,6 +1602,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	swp_entry_t entry;
 	int nr;
 
+retry:
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	init_rss_vec(rss);
 	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
@@ -1706,6 +1707,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	if (force_flush)
 		tlb_flush_mmu(tlb);
 
+	if (addr != end) {
+		cond_resched();
+		goto retry;
+	}
+
 	return addr;
 }
 
@@ -1744,8 +1750,6 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 			continue;
 		}
 		addr = zap_pte_range(tlb, vma, pmd, addr, next, details);
-		if (addr != next)
-			pmd--;
 	} while (pmd++, cond_resched(), addr != end);
 
 	return addr;
-- 
2.20.1


