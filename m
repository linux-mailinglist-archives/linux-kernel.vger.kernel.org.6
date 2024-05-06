Return-Path: <linux-kernel+bounces-169312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7E78BC6B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06264281834
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C5D47F69;
	Mon,  6 May 2024 05:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YKVxeu/T"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DA44642B;
	Mon,  6 May 2024 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714972863; cv=none; b=Go850hS5v38M3HoBcV9pgOUaNe3W8mrtArexklVSiEjrB3gaxO4Ilnso30KC88+2Ut3LtNbvyMYbABSLbcnY5qfG7Yt0pO6w3d5KFIV3NpP1fwsU8JTT+ri4qcD/tXt4Ao2bgYZx/w3Hdw0DiciQZNIzdaTPfaVTjreh3rDTeZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714972863; c=relaxed/simple;
	bh=hn1ClySGSuHw+ugjTHAaJkB5rGFfnFPxjXfC33Z/5ZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G6PcjlcWEk1iXjozcCBECgrtzF1rCm8fKmlj1FwBCLnErVof+7N353UK1DiewekbwYpXSnbps9pFhdJu47oSgR+GZ7ukElIKDew9lDkGic+41O4qFDKYRWMu4AlcIvSB5jsBXQHJ9wkHlUznNkvgWabkSuuoSwOMIWynDNeClFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YKVxeu/T; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4465Kn7Q124255;
	Mon, 6 May 2024 00:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714972849;
	bh=+npqNy0VbSMQXBHJ9TKRa0hUjJedPcbo7uWsi+wVW9k=;
	h=From:To:CC:Subject:Date;
	b=YKVxeu/T4+YOTPkx+PUKV2qoN1TbFEELingAeR9Nz7c0VgUCH1fv1AXaE6MwFBvjh
	 AgS1asyawoaWryMLEqu45Lvct5RC4ZYBscdHSfz0PdPB2AySV/0FEH09jSUH8mTjXM
	 kwfzq0vlJiWdPf5rD1Z/UA1msl1VfeH8+enhMc5o=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4465Kn1h009623
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 May 2024 00:20:49 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 May 2024 00:20:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 May 2024 00:20:49 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4465Kj0f069015;
	Mon, 6 May 2024 00:20:45 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add USB 3.0 support for J784S4
Date: Mon, 6 May 2024 10:50:42 +0530
Message-ID: <20240506052044.8228-1-r-gunasekaran@ti.com>
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

Changes since v1:
-----------------
* Fixed dtbs_check warning in [2/2]
* Rebased to tip of -next

v1: https://lore.kernel.org/all/20240502053615.29514-1-r-gunasekaran@ti.com/

Matt Ranostay (2):
  arm64: dts: ti: k3-j784s4-main: Add support for USB
  arm64: dts: ti: k3-j784s4-evm: Enable USB3 support

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 41 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 39 ++++++++++++++++++++
 2 files changed, 80 insertions(+)


base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
-- 
2.17.1


