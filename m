Return-Path: <linux-kernel+bounces-260313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A793A66D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D57C1F23211
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68CB158D74;
	Tue, 23 Jul 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uu9U173Y"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7C13D600
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759696; cv=none; b=puMP71mX0mtxXbfG+tAnTfaGCX9ER3N59AkMfGKL+nXQw34FqTx+7QM1s3c7Jrn2nvmiqBY/xTMGcXpZRgrhqs5TLHFd1fecgXrJFEluFSNcp1HJVEfVLIPgJde7MZOLd1kY+OT1dh0Y2vkr5qkEXWnCktyqV3zObei51MayOT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759696; c=relaxed/simple;
	bh=XEWE6xMz6M86eEd5dnsNmzH44RKvXXzKWp/QxVJQKoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srY4CwiH0OOV4fKy/HcfFWOSblLgPTf3UCxLMC36eT0ndwdj5wjjWtgSSka7lDzFcyOT+9quNQqknaAzuuzr6iJICe/3EUpZ7QproKGJtogWfeEUMES+mgkU0BlQ8GTN5QnCvBeyB2a4gjYtLghlJJyfvRM4saIhLzSR3NlsgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uu9U173Y; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721759690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F4i7HbM8QGABjPfD4TFjiezRqSLPn0D8j/qvuvRy/wI=;
	b=Uu9U173Yk7ia4Y2ldUT5IuVtgXkQbDtp3rdoxuti0wDUT979a45RPKuRxjhgxasV9IENgU
	qNhIUObmR6thPfKsMv0FUguELje/ZYpjgxckBQBB4ee9pjh8EPzo4M22RAoneuEAMAnK0E
	Kfkx4rDoZNPf5YHDDd2INesYTYT5BfY=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Markus Elfring <elfring@users.sourceforge.net>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v4 0/1] drm/loongson: Introduce component framework support
Date: Wed, 24 Jul 2024 02:34:35 +0800
Message-ID: <20240723183436.216670-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce component framework to avoid potential cyclic dependency problem.
The whole driver won't finish bound before all submodules are ready, 
respective modules just do fundimental works in their probe() function,
such as allocating storage for themselves, mapping mmio, and handling the
external dependencies.

v1 -> v2:
	* Squash patch 0002 and patch 0003 into one
	* Fill typos and improve commit message

v2 -> v3:
	* Squash all patch into one
	* Create another platform device as drm proxy master.
	* Make LSDC PCI driver as a subcomponent as well.

v3 -> v4:
	* Tiny refinement and clean up.

Tested with ls3a6000+ls7a2000:

[   11.307887] loongson 0000:00:06.1: Found LS7A2000 bridge chipset, revision: 2
[   11.316701] loongson 0000:00:06.1: i2c-6(sda pin mask=1, scl pin mask=2) created
[   11.325318] loongson 0000:00:06.1: i2c-7(sda pin mask=4, scl pin mask=8) created
[   12.644855] loongson 0000:00:06.1: lsdc-output.0 probed, type: HDMI-or-VGA
[   12.654461] loongson 0000:00:06.1: lsdc-output.1 probed, type: HDMI
[   12.661175] loongson 0000:00:06.1: [drm] dc: 400MHz, gmc: 1200MHz, gpu: 480MHz
[   12.669027] loongson loongson: bound lsdc-output.0 (ops lsdc_output_component_ops [loongson])
[   12.677968] loongson loongson: bound lsdc-output.1 (ops lsdc_output_component_ops [loongson])
[   12.686578] loongson 0000:00:06.1: [drm] Dedicated vram start: 0xe0020000000, size: 256MiB
[   12.700799] loongson 0000:00:06.1: lsdc irq: 61
[   12.700802] loongson loongson: bound 0000:00:06.1 (ops lsdc_component_ops [loongson])
[   12.700825] loongson 0000:00:06.1: [drm] LoongGPU(TM): LG110, revision: 0, Host: LS7A2000
[   12.700835] loongson 0000:00:06.1: [drm] LoongGPU irq: 62
[   12.700837] loongson loongson: bound 0000:00:06.0 (ops loonggpu_component_ops [loongson])
[   12.700870] loongson 0000:00:06.1: [drm] Total 2 outputs
[   12.706489] loongson 0000:00:06.1: [drm] VRAM: 16384 pages ready
[   12.746614] loongson 0000:00:06.1: [drm] GTT: 32768 pages ready
[   12.792895] [drm] Initialized loongson 1.0.0 for 0000:00:06.1 on minor 0
[   12.879707] loongson 0000:00:06.1: [drm] fb0: loongsondrmfb frame buffer device
[   16.952830] loongson 0000:00:06.1: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=io+mem


Tested with ls3a5000+ls7a1000:

[   10.509247] loongson.lsdc 0000:00:06.1: Found LS7A2000 bridge chipset, revision: 2
[   10.574274] loongson.lsdc 0000:00:06.1: i2c-6(sda pin mask=1, scl pin mask=2) created
[   10.624394] loongson.lsdc 0000:00:06.1: i2c-7(sda pin mask=4, scl pin mask=8) created
[   10.643855] loongson.lsdc 0000:00:06.1: loongson.output.agent.0 probed, type: HDMI-or-VGA
[   10.656206] loongson.lsdc 0000:00:06.1: loongson.output.agent.1 probed, type: HDMI
[   11.739180] loongson.loonggpu 0000:00:06.0: LoongGPU PCI driver probed
[   11.875815] loongson loongson: drm proxy probed
[   11.880345] loongson.lsdc 0000:00:06.1: [drm] Dedicated vram start: 0xe0020000000, size: 256MiB
[   11.889019] loongson.lsdc 0000:00:06.1: [drm] dc: 400MHz, gmc: 1200MHz, gpu: 480MHz
[   11.896673] loongson loongson: bound loongson.output.agent.0 (ops lsdc_output_component_ops [loongson])
[   11.906046] loongson loongson: bound loongson.output.agent.1 (ops lsdc_output_component_ops [loongson])
[   11.921372] loongson.lsdc 0000:00:06.1: lsdc irq: 61
[   11.926319] loongson loongson: bound 0000:00:06.1 (ops lsdc_pci_component_ops [loongson])
[   11.934474] loongson.lsdc 0000:00:06.1: [drm] LoongGPU(TM): LG110, revision: 0, Host: LS7A2000
[   11.943055] loongson.lsdc 0000:00:06.1: [drm] LoongGPU irq: 62
[   11.948869] loongson loongson: bound 0000:00:06.0 (ops loonggpu_component_ops [loongson])
[   11.997246] loongson.lsdc 0000:00:06.1: [drm] VRAM: 16384 pages ready
[   12.003665] loongson.lsdc 0000:00:06.1: [drm] GTT: 32768 pages ready
[   12.010295] [drm] Initialized loongson 1.0.0 for 0000:00:06.1 on minor 1
[   12.087732] loongson.lsdc 0000:00:06.1: [drm] fb0: loongsondrmfb frame buffer device
[   12.115177] loongson: total 4 drivers registered
[   16.110934] loongson.lsdc 0000:00:06.1: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=io+mem

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

Also run IGT kms_flip and fbdev tests, no obvious problem found.

Sui Jingfeng (1):
  drm/loongson: Introduce component framework support

 drivers/gpu/drm/loongson/Makefile             |   6 +
 drivers/gpu/drm/loongson/loonggpu_pci_drv.c   | 163 ++++++++
 drivers/gpu/drm/loongson/loonggpu_pci_drv.h   |  35 ++
 drivers/gpu/drm/loongson/loongson_device.c    |  30 ++
 drivers/gpu/drm/loongson/loongson_drv.c       | 293 +++++++++++++
 drivers/gpu/drm/loongson/loongson_drv.h       |  90 ++++
 drivers/gpu/drm/loongson/loongson_module.c    |  84 +++-
 drivers/gpu/drm/loongson/loongson_module.h    |  32 ++
 drivers/gpu/drm/loongson/lsdc_benchmark.c     |  12 +-
 drivers/gpu/drm/loongson/lsdc_benchmark.h     |   2 +-
 drivers/gpu/drm/loongson/lsdc_component.c     | 159 +++++++
 drivers/gpu/drm/loongson/lsdc_crtc.c          |   4 +-
 drivers/gpu/drm/loongson/lsdc_debugfs.c       |  44 +-
 drivers/gpu/drm/loongson/lsdc_drv.c           | 394 ++----------------
 drivers/gpu/drm/loongson/lsdc_drv.h           |  83 +---
 drivers/gpu/drm/loongson/lsdc_gem.c           |  44 +-
 drivers/gpu/drm/loongson/lsdc_gem.h           |  19 +-
 drivers/gpu/drm/loongson/lsdc_gfxpll.c        |  29 +-
 drivers/gpu/drm/loongson/lsdc_gfxpll.h        |   3 +-
 drivers/gpu/drm/loongson/lsdc_i2c.c           |  43 +-
 drivers/gpu/drm/loongson/lsdc_i2c.h           |  12 +-
 drivers/gpu/drm/loongson/lsdc_output.c        | 183 ++++++++
 drivers/gpu/drm/loongson/lsdc_output.h        |  36 +-
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c |  14 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c |  20 +-
 drivers/gpu/drm/loongson/lsdc_plane.c         |   4 +-
 drivers/gpu/drm/loongson/lsdc_ttm.c           |  84 ++--
 drivers/gpu/drm/loongson/lsdc_ttm.h           |   4 +-
 28 files changed, 1318 insertions(+), 608 deletions(-)
 create mode 100644 drivers/gpu/drm/loongson/loonggpu_pci_drv.c
 create mode 100644 drivers/gpu/drm/loongson/loonggpu_pci_drv.h
 create mode 100644 drivers/gpu/drm/loongson/loongson_drv.c
 create mode 100644 drivers/gpu/drm/loongson/loongson_drv.h
 create mode 100644 drivers/gpu/drm/loongson/lsdc_component.c
 create mode 100644 drivers/gpu/drm/loongson/lsdc_output.c

-- 
2.43.0


