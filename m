Return-Path: <linux-kernel+bounces-190601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6B8D0054
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F26A1C2137A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157915E5D2;
	Mon, 27 May 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="up2iwDuf"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF115E5A9;
	Mon, 27 May 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813883; cv=none; b=S6lGetuN/W8os5nXRLltZ9fkE+vQv4vRAWVLZamOIYg+KA4kHLio/bPtns/GBkIPGZQggLyVyriz0hAo+u1oLowVekENKbxTr6Piq/bgkuGtFzOi/uwE+V5mINu51l8bG/2PpWJ09XABFq915YaxrxOf0NJvejOz5x//zumuOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813883; c=relaxed/simple;
	bh=XGq8EBx7YBbAZYv3a+yoVQGfuikgMWgloGnI4v0Cqqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZByYja89vKqLXr0sZCVuFnhjxl9dB5VvoMFkqQCDZ2fDYqi+be/5qvphmVRA/VgUESXNGkQa89CjhJalviUvMatykrwIFEBbeDWd0RighH2bgVhNOXADnIqNWTrXsV7rPakmw7ymKdTVwpOUWuI8m6ijk0m1yqnNxRD0lnAKkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=up2iwDuf; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44RCiRqs033804;
	Mon, 27 May 2024 07:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716813867;
	bh=znYaiwd1zQ81t8MWJthN/5rFgqs1K/Pm7b/YKSKLSfU=;
	h=From:To:CC:Subject:Date;
	b=up2iwDuf5qTQXIxYH1ZERrFL/clWn45vi+DXRy+cdiD1J1iZVb40YfFfdflVGrUIm
	 p7ORKFodFQERvLHeqpYdQ+9NyAse4aRpdxIrQZ/1unAsVbDdI2y1pJYVVOQ9es9ZA8
	 btY51EylO6fgdtw0CbvM4BMvVj/GKoZR0LSHPhII=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44RCiRsO015508
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 07:44:27 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 07:44:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 07:44:27 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44RCiMbT035499;
	Mon, 27 May 2024 07:44:23 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 0/3] arm64: ti: Add TPS6287 nodes
Date: Mon, 27 May 2024 18:14:19 +0530
Message-ID: <20240527124422.3553828-1-n-francis@ti.com>
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

Add nodes for TPS6287x present in AM68 SK, AM69 SK and J784S4 EVM. They
are a family of synchronous step-down DC/DC converters. These converters
are used to enable AVS (Adaptive Voltage Scaling) for these devices.

Also since AM68 SK lacks DT node of it's PMIC, LP8733; make use of this
series to add that in as well.

Data sheet: https://www.ti.com/lit/ds/slvsgc5a/slvsgc5a.pdf
Boot logs (v2): https://gist.github.com/nehamalcom/1a288f534d730e8af43c48a175919b19 

Changes since v1:
- remove changing the compatibility of the existing driver (Rob and
  Mark)
- remove unnecessary bootph-pre-ram, have them only for VDD_CPU_AVS
  (Udit)

Neha Malcom Francis (3):
  arm64: boot: dts: ti: k3-am68-sk-base-board: Add LP8733 and TPS6287
    nodes
  arm64: boot: dts: ti: k3-am69-sk: Add TPS62873 node
  arm64: boot: dts: ti: k3-j784s4-evm: Add TPS62873 node

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 77 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 21 +++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 21 +++++
 3 files changed, 119 insertions(+)

-- 
2.34.1


