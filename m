Return-Path: <linux-kernel+bounces-412925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311929D1154
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A672841AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814341A255C;
	Mon, 18 Nov 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="hiRhsSKJ"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5841A00FE;
	Mon, 18 Nov 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934994; cv=none; b=eMICJbtk5SSWWx8m9LEFeWQz9SKdiselaRWr/u1B+/SxX+mog0aK4Ev8PwxQetv9LsENTukvHSGMEWdExPy9dbW6Qi7iOHg3brxV5ywD4dgeNzl96FTTgt8voVI1jn6UKwvjpze+ME53VWt4m2uYaYy3J7YzkwOAeGERU4ihe08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934994; c=relaxed/simple;
	bh=fljcuho9a33z9+IGkIJUha7C2PNVC3HkxPmhJCcqpLU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Crtb1UihYOZF0eUmE/1JrvXQicSBHQ6n9Ah5+rffImwi+3dY1eBo5Bq5ehEnNfnMTVPxAwYJIINYbZMLfx5k1qS9OUnm/XjvCnb6BQcASa+d6oaMxxLunflaymdeHRD7dMpILPXCJzwReQSMdnNVitni47O8mtHYihB3fWHJdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=hiRhsSKJ; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AICKePe029230;
	Mon, 18 Nov 2024 13:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=dk201812; bh=Np8+f4FVRwom9n2f6Z1Cs1k
	5RrAZHdriQthYWehl0ag=; b=hiRhsSKJ8E6dM1ZLE3zBSvkINCaNHjV4yAAEmNf
	cSZBO0cqn7jLWuDqpYCEtLW+Jmf1XHBN5wp4B4gjeGOLnUReHZrdrONYMp7Z0rth
	J9g2tMkF/Qj5galcHiKNh+B3CEMH0fK6uJB4bCZqj/qKgOz1+1+MCThy4/5qxSKG
	nZNJE/Ko9BN6vJSj7JmBQnGSCpv+1FPbntiSx2zlixshDlegoVdlwHcwufM+1In+
	svPxWR3AvosnjWWrHBQtKJQNCYI3yyakBNf1SQiadnGHWtdFCBhvFYPuFrPUZoRV
	il27VpCaGVTnOTMpcR84M3fT7XkVj6vmT8inGg3Esf4u2Hw==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 42xmc1hmhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Nov 2024 13:02:32 +0000 (GMT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.16.114) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 18 Nov 2024 13:02:31 +0000
From: Matt Coster <matt.coster@imgtec.com>
Subject: [PATCH v2 00/21] Imagination BXS-4-64 MC1 GPU support
Date: Mon, 18 Nov 2024 13:01:52 +0000
Message-ID: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMA6O2cC/3WNzQqDMBCEX0Vy7pYkTUR76nsUD3ZddQ/+kA3BI
 r57U3suzOUbmG92JRSYRN2LXQVKLLzMGeylUDi280DAXWZltXVGWwNCUeC1CTgoHaxtxBGSAee
 w62tE732v8ngN1PN2ip9N5pElLuF9/iTzbX9Ko/0/ZY4GR91NU1X6qrYPnoZIeMVlUs1xHB8Li
 ZXSvQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5000;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=fljcuho9a33z9+IGkIJUha7C2PNVC3HkxPmhJCcqpLU=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMaRbWz02DA67fWzXposnNn11Wr0ovO9CnkrL89Zyj+M+7
 8vFODO2dpSyMIhxMMiKKbLsWGG5Qu2PmpbEjV/FMHNYmUCGMHBxCsBEHsYz/JVjOLww9fTe8+6L
 hT+W5RjIZflWq9tKZpx2dolTfPPtZATDf39Z2S2Hci1VPT0+bJ7Psv//ouDmS2r3Ku79+sJU9du
 ogh0A
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: Ft2HkZhh4669WuV4leAwzxj0rI1wgsH9
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673b3ae8 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=hzDjp0mCheYA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=e5mUnYsNAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=gAcbV61aEvjkjzSdo3MA:9 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: Ft2HkZhh4669WuV4leAwzxj0rI1wgsH9

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
Changes in v2:
- Clarified justification for compatible strings (P1)
- Simplified clocks constraints (P2)
- Simplified power-domains constraints (P3/P4)
- Use normal reg syntax for 64-bit values (P8/P21)
- Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com

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

 .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 107 ++++++++++++--
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
 23 files changed, 864 insertions(+), 236 deletions(-)
---
base-commit: d78f0ee0406803cda8801fd5201746ccf89e5e4a
change-id: 20241021-sets-bxs-4-64-patch-v1-44cdf9cc555f


