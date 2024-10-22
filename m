Return-Path: <linux-kernel+bounces-376266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A109AA26E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FB328346D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DA19D8A4;
	Tue, 22 Oct 2024 12:47:04 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE0619D880
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601224; cv=none; b=jwiREqW3mw/68AkyDqL3RnCoDidSz8FdWCPFI5e4nz2Ja7bKCo8h6MJ+O2wrKtidPE9ohftluu0KA03jQFThv9bKfXdkvZlOgSc8zg8j2EbQxkNZw4wGpmGulDkgEbyI86ZON4pqIbZsYL2Y+i/meECTcfPVbqxhAfa2nDwZ6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601224; c=relaxed/simple;
	bh=T7S0R0exlKVj0YMPm6JytKKVAX2qIYQyxPfzRa0AkNg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HjGy5nsBL4gbkZfyvAJ+UtmnY6YJnfDY3j4Bzj2wg/xVebVIEIpzW6L6AtBTP+I08FAjZJO463qAC6t60LJR/711EVHbNUXspGtptWPb87rtUdL0bAOl+CjlHeMpnbnIeTPZ54tWT2l/eHpVkMwjJ8AF/dwZ4mIrBqVGR2STwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XXsN73LczzyT6w;
	Tue, 22 Oct 2024 20:45:27 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id F2172140159;
	Tue, 22 Oct 2024 20:46:57 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 22 Oct 2024 20:46:56 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 drm-dp 0/4] Add dp module in hibmc driver
Date: Tue, 22 Oct 2024 20:41:44 +0800
Message-ID: <20241022124148.1952761-1-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500013.china.huawei.com (7.221.188.12)

From: baihan li <libaihan@huawei.com>

Realizing the basic display function of DP cable for DP connector
displaying. Add DP module in hibmc drm driver, which is for Hisilicon
Hibmc SoC which used for Out-of-band management. Blow is the general
hardware connection, both the Hibmc and the host CPU are on the same
mother board.

+----------+       +----------+      +----- ----+      +----------------+
|          | PCIe  |  Hibmc   |      |          |      |                |
|host CPU( |<----->| display  |<---->| dp kapi  |<---->| dp aux moduel  |
|arm64,x86)|       |subsystem |      |  moduel  |<---->| dp link moduel |
+----------+       +----------+      +----------+      +----------------+
---
ChangeLog:
v1 -> v2:
  - using drm_dp_aux frame implement dp aux read and write functions, suggested by Jani Nikula.
  - using drm dp header files' dp macros instead, suggested by Andy Yan.
  - using drm_dp_* functions implement dp link training process, suggested by Jani Nikula.
  - changed some defines and functions to former patch, suggested by Dmitry Baryshkov.
  - sorting the headers including in dp_hw.h and hibmc_drm_drv.c files, suggested by Dmitry Baryshkov.
  - deleting struct dp_mode and dp_mode_cfg function, suggested by Dmitry Baryshkov.
  - modifying drm_simple_encoder_init function, suggested by Dmitry Baryshkov.
  - refactoring struct hibmc_connector, suggested by Dmitry Baryshkov.
  - withdrawing the modification in hibmc_kms_init, suggested by Dmitry Baryshkov.
  - fix build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202410031735.8iRZZR6T-lkp@intel.com/
    Closes: https://lore.kernel.org/oe-kbuild-all/202410040328.VeVxM9yB-lkp@intel.com/
  v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
---

baihan li (4):
  drm/hisilicon/hibmc: add dp aux in hibmc drivers
  drm/hisilicon/hibmc: add dp link moduel in hibmc drivers
  drm/hisilicon/hibmc: add dp hw moduel in hibmc driver
  drm/hisilicon/hibmc: add dp module in hibmc

 drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   | 162 +++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.h   |  31 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  74 ++++
 .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  19 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 237 ++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  31 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 344 ++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h  |  25 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  76 ++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 148 ++++++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  16 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  21 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   |  41 +--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  |  20 +-
 15 files changed, 1208 insertions(+), 40 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c

-- 
2.33.0


