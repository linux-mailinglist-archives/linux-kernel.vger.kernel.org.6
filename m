Return-Path: <linux-kernel+bounces-197120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1BE8D6675
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95B61C23CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0DC15AAB6;
	Fri, 31 May 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dNvXwOiT"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA3158D78
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172032; cv=none; b=sblDubUmaTEvidrhSzCUxkGD4C7k7Tw5P+vlBXrIm/sP9NirlPDm3w/Uz03VwDMZ1PrMXNaL+AmrewwtEYnajjDmOUAlS4WplnWsMZP1IW16ALxZZ39c98H8GnY40PJeLnHRZG0pT7A6bvWp6S69XvLp8psi/xrdWcX8AOcSRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172032; c=relaxed/simple;
	bh=vZhBBVl8czJfcB3QyAXJ/jzdXjaM/KONvegUH9JNRgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aT99DeAkZd3eEgbwM07fJ8qVa8eCegok60kZuVn33dk7DMv3rNvcCZjIOf7ye+5fgl8Y/NJkGtEdlI8efGuc8rjnRyN2o6xSMdHJto8KMWExZQUWarylTKF34U0JMeITcnZZ2kxOrL5Dq5NoykZANRR3ZzXSHAQhmIrWnxm1MvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dNvXwOiT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717172027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9pcEl9M55lrI6aQcGSoBDLIhIuk5i++OCOwZXRusXEo=;
	b=dNvXwOiTb/9FbHUiQ24hdOMu3t1DwGywelWdjk+2NUVmKRtBIpyCrrYtoSlW435aPZUImW
	xzraYG7o0qWposzy2mO2QwNEtTKiLsSZpRUvsA1c0szkKJfXdi0x+KGI5jPMEtlulrKYb4
	b2gMAZs+ZkKiViisJ+mEtCNS0Dfh0Lc=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: markus.elfring@web.de
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: sean.anderson@linux.dev
X-Envelope-To: bharat.kumar.gogada@xilinx.com
X-Envelope-To: bharatku@xilinx.com
X-Envelope-To: helgaas@kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: krzysztof.kozlowski+dt@linaro.org
X-Envelope-To: lorenzo.pieralisi@arm.com
X-Envelope-To: michal.simek@xilinx.com
X-Envelope-To: devicetree@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/7] PCI: xilinx-nwl: Add phy support
Date: Fri, 31 May 2024 12:13:30 -0400
Message-Id: <20240531161337.864994-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add phy subsystem support for the xilinx-nwl PCIe controller. This
series also includes several small fixes and improvements.

Changes in v4:
- Clarify dt-bindings commit subject/message
- Explain likely effects of the off-by-one error
- Trim down UBSAN backtrace
- Move if to after pci_host_probe
- Remove if in err_phy
- Fix error path in phy_enable skipping the first phy
- Disable phys in reverse order
- Use dev_err instead of WARN for errors

Changes in v3:
- Document phys property
- Expand off-by-one commit message

Changes in v2:
- Remove phy-names
- Add an example
- Get phys by index and not by name

Sean Anderson (7):
  dt-bindings: pci: xilinx-nwl: Add phys property
  PCI: xilinx-nwl: Fix off-by-one in IRQ handler
  PCI: xilinx-nwl: Fix register misspelling
  PCI: xilinx-nwl: Rate-limit misc interrupt messages
  PCI: xilinx-nwl: Clean up clock on probe failure/removal
  PCI: xilinx-nwl: Add phy support
  arm64: zynqmp: Add PCIe phys

 .../bindings/pci/xlnx,nwl-pcie.yaml           |   7 +
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |   1 +
 drivers/pci/controller/pcie-xilinx-nwl.c      | 139 +++++++++++++++---
 3 files changed, 124 insertions(+), 23 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


