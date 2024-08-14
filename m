Return-Path: <linux-kernel+bounces-286288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FF3951927
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1720A1C210BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F11AE042;
	Wed, 14 Aug 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HDB0wtei"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917CC481A7;
	Wed, 14 Aug 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632137; cv=none; b=CKZyYVrm/rJ8AzdoJVncqmt6/Oh7Jeb+rS9nyxEpCXLgzfKpe7+urRp6kQD4ijLFsoI6VCT7SLXc8cqlSwSxartrDRkNiadEeBUtoKGAcdjgWF/OdrvgPRhyq2jePPzHUAwyY7p3bBsF7A+9aotSTMZ4AO6zXsSSvIzNOkKbMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632137; c=relaxed/simple;
	bh=gObtWvsDa3FYmPi616P7kh9bb0b79KvayEN+vUo0/9k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rPRp6ShT5uEUeaytRHVvYpTMJ/a/EV3quj0hdUjf2OI7pq3x1wleKrr0tzqoMEcJ2uZm7dzIZWwtAhq2eXgceusfSdb+FwnsVQmtz8OAkkcNv5DwCCQYUZJfmLj7oe+qaZ5M0Ftv9K8QHVMar05UHpmad9K/v8FJiiyUpEgoGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HDB0wtei; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EAfuSg084398;
	Wed, 14 Aug 2024 05:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723632116;
	bh=LnqOWvrw+6QHzG1sUxDz08ztLpISRnZA5onqpWG/+HM=;
	h=From:To:CC:Subject:Date;
	b=HDB0wteiw4EGc1iRiws5SoZuha85pcmCWTkq2kRssKQbBbPuJYQJToF0WrlIviSmV
	 ww+bxO3ZefDbILpkVsJ7vP5TpYYZdicR5lZwGVSWVCau73iqhT9Y9EZPyNwKwXL5JG
	 VXVl9N1axKFqnmIYVDgEYvOdxEereSU40TzaMu9g=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EAfurQ089836
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 05:41:56 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 05:41:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 05:41:56 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EAfpSf068615;
	Wed, 14 Aug 2024 05:41:52 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <g-vlaev@ti.com>, <afd@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] Reserve Timer Nodes to avoid clash with Remoteproc
Date: Wed, 14 Aug 2024 16:11:46 +0530
Message-ID: <20240814104151.2038457-1-b-padhi@ti.com>
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

This change is already incorporated for timer nodes in the MCU voltage
domain.

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


