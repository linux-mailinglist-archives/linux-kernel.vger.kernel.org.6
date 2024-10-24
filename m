Return-Path: <linux-kernel+bounces-379201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5F59ADB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F7FB21033
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E779E172BAE;
	Thu, 24 Oct 2024 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LfotmGBr"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA051662EF;
	Thu, 24 Oct 2024 05:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747281; cv=none; b=YK7+dUAvu1O+FPmuJrB2rOoqe2VmN5xtyWYs/j7zLxo+J8hJWS9PJiWQVx0FDYl41uoi/vZj+B7Bn+K2K0F1NlI1eKxTMgDuNYFpfe6mtglpZ6CdayKK0tZpuOycaWS+emCD1y0ydw0m16y8meQ1LSgVtKWPzDXtxFWLRLkHGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747281; c=relaxed/simple;
	bh=P0qB3XuVcTLwJH//aBf5M6QnOTxe7FOuOqqRoy+TWpM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=auVAggHW0mdY7Jas4yTFgtvkf5NZ3Oq+NS3drp+L0AGaOy1guF/yFrzrYtziXDRSnipakJ5WA+/8PLdb0WlE8Z6Ylhlwd43F4qlITpfsu1V3st03a+t7MfS26MNHT1qrva7Upm6J5UgQYfgVtlssxvXGbeAPbHbBHGwM+K9iydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LfotmGBr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49O5L9Cq109673;
	Thu, 24 Oct 2024 00:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729747270;
	bh=dfJ8c6chkv90K3yOhy0wiD/mADpHOHoC7n+9fhR4gQE=;
	h=From:Subject:Date:To:CC;
	b=LfotmGBrKMEWOUpaXnmQLExRyewHyX3trMxA54TyIYrAc552mSFsvhgj0fD3klKUi
	 bQtxLtIz2U8k2l31ObPOaUUBjTOPef4BkGEX5ADYQwP0wA/c5l/+m+VtOH/mVwJ89p
	 KW8l/xc0qti8l2cQYfsoSyJVakcpO2s0t0lRKRKU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5L9XT024906;
	Thu, 24 Oct 2024 00:21:09 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 00:21:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 00:21:09 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5L4l8090467;
	Thu, 24 Oct 2024 00:21:05 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v6 00/12] Add bootph-all property for J7 boards
Date: Thu, 24 Oct 2024 10:50:57 +0530
Message-ID: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADnZGWcC/3XPS2rDMBCA4asErasyGj2dVe8RutCzFiSxsVyTE
 nz3yikk9ULLf2C+Ye6kxCnHQo6HO5nikkserjXU24H43l6/Is2hNkFAAYIDdYJ+j2Weor1QNwz
 z2FN7PlMThHYanYcUSF0ep5jy7QGfPmv3uczD9PO4s7Bt+kdK0C1yYRSoV0GiksxIlT7m/O6HC
 9m8BV+GBtk0sBodgFaGxaCD2Rn8n9F+beGb4TxG753qJO4M8TIME01DVCOhEwoBIKHcGfJpMED
 eNGQ1bKdFAMU1WPc01nX9BQbgZnPJAQAA
X-Change-ID: 20240430-b4-upstream-bootph-all-8d47b72bc0fd
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
        Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis
	<afd@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729747264; l=2759;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=P0qB3XuVcTLwJH//aBf5M6QnOTxe7FOuOqqRoy+TWpM=;
 b=TH2isT7Kn89O1yfs5WE14YyDH2IghqDsuUFvPVdEo91SFT3mysxSXBPTy3A2tQglt2i5EWNoz
 Zeb2X8AU0YXCuMzlcJpZ/gG6ak5LGUmay18dMw8s2ewsEhePeKfeuUr
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The idea of this series is to add bootph-all and bootph-pre-ram property
in all the leaf nodes wherever required and cleanup any other places where
bootph-all/bootph-pre-ram exist in the parent nodes as well since now
the bootloaders can handle it.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v6:
- Fix the commit message and remove ospi1 ( Aniket )
- Link to v5: https://lore.kernel.org/all/20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com

---
Manorit Chawdhry (12):
      arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup: Move bootph from mcu_timer1 to mcu_timer0
      arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup: Remove parent nodes bootph-*
      arm64: dts: ti: k3-j784s4: Add bootph-* properties
      arm64: dts: ti: k3-j721s2: Add bootph-* properties
      arm64: dts: ti: k3-j721e: Add bootph-* properties
      arm64: dts: ti: k3-j7200: Add bootph-* properties
      arm64: dts: ti: k3-j784s4-j742s2-evm-common: Remove parent nodes bootph-*
      arm64: dts: ti: k3-j721s2-evm*: Add bootph-* properties
      arm64: dts: ti: k3-am68-sk*: Add bootph-* properties
      arm64: dts: ti: k3-j721e-evm*: Add bootph-* properties
      arm64: dts: ti: k3-j721e-sk*: Add bootph-* properties
      arm64: dts: ti: k3-j7200-evm*: Add bootph-* properties

 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts       |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi             |  5 +++--
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts  | 13 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi              |  2 ++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi        | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi            |  6 ++++++
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts  | 16 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi              |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi        | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                 | 18 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi            |  5 +++++
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi             |  1 +
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi       | 13 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi           |  3 +++
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi |  9 ---------
 .../dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi     | 10 ++++++----
 17 files changed, 131 insertions(+), 15 deletions(-)
---
base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
change-id: 20240430-b4-upstream-bootph-all-8d47b72bc0fd

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


