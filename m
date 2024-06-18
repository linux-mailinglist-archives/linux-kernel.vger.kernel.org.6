Return-Path: <linux-kernel+bounces-220330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E125190DFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C36DB225DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C6B185E4B;
	Tue, 18 Jun 2024 23:27:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92E23759
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753222; cv=none; b=Ig+VCP6G2HNaXV/OaIH0LxoePX9IU63CAFGyJ6ItrwEfMDHLUKwP5jDSR8ul+31zq6mvWiltxR1CrqlyHy8lXKGaICreYIyfKP42vHhuDNQuUdXlfKXkncM743Yto1qklozwXgXygPhKWe7ODa20YwxaQ/m4qra/C1X7maUp+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753222; c=relaxed/simple;
	bh=0vFa6zFjl0vkzalReskAx7/vllP2W2aEst65PwL+gXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMkMDqI6Vfi95c6G7aqz8xvnYwkx9p7yOOsO8qmu+mqlvU+RlWB07zqpaOOBvZ99/fFs30kgmOtzWPmjAZmB2pEc7ed3CcSh/m3Z0uCe8O6tXorrQaIt1wh4bnoiAA1gyoiJf5+orMSn6R1jLVZw+7iksqSvfPQx8iE6TVAP8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CD461042;
	Tue, 18 Jun 2024 16:27:24 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EECF83F64C;
	Tue, 18 Jun 2024 16:26:57 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Barry Song <baohua@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 1/5] mm: swap: Simplify end-of-cluster calculation
Date: Wed, 19 Jun 2024 00:26:41 +0100
Message-ID: <20240618232648.4090299-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618232648.4090299-1-ryan.roberts@arm.com>
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its possible that a swap file will have a partial cluster at the end, if
the swap size is not a multiple of the cluster size. But this partial
cluster will never be marked free and so scan_swap_map_try_ssd_cluster()
will never see it. Therefore it can always consider that a cluster ends
at the next cluster boundary.

This leads to a simplification of the endpoint calculation and removal
of an unnecessary conditional.

This change has the useful side effect of making lock_cluster()
unconditional, which will be used in a later commit.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/swapfile.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index b3e5e384e330..30e79739dfdc 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -677,16 +677,14 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	 * check if there is still free entry in the cluster, maintaining
 	 * natural alignment.
 	 */
-	max = min_t(unsigned long, si->max, ALIGN(tmp + 1, SWAPFILE_CLUSTER));
-	if (tmp < max) {
-		ci = lock_cluster(si, tmp);
-		while (tmp < max) {
-			if (swap_range_empty(si->swap_map, tmp, nr_pages))
-				break;
-			tmp += nr_pages;
-		}
-		unlock_cluster(ci);
+	max = ALIGN(tmp + 1, SWAPFILE_CLUSTER);
+	ci = lock_cluster(si, tmp);
+	while (tmp < max) {
+		if (swap_range_empty(si->swap_map, tmp, nr_pages))
+			break;
+		tmp += nr_pages;
 	}
+	unlock_cluster(ci);
 	if (tmp >= max) {
 		cluster->next[order] = SWAP_NEXT_INVALID;
 		goto new_cluster;
--
2.43.0


