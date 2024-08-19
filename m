Return-Path: <linux-kernel+bounces-291808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B9595673A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF831C2198D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0E415CD6A;
	Mon, 19 Aug 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YeJjk0sh"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6D140E50;
	Mon, 19 Aug 2024 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060391; cv=none; b=e58/CZ+YEQTi5AWH9DxaIddDTvaZ/hIPpZ9aGel8IVmMA0lVnpsUfqO51lBpJW04tzY6CmbVTOSNQXPraFcq1yQgyhu1KdgIDF4VXkWWI05bBEh4DoY4Wriknk1beeDD4YoPoYmIdhJFYAr/8MmpJnmZUFt5JjxJ2DHE0FKgWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060391; c=relaxed/simple;
	bh=sdmUcFtODGAvYu5cPefrXyqjQBQ1q32m3g8CCade5p4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CAejUn5RgSwrwk7rumeWmITQhW2vxFDpHgO9B6CyNdc9jMJKYkYy8O18R1y0SpY4AE3Y5KwHGf0ujQiEgGm3oxJMoyyTlhslV9Jo6tkkfiG/oqSLr2rGMPVLEYgE0Z/KM3Mti8KZ7ELeQwdqWilDc1t2sbEcWnf1uhB1SMccm80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YeJjk0sh; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47J9deVi054268;
	Mon, 19 Aug 2024 04:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724060380;
	bh=lUqPLq8CAGLQB9y55KXemaCm/GMfG44CURi+0vrgves=;
	h=From:Subject:Date:To:CC;
	b=YeJjk0shHKCHKvGVnVETRw7AWVkVR11tXef/FRtQwZ6yluCn4JfJkMnh+cU04wOhJ
	 q1RHuYzlILc++aeg0KKi/iIjla0WfJJkW90q5r7Qmf0bM2lhu1S6z4dX/rlZhC/H3k
	 x84MM/Sb94Y+mjslGQjV3oPqraJM75/E92UkN8xI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47J9deo0015739
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Aug 2024 04:39:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Aug 2024 04:39:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Aug 2024 04:39:40 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47J9daOC082967;
	Mon, 19 Aug 2024 04:39:36 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v4 0/5] Introduce J742S2 SoC and EVM
Date: Mon, 19 Aug 2024 15:09:34 +0530
Message-ID: <20240819-b4-upstream-j742s2-v4-0-f2284f6f771d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANYSw2YC/22OzQ6CMBAGX8X07JruUn7qyfcwHgosUhPAtNhoD
 O9uwcRgwnE2mfn2LTw7y14cd2/hOFhvhz6C2u9E1Zr+ymDryIIkKZmRhFLB4+5Hx6aDW67IE+S
 lyVKSGtNUiijeHTf2uUTPl8it9ePgXstGwPn6zeWIW7mAgFCUmhVWWDQaT6M9VEMn5laglZ9sv
 hMIJGSG66bQhGlW/fnJ2t/eT6Jfm7zhxBjNWv78aZo+S881NTEBAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724060376; l=2140;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=sdmUcFtODGAvYu5cPefrXyqjQBQ1q32m3g8CCade5p4=;
 b=zz8M4bz/omi+ud2CoftGiJ37vmE6QRnuSCz7irOiZAVuFXLsHqFE0rdwt/3c1+4wwW2eca80B
 q4cdV6TK9ntA0BxzI2ltEoGMMgtQWKXE5JIcJUoFLpx0lBEUZWV7aCf
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
Support and re-uses most of the stuff from the superset device J784s4.

It initially cleans up the J784s4 SoC files so that they can be
re-usable for j742s2 by introducing -common files. Next it cleans up the
EVM files for j784s4 in a similar way and then goes about adding the
support for j742s2.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v4:
* Nishanth
- Update pcie and serdes related changes.
- Update devicetree ordering for nodes in j784s4 and j742s2.
- Squash the commits and update the description.
- Link to v3: https://lore.kernel.org/r/20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com

---
Manorit Chawdhry (5):
      arm64: dts: ti: Refactor J784s4 SoC files to a common file
      arm64: dts: ti: Refactor J784s4-evm to a common file
      dt-bindings: arm: ti: Add bindings for J742S2 SoCs and Boards
      arm64: dts: ti: Introduce J742S2 SoC family
      arm64: dts: ti: Add support for J742S2 EVM board

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |    6 +
 arch/arm64/boot/dts/ti/Makefile                    |    4 +
 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts           |   26 +
 arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi         |   45 +
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi              |   98 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 1426 +---------
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  150 ++
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 1436 ++++++++++
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2667 ++++++++++++++++++
 ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
 ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2847 +-------------------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  135 +-
 13 files changed, 4532 insertions(+), 4310 deletions(-)
---
base-commit: 367b5c3d53e57d51a5878816804652963da90950
change-id: 20240620-b4-upstream-j742s2-7ba652091550

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


