Return-Path: <linux-kernel+bounces-183352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38F8C97E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126B5284238
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE92D52F;
	Mon, 20 May 2024 02:19:56 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4285B9474;
	Mon, 20 May 2024 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171596; cv=none; b=g9vDRz96yxZau7aYMrVULWB2bRjTCk/Wf/YgDbp31OE6N/48RCx4EyB2oCRdEg+GNgWY0YCALtYYUzJy9kxFyOMSmZFcajE3+IqtczmzvE+TCOpcAoKQBNTJPZ8xjo+2Dgciotq5TriWFxftNWIiEgAZUa8RHcn/NuJiuCZ7TkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171596; c=relaxed/simple;
	bh=rB7dD75CY84ry20/0r/cpYaVwib9bJIdMevmIkkR3EE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cdnLeTaW7Pq/7u1vlzZEo3Mtk5DZJKQS1vGLyXoKuSUNF8curYB7YsfzPv5WbZ0rSHLJdlyr/w0wEvOaF/a9NJFTPdZ4nx6UemuOc3M9h2Ch16qLmeYFHsHn+na/yHMNvcI6/5UFMNvtPs7UjAlgRV3nmeE2gqZsEFWm8FHQzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 4F0696026E8D1;
	Mon, 20 May 2024 10:19:44 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: srinivas.pandruvada@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	rui.zhang@intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/x86: ISST: fix use after free problem in tpmi_sst_dev_remove()
Date: Mon, 20 May 2024 10:19:35 +0800
Message-Id: <20240520021934.113877-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang static checker (scan-build) warning:
drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c:1614:24:
Use of memory after it is freed.

Using 'tpmi_sst->package_id' after releasing 'tpmi_sst' causes this
problem. Change the order of releasing 'tpmi_sst' to fix this.

Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned systems")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 7bac7841ff0a..7fa360073f6e 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1610,8 +1610,8 @@ void tpmi_sst_dev_remove(struct auxiliary_device *auxdev)
 	tpmi_sst->partition_mask_current &= ~BIT(plat_info->partition);
 	/* Free the package instance when the all partitions are removed */
 	if (!tpmi_sst->partition_mask_current) {
-		kfree(tpmi_sst);
 		isst_common.sst_inst[tpmi_sst->package_id] = NULL;
+		kfree(tpmi_sst);
 	}
 	mutex_unlock(&isst_tpmi_dev_lock);
 }
-- 
2.30.2


