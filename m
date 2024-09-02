Return-Path: <linux-kernel+bounces-311315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C453968774
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DACE0B22730
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1419C56E;
	Mon,  2 Sep 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PWUs6k6s"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D319C566;
	Mon,  2 Sep 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280027; cv=none; b=J93sBmLWyWbo3oKKOf0j1ixIDGSfPr0KiqJ7SW+sIgKM6tZfa7sSUpyn5QTN5OiUNjn6cK9mtmrDAIOyOvknxC17W2Hh1O+VQIIAENtKBvSe3LUIUE0FaX3LZ/rQeO6DJRmdKLlCUh1CNbwBm7ph357+arSAcZpPF1nkdv6SAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280027; c=relaxed/simple;
	bh=O6fMx4aZUcqiaFE23C4p1D4ilSZnoIISHadiqvgdeWI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=WTpBt1b+CtWrkO0u/2Q/cs4mAYUutiPjV6l3IWLYnd85MbbCwKl+5jlXK97qkFrvqKwreyYupdr7kYRYhFGuleSbP6UxFzfcRXzl5gPLbYG2hNXjdLZug86FxmmzDNwYevnp09yYfJ7LhjQebbwgo9o5M0AA+dDxUK4WpSLH+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PWUs6k6s; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 482CQuVO000744;
	Mon, 2 Sep 2024 07:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725280016;
	bh=GqfQTypGsovyreDvPW1W4u4mSQvaqE2Q1zGIXLLx578=;
	h=From:Subject:Date:To:CC;
	b=PWUs6k6sJmd3MKvc1w7QpSETOZBw+SS55z12/e4oPv9O2Pi3tpYLolUDg1Ry9VHBZ
	 yQbI5mr2oS1KYxC3trzEK6/EMcEnUXfrJer0QdfkowOX+OC0qnEGK2paahapnMUgqd
	 Q2T5A/+5YlecqHW6tXgzlP0xHum0MMykDbWUNF5A=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 482CQutm003613
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 07:26:56 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 07:26:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 07:26:55 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 482CQpGE023644;
	Mon, 2 Sep 2024 07:26:52 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v6 0/5] Introduce J742S2 SoC and EVM
Date: Mon, 2 Sep 2024 17:56:48 +0530
Message-ID: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAiv1WYC/23OTWrDMBAF4KsErauiGes3q96jdDG2R40KiYPki
 pbgu1dJobXByzfwvTc3UTgnLuJ4uInMNZU0XVqwTwcxnOjyzjKNLQtUqJVFJXstP69lzkxn+eE
 0FpSuJ2tQBTBGiQavmWP6epS+vrV8SmWe8vdjo8L9+lvnAPbqKkiQvg+sYQAfA7zM6XmYzuLeV
 XHlu913KkolLfEYfUAwdtj4bu3397vmR3KRO6LAQW28/vcewq7XzUdEr6ONzsG48Wbl0e9603w
 gIoWkIjH/+WVZfgBZx3dmsQEAAA==
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
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Manorit Chawdhry
	<m-chawdhry@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725280011; l=2226;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=O6fMx4aZUcqiaFE23C4p1D4ilSZnoIISHadiqvgdeWI=;
 b=42gbC6QVYuplgMckubwKsKJzYYDImLLPsSj/QnY3u72iZRB8EcBK0/z9DEGTe/PPPk1aObClz
 pvp3ZZZBLuxA69buss3Vrmgt3wZiiU8fKp3XIW4YAhMqezdWDqVpQ2/
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
Changes in v6:
- Rebased on upstream-next
- Add a comment for MSMC node (Udit)
- Link to v5: https://lore.kernel.org/r/20240828-b4-upstream-j742s2-v5-0-9aaa02a0faee@ti.com

Changes in v5:
- Rebased on upstream-next
- Align j742s2 and j784s4 comments (Siddharth)
- Link to v4: https://lore.kernel.org/r/20240819-b4-upstream-j742s2-v4-0-f2284f6f771d@ti.com

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
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 1488 +---------
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  148 +
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 1490 ++++++++++
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2671 ++++++++++++++++++
 ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
 ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2847 +-------------------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  133 +-
 13 files changed, 4592 insertions(+), 4366 deletions(-)
---
base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
change-id: 20240620-b4-upstream-j742s2-7ba652091550

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


