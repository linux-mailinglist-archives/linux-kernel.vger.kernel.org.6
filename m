Return-Path: <linux-kernel+bounces-369067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17FC9A1892
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8B81C22399
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AB44C97;
	Thu, 17 Oct 2024 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uclBJYPy"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACC17580
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729131881; cv=none; b=OzL4bycea00uZQYdOmni63wf6kDJ2Fcu47hF4Q4YLXMMlooGMDyFLAzo7RbKFc1tWRteKmnhm4O2Wa+eVvysn8N31FuYnJGeVrHNaCTHugYDVSrA7A7yx/YWs38mu3e4i8UnfjQqAlJ/iTvCqDQWjVr7vnY2xpt6exBt2GEfAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729131881; c=relaxed/simple;
	bh=H5MODp2UFoJLwNCIi2zJogy9IWjZEZk334LDzMZhHOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kU1x8pAfiPQwd/5oGW/B+b3z4ShDmD/TWNhbUq6elUGIymxuhBg9BiYGT4oSWfGMpnkrf8avTra+wLFQ+Dv1VO9L4OpMVkVl5NBRFRRQSAPQuncFRzIj1H3uRjB4euXccBJ+9aYlGGeAmkXsN3opRbRF+c8mu4ABj3+DnE87Gkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uclBJYPy; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729131868; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sTQKUY9bYv2FQcppEn7rMkZGCklExQGuiP2W4/xe0z8=;
	b=uclBJYPysjOUg71SMWmEfOyvjRNQvcf+ryTTGmybU6lIwUZUv0QfoIcYRzwf6cOg8uT9QsFFg6zWcKYv9C0Yr+1qKIy7QrjBZa2kwPuGTv5Bc5NjJTjkHTucof/AKCfF60UaZDmUzYpLF2xmtwueJEfqJUY3eMUB/zPqgARlMD8=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WHJ8Nm9_1729131863 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 10:24:28 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: stefan@agner.ch
Cc: alison.wang@nxp.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/fsl-dcu: Remove unnecessary print function dev_err()
Date: Thu, 17 Oct 2024 10:24:22 +0800
Message-Id: <20241017022422.23557-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The print function dev_err() is redundant because
platform_get_irq_byname() already prints an error.

./drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c:278:2-9: line 278 is redundant because platform_get_irq() already prints an error.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11384
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 2b3f15f0dc56..60a7b9dbf95c 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -273,11 +273,8 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	fsl_dev->irq = platform_get_irq(pdev, 0);
-	if (fsl_dev->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (platform_get_irq(pdev, 0) < 0)
 		return fsl_dev->irq;
-	}
 
 	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
 			&fsl_dcu_regmap_config);
-- 
2.32.0.3.g01195cf9f


