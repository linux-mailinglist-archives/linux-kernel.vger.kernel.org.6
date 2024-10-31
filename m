Return-Path: <linux-kernel+bounces-390150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE79B7627
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ED11C21389
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1AD15534E;
	Thu, 31 Oct 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fsTeXRU0"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F6187323
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362474; cv=none; b=MZXrkkWQ4eY0MA0IP42Pr/PSC98rqTGjl5YR7BIEfgKZOGfcnE/AujNgw/XiNa7M0Wz6hAMme/1VwJdSW8ngefBFTlEzeKuRHIzXWSCjbn1miJsOs3hLBghm1xfo3tLsvm3K9ksGKL+uzmi6C6njadhGGkJ138/EozWdwWIMFU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362474; c=relaxed/simple;
	bh=8PV9Chaa8T7WeXJAYQ/SP4YBbi1NrEJGvTUgFb1bqDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZSrXl7mbe2hQ0Jdh54OyvAeYCXXQ/PFO6CDUuBI6WoPoff/S6nB5hvN0CPrUGFjX/0HkpLxP4kLCouhoXwCIrolprQxCgCjAhgOku1ktziY9iB0+xOAyva/auL59to87o4I1xvOVIefBClRXoHnnINiKVORRRQhwT+cN9eu4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fsTeXRU0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so1354736a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730362472; x=1730967272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXIV/VGyywoEEnyyPnCjvRn11K4iZ53lY17h1S4nRMU=;
        b=fsTeXRU0cMHgMtYycW0HWy0X3ztgIyIyYEF2T1G+19xVLL6WslEewpYkwNWEt0kAoT
         T/BMg7N1uDifbMHG77UIlKmfFnC1ChDSZ6wgEM6q4ReE+VTinr355Kv356APspUwbjpK
         2650id3cOCewMgSxGzr3GgYEylQc3RTvvcNNDXDxStV5Ba6Mi/z1RawM4cr6AlWmPRfF
         eOsvzTh+Vibi/dKAs8Ulo5OiPDSa+8i4n8xMAKF8JpDOH0vbw8ZNbQCQyOVUk/W7ni0W
         dqLFcXpJS2WetvDAyXNvgN5piEDrxhDUghuLG4ADy4CjM3nibrmDL2ofXZj/j0yL2/Nv
         Jp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362472; x=1730967272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXIV/VGyywoEEnyyPnCjvRn11K4iZ53lY17h1S4nRMU=;
        b=J03siAjM86Gap5HqDbcn6t8ibLFPhlnrlg5+n6lH2oxrRPn8uKZL6WgUxH4PKTCpBZ
         AO4ul66Ed2gNheOuOgKC/gY1acGlTkLbx2A5qa+ATEVYJerIVt8q5QuR80VnryuDxPX4
         B4yuNqyvDZVTXorxX5e0V1L3+pDTOgbd0RC7uKuZfDROGK5Iwn4xtuLz2DDECKHRS3l7
         I9qkgGHae27Lq8SUjQOzkq1yyXKxCJ0b2ndNuPA+G5XkGNfJ+XP5ahjhzXTroZpScTur
         4IFD88nf6feFLOox7MAAyrbian2NiSm+GjwcaG2iOTdP1qtYXOkG5vz19/FxxIGtCbKc
         iXPA==
X-Forwarded-Encrypted: i=1; AJvYcCXNjlWZbFpN9r+rxQ6sYm9nEFVq2VICI0Rylk1P3cMUvRVWSk97enP8UbXuVugqX7hnTYdUdMXTW2vN8WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5eiaaN62p2w1h69Vc1ZurnpQo+tRqtuix4VflxmJHVODyI17C
	BWg00aNyHkXNNoeX9Wsu4e1OSp2iLzcuQ2cOmp41HEQLeobLEeFqrjzalHRFqkY=
X-Google-Smtp-Source: AGHT+IHX23XnGunJsTXB9lUCwZL9x2plTKY2+aB5lG85OOgVbjA/C6wsUFYSS/R0cYtYXLJhUsQsBA==
X-Received: by 2002:a17:90b:1b4a:b0:2e9:20d8:414c with SMTP id 98e67ed59e1d1-2e93e0139a2mr2423394a91.5.1730362472334;
        Thu, 31 Oct 2024 01:14:32 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9201b2586sm5163996a91.0.2024.10.31.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:14:31 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	peterx@redhat.com,
	catalin.marinas@arm.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 4/7] mm: make zap_pte_range() handle full within-PMD range
Date: Thu, 31 Oct 2024 16:13:20 +0800
Message-Id: <63c92f1e2a2fa6267490ab9fad5b090316b39b98.1730360798.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1730360798.git.zhengqi.arch@bytedance.com>
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
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
 mm/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index c1150e62dd073..002aa4f454fa0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1691,6 +1691,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *pte;
 	int nr;
 
+retry:
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	init_rss_vec(rss);
 	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
@@ -1730,6 +1731,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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


