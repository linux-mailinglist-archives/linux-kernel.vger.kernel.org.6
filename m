Return-Path: <linux-kernel+bounces-540592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D07BA4B29E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D970166C3A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1E1E51EB;
	Sun,  2 Mar 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a+FU4jEC"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40971172A;
	Sun,  2 Mar 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740929714; cv=none; b=FErC8vEqarycbhfALT5nRXoKD4h97mQHr6s7htNUIyo15pIvu3qTYFdE6EkAIa4xjXRzmAPYll6EuCLXx6x9uz1+DJ2afRptTv/mvgBKWWSUAx/2i93a5uJZ6dozNCbUYpdHEj3SuzkQdZpPEqyZMp04TKF0zCCPekEDrCfbQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740929714; c=relaxed/simple;
	bh=sp+aBzUeoeWE0ZtxyqtC/x3EA65BT0kY57znG+bVzag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FuZtnGjv9/AR5MHrswPs0fRzAG5XRav2ALZAUajqCzTBl9T1fT/dDuNHSQLtkFBCydMaoq+onmQPdXeunNF2NgArrHJ75i8wYHJPy1pPJDNepDCVqiD4SOc2GcWuDqiGvMJbkhtPzld5aOqPz6BxQl4lSlCirA/J0q0n0uQMfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a+FU4jEC; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 522FZ4G42556074
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 09:35:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740929704;
	bh=wdAoh/ayfnLnb4rljIhkNtkXJPCCVbcFapnePSxCyVQ=;
	h=From:To:CC:Subject:Date;
	b=a+FU4jEC28l5XEJbJ2NMrmbp4o6HUFInvm45S6lnBi8pRrTMDYQWQjR/vHEnkiu2E
	 fsK7pRv+s/LprOOOt+pyYvrSVSakdxr9R2c8SD1go/yE5jWB0scRsuoZK+kmdxhC/T
	 o0Hww0Qe3u3xGAnr3fmiQfKP9mYPlH4FCGrq44L8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 522FZ4VP085114
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 09:35:04 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 09:35:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 09:35:04 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 522FZ3a0120099;
	Sun, 2 Mar 2025 09:35:03 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>
CC: <s-vadapalli@ti.com>, <c-vankar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/2] Add bootph-all property to necessary nodes to enable ethernet boot for AM68-SK, J722s and AM62p-SK
Date: Sun, 2 Mar 2025 21:05:00 +0530
Message-ID: <20250302153502.181832-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series adds bootph-all property to necessary nodes to enable
ethernet boot support for AM68-SK, J722s and AM62p-SK.

This series is based on linux-next tagged next-20250228.

Link to v1:
https://lore.kernel.org/r/20250106123122.3531845-1-c-vankar@ti.com/

Changes from v1 to v2:
- Updated order of "bootph-all" in [PATCH 1/1].

Chintan Vankar (2):
  arm64: dts: ti: k3-am68-sk/k3-j721s2-mcu: Add bootph-all property to
    enable Ethernet boot
  arm64: dts: ti: k3-am62p5*/k3-j722s: Add bootph-all property to enable
    Ethernet boot

 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                | 2 ++
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts       | 3 +++
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi       | 4 ++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                | 3 +++
 5 files changed, 15 insertions(+)

-- 
2.34.1


