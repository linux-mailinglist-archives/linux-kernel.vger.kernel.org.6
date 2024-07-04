Return-Path: <linux-kernel+bounces-240956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EC992750D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3A81C220C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D131ACE88;
	Thu,  4 Jul 2024 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fmXHymF6"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C91AC24D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092319; cv=none; b=K0Cgw6LaCoigsIP/C1V7VQVJ7wm7pwujuDZaAQQHN9bMMm2xAGAz1Ppjg8nJDsynFBCLgjFcT/t+C++WOLQSTKuT+xVpcMjUNMhqmvt27hbH90uXZe1fxp3AjiGAQQsYJ5SFRJ8mrA5CMiVKlNKOP0rZd3AM0SFuwMZafOfqObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092319; c=relaxed/simple;
	bh=mfuHWKwxF4cuoSo2uY86uLZ9l7fnXmIiVjxYGYpXGGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4oNi/KaI+qBZTyRMuDOeyqOhnjDJqolFHOaPQSn55O36W0IRUO5mMJi+Itx7pADeCkUPuAO+8/k/bIHkaDFiwzeAG7ZCZyie45vKigKYCsJk1xEwdHVXs4F19hcutxAiRpn2NvwcYt1uKZdk15pSTgh1ImlCAN/jOoYD2UCBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fmXHymF6; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720092315; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QyBoZMTgb7NS//TXwyienog6t9srSRphl+czPh5Cin4=;
	b=fmXHymF6BPnwWtsidKw9sftKAnYWv9L7JPScxS6K3zuXuKsbi95BwKJHzcvxznE/1Y/fraZS+c5Cz8sxxVypP4t4gD4ZdfAdid0fdxVh3E2MHSxiq89Y8O3sYdm+6NO5RJGzmo89tV4msL9CccxiNqRzy+tqlnwNX449bguNHuc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W9qjnNQ_1720092312;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9qjnNQ_1720092312)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:25:12 +0800
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
Subject: [PATCH v3 05/10] mm: filemap: use xa_get_order() to get the swap entry order
Date: Thu,  4 Jul 2024 19:24:54 +0800
Message-Id: <f6628d0a1257a9c46aa91a7774017b4da931d6fb.1720079976.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
References: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
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
index 95d56cc788ef..c1a703eb8116 100644
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


