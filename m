Return-Path: <linux-kernel+bounces-526920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBE5A4052D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 03:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C9E707693
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B481FF612;
	Sat, 22 Feb 2025 02:58:25 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D271E3DED
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 02:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740193105; cv=none; b=meqab7xmM81fjdEjmI6lBKoDUDhab0wCasjlk8q1R7VHKa/27SuSA0eahJg7m7s63yqvJuKVJL0mE6HEwjRuPBDPuYKVr/1dCzNlogNbAiVvdB38TjLrKHUbBupEDREShlKc/BxPj5TIUQcraKmGhOFI+nJlaqzbWPAWY1iU1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740193105; c=relaxed/simple;
	bh=c2J9o0YK624twklzQNJrfHpQW68yr+dRangFzxpliL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FRwPlN76dsBxQowTFSHKq8wOtkAln9Y33AQmbuQYZiYsQFTHjOSn58+2aEsGQsGZfRpQhpTdWmoG6Jnq08bU2yTdZ94CI2g27jPCvymrgMu/N6nSA/zeoQUCPNEGrQtvvW8XMV4tJShr19MjLj5clSQ4ASjEz4aGpTxhyAuhAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z0BSN3yjpzHr9G;
	Sat, 22 Feb 2025 10:55:16 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C826140336;
	Sat, 22 Feb 2025 10:58:19 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 22 Feb 2025 10:58:18 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 drm-dp 0/8] Add HPD, getting EDID, colorbar features in DP function
Date: Sat, 22 Feb 2025 10:50:53 +0800
Message-ID: <20250222025102.1519798-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500013.china.huawei.com (7.221.188.12)

From: Baihan Li <libaihan@huawei.com>

To support DP HPD, edid printing, and colorbar display features based on
the Hisislcon DP devices. 

---
ChangeLog:
v2 -> v3:
  - restructuring the header p_reg.h, suggested by Dmitry Baryshkov.
  - add commit log about dp serdes, suggested by Dmitry Baryshkov.
  - return value in hibmc_dp_serdes_init(), suggested by Dmitry Baryshkov.
  - add static const in the array of serdes_tx_cfg[], suggested by Dmitry Baryshkov.
  - change drm_warn to drm_dbg_dp, suggested by Dmitry Baryshkov.
  - add explanations about dp serdes macros, suggested by Dmitry Baryshkov.
  - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
  - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
  - split the patch into two parts, suggested by Dmitry Baryshkov.
  - Capitalized EDID and AUX, suggested by Dmitry Baryshkov.
  - rewrite the commit log, suggested by Dmitry Baryshkov.
  - move colorbar debugfs entry to this patch, suggested by Dmitry Baryshkov.
  - change binary format to integer format, suggested by Dmitry Baryshkov.
  - remove mdelay(100) hpd function in ISR, suggested by Dmitry Baryshkov.
  - remove enble_display in ISR, suggested by Dmitry Baryshkov.
  - change drm_kms_helper_connector_hotplug_event() to
    drm_connector_helper_hpd_irq_event(), suggested by Dmitry Baryshkov.
  - move macros to dp_reg.h, suggested by Dmitry Baryshkov.
  - remove struct irqs, suggested by Dmitry Baryshkov.
  - split this patch into two parts, suggested by Dmitry Baryshkov.
v1 -> v2:
  - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
  - changing all names of dp phy to dp serdes.
  - deleting type conversion, suggested by Dmitry Baryshkov.
  - deleting hibmc_dp_connector_get_modes() and using drm_connector_helper_get_modes(), suggested by Dmitry Baryshkov.
  - add colorbar introduction in commit, suggested by Dmitry Baryshkov.
  - deleting edid decoder and its debugfs, suggested by Dmitry Baryshkov.
  - using debugfs_init() callback, suggested by Dmitry Baryshkov.
  - splittting colorbar and debugfs in different patches, suggested by Dmitry Baryshkov.
  - optimizing the description in commit message, suggested by Dmitry Baryshkov.
  - add mdelay(100) comments, suggested by Dmitry Baryshkov.
  - deleting display enable in hpd event, suggested by Dmitry Baryshkov.
---

Baihan Li (8):
  drm/hisilicon/hibmc: Restructuring the header dp_reg.h
  drm/hisilicon/hibmc: Add dp phy cfg to adjust serdes rate, voltage and
    pre-emphasis
  drm/hisilicon/hibmc: Add dp serdes cfg in dp process
  drm/hisilicon/hibmc: Refactor the member of drm_aux in struct hibmc_dp
  drm/hisilicon/hibmc: Getting connector info and edid by using aux
    channel
  drm/hisilicon/hibmc: Add colorbar-cfg feature and its debugfs file
  drm/hisilicon/hibmc: Enable this hot plug detect of irq feature
  drm/hisilicon/hibmc: Add MSI irq getting and requesting for HPD

 drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   |  16 ++-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |   7 +-
 .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |   2 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  78 ++++++++++++-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  37 +++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  |  55 +++++++---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   | 103 +++++++++++-------
 .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    |  72 ++++++++++++
 .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.h    |  40 +++++++
 .../drm/hisilicon/hibmc/hibmc_drm_debugfs.c   | 100 +++++++++++++++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |  95 +++++++++++++++-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  85 +++++++++++----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  12 ++
 14 files changed, 617 insertions(+), 88 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c

-- 
2.33.0


