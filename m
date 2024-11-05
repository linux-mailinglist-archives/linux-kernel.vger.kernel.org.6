Return-Path: <linux-kernel+bounces-396745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6229BD18C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2784EB241E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866861E7C0C;
	Tue,  5 Nov 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="RvOZ5IzM"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51814EC56;
	Tue,  5 Nov 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822388; cv=none; b=WgmXevfBn/5l39NxcN1EOyeZupL08uz2F2FPDin+Gx4/Z4wuwyQwenEHQ7qyL8Wyf2VQYmDh0qHTq9L2FWLpM8aTqOQXtc4w6GsW5rb95dZkhNOHILRqPebZbKsyZX2LNEZpMwRrQ6h8ukgSI3KSh2E0GvwQazG4NrKEN+5NugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822388; c=relaxed/simple;
	bh=UDHyhwvncQQ0+/VdyMOAScTvsSjhCbAR2gGCz0CJwCM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=HMYV5UMVs5u9ajaMCSsvs3dyo0CqL0xek+9GDQveQFayIp11AdW/BPLL01Xltr45/YxghGdUDxgUtq0XOj+x2zb7804twljvb2FusTeem9X9aS6K5NSko3uROdQjs5LhfH9YiSfJFPLZbIVbYVPh2m2og8hA/HowPYqe3avGsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=RvOZ5IzM; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5EF3ux003827;
	Tue, 5 Nov 2024 15:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=dk201812; bh=B/abEZOC6tU29ZHO7iY0iyL
	PlTbvm1PrP9fAvufkChQ=; b=RvOZ5IzMozU1lgsuweUlSSda+F6CiT1eT3D8Rqu
	lEx5hIAcFgOWBGR9NS5yDda6rNI7twTyq/+PIcneeKb/StUOxcAx8GTbCfhI2jux
	UWoLD+qLzMXlKBvEb9HK8ncn/DoMyv3LNVMLZJG637pGWhbOZtRNFWq7Am+6EJra
	9mmA/JJLNlwpA5R2hgpUOEv1XmSN9IcAQHaeUee9zNHfKdC1t/aKrziRRebSFLfM
	3NtiICRvId7ODKgYkSI70m1oW/rD4V5swhgDKuMYSvPzdn/cFAlpVjsWBtvlTitm
	Vw+qVQeER2eHrQxa2wUhsXMdw4mRqvdMQeANx6DcEf/Jr5Q==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 42nb7wta0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 15:58:25 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Tue, 5 Nov 2024 15:58:23 +0000
From: Matt Coster <matt.coster@imgtec.com>
Subject: [PATCH 00/21] Imagination BXS-4-64 MC1 GPU support
Date: Tue, 5 Nov 2024 15:58:06 +0000
Message-ID: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI5AKmcC/x3MMQqAMAxA0atIZgO2pIJeRRw0pppFpRERine3O
 L7h/wwmScWgrzIkudX02AtcXQFv074K6lIMvvHkGu/Q5DKcH0PClvCcLt7wdkjES+yYQwgRSnw
 mifr842F83w/6iJmbaAAAAA==
X-Change-ID: 20241021-sets-bxs-4-64-patch-v1-44cdf9cc555f
To: Frank Binns <frank.binns@imgtec.com>,
        Matt Coster
	<matt.coster@imgtec.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>,
        Sarah Walker
	<sarah.walker@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4626;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=UDHyhwvncQQ0+/VdyMOAScTvsSjhCbAR2gGCz0CJwCM=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRrOcz5P9Fz+ZqrWhsz5lQcO5N9t0L13dTT9dezH9Y97
 Op5NzOzvaOUhUGMg0FWTJFlxwrLFWp/1LQkbvwqhpnDygQyhIGLUwAmcu0kwx9e/SYuyf0XHHc5
 b576QqrZvKb2MOsf36b8rcFWU7oPi7xiZOh0Ly8SFFIXL+AWcDDM/8O97rucxrSs451CJcw7ncJ
 suQE=
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Authority-Analysis: v=2.4 cv=ddzS3mXe c=1 sm=1 tr=0 ts=672a40a1 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=e5mUnYsNAAAA:8 a=NEAV23lmAAAA:8 a=gAcbV61aEvjkjzSdo3MA:9
 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: w_vyz2WEhYYv-zf7zPTWJIEcOasBRElO
X-Proofpoint-ORIG-GUID: w_vyz2WEhYYv-zf7zPTWJIEcOasBRElO

This GPU is found in the TI AM68 family of SoCs, with initial support
added to the k3-j721s2 devicetree and tested on a TI SK-AM68 board.

A suitable firmware binary can currently be found in the IMG
linux-firmware repository[1] as powervr/rogue_36.53.104.796_v1.fw. A
merge request will be sent out for this within the next few weeks.

No new UAPI will be necessary for this platform as it is sufficiently
similar to the already supported AXE-1-16M.

The firmware successfully boots with basic job submission appearing to
work correctly, as tested with a few of Sascha Willems' Vulkan demos[2].
Note these do not necessarily render correctly due to incomplete UMD
support.

UMD support is still a work in progress. The branch at [3] is nearly
feature complete from a Vulkan perspective. We're currently undertaking
a significant rework of the compiler to better accommodate this and
other Rogue GPUs which means we can't do more comprehensive driver
testing at this point. However, we expect to send a Mesa merge request
for the initial version of the compiler (capable of passing some of the
Vulkan CTS smoke tests) within the next few days, with a fully
functional version of the compiler in place by the end of the year.

There are several dt-bindings changes at the beginning of this series.
We expect the result to be versatile enough to handle all Imagination
Rogue GPUs while being a strong foundation to build bindings for the
newer Volcanic architecture (for which we're currently developing
support).

[1]: https://gitlab.freedesktop.org/imagination/linux-firmware/-/tree/powervr
[2]: https://github.com/SaschaWillems/Vulkan
[3]: https://gitlab.freedesktop.org/imagination/mesa/-/tree/dev/bxs

---
Matt Coster (20):
      dt-bindings: gpu: img: More explicit compatible strings
      dt-bindings: gpu: img: Further constrain clocks
      dt-bindings: gpu: img: Power domain details
      dt-bindings: gpu: img: Allow dma-coherent
      drm/imagination: Use more specific compatible strings
      drm/imagination: Add power domain control
      arm64: dts: ti: k3-am62: New GPU binding details
      dt-bindings: gpu: img: Add BXS-4-64 devicetree bindings
      drm/imagination: Revert to non-threaded IRQs
      drm/imagination: Remove firmware enable_reg
      drm/imagination: Rename event_mask -> status_mask
      drm/imagination: Make has_fixed_data_addr a value
      drm/imagination: Use a lookup table for fw defs
      drm/imagination: Use callbacks for fw irq handling
      drm/imagination: Add register required for RISC-V firmware
      drm/imagination: Move ELF fw utils to common file
      drm/imagination: Add platform overrides infrastructure
      drm/imagination: Add device_memory_force_cpu_cached override
      drm/imagination: Add support for TI AM68 GPU
      arm64: dts: ti: k3-j721s2: Add GPU node

Sarah Walker (1):
      drm/imagination: Add RISC-V firmware processor support

 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 122 +++++++++++++--
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |   3 +-
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |  12 ++
 drivers/gpu/drm/imagination/Makefile               |   2 +
 drivers/gpu/drm/imagination/pvr_ccb.c              |  25 +++-
 drivers/gpu/drm/imagination/pvr_device.c           | 130 ++++++++--------
 drivers/gpu/drm/imagination/pvr_device.h           |  77 +++++++++-
 drivers/gpu/drm/imagination/pvr_drv.c              |  58 +++++++-
 drivers/gpu/drm/imagination/pvr_fw.c               |  26 +++-
 drivers/gpu/drm/imagination/pvr_fw.h               |  85 +++++------
 drivers/gpu/drm/imagination/pvr_fw_meta.c          |  23 +--
 drivers/gpu/drm/imagination/pvr_fw_mips.c          |  82 ++---------
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         | 163 +++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     |  21 +++
 drivers/gpu/drm/imagination/pvr_fw_util.c          |  67 +++++++++
 drivers/gpu/drm/imagination/pvr_gem.c              |   3 +
 drivers/gpu/drm/imagination/pvr_gem.h              |   7 +-
 drivers/gpu/drm/imagination/pvr_mmu.c              |   7 +-
 drivers/gpu/drm/imagination/pvr_power.c            | 118 ++++++++++++++-
 drivers/gpu/drm/imagination/pvr_power.h            |   3 +
 drivers/gpu/drm/imagination/pvr_queue.c            |  23 ++-
 drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h    |  17 ++-
 drivers/gpu/drm/imagination/pvr_rogue_riscv.h      |  41 ++++++
 23 files changed, 881 insertions(+), 234 deletions(-)
---
base-commit: d78f0ee0406803cda8801fd5201746ccf89e5e4a


