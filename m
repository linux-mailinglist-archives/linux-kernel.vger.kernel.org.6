Return-Path: <linux-kernel+bounces-301298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC895EEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C11C21C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C47A14D2A7;
	Mon, 26 Aug 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PHvp1FK5"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129F39ACC;
	Mon, 26 Aug 2024 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669324; cv=none; b=Y3+rD1GCXeWHlcyOnnRor1rSACTdQ7ZPaIsRtmXyWo1dLA/6CtYSCbfl8QftnF+UDcWp7HP7f4bjjwx8Ux/JKex//4hWxqo5YpO6Tv3OcLxl1xhesbbmZwqep6jCYlG1UImwQyG11WaB+nGFafOOJ4Su9UOaFC1teREJaf7hPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669324; c=relaxed/simple;
	bh=H5qdFsHLBF26NXOTNKT8cc1YmjeXWIdmAW1q9jJoiFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iyQUuVMYsQ39wi7sFKez71jZ5ozIStCUeCB+n5FTS3RcYLas+Gl0Sz2XVzyC9vuWdlloLgDITrH9lvIx+1x+43sjFsgpUGdUYQySslghUz1KJ9GB74QBKRuSoy27UGz7G424++gzRoMEdaLVmL5dl0nO7vIuhOcIaIqc7G3csJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PHvp1FK5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAmQKF008291;
	Mon, 26 Aug 2024 05:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724669306;
	bh=Sdt9ErsTLxOJWQjj+at8gn6Uw33/oDVhLQO7dagY6aY=;
	h=From:To:CC:Subject:Date;
	b=PHvp1FK5EG3EpiNJ55xTrnwZceDMq+nwJuBwzKttC2nQzHeTXGSw1tqsbsemnndFC
	 8P8sFIK1kiZcjfuR9A0/dsvnX5FawLXe9rIwv/OWLTpZKRR9E6gtPgtOJSeVdcXxLR
	 fMPCjgBfhzGiug2NdRLJYyIewhZ7BSPhl4k2XZVI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAmQXO037593
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 05:48:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:48:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:48:26 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAmLNj063606;
	Mon, 26 Aug 2024 05:48:22 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/7] Reserve Timer Nodes to avoid clash with Remoteproc firmware
Date: Mon, 26 Aug 2024 16:18:13 +0530
Message-ID: <20240826104821.1516344-1-b-padhi@ti.com>
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

NOTE: This series has been rebased on top of a sibling series[0] as both of them
introduce changes in the same files. Thus, please apply [0] before applying this
series.

[0]: https://lore.kernel.org/all/20240826093024.1183540-1-b-padhi@ti.com/

v4: Changelog:
1) Refactored changes from {}-common-proc-board.dts to {}-som.dtsi to put all
remoteproc related changes at one place as remotecores were getting enabled at
{}-som.dtsi file.
2) Rebased this series on top of [0].

* Nishanth:
1) Fixed $subject line for all patches to include the board level files where
the changes were applied instead of the SoC level files.
2) Applied these timer fixes to J721E-SK, AM68-SK and AM69-SK boards as well.

Link to v3:
https://lore.kernel.org/all/20240816073908.2343650-1-b-padhi@ti.com/

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

Beleswar Padhi (7):
  arm64: dts: ti: k3-j7200-som-p0: Change timer nodes status to reserved
  arm64: dts: ti: k3-j721e-som-p0: Change timer nodes status to reserved
  arm64: dts: ti: k3-j721e-sk: Change timer nodes status to reserved
  arm64: dts: ti: k3-j721s2-som-p0: Change timer nodes status to
    reserved
  arm64: dts: ti: k3-am68-sk-som: Change timer nodes status to reserved
  arm64: dts: ti: k3-j784s4-evm: Change timer nodes status to reserved
  arm64: dts: ti: k3-am69-sk: Change timer nodes status to reserved

 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi   | 25 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts        | 41 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi  | 13 +++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts       | 29 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi  | 29 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 25 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts     | 41 ++++++++++++++++++++
 7 files changed, 203 insertions(+)

-- 
2.34.1


