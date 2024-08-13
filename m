Return-Path: <linux-kernel+bounces-285600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE195102F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C41D1F2532D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB431AC448;
	Tue, 13 Aug 2024 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tvQyV5W9"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D8183CAD;
	Tue, 13 Aug 2024 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590208; cv=none; b=iM9W9KiGgH9JeUsGcOAsTTV/zdjKul/Ih8uwL2QP+1DyJghU9K3CSHumVgGRfoATRGL5BntPr3/IHTde0SxVxyi4MDsYMqiDpYk8j6G7boYakkJHtkidD4Tq/MRXTVlqsdUgGdBr21kJCnqn2+QcCU8VAouzzVrNyCB6hEKNCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590208; c=relaxed/simple;
	bh=qsoNR2Jg4jUsrj80/bt5EU5Y+L/p5JP/RXuphrpRa9Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wx5FeBkJl9hV3F1XS8fkACmwWvJsmI+oMpH5p9A1Xp3pWY8RZBlphCO2b9+Vuo0ANj6kNJ3IqJ7s3A5QizNq0WXKsepI9fgop9p8Kxoh/1dCp35xGoZaoqfR48M/+g8PBikcuU0am2jhjXiOpVGk3C1BaSBBuG4bAtgYPKdfJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tvQyV5W9; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3K0O099206;
	Tue, 13 Aug 2024 18:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723590200;
	bh=hUDUxTYzjMt08Xqxt6Rk3RxZcN35S69r0y7JvUi71ms=;
	h=From:To:CC:Subject:Date;
	b=tvQyV5W9nq1NXYr8Y0onHezz6AZnuG9mcotsieQ3GQ5Z9upcTaLun8qKs8yxupUcb
	 Wj/Y5YNL0zM92hz2IKUxtYccufqR+gKO73o7I/EVOsk+l+CjRm1O/zLqx1dreushab
	 pSs22GERoYi8iah9FPMEbFlzEvlTHewTNwI3hnoo=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DN3Kux025563
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 18:03:20 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 18:03:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 18:03:20 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3Khl026425;
	Tue, 13 Aug 2024 18:03:20 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        Judith
 Mendez <jm@ti.com>
Subject: [PATCH v2 0/6] Add and fix ESM nodes
Date: Tue, 13 Aug 2024 18:03:06 -0500
Message-ID: <20240813230312.3289428-1-jm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The following patch adds ESM nodes and fixes ESM source
interrupts for Sitara K3 platforms. Currently watchdog cannot
reset the CPU because of misconfiguration or missing ESM node
in DT.

ESM node was added for am62ax and am65x. For am62px ESM source
interrupts are fixed. Comments were also added for clarity on what
source interrupts are routed to ESM based on device TRM.

ESM nodes like MCU ESM for am65x are added for device completion,
currently, some ESM0 events are not routed to MCU ESM, so watchdog
cannot reset the CPU using the current implementation.

Changes since v1:
- Remove watchdog patch
- Add am64x patch 5/6
- Add am65x patch 6/6
- Add missing bootph flag

Judith Mendez (5):
  arm64: dts: ti: k3-am62a: Add ESM nodes
  arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
  arm64: dts: ti: k3-am62: Add comments to ESM nodes
  arm64: dts: ti: k3-am64: Add more ESM interrupt sources
  arm64: dts: ti: k3-am65: Add ESM nodes

Santhosh Kumar K (1):
  arm64: dts: ti: k3-am62p: Remove 'reserved' status for ESM

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi               | 1 +
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi                | 1 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi              | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi               | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ++-
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 3 ++-
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi                | 3 ++-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi               | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                | 8 ++++++++
 10 files changed, 42 insertions(+), 5 deletions(-)


base-commit: e3cce1229c34b5c28f103361c4d6b3ef17302d5d
-- 
2.46.0


