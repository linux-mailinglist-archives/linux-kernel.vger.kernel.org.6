Return-Path: <linux-kernel+bounces-188518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C02338CE2F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDBEBB226C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032C0129E98;
	Fri, 24 May 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nQ8LxpPi"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D1129A6D;
	Fri, 24 May 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541539; cv=none; b=FWiCIv7fVfX748rmKioeDTxy6ZoBTwMTwLa3dvlwfGNVcS+iMfF9EpeIg4HrjFdkND7znkr4hUWdhrgPI8kJmCwtvShWPxTzFXcdDDu4VxTqHa04sjeuNfePNwQNnmLXdpgUs0jVEELUz7OuXmLF3RYTmqsKv3wQYhID0ZLjuDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541539; c=relaxed/simple;
	bh=+zt3DFxO0fnlmonm94eGfk5hJBfckoxqrYa5hNmXlqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SRZZOLIicL0zsFB8CJcKFg6lgA1++K9zi+HmSz4jbmoRJTXs6SIi913zKqtWEU0oSgtnfmVpxI03r5nM72xTGWx7qMQC8rxVNsfMOFLuG/xw9RP6EazY4kjeDq3ywr5rGM2a78mXcnZ0HBsqbJPQjxn+xfc0XVYctJ0BC5JjG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nQ8LxpPi; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O95K8m071471;
	Fri, 24 May 2024 04:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716541520;
	bh=ERdEWnZaf8wEUS9yivBfRntCDoHPogtyIgugw5XQBgc=;
	h=From:To:CC:Subject:Date;
	b=nQ8LxpPiJVzvV6eCpzfGnAjTwECW/tyi3KUurUc5i/IvuLvrsN4bjE5+GSxt6X8e4
	 UygUl+hx/uBm+JV53cVSxT/AztzzIBRurI+yrKUL34kfDLZTbM2goxA7Rjb8u4+QdT
	 pqZSarm40pIjE9RIWefO6o0kaRW/BPTyThQqQPsc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O95KCR029558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:05:20 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:05:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:05:19 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O95F7F017455;
	Fri, 24 May 2024 04:05:15 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/7] Add PCIe and USB device-tree support for J722S
Date: Fri, 24 May 2024 14:35:07 +0530
Message-ID: <20240524090514.152727-1-s-vadapalli@ti.com>
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

This series adds device-tree support for PCIe and USB on J722S SoC.
This series is the v3 for the v2 USB series at:
https://lore.kernel.org/r/20240513114443.16350-1-r-gunasekaran@ti.com/
and is also the v1 series for enabling PCIe device-tree support for J722S.

Since the v2 USB series combined portions of the PCIe changes incorrectly,
I have updated this series to contain USB specific changes in the first 3
patches of this series while moving the PCIe specific changes to the
remaining 4 patches in this series.

Series is based on linux-next tagged next-20240524.

v2 for USB:
https://lore.kernel.org/r/20240513114443.16350-1-r-gunasekaran@ti.com/
Changes since v2 USB series:
- For patch 1:
  => Renamed serdes0_ln_ctrl to serdes_ln_ctrl to keep the format
  consistent across SoCs where a single node is sufficient to
  represent the Lane-Muxing for all instances of the Serdes.
- For patch 2:
  => No changes since v2.
- For patch 3:
  => Renamed serdes0_ln_ctrl to serdes_ln_ctrl corresponding to the change
  made in patch 1.
  => Dropped Serdes1 idle-states since it has not yet been added in the
  serdes_ln_ctrl node.
  => Dropped Serdes1 specific Lane-Muxing macros in "k3-serdes.h".
  => Added newline after /* J722S */ in "k3-serdes.h" following the file
  convention.

v1 for USB:
https://lore.kernel.org/r/20240429120932.11456-1-r-gunasekaran@ti.com/
Changes since v1 USB series:
- Introduced k3-j722s-main.dtsi newly to add the main domain
  peripherals that are present additionally in J722S as suggested by
  Andrew Davis.
- Used generic node names as suggested by Roger Quadros.
- Removed the aliases for usb as suggested by Rob Herring.

This series has no dependencies and has been tested on J722S-EVM.
Logs testing PCIe functionality with an NVMe SSD connected to the
J722S-EVM and testing USB functionality limited to "lsusb" output:
https://gist.github.com/Siddharth-Vadapalli-at-TI/6a9cdcec24add0114e63db736b3e23fb

Regards,
Siddharth.

Ravi Gunasekaran (3):
  arm64: dts: ti: k3-j722s-main: Add support for SERDES0
  arm64: dts: ti: k3-j722s-main: Redefine USB1 node description
  arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1

Siddharth Vadapalli (4):
  arm64: dts: ti: k3-serdes: Add Serdes1 lane-muxing macros for J722S
  arm64: dts: ti: k3-j722s: Add lane mux for Serdes1
  arm64: dts: ti: k3-j722s-main: Add WIZ1 and Serdes1 nodes
  arm64: dts: ti: k3-j722s: Add support for PCIe0

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   |  72 +++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 177 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi      |   5 +
 arch/arm64/boot/dts/ti/k3-serdes.h        |   8 +
 4 files changed, 262 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi

-- 
2.40.1


