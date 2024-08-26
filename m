Return-Path: <linux-kernel+bounces-302009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8895F891
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB8B1C22556
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E957199234;
	Mon, 26 Aug 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Mod5xaa8"
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D1198E93
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694980; cv=none; b=Uow1/SI7bEJUyHqCnDeJn+yAIEM7rbPpaCs0HLnA+QLFcKKccuj7PMlmNQa40ykz11J2selbN2jFd1PcqRbqWF014hPz1/xQz0kZY16VQdTDqTCuD7IWpVnbTOJRNbzt9YqhxhtkezvcJPP+dMOfOuz4Na6owCY9VEK7ymZUN64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694980; c=relaxed/simple;
	bh=N2djJd0WYYRX9cjM1WBPQCrQ21ATk/CJUK1MHdImUZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gFojDaSqJfEoa/NNnkeQn4TwmS5jHyguXzjVouC0Gi5Ougw5luIFuuR9kb0tL4/xWrb7PLbkxm4kxjfexHq9TnLdyX76d/5kfuc73HtxxbIG7GowgOiZ+HhpCPdJzxTnIoyLkh8+tq3kgSp66RTU00PaSjDu7xHv9iuoWTw6ooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Mod5xaa8; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240826175611b3bfbd5a5d05111adc
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Aug 2024 19:56:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gZKpTRJ8W7SkkE1KwvlOBmtitx/bdQNDzMKnknjtNFQ=;
 b=Mod5xaa8Cia6HwMpy2GXsGPsK2qr7oe8ld/H93MPnR3wf5oVYdFI7Dg/K6Z6ay5SZjK8ET
 Vdhflt8cOFXMOq0a//W6FTeODpVftQypgAd3JjSfE1cGmHgsgIA8CQ8/hxqM44gI6zzPPU8F
 KjBoKSKSNU9Wp83dbl9zD7rh1rs1YdwuGP5pUlh+VUsdkAkjDCUqDXxDhHNtPJhi2FwAN/TK
 4KMJVn9d9seJQCeQU1v1H6dtgnWXS8cVNXMpNpY8EAvOoMGl13IIpbPCdnVkvsZF8PL4xfiS
 gsR1+sBZgZZjKi7lWBuN46x9mtJO6drCaoP4AljNPhGiw+xd/w00OOAA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 0/5] soc: ti: Add and use PVU on K3-AM65 for DMA isolation
Date: Mon, 26 Aug 2024 19:56:04 +0200
Message-ID: <cover.1724694969.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Only few of the K3 SoCs have an IOMMU and, thus, can isolate the system
against DMA-based attacks of external PCI devices. The AM65 is without
an IOMMU, but it comes with something close to it: the Peripheral
Virtualization Unit (PVU).

The PVU was originally designed to establish static compartments via a
hypervisor, isolate those DMA-wise against each other and the host and
even allow remapping of guest-physical addresses. But it only provides
a static translation region, not page-granular mappings. Thus, it cannot
be handled transparently like an IOMMU.

Now, to use the PVU for the purpose of isolated PCI devices from the
Linux host, this series takes a different approach. It defines a
restricted-dma-pool for the PCI host, using swiotlb to map all DMA
buffers from a static memory carve-out. And to enforce that the devices
actually follow this, a special PVU soc driver is introduced. The driver
permits access to the GIC ITS and otherwise waits for other drivers that
detect devices with constrained DMA to register pools with the PVU.

For the AM65, the first (and possibly only) driver where this is
introduced is the pci-keystone host controller. Finally, this series
configures the IOT2050 devices (all have MiniPCIe or M.2 extension
slots) to make use of this protection scheme.

Due to the cross-cutting nature of these changes, multiple subsystems
are affected. However, I wanted to present the whole thing in one series
to allow everyone to review with the complete picture in hands. If
preferred, I can also split the series up, of course.

Jan

CC: Bjorn Helgaas <bhelgaas@google.com>
CC: "Krzysztof Wilczyński" <kw@linux.com>
CC: linux-pci@vger.kernel.org
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>

Jan Kiszka (5):
  dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
  soc: ti: Add IOMPU-like PVU driver
  arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
  PCI: keystone: Add supported for PVU-based DMA isolation on AM654
  arm64: dts: ti: iot2050: Enforce DMA isolation for devices behind PCI
    RC

 .../bindings/soc/ti/ti,am654-pvu.yaml         |  48 ++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  32 ++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  18 +-
 drivers/pci/controller/dwc/pci-keystone.c     | 101 ++++
 drivers/soc/ti/Kconfig                        |   4 +
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/ti-pvu.c                       | 487 ++++++++++++++++++
 include/linux/ti-pvu.h                        |  11 +
 8 files changed, 698 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
 create mode 100644 drivers/soc/ti/ti-pvu.c
 create mode 100644 include/linux/ti-pvu.h

-- 
2.43.0


