Return-Path: <linux-kernel+bounces-291995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C99569E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5844A1F23C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DEA166F36;
	Mon, 19 Aug 2024 11:52:16 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5191552FA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068336; cv=none; b=uIOui9x1aMgsiFR7SYuNiJRNibCQNlthXzzDGaQoSacWdYChpKAuY+66esgg7N5QKIJ7gOV93ZJvCR7iR8mbXaWFgqSa/Q084PvU9d8IglDLJV5QGh9yuH5A/hbzNrw7CPp6Rr5e7clUsKvE6mcDFUZCUglp6CUYDgqjuDz2fHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068336; c=relaxed/simple;
	bh=ii7YRbGq50XyZW5BirGD5uoYuj8n6Q/8UfSeVxLedbQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZKyUV0Lw/PWAftM+5Lqpbcyacz15Kf3Puf9WiTE/kbHzTnsh8zlNfcUKlNv3jwEG0yyHNwt2is1QOMI/bud4juGuoPRhRfqoDRMKOCHnUrTKk0q5WdJDMbGe3t2RABi9d0ZXyJelBzhY3BtQoI83q9Z22PlOJWTkwgUb/A79hFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WnW6p75VQz20m3Z;
	Mon, 19 Aug 2024 19:47:30 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 763A418001B;
	Mon, 19 Aug 2024 19:52:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:52:08 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
	<neil.armstrong@linaro.org>, <quic_jesszhan@quicinc.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<marcan@marcan.st>, <sven@svenpeter.dev>, <alyssa@rosenzweig.io>,
	<ulf.hansson@linaro.org>, <broonie@kernel.org>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <michal.simek@amd.com>, <p.zabel@pengutronix.de>,
	<ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>,
	<ruanjinjie@huawei.com>, <shiju.jose@huawei.com>,
	<xueshuai@linux.alibaba.com>, <manikanta.guntupalli@amd.com>,
	<u.kleine-koenig@pengutronix.de>, <tglx@linutronix.de>,
	<julien.malik@unseenlabs.fr>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/8] drivers: Fix some compile warnings
Date: Mon, 19 Aug 2024 19:59:13 +0800
Message-ID: <20240819115913.3884804-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Fix some sparse warnings.

Jinjie Ruan (8):
  dax/bus.c: Make dax_region_rwsem and dax_dev_rwsem static
  pmdomain: Make apple_pmgr_reset_ops static
  iommufd/selftest: Make dirty_ops static
  nvmet: Make nvmet_debugfs static
  spi: cadence: Make cdns_mrvl_xspi_clk_div_list static
  drm/panel: khadas-ts050: Make ts050_panel_data and ts050v2_panel_data
    static
  acpi/ghes: Make cxl_cper_fifo and cxl_cper_work static
  serial: xilinx_uartps: Make cdns_rs485_supported static

 drivers/acpi/apei/ghes.c                   | 4 ++--
 drivers/dax/bus.c                          | 4 ++--
 drivers/gpu/drm/panel/panel-khadas-ts050.c | 4 ++--
 drivers/iommu/iommufd/selftest.c           | 2 +-
 drivers/nvme/target/debugfs.c              | 2 +-
 drivers/pmdomain/apple/pmgr-pwrstate.c     | 2 +-
 drivers/spi/spi-cadence-xspi.c             | 2 +-
 drivers/tty/serial/xilinx_uartps.c         | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.34.1


