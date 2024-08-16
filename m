Return-Path: <linux-kernel+bounces-289195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5A5954301
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAEC0B288B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41027839F4;
	Fri, 16 Aug 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j6Q6tBmd"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE967E0FF;
	Fri, 16 Aug 2024 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793964; cv=none; b=Vc/7j2jOkRWuRNdMlkK6lCjKsNXcex72PCIpbA9EFvTqhLwOUpArwA4YXAGhbo7A51zU8Nhg/KaDSeZGJZQ0hI8L4W7vKTzZuuaZsYXmhJktnADZUH+8wkubyz/JcOEH2nuErP6/wPMm1xo7dDYT0uKSOLeOaTtimxbwYAT/sWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793964; c=relaxed/simple;
	bh=midZkf+k+u4VFg3rrvLhjx+1Kj5EB07q+nYQOkQ8ZnE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f87hAQA3EED7t/kWOkBpZgRmiof1j/sV+7i9sDa/D+uN77z64kNOQPTB4Tu50yAOXYKKu0adf0Reo0KzlwXC8gXThebkIKUD49ENKd187T/FoX3Gf/6PYKRoNEjuqwXbYfVMRWuWb82torFVqqCyzAHnNm52A/iZWwvnrNQmdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j6Q6tBmd; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47G7dDOA008215;
	Fri, 16 Aug 2024 02:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723793953;
	bh=EUwlxk+zGE+cPAdVV2qhwWnWJ4D0pn8CF21E9m687b0=;
	h=From:To:CC:Subject:Date;
	b=j6Q6tBmdUpg31o6m8clIqhILK6csZNWpWr4yHIWuM5UT7yk06k+oFhBRbAiewNaBH
	 aO5HrHAFCGBP/IfakRAiqVhgDsHRLszDuFlllXDTSL+vcOKQ42KnhfSd7naloAtJBj
	 Hrb0Vq1x7NBwWv1bX/nafni99kwNpwVu8Ng3l57o=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47G7dDdM094366
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Aug 2024 02:39:13 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Aug 2024 02:39:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Aug 2024 02:39:13 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47G7d9Tp084976;
	Fri, 16 Aug 2024 02:39:09 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] Reserve Timer Nodes to avoid clash with Remoteproc firmware
Date: Fri, 16 Aug 2024 13:09:03 +0530
Message-ID: <20240816073908.2343650-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
use timers. At the same time, if Linux probes the timers, some
instability is observed while booting remote cores. Therefore, change
the status of the timer nodes to "reserved" to avoid any clash. 

v3: Changelog:
* Udit
1) j7200: Updated commit message description to remove DSPs as the SoC does not
have one.
2) j722s: Updated the correct commit for "Fixes:" tag which introduced the bug.
3) For entire series, removed comment about timer usage by R5fs in the MCU
voltage domain as those are used by Device Manager firmware to get SoC
functional.

Link to v2:
https://lore.kernel.org/all/20240814104151.2038457-1-b-padhi@ti.com/

v2: Changelog:
- Split the changes into individual patches for each SoC to tag the
  correct offending commit for "Fixes:" tag.

* Udit
1) Add the correct clashing timer nodes for J7200 SoC.
2) Port these changes to board level dts files instead of SoC level dtsi files.

Link to v1:
https://lore.kernel.org/all/20240607105559.771080-1-b-padhi@ti.com/

Beleswar Padhi (5):
  arm64: dts: ti: k3-j7200: Change timer nodes status to reserved
  arm64: dts: ti: k3-j721e: Change timer nodes status to reserved
  arm64: dts: ti: k3-j721s2: Change timer nodes status to reserved
  arm64: dts: ti: k3-j784s4: Change timer nodes status to reserved
  arm64: dts: ti: k3-j722s: Change timer nodes status to reserved

 .../dts/ti/k3-j7200-common-proc-board.dts     | 13 ++++++
 .../dts/ti/k3-j721e-common-proc-board.dts     | 29 +++++++++++++
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 25 +++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       | 13 ++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 41 +++++++++++++++++++
 5 files changed, 121 insertions(+)

-- 
2.34.1


