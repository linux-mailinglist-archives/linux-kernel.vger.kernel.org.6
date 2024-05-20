Return-Path: <linux-kernel+bounces-183593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED38C9B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD89A280F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9351005;
	Mon, 20 May 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BRKsI0cZ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0714D59E;
	Mon, 20 May 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199939; cv=none; b=UGpP1wDfaH1wYezH9fpZnDbnZOU2q/TLTPexmhZXC77PgV0YuYrph3Y/vdcKxBPM/h0O4xwX/hRkTwN2z1N43JB4tpxDPZXnN4awZ0EFAjsCTeRZ3xRFSXxE8ju5J6HmPF3GqGdu7dk9Hvz71OJt9RnPsDNBDgL/1evz3eioCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199939; c=relaxed/simple;
	bh=t8JHFIczAcdCAF9OJRqKZg4eqdcnQTsX+a1jEg1CWjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0bvvkD2MlmAQ+So/0/OMWM4VUzMVr0+kJkhCxazUVBcaJk8Ts1pPjR1/UUy2f+8ocrfo4BleyQr43DRoIiR5XG+dvpR+3dqkFexZStm1y5poekb36Rpc4HdXNHXwyBKrEVMGlX6B+o7JHAyZKQ2LyLHUmQ/aXUvMrS077oQdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BRKsI0cZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44KABrbs112056;
	Mon, 20 May 2024 05:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716199913;
	bh=l9dQQBkoaq18ik/IFSgRjGWwiw8uydoqC4ckZ4WqZ90=;
	h=From:To:CC:Subject:Date;
	b=BRKsI0cZq6HCnyscELq36UuCvjbSVyTFhfsbXze2JJOOMDwsMnwzHzishae6f6Gvv
	 O/NsXbH0Jd9ZVRCwV9HANhmb9gQdioX8vBbQRwpnNMQha/5Zn9LPW3qMB4ajhQsCFn
	 mpyB6ZlfwERhWFx+h/aBs2fBBqZLhXBD3Wj9NRR8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44KABroq025278
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 May 2024 05:11:53 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 May 2024 05:11:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 May 2024 05:11:53 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44KABnjS060604;
	Mon, 20 May 2024 05:11:50 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <danishanwar@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/3] Add PCIe DT support for TI's J784S4 SoC
Date: Mon, 20 May 2024 15:41:46 +0530
Message-ID: <20240520101149.3243151-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

TI's J784S4 SoC has two Gen3 x4 Lane PCIe Controllers. This series adds
the necessary device-tree support to enable both PCIe instances in Root
Complex mode of operation by default. The device-tree overlay to enable
both instances in Endpoint mode of operation is also present in this
series.

v1:
https://lore.kernel.org/r/20240129114749.1197579-1-s-vadapalli@ti.com
Changes since v1:
- Rebased series on linux-next tagged next-2024020.
- All dependencies mentioned in v1 series have been met. This series has
  no further dependencies for functionality.
- Added "pcie0_ctrl" and "pcie1_ctrl" nodes within the System Controller
  node (scm_conf). This enables reusing the existing
  "ti,syscon-pcie-ctrl" property without having to map the entire System
  Controller region for configuring the PCIe specific registers within
  "scm_conf". This change is also done in the "overlay" file in patch
  3/3 w.r.t. providing the phandle to the pcie0_ctrl and pcie1_ctrl
  nodes to the "ti,syscon-pcie-ctrl" property in the overlay.

Test Logs:
1. PCIe0 and PCIe1 in Root Complex Modes of operation with an NVMe SSD
connected to the PCIe0 instance and the Read Performance measured with
hdparm command:
https://gist.github.com/Siddharth-Vadapalli-at-TI/96c4ca37dd855120516ccdc298548dc6
2. PCIe0 Endpoint Mode functionality verified with the overlay. Logs of
the RC enumerating PCIe0 as an Endpoint:
https://gist.github.com/Siddharth-Vadapalli-at-TI/01b6fb0c9494ab76607b574a728b84da
3. PCIe1 Endpoint Mode functionality verified with the overlay. Logs of
the RC enumerating PCIe1 as an Endpoint:
https://gist.github.com/Siddharth-Vadapalli-at-TI/e844ac92d56131cbb2c134fab621b1e6

Regards,
Siddharth.

Siddharth Vadapalli (3):
  arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
  arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
  arm64: dts: ti: k3-j784s4-evm: Add overlay for PCIe0 and PCIe1 EP Mode

 arch/arm64/boot/dts/ti/Makefile               |  7 +-
 .../dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso  | 79 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 46 +++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 94 +++++++++++++++++++
 4 files changed, 225 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-pcie0-pcie1-ep.dtso

-- 
2.40.1


