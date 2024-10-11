Return-Path: <linux-kernel+bounces-360730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49420999EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC931C22DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F120ADE3;
	Fri, 11 Oct 2024 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JopWxbUh"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C020A5D9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633956; cv=none; b=thAmRvY1zGpJxH1Mk4hG+OsxcustFgwZHW4zuwwpor+Jat2yPNO3PNC9tdsYtfF17Q8cjyN5dD6imnFpHYwYV9kqg0UM1cQYhpcobsobaLRRfEiAh5nbNW4xUP2AgWWGI/TSwddIDdgG0n18I3u2WXdrxLWd3wDEsXErIJi8CVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633956; c=relaxed/simple;
	bh=Z67+iI2hSrIPj2oHFuxqCUY/2/HpoC+2Pkurb+74nTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JYzD8O4gbSVNBMAeqPmPpnEi/S13qkyvDTD5rGz+TU4oG81dmxKdZaC4msEq+fjFbKxmKNbZMa/3xCVC56feCFH+TvRTkNauoMg8ev3ICbI4U2u7oR15wC56k8GJga5II/mAFHWuIatGBNBjkerR/TY3kYxu2PdWYISGqFlJO0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JopWxbUh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71df1fe11c1so1498004b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728633954; x=1729238754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cyTFlm4m/KDy5BUSGM2UwZPLgDsNUyTZVqJf5DcscI8=;
        b=JopWxbUh8GMYH8VTK8Dv9+r32uup7Nh9S1eTw2jDaQyabe7KS8IfXerq3+OZqyKtAv
         hqGo6oMAhNhT82f7qHoSGte0IaoOW07nxEJIIyIoTSR4P6mrf3lBMlVLniXfhNCl6fkX
         SxfTJzFsAe7+sJ8Ethw8HTEjrLOzLe1RTPj4/dDBNxR5Vn4kTLC+8CzLNvos83HWai/P
         0Up2sJ/nkvP8FjgxvMv0+zRf7wpnWkICTSvSF7MUjAhUxtjXd7F3BPhUL2WD5GjjSFCk
         BLhGX51Nj63WxYAFvWfEQfmUcMfKbtvw73fTbCLiwLwW8LiIIDZ1grItk4CVnZcl7j9O
         n2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728633954; x=1729238754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyTFlm4m/KDy5BUSGM2UwZPLgDsNUyTZVqJf5DcscI8=;
        b=j9wjfnmMLF4cgEIMReujjDktDC1s2eV9xlJZVUy8BAceUDPDbLKOUOdY7yLjwJXkbf
         hw4mifWCLqR0ouimap1E+4DWCQgQmRdopeaUKyuJew3we9CEVQHwNt7bPfAjSPtX8DjF
         yUdFcd+Jkd8vrWwD0qMqCbZQBhPQWdGMHBBwDRCJpULTmJ7VQ6Mjo9IyvxDVCGBrV21q
         DFeNqBPmgHADLMIGglSR5Ow5aKj4NHeIcV6A3/STPAj1G/HjSHHYhim0SemF5Q23vvNQ
         RuY4pjpjbY1mW9QuE8ppjLBSfRDXTMzzX0cPodkfNy4//h9CKbqn/K5B0j2eiJbByFB/
         wIMw==
X-Forwarded-Encrypted: i=1; AJvYcCVAvZWub1iGSYiarfZbOKLAiFAWDuBSQF/lYoraZx2H7oC5DU5JERKeA/nZIZH5lm81xyaubKmzvdfGTq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7pXbKgoyA/oNRz0oyy2TitJetlTUM9iNkF61LUUqv7PvbizG
	W2KdMgvfW8O/rJniRXDd4QlTenf1fZuZwbMMpzTjoYFP6XAUlVrJ
X-Google-Smtp-Source: AGHT+IEPfa7gZvPRyo8ByepVRETQkhFpHB8/vsFkvFzynMFqH7IIfh9guYjrHr6K/nM9x22xyqa83A==
X-Received: by 2002:a05:6a00:3189:b0:71e:3b8f:918 with SMTP id d2e1a72fcca58-71e3b8f11eamr1354871b3a.7.1728633953799;
        Fri, 11 Oct 2024 01:05:53 -0700 (PDT)
Received: from suhua-virtual-machine.localdomain ([36.112.24.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab10205sm2131409b3a.220.2024.10.11.01.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:05:53 -0700 (PDT)
From: suhua <suhua.tanke@gmail.com>
X-Google-Original-From: suhua <suhua1@kingsoft.com>
To: muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	suhua.tanke@gmail.com,
	suhua <suhua1@kingsoft.com>
Subject: [PATCH] mm/hugetlb: Concentrated releases memory when cmdline specifies node requests for large pages
Date: Fri, 11 Oct 2024 16:05:43 +0800
Message-Id: <20241011080543.2422-1-suhua1@kingsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When HVO is enabled and huge page memory allocs are made, the freed memory
can be aggregated into higher order memory in the following paths, which
facilitates further allocs for higher order memory.

echo 200000 > /proc/sys/vm/nr_hugepages
echo 200000 > /sys/devices/system/node/node*/hugepages/hugepages-2048kB/nr_hugepages
grub： default_hugepagesz=2M hugepagesz=2M hugepages=200000

Currently not support for releasing aggregations to higher order in the
following way, which will releasing to lower order.

grub: default_hugepagesz=2M hugepagesz=2M hugepages=0:100000,1:100000

This patch supports the release of huge page optimizations aggregates to
higher order memory.

eg:
cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-xxx ... default_hugepagesz=2M hugepagesz=2M hugepages=0:100000,1:100000

Before:
Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
...
Node    0, zone   Normal, type    Unmovable  55282  97039  99307      0      1      1      0      1      1      1      0
Node    0, zone   Normal, type      Movable     25     11    345     87     48     21      2     20      9      3  75061
Node    0, zone   Normal, type  Reclaimable      4      2      2      4      3      0      2      1      1      1      0
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
...
Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
Node    1, zone   Normal, type    Unmovable  98888  99650  99679      2      3      1      2      2      2      0      0
Node    1, zone   Normal, type      Movable      1      1      0      1      1      0      1      0      1      1  75937
Node    1, zone   Normal, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
Node    1, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0

After:
Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
...
Node    0, zone   Normal, type    Unmovable    152    158     37      2      2      0      3      4      2      6    717
Node    0, zone   Normal, type      Movable      1     37     53      3     55     49     16      6      2      1  75000
Node    0, zone   Normal, type  Reclaimable      1      4      3      1      2      1      1      1      1      1      0
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
...
Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
Node    1, zone   Normal, type    Unmovable      5      3      2      1      3      4      2      2      2      0    779
Node    1, zone   Normal, type      Movable      1      0      1      1      1      0      1      0      1      1  75849
Node    1, zone   Normal, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
Node    1, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0

Signed-off-by: suhua <suhua1@kingsoft.com>
---
 mm/hugetlb.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 190fa05635f4..3441d380c90b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2077,6 +2077,24 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
 	return folio;
 }
 
+static struct folio *only_alloc_and_account_fresh_hugetlb_folio(
+		struct hstate *h, gfp_t gfp_mask,
+		int nid, nodemask_t *nmask)
+{
+	struct folio *folio;
+
+	folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	if (!folio)
+		return NULL;
+
+	spin_lock_irq(&hugetlb_lock);
+	h->nr_huge_pages++;
+	h->nr_huge_pages_node[nid]++;
+	spin_unlock_irq(&hugetlb_lock);
+
+	return folio;
+}
+
 /*
  * Common helper to allocate a fresh hugetlb page. All specific allocators
  * should use this function to get new hugetlb pages
@@ -3301,23 +3319,34 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 {
 	unsigned long i;
 	char buf[32];
+	LIST_HEAD(folio_list);
+	struct folio *folio, *tmp_f;
 
 	for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
 		if (hstate_is_gigantic(h)) {
 			if (!alloc_bootmem_huge_page(h, nid))
 				break;
 		} else {
-			struct folio *folio;
 			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
-			folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-					&node_states[N_MEMORY]);
+			folio = only_alloc_and_account_fresh_hugetlb_folio(h,
+					gfp_mask, nid, &node_states[N_MEMORY]);
 			if (!folio)
 				break;
-			free_huge_folio(folio); /* free it into the hugepage allocator */
+			list_add(&folio->lru, &folio_list);
 		}
 		cond_resched();
 	}
+
+	if (!list_empty(&folio_list)) {
+		/* Send list for bulk vmemmap optimization processing */
+		hugetlb_vmemmap_optimize_folios(h, &folio_list);
+
+		list_for_each_entry_safe(folio, tmp_f, &folio_list, lru) {
+			free_huge_folio(folio); /* free it into the hugepage allocator */
+		}
+	}
+
 	if (i == h->max_huge_pages_node[nid])
 		return;
 
-- 
2.34.1


