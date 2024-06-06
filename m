Return-Path: <linux-kernel+bounces-204215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CCD8FE5EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B476CB23920
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863B19598B;
	Thu,  6 Jun 2024 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NdhGyyJd"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62D13D28C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675157; cv=none; b=Mx/xN5w8KcIpNb9614eHxKtzGOMRGN87nFnvQdqhudKSYt5d/pRZxUKqHAV4eCQxy6g0JXcNDKY4aj8vW4XK0Mir2w7ptlihgq5hfkHrbaHjsbNVHUM2atPwq0Eyt6uvxRdSDS/FM8Dfzzyf3dZjD8NmnCYWh/6sNjNvvwMk4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675157; c=relaxed/simple;
	bh=7DDX0syXSnSQYfxWFEQq91bQjru/boDlZCHaJZ2e48A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+inMHMnSwQNJ5YuWznkGpDFPhk1kJb8w1XGhJ4Uhq7fiI9DciQPmOogf+mTUuEg/fL28jLL5uEvCxkJLNJc39f4R6X+UYikKvyt0y3bL40VotbfKQB187vuSXlKC3FGCkLOTUzCKD1410P62rlSTiLy9nzykggLoXh5AT3jSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NdhGyyJd; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717675153; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QaLyG6fEgySNt1B9Umu3RlbPCCtnChT65+F+Wd+srs4=;
	b=NdhGyyJdxwqunhqgviQG52l7beR8YPxvNV19Uo779mUWRcRKpkwiX55A3BRaXTp7F4wNeSxYZ/3uMCO543VTw/kmsI3aucTdA6Z3dkzAPDazoHyxkjPuO2OTQ73o0PrHUWbsCMdGuY4aAKgcQiUwIzVF9+rOf0GgviXhrwT7peQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W7y5mug_1717675151;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7y5mug_1717675151)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 19:59:11 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	chrisl@kernel.org,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mm: vmscan: add validation before spliting shmem large folio
Date: Thu,  6 Jun 2024 19:58:51 +0800
Message-Id: <3516f4ff0242c48ad0fa000d50ac382817776be1.1717673614.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
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
index c0429fd6c573..9146fd0dc61e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1255,6 +1255,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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


