Return-Path: <linux-kernel+bounces-241966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E739281FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B93B20F05
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6AE14036F;
	Fri,  5 Jul 2024 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CpXQ/lPE"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A913C3F9;
	Fri,  5 Jul 2024 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160803; cv=none; b=XsjNh2DHZ3DWth8+XmBKCeGm5vmIoy3U7rAvSrnDBO/CbHIVRM9ES9wrz+zu+EZvoeIsk4D61P89EMC0RZmD6jT318A/QXOpRjbgjpIo9DV8qHGypChX5tHtUhgFacrn9g5LajWslf3lR6xH34geTaQ4NlF43GQaTzFtZsui7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160803; c=relaxed/simple;
	bh=PsOCdDQHDkkN5yk81vB/MxWYDnho+hQKOhRjkfkYaO4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CCtqNOA9MpP55glEKYQ7DhpAPwnIHRkIRfM3dhSPGtT72sFuH5bpsfJ19HSRE+tPEwKg44EFwp6iy5z90AzkSdfbbZSOBlq2dfha0C8H6NYejUC3XlLJbSm0ZgIlnMIv1YSXyVNDTKZJANm7yePPXH1tQZ6rgVgy2HVicAEQx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CpXQ/lPE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4656QXaY056775;
	Fri, 5 Jul 2024 01:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720160793;
	bh=IV0n6ijyKfh1YRqKcxTC4rIe295gDQGgyvmuFTwWCaQ=;
	h=From:Subject:Date:To:CC;
	b=CpXQ/lPEX4HnZ2Ru2lCxzKFwJwfJsRWDL66CA8Ot+AVGwFd+NhcEIcQ/foUp7uqFI
	 KCqYJPre0/WbeliAtZ1aOPzQGY80paxiSoDCu37Cg9Gqk9EGG6w7onF4EnnfkKDNIe
	 GI+FPOvcAYLtnUyyj5VHUi7gGdoBuIIqoTWPtT3g=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4656QXLY020326
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jul 2024 01:26:33 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 01:26:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 01:26:33 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4656QTjv127334;
	Fri, 5 Jul 2024 01:26:29 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v2 0/5] Add bootph-all property for J7 boards
Date: Fri, 5 Jul 2024 11:56:26 +0530
Message-ID: <20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABKSh2YC/3WNyw6CMBBFf4XM2jGltkBc+R+GRV/IJEBJW4mG9
 N+tuHZ5TnLP3SG6QC7CtdohuI0i+aUAP1VgRrU8HJItDJxxwcSFoRb4XGMKTs2ovU/riGqasLO
 i1S3Xhg0WyngNbqDXEb73hUeKyYf38bPVX/tLStb+S241MjSNlbyRdSeb4ZbobPwMfc75AwvAN
 rK5AAAA
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
	<b-padhi@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720160789; l=2341;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=PsOCdDQHDkkN5yk81vB/MxWYDnho+hQKOhRjkfkYaO4=;
 b=whMcPo9UOIQtQtJn7aSnFNQZETb4y/Mt1U7JxlEI/aAgsSAhGD1qi17ApcSemUbH7g6RqPxf1
 YbbNSOPbBUjBoVs5hzs/pIsl9eRXGyo44uXii3Fomd4dN53mCs8ulEt
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The idea of this series is to add bootph-all and bootph-pre-ram property
in all the leaf nodes wherever required and cleanup any other places where
bootph-all/bootph-pre-ram exist in the parent nodes as well.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v2:

* Aniket
- Change wkup_vtm0 bootph-all to bootph-pre-ram
- Add bootph-all explicitly to dmsc/sms nodes as otherwise the boards
  don't boot

- Cleanup more nodes along with some testing with u-boot.
- Fix build errors
- Link to v1: https://lore.kernel.org/r/20240507-b4-upstream-bootph-all-v1-0-c6d52651856f@ti.com

---
Manorit Chawdhry (5):
      arm64: dts: ti: k3-j721s2*: Add bootph-* properties
      arm64: dts: ti: k3-j784s4*: Remove bootph properties from parent nodes
      arm64: dts: ti: k3-am68*: Add bootph-* properties
      arm64: dts: ti: k3-j721e*: Add bootph-* properties
      arm64: dts: ti: k3-j7200*: Add bootph-* properties

 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi         |  2 ++
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     | 23 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |  2 ++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |  7 +++++++
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     | 20 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             | 18 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |  5 +++++
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |  2 ++
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   | 12 +++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       |  2 ++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           |  9 +--------
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi   |  7 ++++---
 17 files changed, 145 insertions(+), 11 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240430-b4-upstream-bootph-all-8d47b72bc0fd

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


