Return-Path: <linux-kernel+bounces-431665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED49E4029
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449E2283859
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC120C49E;
	Wed,  4 Dec 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cthRSbL8"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7138D20CCC0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331339; cv=none; b=YLEjrLl7XYLUbhwisEE7YU4JiV7dfO16MYJaqMwRnLpoex/rHH7qGYbbp01jyuwiQC2x0QrJAjegDHLeBcU2T+nK7ECWhzRANS/e4fLm3Z/fioDqotxLK2ALNd+nGTGfGv5fimZg4fkhxJpzNpeZKJPRtlCJj4snKoi5O7mG6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331339; c=relaxed/simple;
	bh=1qgZPwN8z2NZkdJKFInHrqOxsHWmrEEqV/5xcYDRxeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPZtEbPBuuuA88Rrm0Y5/gdg+E9CTpFh8q2MjdaS4g7vx7eS0Lon7ZOM71bndJS9fdw6vSy/TOWO1XcEQ3r9QIPn1/vPJxtYBhwKIR7hrU6zMR1kXctl7+AAt/6fI2b/NkXyCvPuBeQaTQVgqLe0M66TDltUW76uvDcy+VADPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cthRSbL8; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 325103F5AA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733331334;
	bh=OfRULcgbj9969PfzAEC+2ztALegozxLXhupgdMLyKBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=cthRSbL8FKr9XhXk2YWELkP08l4End9Y0pXUMhjXWFTj6f+Wd8+Zpv82UtVGtV5fV
	 tLpSvxXRPVZyxrYNrDhTbigr0Gy20K60M5PIjka90GNpnwSqzvGncvK+H/QcR6pCUe
	 G1aRvhnTT1+EYSbOsvuUoHlYIkdExlc/ZIk6xGIj4ZRzQpzY4eXM/x4Xd5qV5K/vUC
	 5xU0s388xo74gPhLOhrNchu6kCGscE1x34iOq02VIHED8idiDDK4jJVSEVbvDUvtoh
	 lXl+uQca9v9BFJncBHxUuvgKenMDs/P8sHqwc42rzKm4YD46BHanETpUjCdMdGHW0x
	 uqnQZBsCgBoQg==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7c6b192a39bso1426a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331333; x=1733936133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfRULcgbj9969PfzAEC+2ztALegozxLXhupgdMLyKBE=;
        b=hsav0io8Hc4gk9kpihHHkxSD1StkprYJwZnYpQK4dAVLJ27uAOUf+52IXO1MKcuJOa
         jmnE7qD40WT+vXqG1Nev6EHI3SGYPiV7XjF/GMTXzTYxCAuBmz7P8ovktCOck1xQKeic
         MgPCIdRrmcwLdt4yhh2rhAqiplgCilM4GMxzLG++vSWvq1M4BBJZGv0aboVqkrM3/H42
         E1m2F5C4Ir2j6eTNbd1RiX+3pabj3VGWvaDAo10/oESdSczHG/2V/zmJSHxtJTiMcBt0
         API4kJfz+aXamMafE6QXL5rOy1SHWrhqqwLLyO7XRO3KhtFoRzczQoEWJi3oofxXMuGi
         Ra1g==
X-Forwarded-Encrypted: i=1; AJvYcCWvSz0qGxBMJ28oeZIdc9PcaPxuHPxCHMgPZp2MP8Wz/RFAcwADCbYX8BdYu5UD07J2V3hLQ0sJytAtFtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWGb8m40goNBZ6SUlzOOqce1RYiavPNEWHFmi0Oex/Mnb4/Rrb
	tEV1TPjMByPsIWqaZIrZUQigpK0Z0aVMZbhZ2XOvrG87seq5/680/8HCj2y3oPcjWGWkf1cw+Ck
	PWRMCqSrNvXfxgdAohUmprLBa1flLr6IMpC6EFnCOwBSNqDUPKEJb0CKNb9+RKbX8kP69mDZbZW
	1jwQ==
X-Gm-Gg: ASbGncvXZUgLv32adnRlFjcOlLnElOQdxoaDhd09Rc1jB8MgQV7ctnnX74XV8TseH5Z
	cBWpJx9Riq6rxEVuw2Iqhq410//x3akYemZWlpdgKggRP7SDkAkuF7YMO/nyNHGLyQTG2PKRdck
	2qOxh/waxFe7gDUCKIFpLfp/dJwDKtlkXjynnMozZFEW7lIwftZNgSiF4SpoobZY+UhWdsDb1eI
	lmzY9PTqZVE3alrwMPvw0xBIzw3QfRqbMjWVQSxYxddKF9KsbA8NTXfKBchBGa3r0cx
X-Received: by 2002:a05:6a20:12c3:b0:1db:df34:a1d6 with SMTP id adf61e73a8af0-1e16540f49cmr12044202637.42.1733331332752;
        Wed, 04 Dec 2024 08:55:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbPPD/q7lir5PlOM4kjQV6wuhK7NJGmbnDCRqclPQUWXh5pL8q/YacWxwvE4iN90uUp7L8gw==
X-Received: by 2002:a05:6a20:12c3:b0:1db:df34:a1d6 with SMTP id adf61e73a8af0-1e16540f49cmr12044176637.42.1733331332413;
        Wed, 04 Dec 2024 08:55:32 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fcfac85434sm1394687a12.21.2024.12.04.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:55:32 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-mm@kvack.org
Cc: muchun.song@linux.dev,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hugetlb: prioritize surplus allocation from current node
Date: Thu,  5 Dec 2024 01:55:03 +0900
Message-ID: <20241204165503.628784-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, surplus allocations triggered by mmap were typically made
from the node where the process was running. On a page fault, the area
was reliably dequeued from the hugepage_freelists for that node.
However, since commit 003af997c8a9 ("hugetlb: force allocating surplus
hugepages on mempolicy allowed nodes"), dequeue_hugetlb_folio_vma() may
fall back to other nodes unnecessarily even if there is no MPOL_BIND
policy, causing folios to be dequeued from nodes other than the current
one.

Also, allocating from the node where the current process is running is
likely to result in a performance win, as mmap-ing processes often
touch the area not so long after allocation. This change minimizes
surprises for users relying on the previous behavior while maintaining
the benefit introduced by the commit.

So, prioritize the node the current process is running on when possible.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 mm/hugetlb.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c8de0f5c760..0fa24e105202 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2463,7 +2463,13 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	long needed, allocated;
 	bool alloc_ok = true;
 	int node;
-	nodemask_t *mbind_nodemask = policy_mbind_nodemask(htlb_alloc_mask(h));
+	nodemask_t *mbind_nodemask, alloc_nodemask;
+
+	mbind_nodemask = policy_mbind_nodemask(htlb_alloc_mask(h));
+	if (mbind_nodemask)
+		nodes_and(alloc_nodemask, *mbind_nodemask, cpuset_current_mems_allowed);
+	else
+		alloc_nodemask = cpuset_current_mems_allowed;
 
 	lockdep_assert_held(&hugetlb_lock);
 	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
@@ -2479,8 +2485,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
 		folio = NULL;
-		for_each_node_mask(node, cpuset_current_mems_allowed) {
-			if (!mbind_nodemask || node_isset(node, *mbind_nodemask)) {
+
+		/* Prioritize current node */
+		if (node_isset(numa_mem_id(), alloc_nodemask))
+			folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
+					numa_mem_id(), NULL);
+
+		if (!folio) {
+			for_each_node_mask(node, alloc_nodemask) {
+				if (node == numa_mem_id())
+					continue;
 				folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
 						node, NULL);
 				if (folio)
-- 
2.43.0


