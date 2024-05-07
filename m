Return-Path: <linux-kernel+bounces-171042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B458BDF11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F4F1C20EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A1114E2E9;
	Tue,  7 May 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="giqUDCDQ"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360E4F894;
	Tue,  7 May 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075758; cv=none; b=YVl1T9dOQZquAVsi9HkwYkgqj+aIzUC7zqH/zfHpK9vWC2OAWSPIAS4k7K1MRvwutWJXbyElOR999HXI0mFEtQLP35frf66te0gIq32hcJV0LtBcjPy9bwqvQWTq8enE012L3a2qK4gB5nyP0UeN+SpjET8ydiEJfoR2bwXtnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075758; c=relaxed/simple;
	bh=9jWL+RVVX1qVd3kU2nm+exdcflWB3XJ3hRh2aLyMlr8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l3unyLVxsdnzSCkkmInKcQD2wnV9PuVrXONTr/n77p83JJsdFt8nP8N9nwnGeb+zBsM2j3Ayf00Gh58g6br41ZMfXmNpKR9VMA4X+8CGTUdedgbBpIoofgb6OK6AsnKr0Hy4z/O40X6ARAgxQjxrRkY8PuJd9rgBaKOMYtXapBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=giqUDCDQ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4479tnTU100331;
	Tue, 7 May 2024 04:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715075749;
	bh=GUn0NZVvuTz2voPwCEaXEML7orKNXf7WSWlCKMQrMUM=;
	h=From:To:CC:Subject:Date;
	b=giqUDCDQmJbGpo3oF6S9CHnAYhln7YG2Fn0PZKdfzFSPnCE8rBID0P4Glo7op5YZE
	 pEly4b2kztpg1WUQfWwbrHMB8VoYtVlNZfCAE2GCJSnOTXe2nnlDbxxAwtNcMRLdzs
	 06E0mro8sfiN2xU92a6dIW/Ql9DOvH+7W+MnYgN0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4479tno9067788
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 04:55:49 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 04:55:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 04:55:49 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4479tjn7007273;
	Tue, 7 May 2024 04:55:46 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add USB 3.0 support for J784S4
Date: Tue, 7 May 2024 15:25:43 +0530
Message-ID: <20240507095545.8210-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J784S4 has one USB sub system.
This series adds and enables support for USB 3.0 for
J784S4 EVM.

Change log:

Changes since v2:
-----------------
* Used generic node names; Renamed "cdns-usb" to "usb"
* Rebased to tip of -next

Changes since v1:
-----------------
* Fixed dtbs_check warning in [2/2]
* Rebased to tip of -next

v2: https://lore.kernel.org/all/20240506052044.8228-1-r-gunasekaran@ti.com/
v1: https://lore.kernel.org/all/20240502053615.29514-1-r-gunasekaran@ti.com/

Matt Ranostay (2):
  arm64: dts: ti: k3-j784s4-main: Add support for USB
  arm64: dts: ti: k3-j784s4-evm: Enable USB3 support

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 41 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 39 ++++++++++++++++++++
 2 files changed, 80 insertions(+)


base-commit: 2b84edefcad14934796fad37b16512b6a2ca467e
-- 
2.17.1


