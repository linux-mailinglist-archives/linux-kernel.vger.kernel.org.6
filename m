Return-Path: <linux-kernel+bounces-364668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130AB99D7AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77796284443
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515611CF2B6;
	Mon, 14 Oct 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kkEMV0OT"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB71494DD;
	Mon, 14 Oct 2024 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728935251; cv=none; b=QzSZ1xMgx6wA1NWv0YxBDp4CBRxFe1xp9yWDyBijKNsFAhH48uobJfd8Th3iTTLq1QBYNI3BSCGuFkxg8W63/D7lVy9rACef6X39Fld2mgxitzIEnYoMkEOM6yfsVYMfNHY+kMKXJQtfjY2T77bx1P1M8Q7AbFN3PViaTDvxs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728935251; c=relaxed/simple;
	bh=omHVLXQtcSuvVJ5T3HfqlH8YvVDr+4wlfVsAxSF71xU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVYJn15qmLGyYCqBQdNdK1OnIPO1GiB1V+PZGImR3C/y6Jvd+BYdE2JARqLO53/zenq22RQmT9naz9I5RGBhdSakcuXXySVAUFnjdyQwx4vtJw30lhU6rParKtcLeCJ5TNWhq2sRqX4ZqB9Tw2q4BuKnOueuXy3iqNrbn4Lc2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kkEMV0OT; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49EJlNeP022638;
	Mon, 14 Oct 2024 14:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728935243;
	bh=CpUE9cATnqNSdN6EyIqHZJuNjvjoCizcHJskkWPG0KY=;
	h=From:To:CC:Subject:Date;
	b=kkEMV0OT9KrLrmKcjb3mCcxzzfwtfhpVvEouMgEW/He7YDXFBpStZLzHofQrDcDkE
	 1nWqyZBpl3ZbcQI+BjaDmTtk63Al6Sk6+tBvGTnk39TI+e0+Kx2+SObnhY0mB8YXKy
	 qgf26ltzNtAKrCizep/VnHP12J+ums7vFuwTARWE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49EJlNSV016772
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 14:47:23 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 14:47:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 14:47:22 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EJlM9X002469;
	Mon, 14 Oct 2024 14:47:22 -0500
From: Judith Mendez <jm@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Judith
 Mendez <jm@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Misc MMC updates
Date: Mon, 14 Oct 2024 14:47:19 -0500
Message-ID: <20241014194722.358444-1-jm@ti.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

In this patch series we remove/add MMC DT
properties:

- disable-wp
- non-removable
- ti,itap-del-sel-legacy
- ti,itap-del-sel-mmc-hs

for am62x, am62ax, am64x, and/or am65x family devices.

Patches 1/3 and 3/3 have only been built tested.
Patch 2/3 has been boot tested on am64x IDK board.

Judith Mendez (3):
  arm64: dts: ti: k3-am6*: Remove disable-wp for eMMC
  arm64: dts: ti: k3-am65-main: Add missing itapdly to sdhci0
  arm64: dts: ti: k3-am62*: Add non-removable flag for eMMC

 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 1 -
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 2 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 1 -
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 2 ++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 1 -
 7 files changed, 5 insertions(+), 6 deletions(-)


base-commit: 5b035d14a508efd065895607ae7a6f913b26fef8
-- 
2.47.0


