Return-Path: <linux-kernel+bounces-228735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B51916640
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3F81F2457B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD81514D8;
	Tue, 25 Jun 2024 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iGhXFpWb"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153814D2A0;
	Tue, 25 Jun 2024 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315194; cv=none; b=Rj/JqtKm1dhC57dV/XTMhPEPJD3AaoWS/vS5BnkU+B94jp/wFVX2kK/2PXpWUcesX5Lm2zPBuxK09wIEAf4N+x9z1YUEh6qHrjDRiLnMxaQeypne8vVNu4Wv7wt/JCRVTaIQDquh2zxIu4mgI8UqMGR4uVDkBxEc682WbQwdSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315194; c=relaxed/simple;
	bh=UZ9YirwpbxbCob/4vioymSk6EBuEAoGiUA6aEuKj0CE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iUovb0avgAs02C54zHejGUweD+czYTY52OxYEQ6ioip8ruzrymauTUyULXNbAb8Y9era0t49UluoaDKa8Yw71HEvCB3cDeEvDZUz02pf/O+/fbRolxZ0Y/PxqWsJQcwVqv8egcwPsFUq5TOjnsC45s+NtzEtaBW75Eqa1d/TYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iGhXFpWb; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PBX3Ld012294;
	Tue, 25 Jun 2024 06:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719315183;
	bh=GTrRv7hZKh8wsQ3kQX3qig4U5gcaCbbB88Jxc8ALilU=;
	h=From:To:CC:Subject:Date;
	b=iGhXFpWbog8l2K6JP2ItQYkIk2Zrc1+klIDZQawBg1o3EKh41lCGrBPfU/C7rx0hX
	 W7bpjnkf151GgDrZ10yD4EJiTK+ruqsbkRwjXuBeYkG8/J9n7CTwPbaMjEtmJHbz+C
	 XRgLTDz2qg0z3q/rwXIWq1EGhRNYuZ+n+j3dCPlE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PBX3Ge044057
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 06:33:03 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 06:33:03 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 06:33:03 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.248])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PBX2pK048633;
	Tue, 25 Jun 2024 06:33:02 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <j-luthra@ti.com>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v3 0/2] Enable audio support for J722S-EVM
Date: Tue, 25 Jun 2024 17:02:59 +0530
Message-ID: <20240625113301.217369-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello All,
These 2 patches enable audio on J722S-EVM platform.

This patch depends upon the bcdma driver fix posted upstream:
<https://lore.kernel.org/all/20240607-bcdma_chan_cnt-v2-1-bf1a55529d91@ti.com/>

Changelog v2->v3:
- Move audio_refclk1 node to SOC level dtsi (k3-j722s-main.dtsi)
  in a separate patch
- Rename vcc_3v3_aud to vsys_io_3v3
- Fix ball number for McASP pins in comments
- Fix padding for audio_ext_refclk1_pins_default pinmux
- Pick up R-by from Jai

v2 patch:
<https://lore.kernel.org/all/20240612051246.41117-1-j-choudhary@ti.com/>

Changelog v1->v2:
- Fix dtb warning for pin-muxing

v1 patch:
<https://lore.kernel.org/all/20240611082820.17442-1-j-choudhary@ti.com/>

Jayesh Choudhary (2):
  arm64: dts: ti: k3-j722s-main: Add audio_refclk node
  arm64: dts: ti: k3-j722s-evm: Enable analog audio support

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 109 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi |   9 ++
 2 files changed, 118 insertions(+)

-- 
2.25.1


