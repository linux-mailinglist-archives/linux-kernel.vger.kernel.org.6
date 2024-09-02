Return-Path: <linux-kernel+bounces-310967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1F1968367
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5502B240A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABEC1D1F6B;
	Mon,  2 Sep 2024 09:35:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341E1C32F8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269746; cv=none; b=V8bl20Tnx0T0RXliA5Gj2s9dkitQ8d3qHrIBKviPdFiqspIIuv3uxr0SsBUPxHPpR46tfG1WZn0lIbaZs5CmzCBeYIb1lJDOCbQtom7FDfbCgI2AS09+aoYLJCMKwjy2WS6hl3xI1PGCrQ5YthoX1OikoPpNuCiDBo52mTv+t9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269746; c=relaxed/simple;
	bh=8yLKoD5cvegiCAJYpS+OTwa5iRbGxYyQdhV/v6P2DGs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=doccI4zAbb7WN26MOKuPGBN7+1jkPxhmcH/d+DTgVIBAbmOfhPpenmxG1RTq7VQoGEi0WlC32Rsu7+9uUIdf6tBUCbLMhab7kBx4tASvzMls0eDgFjEV7IcDQmcKse6IVZxfYMPXXzChJPeLXV02MieEHYcHxYfF71DkR/09gJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wy3Tq0jpqzgYfn;
	Mon,  2 Sep 2024 17:33:35 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 55A051800A0;
	Mon,  2 Sep 2024 17:35:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 17:35:40 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <boris.brezillon@collabora.com>, <steven.price@arm.com>,
	<liviu.dudau@arm.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] drm/panthor: Use the BITS_PER_LONG macro
Date: Mon, 2 Sep 2024 17:44:04 +0800
Message-ID: <20240902094404.1943710-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

sizeof(unsigned long) * 8 is the number of bits in an unsigned long
variable, replace it with BITS_PER_LONG macro to make them simpler.

And fix the warning:
	WARNING: Comparisons should place the constant on the right side of the test
	#23: FILE: drivers/gpu/drm/panthor/panthor_mmu.c:2696:
	+       if (BITS_PER_LONG < va_bits) {

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Also fix for below mmu_features.
- Remoove -next.
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index fa0a002b1016..7b1c345669b7 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2693,9 +2693,9 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	 * which passes iova as an unsigned long. Patch the mmu_features to reflect this
 	 * limitation.
 	 */
-	if (sizeof(unsigned long) * 8 < va_bits) {
+	if (va_bits > BITS_PER_LONG) {
 		ptdev->gpu_info.mmu_features &= ~GENMASK(7, 0);
-		ptdev->gpu_info.mmu_features |= sizeof(unsigned long) * 8;
+		ptdev->gpu_info.mmu_features |= BITS_PER_LONG;
 	}
 
 	return drmm_add_action_or_reset(&ptdev->base, panthor_mmu_release_wq, mmu->vm.wq);
-- 
2.34.1


