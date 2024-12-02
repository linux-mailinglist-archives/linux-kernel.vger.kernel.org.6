Return-Path: <linux-kernel+bounces-427111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3289DFCCB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E170DB220A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48011FA14F;
	Mon,  2 Dec 2024 09:07:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA061F9F7C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130459; cv=none; b=q96l37FWzMMr39iqxB+R/fHVgP9QyfhCZV1GiwDSFblfXS8+d7rWBOhqEO1Yg0DP/zYc1FmAjS4CCawBzRSeJpPWPbjpvf4FBEgmYuxQNrfpo4OmVafS5p3d1Wn4+MzhH2jnpAqve/TlFBbareLs0xnZvs+r2NgKKmzCekeTOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130459; c=relaxed/simple;
	bh=oH4Kem7zGe57gGlvYFDp+8QZRB5DB1sOu7y5qiCMpwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u85dRpYPVlNBTnPuUjUKbtaHzd6lH/OUnCtZWaW6+L2FFWwmfnuCgFIFSHJ43+4K5UCEJe408FBrZr6KkDB1VUt3iJe3D7bLz9PWrAA6dTz9cAKqz8CHaKn+JtjQy+rWo8qUzjDw6mc+A5QB9BQ34Ojc1l7iUZKMKNxLeHZvNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CFCB1063;
	Mon,  2 Dec 2024 01:08:05 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A190C3F71E;
	Mon,  2 Dec 2024 01:07:34 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb: Make __NR_USED_SUBPAGE check conditional
Date: Mon,  2 Dec 2024 14:37:28 +0530
Message-Id: <20241202090728.78935-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HugeTLB order check against __NR_USED_SUBPAGE is required only when
HUGETLB_PAGE_OPTIMIZE_VMEMMAP is enabled. Hence BUG_ON() trigger should
happen only when applicable.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.13-rc1

 mm/hugetlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea2ed8e301ef..b7443c7f3e0c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4513,11 +4513,13 @@ void __init hugetlb_add_hstate(unsigned int order)
 	struct hstate *h;
 	unsigned long i;
 
-	if (size_to_hstate(PAGE_SIZE << order)) {
+	if (size_to_hstate(PAGE_SIZE << order))
 		return;
-	}
+
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
+#ifdef HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
+#endif
 	h = &hstates[hugetlb_max_hstate++];
 	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
-- 
2.30.2


