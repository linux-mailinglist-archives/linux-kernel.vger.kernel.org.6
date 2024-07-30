Return-Path: <linux-kernel+bounces-267201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B389940E57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34321283D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B172F196DA4;
	Tue, 30 Jul 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WqBs0YqF"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C191922CA;
	Tue, 30 Jul 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333249; cv=none; b=UeghD8oVEaXytOqu4WamdkpSJ8gNoPUSSVhN+xfIrh2BpWYWrl7CwQVeQ8LMgO+wvVTojUP/1pZY6dzFH+ZT7gUQjYrIMY1IrGQMn/LfPbtLl6J9H6USBnXDza60f7Bdit92rorPgYuZE28wPtqq+rolEpZg8SY7/vGve/CnXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333249; c=relaxed/simple;
	bh=F9DKMMqI0vWmkAkIJUVRr0xfxbUyOJ/q9rg1X098EIQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=TmDj6qj5oys9KKyzepjxeAi6JyWl+FwJ/mC0GAE4wdCZ73Ogv8jrpHgvedUjfMNzHf1wg5x+1/U4G1TvSjd3/R/UvckiN5kmd2/id6DZe4cQWwd/zISs0SVEIEnrM1YA2MqL0yDtI6ohd/9BLLr6IEOCsQ6XjFFxkN91Myv7XAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WqBs0YqF; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U9s1Yt006886;
	Tue, 30 Jul 2024 04:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722333241;
	bh=ugtmiRpAmCqi4LtLpNLj8IUxCysgBMlMyAKDsxH2xuI=;
	h=From:Subject:Date:To:CC;
	b=WqBs0YqFkpy/2jYdvIUN/y5EUmJ2Lc/iTNUzW+SiuI0GbgE7SlyRyJZjs2HIJaGDF
	 k+FgytGSYkhU1PTvZ/joXUigW9ODm2NcaAx+h0bXtjrUanyzd895bdoDpAnWle7d4M
	 5cE6nXQNQ/Neak0GT+GulmaHQGMFisw1/CPjGIhw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U9s16c087396
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 04:54:01 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 04:54:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 04:54:00 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46U9rulu008969;
	Tue, 30 Jul 2024 04:53:56 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v3 0/5] Add bootph-all property for J7 boards
Date: Tue, 30 Jul 2024 15:23:50 +0530
Message-ID: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC64qGYC/3XNSw6CMBSF4a2Yjq25LfShI/dhHNAH0gQoaWujI
 ezdgomOGP4nud+dUbTB2YguhxkFm110fixRHQ9Id834sNiZ0ogCraGuAKsaP6eYgm0GrLxPU4e
 bvsfS1EIJqjS0BpXjKdjWvTb4di/duZh8eG9/MlnXL8lA7JGZYMCaG0Y5I5Lx9prcSfsBrV6mf
 0MA2zVoMc4AgktijTDyZyzL8gFF3hhk/QAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Manorit Chawdhry
	<m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722333236; l=2257;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=F9DKMMqI0vWmkAkIJUVRr0xfxbUyOJ/q9rg1X098EIQ=;
 b=kTg+meFlXaPl+osTL9xBi6uY41w2xa4XOxtF+EcnrAxFErPFHHiUPyDUJZUTmhHZfniV2SHhc
 hu5awn6WumiCzM0njmL0uaiprzCVw1OS2+/e7WyfMTXu7oeQbO0ey9a
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The idea of this series is to add bootph-all and bootph-pre-ram property
in all the leaf nodes wherever required and cleanup any other places where
bootph-all/bootph-pre-ram exist in the parent nodes as well.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v3:
* Vignesh
- Remove bootph-all from sms/dmsc node

- Remove bootph-all j7200 from main_uart2 and mcu_cpsw
- Link to v2: https://lore.kernel.org/r/20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com

---
Manorit Chawdhry (5):
      arm64: dts: ti: k3-j721s2*: Add bootph-* properties
      arm64: dts: ti: k3-j784s4*: Remove bootph properties from parent nodes
      arm64: dts: ti: k3-am68*: Add bootph-* properties
      arm64: dts: ti: k3-j721e*: Add bootph-* properties
      arm64: dts: ti: k3-j7200*: Add bootph-* properties

 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts     | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi           |  2 ++
 .../arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi            |  2 ++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi          |  7 +++++++
 .../arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi            |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  9 +++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts               | 18 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi          |  5 +++++
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts      | 14 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi           |  2 ++
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi         |  2 ++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts             |  9 +--------
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  8 ++++----
 17 files changed, 139 insertions(+), 12 deletions(-)
---
base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
change-id: 20240430-b4-upstream-bootph-all-8d47b72bc0fd

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


