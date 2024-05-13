Return-Path: <linux-kernel+bounces-177515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DED58C4007
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88C31F22A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A0214F135;
	Mon, 13 May 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ClF9jH9G"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9CD14F120;
	Mon, 13 May 2024 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600705; cv=none; b=EbSGOh6XtB2p4JJY8Vys/Bd/E6Y8ss+GSzkaclP63H18erLRMA5N7b8MKKFfQXAd92l7tuiA3uIRI+enkkPdEr2VDXVUTcihUXKRiFBRFXILjpkTp8t4KhfRUDuTQ+H+7w1TOdVh9xNWpM2KSprSAFEIMvlf2riJQb2dZWX4vAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600705; c=relaxed/simple;
	bh=UO2xgugCk5c0BHc8qM/tNx8MMcrSOKLdvQugUus2P/M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ddp37UBCT4CoKN7rpmxgTCXTyuzFqQWnN70OZkjmb4STgnT2ebfsnr0FzX4eDCGSj9/9f57Few+SfUNwzAffgNYdBy40E9VtsaQY1mqS75sL8a4tI/Ke68Gn8rUxVZQX/nKL5RpEFv3ZOX3rnIxfsgwJT+WdW1cq6AeLa9tbnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ClF9jH9G; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44DBim75095055;
	Mon, 13 May 2024 06:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715600688;
	bh=DKjcLNQAAq4yPHIkyE51/S+JTjN9aZ3JRxB9VKcD0RE=;
	h=From:To:CC:Subject:Date;
	b=ClF9jH9Gl2S+EEbLBaLzJWl4n/SYLsZDTmcIIDXILDrE0qYFnvt85ViMewxm+PRO4
	 Du4mC8H09e9ggdQ4/smHxoxnxVzrbjURgAPMEHkmJBQwN33fQk9O98UQ7Z047h3Yf/
	 +kodygNBwrxH6RuYXKDOHJK9UWa673CjnKYngNio=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44DBimda042571
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 May 2024 06:44:48 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 May 2024 06:44:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 May 2024 06:44:48 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44DBiiZg086026;
	Mon, 13 May 2024 06:44:44 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <robh@kernel.org>,
        <rogerq@kernel.org>
CC: <kristo@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] arm64: dts: ti: Add USB support for J722S EVM
Date: Mon, 13 May 2024 17:14:40 +0530
Message-ID: <20240513114443.16350-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J722S has two USB instances. This series enables USB support for
both instances.

Change log:
----------
Changes since v1:
----------------
* Introduced k3-j722s-main.dtsi newly to add the main domain
  peripherals that are present additionally in J722S as suggested by
  Andrew Davis

* Used generic node names as suggested by Roger Quadros

* Removed the aliases for usb as suggested by Rob Herring

v1: https://lore.kernel.org/all/20240429120932.11456-1-r-gunasekaran@ti.com/

Ravi Gunasekaran (3):
  arm64: dts: ti: k3-j722s-main: Add support for SERDES0
  arm64: dts: ti: k3-j722s-main: Redefine USB1 node description
  arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   |  55 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 103 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi      |   5 ++
 arch/arm64/boot/dts/ti/k3-serdes.h        |   7 ++
 4 files changed, 170 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi

-- 
2.17.1


