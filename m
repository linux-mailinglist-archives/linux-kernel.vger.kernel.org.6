Return-Path: <linux-kernel+bounces-368893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815DB9A1630
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8821F22DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FC61D5CF4;
	Wed, 16 Oct 2024 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cuNhSdBU"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A81D54CF;
	Wed, 16 Oct 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729121465; cv=none; b=Nii9j32i1qMRO8bImlJJm5i26O7DdGKDWv2u0XKxvFizE+GqnBQy5skJTihSya9ljcxGhvmWacVL+yl/fnsc3YEyzkliErks012NiZoitX80s7kZSuPDeoXs+YIriP6BfiAnY9Ju88TS8MsrtvO3UxmZ2bK1xT76kfoYu4ffbys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729121465; c=relaxed/simple;
	bh=OXxOgAGc/GHNdIO7K9NLOh0qGq7v0GSqWfojcHr+N4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ib5rcu1JKb5IMhQG7vCZahvNcw6JCeWxDkhdXwbnm4UjDCgrZABOzyeZzSsHcYDJp2YPEVy6EYWs39qfAx6uvoRGewxyXvUs9x6Rl7edc8mjGFo90LDUtlWB1nkzxhU2RzCXXNmrZMb5lJwCAoNL4UykiFufaFZqWzDsbgUxlZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cuNhSdBU; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUk5A053745;
	Wed, 16 Oct 2024 18:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729121446;
	bh=NTFzU59PBYtGMvWw4oj+dZrXWgp3ksm4qtF5B8NQwOo=;
	h=From:To:CC:Subject:Date;
	b=cuNhSdBUHkFxWysqKv3x3StWLrhRePWD+PB9BZX03U8DvyOvGO6gC2MyGIQ8vOjUM
	 tVxYWADY7xJkrkwYZi9sFoNfsXKc/vV7SgKrDMCN3NBHGDkWqpoEJUOx9wI3R0I7a2
	 C5wJPHCAOinNq1hI53r/O2MfoYTf6M6j3hgBzDxA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49GNUk9K014824
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Oct 2024 18:30:46 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Oct 2024 18:30:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Oct 2024 18:30:45 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUj7h070988;
	Wed, 16 Oct 2024 18:30:45 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 0/5] Use ti,j784s4-pcie-ctrl for PCIe CTRL spaces
Date: Wed, 16 Oct 2024 18:30:39 -0500
Message-ID: <20241016233044.240699-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello all,

Now that we have ti,j784s4-pcie-ctrl[0] let's use it. This makes these
K3 SoCs all match what is already done for J784s4.

No functional change, DT changes are fully backwards and forwards
compatible.

Thanks,
Andrew

[0] commit cc1965b02d6c ("dt-bindings: mfd: syscon: Add ti,j784s4-pcie-ctrl compatible")

Andrew Davis (5):
  dt-bindings: soc: ti: ti,j721e-system-controller: Add PCIe ctrl
    property
  arm64: dts: ti: k3-j721e: Add PCIe ctrl node to scm_conf region
  arm64: dts: ti: k3-j7200: Add PCIe ctrl node to scm_conf region
  arm64: dts: ti: k3-j721s2: Add PCIe ctrl node to scm_conf region
  arm64: dts: ti: k3-am64: Add PCIe ctrl node to main_conf region

 .../soc/ti/ti,j721e-system-controller.yaml    |  5 ++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  7 ++++-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  7 ++++-
 .../boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso    |  2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 28 ++++++++++++++++---
 .../boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso   |  2 +-
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  7 ++++-
 7 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.39.2


