Return-Path: <linux-kernel+bounces-184847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0108CAD00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E02D2819C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA506E5E8;
	Tue, 21 May 2024 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lz3wmb9h"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFC1F947
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289420; cv=none; b=nMURNTo5z+T4bNTnexca4KGXg1Ytrkg4Hy9gkC1Hfu90NwxV014b4tUkTjLqCmbyvWMIEEsSAEUWQYdfS4llWQt3SMAntRtcOnl6DdoH/UiZ1KvDHmEL7IUG52vjXZ2SsPl+/4ytZyduK8VA3XKYZb6rOKZI3xRgw0ZI8Gc8hxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289420; c=relaxed/simple;
	bh=h22zJbPRxyQFlNc4ugoehr8HE78sCotSnHOiJ3gEnU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KU1oWZun7a/xnmUrxaa54XtUXg/0gdDE1PUsnhxgnX6X244yKlkKThgDHSZDE6AdciHqirjKwVQ/4Xr4seFPZl177fONh3g9+k9fF59h5rUgqNZUV1RkCELK/iIf/TYoCrplP1xQ1o6bjBDZv0kW1xDDEjcmUHpw1QCiut/Tq1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lz3wmb9h; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716289414; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=emwz+iI9NQ7GxFXPBlPImuiv2PaM3+Taa8lvRwiumnM=;
	b=lz3wmb9hM7NQm3xqYf8LPwVLZmpLvXu3uuGv0pvPh9RnGTU8FhSIHjQeHOmBJyr7IWGr9cAraPwBnK7LvvMbuxJNxcDCh0XiuLweDjD+LUCfhZ1XFVja4BLLP45UjsWr04fBiQEtCodoi18gUa21KVDxK1jeTH4cGU24+EPeKfg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W6xl94l_1716289411;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6xl94l_1716289411)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 19:03:33 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	hrisl@kernel.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/8] mm: vmscan: add validation before spliting shmem large folio
Date: Tue, 21 May 2024 19:03:12 +0800
Message-Id: <5c919e5002739d2f396918d11bde5711d4ae8182.1716285099.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
References: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add swap available space validation before spliting shmem large folio to
avoid redundant split, since we can not write shmem folio to the swap device
in this case.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/vmscan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6981a71c8ef0..bf11c0cbf12e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1252,6 +1252,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			}
 		} else if (folio_test_swapbacked(folio) &&
 			   folio_test_large(folio)) {
+
+			/*
+			 * Do not split shmem folio if no swap memory
+			 * available.
+			 */
+			if (!total_swap_pages)
+				goto activate_locked;
+
 			/* Split shmem folio */
 			if (split_folio_to_list(folio, folio_list))
 				goto keep_locked;
-- 
2.39.3


