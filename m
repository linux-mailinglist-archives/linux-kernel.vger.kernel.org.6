Return-Path: <linux-kernel+bounces-220331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9C390DFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D5F285CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E62185E7B;
	Tue, 18 Jun 2024 23:27:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555451849E7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753224; cv=none; b=A6KrC3bpoUamTQTiOHNyw11ypMoJxy0NxMEu5sCXwylokFpFkguFVCaWYKWM86HY5A6wY/F7+H2CCYiqNGuk8AndwFV0ASoayxTtFSsK7sn1bLVrkv3fTd16wg9hsTI96Db45pioaQ0BKSJj5qtqx4DRIqMsHswIQ6+lDqs/3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753224; c=relaxed/simple;
	bh=KPWhWMwn8+fxwlOnQKIDT3FoyE/8dI9V/ENsNSbrzHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXaA4bNZwwX6pGLTdgpexItabwGxlf3FodbXT4+4Af/4Mud/jJ6nUbIRjl7kkzK1frHZj0RyTORCY5y5u6rhY5uhQw9+vfpMxdzaz2oh2wg/2yC03oGdZ0D1FCccW3gd95l7knsh9uj/dZDrxnxIfymgWKGuz7WxSc+7fm1etEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C3A61474;
	Tue, 18 Jun 2024 16:27:26 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2AE3F64C;
	Tue, 18 Jun 2024 16:26:59 -0700 (PDT)
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
Subject: [RFC PATCH v1 2/5] mm: swap: Change SWAP_NEXT_INVALID to highest value
Date: Wed, 19 Jun 2024 00:26:42 +0100
Message-ID: <20240618232648.4090299-3-ryan.roberts@arm.com>
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

We are about to introduce a scanning mechanism that can present 0 as a
valid cluster offset to scan_swap_map_try_ssd_cluster(), so let's change
SWAP_NEXT_INVALID to UINT_MAX, which is always invalid as an offset in
practice.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index bd450023b9a4..66566251ba31 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -261,12 +261,12 @@ struct swap_cluster_info {
 #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */

 /*
- * The first page in the swap file is the swap header, which is always marked
- * bad to prevent it from being allocated as an entry. This also prevents the
- * cluster to which it belongs being marked free. Therefore 0 is safe to use as
- * a sentinel to indicate next is not valid in percpu_cluster.
+ * swap_info_struct::max is an unsigned int, so the maximum number of pages in
+ * the swap file is UINT_MAX. Therefore the highest legitimate index is
+ * UINT_MAX-1. Therefore UINT_MAX is safe to use as a sentinel to indicate next
+ * is not valid in percpu_cluster.
  */
-#define SWAP_NEXT_INVALID	0
+#define SWAP_NEXT_INVALID	UINT_MAX

 #ifdef CONFIG_THP_SWAP
 #define SWAP_NR_ORDERS		(PMD_ORDER + 1)
--
2.43.0


