Return-Path: <linux-kernel+bounces-381334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4139AFDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9008A1F24117
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DCF1D3585;
	Fri, 25 Oct 2024 09:13:51 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE81CFED9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847630; cv=none; b=T8tZGAANAOB8LNjKrI75p/gI+U9NiY70m0f28ac4LnaT0McK+rVwrLPANKjNt7lrmmHhkuRaLfMoVZ3pDszrvcWkLOFY0Rl7ii9+MmZy6NpNwYf9M9b2OTkhKx+EitzEkqDm6A7uj7nP94KKhoYNwGzRomWx0EsyxfAJA6hngOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847630; c=relaxed/simple;
	bh=aP1V2Qa6H/emozTDBEmOMe1vdAVMsTYcxtck9odG+ds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YxrFHRisav9m3pGnsI40GpxLHNe0JvraxILFXY6goNojW4UIiDSAEEPub7f/JKv3xIVX7mm9kQIXSqWvEH4GP7UCIO43cTLCcFw4OS8Byb4nhaiBFGnxqdiE8wq1dTbSaTWOJeO3PeyPK4RFTD4jM8yxIv1NvpDn2LoIVnIplWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XZcWQ1lk2zQrZF;
	Fri, 25 Oct 2024 17:12:50 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CE25140361;
	Fri, 25 Oct 2024 17:13:44 +0800 (CST)
Received: from huawei.com (10.175.113.133) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 17:13:42 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <lucas.demarchi@intel.com>, <thomas.hellstrom@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <matthew.auld@intel.com>, <matthew.brost@intel.com>,
	<michal.wajdeczko@intel.com>, <akshata.jahagirdar@intel.com>,
	<david.kershner@intel.com>, <matthew.d.roper@intel.com>,
	<zhangxiaoxu5@huawei.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <wanghai38@huawei.com>
Subject: [PATCH] drm/xe/migrate: Fix inappropriate error printing in xe_migrate_sanity_test()
Date: Fri, 25 Oct 2024 17:13:10 +0800
Message-ID: <20241025091310.15380-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600001.china.huawei.com (7.193.23.3)

When creating pin map for tiny fails, the PTR_ERR(pt) is printed instead
of PTR_ERR(tiny), which makes it impossible to accurately get the true
cause of the error.

Print PTR_ERR(tiny) after creating pin map for tiny fails.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/gpu/drm/xe/tests/xe_migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index 1a192a2a941b..4542925445de 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -224,8 +224,8 @@ static void xe_migrate_sanity_test(struct xe_migrate *m, struct kunit *test)
 				    XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 				    XE_BO_FLAG_PINNED);
 	if (IS_ERR(tiny)) {
-		KUNIT_FAIL(test, "Failed to allocate fake pt: %li\n",
-			   PTR_ERR(pt));
+		KUNIT_FAIL(test, "Failed to allocate fake tiny: %li\n",
+			   PTR_ERR(tiny));
 		goto free_pt;
 	}
 
-- 
2.17.1


