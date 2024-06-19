Return-Path: <linux-kernel+bounces-220772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCB990E6D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08E41C2171F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA77FBCF;
	Wed, 19 Jun 2024 09:22:29 +0000 (UTC)
Received: from njjs-sys-mailin01.njjs.baidu.com (mx316.baidu.com [180.101.52.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7AA79DC7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788948; cv=none; b=pryBFyLcS5ec9+LmDrtGcC78tUdUGNLfajmW2QqRmv1lpv0atzz70mgYnqq3J46WK7qfgHP0EgFZgQkzyRsrw3RmjbEDfI46b83w+OHq5cB4ddQN3+J8HIWZNIxQNTooMFsQ7Rq+Kkun5l37IJ6EDoXMHdt118ElkwHUZmq3RBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788948; c=relaxed/simple;
	bh=S1DeiE19TZ8/suV5Voa0916Kr/F12FKieC1NBMa2tzM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hw+HiGy7KfweNoZJfD1qbBJne/xrsRpQPjOvpAs/R2q2KnPJfZkZlyJtaV2uI4K3YpprR602ihUhAuSdTDN/Lev1whDGa1V684dzc9tQ8WwifFRN1lQ5kQAAgxP6XzYNkHgL+xNAQXYV6DWjlq+y75dy2z0ZtiwGR+VDCslPL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id CE2427F00045;
	Wed, 19 Jun 2024 17:22:17 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: thomas.lendacky@amd.com,
	dan.j.williams@intel.com,
	bp@alien8.de,
	linux-kernel@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] virt/coco/sev-guest: Don't free decrypted memory
Date: Wed, 19 Jun 2024 17:22:15 +0800
Message-Id: <20240619092215.1824-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

If set_memory_decrypted() fails, and memory maybe have a mix of
pagetable entries, that could be a problem.

As Tom explained:
  As long as the encryption bit hasn't been cleared in any of the
  guest pagetables for the page range, then there should not be an
  issue. When the page is referenced it will generate a #NPF and
  the host will have to make that page a private page in order for
  forward progress to be made. But, that page will already have
  been PVALIDATEd previously, so the resulting #VC for the page no
  longer being PVALIDATEd will allow the guest to detect the
  malicious hypervisor and terminate.

  If we fail during the __change_page_attr_set_clr() call and we get
  a mix of pagetable entries that could be a problem, so leaking the
  pages would be best in that case.

  And since the failure reason isn't clear after the call, leaking
  the pages is probably the safest thing.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
diff with v1: update the commit log

 drivers/virt/coco/sev-guest/sev-guest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 654290a8e..d31f229 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -730,8 +730,7 @@ static void *alloc_shared_pages(struct device *dev, size_t sz)
 
 	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
 	if (ret) {
-		dev_err(dev, "failed to mark page shared, ret=%d\n", ret);
-		__free_pages(page, get_order(sz));
+		dev_err(dev, "failed to mark page shared, leak it, ret=%d\n", ret);
 		return NULL;
 	}
 
-- 
2.9.4


