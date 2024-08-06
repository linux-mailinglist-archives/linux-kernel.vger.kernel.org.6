Return-Path: <linux-kernel+bounces-276964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B32949A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150FF1F22ECC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B364173320;
	Tue,  6 Aug 2024 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lMdhxqqk"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303AC16CD11;
	Tue,  6 Aug 2024 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980774; cv=none; b=tDn2o3fUY7jZZru5NvT1cP7gpuBBCQSnpA4Sy8NmSXPSBqcjrc/Sl2oWXo0yNJ+hAKVps7pn2eluAuwJCUQHsFE7hhHb/dzKWC8/+CpU4YXmXBNeyFBJRTZeVeEhZb8NYknvhBA4t0t/SdqcrRVW06dqaQYW9jC/f0zPzhC1Sa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980774; c=relaxed/simple;
	bh=xT2XBrMNRq0AjIGxscX8/LYsM3LUVZk62Gp59uz84/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kVfHvc4xD5Hc5c2ekMT02Sxmn6n3cEOvHhKNKpTEZgNcdUvai4CBgL7BP/lUVjWDcMkQYm6w0pD9J6f5pOLyPJj6Ck+KSiBNpqBvac74rDyeog3kXliENKCrAdXo4bqHIJIDfvpo6L6EvNUE4GGwkxhO4jgok9koKR3orUDTqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lMdhxqqk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5Jv067922;
	Tue, 6 Aug 2024 16:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722980765;
	bh=4Y8pqg1sDjSvIPWAUhnNxXSZe5SXwQueSXt7SVVWkeI=;
	h=From:To:CC:Subject:Date;
	b=lMdhxqqkmv1zU+ym4OKWo91vRno+G4vxcChkErdDl1HqEaN3uTdnibn55c9bEZ/qK
	 rzveCf3DBUhX5JWRkvGRc8Co/8VHeNcqhfR4apzS6HYvZMOeFP3tzUbCcjjK4R+TGc
	 hdQIyPYvX6ZXwMfZ9Ive70sohZR6h4mZ7NDzQqZA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476Lk578024467
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 16:46:05 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 16:46:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 16:46:05 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5Qp100327;
	Tue, 6 Aug 2024 16:46:05 -0500
From: Judith Mendez <jm@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Santhosh Kumar <s-k6@ti.com>,
        Bryan Brattlof
	<bb@ti.com>
Subject: [PATCH 0/5] Fix ESM source interrupts
Date: Tue, 6 Aug 2024 16:45:59 -0500
Message-ID: <20240806214605.3379881-1-jm@ti.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The following patch series fixes ESM source interrupts
for Sitara K3 platforms, currently watchdog cannot reset
the CPU because of misconfiguration or missing ESM node
in DT.

ESM node was added for am62ax and am62px ESM source interrupts
are fixed. Comments were also added for clarity on what
source interrupts are routed to ESM based on device datasheets.

Judith Mendez (4):
  arm64: dts: ti: k3-am62a: Add ESM support
  arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
  arm64: dts: ti: k3-am6*: Add comment for ESM interrupt sources
  arm64: dts: ti: k3-am6*: Fix comment in watchdog nodes

Santhosh Kumar K (1):
  arm64: dts: ti: k3-am62p: Remove 'reserved' status

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi               | 1 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi              | 7 +++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi               | 8 +++++++-
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ++-
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi  | 3 +--
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 1 +
 6 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.45.2


