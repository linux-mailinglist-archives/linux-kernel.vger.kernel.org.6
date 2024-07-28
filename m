Return-Path: <linux-kernel+bounces-264601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E693E5E2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5922824D1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40157333;
	Sun, 28 Jul 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lLEZN+j4"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1A47F6B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180571; cv=none; b=BByCTzerz5OJmsoXI95JqHO4FsURT3FlgG3sqW8yZuMx/i5x6lP1xZueo6nRnoix5z91G/BixeCDnciAy8r08GUFAE7dOLT2KeHBcJPROck/xnngvtiFn5CaOfrabt0xPH/td5Lvns7/JejNl5L3MuBJxZicyCxOVm9BiF7118Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180571; c=relaxed/simple;
	bh=snbKvQiQwX9p4F4uFMVThi/BGL0Bl9ZClA+6AS0YOh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/WQ10m/YJL8W0Jv5Nt9LqEmY43R1fMXT97R8Vu9JKPfVqNpiGX3G4JKgdzKLI7cpDNTcZfXBLxOQkACGqe6pgnXyeiirNSe88aaqhC+nbl9KL388fidQXsLz/nQ+OKJjdeRyVr5DVkVapC/rHkxDU0Ow6JHsHTwcCw9ESPuZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lLEZN+j4; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722180566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hQhmC8xdv28YX/UUjbioyIpWdbinTpv06ZDMyyHEVbw=;
	b=lLEZN+j4/3ryP0CVzY/3Cfa4ylonXexUmcPKuHy+UYLM/xYIFm84ivacMAZ6la0q7iDnVY
	sbSUbbbrElcV6hnLEaaa7dhLdJgC8LkLue6XB0Etg2ud/TEsxx0Z//sEBnsGtYVYmbGLgf
	F6SNfw4bNrXS+HpMuedOYuJN7qg3MoU=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v5 0/2] drm/loongson: Introduce component framework support
Date: Sun, 28 Jul 2024 23:28:56 +0800
Message-ID: <20240728152858.346211-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce component framework to bind modules and to avoid potential
cyclic dependency problem.

v1 -> v2:
	* Squash patch 0002 and patch 0003 into one
	* Fill typos and improve commit message

v2 -> v3:
	* Squash all patch into one
	* Create another platform device as drm proxy master.
	* Make LSDC PCI driver as a subcomponent as well.

v3 -> v4:
	* Split sharable structure from struct lsdc_device.
	* Make LSDC as a subcomponent.

v4 -> v5:
	* Split to two patch.
	* Fix typos and cleanup.

Tested with ls3a6000+ls7a2000, dmesg | grep loongson:

[   10.357813] loongson.lsdc 0000:00:06.1: Found LS7A2000 bridge chipset, revision: 2
[   10.370737] loongson.lsdc 0000:00:06.1: i2c-6(sda pin mask=1, scl pin mask=2) created
[   10.466747] loongson.lsdc 0000:00:06.1: i2c-7(sda pin mask=4, scl pin mask=8) created
[   10.479231] loongson.lsdc 0000:00:06.1: lsdc.output.agent.0 probed, type: HDMI-or-VGA
[   10.507553] loongson.lsdc 0000:00:06.1: lsdc.output.agent.1 probed, type: HDMI
[   11.595162] loongson.loonggpu 0000:00:06.0: LoongGPU(TM) PCI driver probed
[   11.699961] loongson.drm.proxy loongson.drm.proxy: probed
[   11.717768] loongson.lsdc 0000:00:06.1: [drm] Dedicated vram start: 0xe0020000000, size: 256MiB
[   11.727041] loongson.lsdc 0000:00:06.1: [drm] dc: 400MHz, gmc: 1200MHz, gpu: 480MHz
[   11.735138] loongson.drm.proxy loongson.drm.proxy: bound lsdc.output.agent.0 (ops lsdc_output_component_ops [loongson])
[   11.746343] loongson.drm.proxy loongson.drm.proxy: bound lsdc.output.agent.1 (ops lsdc_output_component_ops [loongson])
[   11.763218] loongson.lsdc 0000:00:06.1: lsdc irq: 61
[   11.768258] loongson.drm.proxy loongson.drm.proxy: bound 0000:00:06.1 (ops lsdc_pci_component_ops [loongson])
[   11.778138] loongson.lsdc 0000:00:06.1: [drm] LoongGPU(TM): LG110, revision: 0, Host: LS7A2000
[   11.786711] loongson.lsdc 0000:00:06.1: [drm] LoongGPU(TM) irq: 62
[   11.792853] loongson.drm.proxy loongson.drm.proxy: bound 0000:00:06.0 (ops loonggpu_pci_component_ops [loongson])
[   11.843337] loongson.lsdc 0000:00:06.1: [drm] VRAM: 16384 pages ready
[   11.849757] loongson.lsdc 0000:00:06.1: [drm] GTT: 32768 pages ready
[   11.856399] [drm] Initialized loongson 1.0.0 for 0000:00:06.1 on minor 1
[   11.931176] loongson.lsdc 0000:00:06.1: [drm] fb0: loongsondrmfb frame buffer device
[   11.963180] loongson: total 4 drivers registered
[   16.040603] loongson.lsdc 0000:00:06.1: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=io+mem


Tested with ls3a5000+ls7a1000, dmesg | grep loongson:

[   10.887229] loongson.lsdc 0000:00:06.1: Found LS7A1000 bridge chipset, revision: 1
[   10.907694] loongson.lsdc 0000:00:06.1: i2c-6(sda pin mask=1, scl pin mask=2) created
[   10.940652] loongson.lsdc 0000:00:06.1: i2c-7(sda pin mask=4, scl pin mask=8) created
[   10.973292] loongson.lsdc 0000:00:06.1: lsdc.output.agent.0 probed, type: DVO
[   10.993424] loongson.lsdc 0000:00:06.1: lsdc.output.agent.1 probed, type: DVO
[   11.011791] loongson.drm.proxy loongson.drm.proxy: probed
[   11.048820] loongson.lsdc 0000:00:06.1: [drm] Dedicated vram start: 0xe0030000000, size: 64MiB
[   11.087580] loongson.lsdc 0000:00:06.1: [drm] dc: 264MHz, gmc: 529MHz, gpu: 529MHz
[   11.095885] loongson.drm.proxy loongson.drm.proxy: bound lsdc.output.agent.0 (ops lsdc_output_component_ops [loongson])
[   11.106794] loongson.drm.proxy loongson.drm.proxy: bound lsdc.output.agent.1 (ops lsdc_output_component_ops [loongson])
[   11.128480] loongson.lsdc 0000:00:06.1: lsdc irq: 55
[   11.135618] loongson.drm.proxy loongson.drm.proxy: bound 0000:00:06.1 (ops lsdc_pci_component_ops [loongson])
[   11.146096] loongson.lsdc 0000:00:06.1: [drm] VRAM: 4096 pages ready
[   11.152492] loongson.lsdc 0000:00:06.1: [drm] GTT: 32768 pages ready
[   11.159720] [drm] Initialized loongson 1.0.0 for 0000:00:06.1 on minor 0
[   11.243566] loongson.lsdc 0000:00:06.1: [drm] fb0: loongsondrmfb frame buffer device
[   11.285817] loongson: total 4 drivers registered


Tested with builtin debugfs interface:

[root@fedora 0]# cd /sys/kernel/debug/dri/0000\:00\:06.1/
[root@fedora 0000:00:06.1]# ls
benchmark  clients  crtc-1     framebuffer  HDMI-A-1          mm     vram_mm
bos        clocks   encoder-0  gem_names    HDMI-A-2          name
chips      crtc-0   encoder-1  gtt_mm       internal_clients  state

[root@fedora 0000:00:06.1]# cat bos
bo[0000][0000000033d33c9c]: size:     8112KiB VRAM offset:        0
bo[0001][0000000059581d0a]: size:     8112KiB VRAM offset:   7ec000
bo[0002][00000000e7eec263]: size:       16KiB VRAM offset:        0
bo[0003][00000000d4fb6ef2]: size:       16KiB VRAM offset:  fff8000
Pinned BO size: VRAM: 8128KiB, GTT: 0 KiB

[root@fedora 0000:00:06.1]# cat chips
Running on cpu 0xc0, cpu revision: 0x11
Contained in: LS7A2000 bridge chipset

[root@fedora 0000:00:06.1]# cat benchmark
Copy bo of 8100KiB 60 times from GTT to GTT in 48ms: 10125MB/s
Copy bo of 8100KiB 60 times from GTT to VRAM in 104ms: 4673MB/s
Copy bo of 8100KiB 60 times from VRAM to GTT in 13480ms: 36MB/s


Also run IGT kms_flip and fbdev tests, no obvious problems found.

Sui Jingfeng (2):
  drm/loongson: Introduce component framework support
  drm/loongson: Add dummy gpu driver as a subcomponent

 drivers/gpu/drm/loongson/Makefile             |   5 +
 drivers/gpu/drm/loongson/loonggpu_pci_drv.c   | 163 +++++++++
 drivers/gpu/drm/loongson/loonggpu_pci_drv.h   |  35 ++
 drivers/gpu/drm/loongson/loongson_device.c    |  30 ++
 drivers/gpu/drm/loongson/loongson_drv.c       | 299 +++++++++++++++
 drivers/gpu/drm/loongson/loongson_drv.h       | 108 ++++++
 drivers/gpu/drm/loongson/loongson_module.c    |  84 ++++-
 drivers/gpu/drm/loongson/loongson_module.h    |  32 ++
 drivers/gpu/drm/loongson/lsdc_benchmark.c     |  12 +-
 drivers/gpu/drm/loongson/lsdc_benchmark.h     |   2 +-
 drivers/gpu/drm/loongson/lsdc_crtc.c          |   4 +-
 drivers/gpu/drm/loongson/lsdc_debugfs.c       |  41 +--
 drivers/gpu/drm/loongson/lsdc_drv.c           | 346 +++++-------------
 drivers/gpu/drm/loongson/lsdc_drv.h           |  89 +----
 drivers/gpu/drm/loongson/lsdc_gem.c           |  42 ++-
 drivers/gpu/drm/loongson/lsdc_gem.h           |  13 +
 drivers/gpu/drm/loongson/lsdc_gfxpll.c        |  33 +-
 drivers/gpu/drm/loongson/lsdc_gfxpll.h        |   3 +-
 drivers/gpu/drm/loongson/lsdc_i2c.c           |  55 ++-
 drivers/gpu/drm/loongson/lsdc_i2c.h           |  21 +-
 drivers/gpu/drm/loongson/lsdc_output.c        | 183 +++++++++
 drivers/gpu/drm/loongson/lsdc_output.h        |  33 +-
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c |   6 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c |  20 +-
 drivers/gpu/drm/loongson/lsdc_pixpll.c        |   4 +-
 drivers/gpu/drm/loongson/lsdc_plane.c         |   4 +-
 drivers/gpu/drm/loongson/lsdc_ttm.c           |  70 ++--
 drivers/gpu/drm/loongson/lsdc_ttm.h           |   4 +-
 28 files changed, 1233 insertions(+), 508 deletions(-)
 create mode 100644 drivers/gpu/drm/loongson/loonggpu_pci_drv.c
 create mode 100644 drivers/gpu/drm/loongson/loonggpu_pci_drv.h
 create mode 100644 drivers/gpu/drm/loongson/loongson_drv.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_drv.h
 create mode 100644 drivers/gpu/drm/loongson/lsdc_output.c

-- 
2.43.0


