Return-Path: <linux-kernel+bounces-203889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C588FE1AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A619FB27522
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ADD13C913;
	Thu,  6 Jun 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="psrqJZSX"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532777347A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663931; cv=none; b=Lx97r59dhi8O0VQhCSf5Z3wYCfEPWRQ3wOOeOQ6x96i1XbWI0+XK79Fs5YwywnE1jaKZYyRkzFd/5RsRvrFdmyRaQbI3GrLIIZF2aI4XTjFFVarJuSt5x4yUirgW//WnaF8vnl+pywdk0RSLqYXkeKi0h/0Sc3X/PKCNcO6Nz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663931; c=relaxed/simple;
	bh=kFrzNHgtHCeKyReD6Xg4n3HRpvFtYIRgMS7Z8IXf+cM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bkZcyBhNmNMK8T58OM7SAdUF0Hi0zH8y7wlmPaO+ntval+RHmSH4yKwuhIOcjDtpXDAh4eFvNwPiiFGc2Tjtf4ZteaKBkxYtbVAOdcb0n2uComrAW9pcMxEyE+lUndgCP9sIQA6WT4nk2lr4lsibUHv1srTAhe2JudCXvbPioqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=psrqJZSX; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/5nNd
	xAHvn8XrVpENTsC9WADZwaWod7V36HzzLbSoTc=; b=psrqJZSXv4dSzC+cjOy1Y
	DSL2U+wPy3MJD5VIpSzntUHwah7WbhEYWnAjD2IPLkTyXxomCG+HiqI/GpBWMNVh
	t8/PqOOpJOwEtZ4ori0B2s2errC1yIpbpLUSMSaMtYyHSipQ+YbNKM+x8tnUwqk4
	qzNulu9YcbhG3i6ACyesgE=
Received: from localhost.localdomain (unknown [111.48.69.247])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wDn77VGeGFmxpB0Dg--.65491S2;
	Thu, 06 Jun 2024 16:50:15 +0800 (CST)
From: oushixiong1025@163.com
To: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Tian Tao <tiantao6@hisilicon.com>,
	Xinwei Kong <kong.kongxinwei@hisilicon.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Yongqin Liu <yongqin.liu@linaro.org>,
	John Stultz <jstultz@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/hisilicon: Fix a NULL pointer access when call hibmc_unload
Date: Thu,  6 Jun 2024 16:50:12 +0800
Message-Id: <20240606085012.284167-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn77VGeGFmxpB0Dg--.65491S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4kGryxGFy3XF4DGr4kZwb_yoW5Kw4UpF
	W7XFW3tr4vq39xGF45JrW09FZ0ka1avayIkF1Sy3s3uws0kryDXF18JF4xCFy8XrWkCF95
	Z3Z7Gr4UZr1UZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMCJdUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXRjyD2XAljx7NgABs7

From: Shixiong Ou <oushixiong@kylinos.cn>

If Calling hibmc_mm_init() failed in hibmc_load(), the hibmc_unload()
will access a NULL pointer, as it don't call ww_mutex_init() to
initialize mode_config.connection_mutex but try to lock it when
calling drm_atomic_helper_shutdown() in hibmc_unload().

[   50.939211][  0] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
	......
[   51.149882][  0] Call trace:
[   51.152750][  0]  ww_mutex_lock+0xf0/0x1e0
[   51.156829][  0]  drm_modeset_lock+0x184/0x2c0
[   51.161254][  0]  drm_modeset_lock_all_ctx+0x98/0x188
[   51.166284][  0]  drm_atomic_helper_shutdown+0xa4/0x128
[   51.171487][  0]  hibmc_unload+0x50/0x2f0
[   51.175479][  0]  hibmc_load+0x5d8/0x888
[   51.179386][  0]  drm_dev_register+0x280/0x558
[   51.183811][  0]  drm_get_pci_dev+0x140/0x3c8
[   51.188150][  0]  hibmc_pci_probe+0x148/0x190
[   51.192489][  0]  local_pci_probe+0xc4/0x180
[   51.196742][  0]  pci_device_probe+0x328/0x530
[   51.201167][  0]  really_probe+0x498/0x9a0
[   51.205248][  0]  driver_probe_device+0x224/0x308
[   51.209932][  0]  device_driver_attach+0xec/0x128
[   51.214616][  0]  __driver_attach+0x144/0x280
[   51.218955][  0]  bus_for_each_dev+0x120/0x1a0
[   51.223380][  0]  driver_attach+0x48/0x60
[   51.227372][  0]  bus_add_driver+0x328/0x578
[   51.231625][  0]  driver_register+0x148/0x398
[   51.235965][  0]  __pci_register_driver+0x15c/0x1c8
[   51.240823][  0]  hibmc_init+0x2c/0x34
[   51.244557][  0]  do_one_initcall+0xc8/0x4a8
[   51.248810][  0]  kernel_init_freeable+0x678/0x75c
[   51.253582][  0]  kernel_init+0x18/0x128
[   51.257489][  0]  ret_from_fork+0x10/0x18

Add a initialized flag to avoid this.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 8 ++++++--
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 57c21ec452b7..343f64d66e75 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -99,6 +99,7 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 	ret = drmm_mode_config_init(dev);
 	if (ret)
 		return ret;
+	priv->mode_config_initialized = true;
 
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
@@ -240,9 +241,12 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
 static int hibmc_unload(struct drm_device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
 
-	drm_atomic_helper_shutdown(dev);
-
+	if(priv->mode_config_initialized){
+		drm_atomic_helper_shutdown(dev);
+		priv->mode_config_initialized = false;
+	}
 	free_irq(pdev->irq, dev);
 
 	pci_disable_msi(to_pci_dev(dev->dev));
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 207aa3f660b0..08fd7cb59bb5 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -37,6 +37,7 @@ struct hibmc_drm_private {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct hibmc_connector connector;
+	bool mode_config_initialized;
 };
 
 static inline struct hibmc_connector *to_hibmc_connector(struct drm_connector *connector)
-- 
2.25.1


