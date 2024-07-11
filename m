Return-Path: <linux-kernel+bounces-248536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A1392DE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9171C21497
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2582DDAA;
	Thu, 11 Jul 2024 02:46:03 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA04436
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665963; cv=none; b=eBt2YjU732A4ChhDyjZgjxdOtjOCgWut0ymjeD2dMhbtePknt/+cQVffeMlv+r4JEiA0xelIGPnm1LtJCGG8USbwOGIyjc+zhOMYF8JJhQwwEvuCWJxRzWiAb4bgbD2YIRXZ2rjjAnFmWrsK903fIhjDJeV5oRklqgmzhXJ5RPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665963; c=relaxed/simple;
	bh=5gXBlyahX6q9RfmI0ylUodRKCsl37mC6AYqAZEdNbNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H8m6OqX8Ab3vevhuzBWRYeASktdfZ19hmy4eTrD51rGJe87mDNLDBiHaBPY7AoFLsp8RP/iHqp8K/LGsZVG48HKggdeFIP73UnwycJaJiy4FNIe3HHjbNlLpVS/q9icgRajxusew7O/6Kfhf+rgZbnM2Kplm260Ka3lR4Q2uIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAD32E1MR49mzRe_Ag--.49651S2;
	Thu, 11 Jul 2024 10:45:50 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	make24@iscas.ac.cn,
	guchun.chen@amd.com,
	chenjiahao16@huawei.com,
	Jammy.Zhou@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: fix a possible null pointer dereference
Date: Thu, 11 Jul 2024 10:45:31 +0800
Message-Id: <20240711024531.1604757-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD32E1MR49mzRe_Ag--.49651S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4UAFy5KF45AF4UGFyUZFb_yoWDKrc_CF
	WDZa9xJw43A3ZYvr47Zw4Sv3sIva4UAr4ktr1Sqa9av34xXw17XryUJryFqF1fWFZ3CFnr
	t34Ygw15A3ZrCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In amdgpu_connector_add_common_modes(), the return value of drm_cvt_mode()
is assigned to mode, which will lead to a NULL pointer dereference on
failure of drm_cvt_mode(). Add a check to avoid npd.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch according to suggestions;
- added Fixes line.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 9caba10315a8..21530f70a8bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -458,6 +458,8 @@ static void amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
 			continue;
 
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+		if (!mode)
+			return;
 		drm_mode_probed_add(connector, mode);
 	}
 }
-- 
2.25.1


