Return-Path: <linux-kernel+bounces-301163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D495ED2C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25561C218D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F3114430E;
	Mon, 26 Aug 2024 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KVl7i6U1"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86977F08;
	Mon, 26 Aug 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664640; cv=none; b=tgKpa53/zXSBN+iz84dBDFD0LBsfzNiNt71+2/QsXpx3s9rrP5lU3mQurGAL1J2AbwR8JIKBZOSJRHc5HSRKiff93yZLnEyO9kuOWKpC7+705slQgRx8b4I5+D6cHYg+cRiVo3jA2wjBtYnOxwqcduXm3wUqtiZqf9Sp0KgWD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664640; c=relaxed/simple;
	bh=IaQvQK322F41Wu3XuQqzpU/an5HrTCCYpOEpInG8XP8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QV43Z9uhFPHhIT7gP2Ii49IE+Ruvx7Zeb4ztZhg72J1/gu/FRvGFbgdktcaOP+TwjjEvX72WhkDiTmZEu/6KFi+r/o4g7D0luqEUpWaQDKgbaULbkekt33a/K4iNqOTvlYpM3kFZQmgjQLNc38bUBGecmhLy39HapB0uCX3WvhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KVl7i6U1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47Q9UTCR113589;
	Mon, 26 Aug 2024 04:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724664629;
	bh=M5c+I3fwFUbb6TlPohBPIc7+gZ7Wuml8QQ0nxOyyRsI=;
	h=From:To:CC:Subject:Date;
	b=KVl7i6U1jF7Hv9JSTee5ir+NsRUAJ02T0gGgJvh7KFz6qZHuJOLk59ajHJmKundAs
	 S8Bp2XT6/3SMtCgofHLrNPm9/JF9gYAE9bySgj1kGTttfz1+RZWzO4ZEtEz8Z6btMV
	 P5hpgrrW/ofRWB4wenDLM1JnvVn8JjUuH3JWC/9Q=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47Q9UTFr015239
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 04:30:29 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 04:30:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 04:30:28 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47Q9UPn9118247;
	Mon, 26 Aug 2024 04:30:25 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <s-anna@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] Switch MAIN R5F clusters to Split-mode for TI K3 Platforms
Date: Mon, 26 Aug 2024 15:00:17 +0530
Message-ID: <20240826093024.1183540-1-b-padhi@ti.com>
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

TI's K3 Platforms (J7200-EVM, J721E-EVM, J721E-SK, J721S2-EVM, AM68-SK,
J784S4-EVM, AM69-SK) have multiple R5F clusters in the MAIN domain. All
of these clusters are configured for LockStep mode at the moment. Switch
all of these R5F clusters to Split mode by default to maximize the
number of R5F cores.

v3: Changelog:
* Nishanth
1) Refactored changes to board level DTS files instead of SoC level dtsi files.

Link to v2:
https://lore.kernel.org/all/20240821095200.3050878-1-b-padhi@ti.com/

v2: Changelog:
1) Update commit messages to drop "Lockstep-mode" as default mode for early
booted remoteprocs.

Link to v1:
https://lore.kernel.org/all/20240503062414.804209-1-b-padhi@ti.com/

Beleswar Padhi (7):
  arm64: dts: ti: k3-j7200-som-p0: Switch MAIN R5F cluster to Split-mode
  arm64: dts: ti: k3-j721e-som-p0: Switch MAIN R5F clusters to
    Split-mode
  arm64: dts: ti: k3-j721e-sk: Switch MAIN R5F clusters to Split-mode
  arm64: dts: ti: k3-j721s2-som-p0: Switch MAIN R5F clusters to
    Split-mode
  arm64: dts: ti: k3-am68-sk-som: Switch MAIN R5F clusters to Split-mode
  arm64: dts: ti: k3-j784s4-evm: Switch MAIN R5F clusters to Split-mode
  arm64: dts: ti: k3-am69-sk: Switch MAIN R5F clusters to Split-mode

 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi   |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts        | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi  |  4 ++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts       |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi  |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts     | 12 ++++++++++++
 7 files changed, 60 insertions(+)

-- 
2.34.1


