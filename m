Return-Path: <linux-kernel+bounces-229907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D8B9175DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EEAE1F221FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2AB1BC4B;
	Wed, 26 Jun 2024 01:47:37 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A311184
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366456; cv=none; b=Vb1T09CM5LgQ2ck1WFU4G5MtVuKJ3SrD5yvOFWjfK5bWWCMTUnOoKF5DP/X+3dIsZayVc9sNZF87M5TneWcklYw/qFDRGF3J97PczHxGw4Lmd8pQIm0OnS8GbAqT2CRdCkJHuigTy48IWaG8PNHCSaSXSSaJajsn3OxEKnJROBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366456; c=relaxed/simple;
	bh=+jiRWKNvCVOTC1iS88LMOpw03Uv3lldwpons67Q3hiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UMaEWh/8bfqy34GW9XdxAqWlUyYKxnz8PnCQmoaM6z3/3/uhR0iWoZnipeyUmQpRTCVMZeeywMKuFmZC6BSxy0OAyznx68571wz0jEaBmVAoKBWP5i+ODUJp82S7vrVVjIA3ps+CMkH0yhWXQR4IsxJ2ENiRhXxfvUeobJFC4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowACHjuYic3tm+7_REg--.43994S2;
	Wed, 26 Jun 2024 09:47:21 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] drm/client: fix null pointer dereference in drm_client_modeset_probe
Date: Wed, 26 Jun 2024 09:47:14 +0800
Message-Id: <20240626014714.2768720-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHjuYic3tm+7_REg--.43994S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4DZw13ZF13JF18KFWDtwb_yoWfKwb_GF
	yUZ3srursxWa4kCanI9ay7AF12yryUCr48AF12va4Fy3s8J3ZrZr9rXF1rZ3W8XFy7Ary7
	ta9ruF13Ar4xCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0D
	UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In drm_client_modeset_probe(), the return value of drm_mode_duplicate() is
assigned to modeset->mode, which will lead to a possible NULL pointer
dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/drm_client_modeset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 31af5cf37a09..bbe21522dc6a 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -880,6 +880,8 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 
 			kfree(modeset->mode);
 			modeset->mode = drm_mode_duplicate(dev, mode);
+			if (!modeset->mode)
+				continue;
 			drm_connector_get(connector);
 			modeset->connectors[modeset->num_connectors++] = connector;
 			modeset->x = offset->x;
-- 
2.25.1


