Return-Path: <linux-kernel+bounces-431054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BBE9E387D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6D21618A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15E41CEADA;
	Wed,  4 Dec 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bh6for3m"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E81B6D1B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310682; cv=none; b=jq6YuM9Zg6t4Qv9z9BOJL7cbHOof2ZkAGQ/qls1ADKbrJT8JBa8loRC+vOQIWksEmccPt5UpXDWBZrWMH5r+ZEqLxFnjUN+yyyXfaKuOByDtkVqTsycqGGt1lFQJVXVIVftr99lJ7mS1RSxX+dLSdAoz5vJU9oNosiEJ8dMRCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310682; c=relaxed/simple;
	bh=1lQMPd0BbclJorppW+dGp8eaHmksS0ywZIvax3ZYyUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U95HSkni0ARgdXISR9NgZfEWDek/qRlKzSa5HIy6zfH4E/OBbNgi+4TI0WXN/uJvR/sYkPf2pRAPvvwKc5Cy3kFDw/tpTZnjIzbh/CHOiJMIMQEKbvAsXWT6fbvD5yeCe1VsYmv3A+N9K4ysBelYqbbbvrWL9//r/Sd/ga3ggQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bh6for3m; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-215bb7bb9f9so16672485ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310680; x=1733915480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pv7uitRReKN+1XEtzxbevTSt67jmAqoi+0p+H++uGg=;
        b=bh6for3mkxnhUw0u2Eho+xz9yz092xYy5H/46Nd/eTGt6DVza2U4T3jTWEkVLuoXlM
         mktqD8U1nxCQE7XZF+0kzJPuC4eE1CvFCDfczFQLvabc8i1exBJjbNOsP3eQ96TgE+Tg
         RJH5oqXQHY8jIXH1NZ1eeYHE0cEKYw3X0enDSEAAZ7dJLSv6hNueDI85jJq1ghwBd0Dl
         wNDwQO4QWuVTlFm7YEzNgpL5ZUcdV3OsdKfE5akeqJmsGF9+oy5lKkv3FkXbzByNAXNg
         8a20wOQJZJeVx4oNUiBRue/99eVI+itYu3/YtzzSXvmfSrF/C3AQq+MqQ5BJvH3hQ2ym
         g7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310680; x=1733915480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pv7uitRReKN+1XEtzxbevTSt67jmAqoi+0p+H++uGg=;
        b=JWAaLuquOhwPIQKHUqG8hQBLvxw69EByZeatPlcZfgMPVwcRn0LH8swkabgcA+5iYO
         t2vLiP0z7wCIkbMi2tqWpIKd1mJLcDGM9xY8wTJJM4v7cP38/iY7BTHFGGxNyLi6G7vO
         mLuTu5TbvL47Tt+12YNXUTmqQyW9/EjiN/skS4qLvbsJhshNmaNpFGqHDb9akRIniJjK
         Gaiij4r1/a27QoAUi84MNwIvUS3IOZhbaCQlHby0rn0pzEWD4B56DuxZjRjLUKuOuJqq
         c8BlhTDTBWlsXVFXjXZu8oFYU6NTiRbKrRsC/pWHsz4OlfBPdNkaFfHBRISjGkg1aFSb
         Sj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOefLGh35ft96oZN4vB5vkaza9vT2Bholy5LIIBmX3VhNuDG/1JkJII9Dhfxy/N8bZxP/knAjyOFYcqbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgW8497FoT4i/Muyp1DYGtr5sLqWDlU1j0Gyas4BParCOIim0e
	8YhQ0ejnDeWuaDPxS9mT7LznEasGMp0OeVxesDXFZgqjJzwlUM+vTh/CJoi3xaYRfrMsUlSUpqV
	b
X-Gm-Gg: ASbGncvRhcGnSGfNsBbBw91ZSgLlsvkKpay44Yf6M9ZqYOskcXmRcjXH7HelClP6XvM
	4iWXsq6SQaCRzAPvSSUgfqQGpuPL48QMsS8ocC/5Lj0HYiVJ6pLVaZIV/VqaPR4GKgTX8q+Qk9D
	PdDH7ZY7TOc9nftlmZCHIGbFgmPXyhDX7n2jh7sbhy0u/65IZZVm9cZEmK8nt52C0LPM2+zP8bd
	4hOsL90Z9/gqWShsv2P8/LNzjsnyHLSPFVo2nqjg8Bw3XZHXON1ho8p0yUPme8A7WH7sN+xkUG2
	Dw5r3AzJ42sTL/A=
X-Google-Smtp-Source: AGHT+IHbc9xNaqbbB+HahdZkvlcNVEtw+zco1U61JfjC0HrH8ZPfSYoGTbGPdGo4pnmKoLHl9UqICQ==
X-Received: by 2002:a17:902:f712:b0:211:ff13:8652 with SMTP id d9443c01a7336-215d0050dfcmr58113365ad.28.1733310680194;
        Wed, 04 Dec 2024 03:11:20 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:11:19 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	zokeefe@google.com,
	rientjes@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 08/11] mm: make zap_pte_range() handle full within-PMD range
Date: Wed,  4 Dec 2024 19:09:48 +0800
Message-Id: <76c95ee641da7808cd66d642ab95841df4048295.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
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
Reviewed-by: Jann Horn <jannh@google.com>
---
 mm/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index fdefa551d1250..36a59bea289d1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1718,6 +1718,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *pte;
 	int nr;
 
+retry:
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	init_rss_vec(rss);
 	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
@@ -1757,6 +1758,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	if (force_flush)
 		tlb_flush_mmu(tlb);
 
+	if (addr != end) {
+		cond_resched();
+		force_flush = false;
+		force_break = false;
+		goto retry;
+	}
+
 	return addr;
 }
 
-- 
2.20.1


