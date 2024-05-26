Return-Path: <linux-kernel+bounces-189850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450488CF5D5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 21:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EB11C20A1B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 19:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6EE131BC7;
	Sun, 26 May 2024 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ljUUPJo5"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9E13174B
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716753558; cv=none; b=UH/akRZoWemCIkle5CB+P7J4WlvrNUYbWJQt6evNAufshFJl8KdH8/d7fnfyohZ5zqzbunTBIz8T3Cb2RQSmFoBGAavKpkF5wk1F1gXE6DY2Bqo/T9rrcLVe623SKp8bI/cM6WdnG6Oc5rsI8QbFGgwNczzNxvuK5bjkxaaqvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716753558; c=relaxed/simple;
	bh=gtek/LpSmavJXkf/GOvnKy6tYof+T3bCS5DZK1LDa9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hpXW477gQ7Fq18kDkFPaBtVsUmFMbK7Jq7zw42Cz0p1IsaZLob619Wl6J9uZd7ZLuzf2MyOGP7gSwhL35IdSQwMxxeEkZU2RneNPa8nVncGTjSfZoScLa1rWmDsmj4HiNOraTniEdGmMAy1yOJ2VYapcQJQAnptTALDovc+gjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ljUUPJo5; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: maarten.lankhorst@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716753553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jxmqEj250Efur2ANihKilbqvxEioI+rBu1p7H01pzAk=;
	b=ljUUPJo5WMDcfBAd7LxoCQoBhDiI8LAgymmYrjMZri0/3IqB3x3kvXmKGBoaIDgAsNRdvQ
	0Wv1vkXMnrEw4EQ191dItUT1zsZAsWPIAw8in9xEed5nCcCdClP+AiiNYdjzu2azrWALp6
	OxYsqPSKVmHP8++sTaMsiHmrAFKC1Sg=
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: markus.elfring@web.de
X-Envelope-To: sui.jingfeng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v2 0/3] drm/loongson: Introduce component framework support
Date: Mon, 27 May 2024 03:58:23 +0800
Message-Id: <20240526195826.109008-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce component framework to bind child and sibling devices, for better
modularity and offload the deferral probe issue to submodule if it need to
attach exterinal module someday. Also for better reflect the hardware
layout.

Hardware units that come with PCIe are all ready to drive, but there are
some board specific modules will return -EPROBE_DEFER to us. We need all
submodules ready to use before we can register the drm device to userspace.

The idea is to device the exterinal module dependent part and exterinal
module independent part. For example, the display controller and the
GPIO-I2C just belong to exterinal module independent part. While the
outputs are just belong to exterinal module dependent part.

We abstract the output ports as child devices, the output ports may
consists of encoder phy and level shifter. Well, the GPU are standalone
siblings relative to the DC. Those units are relatively separated
hardware units from display controller itself.

By design, the display controller PCI(e) is selected as master, gpio-i2c
go with master. Manually created virtual subdevice functional as agents
for the master, it could return the -EPROBE_DEFER back to the drvier core.
This allows the master don't have to tear down everything, thereore
majority setups work can be preserved. The potential cyclic dependency
problem can be solved then.

v1 -> v2:
	* Squash patch 0002 and patch 0003 into one
	* Fill type and improve commit message

Sui Jingfeng (3):
  drm/loongson: Add a helper for creating child devices
  drm/loongson: Introduce component framework support
  drm/loongson: Add dummy gpu driver as a subcomponent

 drivers/gpu/drm/loongson/Makefile             |   4 +
 drivers/gpu/drm/loongson/loong_gpu_pci_drv.c  |  90 ++++++++
 drivers/gpu/drm/loongson/loong_gpu_pci_drv.h  |  27 +++
 drivers/gpu/drm/loongson/loongson_device.c    |  42 ++++
 drivers/gpu/drm/loongson/loongson_module.c    |  26 ++-
 drivers/gpu/drm/loongson/loongson_module.h    |   8 +
 drivers/gpu/drm/loongson/lsdc_drv.c           | 217 +++++++++++-------
 drivers/gpu/drm/loongson/lsdc_drv.h           |  45 +---
 drivers/gpu/drm/loongson/lsdc_i2c.c           |   5 +-
 drivers/gpu/drm/loongson/lsdc_i2c.h           |   3 -
 drivers/gpu/drm/loongson/lsdc_output.c        | 176 ++++++++++++++
 drivers/gpu/drm/loongson/lsdc_output.h        |  38 ++-
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c |   3 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c |  17 +-
 14 files changed, 564 insertions(+), 137 deletions(-)
 create mode 100644 drivers/gpu/drm/loongson/loong_gpu_pci_drv.c
 create mode 100644 drivers/gpu/drm/loongson/loong_gpu_pci_drv.h
 create mode 100644 drivers/gpu/drm/loongson/lsdc_output.c

-- 
2.34.1


