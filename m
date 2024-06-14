Return-Path: <linux-kernel+bounces-214364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E090834B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F123C1C22120
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A647F14601C;
	Fri, 14 Jun 2024 05:26:05 +0000 (UTC)
Received: from njjs-sys-mailin01.njjs.baidu.com (mx315.baidu.com [180.101.52.204])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA626ADE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342765; cv=none; b=SRwUVK1Uh+v5u4gRHGFvI9eiIs7HErPDEl2AA78fk8agw2Kc5b3fz6hfm0XXEc69pOMOb2xOoMD2u1QMCovORn5Dmuu147ieCZavQbL8710+4Ceq1G7wxQ1zKhEw4ICbQgxLOn9SI7LVngq+shF7deunJWEfAiEWhChWIERxvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342765; c=relaxed/simple;
	bh=hlAC+liJwlMTETxKRDMCL6af/9a3p3shTmSwAKBxmgw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IKsCIw9iCQqNtLAZBeq31PKPhNF/8NJ8AUJtteD3RCbaTy9jkhY6ujYtRvJL1JdchsGkurfMQ2bshySYAozX5lE+Wc9NHXa9vjjThdx0OqVxpP6ArmJ4/FnKGZ5ASrUhQXWf5PyAaXaVf/A83WafCSKXs4iwwPOI91/FGrXMqHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 814067F0003D;
	Fri, 14 Jun 2024 13:10:38 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: thomas.lendacky@amd.com,
	dan.j.williams@intel.com,
	bp@alien8.de,
	linux-kernel@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virt/coco/sev-guest: Don't free decrypted memory
Date: Fri, 14 Jun 2024 13:10:36 +0800
Message-Id: <20240614051036.41983-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In CoCo VMs, it is possible for the untrusted host to cause
set_memory_decrypted() to fail such that an error is returned
and the resulting memory is shared. Callers need to take care
to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional
or security issues. so don't free decrypted memory

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 654290a8e..799563a 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -730,8 +730,7 @@ static void *alloc_shared_pages(struct device *dev, size_t sz)
 
 	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
 	if (ret) {
-		dev_err(dev, "failed to mark page shared, ret=%d\n", ret);
-		__free_pages(page, get_order(sz));
+		dev_err(dev, "failed to mark page shared, leak page, ret=%d\n", ret);
 		return NULL;
 	}
 
-- 
2.9.4


