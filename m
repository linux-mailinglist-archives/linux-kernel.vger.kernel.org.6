Return-Path: <linux-kernel+bounces-269602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896309434BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CD5288666
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518531BD4EA;
	Wed, 31 Jul 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iUs6yaCg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8681BD023;
	Wed, 31 Jul 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445846; cv=none; b=cM2BvMrd+g+iMG5yDDJZ4UBe2BAdRvkJ6utULVXf0m3maolpgAnvokItLNYrccsiCf0+XRJYMM6wwnl8tY0MbldnSS13Pu1tXUHrST+AIFRiJbI0DaDtOpztzaYmjyi5Q6402JmtZVyrDCugwibA+YAKvRpBUNvlBUP4CRadiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445846; c=relaxed/simple;
	bh=0YQrtYhAReQOa1DjkHePgdBXIHtoTYN5cK7um85L3S0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=eazaVUEvNvFTvNZ4hOBuYpG6ul1E7+sRh/09S3ed1oAPkTbb6kSk18reyJClD4loGtXNfqChp9iCE4XJDCtsgwjZNW+0zIBe+z7SiBSu9HvL5jB39JgJ4PS6cP7yuDgjldSdVLaVdA2ChFOHExd4/PkMZNh+pX+jjMHf2kQ9nz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iUs6yaCg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAaGa117246;
	Wed, 31 Jul 2024 12:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722445836;
	bh=bY7GzLyiTBOVWnOKMfGJrWwvJRBukqjlA7MgmYp4JVo=;
	h=From:Subject:Date:To:CC;
	b=iUs6yaCgI+FiD+aURE7txDVpmKEWRf+xutxIkaLPqlsbc5U0cL4n4XIuTqXAjav7/
	 n9SzH1lIM9mqX6XoY0XCuQ7ea0OA/U3dQm4DRk34F1aTL+lw83bGbYJKL8Y28Lkqo7
	 IxqAwZrBmz5PiHxLMITbux3ddZfTvtfPLgy5z6FY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VHAZjK082407
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 12:10:36 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 12:10:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 12:10:35 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAVgN036362;
	Wed, 31 Jul 2024 12:10:32 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v3 0/9] Introduce J742S2 SoC and EVM
Date: Wed, 31 Jul 2024 22:40:26 +0530
Message-ID: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANwqmYC/22OzQ6CMBAGX8X07Jru0hbw5HsYD6UUqQk/abHRE
 N7dgonxwHE2mfl2ZsF6ZwM7H2bmbXTBDX2C7HhgptX93YKrEzPiJLgiDpWA5xgmb3UHj1xQIMg
 rrSTxEqXkLImjt417bdHrLXHrwjT497YRcb1+czniXi4iIBRVaQUaLJoSL5M7maFjayvSn5/tv
 hMJOCht66YoCaUyP39Zlg+hbNut8QAAAA==
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
        Aniket Limaye <a-limaye@ti.com>, Manorit Chawdhry
	<m-chawdhry@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722445831; l=2448;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=0YQrtYhAReQOa1DjkHePgdBXIHtoTYN5cK7um85L3S0=;
 b=D/JbW11x+IC1cYnX0bfAucZA4fxgHux8cq/KQI4c28L5cxCJQTuD4spyCCayJxmWQljIjLUsk
 RGQXCiuY/WdAq3W4RUA0aIz9ydTMdnRGbgo9fHgJ6CGWdPJJ2HtaO6X
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
Changes in v3:
* Nishanth
- Update copyright string
- Add TRM link in SoC file.
- Refactor to split out common soc support between j742s2 and j784s4

- Add DTC_FLAGS as well for j742s2
- Link to v2: https://lore.kernel.org/r/20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com

---
Manorit Chawdhry (9):
      arm64: dts: ti: Move j784s4-{} include files to j784s4-j742s2-{}-common.dtsi
      arm64: dts: ti: Move k3-j784s4.dtsi to k3-j784s4-j742s2-common.dtsi
      arm64: dts: ti: Split k3-j784s4-j742s2-common.dtsi
      arm64: dts: ti: Split k3-j784s4-j742s2-main-common.dtsi
      arm64: dts: ti: Move k3-j784s4-evm.dts to k3-j784s4-j742s2-evm-common.dtsi
      arm64: dts: ti: Split k3-j784s4-j742s2-evm-common.dtsi
      dt-bindings: arm: ti: Add bindings for J742S2 SoCs and Boards
      arm64: dts: ti: Introduce J742S2 SoC family
      arm64: dts: ti: Add support for J742S2 EVM board

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |    6 +
 arch/arm64/boot/dts/ti/Makefile                    |    4 +
 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts           |   26 +
 arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi         |   45 +
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi              |   98 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 1422 +---------
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  150 ++
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 1436 ++++++++++
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2772 ++++++++++++++++++++
 ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
 ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2764 -------------------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  135 +-
 13 files changed, 4540 insertions(+), 4320 deletions(-)
---
base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
change-id: 20240620-b4-upstream-j742s2-7ba652091550

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


