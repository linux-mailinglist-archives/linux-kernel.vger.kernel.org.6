Return-Path: <linux-kernel+bounces-277469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9EC94A1CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4131F21ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB11CCB32;
	Wed,  7 Aug 2024 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hv5eGz1z"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B941C6890
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015904; cv=none; b=HQxQjkumZFunCMIT3hBzrP6wfyQMAmdAVlNw6cehEMaGWhJBrysnECJDSy9V++/PFEjR9HPTtLolXF/4tbchux1UpwqJylOa53vZx280kheRfYtEQQIRUEeJtAva91nfHqt30LZ0MuSjIlIsNB4UG67gi+daIZGGWMl1DTyffA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015904; c=relaxed/simple;
	bh=xQOVqSgAJA3gYLLEP9aMoaNOqiX/NhGKX5duWWfBJ4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrCFNS0pqLfez7M0TMNI9s0mG1Yo4Aw52pXFgI8VfD4AlCPOuo8OgIg76lrVRHZl6KoYyocA8w6Svoc5Hz9O41tKYZrrAcKQtpmxFYIkf8qHSlOEeF04H4LgpJ9dKfQ9Xyd+8brHymeJPNJ1ZVzd1LpP70DC196DOBJzDKF/HIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hv5eGz1z; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723015894; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kqzOiSUcg37jmhpXPpVX6LPzNgjUKcTxKBX3p6fMXZU=;
	b=Hv5eGz1zZzQiN+NORYSKwaXBqELMdjLpskd7geTX3Lo7jbrbbNnJbFPkbhhfups+YOxQLCGC3mh6OJF0anOHF3rf+cojEqZDuxKy8RWGQwdGABX3atdykXDtEnA1E49csIcRQTW3Tqd9gzYRwx+7EOn1tClccQT8JDW04TSB7d8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0WCI3ghQ_1723015892;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCI3ghQ_1723015892)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:31:32 +0800
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
Subject: [PATCH v4 05/10] mm: filemap: use xa_get_order() to get the swap entry order
Date: Wed,  7 Aug 2024 15:31:10 +0800
Message-Id: <640ce8446a47b445ef89ed2bd61d6e92a916ecae.1723012159.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the following patches, shmem will support the swap out of large folios,
which means the shmem mappings may contain large order swap entries, so
using xa_get_order() to get the folio order of the shmem swap entry to
update the '*start' correctly.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/filemap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4130be74f6fd..4c312aab8b1f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2056,6 +2056,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		folio = fbatch->folios[idx];
 		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
+		else
+			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
 		*start = indices[idx] + nr;
 	}
 	return folio_batch_count(fbatch);
@@ -2120,6 +2122,8 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		folio = fbatch->folios[idx];
 		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
+		else
+			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
 		*start = indices[idx] + nr;
 	}
 	return folio_batch_count(fbatch);
-- 
2.39.3


